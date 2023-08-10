Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792567775C3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjHJK2K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjHJK2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 06:28:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB191
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 03:28:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso1058145e87.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691663285; x=1692268085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtfGuHBqzKgvRO7nkOwGjCqGwEnROHkA84/MSSd9jWc=;
        b=sk2OwjgcUA+4BWuh4y1YrKFPJwAaZozAevMa6GxprwQ4cJnZmGjKDQh3Zoy8HolCo0
         3vB4QXTX9aEFrFylOQY9Pwj7s7W/TfLTdlasfb52/mMDPdKIjmunQeEc09xV/7Ky441h
         Vwg5orOAC3wt7G8PskZvJbHWp1nYBK+4kzXsM+Ay1Yx0GT7y3nK7923aYuYLe+1Z2cXk
         ly0y9e1Az181TMVBEVNhY1aT6oew+w7v5x9bhlHSmL01ACe59WFwGhwnuHNJ5AQwMps9
         /2ez161fooc3OP2lYxrrjYxo8uFJS8SjpgDZuxcMxJ8ZS2gWDB7oHz2LLoLp8ztCP2Ay
         KyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663285; x=1692268085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtfGuHBqzKgvRO7nkOwGjCqGwEnROHkA84/MSSd9jWc=;
        b=gfa45AXuYjZju0AxMR3Ctm3yxKqbCdWoL4OU8fbRbpN9x3qG7AdoXWsaqfs8b9Kjnu
         XvNFt8Ka1VtOvGfWovXBa2RwpCCcBkdrMUMT0XTys2we1Dx3Y6lRm1RQiMgzihmOpT3A
         uYs+yMv9bqwETIx77O78DcEQb59IG4Slg/OlHgkr5r5nikm1nLikj1B6W6jGu1p74B7H
         NHkmy8X0npsSUiMI43nYTyqExIws/0gzb8SsPgsNL7+0oTZDAqGBi50o6dGOSeCzC4lj
         VmwHh4j7YyHAcDpeRdvDnSKS5evQqk92NjXy2Ba/vRXT61xEVIUNX0L+g6/QxyylDrvn
         4ivQ==
X-Gm-Message-State: AOJu0YzE6ggBmPffWa3B6pKL22W3QeSt/u72X+XUuNZPvz3k5omdteSD
        M6v6tSZVhatfVxv7XAwykbiUEytx9ywhlGkAj1tKxQ==
X-Google-Smtp-Source: AGHT+IGfSEz+4dCHJjA2StQXybH0vYjOxS0CJoaenf2Vw1MVAav/Muy0pwow59cBq5//WlieCDBrvzWr4x/jturjeTo=
X-Received: by 2002:ac2:57c7:0:b0:4fb:7559:aea3 with SMTP id
 k7-20020ac257c7000000b004fb7559aea3mr1320229lfo.39.1691663285426; Thu, 10 Aug
 2023 03:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230809154813.16033-1-aboutphysycs@gmail.com>
In-Reply-To: <20230809154813.16033-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Thu, 10 Aug 2023 13:27:54 +0300
Message-ID: <CAH3L5Qp3HYbaz3eWr7ugJ0Ftm+ji-3r376LeX23_qCHOq8Vvqg@mail.gmail.com>
Subject: Re: [PATCH] thermal: broadcom: brcstb_thermal: removed unneeded platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, florian.fainelli@broadcom.com,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        mmayer@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 9, 2023 at 6:48=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.c=
om> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal=
/broadcom/brcmstb_thermal.c
> index 72d1dbe60b8f..2997c589ac7d 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -334,7 +334,6 @@ static int brcmstb_thermal_probe(struct platform_devi=
ce *pdev)
>                 return PTR_ERR(priv->tmon_base);
>
>         priv->dev =3D &pdev->dev;
> -       platform_set_drvdata(pdev, priv);
>         of_ops =3D priv->temp_params->of_ops;
>
>         thermal =3D devm_thermal_of_zone_register(&pdev->dev, 0, priv,
> --
> 2.34.1
>
