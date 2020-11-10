Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B0D2ADF3B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 20:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgKJTYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 14:24:47 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34336 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgKJTYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 14:24:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id w188so10139598oib.1;
        Tue, 10 Nov 2020 11:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLtE3tMLtSi7n/B5JdK1WUUhcUXhkUtvrXORbwS49TA=;
        b=bgucE2we1Wd5XigjrbxI1U67DgG841AOTkbBDeog4fDS5VbU3i5xp9GjL7VWNYIeyV
         BkzogVGV/3wkJx1ooO7obnMASqcwIPPDF9dov8J7VcV23b8MuOmMkU39SYExd/gcrI2/
         aMca8Y3bwAWrZjbMTFLIzEnXMr4X5AS7jdeaoBW7+z+xbJbkoOfeMuaAfctn1zn+uQBm
         oTnxalpEGmD1afiZsZcjElcLNrwoE1dH6O634wMn5ejyCHvE0bYkH0v6nADryQGAIUIf
         aKdtct+3DfRos/S7NudPgD0Nih9QdRQS5PukwU6bfvMBq55gY1cUNs/J55STvnqWnc0l
         cDtQ==
X-Gm-Message-State: AOAM532qLsWoUUq/TwPd3b4NMvfV90+7f91cmapceelc6CoYcJJFNcKJ
        nPC7QDUDjO9n5KoTcX50onskH3panliRLa/FOvg=
X-Google-Smtp-Source: ABdhPJxdZHo4CBPYqOpn21InSDy8dHnAf5BesVSE5u+A0tvobtpe0S9pEGJFI8Zfpm+iEvQmTMbru4tk6fNYC9qxq0U=
X-Received: by 2002:aca:1c0b:: with SMTP id c11mr421390oic.71.1605036285623;
 Tue, 10 Nov 2020 11:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20201027072358.13725-1-victording@google.com>
In-Reply-To: <20201027072358.13725-1-victording@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 20:24:34 +0100
Message-ID: <CAJZ5v0h8m-rUxqo5hVGDrm+Rm_0nEwN1yQCeKQVE5AbbR2GXFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] powercap: Enable RAPL for AMD Fam17h and Fam19h
To:     Victor Ding <victording@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 8:24 AM Victor Ding <victording@google.com> wrote:
>
> This patch series adds support for AMD Fam17h RAPL counters. As per
> AMD PPR, Fam17h and Fam19h support RAPL counters to monitor power
> usage. The RAPL counter operates as with Intel RAPL. Therefore, it is
> beneficial to re-use existing framework for Intel, especially to
> allow existing tools to seamlessly run on AMD.
>
> From the user's point view, this series enables the following two sysfs
> entry on AMD Fam17h or Fam19h:
>   /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
>   /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj
>
> Changes in v3:
> By Victor Ding <victording@google.com>
>  - Rebased to the latest code.
>  - Created a new rapl_defaults for AMD CPUs.
>  - Removed redundant setting to zeros.
>  - Stopped using the fake power limit domain 1.
>
> Changes in v2:
> By Kim Phillips <kim.phillips@amd.com>
> - Added the Fam19h patch to the end of the series
> - Added my Acked-by
> - Added Daniel Lezcano to Cc
> - (linux-pm was already on Cc)
> - (No code changes)
>
> Kim Phillips (1):
>   powercap: Add AMD Fam19h RAPL support
>
> Victor Ding (3):
>   x86/msr-index: sort AMD RAPL MSRs by address
>   powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
>   powercap: Add AMD Fam17h RAPL support
>
>  arch/x86/include/asm/msr-index.h     |  3 +-
>  drivers/powercap/intel_rapl_common.c |  7 ++++
>  drivers/powercap/intel_rapl_msr.c    | 51 ++++++++++++++++++++--------
>  3 files changed, 45 insertions(+), 16 deletions(-)
>
> --

All patches applied as 5.11 material (which some minor edits in the
changelogs), thanks!
