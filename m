Return-Path: <linux-pm+bounces-37326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ADCC2EAFA
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 02:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6122C3B9BC5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1C02135D7;
	Tue,  4 Nov 2025 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCiHQLD1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9119CD1B;
	Tue,  4 Nov 2025 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218125; cv=none; b=fCDbo6hotsAr1av9Px7xvz1+/oSuF/V/k/wD69MMHOYLJHLfM78iEs+Sy/m5SxU9iLFD1EDI1PKEhYhsSG/t5cCC7IMXkuxTumnw+Nx9doelqLV0LTqmJHEhRt/cHqpgFYl376ecPomC8uDopfCR/RRb61KnkSWwv+OaJAeQIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218125; c=relaxed/simple;
	bh=K+rJ33e8ZnjdO7vzPy3i645krvbBHeCx31o+woikNJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe509/6DdS9LhC1bud3iYUUFEa8xAGKyId+liafanklDO6qvJJ/iRY2c52gNPDZxPE6VxpT2ZDDovXgsska+uWVRyQZyG9C5U8ILz8A2x+bcKmmu9Hc/fvrDOf2/7aE0KzJ72kIWDbblZVb/fAKi0o37mIjEai/6NwuOgWlLEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCiHQLD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2FBC4CEE7;
	Tue,  4 Nov 2025 01:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762218125;
	bh=K+rJ33e8ZnjdO7vzPy3i645krvbBHeCx31o+woikNJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCiHQLD1LfDXnUumr9ujAR8072dTzZSGHyeXTdV2fAzkJLddlFvRZ5nxncNOnF6xI
	 QRO7nnv4jynO22aRogaHMHDrUYaTKRyDHtBWO0O2mn6yjY2lPBQUjtCwr/Iq7qvr5N
	 bFW/i9EQ84cnTsQ/iUGFPWjl7/oMePj6kS6YDIYtI3gWqUEYSj9hOFgGNr57Eq6UHa
	 ydTenu7o9ycaS80pc7ieJkBcRhrlBg1PdjkjYZzzOcsNiDUA8xjWr0A3fj5ERvjt8a
	 X4f38gGTt00wQ2ySXjhJo5Sw+c+pb0A5kh15QKhtadtJp7kXwrlMV8Qktl9fMLcZ2C
	 xrxhVToCmyS5A==
Date: Mon, 3 Nov 2025 19:05:36 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Konrad Dybcio <konradybcio@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dt-bindings: qcom,pdc: document the Milos Power
 Domain Controller
Message-ID: <zug3lkerrgvclenswztfcec3wwk36ra7mwioejjch3si5j6x3b@fok5lio66lp6>
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
 <20250905-sm7635-fp6-initial-v3-3-0117c2eff1b7@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-sm7635-fp6-initial-v3-3-0117c2eff1b7@fairphone.com>

On Fri, Sep 05, 2025 at 12:40:34PM +0200, Luca Weiss wrote:
> Document the Power Domain Controller on the Milos SoC.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> index f06b40f88778929579ef9b3b3206f075e140ba96..3f90917a5a4dd9d068ec472565f5009690ea2c5b 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> @@ -26,6 +26,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - qcom,milos-pdc
>            - qcom,qcs615-pdc
>            - qcom,qcs8300-pdc
>            - qcom,qdu1000-pdc
> 
> -- 
> 2.51.0
> 

