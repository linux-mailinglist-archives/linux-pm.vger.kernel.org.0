Return-Path: <linux-pm+bounces-34110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777BB47BA4
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E2B3B580D
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149EB1FAC34;
	Sun,  7 Sep 2025 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3by046A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22C1C28E;
	Sun,  7 Sep 2025 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757252153; cv=none; b=NOd63p+5vGm34WgAr7qklSpyY4haPHw9+2SVJ1jVeXVG8Nefm172P3dZYp1KwgHdz5brquWU9/a3rlxwHXlU2vewVlgoVHj2Ca3zFLXbHt0Mc9NQ8jXepi6kVCz2Z11rZCRi3fe+3kPK7UnDFYqoRwvBRGPyouEYOm1m4vrpBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757252153; c=relaxed/simple;
	bh=rNoPmiCA0KoAx7EBFxvixnxdNCF9UXaAbsu4Ps4ESSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlFK8d6PLafEEfgbhSGKmmo8C79iFsPEw7CgMvU/Lmur7UMA59SxF57qaxTVdskfdKMM6XwXC3tpBRF9TYRjjTYlhDX1OllUALI33WHdIbMauNmOAaRkUOfeMEw4QjgXLzXzJiKb+DiRPUO84jRa2FnEWZPKqRI1Q8uyeT9eRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3by046A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1328CC4CEF0;
	Sun,  7 Sep 2025 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757252152;
	bh=rNoPmiCA0KoAx7EBFxvixnxdNCF9UXaAbsu4Ps4ESSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f3by046Ai3dw8pXvF2Ofc1BkEM4yJpKZJtJFZ5WQuv26/ouDy8ulNZluqueF8c8OV
	 BuK/2W1LBNR5b6Nv0xXhJOQxswO7JMEOQ16MOrzipAWkDUuhNz96uDmX6ums/fTo/6
	 mptQOZs84fqcA6lt+svO/HyyJpk80rb1NYcDHsV5Ww/kRdXKVOsmRrNROPuKSZ2dyc
	 dLQL7clxM1lbfX+XJWAeXqjeeYJDqEjM+eEq8hT8W1Ega807Cadc6VdF0zKRNdj7Rd
	 0rkmLfucKiUqVPv8pO4w66yCgk1DndsMiQt28XnuesTzllP3wbg3k+6b0izxSDYfGi
	 wF8VyUCtbdbrQ==
Date: Sun, 7 Sep 2025 15:35:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
Message-ID: <20250907153547.5d4271d9@foz.lan>
In-Reply-To: <20250906233028.56573fd6@foz.lan>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
	<6089e22ddfdc135040cdeb69329d817846026728@intel.com>
	<20250905140104.42418fba@foz.lan>
	<34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
	<atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
	<2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
	<20250906105627.2c0cd0d9@foz.lan>
	<d815f5c3-6e15-4758-8bf4-601d5543cab9@infradead.org>
	<20250906233028.56573fd6@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 6 Sep 2025 23:30:28 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Sat, 6 Sep 2025 10:13:23 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
