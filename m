Return-Path: <linux-pm+bounces-12425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD7956BCE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342F9284853
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFF5176AAA;
	Mon, 19 Aug 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCp9+co0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B41741FE;
	Mon, 19 Aug 2024 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073627; cv=none; b=frHKBFo39IjFI0O2otGcfMLHaIdPan4xdL+46b1+eXbkmQQ2Ctp81EztnKMIHr1/G5Kq0JcNYk0iAj5/JvMw4ZbLtkXRK+vs5zORM3cWqU5TXt2PAw80w+XgSXIpdCI+TLY/OX0vOQFgR5LRekgv8IglGDhGNT+FyOfL9xfYzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073627; c=relaxed/simple;
	bh=50I8COzcE/JeGElXTnODDmOHDeO1Gj1w/aX2OmR9j2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIVzbFQ6H2Dp8mi1S1iFUZT41a1dTapaJE4d2JZoML0VHEs0vzm3NjbBmeFT1mQ2Hodqmj03updloMvKeGoNCInU+O+x9An0pPrzgN3QjUcPJWX62D2nMvmlids8O8tORqk30UQkKqYq0SCKFcSl7OUy7r8D7elqhpj5d+FO0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCp9+co0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724073626; x=1755609626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=50I8COzcE/JeGElXTnODDmOHDeO1Gj1w/aX2OmR9j2c=;
  b=JCp9+co0mds8Co3DaWiU/Ey1NEMR9xLEmT/qZZPxRE6N6Gpx5oWWPCqy
   rzlEdvHwVQJs7tSuzM/4CgL3xeTqjioIRy7gOiI498iddplsjEOf76Fb2
   7N99ZXJXS5uyunb6A9qsVcWYUHGQz2DUdXv8JmRg+s8nM5dfWdEX0Sweq
   B+zvGy5Z+/h79Y49uNkjCz0Yjl9K9mThnOh26agJuMuv1cdGKnWtDG4jK
   SYxlNTn53ONmExH9QUBnnlFW6y5+XnUC46vCg+F6lF2KoX0Zr8gMCBzLz
   sByKrAIyQ9hYAxTT1j3dODFvpfPzMUzgegL+MMqJ828i+Et/RUzC+9T7+
   Q==;
X-CSE-ConnectionGUID: JpYCyj9XT36pqxPW5B3JEQ==
X-CSE-MsgGUID: dvq3sOA3Qf2UdSKUFCiIew==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="44841603"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="44841603"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:20:09 -0700
X-CSE-ConnectionGUID: cSOzekq9SCqObRfLMNEFpw==
X-CSE-MsgGUID: H5Sc6wXtTbSVGkbW6dCZ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60679966"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 19 Aug 2024 06:20:03 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Aug 2024 16:20:02 +0300
Date: Mon, 19 Aug 2024 16:20:02 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Chris Lew <quic_clew@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Amit Pundir <amit.pundir@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] soc: qcom: pmic_glink: Fix race during initialization
Message-ID: <ZsNGgmnZfZs+Z50R@kuha.fi.intel.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <20240818-pmic-glink-v6-11-races-v1-1-f87c577e0bc9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-1-f87c577e0bc9@quicinc.com>

