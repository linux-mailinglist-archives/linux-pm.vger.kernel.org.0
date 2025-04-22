Return-Path: <linux-pm+bounces-25883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE3A964F4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 11:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CB8178785
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A081F2B8D;
	Tue, 22 Apr 2025 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9VE6XQh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25061F0E2D;
	Tue, 22 Apr 2025 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315222; cv=none; b=Sf5Nlnmpx0ICBU76y1aoK1RVdB2vGMmvDLMi4QqdahMsoPwIIAKM00El0pLccoh40Nat2CqRQTkc0AqzsEDpFdKWfYJ3S8/KY4Mo8rQqY84Yc1gaXpAcOeSfXqaqExB6SjZqFBenA/ifHilQXs58thglkXn3pRxYBlqk8SaL3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315222; c=relaxed/simple;
	bh=uR4c7TVXy6cIFrfSyaKbGAwXsLX03FHagsh1jUPtnb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzVCFPCNoV46U7r8SNF3dN5+rsY5NDkoGtt6k2ke8pn30n4HOCw8OLIud273urYsRDLejwoaqA7GJkoaQ6JJiwlb2Z/IUMf2IUFTEN3lHfDGdlHUE55gu996qgFJiyRH9tmpxMxnZ4+BX6xtCaABfoDx2dQrGtf44dCOhiyxzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9VE6XQh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso3437769f8f.2;
        Tue, 22 Apr 2025 02:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745315219; x=1745920019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+aH8Vkp+uMKgYBEzeWu9ULP2uz2ukYCauu+HrKitUU=;
        b=j9VE6XQhmVUO6Vhm/qVkP4iDNHWpjm95tV9M0DlH44P6NGyzvyt7E+6YKZaCc0Rq1F
         yzq+F/CsJO9Z2fUvxqUqj0y76kIeMA72HtvUvKbsdfsBvlNoxCRSPbSqCovmQo8fI24W
         pAykjA0xQm/zer/EseAv+vrs7LMn2Nf2NluOPDhu4R/Y4jv+zHW+8TR2LgFmYBHjsTFm
         chwDt8DTc2vICe5V8+HHyzZ8jnlug1yAbgp/wjdUZVVQpBrfn3B10wqbBJqcxK487WpA
         iEVXVvlhi3SK2LNgwTPAE+/e/8lOKkofJQ48xZtpEaOAJFDdHfJXGkR6gQ0Qgv8CfDZ+
         XeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315219; x=1745920019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+aH8Vkp+uMKgYBEzeWu9ULP2uz2ukYCauu+HrKitUU=;
        b=k7jgztKCqZWZArsYpe3b+UGL5xJtCOWmXccuHD7rovPX2CO/NLFwr17JcXlEbyoIHg
         srfs+BPM5MRDd1LUFtDEa9uwv94vNrZeMZdnG7LHy58h4eYCX83jvosc7aiibvdC51oP
         BAwnUjJ99awwv6tkRk3rL6+OFKjOCwOUWCeghvuM1aSxfNCt99qcTddkkaL0S6NlW4II
         DjnuA3Y0uuUKKSjFHB7YQsCfn9I5UqEswSgYlytWU9xGBL4ikKX9XF+kz1jSXAZ7/0NL
         heMCESebLXvblt0xZb25tP1cwusXWVpkfqq6s3TV9e57NfPDIhRzo7fKc1TpHpR61kIX
         8NGA==
