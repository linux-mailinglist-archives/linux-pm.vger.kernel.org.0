Return-Path: <linux-pm+bounces-19522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7E9F7D46
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A1D189370E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628F2253E0;
	Thu, 19 Dec 2024 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHFC16b/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2513222589
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619272; cv=none; b=mYrcDf2vKh2gJqMf31zIlX6bE7EagXmSUkuGMWZ7tdOUhQy5ng9+tqbX0jN+QUo6nZ6gwrnUIgyk+Mjh9qW/md7oZaHIVLqZFnSzG/2X7JARDJd7NTo2nH8kbwTHi1PO9N1Jb7ySop/8RPLNEtrebH+ydIA5c4/4nhck0hYYAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619272; c=relaxed/simple;
	bh=vMSYw+Bgio0lxIGWKKM/RKV1s5Tfd4YdcDfX13ZSMXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG5vBcF3C3K/PDwte/Ylgjr/Z3oFgsVZC/0dlTZImNJBfuvt/3/iMQiMw+VUUCpZo8osN9AeRnvSS4QSVwJJJtgsFQIYtlaZe2obAR0iAkGYYk2EutnbeGNnBroJq7I98klru0NXEO/KT6fYPNLBrNrP3GMlEVis/MZdOPzfBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NHFC16b/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f150ddc86dso7306067b3.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734619265; x=1735224065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TeT0U3eIEbCmx0OA+XLlcN5xhRKLPQ6LWGy+dENDTY=;
        b=NHFC16b/oTBSvq/9ScO1DF31pggPw5/oRI1Zicy8+3J2mOdq32e1N6UTNK8WRFYgwk
         2TGBuvpA3ZqyZu05HfRcDMBYoPRpAtAJpm2dojgg2PqGnlFPtoOBtCP3DSvAtmYleIe/
         osRF3Q0t8V5YliKr9OrfGytWj34ns0uBQnPb/WqgPRnYK+0Dmz7nx8L2RRUPxAgCTAL5
         Xu3sTpPYTwj1ErWmKnnzMGmfoF5kknadtoxIWzObrzCVfOOfdiC9j+7O0IitdNc3WIGZ
         vrLUMsIX3LAzaY0+ozKHCnBdBW3C03AaTbjbBeDkE9gh9v2wtoO2iJ3qiizE8nrZ9T91
         Gxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619265; x=1735224065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TeT0U3eIEbCmx0OA+XLlcN5xhRKLPQ6LWGy+dENDTY=;
        b=Y4D6wFIWUnLBOT+IGYj04cBnrUaQU3Et2Tvyr3Yx3bRjsWn4np6b4676W5xj8R4DI/
         F7IOF8/xan9cVauJHQSmXo48SskZVkKF8LaLKzkVYWGjmH6+pjj1CWjLPcUrEOUCAfZz
         uQ9LRJR24QcfqwWv7C0ue/u4K3EL/bUfAQB7tpUb+mFFzCv/vX9zK48bYPR5ZCvps+2Q
         SiglSoLfkeveDEY/ebLUjlLafrLDJ3S1GjcEmDsFFW9XEaxaP0etHdnVTBzHxVTuuuJb
         3T1wx/PN5AwjwLfwM/26FV6bdBbwnIafKB9dFolV8ByzxoyboXW0lfHNEnkUT6TWIZwP
         rjNg==
X-Gm-Message-State: AOJu0YwqmJQJsJNDubI/a6F2MnBBBCM8C0kD384nkN01wGifOX4yrM19
	MMKP3zPMbdRLU8pOPpb/cyAa3Jk9bWe5HJbVY7uYQgQWR3381YnbYjx3R5wCjHs85UU5VFtuzz6
	6YF1apaPz2JpSWEq5SidH9ArPlU5g38dJDCZ0Q5ZDu+V65Pu80WI=
X-Gm-Gg: ASbGnctyWohijAg01L1WdoC5KJ1LbY2pSJKiwSsJziDwVYOtuizLCXPlXwjF3l1ExQs
	rqnwuh2ibZlzf4w3I3ezKXGyKJ8RH9GLXjFUlMMA=
X-Google-Smtp-Source: AGHT+IHPNLFpfVQxpEq9GLLMxAjPgrZJFbEIGt7Waf/hyfZxDSmH4jeupi/atnJV2StzQ84SQYvJvTkX9YTLulbvdPs=
X-Received: by 2002:a05:690c:81c9:b0:6ef:86db:4356 with SMTP id
 00721157ae682-6f3d0f2c79dmr38907707b3.18.1734619265548; Thu, 19 Dec 2024
 06:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218184433.1930532-1-l.stach@pengutronix.de>
In-Reply-To: <20241218184433.1930532-1-l.stach@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Dec 2024 15:40:29 +0100
Message-ID: <CAPDyKFoeebzUkmeya4WEcdc+px-=8rwSGdmF_-1giiwkHvWo5Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: add dummy release function to genpd device
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, 
	patchwork-lst@pengutronix.de, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Dec 2024 at 19:44, Lucas Stach <l.stach@pengutronix.de> wrote:
>
> The genpd device, which is really only used as a handle to lookup
> OPP, but not even registered to the device core otherwise and thus
> lifetime linked to the genpd struct it is contained in, is missing
> a release function. After b8f7bbd1f4ec ("pmdomain: core: Add
> missing put_device()") the device will be cleaned up going through
> the driver core device_release() function, which will warn when no
> release callback is present for the device. Add a dummy release
> function to shut up the warning.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> It's a bit unfortunate that the genpd even needs to have this
> not-really-a-device just for the sake of the OPP lookup.

Right. Although, I have patches in the pipe that will make use of it
that isn't limited to the use for OPP.

> ---
>  drivers/pmdomain/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index bb11f467dc78..83659d79e07d 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2142,6 +2142,11 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
>         return 0;
>  }
>
> +static void genpd_release_opp_dev(struct device *dev)

The above said, would you mind changing the name to
"genpd_provider_release". Or something along those lines.

> +{
> +       /* nothing to be done here */
> +}
> +
>  static int genpd_alloc_data(struct generic_pm_domain *genpd)
>  {
>         struct genpd_governor_data *gd = NULL;
> @@ -2173,6 +2178,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
>
>         genpd->gd = gd;
>         device_initialize(&genpd->dev);
> +       genpd->dev.release = genpd_release_opp_dev;
>
>         if (!genpd_is_dev_name_fw(genpd)) {
>                 dev_set_name(&genpd->dev, "%s", genpd->name);
> --
> 2.47.1
>

Kind regards
Uffe

