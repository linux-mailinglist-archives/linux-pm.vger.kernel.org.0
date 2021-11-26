Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A6D45F2D2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 18:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhKZR1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 12:27:22 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:39817 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhKZRZV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 12:25:21 -0500
Received: by mail-oi1-f169.google.com with SMTP id bf8so20012925oib.6;
        Fri, 26 Nov 2021 09:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvQyGhC9jNKoHcK8q/CTH+eU4jPIt6zo0Ot+2Yqpxyo=;
        b=fW42sNyUp53eV9tMrBvxuVwAI5HbvsdW8brkjJ2NrC2o9ZLwsa+wYiKQCqyqoqJzLI
         xg5EmQwz+uPgFnpdZEMhhShoxt2eUi9Nt7R4XeeetlOtc6TVwQLY1gZ/G2JOoYkBrZ4X
         Iai6WPxNJ/sfGqKoaz6tj/kgLSY2vytEnTgJypkDwxBd+aexXFaxJjlcd2iF3KuWVESP
         9lPgpCHLIUKacqbhYHV9OQki0o83aeHzJCOp8OQTHuPBtibsfcbRBW5otLi0M6xK5JYj
         QJFpFb6cbJBLNN13MyD2g5ZDKHAuQXWRwRfQAKnZzwKju/oQ6PTRGigau3Gln/FZMxus
         6IXg==
X-Gm-Message-State: AOAM532LqcpUHEo1FuSd5jCVXEZinFht2TZlvKl3jyfbpWpyWEeOPhWj
        cNs9D/d7CDcQcuRMn+bUthuM/tPHpWIz6dBu0QY=
X-Google-Smtp-Source: ABdhPJwLcV0kvSupFRnxz8RlbUGxq6S++mPRKq7N52fkhN7kg/LrTJJeiTs8xe1nIglW7SWSCcArVKgTQR8AU5+Fdhg=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr24130345oil.166.1637947328431;
 Fri, 26 Nov 2021 09:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-3-daniel.lezcano@linaro.org> <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
In-Reply-To: <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Nov 2021 18:21:57 +0100
Message-ID: <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

On Fri, Nov 26, 2021 at 6:08 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Daniel,
>
> This patch introduces a regression, at least on my test system.
> I can no longer change CPU frequency scaling drivers, for example
> from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstate
> (A.K.A. active mode). The task just hangs forever.
>
> I bisected the kernel and got this commit as the result.
> As a double check, I reverted this commit:
> 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
> on kernel 5.16-rc2 and the issue was resolved.
>
> While your email is fairly old, I observe that it was only included as of
> kernel 5.16-rc1.
>
> Command Example that never completes:
>
> $ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
>
> syslog excerpt attached.

This looks like it may be problematic:

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index f6076de39540..98841524a782 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
       return ret;
}

-int dtpm_register_cpu(struct dtpm *parent)
+static int __init dtpm_cpu_init(void)
{
       int ret;

so please try to remove the __init annotation from dtpm_cpu_init() and
see if that helps.
