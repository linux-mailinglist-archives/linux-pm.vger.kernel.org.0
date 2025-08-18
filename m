Return-Path: <linux-pm+bounces-32553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB29B2AC2F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AEE2A1537
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C32494FF;
	Mon, 18 Aug 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="udOuyIjC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488323C512;
	Mon, 18 Aug 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529667; cv=none; b=VeqZFhj0y1124XKIdkmQCdia3KUArJ+YiOHmpafg1cgofHn6orG6szHxyP8Ke71pyiwHDUy2e9q1MK5J/zjbz+tpya+1mbZOjHnqaRAe2Jc122KvclZMte1qyUQ6KDTMHU6H6zD1C1S/SVTCfTONpRl5RiZWAYYuTXC89AcBWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529667; c=relaxed/simple;
	bh=HR7AusnEagZic3EkAZi0hRyaLgO0FD0ajgBY78gzR7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAIShAWRldRLFgRLsENtc7JQTCHJHZFaSFlxmtSXxeC1mg5bF9dbXMZ5bChNlur3hcp9Q7NH284ANZtbSataq3ukWzqG6gg/NJqoFw2Uk6rfubUFsZow4s8lbFNi6Sg3WMc0a1wsDnYcLw32S028L8qu19hl4hMmmG79M4ycTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=udOuyIjC; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ylPLbllJs5QVkBJQasK/iA4Hkhf3DAWYGCyEqZCrnac=; b=udOuyIjCCacancZuEmy46ezabu
	p92/nUEH24KMq91g6ZnVVsX5VgwmubqoKrDWSss3E5nTKQooUbp/zhUVHVmaIczDgxLDbmwztFK6+
	5mFDLQgoWH9A6syvhc/ceVsqS9sup9tG8xwbaxu63lBpnxDelMe4wBbOAFdtr4jCUIUnpy3WVBfZO
	DgawutPE1cj45kI+tx5ggbDJF9ZevkTaqs1gdFe12aKsNZM5dQsrcyZvVBGY1muS58UycRqdJ/Q1u
	SvcleqzDp5kCmssmMA1DbJaC1Ded+KlJM0W4txqN93f+/uQIeaF/iU7RT7tk6i4Naru/3vJJ7z+S2
	kBHBVvig==;
Date: Mon, 18 Aug 2025 17:07:38 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
Message-ID: <20250818170738.60d44e17@akair>
In-Reply-To: <33880bc8-40af-42f0-b962-cc5214c7b330@gmail.com>
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
	<20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
	<33880bc8-40af-42f0-b962-cc5214c7b330@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Mon, 18 Aug 2025 13:33:05 +0300
schrieb Matti Vaittinen <mazziesaccount@gmail.com>:

[...]
> > +#define BD7182x_MASK_CCNTRST			0x80
> > +#define BD7182x_MASK_CCNTENB			0x40
> > +#define BD7182x_MASK_CCCALIB			0x20  
> 
> I suppose unused defines could get cleared. (At least the CC related 
> ones)...
> 
Hmm, I don't think having unused register defines is a problem at least
that is not an uncommon thing.

> > +#define BD7182x_MASK_WDT_AUTO			0x40
> > +#define BD7182x_MASK_VBAT_ALM_LIMIT_U		0x01
> > +#define BD7182x_MASK_CHG_EN			0x01
> > +
> > +#define BD7182x_DCIN_COLLAPSE_DEFAULT		0x36
> > +
> > +/* Measured min and max value clear bits */
> > +#define BD718XX_MASK_VSYS_MIN_AVG_CLR		0x10
> > +
> > +#define JITTER_DEFAULT				3000  
> 
> ...Also the loop jitter
> 
yes, there I agree.

> > +#define MAX_CURRENT_DEFAULT			890000		/* uA */
> > +#define AC_NAME					"bd71828_ac"
> > +#define BAT_NAME				"bd71828_bat"
> > +
> > +/*
> > + * VBAT Low voltage detection Threshold
> > + * 0x00D4*16mV = 212*0.016 = 3.392v
> > + */
> > +#define VBAT_LOW_TH			0x00D4
> > +
> > +#define THR_RELAX_CURRENT_DEFAULT		5		/* mA */
> > +#define THR_RELAX_TIME_DEFAULT			(60 * 60)	/* sec. */
> > +
> > +#define DGRD_CYC_CAP_DEFAULT			88	/* 1 micro Ah */
> > +
> > +#define DGRD_TEMP_H_DEFAULT			450	/* 0.1 degrees C */
> > +#define DGRD_TEMP_M_DEFAULT			250	/* 0.1 degrees C */
> > +#define DGRD_TEMP_L_DEFAULT			50	/* 0.1 degrees C */
> > +#define DGRD_TEMP_VL_DEFAULT			0	/* 0.1 degrees C */
> > +
> > +#define SOC_EST_MAX_NUM_DEFAULT			5
> > +#define PWRCTRL_NORMAL				0x22
> > +#define PWRCTRL_RESET				0x23
> > +
> > +/*
> > + * Originally we relied upon a fixed size table of OCV and VDR params.
> > + * However the exising linux power-supply batinfo interface for getting the OCV
> > + * values from DT does not have fixed amount of OCV values. Thus we use fixed
> > + * parameter amount only for values provided as module params - and use this
> > + * only as maximum number of parameters when values come from DT.
> > + */
> > +#define NUM_BAT_PARAMS				23
> > +#define MAX_NUM_VDR_VALUES NUM_BAT_PARAMS
> > +
> > +struct pwr_regs {
> > +	int used_init_regs;
> > +	u8 vbat_init;
> > +	u8 vbat_init2;
> > +	u8 vbat_init3;
> > +	u8 vbat_avg;
> > +	u8 ibat;
> > +	u8 ibat_avg;
> > +	u8 meas_clear;
> > +	u8 vsys_min_avg;
> > +	u8 btemp_vth;
> > +	u8 chg_state;
> > +	u8 coulomb3;
> > +	u8 coulomb2;
> > +	u8 coulomb1;
> > +	u8 coulomb0;
> > +	u8 coulomb_ctrl;
>  > +	u8 vbat_rex_avg;
> > +	u8 coulomb_full3;
> > +	u8 cc_full_clr;
> > +	u8 coulomb_chg3;  
> 
> The coulomb counter and vbat_rex related entries could be dropped as 
> they're now unused. Actually, dropping all unused members would simplify 
> this quite a bit.
> 
hmm, removing it just to add it back tomorrow again... that are not so
much bytes. I would not remove them.

Regards,
Andreas