> > On 9/6/25 1:56 AM, Mauro Carvalho Chehab wrote:  
> > > Em Fri, 5 Sep 2025 15:07:31 -0700
> > > Randy Dunlap <rdunlap@infradead.org> escreveu:
> > >     
> > >> Hi,
> > >>
> > >> On 9/5/25 6:38 AM, Mauro Carvalho Chehab wrote:    
> > >>> On Fri, Sep 05, 2025 at 04:06:31PM +0300, Jani Nikula wrote:      
> > >>>> On Fri, 05 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:      
> > >>>>> Em Fri, 05 Sep 2025 12:02:37 +0300
> > >>>>> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> > >>>>>      
> > >>>>>> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:      
> > >>>>>>> Provide some basic comments about the system_states and what they imply.
> > >>>>>>> Also convert the comments to kernel-doc format.
> > >>>>>>>
> > >>>>>>> However, kernel-doc does not support kernel-doc notation on extern
> > >>>>>>> struct/union/typedef/enum/etc. So I made this a DOC: block so that
> > >>>>>>> I can use (insert) it into a Documentation (.rst) file and have it
> > >>>>>>> look decent.        
> > >>>>>>
> > >>>>>> The simple workaround is to separate the enum type and the variable:
> > >>>>>>
> > >>>>>> /**
> > >>>>>>  * kernel-doc for the enum
> > >>>>>>  */
> > >>>>>> enum system_states {
> > >>>>>> 	...
> > >>>>>> };
> > >>>>>>
> > >>>>>> /**
> > >>>>>>  * kernel-doc for the variable
> > >>>>>>  */
> > >>>>>> extern enum system_states system_state;
> > >>>>>>
> > >>>>>> BR,
> > >>>>>> Jani.
> > >>>>>>      
> > >>>>>>>
> > >>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > >>>>>>> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
> > >>>>>>> ---      
> > >>
> > >> [snip]    
> > >>>>> If the problem is with "extern" before enum, fixing kdoc be
> > >>>>> fairly trivial.      
> > >>>>
> > >>>> The non-trivial part is deciding whether you're documenting the enum
> > >>>> type or the variable. Both are equally valid options.      
> > >>>
> > >>> True.
> > >>>
> > >>> I'd say that, if the variable is under EXPORT_SYMBOL macros, it
> > >>> should be documented.      
> > >>
> > >> Do you mean documented with kernel-doc? How do we do that?
> > >> I was under the impression that we don't currently have a way to
> > >> use kernel-doc for variables (definitions, only for declarations).    
> > > 
> > > No, but it shouldn't be hard to add something like:
> > > 
> > > 	/**
> > > 	 * global system_state - stores system state
> > > 	 * <some description>
> > > 	 */
> > > 	extern enum system_states system_state;  
> > > 
> > > and place a dump_global() function at kdoc parser. Ok, one might use
> > > DOC:, but IMHO the best is to have a proper handler for it that would
> > > automatically pick the type.    
> > 
> > Nitpick, I would s/global/var/. But I won't complain about "global".  
> 
> Either way works for me. Yet, I would expect it to be used only for
> global variables, as documenting local ones using kernel-doc is
> probably not what we expect inside Kernel documentation. So, naming it
> "global" may help.
> 
> > More importantly, I have seen several patches where people try to document a
> > variable, so it seems like something that we should support at some point.  
> 
> Agreed.
> 
> Adding a parsing rule for the variable doesn't sound hard, as they follow,
> in principle, this regex(*):
> 
> 	OPTIONAL_ATTRIBS = ["
> 	    "extern"
> 	]
> 
> 	optional = "|".join(OPTIONAL_ATTRIBS)
> 
> 	"^(?:extern\s+)?(\w.*)\s+([\w\_]+)(?:#.*)$"
> 
> (*) eventually, some might have extra attributes, but we can
>     start with a simpler regex, adding a more complex parser if/when
>     needed.
> 
> I added at the end a one-minute hacky prototype I wrote, completely
> untested and incomplete.

Heh, it doesn't hurt spending 15 mins or so to write something that actually
works and implement all functions.

The example below produces:

	$ ./scripts/kernel-doc include/media/tuner-types.h 
...
	.. c:var:: tuners

	  list of tuners

	extern const struct tunertype tuners[];

	.. c:var:: tuner_count

	  number of known tuners

	$ ./scripts/kernel-doc include/media/tuner-types.h --man
