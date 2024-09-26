Return-Path: <linux-pm+bounces-14764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F6986B16
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 04:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09161B22357
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6E1714B2;
	Thu, 26 Sep 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+TINBbm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784B4C91;
	Thu, 26 Sep 2024 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727318839; cv=none; b=asYt7Di1A2c7KN5YSkfruGfz0o3VSSUGfdVps899QKYCrCiqTzRDCnECOGbtCA++7F2BMIRKBgwsa8/xmxgHc+lka+cVuz/wj55ckaYU8ikyblpVy9aM+3WwdXLekQsdCadL3GQZQhGbMMmOTGaMqXroExyApPvgjTrSGVQiCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727318839; c=relaxed/simple;
	bh=p9f7/M6VxVgbyT6r/eQ+Uzua7XO7gULfB6sZ9zJKS/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWOv2GIOglB17AZW6A/L1TxIDPReNUWVIwWfY6jhyhzMxnqj73CyOHOxciCZ2TkfiN+ZnWCL2teSDJUMylGDbl1LK0QDCcEsBzgcQMWzM2EGV7ZjhQY3NbRdW8EYzi5IhSRstUUVWg0B1EStNdWulSJ8LpvmMz5QJGOuwmgKk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+TINBbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779A0C4CEC3;
	Thu, 26 Sep 2024 02:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727318838;
	bh=p9f7/M6VxVgbyT6r/eQ+Uzua7XO7gULfB6sZ9zJKS/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+TINBbmjEJhJwsoO83lrbzVAgVMxJTqAqTmvYqN6a6nGbLdbdo1gdHIeeRIkGg0F
	 SHhX+dOuWPw7zThU5IW/u0kmqnHVCDtaE/YgaVlSK3B/Ksj8Mi5xc6K6FHivf3UoSz
	 TEClrgI5kBJSCktkNy/aKSM+GpFip62ARVQqCTICvL51q6oPCjs0fl802vuaQ1DLKB
	 tr7Bi6A4WkYhO+IYFdNvWwfWEjNaIXkKGq1BH4L+eUkCpeRNMUnATDfII08Qgo4Ti8
	 e5ewRuz8Vf5YeagjKuFA1HE/dik4A6za7nPlg3tFx/T08eFAHBc70Bga3Fny2TsxNN
	 zyMfkLj5diOzw==
Date: Wed, 25 Sep 2024 21:47:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Pablo Sun <pablo.sun@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Sean Wang <sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	linux-pm@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Bear Wang <bear.wang@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: add adc and
 regulators for mt6359
Message-ID: <172731883694.2430476.10157265874067724564.robh@kernel.org>
References: <20240925171156.9115-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925171156.9115-1-macpaul.lin@mediatek.com>


On Thu, 26 Sep 2024 01:11:55 +0800, Macpaul Lin wrote:
> Since MT6359 PMIC has been added as one of the compatibles of
> "mediatek,mt6397.yaml", the sub-device node of "MT6359 PMIC AUXADC" and
> "MT6359 PMIC Regulators" should also be contained in this DT Schema as
> well.
> 
> This patch includes:
>  - add 'adc' property and $ref for 'mediatek,mt6359-auxadc'.
>  - add 'mt6359-regulator' to the compatibles of regulators.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


