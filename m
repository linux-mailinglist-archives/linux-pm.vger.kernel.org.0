Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B12E4272
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 16:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404426AbgL1PWv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 10:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440871AbgL1PWq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 10:22:46 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF18C061796;
        Mon, 28 Dec 2020 07:22:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 23so24541121lfg.10;
        Mon, 28 Dec 2020 07:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3VwPLXd6o2GllfI0uMKsQz7w/gWAlkuLi7VEd1eZ0TY=;
        b=EMO1cnJCWFS6qwYbumAFA8H7EuKG7SSKusBtFt+Ps0LaFUgRVfHKp7kGO3kXoP34/Y
         TzhupyVe6m5MNl/qhTM8I85/EHh9z8TrOyzxFrbH1QtIA3ur2w/p2VK36Qm7TM/1abLo
         c+Eogx7DFQPkc4K8ufIkGkxt2gCD/22l8q8Uf+amkbKRSdie4BUQ0QJ1rdJfd8yPIfd1
         mIRbh0SO+c5LGcf6S8w3rHmk1j/fePyhVPcjWxE1hqQ+O+2cdtpm0j6wFG60wAGZgZdm
         giO9ivY1pX3O9/gKTeRLfx8gTg66v8noJq1WrhNTxXvrySoo3vGNUAxmQsRgSw0olSXf
         8v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3VwPLXd6o2GllfI0uMKsQz7w/gWAlkuLi7VEd1eZ0TY=;
        b=L2C8Gju91DDKDDgaoYzsmVsXWvvG9WIsbkfU5lHWeyIMTREtoLx0aiPMdX9AasToUQ
         ntlw1IosdplrAX/gpth3m1qVBtmGIsCGGootkCvPjBfIWiS/HGyVetLD83zfB11pq9Uf
         mHf60Qcxn9Oj5bikZE17FL3mh+txc+N79GAvfcHijh0MwBWHYudCKgSX2Y1rIYck2DlS
         e0VCsdNd2P8eZzHtIImaH/6xPgr7Vxa9ojpH7En1jCuecdp3Q1ecVRp8QNLQLZRXkhtk
         nzzoyZS4sOaoWXMyuPsjp4NBREE9n87KHmkRkk13vjytcZ0wPKDUoAFyrTAUwIpSKcmj
         +ziQ==
X-Gm-Message-State: AOAM533I/DyV+eCCFtUJQmAFuDgwX37enk73DljznH6t+b0F01Jef7Gv
        xRRJ+9JWrP8WpAooAwnAyA4sDq9tTZEwKjaoMFo=
X-Google-Smtp-Source: ABdhPJyZzbmnH/Z0aSV8m5ioeqhoj1HhGWUsac24plNU30wOfJKlq/vXLh0xA1UdZ8vQcNzcFY5X48BHvIHVMT9k5nQ=
X-Received: by 2002:a19:e004:: with SMTP id x4mr15643049lfg.419.1609168924663;
 Mon, 28 Dec 2020 07:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20201216022538.7389-1-vichy.kuo@gmail.com>
In-Reply-To: <20201216022538.7389-1-vichy.kuo@gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Mon, 28 Dec 2020 23:21:53 +0800
Message-ID: <CAOVJa8FTyX89MWieV3C+NmmDqS4EWi7Aok-j4_Tti_ZmVS050A@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM / devfreq: Replace devfreq->dev.parent as dev in devfreq_add_device
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi myungjoo, kyungmin and cw:
Would you please help to review this patch?

Thanks a lot.

pierre Kuo <vichy.kuo@gmail.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=8816=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In devfreq_add_device, replace devfreq->dev.parent
> as dev to keep code simple.
>
> Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6aa10de792b3..94cc25fd68da 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -893,13 +893,13 @@ struct devfreq *devfreq_add_device(struct device *d=
ev,
>                 goto err_devfreq;
>
>         devfreq->nb_min.notifier_call =3D qos_min_notifier_call;
> -       err =3D dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb=
_min,
> +       err =3D dev_pm_qos_add_notifier(dev, &devfreq->nb_min,
>                                       DEV_PM_QOS_MIN_FREQUENCY);
>         if (err)
>                 goto err_devfreq;
>
>         devfreq->nb_max.notifier_call =3D qos_max_notifier_call;
> -       err =3D dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb=
_max,
> +       err =3D dev_pm_qos_add_notifier(dev, &devfreq->nb_max,
>                                       DEV_PM_QOS_MAX_FREQUENCY);
>         if (err)
>                 goto err_devfreq;
> --
> 2.17.1
>
