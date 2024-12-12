Return-Path: <linux-pm+bounces-19108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257219EE132
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C70188737B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E0A20DD5C;
	Thu, 12 Dec 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJK6subi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A820D4F1;
	Thu, 12 Dec 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991911; cv=none; b=EpBnONYJ+WiYIxOtnWPKQDkCnVb7NnDuS5GRolGRJaoQzCfju/QvculgQDF6yCP+JtB/vpGwG9cOGbrtQGIoNSl4/eNWLUYkVlw97kC0B3wOBb75P+3CUkt+FPovoowQewzzqVxXv7PLGFEvGaVNF3U1CYGZESW7KK2BLzn+OgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991911; c=relaxed/simple;
	bh=ugwQc1RwWiUB2k1DlePOXPHk9EZtb/h2RNYw3kRvsz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fznb+QKFtDtk3oUWmeb9Pj0ixH78fbeanLTj23mJjmCmcyx7NuF68Qa3tBFbWIWGcHfBF1KIM2wPzfDfzAwf+9mAteRpuAhwYHs6cjchBTR+Ipm9ywUmqTbl8qHjC8NaMFFxfHQFcjrgTqPJLlDrkpf8a3xUCzgKGJEmysAIDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJK6subi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25D2C4CECE;
	Thu, 12 Dec 2024 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733991911;
	bh=ugwQc1RwWiUB2k1DlePOXPHk9EZtb/h2RNYw3kRvsz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJK6subic4H5yc5DmT1goNA5KHVw5ury6O4813bvE2j0JvE8Vuom5vACfYmvBVLQP
	 F7ek6FLf9b6OoD+RJo/Bj8WdeLccMoDuLyj0EESGHdilYZLBGJBEwQADnM0PNMLJ+E
	 kHgvJjE/YK9oBKoYbYCxbmCUPbyC46Te+BA1lWLEnYcTRa7JiwuOGyaYF/KiddaFVK
	 vqTUPGJ6H/eMwJDK0HQzgwNZW9MqGogacLB8s2b73DT14qyOqd39jQwrvAGGbDttd5
	 rdw58Buife0wajhKDnZ3NqTtHfvHukbSP5vg4u1PCxW/Vtpllbl/sHbwoZibSnddQZ
	 q7ZZzSABa4bdw==
Date: Thu, 12 Dec 2024 09:25:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Asahi Linux <asahi@lists.linux.dev>, 
	Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>, Linux power management <linux-pm@vger.kernel.org>, 
	Devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: cpufreq: apple,cluster-cpufreq: Add
 A7-A11, T2 compatibles
Message-ID: <f7whbncdt3yud3loe6xane4gwzpvyygfdju6e55gf6s2s3k75k@n7ehtngsrqxp>
References: <20241212070344.3858-1-towinchenmi@gmail.com>
 <20241212070344.3858-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212070344.3858-2-towinchenmi@gmail.com>

On Thu, Dec 12, 2024 at 03:03:00PM +0800, Nick Chan wrote:
> Add compatibles for Apple A7-A11, T2 SoCs.
> 
> Apple A7, A8, A8X gets the per-SoC compatible and the A7
> "apple,s5l8960x-cluster-cpufreq" compatible.
> 
> Apple A9, A9X, A10, A10X, T2, A11 gets the per-SoC compatible, M1
> "apple,t8103-cluster-cpufreq" compatible, then the
> "apple,cluster-cpufreq" fallback compatible.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


