Return-Path: <linux-pm+bounces-34737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4F1B59ACC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7793BAA79
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433553375B5;
	Tue, 16 Sep 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zQ/kbCpE"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F63191B9;
	Tue, 16 Sep 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034117; cv=none; b=WT4NtzzclJkW2RSwWwDKGUJJcIodBmf8+ZF6wEEX5sdmLqOthS1cVan+8Hm8aP1EABNINPhGf+wUloO89RDEaoePM5Mj8zCAgW92DkTJtBjOBVTi2teFObiQG07SYKohU/UV8jV5EPJQkLfi+MHiNMNe1CRuVHop1g+9+kr/fU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034117; c=relaxed/simple;
	bh=ylED2QmG4z5jpT44UfsD5KLLNSkZmNlT7OtJh7WiFqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cOwPPGjj3jPNYvciF4lAXaZur+CTqztfgJWcl7E8tYQUKPor4vzUc4Ytgew729HhfSNFZUIX7jyq82DenDigcQn/lDHE357WVXQgzellScd2/h2g51P7zw2KH5/G3oNQamZTKJzKyQHGAuphQQEQAQqcc7tNU2s5wsVBCzCv+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zQ/kbCpE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758034115; x=1789570115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ylED2QmG4z5jpT44UfsD5KLLNSkZmNlT7OtJh7WiFqk=;
  b=zQ/kbCpEKOowzR5ozKzBG55LBklc5fStxYgnrGMxP2QWuy+6lADsbBI0
   FMbKhF9wq88RdywT9Bgl9pUtXDbqrSNzL+txmpYjyLaAWjgVsM7HXioOq
   j4WsP5FVVOv7RtqSbaVBxjcegLhG4vBcu2Un+BMixAyPnCyN1upBGveY7
   uMUZ/FXcJlkrZ6DNwGD4eBCf84f8/WSzwahbACe8qB+H7i3kdYYNCv1u0
   gRmJypEvQJpWSW3KCHjcom1ShMMBCbAchwZbk2YmGttzXq/NmEg1ET6oD
   hyaCdjfSZIQwwxtOm8qLVrUnTK+HHEo8D0ZbE16IphLRiIwjcWtzwha6r
   A==;
X-CSE-ConnectionGUID: L6xQAWeqQP+7SzlmY7FqJQ==
X-CSE-MsgGUID: Y8D2Qpz/SHG2ASa0mfu+2w==
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="213953799"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2025 07:48:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Sep 2025 07:48:21 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 07:48:18 -0700
Message-ID: <36a37379-2ad1-40c5-9c7d-6e05ea74bf84@microchip.com>
Date: Tue, 16 Sep 2025 16:48:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: at91: pm: Remove 2.5V regulator
To: <Ryan.Wanner@microchip.com>, <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <cover.1757519351.git.Ryan.Wanner@microchip.com>
 <a6785a40648b315a07152bca261a42bbf0f356af.1757519351.git.Ryan.Wanner@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <a6785a40648b315a07152bca261a42bbf0f356af.1757519351.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2025 at 18:20, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Remove 2.5V regulator since enabling and disabling this regulator is no
> longer supported.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I take this one for at91-soc now. We will come back for the rest.

Regards,
   Nicolas

> ---
>   arch/arm/mach-at91/pm_suspend.S | 29 -----------------------------
>   include/soc/at91/sama7-sfrbu.h  |  7 -------
>   2 files changed, 36 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> index 198236bdbbb3..36cae7b1a490 100644
> --- a/arch/arm/mach-at91/pm_suspend.S
> +++ b/arch/arm/mach-at91/pm_suspend.S
> @@ -87,29 +87,6 @@ tmp3	.req	r6
>   
>   	.endm
>   
> -/**
> - * Set state for 2.5V low power regulator
> - * @ena: 0 - disable regulator
> - *	 1 - enable regulator
> - *
> - * Side effects: overwrites r7, r8, r9, r10
> - */
> -	.macro at91_2_5V_reg_set_low_power ena
> -#ifdef CONFIG_SOC_SAMA7
> -	ldr	r7, .sfrbu
> -	mov	r8, #\ena
> -	ldr	r9, [r7, #AT91_SFRBU_25LDOCR]
> -	orr	r9, r9, #AT91_SFRBU_25LDOCR_LP
> -	cmp	r8, #1
> -	beq	lp_done_\ena
> -	bic	r9, r9, #AT91_SFRBU_25LDOCR_LP
> -lp_done_\ena:
> -	ldr	r10, =AT91_SFRBU_25LDOCR_LDOANAKEY
> -	orr	r9, r9, r10
> -	str	r9, [r7, #AT91_SFRBU_25LDOCR]
> -#endif
> -	.endm
> -
>   /*
>    * Set LPM
>    * @ena: 0 - disable LPM
> @@ -1055,9 +1032,6 @@ save_mck:
>   
>   	at91_plla_disable
>   
> -	/* Enable low power mode for 2.5V regulator. */
> -	at91_2_5V_reg_set_low_power 1
> -
>   	ldr	tmp3, .pm_mode
>   	cmp	tmp3, #AT91_PM_ULP1
>   	beq	ulp1_mode
> @@ -1070,9 +1044,6 @@ ulp1_mode:
>   	b	ulp_exit
>   
>   ulp_exit:
> -	/* Disable low power mode for 2.5V regulator. */
> -	at91_2_5V_reg_set_low_power 0
> -
>   	ldr	pmc, .pmc_base
>   
>   	at91_plla_enable
> diff --git a/include/soc/at91/sama7-sfrbu.h b/include/soc/at91/sama7-sfrbu.h
> index 76b740810d34..8cee48d1ae2c 100644
> --- a/include/soc/at91/sama7-sfrbu.h
> +++ b/include/soc/at91/sama7-sfrbu.h
> @@ -18,13 +18,6 @@
>   #define		AT91_SFRBU_PSWBU_SOFTSWITCH	(1 << 1)	/* Power switch BU source selection */
>   #define		AT91_SFRBU_PSWBU_CTRL		(1 << 0)	/* Power switch BU control */
>   
> -#define AT91_SFRBU_25LDOCR			(0x0C)		/* SFRBU 2.5V LDO Control Register */
> -#define		AT91_SFRBU_25LDOCR_LDOANAKEY	(0x3B6E18 << 8)	/* Specific value mandatory to allow writing of other register bits. */
> -#define		AT91_SFRBU_25LDOCR_STATE	(1 << 3)	/* LDOANA Switch On/Off Control */
> -#define		AT91_SFRBU_25LDOCR_LP		(1 << 2)	/* LDOANA Low-Power Mode Control */
> -#define		AT91_SFRBU_PD_VALUE_MSK		(0x3)
> -#define		AT91_SFRBU_25LDOCR_PD_VALUE(v)	((v) & AT91_SFRBU_PD_VALUE_MSK)	/* LDOANA Pull-down value */
> -
>   #define AT91_FRBU_DDRPWR			(0x10)		/* SFRBU DDR Power Control Register */
>   #define		AT91_FRBU_DDRPWR_STATE		(1 << 0)	/* DDR Power Mode State */
>   


