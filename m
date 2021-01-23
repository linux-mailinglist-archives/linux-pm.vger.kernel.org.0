Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9883017C1
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 19:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbhAWSvl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 13:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWSvk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 13:51:40 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA57EC061786
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 10:50:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p72so18221760iod.12
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 10:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+w2L7sIwOft/kpC6AV4o3i6vRyAbuDXd8tlN+nR2to=;
        b=ZiKN+MqnM5JH2l0renrgZkVnqGw729VFyyERNeqZAU9mEfRz1EMx2fI90HqAxLsvhk
         wljCetWri+jJeDDhbTjWdVQ9KK+zOlLq9hrzdTsPGktqjmbheyZhXZ4aejycKdROmnzE
         QEsUiBKgkGH289eoPlvcEbUauLVHFwQPgWxhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+w2L7sIwOft/kpC6AV4o3i6vRyAbuDXd8tlN+nR2to=;
        b=QkzbyLyRSVST5wxUC+fO5aFgLUvykhKWu2M1GpHjqiYL6EBDpvQomUidI4+uhLHmQa
         aeLVvkSljCWEilU2/Pq6Nee1BNlJ2gOksy8MOExC2KJnQrhHuY2npsVxajmd5ksCszl5
         y6FQjTMs8sxajI+yRUGLVsyfm4NwHboS+0g30v3Fxv/iVi0uPKh1F8/lfAx2ONb9P7zy
         7RoDl682mrRE9AE3hvUk5vREuCIHpSNfZJuVnorNP5Tb4RmblnQCcpBpxy3AA1J/Wsae
         bmf/4i5f+nLhUtLNSz3OsDk6OOxmr08pcF9P8JFaG4hIHbVfZxR6BEwm+g2uR/cXItc/
         uNvg==
X-Gm-Message-State: AOAM531EUnKSz3RXZjx8+iWEFKApu2G8czip5VZgrPcdph4nQwaKBk/p
        /XsmN8ggWZgOcak6w+w1HF3C4KAE45YzVPRQnyC6Bg==
X-Google-Smtp-Source: ABdhPJzCaU2/nupwwEHfJeLInWkUbje3f1zj+tZd56tc+2WooqYNK7AeK3AQtG/zdKeyJOs2fzyE+drtUpegtCiXrho=
X-Received: by 2002:a05:6e02:6ce:: with SMTP id p14mr629823ils.50.1611427859012;
 Sat, 23 Jan 2021 10:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20210123154922.1309290-1-dnojiri@chromium.org> <20210123154922.1309290-2-dnojiri@chromium.org>
In-Reply-To: <20210123154922.1309290-2-dnojiri@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 23 Jan 2021 10:50:47 -0800
Message-ID: <CAPUE2uteRNWVYDSeDnadsgXPdsLMMOZTGbJvtzeudC3SP7uMtQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mfd: cros_ec: Add peripheral device charger
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     Vincent Palatin <vpalatin@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Alex Levin <levinale@google.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Ching-Kang Yen <chingkang@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 23, 2021 at 7:54 AM Daisuke Nojiri <dnojiri@chromium.org> wrote:
>
> This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
> framework managing power supplies for peripheral devices.
>
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v1->v2
> * None
> v2->v3
> * None
> v3->v4
> * None
> ---
>  drivers/mfd/cros_ec_dev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 6135321592b76c..f3bc1cb6891ba5 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -116,6 +116,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
>         { .name = "cros-ec-pd-sysfs" },
>         { .name = "cros-ec-sysfs", },
>         { .name = "cros-ec-pd-update", },
Will not merge upstream, "cros-ec-pd-update" has not been upstreamed yet.
> +       { .name = "cros-ec-pchg", },
In the other patch, you said the driver probe routine will be called
when the feature is supported. For every EC, even older one, these
drivers are always called. If there is a feature flag in the EC (see
ec_feature_code), you can use cros_subdevices instead.
>  };
>
>  static const struct mfd_cell cros_ec_vbc_cells[] = {
> --
> 2.30.0.280.ga3ce27912f-goog
>

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
