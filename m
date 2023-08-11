Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17956778728
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 07:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHKFzg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 01:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHKFze (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 01:55:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040332706
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 22:55:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so2570130e87.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 22:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691733323; x=1692338123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmt/gubznLN0uQ86/mDY3ypBbPnVCxi4XxXVIT45T4w=;
        b=OfFJ1UNpIBwTVK2dQ6oI7ZhD0gUA/qGNMI75hMhgLjsyhB1Ur6y9g6nyNj4NHpa67v
         laQ1KVOlJ0KG431h0d0eRdnEIgMVNw7VwoDNbfE06B4o3dmDxZRbJgzJhFaotA9C5xx2
         UQwQD6mIVuZaCBQ14Bug/omZiLEPxdAEUIuqlhrjbxnxFz9MS2pBQPLsKkuc8LZlGElh
         yD7/WZWaPudEeiAx+O2klrWsjCReiYgYjiLwSK3M+Z4PkzYd9/FxQR2QOkA5dWT3FO9k
         pf8pfUD0yIlSWwqpkd16AOoGLr5WrHniCG/YK5VUhvPH67jzXLoMUC/XlrU2cBHmNhW3
         Xsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691733323; x=1692338123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmt/gubznLN0uQ86/mDY3ypBbPnVCxi4XxXVIT45T4w=;
        b=ABBfrrqmYQA1zgBiFqCRKNVcA1hDyGkVXxR07e1K9eFRl1iFisb+pnn0HbesvMMTQ6
         WPVFI4rxuyc1XJ5XOsb9PjFdd/eHVFbz2fKT8g2vP9dxOI5fSpuvq3I5yixficf4zyqL
         xe4Ejfy/8HVFWC5Dmo1nxdOPvuVbm1ZQ57II8+qQJLXb/q9MNsv2tfJiuvdwn1DmBy8P
         Q5mw2j2YGG6toU1AXReR1NhmchOSeRmszskoZ04hC+Xd3A8QuTkg3LULcqZmfrKukaH7
         sfUpQcPaMjj4SJj7GomTs/HpZlkK3r7LzB5yseQRLADekF1epZtepbs4YbsQ8Z98/+3F
         vcDQ==
X-Gm-Message-State: AOJu0YwFhTC0+d/nAFpDCVd79SmnjHl8t0cq/kbw4tYWiOSWpOsBIbLo
        AgT4MVnH6EFVUXLA3iP71NzBDOzepX8szEuxoqJJqA==
X-Google-Smtp-Source: AGHT+IF554dgo6vpDP/cny3ywpXx2Y4i7DYvhGwYm/FsQFD9IB7TGiXNd7lRSzDOuFYIoN24pfQoZjAfpRhs2nHY4hI=
X-Received: by 2002:a05:6512:250f:b0:4fa:d147:9df with SMTP id
 be15-20020a056512250f00b004fad14709dfmr555576lfb.19.1691733323014; Thu, 10
 Aug 2023 22:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230810111330.3248-1-aboutphysycs@gmail.com>
In-Reply-To: <20230810111330.3248-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Fri, 11 Aug 2023 08:55:11 +0300
Message-ID: <CAH3L5QoXrhFd92krdmeJz2fradMZcBc80nx4rJ+pjtjoa0OwBw@mail.gmail.com>
Subject: Re: [PATCH] thermal: broadcom: sr-thermal: removed call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        hayashi.kunihiko@socionext.com, bchihi@baylibre.com,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 10, 2023 at 2:13=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>

I had to take a look over how "thermal_zone_device_priv()" works, and
it looks like it has nothing to do with the platform_set_drvdata() /
dev_set_drvdata() / dev->driver_data stuff.
It defines it's own `devdata` pointer.
Though, it looks like "thermal_zone_device_priv()" could potentially
be converted to use "dev->driver_data"
But that requires a bit of going through all drivers to convert them.

Anyway, for this:

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/thermal/broadcom/sr-thermal.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broa=
dcom/sr-thermal.c
> index 747915890022..9a29dfd4c7fe 100644
> --- a/drivers/thermal/broadcom/sr-thermal.c
> +++ b/drivers/thermal/broadcom/sr-thermal.c
> @@ -91,7 +91,6 @@ static int sr_thermal_probe(struct platform_device *pde=
v)
>
>                 dev_dbg(dev, "thermal sensor %d registered\n", i);
>         }
> -       platform_set_drvdata(pdev, sr_thermal);
>
>         return 0;
>  }
> --
> 2.34.1
>
