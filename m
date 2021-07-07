Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE3F3BEFE9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhGGS6m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 14:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhGGS6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 14:58:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6EC061574
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 11:56:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f30so6729713lfj.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uJj5cg+B6WOKj1AJs6qGXZoKfwbkWhREZAmiOxgc1AI=;
        b=NdGX6yddKh1RjscPz8VqVDCBJzwT4RaMz86k/NegRYdW8Q4RaXgLiEF0P5erszGtKQ
         WQCSTLlmvH7jNYGn1ncaeez1m1C2rWSs/Q/JxwWifuQervfAM2ijIsF+8d7JkIu0CZgy
         4BE/r/YVZl2Vl7o68ZNqImuUofNw2pV30I18hiOsErN48ARBNwHlQau0lQmr+IrabE8o
         nZ1qh2wfl+wTgKzk7fqIQS+3mtbQfEdCx5uk6CSkcd1EnE0UkOQltP1LTPMcuTctxOCM
         rSYHAyMsl0+LUfWKJEYkQr1Nd43ucfQffQ0yp/1LVEPeKwyCI/ZA3+xxiJZYBpDr8oxl
         YIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uJj5cg+B6WOKj1AJs6qGXZoKfwbkWhREZAmiOxgc1AI=;
        b=gsWbg4K2Y3BcIfcrOeDqOZnCDgXezX/qFzunAsBDA1BWQ3ff8+jkEhpnm0wPPJPqUG
         VTLFfsrWR0JCFUPhpiUvLeeTvhuNfFPeDPrEdrI0fkGq1KBeOUY8yuPa9Z55JwfLtd37
         TkN93LkzqPwKt5hCgZq9p8wUQ7193Ftm3M6PkBmK+yjY2vDpsq9mYj0k6tjNJeEm8ZfD
         OeCuze9ZntoElrJ4hA+qNQHMbuHUXZZ5KVhVx3IwNSNRQShL5ioktqxpfHruJJnvhjVp
         wxMrc9ruq7pV/NnrBdWxX0uomz4M4cVHfj3yFgh+BPxDEfmTyDhDcbOpKacSo7GkxEt8
         uzaQ==
X-Gm-Message-State: AOAM531gM1Pve9MX4b5dE6ihLusgOge/IfNwT173lcWzwmstCOPd7zB9
        7dtUV+oKEo1VbPxB80r+eOZXpbPMcHE0989W
X-Google-Smtp-Source: ABdhPJwlxEAhNCtSwRPkCJ8XqZKPXB38kNP2exl21/jVoGQ6hihmSxTy/OVoLIaNI8Gy5q0rlK59qg==
X-Received: by 2002:a05:651c:10a8:: with SMTP id k8mr19990912ljn.99.1625684159594;
        Wed, 07 Jul 2021 11:55:59 -0700 (PDT)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id k9sm1214400lfo.202.2021.07.07.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:55:59 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:55:58 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 3/3] thermal: rcar_gen3_thermal: Fix datatype for loop
 counter
Message-ID: <YOX4vulWqmtjrn14@oden.dyn.berto.se>
References: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
 <20210707131306.4098443-4-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdUx19uGTX3nddkODwdzLeSGuZbuyac7VMitZv=1tgyPSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUx19uGTX3nddkODwdzLeSGuZbuyac7VMitZv=1tgyPSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your feedback.

On 2021-07-07 16:42:10 +0200, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> Thanks for your patch!
> 
> On Wed, Jul 7, 2021 at 3:14 PM Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > The loop counter 'i' should be unsigned int to match struct
> > rcar_gen3_thermal_priv num_tscs where it's stored.
> 
> It is also stored in rcar_gen3_thermal_tsc.id, which is still (signed) int.

Thanks.

> 
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -423,7 +423,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct resource *res;
> >         struct thermal_zone_device *zone;
> > -       int ret, i;
> > +       unsigned int i;
> > +       int ret;
> >
> >         /* default values if FUSEs are missing */
> >         /* TODO: Read values from hardware on supported platforms */
> 
> And perhaps:
> 
> -                dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
> +                dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
> 
> ?

Good catch, why do my compiler not warn for this? Did you catch this by 
review or have you some compiler magic I'm missing?

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Regards,
Niklas Söderlund
