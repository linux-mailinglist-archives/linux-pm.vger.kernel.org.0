Return-Path: <linux-pm+bounces-12021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19C294C915
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 06:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C0F1F2253C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 04:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940965FB9C;
	Fri,  9 Aug 2024 04:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GtcSSH/2"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA37182BD;
	Fri,  9 Aug 2024 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723177171; cv=none; b=Rg8CCNQqzHUr8BzIjAdNkaAmyqyX1iydCs2y4BaT7OW0EO0nJrvne+9f0izkXDebdnS9Krj0uUjBCOoDGERle0ruN/NyxLWTmWPb8wyBm06BPqk9Sf/1ZmYIymw0+Vi9iFpmuAIfRJMgR7XdSKx1k74+nj3kZWq2Pj7CLFJOP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723177171; c=relaxed/simple;
	bh=T+IR90vCl/ybRqWqiniM0YHXaQXuAi46GttcRjTx16k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBLH2AsrTygah8T/9gErzqvNrvrpVIYNuB6EwyXTowdioxXY+pBZciIqF8xAGva80Qv1c0sQpvSZcoyiXHEs5yvZHQB8V5bTZPFSsabQU02w0nLR6T5bBtJe8ePcPR9DZdOjvE9Vrr2s27YzJeoqigCwozm3TJRlidatV1nEf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GtcSSH/2; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4794JFNR110853;
	Thu, 8 Aug 2024 23:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723177155;
	bh=w0KreaZsLFoMJJTOWogDLvkF2PqIqokxZLI4HI9MM2w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GtcSSH/2My2Npq0I4OwELgMmitjpphVRiDDDQlgZi5ZGpwXCEeQtLV+i2MihR3nX8
	 QaIyi+b1zI18M6cIIG5NnL3n0jBWDmuAJq/m1BG2as2RYzaD0P2hsIieOvLuE5KHN3
	 pfqzAm6B8XJi8Fp8mVMQFPBDL3xEyrh6hWRaPHu4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4794JFAu124014
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 23:19:15 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 23:19:15 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Thu, 8 Aug
 2024 23:19:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 23:19:14 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4794JEDR071971;
	Thu, 8 Aug 2024 23:19:14 -0500
Date: Fri, 9 Aug 2024 09:49:13 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "Len
 Brown" <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio"
	<konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf
 Hansson <ulf.hansson@linaro.org>,
        "Bryan O'Donoghue"
	<bryan.odonoghue@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PM: domains: add device managed version of
 dev_pm_domain_attach|detach_list()
Message-ID: <20240809041913.frh4ooo25gfakwia@lcpd911>
References: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
 <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
 <20240808104130.3lehlvkcprag2md6@lcpd911>
 <36de7f9c-701f-6650-468b-bf07453e2e21@quicinc.com>
 <9b852bed-0daf-634c-13c9-00c6b8dd327a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9b852bed-0daf-634c-13c9-00c6b8dd327a@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Aug 08, 2024 at 16:29:12 +0530, Dikshita Agarwal wrote:
> 
> 
> On 8/8/2024 4:25 PM, Dikshita Agarwal wrote:
> > 
> > 
> > On 8/8/2024 4:11 PM, Dhruva Gole wrote:
> >> On Aug 07, 2024 at 12:45:46 +0530, Dikshita Agarwal wrote:
> >>> Add the devres-enabled version of dev_pm_domain_attach|detach_list.
> >>> If client drivers use devm_pm_domain_attach_list() to attach the
> >>> PM domains, devm_pm_domain_detach_list() will be invoked implicitly
> >>> during remove phase.
> >>>
> >>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> >>> ---
> >>>  drivers/base/power/common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >>>  include/linux/pm_domain.h   | 13 +++++++++++++
> >>>  2 files changed, 57 insertions(+)
> >>>
> >>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> >>> index 327d168..729d6c2 100644
> >>> --- a/drivers/base/power/common.c
> >>> +++ b/drivers/base/power/common.c
> >>> @@ -277,6 +277,50 @@ int dev_pm_domain_attach_list(struct device *dev,
> >>>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
> >>>  
> >>>  /**
> >>> + * devm_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
> >>> + * @_list: The list of PM domains to detach.
> >>> + *
> >>> + * This function reverse the actions from devm_pm_domain_attach_list().
> >>> + * it will be invoked during the remove phase from drivers implicitly if driver
> >>> + * uses devm_pm_domain_attach_list() to attach the PM domains.
> >>> + */
> >>> +void devm_pm_domain_detach_list(void *_list)

My problem is with the type of parameter used being void, why void?
Why not be explicit about it and call it dev_pm_domain_list *list like
the non-devres version of the API?

> >>> +{
> >>> +	struct dev_pm_domain_list *list = _list;
> >>> +
> >>> +	dev_pm_domain_detach_list(list);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(devm_pm_domain_detach_list);
> >>> +
> >>> +/**
> >>> + * devm_pm_domain_attach_list - devres-enabled version of dev_pm_domain_attach_list
> >>> + * @dev: The device used to lookup the PM domains for.
> >>> + * @data: The data used for attaching to the PM domains.
> >>> + * @list: An out-parameter with an allocated list of attached PM domains.
> >>> + *
> >>> + * NOTE: this will also handle calling devm_pm_domain_detach_list() for
> >>> + * you during remove phase.
> >>> + *
> >>> + * Returns the number of attached PM domains or a negative error code in case of
> >>> + * a failure.
> >>> + */
> >>> +int devm_pm_domain_attach_list(struct device *dev,
> >>> +			       const struct dev_pm_domain_attach_data *data,
> >>> +			       struct dev_pm_domain_list **list)
> >>> +{
> >>> +	int ret, num_pds = 0;
> >>
> >> Do we require this =0? In the very next line you're initing this anyway.
> >>
> > That's correct, will fix this. Thanks.
> >>> +
> >>> +	num_pds = dev_pm_domain_attach_list(dev, data, list);
> >>> +
> >>> +	ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, *list);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	return num_pds;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(devm_pm_domain_attach_list);
> >>> +
> >>> +/**
> >>>   * dev_pm_domain_detach - Detach a device from its PM domain.
> >>>   * @dev: Device to detach.
> >>>   * @power_off: Used to indicate whether we should power off the device.
> >>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> >>> index 772d328..efd517017 100644
> >>> --- a/include/linux/pm_domain.h
> >>> +++ b/include/linux/pm_domain.h
> >>> @@ -450,8 +450,12 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
> >>>  int dev_pm_domain_attach_list(struct device *dev,
> >>>  			      const struct dev_pm_domain_attach_data *data,
> >>>  			      struct dev_pm_domain_list **list);
> >>> +int devm_pm_domain_attach_list(struct device *dev,
> >>> +			       const struct dev_pm_domain_attach_data *data,
> >>> +			       struct dev_pm_domain_list **list);
> >>>  void dev_pm_domain_detach(struct device *dev, bool power_off);
> >>>  void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
> >>> +void devm_pm_domain_detach_list(void *list);
> >>
> >> Why not just call it dev_pm_domain_list *list? Why make it void? I am a
> >> bit confused.
> >>
> > This comment is not clear to me, could you pls elaborate?
> Ah! Sorry, pls ignore my below comment. But can you still explain the
> concern here?

I have explained above near the func definition.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

