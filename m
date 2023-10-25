Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C9D7D7343
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjJYS2P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 25 Oct 2023 14:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYS2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 14:28:14 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428CAAB
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 11:28:12 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b4bdb89177so300462b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 11:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258491; x=1698863291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ncLM1argiIpPvYKrR8PP3SrKwdM9xYiRycgGLg3c3k=;
        b=D+jzVjbapnXDJ746slmeQC/cQbfRPF7oXlO6x9i6/wMdj6EXFXXvJCmXqRCiP3KuVP
         8+VLsk23olBP8KY2rdEsLixFkG72nXPm1nLI8PJM3tRObeYa/OEz/l55tBi7NoQUFgnj
         VLHVOxM3OTnCqzJChPx+O/Q7WXegmW1VsbJywkgyzG4ubSV6CjJfg6y43TIy8gq56na9
         toDcn3eugajs356wEn7NpBB3fWE87WLlBRgR1uHUbNsqC79zddc0m7KzzalefbhpojJu
         W9QB8mi3nSbX/b1diZnZKgWBHnGuDXLg8Ntyye6s9h16u38WpMwUWi0kpOdVnq8SHwY1
         Dryw==
X-Gm-Message-State: AOJu0Yz7rv5Gc4sSr1gROwCpcS7741RZmAGOF1oRuRmVFZVeImrnlkF3
        TXpOjQvYzE1Zkj75somNFv3cy+1SYcrtPwq7RW//eEvYSk8=
X-Google-Smtp-Source: AGHT+IFobYYMleT49SRExb//9AMmQBMHd9gYlbFryAYYz7W23I6M6UcZoE2NmF8BHndAZUlEwhmIK5YJ6eQI8Vc8wHM=
X-Received: by 2002:a05:6808:1586:b0:3af:6453:2d83 with SMTP id
 t6-20020a056808158600b003af64532d83mr18493141oiw.2.1698258491581; Wed, 25 Oct
 2023 11:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231024091447.108072-1-chris.feng@mediatek.com>
In-Reply-To: <20231024091447.108072-1-chris.feng@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Oct 2023 20:28:00 +0200
Message-ID: <CAJZ5v0iLCsiPncA1t7ogtpch9gjGjzjtDU6G5E+PHB8ZCHgY0A@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix the bug where wake events cannot wake
 system during hibernation
To:     chris.feng@mediatek.com
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@veger.kernel.org,
        stable@kernel.org, hua.yang@mediatek.com, ting.wang@mediatek.com,
        liang.lu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 24, 2023 at 11:15 AM <chris.feng@mediatek.com> wrote:
>
> From: Chris Feng <chris.feng@mediatek.com>
>
> Wake-up events that occur in the hibernation process's
> hibernation_platform_enter() cannot wake up the system. Although the
> current hibernation framework will execute part of the recovery process
> after a wake-up event occurs, it ultimately performs a shutdown operation
> because the system does not check the return value of
> hibernation_platform_enter(). Moreover, when restoring the device before
> system shutdown, the device's I/O and DMA capabilities will be turned on,
> which can lead to data loss.
>
> To solve this problem, check the return value of
> hibernation_platform_enter(). When it returns a non-zero value, execute
> the hibernation recovery process, discard the previously saved image, and
> ultimately return to the working state.

While I agree with the problem statement, I don't completely agree
with the patch.

> Signed-off-by: Chris Feng <chris.feng@mediatek.com>
> ---
>  kernel/power/hibernate.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 8d35b9f9aaa3..16d8027a195d 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -642,9 +642,9 @@ int hibernation_platform_enter(void)
>   */
>  static void power_down(void)
>  {
> -#ifdef CONFIG_SUSPEND
>         int error;
>
> +#ifdef CONFIG_SUSPEND
>         if (hibernation_mode == HIBERNATION_SUSPEND) {
>                 error = suspend_devices_and_enter(mem_sleep_current);
>                 if (error) {
> @@ -667,7 +667,13 @@ static void power_down(void)
>                 kernel_restart(NULL);
>                 break;
>         case HIBERNATION_PLATFORM:
> -               hibernation_platform_enter();
> +               error = hibernation_platform_enter();
> +               if (error) {

This error need not be -EAGAIN which means pending wakeup.  There are
other errors that can be returned for which the fallback to shutdown
is still desirable.

> +                       swsusp_unmark();
> +                       events_check_enabled = false;
> +                       pr_err("Hibernation Abort.\n");
> +                       return;
> +               }
>                 fallthrough;
>         case HIBERNATION_SHUTDOWN:
>                 if (kernel_can_power_off())
> --
> 2.17.0
>
