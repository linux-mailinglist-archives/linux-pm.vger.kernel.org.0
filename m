Return-Path: <linux-pm+bounces-9230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82C89098B8
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 16:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386EC282912
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129AE49624;
	Sat, 15 Jun 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sl9C7Wmd"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E11DDF5;
	Sat, 15 Jun 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718463039; cv=none; b=J8RD+3y/ayO02l+/6CtPJOBx0N83KinJLMn2ZNI2gPlIEGrMBzmo5eQ0h9R3K+U+nogPB0BQr89pdGuNXsmWWLwWbQsn+XvJyhphUle0kAZI9TToHV3D/SZV5G1s8B0i7kJXh6t9Gn2VgvuRwKDke3lUhUg0lg8OE/59Y4FWbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718463039; c=relaxed/simple;
	bh=1NNkE2zwrmtuE6zcRnt8vGINSTLLTi1t92ouGk4Mcfw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBu938jKe3uhlzmnav275f1s9i/lmfyrG+tMqWjzHGPrro20zUvrissr5jEnMGBG1TOFXuorCl1x9YyvaKCnTVdVGn2HNAO5QensdGubTVdbc/zv0p85oHWa/lByFSwgirDkUQFRIzQlIPoV8rTaOSrcksW5CstKNcJws52T2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sl9C7Wmd; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45FEoIOq040273;
	Sat, 15 Jun 2024 09:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718463018;
	bh=XfD8OKjU91aRgKPUFHn9MTOq8e6kQs4THCBTUSEUj+s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=sl9C7WmdcBBs5buUuUbn/gYcmWr8mVaWh857LsWEcUzyGaVJzYs++jCOD0khthqFh
	 XQOMekXq+5GrD54oVjAJ+Nw0a8SaOKmnbT3YobGQPaEbBPLtWHb5Hqitj4HTGG2GOu
	 ef4VetbepeDnKrKodDO5vjTVmrs2X7L8qM/VIScc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45FEoHo6022415
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 09:50:17 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 09:50:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 09:50:17 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45FEoHPd030739;
	Sat, 15 Jun 2024 09:50:17 -0500
Date: Sat, 15 Jun 2024 09:50:17 -0500
From: Bryan Brattlof <bb@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Vibhore Vardhan
	<vibhore@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/5] cpufreq: ti: update OPP table for AM62Px SoCs
Message-ID: <20240615145017.weij2x5pqownnejj@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
 <20240612-ti-opp-updates-v2-2-422b6747a254@ti.com>
 <20240613113319.kryllyhrqzcnjqgk@dhruva>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240613113319.kryllyhrqzcnjqgk@dhruva>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On June 13, 2024 thus sayeth Dhruva Gole:
> On Jun 12, 2024 at 18:17:35 -0500, Bryan Brattlof wrote:
> > More speed grades for the AM62Px SoC family have been defined which
> > unfortunately no longer align with the AM62x table. So create a new
> > table with these new speed grades defined for the AM62Px
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  drivers/cpufreq/ti-cpufreq.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> > index a80698f3cfe65..6c84562de5c6b 100644
> > --- a/drivers/cpufreq/ti-cpufreq.c
> > +++ b/drivers/cpufreq/ti-cpufreq.c
> > @@ -69,6 +69,13 @@ enum {
> >  #define AM62A7_SUPPORT_R_MPU_OPP		BIT(1)
> >  #define AM62A7_SUPPORT_V_MPU_OPP		BIT(2)
> >  
> > +#define AM62P5_EFUSE_O_MPU_OPP			15
> > +#define AM62P5_EFUSE_S_MPU_OPP			19
> > +#define AM62P5_EFUSE_U_MPU_OPP			21
> > +
> > +#define AM62P5_SUPPORT_O_MPU_OPP		BIT(0)
> > +#define AM62P5_SUPPORT_U_MPU_OPP		BIT(2)
> > +
> >  #define VERSION_COUNT				2
> >  
> >  struct ti_cpufreq_data;
> > @@ -134,6 +141,23 @@ static unsigned long omap3_efuse_xlate(struct ti_cpufreq_data *opp_data,
> >  	return BIT(efuse);
> >  }
> >  
> > +static unsigned long am62p5_efuse_xlate(struct ti_cpufreq_data *opp_data,
> > +					unsigned long efuse)
> > +{
> > +	unsigned long calc_efuse = AM62P5_SUPPORT_O_MPU_OPP;
> 
> This and he earlier patch, why not continue using the name convention
> calculated_efuse like in am625 and dra ?
>

For whatever reason I've been more of a minimalist when it comes to 
naming stack variables. Single letters are just as good as full 
sentences ;)

I'll use the full name next round

~Bryan