On Sun, Aug 18, 2024 at 04:17:37PM -0700, Bjorn Andersson wrote:
> As pointed out by Stephen Boyd it is possible that during initialization
> of the pmic_glink child drivers, the protection-domain notifiers fires,
> and the associated work is scheduled, before the client registration
> returns and as a result the local "client" pointer has been initialized.
> 
> The outcome of this is a NULL pointer dereference as the "client"
> pointer is blindly dereferenced.
> 
> Timeline provided by Stephen:
>  CPU0                               CPU1
>  ----                               ----
>  ucsi->client = NULL;
>  devm_pmic_glink_register_client()
>   client->pdr_notify(client->priv, pg->client_state)
>    pmic_glink_ucsi_pdr_notify()
>     schedule_work(&ucsi->register_work)
>     <schedule away>
>                                     pmic_glink_ucsi_register()
>                                      ucsi_register()
>                                       pmic_glink_ucsi_read_version()
>                                        pmic_glink_ucsi_read()
>                                         pmic_glink_ucsi_read()
>                                          pmic_glink_send(ucsi->client)
>                                          <client is NULL BAD>
>  ucsi->client = client // Too late!
> 
> This code is identical across the altmode, battery manager and usci
> child drivers.
> 
> Resolve this by splitting the allocation of the "client" object and the
> registration thereof into two operations.
> 
> This only happens if the protection domain registry is populated at the
> time of registration, which by the introduction of commit '1ebcde047c54
> ("soc: qcom: add pd-mapper implementation")' became much more likely.
> 
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Closes: https://lore.kernel.org/all/CAMi1Hd2_a7TjA7J9ShrAbNOd_CoZ3D87twmO5t+nZxC9sX18tA@mail.gmail.com/
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/ZqiyLvP0gkBnuekL@hovoldconsulting.com/
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Closes: https://lore.kernel.org/all/CAE-0n52JgfCBWiFQyQWPji8cq_rCsviBpW-m72YitgNfdaEhQg@mail.gmail.com/
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/power/supply/qcom_battmgr.c   | 16 ++++++++++------
>  drivers/soc/qcom/pmic_glink.c         | 28 ++++++++++++++++++----------
>  drivers/soc/qcom/pmic_glink_altmode.c | 17 +++++++++++------
>  drivers/usb/typec/ucsi/ucsi_glink.c   | 16 ++++++++++------
>  include/linux/soc/qcom/pmic_glink.h   | 11 ++++++-----
>  5 files changed, 55 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 49bef4a5ac3f..df90a470c51a 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1387,12 +1387,16 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>  					     "failed to register wireless charing power supply\n");
>  	}
>  
> -	battmgr->client = devm_pmic_glink_register_client(dev,
> -							  PMIC_GLINK_OWNER_BATTMGR,
> -							  qcom_battmgr_callback,
> -							  qcom_battmgr_pdr_notify,
> -							  battmgr);
> -	return PTR_ERR_OR_ZERO(battmgr->client);
> +	battmgr->client = devm_pmic_glink_new_client(dev, PMIC_GLINK_OWNER_BATTMGR,
> +						     qcom_battmgr_callback,
> +						     qcom_battmgr_pdr_notify,
> +						     battmgr);
> +	if (IS_ERR(battmgr->client))
> +		return PTR_ERR(battmgr->client);
> +
> +	pmic_glink_register_client(battmgr->client);
> +
> +	return 0;
>  }
>  
>  static const struct auxiliary_device_id qcom_battmgr_id_table[] = {
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 9ebc0ba35947..58ec91767d79 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -66,15 +66,14 @@ static void _devm_pmic_glink_release_client(struct device *dev, void *res)
>  	spin_unlock_irqrestore(&pg->client_lock, flags);
>  }
>  
> -struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
> -							  unsigned int id,
> -							  void (*cb)(const void *, size_t, void *),
> -							  void (*pdr)(void *, int),
> -							  void *priv)
> +struct pmic_glink_client *devm_pmic_glink_new_client(struct device *dev,
> +						     unsigned int id,
> +						     void (*cb)(const void *, size_t, void *),
> +						     void (*pdr)(void *, int),
> +						     void *priv)
>  {
>  	struct pmic_glink_client *client;
>  	struct pmic_glink *pg = dev_get_drvdata(dev->parent);
> -	unsigned long flags;
>  
>  	client = devres_alloc(_devm_pmic_glink_release_client, sizeof(*client), GFP_KERNEL);
>  	if (!client)
> @@ -85,6 +84,18 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
>  	client->cb = cb;
>  	client->pdr_notify = pdr;
>  	client->priv = priv;
> +	INIT_LIST_HEAD(&client->node);
> +
> +	devres_add(dev, client);
> +
> +	return client;
> +}
> +EXPORT_SYMBOL_GPL(devm_pmic_glink_new_client);
> +
> +void pmic_glink_register_client(struct pmic_glink_client *client)
> +{
> +	struct pmic_glink *pg = client->pg;
> +	unsigned long flags;
>  
>  	mutex_lock(&pg->state_lock);
>  	spin_lock_irqsave(&pg->client_lock, flags);
> @@ -95,11 +106,8 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
>  	spin_unlock_irqrestore(&pg->client_lock, flags);
>  	mutex_unlock(&pg->state_lock);
>  
> -	devres_add(dev, client);
> -
> -	return client;
>  }
> -EXPORT_SYMBOL_GPL(devm_pmic_glink_register_client);
> +EXPORT_SYMBOL_GPL(pmic_glink_register_client);
>  
>  int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
>  {
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index 1e0808b3cb93..e4f5059256e5 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -520,12 +520,17 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>  			return ret;
>  	}
>  
> -	altmode->client = devm_pmic_glink_register_client(dev,
> -							  altmode->owner_id,
> -							  pmic_glink_altmode_callback,
> -							  pmic_glink_altmode_pdr_notify,
> -							  altmode);
> -	return PTR_ERR_OR_ZERO(altmode->client);
> +	altmode->client = devm_pmic_glink_new_client(dev,
> +						     altmode->owner_id,
> +						     pmic_glink_altmode_callback,
> +						     pmic_glink_altmode_pdr_notify,
> +						     altmode);
> +	if (IS_ERR(altmode->client))
> +		return PTR_ERR(altmode->client);
> +
> +	pmic_glink_register_client(altmode->client);
> +
> +	return 0;
>  }
>  
>  static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 16c328497e0b..ac53a81c2a81 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -367,12 +367,16 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  		ucsi->port_orientation[port] = desc;
>  	}
>  
> -	ucsi->client = devm_pmic_glink_register_client(dev,
> -						       PMIC_GLINK_OWNER_USBC,
> -						       pmic_glink_ucsi_callback,
> -						       pmic_glink_ucsi_pdr_notify,
> -						       ucsi);
> -	return PTR_ERR_OR_ZERO(ucsi->client);
> +	ucsi->client = devm_pmic_glink_new_client(dev, PMIC_GLINK_OWNER_USBC,
> +						  pmic_glink_ucsi_callback,
> +						  pmic_glink_ucsi_pdr_notify,
> +						  ucsi);
> +	if (IS_ERR(ucsi->client))
> +		return PTR_ERR(ucsi->client);
> +
> +	pmic_glink_register_client(ucsi->client);
> +
> +	return 0;
>  }
>  
>  static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
> diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
> index fd124aa18c81..aedde76d7e13 100644
> --- a/include/linux/soc/qcom/pmic_glink.h
> +++ b/include/linux/soc/qcom/pmic_glink.h
> @@ -23,10 +23,11 @@ struct pmic_glink_hdr {
>  
>  int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len);
>  
> -struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
> -							  unsigned int id,
> -							  void (*cb)(const void *, size_t, void *),
> -							  void (*pdr)(void *, int),
> -							  void *priv);
> +struct pmic_glink_client *devm_pmic_glink_new_client(struct device *dev,
> +						     unsigned int id,
> +						     void (*cb)(const void *, size_t, void *),
> +						     void (*pdr)(void *, int),
> +						     void *priv);
> +void pmic_glink_register_client(struct pmic_glink_client *client);
>  
>  #endif

-- 
heikki

