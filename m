Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28502688052
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 15:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjBBOqK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 09:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBBOqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 09:46:09 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE33F8660F
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 06:46:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b5so2026067plz.5
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 06:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gvGare09I4V4QCI5X/npMy6Vy+zrhiXQfO2Ggf/2QIQ=;
        b=OJSVdyEU67KR6Z4IUNjb9xxd9Rez/Hpvl26ubVkHLZQLBODwGJ2BIPov3hbIsLoJAe
         zVLxY1V/2UCALWWggXLSAW0hQmEYbULgWNVKogiS5i/MNdqwBO/VjiD+UTVR2hopi71o
         YCnPM9GFi/zoHnXfqDZBIxFfqfsIFc07iJTEcHHeicIMh5Qg5Q5uR0jJRPrcz8DoXBay
         scV+MVpnh4EkHMBqUqZfIkaUqPdmFFZRynjaWzrqk/w12wHLoRqYawa2OLsqmrjOED0R
         r3lVgdzDeqKbcL9MFX9fGeo0X+HilreYP2Rk6oZNoNSK2OJUxMpHObsopjzXAR5/41Sq
         85gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvGare09I4V4QCI5X/npMy6Vy+zrhiXQfO2Ggf/2QIQ=;
        b=TZRvf4H1HYdcHMClA8+F3LcQbYbAqrRhjdG66HVgR8KcSJhCwd8R9ii2L10ciV1F/I
         G/yGm4pGOOcM1QbzE4slunQxu7uiSRGhZeLS/z36htZOTMbm/+M8+aRQfxLOmOXDXDTC
         J3GGV90ZnWsyU70pDna1sbY3NcRRjQOySrldSckuxAXx5oEYK8c+0jSBHnoR03NPmLlN
         XsNEUdVLZ37kmY1owzH7/tvw1IXQfUHhjuKWL/96rOTl4XWUYS6QI8olF3aIEJ31cGPS
         e5XyoCKYSFnInCFeft5hBdwRr7l4zFrVI9Sb7ki6KDdP9zMN4LSC8HpBW7MmGFYW8Uv1
         MKVg==
X-Gm-Message-State: AO0yUKVumW42QYqagUW29BXpEMHqz7gqW8zIZjz3/cmMur0XrQ87mFMZ
        K0lfYyrAFAwiob1ICVoX9p7X2uIjoJX5x0z3I+OS3g==
X-Google-Smtp-Source: AK7set+nZEC4dDNojajz4bpX0JArLbWo/ibWLgz3iwsLe/PfjICfstwFRNHUq8px4ZzSazS8Ca+zatCtuHtim1ieg+I=
X-Received: by 2002:a17:90a:f98f:b0:230:5394:6eef with SMTP id
 cq15-20020a17090af98f00b0023053946eefmr531542pjb.109.1675349164472; Thu, 02
 Feb 2023 06:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20230202141545.2295679-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230202141545.2295679-1-gregkh@linuxfoundation.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Feb 2023 15:45:28 +0100
Message-ID: <CAPDyKFq_yAJOSZO7WsPZKV_aGcFAs0kWqpNN-_=ywa8n=8D=-g@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: power: fix memory leak with using debugfs_lookup()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, Kevin Hilman <khilman@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2 Feb 2023 at 15:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at
> once.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 967bcf9d415e..6097644ebdc5 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -220,13 +220,10 @@ static void genpd_debug_add(struct generic_pm_domain *genpd);
>
>  static void genpd_debug_remove(struct generic_pm_domain *genpd)
>  {
> -       struct dentry *d;
> -
>         if (!genpd_debugfs_dir)
>                 return;
>
> -       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> -       debugfs_remove(d);
> +       debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
>  }
>
>  static void genpd_update_accounting(struct generic_pm_domain *genpd)
> --
> 2.39.1
>
