Return-Path: <linux-pm+bounces-21777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C01A30441
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA516539B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9766A1EB191;
	Tue, 11 Feb 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycqy3atr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570D1D63F7
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258134; cv=none; b=f+ae0xVAP+a9Fgon6v2n+iO94RyQGGH9sJgIA+zdbVI4lacHpbRvzOOBEd4y8DresVXI9OcDaJLuXZoNeI/y//xQ83kde9fld8J64RXY7FIE2W3Q17U6ZbaXdHIJqoaNHOSkzcldGcCZMeA1G+L6vlUJUh986DHZVZb4ggugaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258134; c=relaxed/simple;
	bh=a+SKBh55AkQwYZrfdvManTiJRIi7EDKWKDZDpzgL7vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOwDpVDCHD+sJB+k9yee2KHhzU5cU+kwbNxlsVa17tUxtG/sYPYWexWz+V/OvBsDaUo3eB06dzh/EpSapKj21Pv6IrKFRdTbAR2dG6VzjqqMh7Aq0MZBGbN4ZduPznnYnu9i3UYgU2keXIlWhs91gFdz6pl+yB7eLDyOov380dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ycqy3atr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f5a224544so42279555ad.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 23:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739258131; x=1739862931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vD+EgsZ0T7PDMw/bMLDaz1PONiZNjDPIMfFzu3/y2Rc=;
        b=ycqy3atrmqBo8HLOmmY5HyLv+Qo1KIVBOk3uT4jhAJtO7oN8CJfScCulymd5NSCbQ6
         wYRO6PuNjILbLk+P4zfFc18gCfOFrk1YbExiCSWdpkDMicvDyCUPoUHKhpVxM/KTJpkm
         ft/TKo1xcdDZBocgR8wLaQR091hZ0FHaRvWYCZzyw6bZ/9bQGiGaJGN3WTxNE1lZu20S
         hgH2Be7VPgR826F6bBf1dCrp3n9Gwe7bYkNueR8N10C02O/Jg8P51IgyDchWMBFSk4jC
         dFqlOpVfVtdNiGcwUfrvfIJV6ibSk8bniPR+O6De/3aRzRGfCB6yBkwBtPujfFXI+Ad9
         eNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258131; x=1739862931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vD+EgsZ0T7PDMw/bMLDaz1PONiZNjDPIMfFzu3/y2Rc=;
        b=OBieYmC5YbL5OfT/9ZXy81f45/v2AZh5koG4iuujyZ3WvzDmrHVGJ91Kb9tdv6XpZh
         t9As5jB2118LB+kukHPFZCnaMAGH6MdpNs3b4TP7zR2RmufnD3ACnQNRg3PGV087Br0o
         JW+2w5Vh7Jo2OZqD8LFJtChzuxcWcUxrBFgWM93/mS+GvfNGsKlNlph4kSZeJ2LIxQwD
         Pi9zkDUlv5C0snC16qG64Ry3CH11q5IYO2hBui4jiY8LfyYUtL3g+RsRdv7o4KGPIkzU
         6FZyu7LwYLXLsX2JLl15R3J+tqMs1JMS4fGblf8ol1/WqcH1LdwakIW3awqTvF9PsJUn
         7YfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3g11s+RdpVw5qmSxRv1iwZ0cvZpzVb1E+BMaEqXU/Pj0K4EwIa7L2m3CmCi4nVR2zwXtUaZx6Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJma9b8cw3fxW6uQzctp1wA1N3kKp0H320Vq1G56ws+uXFDG76
	KGE5APGvFglGBRCdyheXqJPBDStoobccSYDz4HH5vEfxKFgNExHxcuVhqlu1tQ==
X-Gm-Gg: ASbGncuab2M0/FDeSOvuZ78sC8E4mny/DA4SVh1oeJ3wN116DIt2/cqAD0XWjGwIUZx
	DXyKAxHbqAhMcu79iQWnXRi+E02cN4k7pKm41gJTvc+laM5Tq/SbMV0pLv4II3Iys+zmCDR4qPP
	EOad1laUz5dkoK8hUG8cnIhCCHAq//TsBMbRosglrR6xmn6m91beDSy50oGcALSe88htUcrS0Wc
	vxFxIPIleZ+Zc61mRcnxPSScl5/y2GPRVfmAzSCpvIDYcmRaZcXOZZ0h/UYYAe0oz9frBlj6Dcz
	ViKX2VM0oJX9WuVW+/qJSKx7ow==
X-Google-Smtp-Source: AGHT+IHXWpkWXnY0YN0Dt30stPJV13qAiNuqoc6gzlnixFD8RnVzl3TtjB3rZRgLYzNlQ56fzxsgrA==
X-Received: by 2002:a17:902:d4c7:b0:21f:6005:503d with SMTP id d9443c01a7336-21f60055488mr226844615ad.42.1739258131023;
        Mon, 10 Feb 2025 23:15:31 -0800 (PST)
Received: from thinkpad ([36.255.17.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm90632165ad.168.2025.02.10.23.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 23:15:30 -0800 (PST)
Date: Tue, 11 Feb 2025 12:45:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 3/7] pmdomain: core: Introduce
 dev_pm_genpd_rpm_always_on()
Message-ID: <20250211071523.fd6zss7jjtqivw6a@thinkpad>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <1738736156-119203-4-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1738736156-119203-4-git-send-email-shawn.lin@rock-chips.com>

On Wed, Feb 05, 2025 at 02:15:52PM +0800, Shawn Lin wrote:
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

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Changes in v7: None
> Changes in v6:
> - export dev_pm_genpd_rpm_always_on()
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pmdomain/core.c   | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h |  7 +++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 6c94137..9b2f28b 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -697,6 +697,37 @@ bool dev_pm_genpd_get_hwmode(struct device *dev)
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
> +	struct generic_pm_domain *genpd;
> +
> +	genpd = dev_to_genpd_safe(dev);
> +	if (!genpd)
> +		return -ENODEV;
> +
> +	genpd_lock(genpd);
> +	dev_gpd_data(dev)->rpm_always_on = on;
> +	genpd_unlock(genpd);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>  	unsigned int state_idx = genpd->state_idx;
> @@ -868,6 +899,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>  		if (!pm_runtime_suspended(pdd->dev) ||
>  			irq_safe_dev_in_sleep_domain(pdd->dev, genpd))
>  			not_suspended++;
> +
> +		/* The device may need its PM domain to stay powered on. */
> +		if (to_gpd_data(pdd)->rpm_always_on)
> +			return -EBUSY;
>  	}
>  
>  	if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 1aab313..d56a78a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -261,6 +261,7 @@ struct generic_pm_domain_data {
>  	unsigned int rpm_pstate;
>  	unsigned int opp_token;
>  	bool hw_mode;
> +	bool rpm_always_on;
>  	void *data;
>  };
>  
> @@ -293,6 +294,7 @@ ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
>  void dev_pm_genpd_synced_poweroff(struct device *dev);
>  int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
>  bool dev_pm_genpd_get_hwmode(struct device *dev);
> +int dev_pm_genpd_rpm_always_on(struct device *dev, bool on);
>  
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -376,6 +378,11 @@ static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
>  	return false;
>  }
>  
> +static inline int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
>  #endif
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

