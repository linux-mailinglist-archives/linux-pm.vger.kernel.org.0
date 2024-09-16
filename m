Return-Path: <linux-pm+bounces-14339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB4A97A447
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DF71F23104
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54603157A67;
	Mon, 16 Sep 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOYm4rO1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF3C1DFCF;
	Mon, 16 Sep 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497585; cv=none; b=oHGDDoTEvl7v6Hb1YFOqjuLhvzKPJbrkmv4KIoVKWEmYRkfi0fSH+SWELxaPAsBSV3j7dsOV1psvA2t6M5CNmfLonHt3NJbEjQnhJsy5U3QlPBdyZbX3lwMSQhmpcQT1yclXdrKkErXU30FNCG7enJlm66BcuCYuFAlbr62YbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497585; c=relaxed/simple;
	bh=+g5/8z+N7p1/vFynIT3SDk63WDBI02Y/qPQf/9fcmEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcX6IBAn44sc2B8sreAqKcfE19zL9h4u/ZkoIxUW1wxrWhyfHJbO1gnRf2JgRy/9yHzTIMWfPbiwaZ25Dh1q0gNrEW9Z3ST5osCUir06Hlv8O5/9XFmu/bV3FsiqkBcpNcmXjyH3G3d3IBLJHXMk+KFyFKFHE66cq4bU6642/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOYm4rO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B60C4CEC5;
	Mon, 16 Sep 2024 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726497584;
	bh=+g5/8z+N7p1/vFynIT3SDk63WDBI02Y/qPQf/9fcmEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOYm4rO1eidzqhAUbbchlDXiD11CrL+bMTekPVvaX/mcikU/7eSqcoV6KBRDGD/j9
	 S6RlCV2qlMMfQ2J9tfszb//dUJ4wDWXyEOsLJqp/fz1elfwTdPquHmwCJL0J3O26i+
	 c3ZJCm9SObkFDfiXmhar9g6OcmCMVuSXZt9V4K+hdctaxgI61Pl+EDZmgAB2ApLZQb
	 Un+bxnoAoZwK6ehUZ7YAXRKW0SklZcGLqGNoPVmP4eBQ3QMpmELFKKiF31gP816RKQ
	 zkelIScxmLVMlWHF7wPC1qRrjLHMgAD6pRHCqbAicxjYIp+9Y+vtF3nLrn70IHAN9b
	 f6hBaV2YnWo2Q==
Date: Mon, 16 Sep 2024 16:39:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v3 18/20] arm64: dts: apple: Add A10X devices
Message-ID: <ntl53bla2qwueycbffta5ytmmm7hxrthbfz2677mltldgu6roi@3f3pz6644vb5>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
 <20240915080733.3565-19-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240915080733.3565-19-towinchenmi@gmail.com>

On Sun, Sep 15, 2024 at 03:59:03PM +0800, Nick Chan wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
> 
> Add DTS files for the A10X SoC and the following devices based on it:
> 
> - Apple TV 4K
> - iPad Pro (2nd Generation) (10.5 Inch)
> - iPad Pro (2nd Generation) (12.9 Inch)
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> [Nick: SMP, m1n1 and Apple TV 4K support, uart interrupt and pinctrl fixes]
> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../devicetree/bindings/arm/apple.yaml        |   8 +-

You need to split bindings.

Best regards,
Krzysztof


