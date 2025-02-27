Return-Path: <linux-pm+bounces-23119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA31A48502
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843D2174AA9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9891B4232;
	Thu, 27 Feb 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5znDtvf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66E1AAA05;
	Thu, 27 Feb 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673021; cv=none; b=IByh+aG17YRk5lf9yIr8M75jH6twBnHawrpHHk3+48eTN8pMHFIxvvjYjDJg6eX8JbjxQrnsw0gqwi8KFHdYy4QLvqo9Byti0/yFbw3iVWmlw8qC6wK+6MfV1BNflPFQoSq8Uai1odWP5dr1WB8yAhDVqDwxcSfT10BsFeOAD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673021; c=relaxed/simple;
	bh=C/IXySloKFVBYOwHeyIU21KrrNb5UqpWetJ68tooln0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0vbMPP6bgqW1C68kw81VVqWEoiFtPbkfocI4ghwhQ1tmzpZ6U5tSPfSn0G3OqlwxW4PvLz09Yh7hYjuBqedxI48MqukbJnrYy/m4gxdB+WF3L9kQS/VaKQwbqH63dBX/zvBfIv1Ri/Q0MYoe+OhgoSZydKiot+HqDa5Xe1NRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5znDtvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E869DC4CEDD;
	Thu, 27 Feb 2025 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673020;
	bh=C/IXySloKFVBYOwHeyIU21KrrNb5UqpWetJ68tooln0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5znDtvf3i39QIl2tjSqo+54dFM2Nti1LTC5vEUOyGxK3YsgLDYe17mNX5RTn+/4N
	 boU83qNPp5h+MbzsYxfBM9F9LsJHE0bIwXtA6EzpX3XqeUfw0aFrawUX0iS+FTKsmn
	 GGGmR38J5pbp7StNJOgJzsCjYJmnx6jZasPD3kI2yVk/ZQ1sXw8huWAM25Yv2iJ+Vg
	 e8vIriyF9AWivEnrpxKvShjPYrHqmN4tc3/v7QGeb0yoB+mJ3hq9owFL7lGGuwDffN
	 XAw4vUbn/2MahkTBPcdYKkfMG8RV8oFLrTejUtZWipdN//Zn72QFMF+sM0d+E4R8vf
	 wGSz+xd6cI5Yw==
Date: Thu, 27 Feb 2025 16:16:54 +0000
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	kernel@collabora.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	Andrew Perepech <andrew.perepech@mediatek.com>
Subject: Re: [PATCH 03/13] mfd: mt6397-core: Add mfd_cell for mt6359-accdet
Message-ID: <20250227161654.GG824852@google.com>
References: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
 <20250214-mt6359-accdet-dts-v1-3-677a151b9b4c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214-mt6359-accdet-dts-v1-3-677a151b9b4c@collabora.com>

On Fri, 14 Feb 2025, Nícolas F. R. A. Prado wrote:

> From: Andrew Perepech <andrew.perepech@mediatek.com>
> 
> Add an mfd_cell for mt6359-accdet and describe its IRQ resources to
> allow the mt6359-accdet driver to probe.
> 
> Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/mfd/mt6397-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Looks okay.

Not sure why the other patches are yet to gain attention though.

-- 
Lee Jones [李琼斯]

