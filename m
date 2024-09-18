Return-Path: <linux-pm+bounces-14420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436D897BFB9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C75D283EEA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A289A1C8FD6;
	Wed, 18 Sep 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhWLnGX9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3A1494B1;
	Wed, 18 Sep 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680873; cv=none; b=XK1/KMxzQmYE6Rn1RJR+BcIRVVwz41tDLroDafE4g8B1yjfd0STpXJ0dKVCeNdKEi8qS32CVdHA5Z6fx5bv1dfQ+4orNoISPOQ3tlHfHAI+PvwypjNJOa1DjXENbZIN/vgcJG1mYLknREUZFdLtxc+Z0BAWiSZ0Wb7kno6ylZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680873; c=relaxed/simple;
	bh=Ag88+zokUhRSgZzPziKEPeP6Mdvl0oOyZMMJnyWDSbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpkG30RpMEd0hNccGn+oCLIJ0n6Um51WR7q1/iaFWO9boRyshIcKXupImUshVc/eiBfRyJFjgUmBIPltdEvmfi72WTxcRzJ1fCYSWBtJgQOVv7u/4xz4T/D8KBUkc6DBZ3/DtoOs8aRAWT7CnHjrdI/au9Ehr1oE3xpkjVfNtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhWLnGX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BB1C4CEC2;
	Wed, 18 Sep 2024 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726680872;
	bh=Ag88+zokUhRSgZzPziKEPeP6Mdvl0oOyZMMJnyWDSbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhWLnGX9oh0QrTo8OTO6lL6G2nVHOpekgiaXvdAuw8IICw3gDfDozq5e6YGSFa7PM
	 eFrQewdh9bUVoiCKhRNzzjBbITC7XumP2+h7OiMAdnCsa95nBPzGVJ63RytCR5daJm
	 ndiUDCNysNF/RiSc3zkvDC5ChgA76G0qBnsY4kBQz+IrhxyOQyoWfpeWvUy+WmYSBl
	 Lp3e8gNrrXgovUeX9XAX2XJWqnDZ7V/i5Z96zAwdPmV8Xx1xCotKbdutsbbnNbaWc7
	 Prp9oBRKMhyJDI6nek6wog/A0fAmUwpVdUiglaivoibw7DJE/+lDc8uOIDNaWPQyvp
	 oc8srhShDuB2A==
Date: Wed, 18 Sep 2024 12:34:31 -0500
From: Rob Herring <robh@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nm@ti.com,
	vigneshr@ti.com
Subject: Re: [PATCH v4] dt-bindings: opp: operating-points-v2-ti-cpu:
 Describe opp-supported-hw
Message-ID: <20240918173431.GA1833339-robh@kernel.org>
References: <20240918053317.1390626-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918053317.1390626-1-d-gole@ti.com>

On Wed, Sep 18, 2024 at 11:03:17AM +0530, Dhruva Gole wrote:
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
> Changes in v4:
> - Fix dt_binding_check errors on previous revision.
> - As per Rob's suggestion, used a blank line in between description
>   and the paragraph.
> - Reworded the description a bit.
> - Link to v3: https://lore.kernel.org/all/20240917095252.1292321-1-d-gole@ti.com/
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
>  .../opp/operating-points-v2-ti-cpu.yaml       | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> index fd0c8d5c5f3e..7c07410638db 100644
> --- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
> @@ -45,7 +45,25 @@ patternProperties:
>        clock-latency-ns: true
>        opp-hz: true
>        opp-microvolt: true
> -      opp-supported-hw: true
> +      opp-supported-hw:
> +        items:
> +          items:
> +            - description:
> +

A blank line here wasn't my suggestion. Do you see it done like this 
anywhere else in the tree?

> +                The revision of the SoC the OPP is supported by.
> +                This can be easily obtained from the datasheet of the
> +                part being ordered/used. For eg. it will be 0x01 for SR1.0

/eg./example,/

Is this 1 paragraph or 2? Put a blank line in between paragraphs if 2.

> +            - description:
> +
> +                The eFuse bits that indicate the particular OPP is available.
> +                The device datasheet has a table talking about Device Speed Grades.
> +                This table is to be sorted with only the unique elements of the
> +                MAXIMUM OPERATING FREQUENCY starting from the first row
> +                which tells the lowest OPP, to the highest. The corresponding bits

Odd line wrapping. 'which' should fit on prior line. Wrap at 80.

> +                need to be set based on N elements of speed grade the device supports.
> +                So, if there are 3 possible unique MAXIMUM OPERATING FREQUENCY
> +                in the table, then BIT(0) | (1) | (2) will be set, which means
> +                the value shall be 0x7.

Here you should have a blank line.

>        opp-suspend: true
>        turbo-mode: true
>  
> -- 
> 2.34.1
> 

