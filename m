Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889C5F096D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Sep 2022 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiI3LDN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Sep 2022 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiI3LCs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Sep 2022 07:02:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E846843
        for <linux-pm@vger.kernel.org>; Fri, 30 Sep 2022 03:40:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090a31c600b0020a07b184deso1038532pjf.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Sep 2022 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wE4lpqYwqk4u9XvsAzsnbFiC20Ksy2fiQQh2bbRSmmU=;
        b=IDudUpNy+bL4qo9CmDHK0ImhQiZzyvB3T2pYYBnR67eBRLeIgd+SYRt3ffzRpnDyN1
         O/26o5AvVMUumUU0ab8CpMoK6Uz6vhnPli/92/ifWmH9iRUeteGzdRvO0qCzUdlnYkJV
         fa2MH6k7QG9A7rOqr0IHwfPIlGmE7ZnAsMuLPmNtoRnL2u3fzK4uRtTVpR33TC+Gkra3
         Ce6cKMjINrXqAE0LTBBPRglWzVvB/158SvHspGaFpDHdy4CYEqw5AeOR03gkGzIEvH2M
         /gLSy8kT6E8HazEcT0f1z72A9PzhScJvEI+57Qqkf9Qyph7fvGKAh98LNcfZS3a1a1xZ
         ynxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wE4lpqYwqk4u9XvsAzsnbFiC20Ksy2fiQQh2bbRSmmU=;
        b=OlbsTXZSAcx8xIAl85lZxR+/K2N5hvwP0XDVaZSDfYrlnSuTJcatcFHYnKKodFIU3M
         d/PxkHhKbg0rY2FQd5WbbiqtggNgudq0Vfn/5zVFxXz3sMvf2BPAwiDRI0CThTPRa+uI
         HWbT3XgchJa524QrQkeax6alwSSGPxVQL7ErULaE4zB+AqIesIu6TmQjkxRB1EyYPduI
         wSLVm0pByPPip5vZ6RXrC7zjvLTaMdO7+i45rOVq25NGQD9RxVIrbxxPlt1mydtx5Vk+
         Ei/OLpe3HXkVL+XTiRhQidGrM2w4dX+DFCsW9NqQPqMGc9Ud6mV7i7BQVeCzcsXHZfY9
         fmSg==
X-Gm-Message-State: ACrzQf1RKug3ZAqzu9RBxDaZOJwffFKTzXEYK9CmdCTGuh0lrw8OGzDk
        zQffX0KbdTFz83wGNHoHOOCjYfeB6iAtfF30zLJUiA==
X-Google-Smtp-Source: AMsMyM7SkWkOgIYLRSZzA7wrF5ZlkgNFKGHt4LuheQhgqXfcVvfjOl+z+L3Dhh72A5aFx0IArnxXxXgRtDPZAYX621I=
X-Received: by 2002:a17:90b:1b06:b0:202:cce0:2148 with SMTP id
 nu6-20020a17090b1b0600b00202cce02148mr21664292pjb.84.1664534373483; Fri, 30
 Sep 2022 03:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220929154214.7305-1-johan+linaro@kernel.org>
In-Reply-To: <20220929154214.7305-1-johan+linaro@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Sep 2022 12:38:56 +0200
Message-ID: <CAPDyKFoW5HLykzRdtF4a_7=RNXu6LTfABxDX2P3hotsXQwCUMg@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: log failures to register always-on domains
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 29 Sept 2022 at 17:42, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Always-on PM domains must be on during initialisation or the domain is
> currently silently rejected.
>
> Print an error message in case an always-on domain is not on to make it
> easier to debug drivers getting this wrong (e.g. by setting an always-on
> genpd flag without making sure that the state matches).
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
>
> Both myself and Matthias have hit this with the Qualcomm GCC drivers
> when updating static genpd flags directly instead of using/adding driver
> specific flags to propagate the setting.
>
> Johan
>
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index bbfbf05b3446..7200e307effb 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2087,8 +2087,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>
>         /* Always-on domains must be powered on at initialization. */
>         if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
> -                       !genpd_status_on(genpd))
> +                       !genpd_status_on(genpd)) {
> +               pr_err("always-on PM domain %s is not on\n", genpd->name);
>                 return -EINVAL;
> +       }
>
>         /* Multiple states but no governor doesn't make sense. */
>         if (!gov && genpd->state_count > 1)
> --
> 2.35.1
>
