Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2B4D3975
	for <lists+linux-pm@lfdr.de>; Wed,  9 Mar 2022 20:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiCITGN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Mar 2022 14:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiCITGM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2022 14:06:12 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10836F482
        for <linux-pm@vger.kernel.org>; Wed,  9 Mar 2022 11:05:13 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2dc0364d2ceso34011577b3.7
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2022 11:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5ZhCiN+1hWQW/iJ4V81fkb5gSLx7RVTqHBsIBjU08o=;
        b=Owh6ea/MEW08dCcaHi+PP0jpE4Dzr/qZkYt37M1db51O093eZBEn8tvtt3mHNg550g
         /FucipHJlKfGTiBrCOkZCyHhhmrrEkE1rCfYB3fKHdxjQTBEhdHhFYFZqVC2hpENVmXd
         xNuz5ZoQkRUldB7xiNMpVpoHewSFPUwDCLRglGpBaFAGdJu+Z9aZ1uA2mRh9aAupII6U
         AsKoHA5hqj8qH5osgUgu8Dtz99AmmVvsXQ7sSpERQuIORajmRepjmpj9xXRHhtd6km9X
         ga9Z20JgHjwrG7Y5caGyoAXyWjYtbpaZUISeXb83wRX1vZcAPwALP2EKDv8W1Dw3Z5IX
         fA2g==
X-Gm-Message-State: AOAM5318Apl1tdesZmOd1gJC/NfRxbVswwr4HDQsZCwPN7fzthJFPM1z
        9hNMMkgQ10A3JIkxgQr2cPNMuNhL4gJuVV6aTyk=
X-Google-Smtp-Source: ABdhPJx0dwPUZYzU8UlaW8ZLT6bqDzDEvzODxjYFFtdgDyunrxwjEkx1TJYz4FvLdLAv3gcFP8zYzRPDzFKC9FkTKMw=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr1043929ywb.326.1646852712987; Wed, 09
 Mar 2022 11:05:12 -0800 (PST)
MIME-Version: 1.0
References: <1646380408-57184-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1646380408-57184-1-git-send-email-lirongqing@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Mar 2022 20:05:02 +0100
Message-ID: <CAJZ5v0gqoKRcDACCUnJT2bZNmEGtDJcErC-Qe8v_gQ_oRzCimA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle-haltpoll: move cpuidle_poll_state_init after
To:     Li RongQing <lirongqing@baidu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 4, 2022 at 8:54 AM Li RongQing <lirongqing@baidu.com> wrote:
>
> call cpuidle_poll_state_init only if it is needed to save
> some cpu cycles
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/cpuidle/cpuidle-haltpoll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
> index fcc5321..3a39a7f 100644
> --- a/drivers/cpuidle/cpuidle-haltpoll.c
> +++ b/drivers/cpuidle/cpuidle-haltpoll.c
> @@ -108,11 +108,11 @@ static int __init haltpoll_init(void)
>         if (boot_option_idle_override != IDLE_NO_OVERRIDE)
>                 return -ENODEV;
>
> -       cpuidle_poll_state_init(drv);
> -
>         if (!kvm_para_available() || !haltpoll_want())
>                 return -ENODEV;
>
> +       cpuidle_poll_state_init(drv);
> +
>         ret = cpuidle_register_driver(drv);
>         if (ret < 0)
>                 return ret;
> --

Applied as 5.18 material with some edits in the changelog and subject.

Thanks!
