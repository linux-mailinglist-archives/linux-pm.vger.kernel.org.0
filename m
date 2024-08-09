Return-Path: <linux-pm+bounces-12041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9863F94CDF0
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 12:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F01F22F19
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E61922DB;
	Fri,  9 Aug 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EjlOaKFD"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF01946BC;
	Fri,  9 Aug 2024 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196958; cv=none; b=D3Lz9aKsvtOpZdIddKSvPoRMIC2/NCrvu9YVvHcGB2jyjS5jsPjdiKCv0zFZpR5WuJ9PgQdG7HWzDfuzjHWB0Lau7CE++pQ65NdzoQiciJ2ebHFMgNKsW5GedMoNPshB8TedsYM+Kvrn4Tn7dj+vFaIzvJupvjFR+YqlH5u6Gkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196958; c=relaxed/simple;
	bh=m3nNUq1Sj4RVBOMVUtGmILRYiTnZttmoSx8eySOiKoM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMgX0jsTEpZHwpvTgrSZlenzX1ngTH9bxMJI421d+PuLjxOdSVyAAe1CzKDaLqy1jJNKUjAZSRw83cbQaXSVUnunsdvtXQsKhtM1bXtRNnokKBDrL5gs2OfuKNryAZNoKM4YlE30Pl/yaXK4KidaRTCQBuWmxZQinmFitOnEyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EjlOaKFD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4799n1TO020669;
	Fri, 9 Aug 2024 04:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723196942;
	bh=hY2Hom1U5rajQJIcxGTIqwywMIol0o2qmrQZlrCSEMs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=EjlOaKFDnc5wx/aswCwa2KmjMyJtAOLp7TpGelwhj9BYarFZcSx5NmKTFaWGTRLf2
	 wHMj9Jwj+JV5lSKgo7QVBWBNcFPKHwr4yrrsqA0gMRa9x7RpkhpkeB7An3k+LHGtsN
	 RoGScAp4cPaqoGPJlcJkCUox4bJGHD4xhgKjyRYM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4799n1PQ019962
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Aug 2024 04:49:01 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 04:49:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 04:49:01 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4799n0Wr073307;
	Fri, 9 Aug 2024 04:49:01 -0500
Date: Fri, 9 Aug 2024 15:19:00 +0530
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
Message-ID: <20240809094900.j5c2q6gm72ycheeu@lcpd911>
References: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
 <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
 <20240808104130.3lehlvkcprag2md6@lcpd911>
 <36de7f9c-701f-6650-468b-bf07453e2e21@quicinc.com>
 <9b852bed-0daf-634c-13c9-00c6b8dd327a@quicinc.com>
 <20240809041913.frh4ooo25gfakwia@lcpd911>
 <b16a25d0-3f39-3231-bc80-d79739dc0168@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b16a25d0-3f39-3231-bc80-d79739dc0168@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Aug 09, 2024 at 14:57:11 +0530, Dikshita Agarwal wrote:
> 
> 
> On 8/9/2024 9:49 AM, Dhruva Gole wrote:
> > Hi,
> > 
> > On Aug 08, 2024 at 16:29:12 +0530, Dikshita Agarwal wrote:
> >>
> >>
> >> On 8/8/2024 4:25 PM, Dikshita Agarwal wrote:
> >>>
> >>>
> >>> On 8/8/2024 4:11 PM, Dhruva Gole wrote:
> >>>> On Aug 07, 2024 at 12:45:46 +0530, Dikshita Agarwal wrote:
> >>>>> Add the devres-enabled version of dev_pm_domain_attach|detach_list.
> >>>>> If client drivers use devm_pm_domain_attach_list() to attach the
> >>>>> PM domains, devm_pm_domain_detach_list() will be invoked implicitly
> >>>>> during remove phase.
> >>>>>
> >>>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> >>>>> ---
> >>>>>  drivers/base/power/common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >>>>>  include/linux/pm_domain.h   | 13 +++++++++++++
> >>>>>  2 files changed, 57 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> >>>>> index 327d168..729d6c2 100644
> >>>>> --- a/drivers/base/power/common.c
> >>>>> +++ b/drivers/base/power/common.c
> >>>>> @@ -277,6 +277,50 @@ int dev_pm_domain_attach_list(struct device *dev,
> >>>>>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
> >>>>>  
> >>>>>  /**
> >>>>> + * devm_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
> >>>>> + * @_list: The list of PM domains to detach.
> >>>>> + *
> >>>>> + * This function reverse the actions from devm_pm_domain_attach_list().
> >>>>> + * it will be invoked during the remove phase from drivers implicitly if driver
> >>>>> + * uses devm_pm_domain_attach_list() to attach the PM domains.
> >>>>> + */
> >>>>> +void devm_pm_domain_detach_list(void *_list)
> > 
> > My problem is with the type of parameter used being void, why void?
> > Why not be explicit about it and call it dev_pm_domain_list *list like
> > the non-devres version of the API?
> > 
> devm_add_action_or_reset API expects the argument as void (*)(void *).
> 
> Below are code references following the same way:
> https://elixir.bootlin.com/linux/v6.11-rc2/source/drivers/devfreq/devfreq.c#L1332
> https://elixir.bootlin.com/linux/v6.11-rc2/source/drivers/clk/clk.c#L1033
> 
> If I change the type of argument as you are suggesting, it will throw
> compilation error.
> "expected 'void (*)(void *)' but argument is of type 'void (*)(struct
> dev_pm_domain_list *)'"

Ah yes sorry I missed the devm_add_action_or_reset part. Thanks for clarifying!


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

