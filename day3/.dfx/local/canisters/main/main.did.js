export const idlFactory = ({ IDL }) => {
  const Book = IDL.Record({ 'title' : IDL.Text, 'pages' : IDL.Nat });
  return IDL.Service({
    'add_book' : IDL.Func([Book], [], ['oneway']),
    'get_books' : IDL.Func([], [IDL.Vec(Book)], []),
  });
};
export const init = ({ IDL }) => { return []; };
