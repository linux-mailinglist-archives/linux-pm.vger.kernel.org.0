Return-Path: <linux-pm+bounces-34112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B811B47C63
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356A4178F05
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A20826E702;
	Sun,  7 Sep 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO4u0uOi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF826AC3;
	Sun,  7 Sep 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757261845; cv=none; b=VO6CxlyCGRNBxp0omzmCR+kQ9V9HsrXMVnPo2umxyDo7oS9zjHsdG3P75muHLtmQYdhYnXWx7GRYSkTlOlJqLzycBYIj1xwUUvjgkk9bTXTBPa7xKZ83TSvHW23qocB995ouovgPDgy1zZA9ou80Z/QTHtBR321aR9In9GkAPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757261845; c=relaxed/simple;
	bh=EYXdJ8YszWi189uIndH51i2VPkYPhJ8vNBZbqTwqg5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAcwqH6gWEipXtZX8aB1niYu+s9IlMXIrMS4J2+jO7p/SXoaXTFZvWzi9gSLKn5DBlqWImmBedgmoYV4ZyfWASVXVDXdxt1pc2itYjL0gSjgXrbV0qQNUGrQMJ3E/YGWgPeod9GywO/A7rh0t9shvC7s1Q4EHeTirCPFyU5NC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO4u0uOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D113C4CEF0;
	Sun,  7 Sep 2025 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757261844;
	bh=EYXdJ8YszWi189uIndH51i2VPkYPhJ8vNBZbqTwqg5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eO4u0uOiuXM29q01oK0eUal+08NB0b+oi9PTdEDDABSEHaM22INPDyp3RZZGYoGVd
	 skDm/h/S6aSR0/0Bl3JOllgRW/FxQ5DdBlvZ1AQ1vfVTIzrHy27z/TGCXCcO6ImdoB
	 npOSvJ4fEUisYrGED8FM1Z00Rkel4MPI3Ncn8Z/vSkMPwzC79uL66aYGMzqOaBUgOr
	 2wlrLyB6Jhjomrv+3ONJ3l/n5S9kyNNmo7p7vULsR/Apz0DqJljuI+U35Z8N7csBRw
	 q+UeIEFYSv6EddMyCNhqKdvv/iNE+alZSrXSK2lf75Od5lqZ3hBtcxGlWoYUB90UBW
	 5lH/lRBfV0wOA==
Date: Sun, 7 Sep 2025 18:17:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
Message-ID: <20250907181719.0138c054@foz.lan>
In-Reply-To: <20250907153547.5d4271d9@foz.lan>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
	<6089e22ddfdc135040cdeb69329d817846026728@intel.com>
	<20250905140104.42418fba@foz.lan>
	<34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
	<atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
	<2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
	<20250906105627.2c0cd0d9@foz.lan>
	<d815f5c3-6e15-4758-8bf4-601d5543cab9@infradead.org>
	<20250906233028.56573fd6@foz.lan>
	<20250907153547.5d4271d9@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Sun, 7 Sep 2025 15:35:47 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Sat, 6 Sep 2025 23:30:28 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>=20
> > Em Sat, 6 Sep 2025 10:13:23 -0700
> > Randy Dunlap <rdunlap@infradead.org> escreveu:
> >=20
> > > On 9/6/25 1:56 AM, Mauro Carvalho Chehab wrote: =20
> > > > Em Fri, 5 Sep 2025 15:07:31 -0700
> > > > Randy Dunlap <rdunlap@infradead.org> escreveu:
> > > >    =20
> > > >> Hi,
> > > >>
> > > >> On 9/5/25 6:38 AM, Mauro Carvalho Chehab wrote:   =20
> > > >>> On Fri, Sep 05, 2025 at 04:06:31PM +0300, Jani Nikula wrote:     =
=20
> > > >>>> On Fri, 05 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kerne=
l.org> wrote:     =20
> > > >>>>> Em Fri, 05 Sep 2025 12:02:37 +0300
> > > >>>>> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> > > >>>>>     =20
> > > >>>>>> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrot=
e:     =20
> > > >>>>>>> Provide some basic comments about the system_states and what =
they imply.
> > > >>>>>>> Also convert the comments to kernel-doc format.
> > > >>>>>>>
> > > >>>>>>> However, kernel-doc does not support kernel-doc notation on e=
xtern
> > > >>>>>>> struct/union/typedef/enum/etc. So I made this a DOC: block so=
 that
