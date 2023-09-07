Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C065D79759E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbjIGPwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 11:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbjIGPu1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 11:50:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5408059C8
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 08:40:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso1518445a12.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101193; x=1694705993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G88lP2VW9W0ey1BM427zqcg+F+UpGhl5q2J3uTfo6Co=;
        b=RYvAW12lvwz6uAP68SCj8UMmHJ89SRlK+6d122349mGXAdsbxvLjszlzUGIo2TvBVm
         N0F+ZfRlcc2dRpJ6I1uZRd+dKy+92Zg6LudvV3RYvTWa+o4iBPozvQmzeC5mUQTn5XvD
         l5//40QCM+ZcLWM7/3bwqsFpm4UxHflEySB9eLsV9W2yYvar2pKZYNKHlEttZoaiSCwf
         ps+mlX3CQWfv00nyWXa3yeoJtKC7PU5VJCjCchTwIRj9cEb5W8MXwN6JugkT4akMdXbe
         VCW5LEYEi69UWF39j4cC/+oV4DyfQmCqpbs+ZpOqO0uUvn0uD2nU5OUln6su6IVtnccH
         z6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101193; x=1694705993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G88lP2VW9W0ey1BM427zqcg+F+UpGhl5q2J3uTfo6Co=;
        b=lawtjCxTNdmCuKmtIJJqKfxItmRXAp10d3zElxCPBsRWTAH9H+4wh1yjL+1XmuazaT
         O/9j5A+/JMk4tbpyfADWmZTus99l8DON7TRmZeR8dUCA67vBV3mClK+uIzSM1PAyFtCD
         CzneI6wO2+Aaqky1r3l7NNyKZJX93T9HpX0jZ0Tib9Hr2kerl8SKEYQJOz+0tUARz7ZN
         0GBC2xsCcbXGzJtX5AtRwboGdRyaHX/1ZOTksdwekYKRzi4YW95Y6A5GhBUgkkOE+i+2
         SVl2qNYiuqf00lY83HkhJ1KJZQ95emJh7yJ13CbLNnxtj/R8YY1sfcy0oCBkI/U87L/a
         cvrw==
X-Gm-Message-State: AOJu0YwEQKH6bj3JfQZ4xwl5TR3cRl/u23nrMit1tLaZSm8gWkVVPXDB
        MBAqSK0AAJ3HtF2CQayXjR/qqQ5wQ4Uxp4ROO4o=
X-Google-Smtp-Source: AGHT+IHGT591APG6CRNW4zuyJuEfxCr1FfGrojCK5qI1ehGXhuwAoMXIKQPf6+hAJXIGsQZ5/i+wTg==
X-Received: by 2002:a1c:ed08:0:b0:3fe:2b60:b24e with SMTP id l8-20020a1ced08000000b003fe2b60b24emr4801517wmh.29.1694084900263;
        Thu, 07 Sep 2023 04:08:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ay30-20020a5d6f1e000000b0031f65cdd271sm3999677wrb.100.2023.09.07.04.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:08:19 -0700 (PDT)
Date:   Thu, 7 Sep 2023 14:08:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] power: supply: mt6370: Fix missing error code in
 mt6370_chg_toggle_cfo()
Message-ID: <1092ffb3-0238-4dc0-baf3-344a653fca3f@kadam.mountain>
References: <20230906084815.2827930-1-harshit.m.mogalapalli@oracle.com>
 <cd6eea67-df0f-08b1-61cd-57a3b4f9cf0d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd6eea67-df0f-08b1-61cd-57a3b4f9cf0d@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 07, 2023 at 12:43:12PM +0200, AngeloGioacchino Del Regno wrote:
> Il 06/09/23 10:48, Harshit Mogalapalli ha scritto:
> > When mt6370_chg_field_get() suceeds, ret is set to zero and returning
> > zero when flash led is still in strobe mode looks incorrect.
> > 
> > Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > This is based on static analysis with smatch, only compile tested.
> > ---
> >   drivers/power/supply/mt6370-charger.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
> > index f27dae5043f5..a9641bd3d8cf 100644
> > --- a/drivers/power/supply/mt6370-charger.c
> > +++ b/drivers/power/supply/mt6370-charger.c
> > @@ -324,7 +324,7 @@ static int mt6370_chg_toggle_cfo(struct mt6370_priv *priv)
> >   	if (fl_strobe) {
> >   		dev_err(priv->dev, "Flash led is still in strobe mode\n");
> > -		return ret;
> > +		return -EINVAL;
> 
> I think that returning 0 here was intentional, but I agree on a return ret
> here being both confusing and wrong.

If it's a success path then probably we should remove the dev_err().

regards,
dan carpenter

