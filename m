Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E1C300858
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbhAVQLy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 11:11:54 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:44604 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbhAVQLA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 11:11:00 -0500
Received: by mail-oi1-f175.google.com with SMTP id x137so5261008oix.11;
        Fri, 22 Jan 2021 08:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QJOLWJZmF+NWe59yyneExd/euMLwMsHwRJgWMafHFM=;
        b=DkPxlrvgQIVFgxggGFDhoozd32azQr3rc6AcrGtjefcFpyLipJbcl9zQ9FMh9lQF7p
         DCkix/xiUTbr0N8pq6QlkX1bm1AcQEQ5Ewe+M8mfCRz32dC12El0yZy9Y6cn82Eav9qu
         w6QAK94vNeU4MJFM7KT7QFfNJuwsmSuMZfrBIz8z42jKkk74HLlGT4ijQsq5qHr8IMxx
         rntqUI5qLrbBYFHLewTReLgbR0ldyPXf4qzO+mOq7Hed7axe74umT9P3oqJrvHV65UHV
         VCO24MhcKb/XFF1LGKh75QbLcCLu6DnfQeyR16ieqsQlY66c6Px27Lum0k1wlqlTVPBC
         uZyw==
X-Gm-Message-State: AOAM532r+2vQdfRyfAgZCQYid8C+QsSTDLV0zcw6US38/G73+KtEwz9d
        qiAJVoyDLBJMs4Ea6lWz5BebsXHlBIA9dFSFdkc=
X-Google-Smtp-Source: ABdhPJxLY5PerPLcwqA+39SgSd1WtO2QsOPj1ChUZwmItWePbMy79hWTWs5EsUq7wotD9dbPPmm4Cc+wW2qA3rtpYCU=
X-Received: by 2002:aca:308a:: with SMTP id w132mr3586396oiw.69.1611331818926;
 Fri, 22 Jan 2021 08:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20210120155042.28975-1-ilina@codeaurora.org>
In-Reply-To: <20210120155042.28975-1-ilina@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 17:10:07 +0100
Message-ID: <CAJZ5v0i88KBG6fUGWhwE_AYnPeqN_1BtHnsWFPScjn25JuV4CQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Better domain idle from device wakeup patterns
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 20, 2021 at 4:53 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> Changes since v8 [8]:
> - Check if device is attached to genpd
>
> Changes since v7 [7]:
> - Whitespace and comment fixes
> - Add Reviewed-by tags
>
> Changes since v6 [6];
> - Based on discussions on [6], this update simplifies the next wakeup
>   of domains based on genpd flag GENPD_FLAG_MIN_RESIDENCY specified at
>   init.
> - Assume next wakeup will be set by devices when the domain is not
>   powered down. This could avoid locking requirements.
> - Update commit text.
>
> Changes since v5 [5]:
> - It was pointed out that we don't want to run through the unnecessary
>   work for domains that do not need or support next-wakeup. So, patch #1
>   in this version, now uses a flag to detemine if the domain would
>   support next-wakeup.
> - Other review comments addressed in patches #2, #3
>
> Changes since v4 [4]:
> - Address review comments
>
> Changes since v3 [3]:
> - Move the next_wakeup info of the device deeper into the device's
>   domain data. This should avoid overhead for devices that do not have a
>   predictable wakeup pattern.
>
> Changes since v2:
> - Fix unwanted change
>
> Changes since v1 [2]:
> - Update documentation and commit text
> - Remove check for runtime PM when setting next_event
> - Fix kernel-test robot reported issue
>
> Changes since RFC [1]:
> - Organized the code to make it cleaner
> - Fixed some issues with idle state determination
> - Add documentation and update commit text
>
> Hello,
>
> I was looking for an option to do better power management for some
> domains where the devices enter runtime PM in a predictable fashion. For
> example a display device that sends a vsync interrupt every 16 ms for a
> 60 Hz panel. These interrupts are not timer interrupts but tend to
> interrupt periodically to service the workflow and the devices and
> domains may go back to idle soon after. Two domains are affected by this
> - the device's PM domain and the CPU PM domain.
>
> As a first step, I am looking to solve for the device's PM domain idle
> state (and hopefully solve for the CPU PM domains subsequently). The PM
> domain could have multiple idle states and/or the enter/exit latencies
> could be high. In either case, it may not always be beneficial to power
> off the domain, only to turn it back on before satisfying the idle state
> residency. When the wakeup is known for the device, we could use that to
> determine the worthiness of entering a domain idle state. Only the
> device can tell us when the future event would be and that could change
> as the usecase changes. Like, when the panel refresh rate increases to
> 120 Hz. If this information was made available to runtime PM, we could
> use that in the domain governor to determine a suitable idle state. This
> is the idea behind these patches.
>
> Would appreciate your thoughts on this.
>
> Thanks,
> Lina
>
> [1].
> https://lore.kernel.org/linux-pm/010101746eccb270-05beb27f-e1e4-40eb-92da-ad1bb48feb41-000000@us-west-2.amazonses.com/T
> /
> [2]. https://lore.kernel.org/linux-pm/20201012223400.23609-3-ilina@codeaurora.org/T/#u
> [3]. https://lore.kernel.org/linux-pm/20201015193807.17423-1-ilina@codeaurora.org/
> [4]. https://www.spinics.net/lists/linux-arm-msm/msg74322.html
> [5]. https://lore.kernel.org/linux-pm/20201106164811.3698-1-ilina@codeaurora.org/T/#t
> [6]. https://lore.kernel.org/linux-pm/20201130225039.15981-1-ilina@codeaurora.org/T/#t
> [7]. https://lore.kernel.org/linux-pm/20210113201601.14874-1-ilina@codeaurora.org/T/#t
> [8]. https://lore.kernel.org/linux-pm/20210115165004.22385-1-ilina@codeaurora.org/T/#t
>
>
> Lina Iyer (2):
>   PM / domains: inform PM domain of a device's next wakeup
>   PM / Domains: use device's next wakeup to determine domain idle state
>
>  drivers/base/power/domain.c          |  30 ++++++++
>  drivers/base/power/domain_governor.c | 102 ++++++++++++++++++++++++---
>  include/linux/pm_domain.h            |  12 ++++
>  3 files changed, 135 insertions(+), 9 deletions(-)
>
> --

Both patches applied as 5.12 material, thanks!
