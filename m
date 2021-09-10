Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98295406AA3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhIJLTn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Sep 2021 07:19:43 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45679 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhIJLTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Sep 2021 07:19:42 -0400
Received: by mail-oi1-f170.google.com with SMTP id q39so2401606oiw.12;
        Fri, 10 Sep 2021 04:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mc0xPslGZj9sy1U7IiLU0vE11/d4ChU3H+1S8KTMkf8=;
        b=t/exzw+EAAB1Lb6ptNFV4VsanYDttNI6btyE9NlQJHTkiIF8kgONdBe1jx0UeFJYG+
         zBhB+fwW3NqRdNSsbsOW+3XFTEhiVYIDTv+tX9YyKFFMkOp4mCWUeeKe1G5PusyG+U02
         s9YmMlykR6dQgH9xvq/YiTyY9cMtA1pBcrfWGKIh4rHSCw2rCZ8o1Xbfuh41zFuGjiVN
         NPuGJ6y98C6ZBX9G95IpOYNtl4N+k6SFH2pntqaykB8DfPA/KSgwUfig6QIpi0ayMJTu
         kI5cRNVjknKX4/8DWellORgk5zPe+sXBzw2xdAwJYhAsHNNTZS8jrUlYJRWh/0n2dmNi
         pKcQ==
X-Gm-Message-State: AOAM532wxUP/vYRm1me0oBJxWF2+clxAHffNR7Mopd5KU2bCQ1AUSLE7
        3/s5yMyPFJh/RBFgLnoeIzzYlK4N2ZPVttoCvhQ=
X-Google-Smtp-Source: ABdhPJzT8Mi7i73LpYOilDpG2Ad+eBHrwm2iC4sIYkQi4Xb4mXRbxLlbdk0UuxX+QSYv2b73cgTNW4cL9IKeu6S7Xqg=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr3523425ois.69.1631272711378;
 Fri, 10 Sep 2021 04:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210909034802.1708-1-dsmythies@telus.net> <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
 <CAJZ5v0gn8rpTiVqkXgGqPFDH8-BKTYGiypM-2A2q1jJLm6HbCQ@mail.gmail.com>
 <CAAYoRsWdFwiwo8j2Nc-vhk2mnoZqJC9fyS7URtEz3E1VxfNbLQ@mail.gmail.com>
 <CAJZ5v0hO7SajJ5HFVDcma6nOfzy-289MdwUSiJbY8Hm3mxvXnQ@mail.gmail.com>
 <CAJZ5v0j1JjLr0co06yJCCNV2p06e91Zh7tkMXoGTE=waB5Xo1Q@mail.gmail.com> <CAAYoRsUun0_tXTEGi6m1L0A9ffRWZ8FbLs1kFEZ0d0QQi+ssQw@mail.gmail.com>
