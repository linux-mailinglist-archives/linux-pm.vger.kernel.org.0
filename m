Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF82C43E914
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 21:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJ1TvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 15:51:02 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40785 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJ1TvB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 15:51:01 -0400
Received: by mail-oi1-f177.google.com with SMTP id n63so9886231oif.7;
        Thu, 28 Oct 2021 12:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jL3KygXczyJryGgW69jy+kYNirV804Kzp5AvvlfePI=;
        b=JwRizuYQoyj83ZLrO5dvs2lDI+TMCKLHlKKMKya6uViAZ05xVfcHvhwBOBIeK7r+UY
         B5A5ed+9CTAWUItliJqKhrtstg7SLv1B8KgKthyvklFIfoH91tcXkqUd2RDokb+xeUWo
         1vG/drO2UWUJtMAiz3TM17e8R1mmQNfNpThycnMcP7hCBNykTWgxDsyigLz67glAHXns
         CuoTlBae1mDiMNNaNAOG/BAtv99ZsQWLP66YrbhubYpCw8azCnJgHMwjCJFzK8De9170
         +qCzVbk4RQPuggLuYGvXKotvDCw6YdRAuuwkFLalMCUIA2eNuyXPZAwAL8As0glKIFtQ
         WSqg==
X-Gm-Message-State: AOAM531t93BhImaJErvwFokvtpv7MgsWp+CPErtqWKVeAsRVG9kh357m
        tJyD1Zm6h95k/0HvmbckBb9EOoCm5wu+h7js7Ro=
X-Google-Smtp-Source: ABdhPJxw4UDGyCmyT2w9h9jLlzVxWKsSF+Lacs9/EXu4s7i1IutjPu8yP9l9sVtIgO0WTNVDEgzP2XU81tIBtuERAaA=
X-Received: by 2002:a05:6808:1286:: with SMTP id a6mr10331807oiw.51.1635450512578;
 Thu, 28 Oct 2021 12:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
 <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
 <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110281908150.9518@hadrien> <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com>
 <CAJZ5v0ij105B05xPGgfauwFv1KhXRnwh5p28R1y11qKWjxUOhg@mail.gmail.com>
 <CAJZ5v0gAax-uz+shKv4MNBiSBPKGroQGNKdYyUK4v6sRS15o_w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110282112060.9518@hadrien> <CAJZ5v0jmQgg_DwqSdFsoMd5qV_ZH=cHUJtb372mqv=GSWioRgw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110282124201.9518@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110282124201.9518@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Oct 2021 21:48:21 +0200
Message-ID: <CAJZ5v0j9fJi+Fa1404uH3V2XJUrVB5crEjcZ9tsnBtQWgCCu4w@mail.gmail.com>
Subject: Re: problem in changing from active to passive mode
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d9bcda05cf6efe4b"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--000000000000d9bcda05cf6efe4b
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 28, 2021 at 9:25 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 28 Oct 2021, Rafael J. Wysocki wrote:
>
> > On Thu, Oct 28, 2021 at 9:13 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > >
> > >
> > > On Thu, 28 Oct 2021, Rafael J. Wysocki wrote:
> > >
> > > > On Thu, Oct 28, 2021 at 7:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Oct 28, 2021 at 7:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Oct 28, 2021 at 7:10 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > > > >
> > > > > > > > Now, for your graph 3, are you saying this pseudo
> > > > > > > > code of the process is repeatable?:
> > > > > > > >
> > > > > > > > Power up the system, booting kernel 5.9
> > > > > > > > switch to passive/schedutil.
> > > > > > > > wait X minutes for system to settle
> > > > > > > > do benchmark, result ~13 seconds
> > > > > > > > re-boot to kernel 5.15-RC
> > > > > > > > switch to passive/schedutil.
> > > > > > > > wait X minutes for system to settle
> > > > > > > > do benchmark, result ~40 seconds
> > > > > > > > re-boot to kernel 5.9
> > > > > > > > switch to passive/schedutil.
> > > > > > > > wait X minutes for system to settle
> > > > > > > > do benchmark, result ~28 seconds
> > > > > > >
> > > > > > > In the first boot of 5.9, the des (desired?) field of the HWP_REQUEST
> > > > > > > register is 0 and in the second boot (after booting 5.15 and entering
> > > > > > > passive mode) it is 10.  I don't know though if this is a bug or a
> > > > > > > feature...
> > > > > >
> > > > > > It looks like a bug.
> > > > > >
> > > > > > I think that the desired value is not cleared on driver exit which
> > > > > > should happen.  Let me see if I can do a quick patch for that.
> > > > >
> > > > > Please check the behavior with the attached patch applied.
> > > >
> > > > Well, actually, the previous one won't do anything, because the
> > > > desired perf field is already cleared in this function before writing
> > > > the MSR, so please try the one attached to this message instead.
> > > >
> > >
> > > Turbostat still shows 10:
> > >
> > > cpu0: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> > > cpu0: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> > > cpu0: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> > > cpu0: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> > > cpu1: MSR_PM_ENABLE: 0x00000001 (HWP)
> > > cpu1: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> > > cpu1: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> > > cpu1: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> > > cpu1: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> > > cpu2: MSR_PM_ENABLE: 0x00000001 (HWP)
> > > cpu2: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> > > cpu2: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> > > cpu2: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> > > cpu2: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> > > cpu3: MSR_PM_ENABLE: 0x00000001 (HWP)
> > > cpu3: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> > > cpu3: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> > > cpu3: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> > > cpu3: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> >
> > Hmmm.
> >
> > Is this also the case if you go from "passive" to "active" on 5.15-rc
> > w/ the patch applied?
>
> Sorry, I was wrong.  If I am in 5.15 and go from passive to active, the
> des field indeed returns to 0.  If I use kexec

Well, this means that the cpufreq driver cleanup is not carried out in
the kexec path and the old desired value remains in the register.

> to reboot from 5.15 passive into 5.9, then the des field remains 10.

It looks like desired perf needs to be cleared explicitly in the active mode.

Attached is a patch to do that, but please note that the 5.9 will need
to be patched too to address this issue.

--000000000000d9bcda05cf6efe4b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="intel_pstate-clear-desired-in-active.patch"
Content-Disposition: attachment; 
	filename="intel_pstate-clear-desired-in-active.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvbcy66x0>
X-Attachment-Id: f_kvbcy66x0

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgICAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpJbmRleDogbGludXgtcG0vZHJpdmVycy9jcHVmcmVxL2lu
dGVsX3BzdGF0ZS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9jcHVmcmVx
L2ludGVsX3BzdGF0ZS5jCisrKyBsaW51eC1wbS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRl
LmMKQEAgLTk0Niw2ICs5NDYsOCBAQCBzdGF0aWMgdm9pZCBpbnRlbF9wc3RhdGVfaHdwX3NldCh1
bnNpZ25lCiAJdmFsdWUgJj0gfkhXUF9NQVhfUEVSRih+MEwpOwogCXZhbHVlIHw9IEhXUF9NQVhf
UEVSRihtYXgpOwogCisJdmFsdWUgJj0gfkhXUF9ERVNJUkVEX1BFUkYofjBMKTsKKwogCWlmIChj
cHVfZGF0YS0+ZXBwX3BvbGljeSA9PSBjcHVfZGF0YS0+cG9saWN5KQogCQlnb3RvIHNraXBfZXBw
OwogCg==
--000000000000d9bcda05cf6efe4b--
