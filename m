Return-Path: <linux-pm+bounces-8908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059AF90324E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC802834DC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 06:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8458814E2E8;
	Tue, 11 Jun 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IWyXzCkV"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A1A2A;
	Tue, 11 Jun 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086554; cv=none; b=otIcgepMiyCiCBKLKQKe+uoa1bkguWVMnctec2Uufw78K4pX3iP1xgSXRLltUV/Jmmz2SJ7kdyTROSNsVMV1B+xSCekuqTAF81s1nOlQCNLbDdX6DgmyrauRFx1mLz5rGnoJ4HkxE0BjxnpTOwav9uPl3OfK8hFlJFSya8obgFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086554; c=relaxed/simple;
	bh=lloR2gbqxT2zZLt7BjL1hwfSkhWDcrB89RKDxRxLMow=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMLJ5UF1z6I7Bm7VQqwmYYPlxhJjS4FP3zyJD8gosSza43TAIU2JvKzmCwmRaGQNgSz+Lerh9pvk1Bp/4BTAAEpsReBkDIchKWmWE2OVxX3A5TfczrENzjxbeimwL90Tnn87tFZhfoJzqDfm1HGVZ7Zc6P5u4A4g92M3HD12dnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IWyXzCkV; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45B6FjEE123312;
	Tue, 11 Jun 2024 01:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718086545;
	bh=rW+1bWfOjK8LklAi5rLMDUblTYcqO24dKWlfvRIgaZY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IWyXzCkV+gdrroEyemV28abeEAboGTyRf1vPNNWBfAqkZiSo3hLHaEaLyF2NoySfv
	 pSGxKjjJ0qvIOqZHtuJyGx73blIONVZJJqR2JYQY0oC93qLvuk+XQxnvYsdGsNVzLW
	 BaPV7XON4qNAj3lgbLrUVIAPnKLm4i0QACQRnRGU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45B6Fihl028990
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 01:15:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 01:15:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 01:15:44 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45B6FhHU060985;
	Tue, 11 Jun 2024 01:15:44 -0500
Date: Tue, 11 Jun 2024 11:45:43 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] power: reset: brcmstb: Use
 syscon_regmap_lookup_by_phandle_args() helper
Message-ID: <20240611061543.jivkvda6hhsyv4xu@dhruva>
References: <20240610142836.168603-1-afd@ti.com>
 <20240610142836.168603-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240610142836.168603-3-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Jun 10, 2024 at 09:28:34 -0500, Andrew Davis wrote:
> Simplify probe by fetching the regmap and its arguments in one call.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/power/reset/brcmstb-reboot.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
> index db5b7120eadd0..94ea317f61ef4 100644
> --- a/drivers/power/reset/brcmstb-reboot.c
> +++ b/drivers/power/reset/brcmstb-reboot.c
> @@ -18,9 +18,6 @@
>  #include <linux/smp.h>
>  #include <linux/mfd/syscon.h>
>  
> -#define RESET_SOURCE_ENABLE_REG 1
> -#define SW_MASTER_RESET_REG 2
> -
>  static struct regmap *regmap;
>  static u32 rst_src_en;
>  static u32 sw_mstr_rst;
> @@ -87,6 +84,7 @@ static int brcmstb_reboot_probe(struct platform_device *pdev)
>  {
>  	int rc;
>  	struct device_node *np = pdev->dev.of_node;
> +	unsigned int args[2];

You can also call it syscon_args, but I'm fine either way.

>  
>  	reset_masks = device_get_match_data(&pdev->dev);
>  	if (!reset_masks) {
> @@ -94,25 +92,13 @@ static int brcmstb_reboot_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
> +	regmap = syscon_regmap_lookup_by_phandle_args(np, "syscon", 2, args);
>  	if (IS_ERR(regmap)) {
>  		pr_err("failed to get syscon phandle\n");
>  		return -EINVAL;
>  	}
> -
> -	rc = of_property_read_u32_index(np, "syscon", RESET_SOURCE_ENABLE_REG,
> -					&rst_src_en);
> -	if (rc) {
> -		pr_err("can't get rst_src_en offset (%d)\n", rc);
> -		return -EINVAL;
> -	}
> -
> -	rc = of_property_read_u32_index(np, "syscon", SW_MASTER_RESET_REG,
> -					&sw_mstr_rst);
> -	if (rc) {
> -		pr_err("can't get sw_mstr_rst offset (%d)\n", rc);
> -		return -EINVAL;
> -	}
> +	rst_src_en = args[0];
> +	sw_mstr_rst = args[1];

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva

