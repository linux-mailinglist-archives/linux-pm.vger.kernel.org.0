Return-Path: <linux-pm+bounces-31253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC8B0D2A7
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 09:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0305609FB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397B2D12FF;
	Tue, 22 Jul 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6pG3no2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FB1A29A;
	Tue, 22 Jul 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168855; cv=none; b=bLlbDpT+HokUte3/BYkuXth5NCBlrE3aykikJH204J37VSUaazFkul9xcjXUM2TY3r6YVEQAxx3+1AD+BPTYNsrTl1MOLqAkBzz8oMSWq4tFPg8snOaWa6+7p298aUQ5vPaYOdulPtliAlOtnnCF1D5g7D+i4Gz+26g6BkXsx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168855; c=relaxed/simple;
	bh=D/qLVppq36iQHh/jp2D4snN5Gi/I9boTC8d0En/VQ04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6YSX1Da1eJvCmpoFTsQINIgdP6MknTsLrgxRU1XbwKRkS+b9J9QJwUHZseaAhOtmIU/dy4kdJlTF4ZXtr4Qg+h5zUEMDuuhKT/Oa07uKDRXmuqGNWrJCyf/nt7UncytddxeSvTBquZHuUSzpk1P23DCNobh/58tB3c0Gab98OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6pG3no2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DCEC4CEEB;
	Tue, 22 Jul 2025 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753168855;
	bh=D/qLVppq36iQHh/jp2D4snN5Gi/I9boTC8d0En/VQ04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6pG3no2kAqQquA7w9b69deneG/36FsfavHaBYvNGIm3lVD03CaAgCDXdRzA8wRWv
	 5qh6qUQl6Gp8Qi4qqsV36PknfEzyep2mKfDApKokMu2a3duVYXyxaPRLVdWpX/z5HY
	 QWWtU/Xv2i3zBR88ffu0zcoi+eEF6uGEhXzq8Rh+8pelp0LKBestNFeqz48KC0CZWQ
	 0kBYUgN+A2R9vaxVE1EUstl+qDs9o8blklrMsD8GI6Sw5g1JFxmtQqI2VQ78ZGmCED
	 mM+kgXfYSauiUabUTQf7eavEV9VF5enX/74FeW4UjP1GoqWWdvE1TQN7vKfCuZ1gbI
	 HKwIEku0RstoQ==
Date: Tue, 22 Jul 2025 09:20:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com, 
	u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, 
	bchihi@baylibre.com, frank-w@public-files.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 1/9] dt-bindings: thermal: mediatek: Add LVTS thermal
 controller support for MT8196
Message-ID: <20250722-dynamic-truthful-mussel-9cdf1c@kuoka>
References: <20250721081459.16278-1-laura.nao@collabora.com>
 <20250721081459.16278-2-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721081459.16278-2-laura.nao@collabora.com>

On Mon, Jul 21, 2025 at 10:14:51AM +0200, Laura Nao wrote:
> Add LVTS thermal controller binding for MediaTek MT8196.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  .../thermal/mediatek,lvts-thermal.yaml        |  2 ++
>  .../thermal/mediatek,lvts-thermal.h           | 26 +++++++++++++++++++
>  2 files changed, 28 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


