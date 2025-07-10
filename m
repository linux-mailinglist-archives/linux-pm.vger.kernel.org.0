Return-Path: <linux-pm+bounces-30636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B960B00EBA
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CEF1CA7C27
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647E29A30A;
	Thu, 10 Jul 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIAuBUeI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60928C011;
	Thu, 10 Jul 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186636; cv=none; b=n50MPqpiHiJIIYXpkr4NYergpDaSIefvazKAm3MoTp2hNKzpnvZe5FS5/v4Ne5SmttrcFfQno80Mu369+9X2+pWz/ZNTuZRsh52DanEG0xISRv/APobu2FvFdab3JgCWa3L2v7R8FHwg8nGQ7t8ggd9vf016tU28vYloNg1mVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186636; c=relaxed/simple;
	bh=XwqwZqp7HuX7RcyuJ6RcS3EZOjo+k033TS6NfqYifjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYqt3b4z4Tese7LZjT3+zDAG525fSkB8xpVcpOcoiGKCh45EToKSpXMNIPU7SI0U6AlHiSPO22hd7lUe9jvvguseIbOW5R5Val+gi5rYjIgSBeqBO2AScu5A+pBFi2Ysac4mWYalMSVthu21nIDcXJhgifX38EK7CVoNKxzGaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIAuBUeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1B1C4CEE3;
	Thu, 10 Jul 2025 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752186635;
	bh=XwqwZqp7HuX7RcyuJ6RcS3EZOjo+k033TS6NfqYifjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIAuBUeI9kHse8pIF8gKTTgBrcwPa8tqm5mzxwbYiDTvgLLWdD5NlFqYEVmqzFRyP
	 dHbWbVnJfaHd0bRxy8lEj+WD/L+bs8W222PdgKISqaI8kY3H3LhHgyvjjEQ4TEokV9
	 l8p3FaOQYPuzSGj4Y445VRFrLHoUZMX3y/rwCPnkllrfM22ku9JfMR5VzHYO7KFHZD
	 OKD5xWTLw2ImE4jv1nG7x+FS0xLpHHQ6m3IRzyfKPO5zR+MyubayiHjO1/7i35E0ou
	 +Q52D4SrwrqD8L29YB1u6QtjZrREfLx8jeVSvcj1V9CZ1RrYG20rHD11pN+XRPljMH
	 vFCDCTlCAMGJA==
Date: Thu, 10 Jul 2025 17:30:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add A523 PPU and PCK600 power
 controllers
Message-ID: <175218663372.4188922.16230112848863911974.robh@kernel.org>
References: <20250709155343.3765227-1-wens@kernel.org>
 <20250709155343.3765227-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709155343.3765227-2-wens@kernel.org>


On Wed, 09 Jul 2025 23:53:40 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The A523 PPU is likely the same kind of hardware seen on previous SoCs.
> 
> The A523 PCK600, as the name suggests, is likely a customized version
> of ARM's PCK-600 power controller. Comparing the BSP driver against
> ARM's PPU datasheet shows that the basic registers line up, but
> Allwinner's hardware has some additional delay controls in the reserved
> register range. As such it is likely not fully compatible with the
> standard ARM version.
> 
> Document A523 PPU and PCK600 compatibles.
> 
> Also reorder the compatible string entries so they are grouped and
> ordered by family first, then by SoC model.
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> ---
> Changes since v1:
> - Re-order compatible string entries
> - Fix name of header file to match compatible string
> ---
>  .../bindings/power/allwinner,sun20i-d1-ppu.yaml   |  4 +++-
>  .../power/allwinner,sun55i-a523-pck-600.h         | 15 +++++++++++++++
>  .../dt-bindings/power/allwinner,sun55i-a523-ppu.h | 12 ++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


