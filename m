Return-Path: <linux-pm+bounces-17415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3C9C5A83
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCEC287E7E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFA81FF616;
	Tue, 12 Nov 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLYgBylq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AC1FEFC4
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422210; cv=none; b=GFVXRURPINPwSqCjU+enAwtpwLTn1T+mHnP6Wzc2kbnnRcNcIk9Pcl0x+1CVOXhuUmmiE6Oa3Ua4rxEB1ivGnxB7x2FKDJ41HahdzuXM/MlorHu9a/xDlbzYdxkxvHH97HxXewTNGZDjLOtv5FlbAbA9NeD/wtd8EZDhfekLi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422210; c=relaxed/simple;
	bh=nGSESZ6LNWlBpxc8EUBXwUNaqDZlgGKDnCYvlQF63Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6eiJB2tklT1HRZfbqeZF9fjAmYI/oI1EMNzCcvgOwWfZNASUgO6ehafxFL6N3IdaCA96kBnchDD0ZVaEjTsSLooghJGfiEUE6LMnOvJAV2xCq45K3EOoPWv2Y/GFcTVkF8hro4qYOMVhqL/2Vr5trhIBwMNL3t9gx0fE7KuAzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLYgBylq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea8419a57eso60190607b3.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 06:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731422206; x=1732027006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cgmhvMmvsAX1eZX0S9Wvwi35LFfEY0JKL1PQexUj2Y4=;
        b=lLYgBylqf4JGYHIAG9Pej55FryJ3xC7hckui+u97hmGezb4Nyre1pd/c1tO55pFggh
         Lj2UHnnJxPmYZkcpds7nqAfNwonKfPQe2KcNTa/pZ/bSoOnHEmHhNqIYsnJdeQ8+oFbq
         Vd+2Dbce87vv2DotmBo23gj2G4zxvwh4Kw5Xkpl+4I9SEbS0GshUOAsFE0+INM6zseim
         zHjdDNHwlYwjkkS3PS3Ktiyak9X0fv5GqExTAaEUIl94RK/EajtkhANtbt1tRGiyJGCs
         lwhk5g3Zsd3F7+fDLpRxq3mGGxtaQ17bEt7LBgft9GtLoqg/3tc2HnGmTy4KY8kw2vTP
         TTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731422206; x=1732027006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgmhvMmvsAX1eZX0S9Wvwi35LFfEY0JKL1PQexUj2Y4=;
        b=XM8f3mwtyNMBP9dvabEazGvLRUAQqdOvf61No1/IFm0sFUoRbqqqF95a3yMwVz/PGb
         xhnNc2SmuUk65RjYkcTG4/xkiI/LIeA6wEYBthGVlyqJKhDK04dwGzm9oykfdZOO1BGP
         Ck2o3ih34ZKmDZEzsSLDPmYG3lSP7sfyLTA6dtW0X18XeD7MkazDcUrxT3RZCO11f64G
         PWUfW6ST8XILLPyImsncw2lgZelH2nmBX13cK8/2bjGsvE6lcA9nB9VyrNGxI14c83Jz
         cTfC6OPKBuXb+sL/b+9jWKkTVlShbAB9/48EqwuBCTPtRDNjO1zPu5EgWDmlGUj5QVjK
         dNRw==
X-Forwarded-Encrypted: i=1; AJvYcCWg44cgq4wx9aBGTP6yvTFrkxsZKpz/eOxMxGZs1VAh3T2qyvSyEyfeclI10oboOPewWlPZLTWjYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhE9Uk5ove1hKoPvTeEBxa3fMOAIhc6mSC8gt9G+tYy/iNA16Y
	dGvC9PJBu/20bj5ujkd+y2MzqG/NNJQD4In9V4zc/DEsHYPysoIB9ZLxqrfBrXyMJsm85UaJnRk
	otWTJS6Zp42OsU1SWtrTJTL+QWj5/yVzAXaPtTg==
X-Google-Smtp-Source: AGHT+IH9rSK+tLCTRixNouZv18mLFyvn8FHIuZnQADkcw+GhR4qfmbtPJ/eLDOrbx7U/Aj+xJlWgGqMHWo5EW1qAGx8=
X-Received: by 2002:a05:690c:6885:b0:6ea:90b6:ab48 with SMTP id
 00721157ae682-6eaddd98875mr166222807b3.18.1731422206552; Tue, 12 Nov 2024
 06:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com> <1731048987-229149-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1731048987-229149-4-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 15:36:09 +0100
Message-ID: <CAPDyKFp0LKaqhdybGow7T72Vac52=bP3PjYL2920=SJzmYB06Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 07:57, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For some usecases a consumer driver requires its device to remain power-on
> from the PM domain perspective during runtime. Using dev PM qos along with
> the genpd governors, doesn't work for this case as would potentially
> prevent the device from being runtime suspended too.
>
> To support these usecases, let's introduce dev_pm_genpd_rpm_always_on() to
> allow consumers drivers to dynamically control the behaviour in genpd for a
> device that is attached to it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  drivers/pmdomain/core.c   | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h |  7 +++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 5ede0f7..2ccfcb7 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -692,6 +692,36 @@ bool dev_pm_genpd_get_hwmode(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
>
> +/**
> + * dev_pm_genpd_rpm_always_on() - Control if the PM domain can be powered off.
> + *
> + * @dev: Device for which the PM domain may need to stay on for.
> + * @on: Value to set or unset for the condition.
> + *
> + * For some usecases a consumer driver requires its device to remain power-on
> + * from the PM domain perspective during runtime. This function allows the
> + * behaviour to be dynamically controlled for a device attached to a genpd.
> + *
> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> + * while this routine is getting called.
> + *
> + * Return: Returns 0 on success and negative error values on failures.
> + */
> +int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       genpd = dev_to_genpd_safe(dev);
> +       if (!genpd)
> +               return -ENODEV;
> +
> +       genpd_lock(genpd);
> +       dev_gpd_data(dev)->rpm_always_on = on;
> +       genpd_unlock(genpd);
> +
> +       return 0;
> +}

We need and EXPORT_SYMBOL_GPL() here too.

[...]

Kind regards
Uffe