In-Reply-To: <CAAYoRsUun0_tXTEGi6m1L0A9ffRWZ8FbLs1kFEZ0d0QQi+ssQw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Sep 2021 13:18:19 +0200
Message-ID: <CAJZ5v0jMDbxXt_EWN-GUOGBDCpDGHUoqRoTtfR8-rUOQjDBUyw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Override parameters if HWP forced
 by BIOS
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007e802005cba246a4"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--0000000000007e802005cba246a4
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 10, 2021 at 5:14 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Thu, Sep 9, 2021 at 10:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Sep 9, 2021 at 6:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Thu, Sep 9, 2021 at 3:20 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > > On Thu, Sep 9, 2021 at 4:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > On Thu, Sep 9, 2021 at 8:52 AM Srinivas Pandruvada
> > > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > > >
> > > > > > On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> > > > > > > If HWP has been already been enabled by BIOS, it may be
> > > > > > > necessary to override some kernel command line parameters.
> > > > > > > Once it has been enabled it requires a reset to be disabled.
> > > > > > >
> > > > > > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > > > > > ---
> > > > > > >  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
> > > > > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > > > index bb4549959b11..073bae5d4498 100644
> > > > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > > > @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
> > > > > > >                  */
> > > > > > >                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> > > > > > >                     intel_pstate_hwp_is_enabled()) {
> > > > > > > -                       hwp_active++;
> > > > > > > +                       hwp_active = 1;
> > > > > > Why this change?
> > > > >
> > > > > I think hwp_active can be changed to bool and then it would make sense
> > > > > to update this line.
> > > > >
> > > > > > >                         hwp_mode_bdw = id->driver_data;
> > > > > > >                         intel_pstate.attr = hwp_cpufreq_attrs;
> > > > > > >                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> > > > > > > @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> > > > > > >
> > > > > > >  static int __init intel_pstate_setup(char *str)
> > > > > > >  {
> > > > > > > +       /*
> > > > > > > +        * If BIOS is forcing HWP, then parameter
> > > > > > > +        * overrides might be needed. Only print
> > > > > > > +        * the message once, and regardless of
> > > > > > > +        * any overrides.
> > > > > > > +        */
> > > > > > > +       if(!hwp_active
> > > > > > This part of code is from early_param, Is it possible that
> > > > > > hwp_active is not 0?
> > > > >
> > > > > Well, it wouldn't matter even if it were nonzero.  This check is just
> > > > > pointless anyway.
> > > > >
> > > > > > > && boot_cpu_has(X86_FEATURE_HWP))
> > > > > > > +               if(intel_pstate_hwp_is_enabled()){
> > > > >
> > > > > This should be
> > > > >
> > > > > if (boot_cpu_has(X86_FEATURE_HWP) && intel_pstate_hwp_is_enabled()) {
> > > >
> > > > Disagree.
> > > > This routine gets executed once per intel_pstate related grub command
> > > > line entry. The purpose of the "if(!hwp_active" part is to prevent the
> > > > printing of the message to the logs multiple times.
> > >
> > > Ah OK.  Fair enough.
> > >
> > > You can do all of the checks in one conditional, though.  They will be
> > > processed left-to-right anyway.
> > >
> > > But then it would be good to avoid calling
> > > intel_pstate_hwp_is_enabled() multiple times if it returns false.
> > >
> > > And having said all that I'm not sure why you are trying to make
> > > no_hwp depend on !hwp_active?  I will not be taken into account anyway
> > > if intel_pstate_hwp_is_enabled() returns 'true'?
> > >
> > > So if no_hwp is covered regardless, you may move the
> > > intel_pstate_hwp_is_enabled() inside the no_load conditional.
> > >
> > > Alternatively, and I would do that, intel_pstate_hwp_is_enabled()
> > > could be evaluated earlier in intel_pstate_init() and if it returned
> > > 'true', both no_load and no_hwp would be disregarded.
> >
> > Something like the attached, for the record.
>
> O.K. and Thanks.
> I was trying to avoid this line getting into the log:
>
> [    0.000000] intel_pstate: HWP disabled
>
> only to overridden later by, now, these lines:
>
> [    0.373742] intel_pstate: HWP enabled by BIOS
> [    0.374177] intel_pstate: Intel P-state driver initializing
> [    0.375097] intel_pstate: HWP enabled
>
> Let me see if I can go with your suggestion and get to
> what I had hoped to get in the logs.

It would be sufficient to put the "disabled" printk() after the
"no_hwp" if () statement in intel_pstate_init().  See attached.

BTW, I've changed the message to "HWP not enabled", because that's
what really happens to be precise.

--0000000000007e802005cba246a4
Content-Type: text/x-patch; charset="US-ASCII"; name="intel_pstate-arguments.patch"
Content-Disposition: attachment; filename="intel_pstate-arguments.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kte9jpzq0>
X-Attachment-Id: f_kte9jpzq0

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgIDIyICsrKysrKysrKysrKysr
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYwo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYworKysg
bGludXgtcG0vZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCkBAIC0zMjA1LDExICszMjA1
LDE1IEBAIHN0YXRpYyBpbnQgX19pbml0IGludGVsX3BzdGF0ZV9pbml0KHZvaWQKIAlpZiAoYm9v
dF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSU5URUwpCiAJCXJldHVybiAtRU5P
REVWOwogCi0JaWYgKG5vX2xvYWQpCi0JCXJldHVybiAtRU5PREVWOwotCiAJaWQgPSB4ODZfbWF0
Y2hfY3B1KGh3cF9zdXBwb3J0X2lkcyk7CiAJaWYgKGlkKSB7CisJCWJvb2wgaHdwX2ZvcmNlZCA9
IGludGVsX3BzdGF0ZV9od3BfaXNfZW5hYmxlZCgpOworCisJCWlmIChod3BfZm9yY2VkKQorCQkJ
cHJfaW5mbygiSFdQIGVuYWJsZWQgYnkgQklPU1xuIik7CisJCWVsc2UgaWYgKG5vX2xvYWQpCisJ
CQlyZXR1cm4gLUVOT0RFVjsKKwogCQljb3B5X2NwdV9mdW5jcygmY29yZV9mdW5jcyk7CiAJCS8q
CiAJCSAqIEF2b2lkIGVuYWJsaW5nIEhXUCBmb3IgcHJvY2Vzc29ycyB3aXRob3V0IEVQUCBzdXBw
b3J0LApAQCAtMzIxOSw4ICszMjIzLDcgQEAgc3RhdGljIGludCBfX2luaXQgaW50ZWxfcHN0YXRl
X2luaXQodm9pZAogCQkgKiBJZiBIV1AgaXMgZW5hYmxlZCBhbHJlYWR5LCB0aG91Z2gsIHRoZXJl
IGlzIG5vIGNob2ljZSBidXQgdG8KIAkJICogZGVhbCB3aXRoIGl0LgogCQkgKi8KLQkJaWYgKCgh
bm9faHdwICYmIGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9IV1BfRVBQKSkgfHwKLQkJICAgIGlu
dGVsX3BzdGF0ZV9od3BfaXNfZW5hYmxlZCgpKSB7CisJCWlmICgoIW5vX2h3cCAmJiBib290X2Nw
dV9oYXMoWDg2X0ZFQVRVUkVfSFdQX0VQUCkpIHx8IGh3cF9mb3JjZWQpIHsKIAkJCWh3cF9hY3Rp
dmUrKzsKIAkJCWh3cF9tb2RlX2JkdyA9IGlkLT5kcml2ZXJfZGF0YTsKIAkJCWludGVsX3BzdGF0
ZS5hdHRyID0gaHdwX2NwdWZyZXFfYXR0cnM7CkBAIC0zMjM1LDcgKzMyMzgsMTEgQEAgc3RhdGlj
IGludCBfX2luaXQgaW50ZWxfcHN0YXRlX2luaXQodm9pZAogCiAJCQlnb3RvIGh3cF9jcHVfbWF0
Y2hlZDsKIAkJfQorCQlwcl9pbmZvKCJIV1Agbm90IGVuYWJsZWRcbiIpOwogCX0gZWxzZSB7CisJ
CWlmIChub19sb2FkKQorCQkJcmV0dXJuIC1FTk9ERVY7CisKIAkJaWQgPSB4ODZfbWF0Y2hfY3B1
KGludGVsX3BzdGF0ZV9jcHVfaWRzKTsKIAkJaWYgKCFpZCkgewogCQkJcHJfaW5mbygiQ1BVIG1v
ZGVsIG5vdCBzdXBwb3J0ZWRcbiIpOwpAQCAtMzMxNCwxMCArMzMyMSw5IEBAIHN0YXRpYyBpbnQg
X19pbml0IGludGVsX3BzdGF0ZV9zZXR1cChjaGEKIAllbHNlIGlmICghc3RyY21wKHN0ciwgInBh
c3NpdmUiKSkKIAkJZGVmYXVsdF9kcml2ZXIgPSAmaW50ZWxfY3B1ZnJlcTsKIAotCWlmICghc3Ry
Y21wKHN0ciwgIm5vX2h3cCIpKSB7Ci0JCXByX2luZm8oIkhXUCBkaXNhYmxlZFxuIik7CisJaWYg
KCFzdHJjbXAoc3RyLCAibm9faHdwIikpCiAJCW5vX2h3cCA9IDE7Ci0JfQorCiAJaWYgKCFzdHJj
bXAoc3RyLCAiZm9yY2UiKSkKIAkJZm9yY2VfbG9hZCA9IDE7CiAJaWYgKCFzdHJjbXAoc3RyLCAi
aHdwX29ubHkiKSkK
--0000000000007e802005cba246a4--
