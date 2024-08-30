Return-Path: <linux-pm+bounces-13216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5671B965DE3
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EFE2881D8
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012817B428;
	Fri, 30 Aug 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jVMPthfN"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2817A5B5;
	Fri, 30 Aug 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012268; cv=none; b=J0+W4X6lEMzlCcRrsyclder3raQlDeB/A4yiGZv3p/v2h2nEEgi5CAPkhlbxMDOsdbi96HtWgYr1if36qSb5faU+SNBuKIGXidVNV6cW9UcnSFmIaao5mNN4lzGVVHdaMNVfMBKJjfcXaQT097//+2F6fa5Z9LccoI7j77iZhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012268; c=relaxed/simple;
	bh=+P3HICJbHit9OzS3+mJBWKnoatrjLDoXQuJ6FTKpTkE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGjkehCa0AA9pJatIQyBQt6xBhLUhNM+VB1qOiN8ZdHUt8k32/fMszylJXLno5J3Jbm03Jftg1KXJUUAP07h+2Jv44+WlI+PecE6BFnlLHGwW3d9i4zNufIoPSi+CYGzwiELAJS4uSjufC6+5p2U5l+PgNeE3GFEIflfLnoOAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jVMPthfN; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UA47OJ089536;
	Fri, 30 Aug 2024 05:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725012247;
	bh=E89eBoPBmEm1hejQC0BVgc26P7ikPAipuU2/0Io9WPg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jVMPthfN1Osegc0OA78atURzJOmYo6u3r0O3bceb8Dzu7+h01ojUmdpJezkDRngW4
	 OXX2qOFvzRQ9fYVngswEGefVA3efkmjl0N4ufqhq7VvQ/f1UJmNJfGe1S/88bDnUOC
	 rcAaURj8BSd1Zx4jYGRUTZcRMRWPSpYdEbKTFnsE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UA47n0014921
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 05:04:07 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 05:04:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 05:04:07 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UA466e084667;
	Fri, 30 Aug 2024 05:04:06 -0500
Date: Fri, 30 Aug 2024 15:34:05 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin
 Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <bb@ti.com>
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Introduce quirks to handle syscon
 fails appropriately
Message-ID: <20240830100405.czxtrwmhlhbwlya6@lcpd911>
References: <20240828131915.3198081-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240828131915.3198081-1-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Aug 28, 2024 at 08:19:15 -0500, Nishanth Menon wrote:
> Commit b4bc9f9e27ed ("cpufreq: ti-cpufreq: add support for omap34xx
> and omap36xx") introduced special handling for OMAP3 class devices
> where syscon node may not be present. However, this also creates a bug
> where the syscon node is present, however the offset used to read
> is beyond the syscon defined range.
> 
> Fix this by providing a quirk option that is populated when such
> special handling is required. This allows proper failure for all other
> platforms when the syscon node and efuse offsets are mismatched.
> 
> Fixes: b4bc9f9e27ed ("cpufreq: ti-cpufreq: add support for omap34xx and omap36xx")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> NOTE: this combined with https://lore.kernel.org/r/20240828121008.3066002-1-nm@ti.com
> has created a bunch of un-intended bugs on other TI SoCs such
> as seen in https://lore.kernel.org/all/20240826-opp-v3-1-0934f8309e13@ti.com/
> https://lore.kernel.org/all/20240827131342.6wrielete3yeoinl@bryanbrattlof.com/
> etc.

I have been able to verify that this doesn't cause any regressions on
AM62x cpufreq, logs [0]. I also applied the other syscon patch mentioned
above. So,

Tested-by: Dhruva Gole <d-gole@ti.com>

[0] https://gist.github.com/DhruvaG2000/153b5511889180ee54703603428fb77e

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

