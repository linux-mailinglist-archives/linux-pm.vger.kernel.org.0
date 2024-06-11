Return-Path: <linux-pm+bounces-8909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28845903254
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A671C21D2C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7DB14EC47;
	Tue, 11 Jun 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uiyJAm2g"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DBA2A;
	Tue, 11 Jun 2024 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086687; cv=none; b=I9PsjUzMX+CIcOIyQYJFmtdQXaa3NS2lSB1pFipCGWToVjtvWDH2CNciztvumAzVb+VW5mdnuLEevFSzooVcOFzq27HHZCxnpCNVowvrg8bpXY00kmifjFYD2QRiOiXZf47o5F3gN14BZIwr/khYfhQNux+PHo2/AitwLMZUroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086687; c=relaxed/simple;
	bh=NND4+4SKT9kuVjA6ye6Uxt+EVQtCmTIXZsJsBGTTcfs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpvyT/KB+oXFZk2a6RLj2PzdfIcNDtBgtSbE/T12EmXS1M5NZ8sNb/hwYe+pmYghh5n0xsWNablZw60hH3D66EUi6CmmJlNvbgOSpC2DGaIyWmGhcDQtzDbNrwaIKrrQvF2vcykY3aaqg2/UO5LNMqwFtdWqh98DTB7bjnJ6Yyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uiyJAm2g; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45B6HtXD085772;
	Tue, 11 Jun 2024 01:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718086675;
	bh=Y7v+6kM/gTyLkga3FQtPV9uw8S8OhbW5gDEZPy8TLTM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=uiyJAm2gHOj/VFrEpqRKUn534MpPbGdDBvA5J7CsIOfPOSuw2tjGWs+o6BMx3wmJX
	 7pzRUoWPdGMnRaUHYcvd2RgOOQsjQykMuQHrW53A4jOPG8U0wwvj9YLfecFJIrf6//
	 K4wR/FsrcpRUaBoIPkebFvEb7kHNZk1ZnOdjWJAY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45B6Htg1030053
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 01:17:55 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 01:17:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 01:17:54 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45B6HsOV086366;
	Tue, 11 Jun 2024 01:17:54 -0500
Date: Tue, 11 Jun 2024 11:47:53 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] power: reset: brcmstb: Use
 devm_register_sys_off_handler()
Message-ID: <20240611061753.chm6egv24yxwdj3v@dhruva>
References: <20240610142836.168603-1-afd@ti.com>
 <20240610142836.168603-4-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240610142836.168603-4-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jun 10, 2024 at 09:28:35 -0500, Andrew Davis wrote:
> Function register_restart_handler() is deprecated. Using this new API
> removes our need to keep and manage a struct notifier_block.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/power/reset/brcmstb-reboot.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
> index 94ea317f61ef4..59ed1513cfb30 100644
> --- a/drivers/power/reset/brcmstb-reboot.c
> +++ b/drivers/power/reset/brcmstb-reboot.c
> @@ -29,8 +29,7 @@ struct reset_reg_mask {
>  
>  static const struct reset_reg_mask *reset_masks;
>  
> -static int brcmstb_restart_handler(struct notifier_block *this,
> -				   unsigned long mode, void *cmd)
> +static int brcmstb_restart_handler(struct sys_off_data *data)
>  {
>  	int rc;
>  	u32 tmp;
> @@ -65,11 +64,6 @@ static int brcmstb_restart_handler(struct notifier_block *this,
>  	return NOTIFY_DONE;
>  }
>  
> -static struct notifier_block brcmstb_restart_nb = {
> -	.notifier_call = brcmstb_restart_handler,
> -	.priority = 128,
> -};
> -
>  static const struct reset_reg_mask reset_bits_40nm = {
>  	.rst_src_en_mask = BIT(0),
>  	.sw_mstr_rst_mask = BIT(0),
> @@ -100,7 +94,8 @@ static int brcmstb_reboot_probe(struct platform_device *pdev)
>  	rst_src_en = args[0];
>  	sw_mstr_rst = args[1];
>  
> -	rc = register_restart_handler(&brcmstb_restart_nb);
> +	rc = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
> +					   128, brcmstb_restart_handler, NULL);

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva

