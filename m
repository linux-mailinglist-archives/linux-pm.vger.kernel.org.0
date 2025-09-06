Return-Path: <linux-pm+bounces-34088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7428B47773
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 23:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072757B560B
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67D1CFBA;
	Sat,  6 Sep 2025 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRUlHDeD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71502315D43;
	Sat,  6 Sep 2025 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757194234; cv=none; b=cfdxo2sDu9pOWtlUH+jeJZLM7Qh0BS0OwP9Z5r3CLdPJwpxu7ffzMKMqHTZN3Ux3qogypj9GALsO8EJX0JCFiU1d2IKfiv2Hckhn2aNKuKzkcx1XMQv63Go3Wtbzd2ltk/rDx7pORAuOAw99+zZctmM19cCh6VVIrznQFHBhBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757194234; c=relaxed/simple;
	bh=dR+HFN4RItes6cFLf8dFGdaPc8wtAZj68FPV+CJdYZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lA9t/Nk/vMenZmL5E456d9h6Qx3NSIGdGX0w0DcRkTLHzeR/dwfiM5AYKU+tqphQjzikFK3N8biQtFchBIiL9MuNPYMaKXVbMj7KP4b+uBc71l4YZCDvNIWJIbH6ap2RsiuMhH7I/+tauHEQ6L6QXtwfxcFjIcbyJ5GOtr7FadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRUlHDeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1824C4CEE7;
	Sat,  6 Sep 2025 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757194234;
	bh=dR+HFN4RItes6cFLf8dFGdaPc8wtAZj68FPV+CJdYZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nRUlHDeDO85y8yiubgdJjtfmbfPyD03yJqpqNBaJy//z5MYR5sNlkxX7RVLEsL/Lc
	 yELp57LPa1P3fgLl8JZSB7uDH3nDYdBOgMs22Wc/NhnmxgZDKPpBxq+fwtj+G+7HfX
	 wPpNff9nEZlbyha6DV7yTEH43me5Iay7OIDoKxnak+7goZCV4+O4hp8grftjAgyDtQ
	 RrUglOq708jwG96CGeCddVVkgVhd1Ys1XwIUOSUoYyumhGUKB6kEu4XXeOdyTzHiHQ
	 7d7dPRFHEj16hvV66b4LQycVTLSQjmD+4ndmoFS6j88ngz2Cg3C1KS+kHL9tu9jmv6
	 IjmmvdRgaBU/A==
Date: Sat, 6 Sep 2025 23:30:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
Message-ID: <20250906233028.56573fd6@foz.lan>
In-Reply-To: <d815f5c3-6e15-4758-8bf4-601d5543cab9@infradead.org>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
	<6089e22ddfdc135040cdeb69329d817846026728@intel.com>
	<20250905140104.42418fba@foz.lan>
	<34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
	<atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
	<2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
	<20250906105627.2c0cd0d9@foz.lan>
	<d815f5c3-6e15-4758-8bf4-601d5543cab9@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 6 Sep 2025 10:13:23 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 9/6/25 1:56 AM, Mauro Carvalho Chehab wrote:
