Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5B784ACC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 21:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjHVTr4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 22 Aug 2023 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjHVTr4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 15:47:56 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7433CD9
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 12:47:54 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-68a56ed12c0so447643b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 12:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733674; x=1693338474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jwa/OtT0yuZ30UOanCQPM2itCxyEUNZAF9cGoE4Z5OA=;
        b=HDpTKH4NPC/vp1WaiFpTxw9n3ajJ/GYHbzjb53UKxA4PTS57YLF//LvabKXONxzN4s
         jDe7uERt4rvwr8owxjWjjiFI+g7zuPJriYo49sxyq4VNTYwLfPhJBB2VvoO5S/DB9GUl
         1c37sSp6sDfYMBJ/5yDzGb90syxlo/Ci8uCp3QsCRKpJneh/NpwyIeAoe+MnYH7uGICm
         jak0pqedqJ5kn/LGFpskcjoLa+bFbSUfm+N6FAk7IeWC9LYLAUH4LQmEvKO7XUZge7F4
         QZrEHa+OAjLs47Pnl3b8s/AnpMHQvbRkJtfkrPFxRv79nMUwKEo8ctU/9Q69ccLpP2fR
         GETA==
X-Gm-Message-State: AOJu0Yy14m6bRpe8lni1RDEitxTMv/w8SR+RkpGzCvvEfIAmxAizUNOH
        swLtNKxkfw4e65AKXtv0Z/rMm9c6on0YGJljWfU=
X-Google-Smtp-Source: AGHT+IFAIH3NcPd/bHr4Yk3p1gsz1SDBH+GDKjMyHyJz1HEb7o1b3MokZ3sUlq+ez1MBsGyWD7EEq05214JSUv2UIkM=
X-Received: by 2002:a05:6a20:6a05:b0:134:d4d3:f0a5 with SMTP id
 p5-20020a056a206a0500b00134d4d3f0a5mr13665895pzk.2.1692733674119; Tue, 22 Aug
 2023 12:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230804092101.1354476-1-yangyingliang@huawei.com>
In-Reply-To: <20230804092101.1354476-1-yangyingliang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 21:47:42 +0200
Message-ID: <CAJZ5v0hEdr+TvFCnsM7kgP8S+46s4q7N9EX89i0jvGAzwLcryA@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/int340x: simplify the code with module_platform_driver
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 4, 2023 at 11:24 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> The init/exit() of driver only calls platform_driver_register/unregister,
> it can be simpilfied with module_platform_driver.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  .../thermal/intel/int340x_thermal/int3401_thermal.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> index 217786fba185..c93a28eec4db 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> @@ -70,18 +70,7 @@ static struct platform_driver int3401_driver = {
>         },
>  };
>
> -static int __init proc_thermal_init(void)
> -{
> -       return platform_driver_register(&int3401_driver);
> -}
> -
> -static void __exit proc_thermal_exit(void)
> -{
> -       platform_driver_unregister(&int3401_driver);
> -}
> -
> -module_init(proc_thermal_init);
> -module_exit(proc_thermal_exit);
> +module_platform_driver(int3401_driver);
>
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
>  MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
> --

Applied (with some edits in the subject and changelog) as 6.6 material, thanks!
