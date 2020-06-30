Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D7C20FBD8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 20:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgF3SgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 14:36:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47015 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgF3SgE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 14:36:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id n24so16993727otr.13;
        Tue, 30 Jun 2020 11:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0w1rUKQgK5a4NrOFjBzuKsJ73al8FDWBmP26SO07LY=;
        b=XyYNd9xsRp/zz4XAzRxOUMojhaKTMMJsGrMD3oRl0lP9vKidIjpwoDc4yLcayLDl3g
         jS23+sCd/R0KUXhq5MEuG58Wa0KqEKkiC4JzfWKohSLD0Gv91VTMByKsB9j0QHrABIDX
         qPGWv45CgO9/x8cX7wRdohTpwauB3YelCVRpuDM1gS+sRcUwyu83xIRlSPAbONpEBHsQ
         skW5zBEQWA2Ufj0u6JBVJ7u4JkIR5L92Xk/MDnyBKb2mN7IvVQIIwr1py8zbrSnllasx
         Fqs48w2aaOgYQpdYBRM7qmOMlWpNI6VozqgyXhT4xNB61tMW23CphhtMboI/LsskvqKJ
         AI1A==
X-Gm-Message-State: AOAM5302iSOLn53CmBMBArQqaQaJsbdGSR3xHivyujLR6mNuR86VXE8q
        VDK8ahwsrf1Htmng3rw6fdPdJtBgS7NR8F0hTK8=
X-Google-Smtp-Source: ABdhPJyfKNR2mAW+ZquuTmcfS4CS0jrfj9YUROqYC4rkoPStrpEF1YJI6C4RI2L3RKrKl8F9E2AWh4t/Pazokt5J/Fg=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr18541238otn.118.1593542163940;
 Tue, 30 Jun 2020 11:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200626183401.1495090-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200626183401.1495090-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 20:35:52 +0200
Message-ID: <CAJZ5v0giN1Jmgdh5q_eiJ60O31c-Ez2EY9WLnmn7Z8f9tQvUWw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] cpufreq: intel_pstate: Support raw epp and energy_efficiency
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 26, 2020 at 8:34 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> v4
> Changes suggested by Borislav
> - msr-index file is sorted for the MSR_IA32_POWER_CTL
> - Remove "_enable" from the new attribute
> - Changes related to documentation
> Changes suggested by Peter
> - Use of kstrtobool
> Suspend/resume restore
>
> v3
> Some edits for the description as suggested by Doug
>
> v2
> Remove raw value support for EPB
>
> Srinivas Pandruvada (2):
>   cpufreq: intel_pstate: Allow enable/disable energy efficiency
>   cpufreq: intel_pstate: Allow raw energy performance preference value
>
>  Documentation/admin-guide/pm/intel_pstate.rst |  17 +-
>  arch/x86/include/asm/msr-index.h              |   6 +-
>  drivers/cpufreq/intel_pstate.c                | 147 ++++++++++++++----
>  3 files changed, 133 insertions(+), 37 deletions(-)
>
> --

Both applied as 5.9 material, thanks!