> > > >>>>>>> I can use (insert) it into a Documentation (.rst) file and ha=
ve it
> > > >>>>>>> look decent.       =20
> > > >>>>>>
> > > >>>>>> The simple workaround is to separate the enum type and the var=
iable:
> > > >>>>>>
> > > >>>>>> /**
> > > >>>>>>  * kernel-doc for the enum
> > > >>>>>>  */
> > > >>>>>> enum system_states {
> > > >>>>>> 	...
> > > >>>>>> };
> > > >>>>>>
> > > >>>>>> /**
> > > >>>>>>  * kernel-doc for the variable
> > > >>>>>>  */
> > > >>>>>> extern enum system_states system_state;
> > > >>>>>>
> > > >>>>>> BR,
> > > >>>>>> Jani.
> > > >>>>>>     =20
> > > >>>>>>>
> > > >>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > >>>>>>> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
> > > >>>>>>> ---     =20
> > > >>
> > > >> [snip]   =20
> > > >>>>> If the problem is with "extern" before enum, fixing kdoc be
> > > >>>>> fairly trivial.     =20
> > > >>>>
> > > >>>> The non-trivial part is deciding whether you're documenting the =
enum
> > > >>>> type or the variable. Both are equally valid options.     =20
> > > >>>
> > > >>> True.
> > > >>>
> > > >>> I'd say that, if the variable is under EXPORT_SYMBOL macros, it
> > > >>> should be documented.     =20
> > > >>
> > > >> Do you mean documented with kernel-doc? How do we do that?
> > > >> I was under the impression that we don't currently have a way to
> > > >> use kernel-doc for variables (definitions, only for declarations).=
   =20
