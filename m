Return-Path: <linux-pm+bounces-29271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE37AE3C4E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670C0174EAB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C468E23ABBB;
	Mon, 23 Jun 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYaBP2lk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B5238C21;
	Mon, 23 Jun 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674570; cv=none; b=WCjhRK7TVX4yoqFoetvLO8QlVUnqEnLpDx++iPtZH6AMcEZHN38Up3hNDOhG+woGMxerlfpQgFCipEusRdylo2gkNQ9ynnX7ejahG8IvGa9gibWyPwRi8fERskphKp+hKY1zd2mpLITnAGq/PEI5pFKFfyU1ov9OUrIAlZ2l0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674570; c=relaxed/simple;
	bh=E/V1S8fsQv28bkCAhEQ4ycEwjcFe4GGI4EAwIkH482Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pi7fo1AjHxyd92tU6K+j8x3cdTHgxVvPvjtqt/XSPD553/8Ex5Foyo/vK/taqdDD2J/S0Cq2sREnO9GVDK1TWZLWZYLx55uNDL8vTp/Q+3J3Em9LJxLgTIlrStOK8ttrSxvt2UA3r4EHIerv06ZzWQRAON5j+oZ+l68OZAc3pTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYaBP2lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C3DC4CEF0;
	Mon, 23 Jun 2025 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750674570;
	bh=E/V1S8fsQv28bkCAhEQ4ycEwjcFe4GGI4EAwIkH482Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SYaBP2lk0MdWtqUfv/93HDoI9bgXyLZ1tLGUoFvVQn3m/gqL2pzfO8H4ej/tMuOpo
	 IXbbs9NfCHZpJMK0JIbPK/vuggsuzrNRQJBulX9F4h0vF0THpre66D/rUBsy7scHzk
	 QX50s5saUijGk5oN6fRLOScqEUc6zqKa4/zfL2n9JgdYg81DsDyzEtJHiOsL7HFN+R
	 vTqdIAWvpLpm/my4bGLRZp7TV0NO8xnMoqV/nxj2tsq2xkZpHLA3PAmboH6yFxF10J
	 /gau00wQxz5avfk7CdHNGiNOQnlDl9jAqoe2CJjATH80ADl1hqH21K/kcGJhM9PlBl
	 8rZa7P40gbD/w==
Message-ID: <1d622833-d509-4f5b-ba19-b1f30c592d3b@kernel.org>
Date: Mon, 23 Jun 2025 13:29:10 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] dt-bindings: interconnect: add mt7988-cci
 compatible
To: Frank Wunderlich <linux@fw-web.de>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250620083555.6886-1-linux@fw-web.de>
 <20250620083555.6886-5-linux@fw-web.de>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20250620083555.6886-5-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.25 11:35, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible for Mediatek MT7988 SoC with mediatek,mt8183-cci fallback
> which is taken by driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

This can go with the rest of the patches or please let me know if i should apply it.

BR,
Georgi

> ---
> v2:
> - no RFC
> - drop "items" as sugested by conor
> ---
>   .../bindings/interconnect/mediatek,cci.yaml           | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> index 58611ba2a0f4..4d72525f407e 100644
> --- a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> @@ -17,9 +17,14 @@ description: |
>   
>   properties:
>     compatible:
> -    enum:
> -      - mediatek,mt8183-cci
> -      - mediatek,mt8186-cci
> +    oneOf:
> +      - enum:
> +          - mediatek,mt8183-cci
> +          - mediatek,mt8186-cci
> +      - items:
> +          - enum:
> +              - mediatek,mt7988-cci
> +          - const: mediatek,mt8183-cci
>   
>     clocks:
>       items:


