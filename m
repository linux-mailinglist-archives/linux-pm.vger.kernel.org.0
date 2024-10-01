Return-Path: <linux-pm+bounces-15005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD798B64B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 09:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C991F22719
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 07:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C92A1BDAA3;
	Tue,  1 Oct 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gwTm5ysI"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C881BBBCA;
	Tue,  1 Oct 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769490; cv=none; b=M9d6VfPYp6v/uEiZ264tE8zAOce3xr8TcnPqvV6yPYce3a9EMbrm0Fp0lK2Ct7i+nBXWHCiK2+Xko/cCIv4Tdm0luC67oMCfJnXL3Zzwy1C+DUyRcd8ix8RaLgsFd0474C9hEuLP7O7tiVXGyRwHpBUfuNE1ycq1BLQVr0oBHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769490; c=relaxed/simple;
	bh=hp/rSGpauQKtdbOsaOD855G198XUY0u92V9j+iMsyZw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbXvH/lbVKPj89pPWCuXUrHihTh8cSjJbWgkn9DyYDqh4D7l+bcRMjEp15mwz6FBBoSBy7+Vb05H2CR4Vq53EjYRz4BVEicgt0MhjRXXloKGX1BatanwjFOato5Kmmph7Nt2tBMSQuYPY4UBiq2Jy0f9l3d3wgD9/J4IANpZhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gwTm5ysI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4917w18A018587;
	Tue, 1 Oct 2024 02:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727769481;
	bh=FSR/QonsOSmKVAzZ8TmU3HUL+GIoyrF54tmwIIWxiMA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gwTm5ysIisdiZcUCaEndmpv+6ENyqibBY0TDn+jKHgVJ5daX1dKsOPJ+0L/Du2JTi
	 ApUFRQ41fFqOS0Jm28itg6VwY4HHJdvwsX5VY93Th1TgbOVSwjoaEu3lPpObZoolMv
	 UJmFFbmDojfJVYr7Utq4318uFQXOf6itHsgP2BDc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4917w1eO088258
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 1 Oct 2024 02:58:01 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 02:58:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 02:58:01 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4917w0ne018234;
	Tue, 1 Oct 2024 02:58:00 -0500
Date: Tue, 1 Oct 2024 13:27:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan Brattlof
	<bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Andrew Davis <afd@ti.com>, Lee Jones
	<lee@kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ti-cpufreq: AM62: Backward compatibility for syscon
 and update offsets
Message-ID: <20241001075759.o2a6vhjia5sl6vhr@lcpd911>
References: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 30, 2024 at 15:02:08 +0530, Dhruva Gole wrote:
> With the Silicon revision being taken directly from socinfo, there's no
> longer any need for reading any SOC register for revision from this driver.
> Hence, we do not require any rev_offset for AM62 family of devices.
> 
> Also, maintain the backward compatibility with old devicetree, and hence
> add condition to handle the case where we have the zero offset such that we
> don't end up reading the wrong register offset in new AM625 DTs whenever we fix
> them up.
> 
> These patches have been in discussion as part of another series, which is now
> being split up as per discussions with Nishanth. Ref. the following link for
> more context on the same:
> https://lore.kernel.org/all/20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com/
> 
> **DEPENDS ON:**
> "mfd: syscon: Use regmap max_register_is_0 as needed"
> https://lore.kernel.org/linux-arm-kernel/20240903184710.1552067-1-nm@ti.com/

Just an update, the above dependency patch is now taken in by Lee Jones [1].
Waiting for it to finally appear in -next.

+ Lee just because we are users of that patch.

[1]
https://lore.kernel.org/linux-arm-kernel/172770742318.523866.16912261914335612487.b4-ty@kernel.org/


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

