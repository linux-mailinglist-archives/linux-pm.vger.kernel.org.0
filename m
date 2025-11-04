Return-Path: <linux-pm+bounces-37325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7AAC2EAD6
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 02:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2942F1895F84
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DFC13AA2D;
	Tue,  4 Nov 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKCFITS1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381D27713;
	Tue,  4 Nov 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218110; cv=none; b=rwRFeOGWQBmWNhpJJvXcGb3WZaOVs2s3FAqd1vQVfAU3qMee2C/WQETlcfpvC2qdPuRaTJJGN4OpOXdYBI08qyUa0PGxwhIe/05/7jrfh4TxK/haDZd4hGpzY3vEXAsoBXhUowHkeXzFQ6YwJkIFVaI5XWPCARviNSLIEXH6W5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218110; c=relaxed/simple;
	bh=Sq4HA4+kpfxlgmNufWAk6p2zbCq9w2iqWP85ZHzP+nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSuvKYQ6lsef+ToaWyiQ1UVsqoOGtWYayI4wjDaOFLnVQIShXoFfAukfSm3qq/191qyu5LCUGO/xJutgudf2CZ8meloUj92CWUsiEyRgsKbwNzbGeoKWsDJ6i3Q0VzA5vRuFr1RSx5ROd7kLEAbE1zdivbBuuurlMEcAIirXLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKCFITS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A72C4CEE7;
	Tue,  4 Nov 2025 01:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762218109;
	bh=Sq4HA4+kpfxlgmNufWAk6p2zbCq9w2iqWP85ZHzP+nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKCFITS1riRlsVcVbjUO231fUyEqEQnuOadAWuMgwbIfSwboWfgvIm39yMRcpL2AS
	 9vV9WfBWFJlFNAWa0a84lrSez1qhS+eEX65DyXGykRp6JUetiMDdURhEyVtJOUT/tg
	 j2W8jQNn0pF5FOISyDmBqnM1XItgWes1fPmRr3Liv3LCGMTUZB7kjX52u3PNv5r6OQ
	 gcbIoMB4r40QdZ4M/FhcsLH0POXkeEb/m8fxvccE1vuadpvGF4vu16xz94ykNL0uXq
	 xZKy8LqzcyG7Fi5gM1u2ZKecLmdw0VlqPjdiEAR/rpat1JYpY8jlfoiIP9LEVj9zrC
	 aRdB48ffVws0w==
Date: Mon, 3 Nov 2025 19:05:21 -0600
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
Subject: Re: [PATCH v3 2/7] dt-bindings: crypto: qcom,prng: document Milos
Message-ID: <hg2smlt2fnwbwxsyasv6ptsfvo7s6twqo3eo3qpdnpbag4xpeh@ks25fqpveihc>
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
 <20250905-sm7635-fp6-initial-v3-2-0117c2eff1b7@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-sm7635-fp6-initial-v3-2-0117c2eff1b7@fairphone.com>

On Fri, Sep 05, 2025 at 12:40:33PM +0200, Luca Weiss wrote:
> Document Milos SoC compatible for the True Random Number Generator.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> index ed7e16bd11d33c16d0adf02c38419dbaee87ac48..0fdef054a1a30c363e0d99518351fb18124904f0 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> @@ -20,6 +20,7 @@ properties:
>                - qcom,ipq5332-trng
>                - qcom,ipq5424-trng
>                - qcom,ipq9574-trng
> +              - qcom,milos-trng
>                - qcom,qcs615-trng
>                - qcom,qcs8300-trng
>                - qcom,sa8255p-trng
> 
> -- 
> 2.51.0
> 

