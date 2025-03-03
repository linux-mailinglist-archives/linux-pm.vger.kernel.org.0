Return-Path: <linux-pm+bounces-23374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E905A4E1B0
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0467A70CF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48EF23A58D;
	Tue,  4 Mar 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Lhp5eRfD"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041B2046AF
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099636; cv=pass; b=OkzF5XXguveEMvC5+uGW9oEK4F56C6R+OueG7DiKr8P9fPHE2OVz+PlLEePzkT6DaPEOAjvlmDuwFgjw8k8n0iHWLzPSbRP7kFxnID1TsSza0KpzohGqINcWkojdt0R/3Vt4/i/BusctUG8WUFnV++aYd/lpkCbSFqm58f2uglY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099636; c=relaxed/simple;
	bh=lJXPyymC+Bn7eNg7QGwNenIBMEiR5kuGsl3f2E+vwL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaqtqKDHMArzGuUl86gxUue1JWFkGQ4UQUyr3SoXcvxfZdDg2Op0QmbBrf1dbQFWvq1emVZjv2jxNgohfySwBQmKjg+xXl63Di5wTi+ly9cgJWVM1TN8TDH3G4abZBBicftIoh3vK+xZGVFfJRyTo6RJdizt9RywJJ8+wzC9GbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Lhp5eRfD; arc=none smtp.client-ip=209.85.218.50; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id DAA1B40D4DE8
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:47:12 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=Lhp5eRfD
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dmS1HzMzFxdj
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:46:32 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id BF7A84275B; Tue,  4 Mar 2025 17:46:23 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Lhp5eRfD
X-Envelope-From: <linux-kernel+bounces-541152-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Lhp5eRfD
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 31B8E41E7E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:41:51 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 8A9463063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:27:59 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB561170538
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C418E1EFF82;
	Mon,  3 Mar 2025 08:26:58 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF351EF080
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990416; cv=none; b=Loi89mZW+QwI5tuuXMaymVOUQUI003TD7SC8NqJabTxEOVHUG5ISvka62ZXKbbKdMyHL/VVzAwJoFhNvykOk7gni40Kl5SRuHu6lYGwsqBUuwy2gmDF5dtBQMb/rXc9sHjWeOTBs9P/cSIiRAH/VbAvYhBdVHnmXS3fKXpy6Nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990416; c=relaxed/simple;
	bh=lJXPyymC+Bn7eNg7QGwNenIBMEiR5kuGsl3f2E+vwL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plrUPafLcqoGPWCE9PlCaAgfUR8xLrBZjXVaizpV2fABwpoJwxYJHvPH+aQnDBU8f9ALFsFrCa81ae+5StX2r0GsuGXczeR97jYgQ5JT2URtdO2YRS6TxETcluLQ3a8WIzyFuiEW7wuGKBG9O54hojruBsAiW/RvOqRns6CLNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Lhp5eRfD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaedd529ba1so480810866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740990412; x=1741595212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BD0ged1tbWk7V8+0mBgsPRbGV+NS/Ji1P1tciZQV6bE=;
        b=Lhp5eRfDH8wGcAYGfwM89OO+e8ZKEvJ8G30YTmuWKwp3UwHrBWUElxio4311xTFaJZ
         dfibFmO7LQnho+Rwu8SoiCWi3y0BcDd8CQwttwW4XbP1kRxVEeFw7VkauJymrzUupTY2
         ayMGbkBrgQL/puxu8MZne/R5KP6Dj3CuMceUAXWke2RtcXJMDl64/OBDylZpKTZNK1kG
         IXaKee8r5vtGMxUEICWpLi6VGe6FaJbuSVnCDrjpxKlzJqx1skg27aC0NvK1Rwplz8jl
         OkPgh4AkdndEYYAwrB0H4j2k2TFAS63K0KqhSygfYsVH5yAG8bMDPDMo2r1aoZRtWDji
         2+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990412; x=1741595212;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BD0ged1tbWk7V8+0mBgsPRbGV+NS/Ji1P1tciZQV6bE=;
        b=kVNraAHHl/7jSdtvPxt2NIOYqbFWtKA9LmwmPdzKqW1X9C0Z8nPiiftG0Kx1rJzerD
         Yq8rzsQ33Hh4DYhPm0exIXw3lk+8P/5MT35ydQOyhRXW9UStNYNTJTCcagVwI0Cs2P1V
         i3qtGanadpMXjJ7dmVV2sWl51SB1gs7JQGJVRSfyd9COZqbe0+HQIUVZs45KoPUBNw9c
         9ZwsL75jQdRhbcL3Y9MrNixMTLRjqUfqFrfYLzL1wnDEICHv1llJRXP7Fdw/BQ/poVGO
         lpLmzRyVCxhcixVMdmC6Ur21697fNmilWNy0Y1n37ZBBJxjBSdeJhbZBX6h55UZpBeAN
         09bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYvbFVwuk+ITtM61QMdXfA3waFhrVgzn9XNkJXEm+bAkn4AiefUhV5+P6pBSHvWbkOtDak3SmSCzvgjks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6iZEg/TS2Nl+3hyIa240ucxTR8SypbItv4XLFHdwJ5BAvEQ7B
	FBn1DjDni0oTIFPdHdva6PHSfJQsRbK8rlJqsKWa8PRBSfrB2xE99A5iZiQKJTk=
