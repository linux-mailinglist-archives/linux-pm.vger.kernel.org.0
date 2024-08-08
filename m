Return-Path: <linux-pm+bounces-11988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D9D94BB80
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 12:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CE51C20B53
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53718A6D6;
	Thu,  8 Aug 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YM1JIe0h"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B318C337;
	Thu,  8 Aug 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113710; cv=none; b=qmQwVmuORw+GMuzuzmkEMhsP132lHLJCHjg0F0YGfdeWBHhb2HADDAdCZfhWr26XBddd6UqdaNGmXkE2Rtidn3+X+5zLMkJTaTIDvx3fDL0CB5pMrF7Pjhg78eFYKsIl9nVQAYJvy0nP2nLI5uAXyXliEJlkQTT80szcocjIyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113710; c=relaxed/simple;
	bh=/8R4v1hdwg6XIAC/vX8wn/K3d6yUMIKlqqV3Tif+SEE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqLU8nuu0QymVI6W85gCADJnzm4irdw+MDdihS4U6/bNbW6ongleBnOXzsdi5d80y6lUE6QAMi8AxyIXKIbicPTMCl3NXm5aeejd5wlH22xk2+zN6dHPGh0tc41kDQ8fvRkz7xFzQH25qbUBI8tneDcnhm8zR7g8tZHmM45Fkuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YM1JIe0h; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478AfWqY042517;
	Thu, 8 Aug 2024 05:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723113692;
	bh=QLiQZmW8PMGETBACeXlTL21T7vgBVAfTojVequDO7Zo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YM1JIe0hXtm1Ev3fvW6KRy+X6yZRgHFHzPmcL24X/+PHjObcsr7k58tVGDJJxgjNt
	 0zfhHPN4xF76khM2nDh/u0oFlcZSrzOOnM3403zyAjqpfMX1Nc6z2xRPGbfJZveMmS
	 hUDQ9KwNps80JjKXCxFqGZfE+F5ioG4wwRWckyPg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478AfWAF067586
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 05:41:32 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 05:41:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 05:41:32 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478AfVvG048375;
	Thu, 8 Aug 2024 05:41:31 -0500
Date: Thu, 8 Aug 2024 16:11:30 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len
 Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Bryan O'Donoghue"
	<bryan.odonoghue@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PM: domains: add device managed version of
 dev_pm_domain_attach|detach_list()
Message-ID: <20240808104130.3lehlvkcprag2md6@lcpd911>
References: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
 <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Aug 07, 2024 at 12:45:46 +0530, Dikshita Agarwal wrote:
> Add the devres-enabled version of dev_pm_domain_attach|detach_list.
> If client drivers use devm_pm_domain_attach_list() to attach the
> PM domains, devm_pm_domain_detach_list() will be invoked implicitly
> during remove phase.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/base/power/common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 13 +++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 327d168..729d6c2 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -277,6 +277,50 @@ int dev_pm_domain_attach_list(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
>  
>  /**
> + * devm_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
> + * @_list: The list of PM domains to detach.
> + *
> + * This function reverse the actions from devm_pm_domain_attach_list().
> + * it will be invoked during the remove phase from drivers implicitly if driver
> + * uses devm_pm_domain_attach_list() to attach the PM domains.
> + */
> +void devm_pm_domain_detach_list(void *_list)
> +{
> +	struct dev_pm_domain_list *list = _list;
> +
> +	dev_pm_domain_detach_list(list);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_detach_list);
> +
> +/**
> + * devm_pm_domain_attach_list - devres-enabled version of dev_pm_domain_attach_list
> + * @dev: The device used to lookup the PM domains for.
> + * @data: The data used for attaching to the PM domains.
> + * @list: An out-parameter with an allocated list of attached PM domains.
> + *
> + * NOTE: this will also handle calling devm_pm_domain_detach_list() for
> + * you during remove phase.
> + *
> + * Returns the number of attached PM domains or a negative error code in case of
> + * a failure.
> + */
> +int devm_pm_domain_attach_list(struct device *dev,
> +			       const struct dev_pm_domain_attach_data *data,
> +			       struct dev_pm_domain_list **list)
> +{
> +	int ret, num_pds = 0;

Do we require this =0? In the very next line you're initing this anyway.

> +
> +	num_pds = dev_pm_domain_attach_list(dev, data, list);
> +
> +	ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, *list);
> +	if (ret)
> +		return ret;
> +
> +	return num_pds;
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_attach_list);
> +
> +/**
>   * dev_pm_domain_detach - Detach a device from its PM domain.
>   * @dev: Device to detach.
>   * @power_off: Used to indicate whether we should power off the device.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 772d328..efd517017 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -450,8 +450,12 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
>  int dev_pm_domain_attach_list(struct device *dev,
>  			      const struct dev_pm_domain_attach_data *data,
>  			      struct dev_pm_domain_list **list);
> +int devm_pm_domain_attach_list(struct device *dev,
> +			       const struct dev_pm_domain_attach_data *data,
> +			       struct dev_pm_domain_list **list);
>  void dev_pm_domain_detach(struct device *dev, bool power_off);
>  void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
> +void devm_pm_domain_detach_list(void *list);

Why not just call it dev_pm_domain_list *list? Why make it void? I am a
bit confused.


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

