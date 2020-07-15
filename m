Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7C220E0C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbgGONYJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 09:24:09 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:35394 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbgGONYI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 09:24:08 -0400
Received: by mail-oo1-f65.google.com with SMTP id w1so457900ooj.2;
        Wed, 15 Jul 2020 06:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybTRMRwTXg8GftT6GqtnDN/MiNSxSxn6EjDTyKGp5Qk=;
        b=j9DyxIOxG7B7a8H7FBQ/VbVPWsPA3d+bE/nAUMv3sjVGijrnOrpul8BoA0Xl6WdZJw
         Cfn/58PQytWwq6oC3TZpE2EYj8xBQ4mrzM3UIvJC+iU86Mhjs96Q5pk960HzFVZgLhT5
         I3Ff5iC49c6BOKcBEDyWx5pygZPCAlTHPmD40NMhxRdVEboLtytoym/uxWJvicrsNUV9
         j9NL/wgO14tZxnj5iArdsIVkA/DOiMUVMSH4FjjBe9kAfF1hyZcEDjgpnxXJmAH+zP7+
         TbkubSsrY2WR9tQp19XVrqIEuyvhGN3JwwKuglk6nLISKgaW0H9D8MEzbH0CQtHAsN68
         iJqw==
X-Gm-Message-State: AOAM532pzmwJMyRlIh00HneA/eg5Pc9pb3yp2vJaXd2RkSnQkRlXrBad
        m5ZpoYS86p5J3WwCSJyf5/Ptdo+vJP6HpVB5Bd0=
X-Google-Smtp-Source: ABdhPJxMCfbP+2jw0s4zpYMWrMAbGRmywLWYB0Np/Uh44G/h6/hOUJM7OZKrC4qaIHoEibMSyvOp3EYnmEaG8iTzlPA=
X-Received: by 2002:a4a:2459:: with SMTP id v25mr9382879oov.75.1594819447535;
 Wed, 15 Jul 2020 06:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200715082634.3024816-1-lee.jones@linaro.org>
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 15:23:56 +0200
Message-ID: <CAJZ5v0jra1Q=L9H-9jJTFERbwSt5t4iF=vmtv9_01roa6bPB3A@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Rid W=1 warnings in CPUFreq
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 10:27 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
>
> After these patches are applied, the build system no longer
> complains about any W=0 nor W=1 level warnings in drivers/cpufreq.
>
> Hurrah!
>
> Changelog
>
> v1 => v2:
>  - Collect *-bys
>  - Use __maybe_unused instead of removing device IDs
>  - Use __always_unused instead of using unused variables
>  - Include architecture header instead of creating new include file
>
> Lee Jones (13):
>   cpufreq: freq_table: Demote obvious misuse of kerneldoc to standard
>     comment blocks
>   cpufreq: cpufreq: Demote lots of function headers unworthy of
>     kerneldoc status
>   cpufreq: cpufreq_governor: Demote store_sampling_rate() header to
>     standard comment block
>   cpufreq: sti-cpufreq: Fix some formatting and misspelling issues
>   cpufreq: pasemi: Include header file for {check,restore}_astate
>     prototypes
>   cpufreq: powernv-cpufreq: Functions only used in call-backs should be
>     static
>   cpufreq: powernv-cpufreq: Fix a bunch of kerneldoc related issues
>   cpufreq: acpi-cpufreq: Mark 'dummy' variable as __always_unused
>   cpufreq: acpi-cpufreq: Mark sometimes used ID structs as
>     __maybe_unused
>   cpufreq: powernow-k8: Mark 'hi' and 'lo' dummy variables as
>     __always_unused
>   cpufreq: pcc-cpufreq: Mark sometimes used ID structs as __maybe_unused
>   cpufreq: intel_pstate: Supply struct attribute description for
>     get_aperf_mperf_shift()
>   cpufreq: amd_freq_sensitivity: Mark sometimes used ID structs as
>     __maybe_unused
>
>  drivers/cpufreq/acpi-cpufreq.c         |  8 +++----
>  drivers/cpufreq/amd_freq_sensitivity.c |  2 +-
>  drivers/cpufreq/cpufreq.c              | 32 ++++++++++++++------------
>  drivers/cpufreq/cpufreq_governor.c     |  2 +-
>  drivers/cpufreq/freq_table.c           |  6 ++---
>  drivers/cpufreq/intel_pstate.c         |  2 ++
>  drivers/cpufreq/pasemi-cpufreq.c       |  2 ++
>  drivers/cpufreq/pcc-cpufreq.c          |  2 +-
>  drivers/cpufreq/powernow-k8.c          |  4 ++--
>  drivers/cpufreq/powernv-cpufreq.c      | 15 ++++++------
>  drivers/cpufreq/sti-cpufreq.c          |  8 +++----
>  11 files changed, 45 insertions(+), 38 deletions(-)
>
> --

All patches except for the [04/13] (applied by Viresh) and [06/13]
(requested to be ignored) applied as 5.9 material with the ACKs from
Viresh, thanks!
