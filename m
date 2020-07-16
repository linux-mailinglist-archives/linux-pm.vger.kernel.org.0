Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FAB22222F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGPMHq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 08:07:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45954 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgGPMHp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 08:07:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id h1so3971271otq.12;
        Thu, 16 Jul 2020 05:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUk4uPpwTSITCEjYChNTScClwFq4uq08tlJDRMfMUmU=;
        b=SL2I7pg1TZc9/YHL6wz1AWyvXdZGr5Z2twIjUEOBv3Zoptt1PEQwDUJsVrTk5sfZhH
         m47/EbxUlYY8eNiMfbccthTU20b4zpVDoCc+EetQbPW2SJt3Bagq+8Lb7/F0QKyABeRY
         C0I/1auhrVcUfpizva/2/tUjiss1cfyN/IZEFmRFEARqynNjRY9ncqu66XTv3p+a/RWY
         KMEN5wXcb/pbKhzm8WWZRp6SxtVhbbPNmYhOxDKNFm0GYu7Ye/OcesYrV7x6+VoHdJvZ
         NBP7LEXrAgrKCbxcyfmVZG4ZzoZyesO3rgXsact3tsokx5Z7NDU3tVXGV5Cgs3hbRSgR
         RIUQ==
X-Gm-Message-State: AOAM531eZawOwvc3VBdmw4PBaN8vOEsgYzmMW1G6932IBZg75KBL16qo
        H0CTOmqWlUcs6TE73O18lPy+qzqZmP4X9Hgy+wQ=
X-Google-Smtp-Source: ABdhPJzEJ56GsxoaS/HFvPdr7vkxYUCTd5QUGIeBz9A3WjnvyouFsd0dwP1GnLMjUnT6StsuZqX5NPiMkM4RbdpJks8=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr3934854ota.167.1594901264631;
 Thu, 16 Jul 2020 05:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <3955470.QvD6XneCf3@kreacher> <000f01d65ae8$0c607990$25216cb0$@net>
In-Reply-To: <000f01d65ae8$0c607990$25216cb0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jul 2020 14:07:30 +0200
Message-ID: <CAJZ5v0jGbfqfqqoPLjneFD5HLb20Yv9p25juNTzaumL70iFogg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Francisco Jerez <francisco.jerez.plata@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 10:39 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2020.07.14 11:16 Rafael J. Wysocki wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ...
> > Since the passive mode hasn't worked with HWP at all, and it is not going to
> > the default for HWP systems anyway, I don't see any drawbacks related to making
> > this change, so I would consider this as 5.9 material unless there are any
> > serious objections.
>
> Good point.
> Some of the tests I do involve labour intensive post processing of data.
> I want to automate some of that work, and it will take time.
> We might be into the 5.9-rc series before I have detailed feedback.
>
> However, so far:
>
> Inverse impulse response test [1]:
>
> High level test, i5-9600K, HWP-passive (this patch), ondemand:
> 3101 tests. 0 failures. (GOOD)
>
> From [1], re-stated:
> > . High level: i5-9600K: 2453 tests, 60 failures, 2.45% fail rate. (HWP-active - powersave)
> > . Verify acpi-cpufreq/ondemand works fine: i5-9600K: 8975 tests. 0 failures.
>
> My version of that cool Alexander named pipe test [2] serialized workflow:
>
> HWP-passive (this patch), performance: PASS.
>
> From [2], re-stated, and also re-tested.
> HWP-disabled passive - performance: FAIL.

But I'm not quite sure how this is related to this patch?

This test would still fail without the patch if the kernel was started
with intel_pstate=passive in the kernel command line, wouldn't it.

> Although, I believe the issue to be EPB management, [3].

Well, that's kind of unexpected.

If this really is the case, then it looks like the effect of the EPB
setting on the processor is different depending on whether or not HWP
is enabled.

> And yes, I did see the reply to [3] that came earlier,
> And have now re-done the test, with the referenced patch added.
> It still is FAIL. I reply to the [3] thread, eventually.
>
> [1] https://marc.info/?l=linux-pm&m=159354421400342&w=2
> [2] https://marc.info/?l=linux-pm&m=159155067328641&w=2
> [3] https://marc.info/?l=linux-pm&m=159438804230744&w=2
>
> Kernel:
>
> b08284a541ad (HEAD -> k58rc5-doug) cpufreq: intel_pstate: Avoid enabling HWP if EPP is not supported
> 063fd7ccabfe cpufreq: intel_pstate: Implement passive mode with HWP enabled
> 730ccf5054e9 cpufreq: intel_pstate: Allow raw energy performance preference value
> bee36df01c68 cpufreq: intel_pstate: Allow enable/disable energy efficiency
> 199629d8200e cpufreq: intel_pstate: Fix active mode setting from command line
> 11ba468877bb (tag: v5.8-rc5, origin/master, origin/HEAD, master) Linux 5.8-rc5
>
> Rules for this work:
>
> . never use x86_energy_perf_policy.
> . For HWP disabled: never change from active to passive or via versa, but rather do it via boot.
> . after boot always check and reset the various power limit log bits that are set.
> . never compile the kernel (well, until after any tests), which will set those bits again.
> . never run prime95 high heat torture test, which will set those bits again.
> . try to never do anything else that will set those bits again.
>
> To be clear, I do allow changing governors within the context of the above rules.

Thanks for the feedback!
