Return-Path: <linux-pm+bounces-36030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CBBD76B3
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5402D4E4813
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 05:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A9296BB5;
	Tue, 14 Oct 2025 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gi88Lhdc"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BA264A8D;
	Tue, 14 Oct 2025 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419688; cv=none; b=O3FhPnaeI8ur51XjtXrGHS68sLY8urahoZQKuQf43plMPfekcShIbtSXT09YILP02I2DAxZ1VS/MrbLgb0Kl5IGsz2lQOymtp8+/qQLBjP9j4mK1vV/AaM5rJxIVVUTFQ1UWpBoiwz/wHBGgsLQPWka2qDwOCfsifrE6KQDKHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419688; c=relaxed/simple;
	bh=8xRuTHFFH2PM8vfqKFhpl/BC7O+sNHzqu+hVzNkYBSM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx4urnEmWx6jr8q4fWtMGm0yzQmHplK0UpH+Fy/c4m9lhInd8yxv71HO7LqR08yFylvmEWkJpdpyW48qEf7AXZr2MYm9dB1Hdf6+Itzfff30DV/lyzJoSMi2yRGw5dUIaaoQqmRtDf1TCUCFTbsiiXzW8OvR1MZp+4GJX3v9ZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Gi88Lhdc; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E5RjPa1068705;
	Tue, 14 Oct 2025 00:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760419665;
	bh=GZkDZiqJHRQS6eYPn2MWS93PH5gkev1yZL05Cge9Pt0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Gi88LhdcGPErcxh5788Wua0nCPKCBcEf4fWOaG+hxefH2lCXeHfTGfDniya3rrfls
	 3fwLmXRuzxhEKfQQZnlzCAcv+6DPjshtalj3cfkdJxp9go6TuIQmH1JWQivkVMtrTV
	 iygfWITeMqy4olnixHWux3JNDx215fxAHYneY51s=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E5RjhV783018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 14 Oct 2025 00:27:45 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 14
 Oct 2025 00:27:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 00:27:44 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E5RhoE3267084;
	Tue, 14 Oct 2025 00:27:44 -0500
Date: Tue, 14 Oct 2025 10:57:43 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel
 Machek <pavel@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] docs: power: clean up power_supply_class.rst
Message-ID: <20251014052743.7epupfxrymbq3eu6@lcpd911>
References: <20251014031617.764429-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014031617.764429-1-rdunlap@infradead.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 13, 2025 at 20:16:15 -0700, Randy Dunlap wrote:
> Clean up grammar, punctuation, etc., in the power supply class
> documentation.
> 
> Add article adjectives where needed.
> Hyphenate some adjectives.
> Fix punctuation.
> Fix some verb usage (singular/plural).
> Fix run-on sentences.
> Add "is" in a few places.
> Change "QA" to "Q&A".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Pavel Machek <pavel@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  Documentation/power/power_supply_class.rst |   84 +++++++++----------
>  1 file changed, 42 insertions(+), 42 deletions(-)
> 
> --- linux-next-20251013.orig/Documentation/power/power_supply_class.rst
> +++ linux-next-20251013/Documentation/power/power_supply_class.rst
> @@ -7,35 +7,35 @@ Synopsis
>  Power supply class used to represent battery, UPS, AC or DC power supply
>  properties to user-space.
>  
> -It defines core set of attributes, which should be applicable to (almost)
> +It defines a core set of attributes which should be applicable to (almost)
>  every power supply out there. Attributes are available via sysfs and uevent
>  interfaces.
>  
> -Each attribute has well defined meaning, up to unit of measure used. While
> +Each attribute has a well-defined meaning, up to unit of measure used. While

Not a native English speaker but see if this makes sense?
up to "the" unit of measure used.

>  the attributes provided are believed to be universally applicable to any
>  power supply, specific monitoring hardware may not be able to provide them
>  all, so any of them may be skipped.
>  
> -Power supply class is extensible, and allows to define drivers own attributes.
> -The core attribute set is subject to the standard Linux evolution (i.e.
> -if it will be found that some attribute is applicable to many power supply
> -types or their drivers, it can be added to the core set).
> +The power supply class is extensible and allows drivers to define their own
> +attributes.  The core attribute set is subject to the standard Linux evolution
> +(i.e., if it will be found that some attribute is applicable to many power

Reword as follows:
i.e., if some attribute is found to be applicable to many power supply types

> +supply types or their drivers, it can be added to the core set).
>  
> -It also integrates with LED framework, for the purpose of providing
> +It also integrates with the LED framework, for the purpose of providing
>  typically expected feedback of battery charging/fully charged status and
>  AC/USB power supply online status. (Note that specific details of the
>  indication (including whether to use it at all) are fully controllable by
> -user and/or specific machine defaults, per design principles of LED
> -framework).
> +user and/or specific machine defaults, per design principles of the LED
> +framework.)
>  

With that, if you plan to respin feel free to include:
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