> > > >=20
> > > > No, but it shouldn't be hard to add something like:
> > > >=20
> > > > 	/**
> > > > 	 * global system_state - stores system state
> > > > 	 * <some description>
> > > > 	 */
> > > > 	extern enum system_states system_state; =20
> > > >=20
> > > > and place a dump_global() function at kdoc parser. Ok, one might use
> > > > DOC:, but IMHO the best is to have a proper handler for it that wou=
ld
> > > > automatically pick the type.   =20
> > >=20
> > > Nitpick, I would s/global/var/. But I won't complain about "global". =
=20
> >=20
> > Either way works for me. Yet, I would expect it to be used only for
> > global variables, as documenting local ones using kernel-doc is
> > probably not what we expect inside Kernel documentation. So, naming it
> > "global" may help.
> >=20
> > > More importantly, I have seen several patches where people try to doc=
ument a
> > > variable, so it seems like something that we should support at some p=
oint. =20
> >=20
> > Agreed.
> >=20
> > Adding a parsing rule for the variable doesn't sound hard, as they foll=
ow,
> > in principle, this regex(*):
> >=20
> > 	OPTIONAL_ATTRIBS =3D ["
> > 	    "extern"
> > 	]
> >=20
> > 	optional =3D "|".join(OPTIONAL_ATTRIBS)
> >=20
> > 	"^(?:extern\s+)?(\w.*)\s+([\w\_]+)(?:#.*)$"
> >=20
> > (*) eventually, some might have extra attributes, but we can
> >     start with a simpler regex, adding a more complex parser if/when
> >     needed.
> >=20
> > I added at the end a one-minute hacky prototype I wrote, completely
> > untested and incomplete.
>=20
> Heh, it doesn't hurt spending 15 mins or so to write something that actua=
lly
> works and implement all functions.
>=20
> The example below produces:
>=20
> 	$ ./scripts/kernel-doc include/media/tuner-types.h=20
> ...
> 	.. c:var:: tuners
>=20
> 	  list of tuners
>=20
> 	extern const struct tunertype tuners[];
>=20
> 	.. c:var:: tuner_count
>=20
> 	  number of known tuners
>=20
> 	$ ./scripts/kernel-doc include/media/tuner-types.h --man
> ...
> 	.TH "Kernel API" 9 "global tuner_count" "September 2025" "API Manual" LI=
NUX
> 	.SH NAME
> 	extern unsigned const int tuner_count; \- number of known tuners
> 	.SH SYNOPSIS
> 	enum tuner_count {
> 	.SH "SEE ALSO"
> 	.PP
>=20
> Still not ready for kernel merge (plus I placed bogus descriptions for
> two externs from media that IMO doesn't make sense to document), but it
> has all needed steps for someone wanting to extend kernel-doc to see
> how to do it.
>=20
> Feel free to modify it - even renaming from "global" to "var" and
> submit upstream.
>=20
> Thanks,
> Mauro
>=20
> [PATCH] [RFC] kernel-doc: add support for handling global varaibles
>=20
> Add support for documenting global variables with kernel-doc.
>=20
> Please notice that this is mostly an example, as:
>=20
> 1. I'm documenting just two random variables from media, that
>    doesn't make sense to actually be documented. I did it just
>    to have some example and be able to test it;
>=20
> 2. the html output requires tweak: right now, it is just printing
>    the entire variable prototype as-is, without any formatting,
>    and witout making sense at the output
>=20
> Feel free to modify this patch to make it something actually
> mergeable.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>=20
> diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
> index c79b773f750c..cf074beaeccc 100644
> --- a/include/media/tuner-types.h
> +++ b/include/media/tuner-types.h
> @@ -199,7 +199,18 @@ struct tunertype {
>  	u8 *sleepdata;
>  };
> =20
> +/**
> + * global tuner - list of tuners
> + *
> + * List of all tuners defined via v4l2 API
> + */
>  extern const struct tunertype tuners[];
> +
> +/**
> + * global tune_count - number of known tuners
> + *
> + * Number of tuners at @tuners list
> + */
>  extern unsigned const int tuner_count;
> =20
>  #endif
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_outp=
ut.py
> index 1eca9a918558..a58562bef35a 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -199,6 +199,10 @@ class OutputFormat:
>              self.out_enum(fname, name, args)
>              return self.data
> =20
> +        if dtype =3D=3D "global":
> +            self.out_global(fname, name, args)
> +            return self.data
> +
>          if dtype =3D=3D "typedef":
>              self.out_typedef(fname, name, args)
>              return self.data
> @@ -227,6 +231,9 @@ class OutputFormat:
>      def out_enum(self, fname, name, args):
>          """Outputs an enum"""
> =20
> +    def out_global(self, fname, name, args):
> +        """Outputs a global variable"""
> +
>      def out_typedef(self, fname, name, args):
>          """Outputs a typedef"""
> =20
> @@ -472,6 +479,20 @@ class RestFormat(OutputFormat):
>          self.lineprefix =3D oldprefix
>          self.out_section(args)
> =20
> +    def out_global(self, fname, name, args):
> +        oldprefix =3D self.lineprefix
> +        ln =3D args.declaration_start_line
> +
> +        self.data +=3D f"\n\n.. c:var:: {name}\n\n"
> +
> +        self.print_lineno(ln)
> +        self.lineprefix =3D "  "
> +        self.output_highlight(args.get('purpose', ''))
> +        self.data +=3D "\n"
> +
> +        # FIXME: better handle it
> +        self.data +=3D args.other_stuff["var_type"]
> +

Heh, looking at Sphinx doc at:
https://www.sphinx-doc.org/en/master/usage/domains/c.html:

	.. c:member:: declaration
	.. c:var:: declaration

	    Describes a C struct member or variable. Example signature:

	    .. c:member:: PyObject *PyTypeObject.tp_bases

	    The difference between the two directives is only cosmetic.

I guess the best is to encode it as:

	prototype =3D args.other_stuff["var_type"]
	self.data +=3D f"\n\n.. c:var:: {prototype}\n\n"

And let Sphinx format it for us. With such change, this is
the html output for the two test variables we added at the RFC:

<dl class=3D"c var">
<dt class=3D"sig sig-object c" id=3D"c.tuners">
<span class=3D"k"><span class=3D"pre">extern</span></span><span class=3D"w"=
> </span><span class=3D"k"><span class=3D"pre">const</span></span><span cla=
ss=3D"w"> </span><span class=3D"k"><span class=3D"pre">struct</span></span>=
<span class=3D"w"> </span><a class=3D"reference internal" href=3D"#c.tunert=
ype" title=3D"tunertype"><span class=3D"n"><span class=3D"pre">tunertype</s=
pan></span></a><span class=3D"w"> </span><span class=3D"sig-name descname">=
<span class=3D"n"><span class=3D"pre">tuners</span></span></span><span clas=
s=3D"p"><span class=3D"pre">[</span></span><span class=3D"p"><span class=3D=
"pre">]</span></span><span class=3D"p"><span class=3D"pre">;</span></span><=
a class=3D"headerlink" href=3D"#c.tuners" title=3D"Link to this definition"=
>=C2=B6</a><br /></dt>
<dd><p>list of tuners</p>
</dd></dl>

<dl class=3D"c var">
<dt class=3D"sig sig-object c">
<span class=3D"sig-name descname"><span class=3D"pre">extern</span> <span c=
lass=3D"pre">unsigned</span> <span class=3D"pre">const</span> <span class=
=3D"pre">int</span> <span class=3D"pre">tuner_count;</span></span></dt>
<dd><p>number of known tuners</p>

RFC patch with the test vars enclosed. I'll submit the kernel-doc
patch in separate, without V4L2 stuff, for its review.

Thanks,
Mauro

---

[PATCH] [RFC] kernel-doc: add support for handling global varaibles

Add support for documenting global variables with kernel-doc.

Please notice that this is mostly an example, as:

1. I'm documenting just two random variables from media, that
   doesn't make sense to actually be documented. I did it just
   to have some example and be able to test it;

2. the html output requires tweak: right now, it is just printing
   the entire variable prototype as-is, without any formatting,
   and witout making sense at the output

Feel free to modify this patch to make it something actually
mergeable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
index c79b773f750c..cf074beaeccc 100644
--- a/include/media/tuner-types.h
+++ b/include/media/tuner-types.h
@@ -199,7 +199,18 @@ struct tunertype {
 	u8 *sleepdata;
 };
=20
+/**
+ * global tuner - list of tuners
+ *
+ * List of all tuners defined via v4l2 API
+ */
 extern const struct tunertype tuners[];
+
+/**
+ * global tune_count - number of known tuners
+ *
+ * Number of tuners at @tuners list
+ */
 extern unsigned const int tuner_count;
=20
 #endif
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output=
.py
index 1eca9a918558..405a5c407522 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -199,6 +199,10 @@ class OutputFormat:
             self.out_enum(fname, name, args)
             return self.data
=20
+        if dtype =3D=3D "global":
+            self.out_global(fname, name, args)
+            return self.data
+
         if dtype =3D=3D "typedef":
             self.out_typedef(fname, name, args)
             return self.data
@@ -227,6 +231,9 @@ class OutputFormat:
     def out_enum(self, fname, name, args):
         """Outputs an enum"""
=20
+    def out_global(self, fname, name, args):
+        """Outputs a global variable"""
+
     def out_typedef(self, fname, name, args):
         """Outputs a typedef"""
=20
@@ -472,6 +479,18 @@ class RestFormat(OutputFormat):
         self.lineprefix =3D oldprefix
         self.out_section(args)
=20
+    def out_global(self, fname, name, args):
+        oldprefix =3D self.lineprefix
+        ln =3D args.declaration_start_line
+        prototype =3D args.other_stuff["var_type"]
+
+        self.data +=3D f"\n\n.. c:var:: {prototype}\n\n"
+
+        self.print_lineno(ln)
+        self.lineprefix =3D "  "
+        self.output_highlight(args.get('purpose', ''))
+        self.data +=3D "\n"
+
     def out_typedef(self, fname, name, args):
=20
         oldprefix =3D self.lineprefix
@@ -772,6 +791,18 @@ class ManFormat(OutputFormat):
             self.data +=3D f'.SH "{section}"' + "\n"
             self.output_highlight(text)
=20
+    def out_global(self, fname, name, args):
+        out_name =3D self.arg_name(args, name)
+        prototype =3D args.other_stuff["var_type"]
+
+        self.data +=3D f'.TH "{self.modulename}" 9 "{out_name}" "{self.man=
_date}" "API Manual" LINUX' + "\n"
+
+        self.data +=3D ".SH NAME\n"
+        self.data +=3D f"{prototype} \\- {args['purpose']}\n"
+
+        self.data +=3D ".SH SYNOPSIS\n"
+        self.data +=3D f"enum {name}" + " {\n"
+
     def out_typedef(self, fname, name, args):
         module =3D self.modulename
         purpose =3D args.get('purpose')
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser=
.py
index 574972e1f741..e2a3f4574894 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -64,7 +64,7 @@ type_param =3D KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)=
", cache=3DFalse)
 # Tests for the beginning of a kerneldoc block in its various forms.
 #
 doc_block =3D doc_com + KernRe(r'DOC:\s*(.*)?', cache=3DFalse)
