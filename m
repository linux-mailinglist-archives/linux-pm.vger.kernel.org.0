Return-Path: <linux-pm+bounces-19977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC2FA01FA8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 08:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18A71884E20
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D331D6DDD;
	Mon,  6 Jan 2025 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBUmDX/Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAB1D6193;
	Mon,  6 Jan 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147518; cv=none; b=PPRW77ElapkokDSroR2mrm8L1PN401loEiKr8sFqfcruITqelOL3GREbvBdc6ljo7ely9Nr4bOWAssqyq71q81AdyVWG28sO7GiTbCSt39Oiba7knrgBa98uKMfooIO2Fr/e5aFkPq/wxMT/p6BDn1WZ3AXSv+0IRGGX1bxdI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147518; c=relaxed/simple;
	bh=oLCXSmrVBBsLo0CzHgC7aJIZWv4lFAGFHcrnLUBjFTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ahlh04Dj2kqwgaZHxvLYkgF+w0IkPXzReeaD7d3S50YscvVFuRp9NXFFlQ44MbKiZGin+kZcXqVwvQ3pGfKKgQQbnt7x8Vt9bXfPDZD8fgOc//hrERdTEV75SqT5/fToOjeqaOw41TUuDYXTQlGU+52CydmP6WMvvVYGTSuT+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBUmDX/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA48CC4CED6;
	Mon,  6 Jan 2025 07:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736147517;
	bh=oLCXSmrVBBsLo0CzHgC7aJIZWv4lFAGFHcrnLUBjFTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBUmDX/ZNH3ng9jNNgpjkne5Azv0/mD0yUnO8Xtjsqh9sfUogukNwxkVHgYXTq99T
	 AFabrXUxdUnIWDcKrqvdrtJvu6CMpycSYezrajtvbSiDDBv92MgYOLkuxWgy/KumcC
	 DKldYh8Lcm+4DzxhmYTVbFKw3PS/sfl7eU5BLLpUzDPXAyhAzBOBzeCdV+1LdBF0Zv
	 eR9LC9Bti5XV2xES3XdLDWPAz2J/neJ54usqCt9QSro1GFigHL7xOgmY8cjgSQVIuv
	 C5J90lBwbvS5ud8bfQnbyScDK2lh1hxpVIWY3p9K3Cpv6XBEMkByz3k4exYxnl/nsL
	 6zLbwcXRUXVnw==
Date: Mon, 6 Jan 2025 08:11:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Sebastian Reichel <sre@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Message-ID: <md45rp2dmv7aibez2sxwzyjayfi4wbujshlc46hxi6v4jzlhfr@tpbtqv46hrlh>
References: <20250105174159.227831-1-mitltlatltl@gmail.com>
 <20250105174159.227831-2-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250105174159.227831-2-mitltlatltl@gmail.com>

On Mon, Jan 06, 2025 at 01:41:55AM +0800, Pengyu Luo wrote:
> +maintainers:
> +  - Pengyu Luo <mitltlatltl@gmail.com>
> +
> +description:
> +  Different from other Qualcomm Snapdragon sc8180x and sc8280xp-based
> +  machines, the Huawei Matebook E Go tablets use embedded controllers
> +  while others use a system called PMIC GLink which handles battery,
> +  UCSI, USB Type-C DP Alt Mode. In addition, Huawei's implementation
> +  also handles additional features, such as charging thresholds, FN
> +  lock, smart charging, tablet lid status, thermal sensors, and more.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - huawei,gaokun2
> +          - huawei,gaokun3

Missing "-ec", because gaokun2/3 is the name of the board, apparently. You cannot
duplicate compatibles with different meanings and if you tested this you
would see errors.

I think I might mislead you during last talk, where I questioned what is
"gen2" etc.

> +      - const: huawei,gaokun-ec

There is no support for gaokun2 here, so I assume you checked and you
know these are compatible. What's more, you claim there is a generic
piece of hardware called gaokun-ec and everything in this family will be
compatible with it. Well, that's my standard disclaimer and disapproval
of using generic compatibles.

So in general what you want here is *only one* compatible called
huawei,gaokun3-ec

> +
> +  reg:
> +    const: 0x38
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +patternProperties:
> +  '^connector@[01]$':
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+

Drop +

Best regards,
Krzysztof


