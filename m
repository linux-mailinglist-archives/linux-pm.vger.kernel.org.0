Return-Path: <linux-pm+bounces-33814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B496B43581
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C40E3BECB7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E12C11D7;
	Thu,  4 Sep 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSy/OUSO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817C2C0F6F;
	Thu,  4 Sep 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974058; cv=none; b=SpZFBK0echEf4H0oQJkg624Xm/YnjRXOLx3v6VRUw6q7dJLBHmLI6SXDRgkaGYP62JEhxedWNq4Monz/M5G/maNGXLzK13e+9AebGqaRZJOo3rMr7NoWk16RZKk+0WGeoP0CuoWWXSI/b6Ex+JuH+3jh8/2Ku3wk4y1GYqf5shQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974058; c=relaxed/simple;
	bh=nlOhFP3s8L5AUAfOG7ykkwPjQWERB9QoU6d96TfEL+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnurt9CupjZQjmycaLMKE8ihXVEqn5vNBy8DaH31bjndm8JzVjjHmPc5zzLCCBsxvCmcp/yWjM5qamamBTRFWDdJs1v1LGEe4drvoJJbN5EV+EJ8ytSZvXFlOwyfF3yi6xn9+xeuu892+RDsNSRlH9H2CgH9e55Dcy/EFuRPPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSy/OUSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD95AC4CEF0;
	Thu,  4 Sep 2025 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756974058;
	bh=nlOhFP3s8L5AUAfOG7ykkwPjQWERB9QoU6d96TfEL+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSy/OUSOl/vGmzTRdOdapS2OSRZ8G97JPpM98z2wYRKbuJ8bWd+t6hxz7+rHMlM/s
	 tipahlscBtQD5vGCZv6krx06RWbrJeVoK7/TxsQKMd+B+LIcwn8ok5M4XaKrgp5wqT
	 n8ada+hFalEp6zmzcJp4Sp5uEmMP/g7yjF96O53qBNQM/8oD0RnosnhGx/oK+86zZ0
	 KL9DESUybfN+enQmn5xz9NJugEeC5hYfqr49CgWZw9U55FuXjhAi3qzJvPw53vDPS8
	 7upymmfnUzTecfwPNXLQjtpw3GZ+Kfg1aBgsjYaVHX5rHqMK1o9gH7ucYTKScN23vU
	 p8I3qAxkOzhUg==
Date: Thu, 4 Sep 2025 10:20:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: memory: tegra210: Add memory client
 IDs
Message-ID: <20250904-honest-accurate-bullfrog-fdeaf9@kuoka>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-1-e0d534d4f8ea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903-t210-actmon-v2-1-e0d534d4f8ea@gmail.com>

On Wed, Sep 03, 2025 at 02:50:07PM -0500, Aaron Kling wrote:
> Each memory client has unique hardware ID, add these IDs.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  include/dt-bindings/memory/tegra210-mc.h | 58 ++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/include/dt-bindings/memory/tegra210-mc.h b/include/dt-bindings/memory/tegra210-mc.h
> index 5e082547f1794cba1f72872782e04d8747863b6d..48474942a000e049142014e3bcc132b88bf1a92d 100644
> --- a/include/dt-bindings/memory/tegra210-mc.h
> +++ b/include/dt-bindings/memory/tegra210-mc.h
> @@ -75,4 +75,62 @@
>  #define TEGRA210_MC_RESET_ETR		28
>  #define TEGRA210_MC_RESET_TSECB		29
>  
> +#define TEGRA210_MC_PTCR		0

There is no driver user of this ABI, so does not look like a binding.

You have entire commit msg to clarify such unusual things, like lack of
users. Please use it.

Best regards,
Krzysztof


