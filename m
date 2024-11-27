Return-Path: <linux-pm+bounces-18157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C39DA9D0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 15:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B01A165AA0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191471FF607;
	Wed, 27 Nov 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bChw92x9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B51FF600;
	Wed, 27 Nov 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717387; cv=none; b=K6BgqEKh++FooCpw3wBf8Zih51dLNJhsG04DzPiWXeUSgGq05ku8A14H33T4UbVQsnnBq3lBONvtqMfB5/y7U99Ss5rjHPLJL0t53/BInggRGvQuajgu/XBbTggx4rwg0oCE4vgGQGg8cpywJ4sUiRzfP/QjOR+OK7Zo85y1dLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717387; c=relaxed/simple;
	bh=s+Dd5OmvJfSGzVWRHgb00RXOruG+MA8ymtcQ8+AR5Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFZuJswQXEv45+B+E9eDBWfrlx/7Exk0T3kTRhqlFjpH6nMGUwd1VcN9/7sQURuQ9PV1Rb2zVq/NmI5oDPI+FJPlF1oew8hxcCs7RAzMJzL0i6YHKX3pXi7xlWUEqEVeSRaqqsmYpR8GezNbxSHzQW4Me8mncFvd6OVKvF2SJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bChw92x9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E43C4CECC;
	Wed, 27 Nov 2024 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732717386;
	bh=s+Dd5OmvJfSGzVWRHgb00RXOruG+MA8ymtcQ8+AR5Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bChw92x9A6wsJNCywqTXl5VZfC2x/Pj3J6FW2a/kVHeWCLBTBqSorfp8+39bVXgZ4
	 8uSjq3YtPofshYxhs/NjrAN/T6Y2eqUGDlXZFib5/+tb/sk3vOIzh3m4jbw1HAUbaK
	 +v5XJHQrvT3TMnIngve/wFhwNiD5QRxhO1PyZVE61dBYSBDTWSYvUDyXh/LSTFtSWp
	 K+ipJW6S1NpCW1uFo0uIIuamml1BF2bU7yPTL6ApeGe7lFh9Y9oEtITdJX8xw3A6x0
	 WkTD5WS8qTnwLN3H5uXXXqVhqT1KMJucE9YGIDlrEqYObGPxZJrcZ5LrTVmIAzrf0e
	 d3Tl+LuqXPDTA==
Date: Wed, 27 Nov 2024 08:23:04 -0600
From: Rob Herring <robh@kernel.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 3/4] dt-bindings: interconnect: Add generic compatible
 qcom,epss-l3-perf
Message-ID: <20241127142304.GA3443205-robh@kernel.org>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
 <20241125174511.45-4-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125174511.45-4-quic_rlaggysh@quicinc.com>

On Mon, Nov 25, 2024 at 05:45:10PM +0000, Raviteja Laggyshetty wrote:
> EPSS instance on sc7280, sm8250 SoCs, use PERF_STATE register instead of
> REG_L3_VOTE to scale L3 clocks, hence adding a new generic compatible
> "qcom,epss-l3-perf" for these targets.

Is this a h/w difference from prior blocks or you just want to use B 
instead of A while the h/w has both A and B? The latter sounds like 
driver policy.

It is also an ABI break for s/w that didn't understand 
qcom,epss-l3-perf.

> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml      | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index 21dae0b92819..e24399ca110f 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -28,12 +28,15 @@ properties:
>            - const: qcom,osm-l3
>        - items:
>            - enum:
> -              - qcom,sc7280-epss-l3
>                - qcom,sc8280xp-epss-l3
>                - qcom,sm6375-cpucp-l3
> -              - qcom,sm8250-epss-l3
>                - qcom,sm8350-epss-l3
>            - const: qcom,epss-l3
> +      - items:
> +          - enum:
> +              - qcom,sc7280-epss-l3
> +              - qcom,sm8250-epss-l3
> +          - const: qcom,epss-l3-perf
>  
>    reg:
>      maxItems: 1
> -- 
> 2.39.2
> 

