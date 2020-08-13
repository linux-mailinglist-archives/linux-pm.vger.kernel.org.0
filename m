Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31615244109
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 00:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMWEU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 18:04:20 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:43041 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMWEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 18:04:20 -0400
Received: by mail-ed1-f43.google.com with SMTP id cq28so5369680edb.10
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2020 15:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/i8MsgTmaf+IVoBlCzLbVqj4FaG8V0w7sz1cnyaA3lU=;
        b=Y2OkFah9GK2J1dS89w3I4Y3+sAZ7oNH51nCFtgrBpGynUj/Ridp+5qZj3vNOUrx3CJ
         yjSg92EuD6kCcCOKC8NLkRptYl+S6GOhrU3FjxrLmbLBtwpEIjpTC0yE/yGDmKQgct2Y
         ohqfGYb5ib+z0FMSx/qpqmkTem8WfCdVYHWaRIyrA7Vq8OZKQtpbCaNBZPPHp0ECGXP6
         wsvf319He/UKev/8fNPCm2ZJ2pjX31GJwHx36vi3neF5yaGRWOw/vZIWat4PkURbA10q
         bvzfQ6CW2EoDcy6EA/xVmcz0nmHMcX0p0GGAb2bk3OGdts9nwGL346CZqPTdkIz/rFfQ
         nWBQ==
X-Gm-Message-State: AOAM533Iibx7IiTCENhcZO3RQcAMnPk8trudRTEIag6H2Rd4xyirAJLF
        U+rEN/EdZCX6ACAI37oHBU08Saz/XIk5KmQkVHCNuljB
X-Google-Smtp-Source: ABdhPJzy9LBCioQMKRZZIEt50SNP9jt8MLVW31C6h8euhHWPDd8BqbyG/LHllb1CZR8+NKytAtQtiZSD8fpj40Su95I=
X-Received: by 2002:a50:af86:: with SMTP id h6mr6893895edd.132.1597356257418;
 Thu, 13 Aug 2020 15:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <000701d643f0$fa0f3140$ee2d93c0$@net> <000101d64b05$2ac63200$80529600$@net>
In-Reply-To: <000101d64b05$2ac63200$80529600$@net>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 13 Aug 2020 18:04:06 -0400
Message-ID: <CAJvTdKnL774iVGtUwdOu5XP5ngeynrQU57qBWoxAH59XwpCXVg@mail.gmail.com>
Subject: Re: x86_energy_perf_policy
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,
the purpose of that capability was to have the ability to enable HWP
on a legacy kernel that didn't know how to.

i agree, in this day, it is misleading.

-Len

