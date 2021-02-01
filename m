Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECE230B01F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 20:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhBATMH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 14:12:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:26204 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232026AbhBATMG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Feb 2021 14:12:06 -0500
IronPort-SDR: gNOsHG34c3TiXeO2HT4H0WC9Z7G7Uh11UxqvWD7jEYTsffs57u1nVEhnlvmVS1tethSiRAsqKk
 hG5G7w9TEY2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180814809"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="180814809"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 11:10:19 -0800
IronPort-SDR: eENvFbI8VPGXGsUKVdHJA5wLBm2+s23n394IlK811aXDid5Xq4X3wP6eY4FJcCpTtshNAO9R9f
 zpRMTVB7JAFw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="479203639"
Received: from spandruv-mobl.amr.corp.intel.com ([10.209.6.188])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 11:10:19 -0800
Message-ID: <e78dac06f056231ab7e9b4295e77f8fb146eb587.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/2] Move ...mce/therm_throt.c to drivers/thermal/
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tony Luck <tony.luck@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Date:   Mon, 01 Feb 2021 11:10:18 -0800
In-Reply-To: <20210201142704.12495-1-bp@alien8.de>
References: <20210201142704.12495-1-bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-02-01 at 15:27 +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi,
> 
> I know I already committed those but
> 
> https://lkml.kernel.org/r/20210201032427.GB12524@xsang-OptiPlex-9020
> 
> made me look at the IRQ handler registration. And it does happen per
> CPU
> which is particularly daft and unneeded. And it used to do that
> before
> that change too, for some unknown reason.
> 
> So I decided to not have a handler registration but simply call the
> thermal interrupt handler if all is setup and before that issue the
> message about the unexpected IRQ.
> 
> I did test it by sending bogus thermal interrupts before and after
> registration - see hunk below - and it looks good:
> 
> [    0.136608] 0: Sending thermal IRQ
> [    0.136760] CPU0: Unexpected LVT thermal interrupt!
> [    0.136917] CPU0: Thermal monitoring enabled (TM1)
> [    0.137071] 1: Sending thermal IRQ
> [    0.043243] 0: Sending thermal IRQ
> [    0.043243] 1: Sending thermal IRQ
> [    0.043243] 0: Sending thermal IRQ
> [    0.043243] 1: Sending thermal IRQ
> [    0.043243] 0: Sending thermal IRQ
> [    0.043243] 1: Sending thermal IRQ
> [    0.043243] 0: Sending thermal IRQ
> [    0.043243] 1: Sending thermal IRQ
> [    0.043243] 0: Sending thermal IRQ
> [    0.043243] 1: Sending thermal IRQ
> [    0.149436] thermal_sys: Registered thermal governor 'fair_share'
> [    0.149437] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.149595] thermal_sys: Registered thermal governor 'step_wise'
> [    0.149753] thermal_sys: Registered thermal governor 'user_space'
> [    0.445717] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
> [    0.707539] thermal LNXTHERM:00: registered as thermal_zone0
> 
> Logic in patch 1 got a bit simplified too.
> 
[...]

> 
> Borislav Petkov (2):
>   x86/mce: Get rid of mcheck_intel_therm_init()
>   thermal: Move therm_throt there from x86/mce
> 

I have applied this series and tested. Didn't find any functional
issues. But I have one comment on patch 2/2.

Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas

>  arch/x86/Kconfig                              |  4 --
>  arch/x86/include/asm/mce.h                    | 22 ----------
>  arch/x86/include/asm/thermal.h                | 24 +++++++++++
>  arch/x86/kernel/cpu/intel.c                   |  3 ++
>  arch/x86/kernel/cpu/mce/Makefile              |  2 -
>  arch/x86/kernel/cpu/mce/core.c                |  1 -
>  arch/x86/kernel/cpu/mce/intel.c               |  1 -
>  arch/x86/kernel/irq.c                         | 21 ++++++++++
>  drivers/thermal/intel/Kconfig                 |  4 ++
>  drivers/thermal/intel/Makefile                |  1 +
>  .../thermal/intel}/therm_throt.c              | 41 ++++-------------
> --
>  drivers/thermal/intel/x86_pkg_temp_thermal.c  |  3 +-
>  12 files changed, 64 insertions(+), 63 deletions(-)
>  create mode 100644 arch/x86/include/asm/thermal.h
>  rename {arch/x86/kernel/cpu/mce =>
> drivers/thermal/intel}/therm_throt.c (96%)
> 
> 2nd:rc6-therm_throt
> 

