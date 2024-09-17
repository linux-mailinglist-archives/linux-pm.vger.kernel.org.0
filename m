Return-Path: <linux-pm+bounces-14380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D280C97B596
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 00:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 695DCB23CE9
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 22:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8FF188A11;
	Tue, 17 Sep 2024 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsHFumXJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91315B0F2;
	Tue, 17 Sep 2024 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726611088; cv=none; b=DW3bQcsQXYHEAJhVuQ3EFPd/vJ/uDlT/PF8XVYpnPUqEhwj7p5DiIKAH3pygEPTziQrbTzyVCIdcPI1ARoXtfbEXD9n59Zb76llAlAWJqdJo0ULch4TpVJ3ZY2u7J8L/g6JToJXV2nvsq6+tco5DzAhKwll3BobyuG6ZxsmWO9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726611088; c=relaxed/simple;
	bh=3zlCQ5XhONwK70p5T8DApl7b3ks8gUqFavgcErUBXks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AphhQo8QgadqhcYeDw5FVxwg1+BmZmIH6IfWbmc7NoF4KhN2CV92ITg3/hIvRhHlVBkBsTlQ4OiLHLWZZRGh6S45KDz0vSX8PBSMrXd4tz50q1j1TWvHj92b1DgKpBe4kfwOSR/Vcng/jWAF+4FeT4Q/XqfEyOK0gpxC8MGPElo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsHFumXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056FFC4CEC5;
	Tue, 17 Sep 2024 22:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726611088;
	bh=3zlCQ5XhONwK70p5T8DApl7b3ks8gUqFavgcErUBXks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsHFumXJphh53qPKe051WLkmQxpZK/VjsK7WQXiM5VBm3f8XbT8Pne4pm24A/EhRL
	 0XIJP4W7857sNcj1jQLpsg5OElmB65FK4XT5Y+oHgE+yuaujCxIZEly2Emk4pCfj82
	 /tk/pdMN1gIGAY6EHIcRQ2RCo92xJrhkID12F0S9R0kB4+qS3T54VW3KNrMvdSOahD
	 LAs3aOflMuudR0tC7LY6uQRJdBCGG+C5A+8a/sS8tla94O8/jHavslHCCii9BJ3+gM
	 UKqZqteDEnnx4gQWfN57WlFITA1OTaJsi8JtNkUdfiniH9WEMqxR5ekHPoxtMhF6lC
	 v5lQF0MRZZKAw==
Date: Tue, 17 Sep 2024 17:11:27 -0500
From: Rob Herring <robh@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nm@ti.com,
	vigneshr@ti.com
Subject: Re: [PATCH v3] dt-bindings: opp: operating-points-v2-ti-cpu:
 Describe opp-supported-hw
Message-ID: <20240917221127.GA4045627-robh@kernel.org>
References: <20240917095252.1292321-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917095252.1292321-1-d-gole@ti.com>

On Tue, Sep 17, 2024 at 03:22:52PM +0530, Dhruva Gole wrote:
> It seems like we missed migrating the complete information from the old
> DT binding where we had described what the opp-supported-hw is supposed
> to describe. Hence, bring back the description from the previous binding
> to the current one along with a bit more context on what the values are
> supposed to be.
> 
> Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Changes in v3:
> - Use the items: and then provide description for both required items.
>   This tries to address Rob's comments on previous revision.
> - I've not use min/max Items as the 2 descriptions items implicitly
>   imply that number of bitfields needed are 2.
> - Link to v2: https://lore.kernel.org/all/20240905-b4-opp-dt-binding-fix-v2-1-1e3d2a06748d@ti.com/
> 
> Changes in v2:
> - Drop the patch where I updated Maintainers since it's already picked
>   by Viresh.
> - Add more details of how to populate the property based on device
>   documents like TRM/ datasheet.
> - Link to v1: https://lore.kernel.org/r/20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com
> 
> ---
>  .../opp/operating-points-v2-ti-cpu.yaml         | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> index fd0c8d5c5f3e..700af89487d0 100644
> --- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> @@ -45,7 +45,22 @@ patternProperties:
>        clock-latency-ns: true
>        opp-hz: true
>        opp-microvolt: true
> -      opp-supported-hw: true
> +      opp-supported-hw:
> +        items:
> +          - description: |

Don't need '|'. If you want multiple paragraphs, then put a blank line 
in between them.

> +            Which revision of the SoC the OPP is supported by.
> +            This can be easily obtained from the datasheet of the
> +            part being ordered/used. For eg. it will be 0x01 for SR1.0
> +          - description : |
> +            Which eFuse bits indicate this OPP is available.
> +            The device datasheet has a table talking about Device Speed Grades.
> +            If one were to sort this table and only retain the unique elements
> +            of the MAXIMUM OPERATING FREQUENCY starting from the first row
> +            which tells the lowest OPP, to the highest. The corresponding bits
> +            need to be set based on N elements of speed grade the device supports.
> +            So, if there are 3 possible unique MAXIMUM OPERATING FREQUENCY
> +            in the table, then BIT(0), (1) and (2) will be set, which means
> +            the value shall be 0x7.
>        opp-suspend: true
>        turbo-mode: true
>  
> -- 
> 2.34.1
> 

