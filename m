Return-Path: <linux-pm+bounces-13437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0BF96A2A6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 17:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081C61F29089
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACD17D377;
	Tue,  3 Sep 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw3O4diw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC102AE66;
	Tue,  3 Sep 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377227; cv=none; b=VLu8FFPS6TDO0vQqdaBKMrnFVl+5jRSgv6aC4qZwlh0WxFQl78YkhV3nzrr3nvdjcXVoWeHH7Q2HpXljOFhHkSfKF16J7W7aE8Oha+d+uzLn7BzPyq4mlaTLLGJ9WaqlFvnbWPJ1pDw+cvofssIUeeZiSYpWkAoQq2GdS4zqou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377227; c=relaxed/simple;
	bh=xHRJBR++gk5UN984vqRoTxLZz7hyZvZb/PDsqUJ6Bmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcqfBZo1ORdw1lFHg+fvtKA/25pMdvh4tRwqZuf6EysHLVqvvmt8f66sAie6MEYk6GTWZhA/bD5ImJXUR8bhlwkNi0YBU7X10XXcCo4zS2XzxRf3rrV4omXI/ywWTjOolEJVuRE9S8FynCv7c5fmjacpync2NGiuCL93vpFp6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw3O4diw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC22DC4CEC4;
	Tue,  3 Sep 2024 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377227;
	bh=xHRJBR++gk5UN984vqRoTxLZz7hyZvZb/PDsqUJ6Bmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dw3O4diwZxKNXN2Hkd7lqN1+10no/UW5InQxldhDZiKqGFwEGx6gClrhgkCVNqsnh
	 Ni5P67OX8jhOniY3iYLqA/e8LwfTRLpHbeD2NTQY10X0LkKJM3e9YzHbBGKf95NpUt
	 JCZ4+JxzDEFE1EYj7H2WI9zHlwE6Bqn+svMwWQ6Us4AIxigZsUpJmUEAWdgdoGsa+o
	 rkrjngBXMMFHZR1ymDDV8ZrdGNW0H8opq696QVgjQtLI8l0tnp9OiJ2ZVSXHA9IJkP
	 YXLpTRLi2PzJ+kCjz0rQn4tTT+5D0t/qkgk4tX95BHUDUmWLnqO89vgmnHbfCks9sx
	 fAk8fMASknBcA==
Date: Tue, 3 Sep 2024 10:27:05 -0500
From: Rob Herring <robh@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: opp: operating-points-v2-ti-cpu:
 Describe opp-supported-hw
Message-ID: <20240903152705.GA1044006-robh@kernel.org>
References: <20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com>
 <20240903-b4-opp-dt-binding-fix-v1-1-f7e186456d9f@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-b4-opp-dt-binding-fix-v1-1-f7e186456d9f@ti.com>

On Tue, Sep 03, 2024 at 04:00:07PM +0530, Dhruva Gole wrote:
> It seems like we missed migrating the complete information from the old
> DT binding where we had described what the opp-supported-hw is supposed
> to describe. Hence, bring back the exact description from the previous
> binding to the current one.
> 
> Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  .../devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml         | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> index 02d1d2c17129..90855009cb81 100644
> --- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> @@ -45,7 +45,11 @@ patternProperties:
>        clock-latency-ns: true
>        opp-hz: true
>        opp-microvolt: true
> -      opp-supported-hw: true
> +      opp-supported-hw:
> +        description: |
> +          Two bitfields indicating:
> +            1. Which revision of the SoC the OPP is supported by
> +            2. Which eFuse bits indicate this OPP is available

This does nothing to tell me how to populate the property.

>        opp-suspend: true
>        turbo-mode: true
>  
> 
> -- 
> 2.34.1
> 

