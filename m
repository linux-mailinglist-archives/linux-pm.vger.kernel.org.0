Return-Path: <linux-pm+bounces-13892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DC8971C86
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 16:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A831C22AE4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66A91BA28D;
	Mon,  9 Sep 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJQGDV5u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998561BA27B;
	Mon,  9 Sep 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892151; cv=none; b=AsWTUECBnA9BQ41+wwuB00fqWPRAuHAz0ULMTdr3vqj8GNTxxKiOv99dVAXN5d8I7QCN8qxNk5oMwR1bNUprySSM8dQofjEiFFO6GM3tPKOGgLJCTlKxpSqW1WzduHSwcQ1rDOYVzBI+EG+WpWtOzU5SnPWrpK/mmPM65JQaKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892151; c=relaxed/simple;
	bh=ygupWqgakZDWPAThV+hVt9dHU8i5bT2GtFewIkRe/Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eACDzddSC2ociT3HS7YdzBNLoThS6/jOLgMpdlZZWDUHvcNhGhrHnW7a3tyR6vbobqqakenpmfjRAwj/PzqxP0Q6ZEgeDi8AsuOBiRi+7VpNzJSgKzB2m8qJbwrAhSbuSM/C6qS9efqmsaeeSEu4itswyYAkVdVzh+X/SPgHsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJQGDV5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E36C4CEC5;
	Mon,  9 Sep 2024 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725892151;
	bh=ygupWqgakZDWPAThV+hVt9dHU8i5bT2GtFewIkRe/Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJQGDV5uLFE66Cpvc1fZQiJEbuZJ7+TRFU9q0/E+sHDAQuJzN8p4wXcGy5+VxWo4G
	 OC0M54HOY8fRSM8GftiIj6mHj+zoqYAbNF1NdNR2YPq8CdkvUVaO3o6ivRrA5V8iHv
	 K9uCJIAHCmQVWAH/Mz8REnP8/+YV+n2W9E0KdwBQqldpY4EM4q7IfvZR9ayqPQ7Fre
	 eM7wfg42c7VVdOJygg8ZRYYfh6iuh6wDRCBQ4Txlfxa36IjYINkLBEo3W4HSq5CTqw
	 Tzm8ygtSzRPaicwjdRBB3YvFIa70THIT5tLJDIHXLIQNk6QhCeJsizXQOYe1mMPSFK
	 CnIbegu3MHJuw==
Date: Mon, 9 Sep 2024 09:29:10 -0500
From: Rob Herring <robh@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: opp: operating-points-v2-ti-cpu:
 Describe opp-supported-hw
Message-ID: <20240909142910.GA4188780-robh@kernel.org>
References: <20240905-b4-opp-dt-binding-fix-v2-1-1e3d2a06748d@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-b4-opp-dt-binding-fix-v2-1-1e3d2a06748d@ti.com>

On Thu, Sep 05, 2024 at 10:44:32AM +0530, Dhruva Gole wrote:
> It seems like we missed migrating the complete information from the old
> DT binding where we had described what the opp-supported-hw is supposed
> to describe. Hence, bring back the description from the previous binding
> to the current one along with a bit more context on what the values are
> supposed to be.
> 
> Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> Changes in v2:
> - Drop the patch where I updated Maintainers since it's already picked
>   by Viresh.
> - Add more details of how to populate the property based on device
>   documents like TRM/ datasheet.
> - Link to v1: https://lore.kernel.org/r/20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com
> ---
>  .../bindings/opp/operating-points-v2-ti-cpu.yaml         | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> index 02d1d2c17129..fd260b20c59c 100644
> --- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> @@ -45,7 +45,21 @@ patternProperties:
>        clock-latency-ns: true
>        opp-hz: true
>        opp-microvolt: true
> -      opp-supported-hw: true
> +      opp-supported-hw:
> +        description: |
> +          Two bitfields indicating:
> +            1. Which revision of the SoC the OPP is supported by.
> +            This can be easily obtained from the datasheet of the
> +            part being ordered/used. For eg. it will be 0x01 for SR1.0
> +            2. Which eFuse bits indicate this OPP is available.
> +            The device datasheet has a table talking about Device Speed Grades.
> +            If one were to sort this table and only retain the unique elements
> +            of the MAXIMUM OPERATING FREQUENCY starting from the first row
> +            which tells the lowest OPP, to the highest. The corresponding bits
> +            need to be set based on N elements of speed grade the device supports.
> +            So, if there are 3 possible unique MAXIMUM OPERATING FREQUENCY
> +            in the table, then BIT(0), (1) and (2) will be set, which means
> +            the value shall be 0x7.

I still have no clue what the bitfield layout is. Where do 0x1 and 0x7 
go in the examples from above?

How many 32-bit words is not defined by the common 
schema. You need to define that here (maxItems/minItems).

Rob