On Thu, Jun 25, 2020 at 11:27 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Len,
>
> When I look at the dates for patches,
> I do not think that
>
> tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
>
> even knows about intel_cpufreq (intel_pstate in passive mode).
> Anyway this tool is now banned from my computers.
>
> I'll re-phrase my previous e-mail, in a much more blunt way:
>
> tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
>
> should be fixed or removed.
>
> ... Doug
>
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-owner@vger.kernel.org] On Behalf Of Doug
> > Smythies
> > Sent: June 16, 2020 8:15 AM
> > To: 'Len Brown'
> > Cc: 'Srinivas Pandruvada'; 'Linux PM'
> > Subject: x86_energy_perf_policy
> >
> > Hi Len,
> >
> > I have been using x86_energy_perf_policy to manage EPB while I do some tests.
> > I noticed it says this:
> >
> > "HWP can be enabled using '--hwp-enable'"
> >
> > So, I thought great, I can now in one boot do:
> >
> > intel_pstate, no-HWP, performance/powersave.
> > intel_cpufreq, no-HWP, all governors
> >
> > run: x86_energy_perf_policy --hwp-enable
> >
> > then repeat the above, but only passive, if trying some of Rafael's RFC stuff,
> > which is NOT part of this e-mail.
> >
> > However, enabling HWP via this method leaves my system in an unusable state.
> >
> > Please confirm or deny if I am supposed to be able to enable HWP via
> > x86_energy_perf_policy?
> >
> > No need to read on:
> >
> > Examples (kernel 5.8=rc1):
> >
> > Note: I wrote my own MSR decoder. I know I could use turbostat, and do
> > have it running virtually 100% of the time. However, writing my own
> > decoder forced me to learn more.
> >
> > Fresh boot (no=hwp forced):
> >
> > root@s18:/home/doug# /home/doug/c/msr-decoder
> > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8 :   8 :   8 :
> > B.) 0x770: IA32_PM_ENABLE: 0 : HWP disable
> > 9.) 0x199: IA32_PERF_CTL        : CPU 0-5 :   9 :   8 :   8 :   8 :  19 :  26 :
> > C.) 0x1B0: IA32_ENERGY_PERF_BIAS: CPU 0-5 :   6 :   6 :   6 :   6 :   6 :   6 :
> > 1.) 0x19C: IA32_THERM_STATUS: 88480000
> > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18
> > reset
> > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88470000
> > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
> >
> > Now,
> >
> > # x86_energy_perf_policy --hwp-enable
> >
> > root@s18:/home/doug# /home/doug/c/msr-decoder
> > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8 :   8 :   8 :
> > B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> > 1.) 0x19C: IA32_THERM_STATUS: 88480000
> > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18
> > reset
> > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88460000
> > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
> > 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 :
> > lowest 1
> > 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
> >     raw: 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 :
> >     min:        1 :        1 :        1 :        1 :        1 :        1 :
> >     max:      255 :      255 :      255 :      255 :      255 :      255 :
> >     des:        0 :        0 :        0 :        0 :        0 :        0 :
> >     epp:      128 :      128 :      128 :      128 :      128 :      128 :
> >     act:        0 :        0 :        0 :        0 :        0 :        0 :
> > 7.) 0x777: IA32_HWP_STATUS: 0 : high 0 : guaranteed 0 : efficient 0 : lowest 0
> >
> > Notice that EPP is 128, and I can not achieve full CPU speed for a workflow that should.
> > Ok. So maybe I just need to toggle between performance and powersave and back. No difference.
> > I tried many variations. There are many situations where the misbehaves.
> >
> > If I boot with HWP enabled, I can observe EPP (and min and max) behave as expected
> > and as a function of the governor. The system seems to behave.
> >
> > intel_pstate / powersave:
> >
> > root@s18:/home/doug# /home/doug/c/msr-decoder
> > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8 :   8 :   8 :
> > B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> > 1.) 0x19C: IA32_THERM_STATUS: 88480800 PWL
> > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18
> > reset
> > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88470800 PWL
> > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 4000000 PL1L
> > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
> > 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 :
> > lowest 1
> > 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
> >     raw: 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 :
> >     min:        8 :        8 :        8 :        8 :        8 :        8 :
> >     max:       46 :       46 :       46 :       46 :       46 :       46 :
> >     des:        0 :        0 :        0 :        0 :        0 :        0 :
> >     epp:      128 :      128 :      128 :      128 :      128 :      128 :
> >     act:        0 :        0 :        0 :        0 :        0 :        0 :
> > 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0
> >
> > intel_pstate / performance:
> >
> > root@s18:/home/doug# /home/doug/c/msr-decoder
> > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
> > B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> > 1.) 0x19C: IA32_THERM_STATUS: 88470800 PWL
> > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18
> > reset
> > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88460800 PWL
> > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 4000000 PL1L
> > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
> > 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 :
> > lowest 1
> > 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
> >     raw: 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E :
> >     min:       46 :       46 :       46 :       46 :       46 :       46 :
> >     max:       46 :       46 :       46 :       46 :       46 :       46 :
> >     des:        0 :        0 :        0 :        0 :        0 :        0 :
> >     epp:        0 :        0 :        0 :        0 :        0 :        0 :
> >     act:        0 :        0 :        0 :        0 :        0 :        0 :
> > 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0
> >
> > ... Doug
>
>


-- 
Len Brown, Intel Open Source Technology Center