X-Forwarded-Encrypted: i=1; AJvYcCUuVLuZkvy6FBNBfJ/CZWtjy4fx+sN2Y8TF8E0eBn+TZ0iKrOtzHtBL0vXAkFSgnl5chQ6HC7JLS0Y=@vger.kernel.org, AJvYcCVPuA2NFixD/Iuws2U3njSBDTOApYywxO16QVBCJSgq+SH99fdgvxZQ3rQtuMQaJTORwfhj78p7MmIi@vger.kernel.org, AJvYcCWizeJympk1vlqEdRQ7VQywHjNd/XPF0TPEbg32+9S9OswcygL+JxUX1kbtB4GWsmvysv9o9l1D5Bpfcxb/@vger.kernel.org, AJvYcCWniOcrpRz6XapyvHvHfhNrp6/2ZYUkWxU+JIxurb/2nFsbYUjWBKHx2tsrKVoOGU5T3l2YUiPfiQjl3Z/Zymfb5DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzew+owd3nu0gV4vyvnt2AIDuy0tDWFfnORfv2YdrrOp0H3MgSW
	pJBXHb/tMWeUDi7QrKzkIWu+nV20eL4OT3hpChzGw5522xirsiKm
X-Gm-Gg: ASbGncvEW/7TrvpEDDycutJ8iuvTCEHpNZYvjoKZ6ke0W0mKjtFpmi65OnC/RSyTwCN
	KFftbmrA50H4f2dkGt5FRYFLLrLqfWjQCw/qmOus15ywhLOGvqKI4EqfMz1D0nUa0FE6W5Qcjas
	TDO3h471/KNXq46dW9SMKFlbDGDmxn5ersu2jCx4WvbG10BAN9qxZogImBS8IqnBNpLOsW5702M
	WHcJgqVx5/49xOzJNy5iIB5IfQyE5oIHIRVv9nVShVLhG+MAupLMQUdRc4bp6cDEA5NobsGT4Nl
	zjQoGBubDM8tnQeq4YApTwjPMCjC2U/G6ZtJd4A=
X-Google-Smtp-Source: AGHT+IEMUuvM8SEPdC7enDvmj1KSIpM8sQDJOmbbZ30nkYK0bXnH8XlvLfXljQ4jhhwjqFCSy8BcVA==
X-Received: by 2002:a5d:5f93:0:b0:39c:30d8:3290 with SMTP id ffacd0b85a97d-39efba37cebmr12005512f8f.7.1745315218520;
        Tue, 22 Apr 2025 02:46:58 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:6a3:c300:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43d22esm14785563f8f.52.2025.04.22.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:46:58 -0700 (PDT)
Date: Tue, 22 Apr 2025 11:46:56 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: t.antoine@uclouvain.be
Cc: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/5] power: supply: correct capacity computation
Message-ID: <20250422094656.GA159257@legfed1>
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
 <20250421-b4-gs101_max77759_fg-v3-1-50cd8caf9017@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421-b4-gs101_max77759_fg-v3-1-50cd8caf9017@uclouvain.be>

Hi Thomas,

On Mon, Apr 21, 2025 at 08:13:32PM +0200, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
> 
> From the datasheet of the MAX17201/17205, the LSB should be
> "5.0μVh/RSENSE". The current computation sets it at 0.5mAh=5.0μVh/10mOhm
> which does not take into account the value of rsense which can be
> different from 10mOhm.
> 
> Change the computation to fit the specs.
> 
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
>  drivers/power/supply/max1720x_battery.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
> index ea3912fd1de8bfd0d029c16f276316d06e1b105c..cca5f8b5071fb731f9b60420239ea03d46cb1bf3 100644
> --- a/drivers/power/supply/max1720x_battery.c
> +++ b/drivers/power/supply/max1720x_battery.c
> @@ -288,9 +288,10 @@ static int max172xx_voltage_to_ps(unsigned int reg)
>  	return reg * 1250;	/* in uV */
>  }
>  
> -static int max172xx_capacity_to_ps(unsigned int reg)
> +static int max172xx_capacity_to_ps(unsigned int reg,
> +				   struct max1720x_device_info *info)
>  {
> -	return reg * 500;	/* in uAh */
> +	return reg * (500000 / info->rsense);	/* in uAh */
>  }
>  
>  /*
> 
> -- 
> 2.49.0
> 
> 
thanks for finding this.

Reviewed-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Best regards,
Dimitri Fedrau