...
	.TH "Kernel API" 9 "global tuner_count" "September 2025" "API Manual" LINUX
	.SH NAME
	extern unsigned const int tuner_count; \- number of known tuners
	.SH SYNOPSIS
	enum tuner_count {
	.SH "SEE ALSO"
	.PP

Still not ready for kernel merge (plus I placed bogus descriptions for
two externs from media that IMO doesn't make sense to document), but it
has all needed steps for someone wanting to extend kernel-doc to see
how to do it.

Feel free to modify it - even renaming from "global" to "var" and
submit upstream.

Thanks,
Mauro

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
 
 #endif
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 1eca9a918558..a58562bef35a 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -199,6 +199,10 @@ class OutputFormat:
             self.out_enum(fname, name, args)
             return self.data
 
+        if dtype == "global":
+            self.out_global(fname, name, args)
+            return self.data
+
         if dtype == "typedef":
             self.out_typedef(fname, name, args)
             return self.data
@@ -227,6 +231,9 @@ class OutputFormat:
     def out_enum(self, fname, name, args):
         """Outputs an enum"""
 
+    def out_global(self, fname, name, args):
+        """Outputs a global variable"""
+
     def out_typedef(self, fname, name, args):
         """Outputs a typedef"""
 
@@ -472,6 +479,20 @@ class RestFormat(OutputFormat):
         self.lineprefix = oldprefix
         self.out_section(args)
 
+    def out_global(self, fname, name, args):
+        oldprefix = self.lineprefix
+        ln = args.declaration_start_line
+
+        self.data += f"\n\n.. c:var:: {name}\n\n"
+
+        self.print_lineno(ln)
+        self.lineprefix = "  "
+        self.output_highlight(args.get('purpose', ''))
+        self.data += "\n"
+
+        # FIXME: better handle it
+        self.data += args.other_stuff["var_type"]
+
     def out_typedef(self, fname, name, args):
 
         oldprefix = self.lineprefix
@@ -772,6 +793,18 @@ class ManFormat(OutputFormat):
             self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(text)
 
+    def out_global(self, fname, name, args):
+        out_name = self.arg_name(args, name)
+        prototype = args.other_stuff["var_type"]
+
+        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+
+        self.data += ".SH NAME\n"
+        self.data += f"{prototype} \\- {args['purpose']}\n"
+
+        self.data += ".SH SYNOPSIS\n"
+        self.data += f"enum {name}" + " {\n"
+
     def out_typedef(self, fname, name, args):
         module = self.modulename
         purpose = args.get('purpose')
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 574972e1f741..e2a3f4574894 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -64,7 +64,7 @@ type_param = KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
 # Tests for the beginning of a kerneldoc block in its various forms.
 #
 doc_block = doc_com + KernRe(r'DOC:\s*(.*)?', cache=False)
-doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\b\s*(\w*)", cache = False)
+doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef|global)\b\s*(\w*)", cache = False)
 doc_begin_func = KernRe(str(doc_com) +			# initial " * '
                         r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
                         r'(?:define\s+)?' + 		# possible "define" (not captured)
@@ -886,6 +886,27 @@ class KernelDoc:
         self.output_declaration('enum', declaration_name,
                                 purpose=self.entry.declaration_purpose)
 
+    def dump_global(self, ln, proto):
+        """
+        Stores global variables that are part of kAPI.
+        """
+        VAR_ATTRIBS = [
+            "extern",
+        ]
+        OPTIONAL_VAR_ATTR = "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
+
+        r= KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)[\d\]\[]*\s*;(?:#.*)?$")
+        if not r.match(proto):
+           self.emit_msg(ln,f"{proto}: can't parse variable")
+           return
+
+        declaration_name = r.group(2)
+        var_type = r.group(0)
+
+        self.output_declaration("global", declaration_name,
+                                var_type=var_type,
+                                purpose=self.entry.declaration_purpose)
+
     def dump_declaration(self, ln, prototype):
         """
         Stores a data declaration inside self.entries array.
@@ -897,6 +918,8 @@ class KernelDoc:
             self.dump_typedef(ln, prototype)
         elif self.entry.decl_type in ["union", "struct"]:
             self.dump_struct(ln, prototype)
+        elif self.entry.decl_type == "global":
+            self.dump_global(ln, prototype)
         else:
             # This would be a bug
             self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')


