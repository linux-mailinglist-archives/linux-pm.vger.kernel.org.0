Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B30405BEB
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhIIRXl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 13:23:41 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:41778 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhIIRXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 13:23:41 -0400
Received: by mail-ot1-f51.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso3407067ota.8;
        Thu, 09 Sep 2021 10:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Fx5iAv26f2jc9QufU/pqxgt/pcPtLv+J3rZogchJXY=;
        b=qritL5ikhihmcWS7hcKMQCsSdQQGGvF8wjuMIJFpnrqxbLqJLDxZLb43gS5SAy4j1T
         FbOsUlByJD6Wf9OqvKdis+CVIfwrV7bd7nFS2SwqgF40TdcaffCVxl6+Te/BwsdHXI2E
         nTlAih7izDZtH5DCTnUeo2zxWOgA98raUIDkSp+4HT1HOQBzI7wLfSZN5mPLhVemyfvL
         BBqgKYUJT3mXB2CtAUIXQ7hkF5SW0Y71LLakE/0WrD5QHHjZ9oVvdJBm4vdwhV/RxEQ8
         pqxqJA9aMM2uQdSSG0HtuZxrli5FQfj/1Ub1LIePecbsneo6aFaM89Sn44Q+LlvuT/A9
         3D+g==
X-Gm-Message-State: AOAM532wwOIyMjwBmcLarf/wLHSvn1q6VwSKIpqxbREawty2eliePjPE
        cCjlrmkhZ+ysyveFPSKYxn85+vEipoIM20dxH34=
X-Google-Smtp-Source: ABdhPJzQZBEQP7S5RZx0Q4b7N7BiBUhbxmrCgBjU1n12erZfn8OWOdPumX2019E9flOn5X0bGt97slbFezvgyAR4GM4=
X-Received: by 2002:a9d:6945:: with SMTP id p5mr799989oto.301.1631208151039;
 Thu, 09 Sep 2021 10:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210909034802.1708-1-dsmythies@telus.net> <223a72d91cfda9b13230e4f8cd6a29f853535277.camel@linux.intel.com>
 <CAJZ5v0gn8rpTiVqkXgGqPFDH8-BKTYGiypM-2A2q1jJLm6HbCQ@mail.gmail.com>
 <CAAYoRsWdFwiwo8j2Nc-vhk2mnoZqJC9fyS7URtEz3E1VxfNbLQ@mail.gmail.com> <CAJZ5v0hO7SajJ5HFVDcma6nOfzy-289MdwUSiJbY8Hm3mxvXnQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hO7SajJ5HFVDcma6nOfzy-289MdwUSiJbY8Hm3mxvXnQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Sep 2021 19:22:19 +0200