X-Gm-Gg: ASbGncuqqJDDHODaZtfItej0RcGm6iYsAq27dUGQsLYj4PMn3PIghiqJiUBhY5XIlyF
	W5Z6c6ioR1e2x2ctMt6ai5ws931v+hIvjxKWHK6PLiu+hEVLdNVKp8vamu1ZCXcoA8xMXrSA4gL
	5qszZmw7SOPCiamcJnHOR96hDj5pAeUT5eAEp4PjVWtCRq6IOfwo/z5JDLC4RGnGSzhhpnKpYJP
	tDyJglYev+XTkrRp46+feWdzBSRmg+bHkQLM0TobxcdZqoDoVfG7JusIY5rBnGKIbdS9YLKM+fG
	QZs85HK047qPHnDLF5FVa+n9472b3tpfq/7Bqth22w2bV5SZgirLKw==
X-Google-Smtp-Source: AGHT+IFB0ef71YNR9dJGXCO7UqAzxgYbd67xW8P9JXXgL21idOk1dW4h3KG6K2wPSXyAzJ2F6c4cew==
X-Received: by 2002:a05:6402:2692:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5e4d6b4baabmr28693051a12.23.1740990412164;
        Mon, 03 Mar 2025 00:26:52 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ee491sm776723966b.103.2025.03.03.00.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:26:51 -0800 (PST)
Message-ID: <f03946a8-24bc-4a1a-8d06-d5652a4db34f@tuxon.dev>
Date: Mon, 3 Mar 2025 10:26:49 +0200
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/21] ARM: at91: Add PM support to sama7d65
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <f4634d70f1e7002db059f2cc892fbbbfe1a95dac.1740671156.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <f4634d70f1e7002db059f2cc892fbbbfe1a95dac.1740671156.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dmS1HzMzFxdj
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704392.90779@v53eWl/upd5q81hymTwJ5g
X-ITU-MailScanner-SpamCheck: not spam

Hi, Ryan,

On 27.02.2025 17:51, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add PM support to SAMA7D65 SoC.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  arch/arm/mach-at91/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 04bd91c72521..f3ff1220c0fb 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -65,6 +65,7 @@ config SOC_SAMA7D65
>  	select HAVE_AT91_SAM9X60_PLL
>  	select HAVE_AT91_USB_CLK
>  	select HAVE_AT91_UTMI
> +	select PM_OPP

This is for OPP not PM support. For this series this should not be needed.


>  	select SOC_SAMA7
>  	help
>  	  Select this if you are using one of Microchip's SAMA7D65 family SoC.



