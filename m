Return-Path: <linux-pm+bounces-13368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D2A969072
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 01:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987571F229BB
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5E14A092;
	Mon,  2 Sep 2024 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gAugWOpv"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37136D;
	Mon,  2 Sep 2024 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725320103; cv=none; b=Uow+vEUL3yA6YwlO369Nazn2eCP9Uuepp0tMjyvH1+DAT8Xi2qCRHE6+A/nEAiB6d/F/QyXGdW15hpNI7o/giOryg7HaDJ54vm+/wrhxI7ajKNYntL2qFwhnVSmE72pLlahDgRqnzjipML4+5BJHmjDqbdD4orXXbm+z/B1ycVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725320103; c=relaxed/simple;
	bh=RYDMyGqz9zahG15EoJTKPIKmn7xMLA+UZItnWz0xoZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFdQqIlGJVDv/49/Yaoq+1MRF7ddcya8s+qyFQFFyNOR3qFhYsl7jja5nCgjIATINR2a0eleydM1U+DlyT9ENkmlF4ivPY94+qg3qmKAcJIac+I+eiDPYigaeZhxg2vWqo1h+TOvkFOmriqDnywEdD8i57C2mpBaocrA+NEbhbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gAugWOpv; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 482NYd48047223;
	Mon, 2 Sep 2024 18:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725320079;
	bh=/wfMYXCVgFOUz9ObTrkeq3S4B+T5tceen76AFBjlnWw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gAugWOpvTlt8KqxUYzlYnJr2vAs4YrckpakBLbOF0kL/uk4012jrond09xKh248ef
	 3Ah/AwdoCq6Sq5J4BQCab8z3MljeRXZQw+wXz7v/nybwnSGEVZPbIIRR9grpcPnO88
	 gekDJemPZ3+PahsrjAMOKvVZJWw4xXF5Qr5P9xbg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 482NYdsF116611;
	Mon, 2 Sep 2024 18:34:39 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 18:34:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 18:34:39 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 482NYdtl003525;
	Mon, 2 Sep 2024 18:34:39 -0500
Date: Mon, 2 Sep 2024 18:34:39 -0500
From: Bryan Brattlof <bb@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <vibhore@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] cpufreq: ti-cpufreq: Make the AM625 efuse_offset 0
Message-ID: <20240902233439.z5kpszcwaswkch6q@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240902093222.2828345-1-d-gole@ti.com>
 <20240902093222.2828345-3-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240902093222.2828345-3-d-gole@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On September  2, 2024 thus sayeth Dhruva Gole:
> Since the efuse_offset is basically derived from the syscon node, we no
> longer need to use any efuse_offset for AM625. This is in line with how
> the AM62Ax and AM62Px are already doing.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index ba621ce1cdda..98e320832f78 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -313,7 +313,7 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
>  
>  static struct ti_cpufreq_soc_data am625_soc_data = {
>  	.efuse_xlate = am625_efuse_xlate,
> -	.efuse_offset = 0x0018,
> +	.efuse_offset = 0x0,
>  	.efuse_mask = 0x07c0,
>  	.efuse_shift = 0x6,
>  	.rev_offset = 0x0014,

This may work but it really shouldn't. Unfortunately when I sent out the 
am62ax and am62px support I missed the .rev_offset and now it's pointed 
to some random spot in the WKUP_CTRL_MMR space. How it worked on my 
bench was complete luck (or bad luck depending on how we view this).

We'll need to pull out a OMAP3 chip and try to separate the OMAP and K3 
OPN decoding before we can move the .efuse_offset

~Bryan

