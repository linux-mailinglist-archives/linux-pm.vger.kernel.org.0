Return-Path: <linux-pm+bounces-13249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9829665D1
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 17:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5113B24E6B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7A1B86DE;
	Fri, 30 Aug 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGu2EEG4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242D1B81C3;
	Fri, 30 Aug 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032080; cv=none; b=spG/sW/SxmriZnDPHpzU6zhbRZLMxUSa05BpP/RvF/ynWLO995f4N3FhSbt8PobHYETUJB4arl7vfMZ0JzRD1FYqB9TzbCwtjJrtvOYpsQ93GCXqmhzgPiBUDY1xfJqxtlCngLbnXpc4rp0un6L7NknPFGvgQ/qfTdHVfTreFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032080; c=relaxed/simple;
	bh=sMhjK2G93E8pRdOEGgRej93yB0F8vhk+6uOsJO083iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePSaY+++/UeV/Xinn+MwY22BXxlllp5flPtoRTbACmlUkC5pSwKgxC8OS5zdKErMPpWclGUOQkw16JWRCFV6/OgiV1A8VeAqbpGmCTiHux1PwgMKuUfvid6NHiDxmsv7N4B+7Qt45oMUAUDkgQnvtlhx6rTcFQMMpfV0MJjjcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGu2EEG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36455C4CEC2;
	Fri, 30 Aug 2024 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725032079;
	bh=sMhjK2G93E8pRdOEGgRej93yB0F8vhk+6uOsJO083iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGu2EEG4qNddC56ktd+1VgcidfLuPMPi9DcvYjB8+u+ih72S9+0T0da4r8ynZnk3g
	 uR/6O5p6dBovtm452fMouESkWIiCaWQUfBRivhC/tUQ64Np56kzACgQ+N5XZ+qxpVJ
	 e2QXDNUpP+7nKL9d3OlS3Rwkz4Tq04Ccw/3LjyXnfdQqgefQt1EAS2K682LY4cetbV
	 N1y5WDQj4SEetgbGNmagrg5ajX/6/W5ZmL4qsIapmKNu1lpl3iqkTybW/MclgMf9vf
	 Qwa7DbNb4yqKc4qE0/ylwDVkqcbTik4pTgPG9Cq20KDSUbfiXsxUUScfIlMlLegBaw
	 xMaFmb9Ds0C7A==
Date: Fri, 30 Aug 2024 10:34:37 -0500
From: Rob Herring <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Sean Wang <sean.wang@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 3/7] dt-bindings: rtc: mt6397: merge to MFD
 mediatek,mt6397 DT schema
Message-ID: <20240830153437.GB4175444-robh@kernel.org>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
 <20240830110732.30080-3-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110732.30080-3-macpaul.lin@mediatek.com>

On Fri, Aug 30, 2024 at 07:07:28PM +0800, Macpaul Lin wrote:
> Convert rtc-mt6397.txt be compatible with the DT schema.
> Since this is a simple RTC device node, merge it into parent
> mediatek,mt6397.yaml. Subsequently, remove rtc-mt6397.txt with a
> separate patch.

This doesn't match what the patch does. You can just squash this into 
the MFD patch where you add the schema.

> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../devicetree/bindings/rtc/rtc-mt6397.txt    | 31 -------------------
>  1 file changed, 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

