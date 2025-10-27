Return-Path: <linux-pm+bounces-36926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB01C111AA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 20:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13C76508484
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 19:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5232D7E0;
	Mon, 27 Oct 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFzBCiD2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA81BC4E;
	Mon, 27 Oct 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593106; cv=none; b=aV+3xMBpCEY6vmoipRw3Fx4AlaPQCXxXPUxN43OumUeq+dFOQ+TpxHSdxo7TMBSIIocXGLmIA1pWKxY2T4UzDA5GWU79O2mihIzby4hp3unWZl2n9yfBnmqVCRNjb9dMM5zcmNf+FHhjNJVqw5s1tSmiTaG92t7zOsiOQn34diA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593106; c=relaxed/simple;
	bh=EMFYNTxqqtbeWG7w/xTxHN65hWaPaOm53UuixA0S/bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEqP/8hBcdrAtDRJTj+ZKBLBzzZoNn2JGJ9CZEIhNMyiqYYAUq2FVAue85NFeYMVPKLSI6m5UbMLEJrBMFb5IaAyEaZvbgQkxzWEzS/6YriJUIi/CUqi9GII5R16FnAu/S4V7ygnDLwPNPHC3fvh96MSNNLYi9lSDdtgKzvv3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFzBCiD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB041C4CEFD;
	Mon, 27 Oct 2025 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593105;
	bh=EMFYNTxqqtbeWG7w/xTxHN65hWaPaOm53UuixA0S/bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFzBCiD2TaGdMk3IXuYjzLamws536+Bz7hp5DNvEo0KE381bf4hAOkl5BzMilVSs9
	 TbmuMCnTuI1Nu8la8KjABQ7QF3fXE6UfG6JWQju64rvNpMTH3zfqgWqB7cgKS2Uybt
	 ZCdMY4B7jNzlxocCvEv+YByAgfXaOQEKh/c1LAL9cJAVClnvQGSgmyIPFxWSbYqtGQ
	 8VNGtmcBXuUUK/h6u/rRyaqejErpjwuU8bUFXKABeof3vMkEe2PgpgbdQmsIhRW920
	 omf1N+UlcXgua/pw0KZ+3N4DwiviNcgyPXFDHx/hvI8+457eASfDU4bXE9lukwcSwx
	 p5wKjifUBK6/A==
Date: Mon, 27 Oct 2025 14:25:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: linux-pm@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Balsam CHIHI <bchihi@baylibre.com>, devicetree@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 2/5] dt-bindings: thermal: mediatek: Add LVTS thermal
 controller definition for MT7987
Message-ID: <176159310054.1448869.17678673857769151951.robh@kernel.org>
References: <20251026122143.71100-1-linux@fw-web.de>
 <20251026122143.71100-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026122143.71100-3-linux@fw-web.de>


On Sun, 26 Oct 2025 13:21:31 +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add thermal controller definition for MT7987.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../devicetree/bindings/thermal/mediatek,lvts-thermal.yaml     | 1 +
>  include/dt-bindings/thermal/mediatek,lvts-thermal.h            | 3 +++
>  2 files changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


