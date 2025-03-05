Return-Path: <linux-pm+bounces-23465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E17A4F7A7
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 08:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568883AC4F1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4491EDA26;
	Wed,  5 Mar 2025 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vovlgwec"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30E1E5B98;
	Wed,  5 Mar 2025 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158379; cv=none; b=AqlI0R/cfZAdXg3Hx/Vnixxzs6/jcljZuK+4EPl04en7j1C7HhpoUFT0/vRml6FKrz06QNnODxoZH3Jx3Uv+Rb7i5QA6go8YYBZU6GkuuMWf6xiE8l/id/u78ZfnO/pgq6CKDUMt2LKU8zTPpK7JfX+qMLU8+zc9yeRMtX0xv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158379; c=relaxed/simple;
	bh=qQn6Jnf+mcSHegDRQ65RUohedFJKfjbw3usr7d1maOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VREG+ay5Ad+p1aVFxJuIQrCvan+BtRnMN2CuUyKvWrrDGZP+WHjOqBJgIInCOeobn8Glh83f318fyZEhcXAREIrCJgwTeybbZISHvgw6uhGp6podV4d3YPXp0Az567a1nQo9vRmztNrNlbgC0TjcGd+paBIoy27XUjc9DQjwphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vovlgwec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA30DC4CEE2;
	Wed,  5 Mar 2025 07:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741158378;
	bh=qQn6Jnf+mcSHegDRQ65RUohedFJKfjbw3usr7d1maOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vovlgwec7HLGQkRfcCMfgTrD7i5n47NNZIHh5z5GoLIBRXgkPNYcluXsdQULe8cq3
	 RbFJ+qFDJN4/Tn71ecGqRI1clebUn7dRt87NkMD8snI/EzleaLbYU0ysYBp8CoFNFz
	 YHrZe7AMbMIKvqmpNIypMCgxf1t1fC+1dfUI7oP5vlnH5br5uW9CMZlAECta+JlIds
	 yu5tEBBT8PS+E7aUMG54ohLfuy461ZeqK5o2nDxli79YY8A9aLAvxDOZ9ibY9inaTa
	 v8NY8OSr5SZT7H4ZJrdSquWLaycyAZrts05zqa1I0Plxs5PUiFBRAEBoq5Wrpa2IXX
	 jaXf7EweyFzgA==
Date: Wed, 5 Mar 2025 08:06:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, kernel@collabora.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 02/20] dt-bindings: mfd: mediatek: mt6397: Add accdet
 subnode
Message-ID: <20250305-dancing-amethyst-tortoise-d98036@krzk-bin>
References: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
 <20250304-mt6359-accdet-dts-v3-2-5b0eafc29f5b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250304-mt6359-accdet-dts-v3-2-5b0eafc29f5b@collabora.com>

On Tue, Mar 04, 2025 at 12:15:43PM -0300, N=C3=ADcolas F. R. A. Prado wrote:
> Describe the accdet as a possible subnode of the MT6359 PMIC.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20

Neither this nor cover letter explains dependencies between patches.
Good luck in making maintainers guessing this.

Best regards,
Krzysztof


