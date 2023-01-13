Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AFB66A3B1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jan 2023 20:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjAMTwC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Jan 2023 14:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjAMTv7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2023 14:51:59 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD37C3B1
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 11:51:58 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id v6so11667302ejg.6
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 11:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaeJU1CBT3f4SHty1P0QikqYinKBQQbaLdN6c3ICfbc=;
        b=dOH9oLf91hE3RrzrZq3HrGRxypvHwk9kBLY4VNlijsvl+3YVic6Re4EuJJ/YYKOlYk
         MAN0NzhIRwZtfmOPkoHAx5QleaSQC/8tZjqQughQUFMr3HewwpynwxXhviNHfEAGt7k9
         e3fgHuibq2xyBFA+wsDdL1XrwUpCTnMIyCkCpXzTK59gNlt22Xl0QXZml0Rpoa1p0dME
         M7nXn705uCrwl7m/uVZ5uJYBJsYTIqm5BuYfqrL+MB6pHlVFOwhqfbZdD8gvzibk3qxD
         Y7/VyY9agnxl1qhyREcVB1kiN6LiWRRTpVOXYNJYbLd+5aml4sisaz0sEXVBF+82Novu
         3STQ==
X-Gm-Message-State: AFqh2kpB4SqHMuPt9M2RMVJ7jTOkGLOSCQFswAx6e+OH+dvprubOZ70o
        9+GiHPqMki9RWyaYrkR7Mzl3qHMJH/hi71orShrHsZSG
X-Google-Smtp-Source: AMrXdXuTKpvdohAKOzZJlRMdpVg6kp5WhrCGVgUBskqPQDlaybSr3y3GhOQR0X1e4aF8TXynAevvYJe+4cnw1zguf2c=
X-Received: by 2002:a17:906:9484:b0:84d:3c6a:4c55 with SMTP id
 t4-20020a170906948400b0084d3c6a4c55mr3081508ejx.509.1673639516983; Fri, 13
 Jan 2023 11:51:56 -0800 (PST)
MIME-Version: 1.0
References: <1670577923-39100-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1670577923-39100-1-git-send-email-lirongqing@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Jan 2023 20:51:45 +0100
Message-ID: <CAJZ5v0h3mhGMgbjchBVBiPFj4UL+5F6qNxO4bG9comDaC5gbyQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle-haltpoll: select haltpoll governor
To:     lirongqing@baidu.com
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 9, 2022 at 10:34 AM <lirongqing@baidu.com> wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> haltpoll driver should select haltpoll governor, ensure they
> work together
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/cpuidle/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index ff71dd6..cac5997 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -74,6 +74,7 @@ endmenu
>  config HALTPOLL_CPUIDLE
>         tristate "Halt poll cpuidle driver"
>         depends on X86 && KVM_GUEST
> +       select CPU_IDLE_GOV_HALTPOLL
>         default y
>         help
>          This option enables halt poll cpuidle driver, which allows to poll
> --

Applied as 6.3 material, thanks!