-doc_begin_data =3D KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\b\s*(\w*=
)", cache =3D False)
+doc_begin_data =3D KernRe(r"^\s*\*?\s*(struct|union|enum|typedef|global)\b=
\s*(\w*)", cache =3D False)
 doc_begin_func =3D KernRe(str(doc_com) +			# initial " * '
                         r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
                         r'(?:define\s+)?' + 		# possible "define" (not cap=
tured)
@@ -886,6 +886,27 @@ class KernelDoc:
         self.output_declaration('enum', declaration_name,
                                 purpose=3Dself.entry.declaration_purpose)
=20
+    def dump_global(self, ln, proto):
+        """
+        Stores global variables that are part of kAPI.
+        """
+        VAR_ATTRIBS =3D [
+            "extern",
+        ]
+        OPTIONAL_VAR_ATTR =3D "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
+
+        r=3D KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)[\d\]\[]*\s*;(?=
:#.*)?$")
+        if not r.match(proto):
+           self.emit_msg(ln,f"{proto}: can't parse variable")
+           return
+
+        declaration_name =3D r.group(2)
+        var_type =3D r.group(0)
+
+        self.output_declaration("global", declaration_name,
+                                var_type=3Dvar_type,
+                                purpose=3Dself.entry.declaration_purpose)
+
     def dump_declaration(self, ln, prototype):
         """
         Stores a data declaration inside self.entries array.
@@ -897,6 +918,8 @@ class KernelDoc:
             self.dump_typedef(ln, prototype)
         elif self.entry.decl_type in ["union", "struct"]:
             self.dump_struct(ln, prototype)
+        elif self.entry.decl_type =3D=3D "global":
+            self.dump_global(ln, prototype)
         else:
             # This would be a bug
             self.emit_message(ln, f'Unknown declaration type: {self.entry.=
decl_type}')


