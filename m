Return-Path: <linux-pm+bounces-15960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768899A4026
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 15:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40081C2357C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F0A1F4FA8;
	Fri, 18 Oct 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXzqBHfv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483331DA2FE;
	Fri, 18 Oct 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258717; cv=none; b=puExWFtRi/blKDWwLjQfhOVeuQwS/wbCt8jzV+WqFJdXwAyXwZs9WAIshl5gNhq/t2TC+oEm6M/LNhHO3Y7OzzG1siXiu5GACrFzomDQ+MxnQMs8HrAAIxI6Kb2HyXSR3ibD5mR2Yo5p+FiclonkUX7W2Gcda6ncyJbPeAb+mDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258717; c=relaxed/simple;
	bh=6l9kKrhdvz3VaSLcW+CZ5TUXv+XqnLeITpfX2mDcn2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrTuyTbO7PiTqWIa87dVU/uvosM/NDYQvDIBiqiSvBKLWanDjyyrW4Sss3Bp9PUle+hqu+a7ASwuAGH9ij0PrFMSIz99oAVHz/+lCnk7KVLWz+Pxx1Hq0f28gpbvvovGIDLEDhn8R77miywnexyRiSkG02gJ8eRQbQbEeZidwHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXzqBHfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A32C4CEC3;
	Fri, 18 Oct 2024 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729258716;
	bh=6l9kKrhdvz3VaSLcW+CZ5TUXv+XqnLeITpfX2mDcn2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXzqBHfv9tQu2fm4EyHRKKT3xI85RNMiokMpxLagUeOheHDeNM/+od6mdhW06kwi5
	 GM3XNh1M1mCqXDSBjjMKPwKxrCLlft3fJ0Ifd1jzh71bcQ3AL30d7u3OZSnf/wGYmx
	 WGaf1wc95qw5uuM0qI2JozvTOIXY+vlrxqMJUfHwlMA0a7baRbMyrnEOGC1ehtlnef
	 Y5FSbG51kFNfpTpXWefaVohFZFeEQPSkU38lrge3r9xagy3IjaQNaDuPiXL1s6YmVj
	 aXys2r+MoUynj74TOcsIP4BFHvnc39xDbEaD7NrXNUynWnsp68ZL5Z41Y4DS8SP957
	 YjJl3AMJGDnTw==
Date: Fri, 18 Oct 2024 08:38:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Chen Zhong <chen.zhong@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-pm@vger.kernel.org, Sen Chu <sen.chu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Liam Girdwood <lgirdwood@gmail.com>, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: mfd: mediatek: mt6397: Add bindings for
 MT6328
Message-ID: <172925871518.81782.18196829681223078589.robh@kernel.org>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-3-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018081050.23592-3-y.oudjana@protonmail.com>


On Fri, 18 Oct 2024 11:10:44 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add compatible strings for the MT6328 PMIC.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml      | 2 ++
>  2 files changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


