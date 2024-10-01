Return-Path: <linux-pm+bounces-15003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7FB98B62A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 09:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A0E1C218E8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 07:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BC51BDA8C;
	Tue,  1 Oct 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oDUIUkx9"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9119992D;
	Tue,  1 Oct 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769161; cv=none; b=PjLbZutkSATbawLh5Hf5JqiUPIGUnymMMHivH9cC6U38yiRf/LbKnfm2i8ZlYHWHkpGDFakiQKV9ETk0//acM+RBbGrAtHqRvd4SPRJDv5OmjiW0onbBvAvQ/R0yX+0FTu3VDc0qVhEpOuGbMmuZCA20CRM9LYdRblSJc+VFf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769161; c=relaxed/simple;
	bh=Os8GcwVVpz/gCq3tXdMr+TKVOtO50iLyU13IOY6tL1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaDcmB2AENc4NF3oetG/t0UDUOLwwsonjiVN5q6cEsaVCdtoaN/bL0WylvTqHXSbFqB99OEZBstbQeWLsq1ipOs+/kM7ObPUGEhhQor/sKg7cqNLw2jpwRDdogSmckgJrAXGQDqcQTgeuJb59NBBuJNQzg9UFeig5CbEYzgiwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oDUIUkx9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4917qWFH017647;
	Tue, 1 Oct 2024 02:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727769152;
	bh=WT3J0nlP0gt082jLaewz4ht1d32o5bYLmpagACQUtvc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oDUIUkx9GX0hYaw9eDqcP9oQzbHa4w+BhnijMhHxLxrarTvEUcLoM6dSGMH1aamLH
	 Un+Tq3/QNw5zZKEuXRwwyiUYMAKOAHFG3Y22qJEBZnIXOQ5hdUbqos4iUwij0i+Fki
	 LYzJ/ixinGLkQrz6B2qOGArS9BEiWSZaCMDi7p0k=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4917qWf5128927;
	Tue, 1 Oct 2024 02:52:32 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 02:52:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 02:52:31 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4917qVh8112464;
	Tue, 1 Oct 2024 02:52:31 -0500
Date: Tue, 1 Oct 2024 13:22:30 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH V4 6/6] cpufreq: ti-cpufreq: Update efuse/rev offsets in
 AM62 family
Message-ID: <20241001075230.j6rpis57la2zn4iu@lcpd911>
References: <20240919082809.174589-1-d-gole@ti.com>
 <20240919082809.174589-7-d-gole@ti.com>
 <20241001062919.ftlf3oobxreiulnb@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001062919.ftlf3oobxreiulnb@vireshk-i7>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 01, 2024 at 11:59:19 +0530, Viresh Kumar wrote:
> On 19-09-24, 13:58, Dhruva Gole wrote:
> > With the Silicon revision being taken directly from socinfo, there's no
> > longer any need for reading any SOC register for revision from this driver.
> > Hence, we do not require any rev_offset for AM62 family of devices.
> > The efuse offset should be 0x0 for AM625 as well, as the syscon
> > register being used from DT refers to the efuse_offset directly.
> > 
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> > 
> > Viresh, Nishanth, Vignesh,
> > 
> > This driver fix is better to go with PATCH 5/6.
> > 
> > Subject: [PATCH V4 5/6] arm64: dts: ti: k3-am62: use opp_efuse_table for
> >  opp-table syscon
> > 
> > That patch fixes the efuse offset in the AM625 DT.
> > Without it, the driver will read from an incorrect efuse offset, and end
> > up breaking things in -next till all the DT changes make it in.
> > Hence, it would be preferrable if this entire series goes via a single
> > maintainer's tree.
> > Viresh, perhaps if you can ack this single patch, then Vignesh/Nishanth
> > could take it up if there are no objections?
> > 
> > I am sorry that this break compatibility with older AM625 devicetree.
> > However, the old devicetree was marking the entire wkup_conf as "syscon",
> > "simple-mfd" which was wrong and needed to be fixed.
> > 
> > This series finally tries to bring order to DT and the driver.
> > 
> > However, if there is still any way to maintain the backward
> > compatibility, then I am open to suggestions. Please try
> > and understand here that the ask for backward compatibility here
> > is to ask the driver to support a case where the register offset itself
> > was to be picked from a different node. I am not sure there's any
> > clean way to do this.
> > 
> > ---
> >  drivers/cpufreq/ti-cpufreq.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> > index ba621ce1cdda..870ab0b376c1 100644
> > --- a/drivers/cpufreq/ti-cpufreq.c
> > +++ b/drivers/cpufreq/ti-cpufreq.c
> > @@ -313,10 +313,9 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
> >  
> >  static struct ti_cpufreq_soc_data am625_soc_data = {
> >  	.efuse_xlate = am625_efuse_xlate,
> > -	.efuse_offset = 0x0018,
> > +	.efuse_offset = 0x0,
> >  	.efuse_mask = 0x07c0,
> >  	.efuse_shift = 0x6,
> > -	.rev_offset = 0x0014,
> >  	.multi_regulator = false,
> >  };
> >  
> > @@ -325,7 +324,6 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
> >  	.efuse_offset = 0x0,
> >  	.efuse_mask = 0x07c0,
> >  	.efuse_shift = 0x6,
> > -	.rev_offset = 0x0014,
> >  	.multi_regulator = false,
> >  };
> >  
> > @@ -334,7 +332,6 @@ static struct ti_cpufreq_soc_data am62p5_soc_data = {
> >  	.efuse_offset = 0x0,
> >  	.efuse_mask = 0x07c0,
> >  	.efuse_shift = 0x6,
> > -	.rev_offset = 0x0014,
> >  	.multi_regulator = false,
> >  };
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Really sorry for any confusion here, but this series has been overall
split up and posted afresh here:
https://lore.kernel.org/all/20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com/

This was done to avoid breaking any backward compatibility issues with
older DTs in a clean way.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

