Return-Path: <linux-pm+bounces-8907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B6C90323E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A7A282057
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 06:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4077171093;
	Tue, 11 Jun 2024 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KNhOCk7Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE417108B;
	Tue, 11 Jun 2024 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086224; cv=none; b=b+mqvzEdT1X5yVCMT10CCeqLqb4m+pl3WBtinnp21a5F03mMigDfpfDPAuO8QSE2bFQQpIKqdccR90sOV+9GQKQVPgKplVCHx3wdP4WxLLrrMZBDDMPav2JjIgDKxOvYNyLThNkffs34V7NifrFRPyzrDvH+jGkdSqzk/ENEp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086224; c=relaxed/simple;
	bh=EgEYhsFBJ5H7EevFGdW0eMvoHeTOydiqxx0iI8hCqlM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Koa8eggbFzGHq/EZBLwUn6571kXBCZaT65bp9UsexW39UU9UpPWlzWWMaG0fvub1qKMdZmWCQh9qAvA5CIKiHX/74kdXTWg4rceCUgtB01W0gWXavBgWh3S/T5caRj1v/Dnp3/RWTLXpn7rZ/MUSTVHZ0bBHxnobrRwYtWP4f3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KNhOCk7Y; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45B6A0Xi121243;
	Tue, 11 Jun 2024 01:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718086200;
	bh=FtYObnNVwakYowCUn2TrHl3DGDxxEgIe5m751WPYKCk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KNhOCk7YtcetQ4y9KJAxAuLlrM74orpfPG7ki3L4JPIL0P6oT+RbrXPtCZpAlKMxz
	 ywLkblqsB1zpXK+vHTnBOgi2/KJzAIfDFEaikhZwMvHhKOkeLUbVRiP2SnNXNyvUT5
	 JVDBty64X+4hMVHjPS+/bWD8Zhexp5NUJnjA2XnI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45B6A0J9048676
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 01:10:00 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 01:10:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 01:10:00 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45B69x5t051533;
	Tue, 11 Jun 2024 01:10:00 -0500
Date: Tue, 11 Jun 2024 11:39:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] power: reset: brcmstb: Use normal driver register
 function
Message-ID: <20240611060959.nvcaasoft7l2gr3w@dhruva>
References: <20240610142836.168603-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240610142836.168603-1-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Jun 10, 2024 at 09:28:32 -0500, Andrew Davis wrote:
> The platform_driver_probe() helper is useful when the probe function
> is in the _init section, that is not the case here. Use the normal
> platform_driver_register() function.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/power/reset/brcmstb-reboot.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
> index 0f2944dc93551..797f0079bb590 100644
> --- a/drivers/power/reset/brcmstb-reboot.c
> +++ b/drivers/power/reset/brcmstb-reboot.c
> @@ -140,7 +140,6 @@ static struct platform_driver brcmstb_reboot_driver = {
>  
>  static int __init brcmstb_reboot_init(void)
>  {
> -	return platform_driver_probe(&brcmstb_reboot_driver,
> -					brcmstb_reboot_probe);
> +	return platform_driver_register(&brcmstb_reboot_driver);

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva

