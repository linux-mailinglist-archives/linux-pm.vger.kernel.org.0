Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0B169B1F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 01:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgBXAM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Feb 2020 19:12:56 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34433 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBXAM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Feb 2020 19:12:56 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so7378951oig.1;
        Sun, 23 Feb 2020 16:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXtF/HmMIrcd+cQtmXxs/T7lgY990MkWtsdCks/TALQ=;
        b=n1y0GFsabmOGSPdsWZwUCkx5zUH6EwT/QM3R2QhUuCiDi3yzz+PlNtyUy0TyjkaW2z
         0UXfQNjTXmYZoELA1HAxUQAJLNjYNY39B8SSw1qtR/Cqi/xKT2FFUKwGb4qakt8texD1
         edAMrtAmNF4Sj0eT4p4yVi/E7U96+SFVo695gqCUl3zp/ufLB857dk4BhGP2ojxdNTeu
         sdZnAq0wGuvcG783Ra8g15VheMBuZu+3T/i2ZAdMaV7dEcMcm0uBLSzpNj0Yh228rE53
         eoVqjUwO8HOcdq3BR66pH5P9r1PCCjFKfh6XDdi7fOqtSjygDUrlxhS89HckN2/1s9vI
         DMlA==
X-Gm-Message-State: APjAAAUY7HY0fwsDVAp/1y9UjrNXKl7d/BQGrMtUQhIpE4or/3pTYyF1
        NZCivzGDXntTznKoRJ2k6vTFf8FpkvFWt1z7LDbfOw==
X-Google-Smtp-Source: APXvYqzdpH/FefyGNd/m5kE+ZaANP4jSIXHMUatJ93J6tlevnB7xPSMTV256Cq9jT+92l+vsHgJ3g0osYRVYlYV+4is=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr11067116oiy.110.1582503175589;
 Sun, 23 Feb 2020 16:12:55 -0800 (PST)
MIME-Version: 1.0
References: <1582319350-23515-1-git-send-email-cai@lca.pw>
In-Reply-To: <1582319350-23515-1-git-send-email-cai@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Feb 2020 01:12:41 +0100
Message-ID: <CAJZ5v0iSEV9S=zTa9++vUCO6GTfBE2sxNY+b4mMMt4Y6RCRvjA@mail.gmail.com>
Subject: Re: [PATCH -next] power/qos: fix a data race in pm_qos_*_value
To:     Qian Cai <cai@lca.pw>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, elver@google.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 10:09 PM Qian Cai <cai@lca.pw> wrote:
>
> cpu_latency_constraints.target_value could be accessed concurrently as
> noticed by KCSAN,

Yes, they could, pretty much by design.

So why *exactly* is this a problem?

>  LTP: starting ppoll01
>  BUG: KCSAN: data-race in cpu_latency_qos_limit / pm_qos_update_target

It may be a bug under certain conditions, but you don't mention what
conditions they are.  Reporting it as a general bug is not accurate at
the very least.

>  write to 0xffffffff99081470 of 4 bytes by task 27532 on cpu 2:
>   pm_qos_update_target+0xa4/0x370
>   pm_qos_set_value at kernel/power/qos.c:78
>   cpu_latency_qos_apply+0x3b/0x50
>   cpu_latency_qos_remove_request+0xea/0x270
>   cpu_latency_qos_release+0x4b/0x70
>   __fput+0x187/0x3d0
>   ____fput+0x1e/0x30
>   task_work_run+0xbf/0x130
>   do_exit+0xa78/0xfd0
>   do_group_exit+0x8b/0x180
>   __x64_sys_exit_group+0x2e/0x30
>   do_syscall_64+0x91/0xb05
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>  read to 0xffffffff99081470 of 4 bytes by task 0 on cpu 41:
>   cpu_latency_qos_limit+0x1f/0x30
>   pm_qos_read_value at kernel/power/qos.c:55
>   cpuidle_governor_latency_req+0x4f/0x80
>   cpuidle_governor_latency_req at drivers/cpuidle/governor.c:114
>   menu_select+0x6b/0xc29
>   cpuidle_select+0x50/0x70
>   do_idle+0x214/0x280
>   cpu_startup_entry+0x1d/0x1f
>   start_secondary+0x1b2/0x230
>   secondary_startup_64+0xb6/0xc0
>
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 41 PID: 0 Comm: swapper/41 Tainted: G L 5.6.0-rc2-next-20200221+ #7
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
>
> The read is outside pm_qos_lock critical section which results in a data
> race.

This is purely theoretical AFAICS and so it should be presented this way.

Also the call traces above don't add much value to the changelog, so
maybe try to explain what the problem is in English.

> Fix it by adding a pair of READ|WRITE_ONCE().
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/power/qos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 32927682bcc4..db0bed2cae26 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -52,7 +52,7 @@
>   */
>  s32 pm_qos_read_value(struct pm_qos_constraints *c)
>  {
> -       return c->target_value;
> +       return READ_ONCE(c->target_value);
>  }
>
>  static int pm_qos_get_value(struct pm_qos_constraints *c)
> @@ -75,7 +75,7 @@ static int pm_qos_get_value(struct pm_qos_constraints *c)
>
>  static void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
>  {
> -       c->target_value = value;
> +       WRITE_ONCE(c->target_value, value);
>  }
>
>  /**
> --
> 1.8.3.1
>
