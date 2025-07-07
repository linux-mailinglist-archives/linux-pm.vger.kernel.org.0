Return-Path: <linux-pm+bounces-30243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12FDAFABE5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 08:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172FA178BB1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5355E279783;
	Mon,  7 Jul 2025 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNAkyeJ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24495192B96;
	Mon,  7 Jul 2025 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751869626; cv=none; b=ZNxHmB1Pe8LGrraXEIFqMFXz6FBKyTdvfMiVEMPiOLqOSzZfaevmFuqZf0Jcd7eEYHf1sih/DntJv0NRE1jOnmfD/dUQqQDCrnAfGbWKDCLSFeTuiNsZpYLjY+imdriOMuZ+Tc1llhezDYcYqlFFlTT2B0xNM3BAkNF3hU3Xs3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751869626; c=relaxed/simple;
	bh=qgpJwWOs4lGsGZIewidOYHNqx+AL239trjUa1lpTRUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMP8LRtS0oIuVNspifI27urdrVau14X2ukPTzwc+iVhuTvcDuXoV4Gxk8JUzANHmpcQFXtZkh3use2iimtt+AAfwT+XmUS3XmxUCbZ+zICdczk6bJBirhrOKPwTepCCJshoYV1abdiq86t0GW6l5thy/MwiqRmoL6r2f68fY8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNAkyeJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C59C4CEE3;
	Mon,  7 Jul 2025 06:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751869625;
	bh=qgpJwWOs4lGsGZIewidOYHNqx+AL239trjUa1lpTRUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNAkyeJ7zXavwPMmFD8w9pyoJksQvP184yx/9M8iF3lhATTlCVeVNGRgOXsU8Sdbv
	 N6Zkgs2M9CTXrfNUeyxkINK/wUCY3KhVt3KobDInRDK8HYhGv44rXWe/P0Wp9h0bir
	 By0mGMzoVHtgFb90wU687PTZ6Ymg63cmc/jE73eSX/yufY8VFliVb0IKolI9pyVugc
	 vc3wu66xQZyrjF7mnoAPg6ejYFc0XnVzvni6Alfp3PHe+CuAIuNoAn9AD4RMtCH1ku
	 tJ9OHv+0r9IKtp3kRtpEGIkl0gdaM2/vTfBJTbFSQrrvp04+MS0K2cPp/ug0Eyfy7N
	 50QStbyls68bw==
Date: Mon, 7 Jul 2025 08:27:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Johnson Wang <johnson.wang@mediatek.com>, 
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Felix Fietkau <nbd@nbd.name>, Frank Wunderlich <frank-w@public-files.de>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 01/16] dt-bindings: net: mediatek,net: update mac
 subnode pattern for mt7988
Message-ID: <20250707-pastel-psychedelic-piculet-b5af11@krzk-bin>
References: <20250706132213.20412-1-linux@fw-web.de>
 <20250706132213.20412-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250706132213.20412-2-linux@fw-web.de>

On Sun, Jul 06, 2025 at 03:21:56PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> MT7888 have 3 Macs and so its nodes have names from mac0 - mac2. Update
> pattern to fix this.
> 
> Fixes: c94a9aabec36 ("dt-bindings: net: mediatek,net: add mt7988-eth binding")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/net/mediatek,net.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