> > Em Fri, 5 Sep 2025 15:07:31 -0700
> > Randy Dunlap <rdunlap@infradead.org> escreveu:
> >   
> >> Hi,
> >>
> >> On 9/5/25 6:38 AM, Mauro Carvalho Chehab wrote:  
> >>> On Fri, Sep 05, 2025 at 04:06:31PM +0300, Jani Nikula wrote:    
> >>>> On Fri, 05 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:    
> >>>>> Em Fri, 05 Sep 2025 12:02:37 +0300
> >>>>> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >>>>>    
> >>>>>> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:    
> >>>>>>> Provide some basic comments about the system_states and what they imply.
> >>>>>>> Also convert the comments to kernel-doc format.
> >>>>>>>
> >>>>>>> However, kernel-doc does not support kernel-doc notation on extern
> >>>>>>> struct/union/typedef/enum/etc. So I made this a DOC: block so that
> >>>>>>> I can use (insert) it into a Documentation (.rst) file and have it
> >>>>>>> look decent.      
> >>>>>>
> >>>>>> The simple workaround is to separate the enum type and the variable:
> >>>>>>
> >>>>>> /**
> >>>>>>  * kernel-doc for the enum
> >>>>>>  */
> >>>>>> enum system_states {
> >>>>>> 	...
> >>>>>> };
> >>>>>>
> >>>>>> /**
> >>>>>>  * kernel-doc for the variable
> >>>>>>  */
> >>>>>> extern enum system_states system_state;
> >>>>>>
> >>>>>> BR,
> >>>>>> Jani.
> >>>>>>    
> >>>>>>>
> >>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>>>>>> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
> >>>>>>> ---    
> >>
> >> [snip]  
> >>>>> If the problem is with "extern" before enum, fixing kdoc be
> >>>>> fairly trivial.    
> >>>>
> >>>> The non-trivial part is deciding whether you're documenting the enum
> >>>> type or the variable. Both are equally valid options.    
> >>>
> >>> True.
> >>>
> >>> I'd say that, if the variable is under EXPORT_SYMBOL macros, it
> >>> should be documented.    
> >>
> >> Do you mean documented with kernel-doc? How do we do that?
> >> I was under the impression that we don't currently have a way to
> >> use kernel-doc for variables (definitions, only for declarations).  
> > 
> > No, but it shouldn't be hard to add something like:
> > 
> > 	/**
> > 	 * global system_state - stores system state
> > 	 * <some description>
> > 	 */
> > 	extern enum system_states system_state;  
> > 
> > and place a dump_global() function at kdoc parser. Ok, one might use
> > DOC:, but IMHO the best is to have a proper handler for it that would
> > automatically pick the type.  
> 
> Nitpick, I would s/global/var/. But I won't complain about "global".

Either way works for me. Yet, I would expect it to be used only for
global variables, as documenting local ones using kernel-doc is
probably not what we expect inside Kernel documentation. So, naming it
"global" may help.

> More importantly, I have seen several patches where people try to document a
> variable, so it seems like something that we should support at some point.

Agreed.

Adding a parsing rule for the variable doesn't sound hard, as they follow,
in principle, this regex(*):

	OPTIONAL_ATTRIBS = ["
	    "extern"
	]

	optional = "|".join(OPTIONAL_ATTRIBS)

	"^(?:extern\s+)?(\w.*)\s+([\w\_]+)(?:#.*)$"

(*) eventually, some might have extra attributes, but we can
    start with a simpler regex, adding a more complex parser if/when
    needed.

I added at the end a one-minute hacky prototype I wrote, completely
untested and incomplete.

Thanks,
Mauro

The following code snippet is incomplete, not tested, and requires more
work, like placing global vars at the beginning. Feel free
to pick it and use it to produce a GPL code to the Kernel.

Note that this is just the parsing part. for it to work, you also
need to modify scripts/lib/kdoc/kdoc_output.py, which contains how
this will be output at rst and man formats.

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 574972e1f741..b3ffaa541e9d 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -886,6 +886,25 @@ class KernelDoc:
         self.output_declaration('enum', declaration_name,
                                 purpose=self.entry.declaration_purpose)
 
+   def dump_global(self, ln, proto):
+        # TODO: move this to the beginning of this file
+        VAR_ATTRIBS = [
+            "extern",
+        ]
+        OPTIONAL_VAR_ATTR = "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
+
+        type_var = KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)(?:#.*)?$")
+
+        # function logic starts here:
+
+        if type_var.match(proto):
+                declaration_name = r.group(2)
+                var_type = r.group(1)
+
+        self.output_declaration('global', declaration_name,
+                                var_type=var_type,
+                                purpose=self.entry.declaration_purpose)
+
     def dump_declaration(self, ln, prototype):
         """
         Stores a data declaration inside self.entries array.
@@ -897,6 +916,8 @@ class KernelDoc:
             self.dump_typedef(ln, prototype)
         elif self.entry.decl_type in ["union", "struct"]:
             self.dump_struct(ln, prototype)
+        elif self.entry.decl_type == "global"]:
+            self.dump_global(ln, prototype)
         else:
             # This would be a bug
             self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')


