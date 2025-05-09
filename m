Return-Path: <linux-pm+bounces-26933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F91AB1458
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E8252377F
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA428ECEF;
	Fri,  9 May 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="tIgn3Xe2"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81428EA40
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795923; cv=none; b=S7kmdeo60aZNrG0TY5E8JyCV88/Qg7m1U8tk5aNcnk1+7s59fZ6a/DPDI63pEB2T2t4MdKOfIM1/3t9ah7gIMOC0LfpwSyPrXdz4AwsaK4nHpYhDGkAnAAewcDDbbI4PcFtkVNkNwyT0Rm5/n75HJWBxT98+xAJtmtb4M5Lc1ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795923; c=relaxed/simple;
	bh=wf5aooCRDYeY8UPU0Zbj2NphFSO7stnqv3aY4IenlGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBAipX7RUUmBXe72rCszJHFciSAu7dvY4KHcBEQ2KT03flqggG44OaUBbV9kh7gZqR2k9Kn5pl7gf2lgoU5yQrQPAwIErSa3rxyGh6OFxoizsET9wTqsH/i9odVQBVGVLpiYJEhlJbCgsGUbK6Fl4BU9cBGIjNWfdZhQLRTNIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=tIgn3Xe2; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Fri, 9 May 2025 09:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1746795918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gzSnmSwk0nGHtv2iF4t+ebWzcjSFYhcwYVYNbytSiHk=;
	b=tIgn3Xe2JeGm376gk4FVSfq+FmP0ZaFCgb4UHTE7K3hNLhS/FqRBYeGELvYgW5MxqZGVZ4
	n0kBVS1euuaTESPcXx/31E0/NnalAoUrBvZt5CdQsj7zWa61fB8zdwAYSvsr1yGN6ayaw6
	FhsDNP1jUAZnni0KgqScKToufJJ3m8+WS8U12YoV9ufY1G6w2sASlEza3I+RbTJWkAvvd6
	kEJQbO8AIxAufRvXll84vR04nBi3tqBtyjeo0QTFDI2fCwGmFETIm6EGohBbQg4tfZu+St
	UjkMTd89YeYTR25UgS7gTl4cm3jzqLDzzBP6s9JlKlRkSU2SLBnk78pEA/ds7A==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/9] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
Message-ID: <aB39iJm9759RYAKW@blossom>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-6-500b9b6546fc@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503-smc-6-15-v4-6-500b9b6546fc@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

> +	for (i = 0; i < ARRAY_SIZE(ac_power_mode_map); i++)
> +		if (mode == ac_power_mode_map[i])
> +			len += scnprintf(buf+len, PAGE_SIZE-len,
> +					 "[%s] ", ac_power_modes[i]);
> +		else
> +			len += scnprintf(buf+len, PAGE_SIZE-len,
> +					 "%s ", ac_power_modes[i]);

Nit: { braces } at least on the for loop...

(And might be more concise as

    for (i = 0; i < ARRAY_SIZE(ac_power_mode_map); i++) {
        bool match = (mode == ac_power_mode_map[i]);
        len += scnprintf(buf+len, PAGE_SIZE-len,
                 match ? "[%s] " : "%s ", ac_power_modes[i]);
    }

though IDK how people feel about it.)

> +		mdelay(100);
> +		WARN_ON(1);

...What?

> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register power-off handler\n");
> +
> +
> +	ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART_PREPARE,
> +					    SYS_OFF_PRIO_HIGH, macsmc_prepare_atomic, reboot);

Nit: squash double blank-line

