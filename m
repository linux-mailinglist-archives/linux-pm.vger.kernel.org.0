Return-Path: <linux-pm+bounces-3555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B301384CEB7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 17:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523C41F29506
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE580625;
	Wed,  7 Feb 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKkDthLQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E55A100;
	Wed,  7 Feb 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322555; cv=none; b=aqPfnBH3co5kM+APqCOzJyxqEyEUlhQZ1rIhVOG3uz9u4DqfBdUo2+8Pb2Lp9xmXShO+wIMgKwv05Cuh6sSMFwXkZCe5P0s8ahb/to+R1nJhYYEBFJ3UW9nlKT4WwcrsYfu/dfKUzmG3CbljQDEZS8NJ3xBAoexg4y7wSnNLwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322555; c=relaxed/simple;
	bh=VUvNmp+FcptDTqhLyvPkH0jFwyeuzgPo0Vn4CkOHnWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcQKZ9VGZG8br3ypwa7IuaQKTk1gdVFBUpbEqkM0keWe3wRbtgMNS74LGpAy0pkZBuYNUUxWtirQXxePnN5ENyp0v237JnB+aGhxChKa4BAxCSfFNozZ6uIIgpwBU8a77H6CuXY5Mw+OUyTRda28kXxFetpko0kSbt+c7YgucWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKkDthLQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b45e8a670so495966f8f.3;
        Wed, 07 Feb 2024 08:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707322552; x=1707927352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4pYG6zwwEvVZqzB1UVyWdaE9HtpoW58qB+A15J4okA=;
        b=WKkDthLQfGBJ/4L0bBtETaOKPWwvBRAIFsaOsU4NixeFrYw4R2FEP0YKruHSM0Ujzn
         0mc/qOnL11/+NwJA3myqY921zO0S1AQ4uy/dBbqWSceMNLoOidEu+VhnTOy4WJYtQMe8
         91kyATKmf6uGccT0OExgoD/P5kP7ZdmD4nbTyBKFBnIoT7N+iRQM1KKvKO4DtP2OLG5z
         CbJnHID3Udqk4QxMTFJrBWIVkoiNXzCWaFXzgtjFEBj20zIkPZGxJhJidgUpMbpEXpgr
         i14RVZge0SHv7bTJuTXtLZbXmtE8zIXrqrzV2WWM9udfWDHz7iE7jXdiQ0/myedBpLl9
         y3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322552; x=1707927352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4pYG6zwwEvVZqzB1UVyWdaE9HtpoW58qB+A15J4okA=;
        b=oR++mjzjePwpqFxNIgAzHdLFCHuzSWlfYBbAKKEw1HW+PF+Ak5phaoDbJnVQFozvOO
         8FVNbbEdesheL6Iftee5Ft7+Oka2uA76xtOBKvjyBsvuzz2ACsj0fuBcVnpQkF0K3MFm
         dy9ujZOVVmD4ca2yhNPchOs/xe7FBu1Mskl2SROSxZsAv4dYd6dWuOVYn75Y4MXuYOpA
         aIYSr+DvyZ6Afy/NS+qWlBrGv0tFYjT8cjpE1ZOc6x48mFiSXo9kQAT115VwwA+XArjv
         zIIYK0I1z9+CWw5W5oRXAxjLZ1SkG4D2hIxLuU9E79Y5+XAbv6xBJPDAweVSch6V3RrX
         teTg==
X-Gm-Message-State: AOJu0Yyhk6sUV2UVEV4wPv/DDKdbuPRjAAAZZde+I2ad7T8DpC9ufba8
	717DePvJfAV/0vud2noPeM1i+8clXtZfwzd8iZ1M9hLFzwex9KlZXia+pG4PlTI=
X-Google-Smtp-Source: AGHT+IHiMy8HKtkCt4IcEdpck47U2LufL/8oYN3slvxpUedKC9QRsxUcjMDjE+7vJNKSY1kscyktMw==
X-Received: by 2002:adf:fc88:0:b0:33b:304d:36b7 with SMTP id g8-20020adffc88000000b0033b304d36b7mr3719237wrr.56.1707322551870;
        Wed, 07 Feb 2024 08:15:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlml/unLO5WKB1WAImP4biDD6QniR65R7n3pK53EWq//01uJihJ2g1nuQOrV6XbNIKBSWP3Smc4+dJk4ocCSolUIxqEuJBBXMze92tUr2YWmA4LY2raDbCst2ZfjnpMiUOl54zw6S4iFK5bSLGmLQjD1cu2Gkhl2Mm9aPeMBqXt4ptrrAvBI/110kzy5Q6vys/JinxkcbNZW1wGoHkeq926xwsZnoADtKfP4hS5dpTPTZ91R1ArWJQg1y74nzYSIy3hnr8IVFLkGVDSq8xKEXIS9zp8qjeepeVOS0vpzWZosFbNCBRhQfQp8bRngPJsw57ljFFhm5MKtCm1g5CNRE/I74lQSAPnAfw4Pdjs2roVg+IvwegLGykH7Y6lyIcKmqk7cdMInFCXXH2Jhv9lxBdtJ2lbTsE85AcqG6NPP2Lmsaz2omO95OB9YVlbZmp3pqv03moci9G756yMl5NMWadvSY0PahN4Cig+4d245tL0UdAxyDLyXIuDlYjo4wtycNifBvlVBQJN2U5vgIL164+cPdNzDUt1heVfvC8rYhfhcyU
Received: from eichest-laptop ([178.197.195.228])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c234900b0040fccf7e8easm5597865wmq.36.2024.02.07.08.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:15:51 -0800 (PST)
Date: Wed, 7 Feb 2024 17:15:48 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Amit Kucheria <amitk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, Josua Mayer <josua@solid-run.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, manuel.aebischer@netmodule.com
Subject: Re: [PATCH 3/3] arm64: dts: armada-ap807: update thermal compatible
Message-ID: <ZcOsjRzE8V73wNtT@eichest-laptop>
References: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
 <E1qA7yZ-00Ea50-OC@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qA7yZ-00Ea50-OC@rmk-PC.armlinux.org.uk>

Hi Russell and Alex,

On Fri, Jun 16, 2023 at 12:50:47PM +0100, Russell King wrote:
> From: Alex Leibovich <alexl@marvell.com>
> 
> Use the correct thermal coefficients for the Armada AP807 dies.
> 
> Signed-off-by: Alex Leibovich <alexl@marvell.com>
> Reviewed-by: Stefan Chulski <stefanc@marvell.com>
> Tested-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> index 4a23f65d475f..a3328d05fc94 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> @@ -33,3 +33,6 @@ &ap_sdhci0 {
>  		     "marvell,armada-ap806-sdhci"; /* Backward compatibility */
>  };
>  
> +&ap_thermal {
> +	compatible = "marvell,armada-ap807-thermal";
> +};

While working on some thermal optimizations, our hardware team
discovered that this patch is still missing upstream. Is something
missing or did it get lost?

Regards,
Stefan