Message-ID: <CAJZ5v0j1JjLr0co06yJCCNV2p06e91Zh7tkMXoGTE=waB5Xo1Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Override parameters if HWP forced
 by BIOS
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000065d88b05cb933e95"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--00000000000065d88b05cb933e95
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 9, 2021 at 6:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 9, 2021 at 3:20 PM Doug Smythies <dsmythies@telus.net> wrote:
> >
> > On Thu, Sep 9, 2021 at 4:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Sep 9, 2021 at 8:52 AM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >
> > > > On Wed, 2021-09-08 at 20:48 -0700, Doug Smythies wrote:
> > > > > If HWP has been already been enabled by BIOS, it may be
> > > > > necessary to override some kernel command line parameters.
> > > > > Once it has been enabled it requires a reset to be disabled.
> > > > >
> > > > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > > > ---
> > > > >  drivers/cpufreq/intel_pstate.c | 22 ++++++++++++++++------
> > > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > index bb4549959b11..073bae5d4498 100644
> > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > @@ -3267,7 +3267,7 @@ static int __init intel_pstate_init(void)
> > > > >                  */
> > > > >                 if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
> > > > >                     intel_pstate_hwp_is_enabled()) {
> > > > > -                       hwp_active++;
> > > > > +                       hwp_active = 1;
> > > > Why this change?
> > >
> > > I think hwp_active can be changed to bool and then it would make sense
> > > to update this line.
> > >
> > > > >                         hwp_mode_bdw = id->driver_data;
> > > > >                         intel_pstate.attr = hwp_cpufreq_attrs;
> > > > >                         intel_cpufreq.attr = hwp_cpufreq_attrs;
> > > > > @@ -3347,17 +3347,27 @@ device_initcall(intel_pstate_init);
> > > > >
> > > > >  static int __init intel_pstate_setup(char *str)
> > > > >  {
> > > > > +       /*
> > > > > +        * If BIOS is forcing HWP, then parameter
> > > > > +        * overrides might be needed. Only print
> > > > > +        * the message once, and regardless of
> > > > > +        * any overrides.
> > > > > +        */
> > > > > +       if(!hwp_active
> > > > This part of code is from early_param, Is it possible that
> > > > hwp_active is not 0?
> > >
> > > Well, it wouldn't matter even if it were nonzero.  This check is just
> > > pointless anyway.
> > >
> > > > > && boot_cpu_has(X86_FEATURE_HWP))
> > > > > +               if(intel_pstate_hwp_is_enabled()){
> > >
> > > This should be
> > >
> > > if (boot_cpu_has(X86_FEATURE_HWP) && intel_pstate_hwp_is_enabled()) {
> >
> > Disagree.
> > This routine gets executed once per intel_pstate related grub command
> > line entry. The purpose of the "if(!hwp_active" part is to prevent the
> > printing of the message to the logs multiple times.
>
> Ah OK.  Fair enough.
>
> You can do all of the checks in one conditional, though.  They will be
> processed left-to-right anyway.
>
> But then it would be good to avoid calling
> intel_pstate_hwp_is_enabled() multiple times if it returns false.
>
> And having said all that I'm not sure why you are trying to make
> no_hwp depend on !hwp_active?  I will not be taken into account anyway
> if intel_pstate_hwp_is_enabled() returns 'true'?
>
> So if no_hwp is covered regardless, you may move the
> intel_pstate_hwp_is_enabled() inside the no_load conditional.
>
> Alternatively, and I would do that, intel_pstate_hwp_is_enabled()
> could be evaluated earlier in intel_pstate_init() and if it returned
> 'true', both no_load and no_hwp would be disregarded.

Something like the attached, for the record.

--00000000000065d88b05cb933e95
Content-Type: text/x-patch; charset="US-ASCII"; name="intel_pstate-arguments.patch"
Content-Disposition: attachment; filename="intel_pstate-arguments.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ktd76dn70>
X-Attachment-Id: f_ktd76dn70

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgIDE2ICsrKysrKysrKysrLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKSW5k
ZXg6IGxpbnV4LXBtL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYworKysgbGludXgt
cG0vZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCkBAIC0zMjA1LDExICszMjA1LDE1IEBA
IHN0YXRpYyBpbnQgX19pbml0IGludGVsX3BzdGF0ZV9pbml0KHZvaWQKIAlpZiAoYm9vdF9jcHVf
ZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSU5URUwpCiAJCXJldHVybiAtRU5PREVWOwog
Ci0JaWYgKG5vX2xvYWQpCi0JCXJldHVybiAtRU5PREVWOwotCiAJaWQgPSB4ODZfbWF0Y2hfY3B1
KGh3cF9zdXBwb3J0X2lkcyk7CiAJaWYgKGlkKSB7CisJCWJvb2wgaHdwX2ZvcmNlZCA9IGludGVs
X3BzdGF0ZV9od3BfaXNfZW5hYmxlZCgpOworCisJCWlmIChod3BfZm9yY2VkKQorCQkJcHJfaW5m
bygiSFdQIGVuYWJsZWQgYnkgQklPU1xuIik7CisJCWVsc2UgaWYgKG5vX2xvYWQpCisJCQlyZXR1
cm4gLUVOT0RFVjsKKwogCQljb3B5X2NwdV9mdW5jcygmY29yZV9mdW5jcyk7CiAJCS8qCiAJCSAq
IEF2b2lkIGVuYWJsaW5nIEhXUCBmb3IgcHJvY2Vzc29ycyB3aXRob3V0IEVQUCBzdXBwb3J0LApA
QCAtMzIxOSw4ICszMjIzLDcgQEAgc3RhdGljIGludCBfX2luaXQgaW50ZWxfcHN0YXRlX2luaXQo
dm9pZAogCQkgKiBJZiBIV1AgaXMgZW5hYmxlZCBhbHJlYWR5LCB0aG91Z2gsIHRoZXJlIGlzIG5v
IGNob2ljZSBidXQgdG8KIAkJICogZGVhbCB3aXRoIGl0LgogCQkgKi8KLQkJaWYgKCghbm9faHdw
ICYmIGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9IV1BfRVBQKSkgfHwKLQkJICAgIGludGVsX3Bz
dGF0ZV9od3BfaXNfZW5hYmxlZCgpKSB7CisJCWlmICgoIW5vX2h3cCAmJiBib290X2NwdV9oYXMo
WDg2X0ZFQVRVUkVfSFdQX0VQUCkpIHx8IGh3cF9mb3JjZWQpIHsKIAkJCWh3cF9hY3RpdmUrKzsK
IAkJCWh3cF9tb2RlX2JkdyA9IGlkLT5kcml2ZXJfZGF0YTsKIAkJCWludGVsX3BzdGF0ZS5hdHRy
ID0gaHdwX2NwdWZyZXFfYXR0cnM7CkBAIC0zMjM2LDYgKzMyMzksOSBAQCBzdGF0aWMgaW50IF9f
aW5pdCBpbnRlbF9wc3RhdGVfaW5pdCh2b2lkCiAJCQlnb3RvIGh3cF9jcHVfbWF0Y2hlZDsKIAkJ
fQogCX0gZWxzZSB7CisJCWlmIChub19sb2FkKQorCQkJcmV0dXJuIC1FTk9ERVY7CisKIAkJaWQg
PSB4ODZfbWF0Y2hfY3B1KGludGVsX3BzdGF0ZV9jcHVfaWRzKTsKIAkJaWYgKCFpZCkgewogCQkJ
cHJfaW5mbygiQ1BVIG1vZGVsIG5vdCBzdXBwb3J0ZWRcbiIpOwo=
--00000000000065d88b05cb933e95--
