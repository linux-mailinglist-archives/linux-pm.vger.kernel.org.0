Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E62C08CC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 14:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbgKWNAk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 08:00:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39739 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgKWM6r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 07:58:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id z24so1759647oto.6
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 04:58:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Z2UlzuWnATeTs8zM6lq9gr/RjBmBr1rvvGiLm0Ff2Y=;
        b=q63ZVY2UYCgB6kk1i784Kr+ZYAPFQzIvI6A62yvRWxJ4bujX6Cm3tP+1WCtpNyRB2e
         m2yatYknPVos6KHVXNfxmX7JefwHx4L1+7I9sClepiyYYyrfLT0S0srNqwm7rdMH305Q
         hNyjbBMtGdri4fQrnUrmhNnwa8Ikn/BYy3eupyR7RH1Bcb0m90hnAk/ugiqQMbkatdd5
         Ec6t22O1IfDaRC2GSemV6VS/+QuIeiAU7fICx1HOUwQM0SgGFPJbETffHUYvBZh7qBtP
         hfEFCsjmsww/g6k5v8maofrw9E0nGktc9sa2grqpyQyL5K2ZYLWViw2KjubogAR92D+a
         YPfg==
X-Gm-Message-State: AOAM530ruNQ/cp7poRDFzT7uhAK8O+8PyoCa1p7P67OrqRHMu/RZMnI/
        3BsBcjxIUI2IBP/lIXaZC00LE9njOxPyN9KIfFlsxqac
X-Google-Smtp-Source: ABdhPJzwE3tUPY71/vJWzTVDDlai1Ijc0ixERtQnMkcNDJOlmgtz9zEnku27xDxwOp/gaYN6XUyJrvuI3WM3m30w9JQ=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr12603603ots.321.1606136326748;
 Mon, 23 Nov 2020 04:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20201123044907.6xgnqf5d2xnfikhm@vireshk-i7>
In-Reply-To: <20201123044907.6xgnqf5d2xnfikhm@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 12:58:30 +0100
Message-ID: <CAJZ5v0jcqrDUrS2Z=4_ywCX9S=dXoZTtOUTXXHQWTqtOFvXWsw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq-arm fixes for 5.10-rc6
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 23, 2020 at 5:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request fixes a build issues with scmi cpufreq driver in the
> !CONFIG_COMMON_CLK case.
>
> -------------------------8<-------------------------
> The following changes since commit 8410e7f3b31e53bfa7a34c282b4313e79ed7ff8d:
>
>   cpufreq: scmi: Fix OPP addition failure with a dummy clock provider (2020-11-17 10:04:28 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes
>
> for you to fetch changes up to f943849f720689214abb3930623c31ff91990be9:
>
>   cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK (2020-11-23 10:15:56 +0530)
>
> ----------------------------------------------------------------
> Sudeep Holla (1):
>       cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK
>
>  drivers/cpufreq/scmi-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --

Pulled, thanks!
