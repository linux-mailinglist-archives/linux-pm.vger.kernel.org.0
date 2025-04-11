Return-Path: <linux-pm+bounces-25284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB3A864C0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258608A0D05
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C53221FD6;
	Fri, 11 Apr 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up/PWyhT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8A2367D0;
	Fri, 11 Apr 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392315; cv=none; b=UUB5g37A06d49mX/BZ8XXb4rSHLTCIxXpnjH9d3baUIf46xvUBU4MmeuEjAQKhzOjQEnjsI8goW6mVGl9t4w4LCVKq+1jVfInvWmf9BtvLmy9lkFAbMlXAkQlvy+PZKLizyli4yPMYTBbv8xIPJrC80iPtYmE4zk9l3Ukl2Oddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392315; c=relaxed/simple;
	bh=wKL6klck+zBAXPJH7vpcgxZNxZBcOAkRLudiLM2Ns3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx5kZRv4a21VW4ymkUhgwmbK19SKcMyTBm0k+gRJT2hLwZQXuhexA4+1H6rm+GYUMAKtrWITe/LVR2j16oDjBqI7wDPpvh4x8VEm71qX2CRBP4jZ9ANC8mKRieZYc9eu0/uDqsZE/IvMd7RMYwUmztEaOgUlZNhzjk/Vjg3v6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up/PWyhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B2DC4CEE7;
	Fri, 11 Apr 2025 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744392314;
	bh=wKL6klck+zBAXPJH7vpcgxZNxZBcOAkRLudiLM2Ns3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=up/PWyhT0eLoiCHQaOrBL9cHonTnfSQPtDomBOSEM813K7ZiLq985bQklbdSym773
	 O33EAI4T2+Njvk+qfa0JE0ZeejoEy/Cj3TNZBSC93t72tKBK2oJlx3vOOBicD+54QZ
	 HL+PXJj9CO5w9qIBL1UZ9eooKlKRBkM8b8H08rCP2hOeB+EBdHusZ1mY5i2LYIQKHu
	 QxcbmgnCsbkTILHGHUBtrIdZTvXdVR1Nn8ukV5CaFUIzNAWMTC9rgxnULBvDwgfd66
	 HhSrBtfoe+HiEa4iLQrQYRJ8gjwbhbwEM1m9YNGcBVGRM8Fd5dmKFev/Chf+Or0bYy
	 9B3MK0o/cyIgA==
Date: Fri, 11 Apr 2025 12:25:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lihongbo22@huawei.com, mbrugger@suse.com, linux-kernel@vger.kernel.org,
	y.oudjana@protonmail.com, devicetree@vger.kernel.org,
	fshao@chromium.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, mandyjh.liu@mediatek.com,
	ulf.hansson@linaro.org, kernel@collabora.com, krzk+dt@kernel.org,
	linux-pm@vger.kernel.org, matthias.bgg@gmail.com,
	wenst@chromium.org
Subject: Re: [PATCH v1 1/3] dt-bindings: power: mediatek: Support Dimensity
 1200 MT6893 MTCMOS
Message-ID: <174439231282.3566165.14821715325780672996.robh@kernel.org>
References: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
 <20250410143944.475773-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410143944.475773-2-angelogioacchino.delregno@collabora.com>


On Thu, 10 Apr 2025 16:39:42 +0200, AngeloGioacchino Del Regno wrote:
> Add support for the Power Domains (MTCMOS) integrated into the
> MediaTek Dimensity 1200 (MT6893) SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../power/mediatek,power-controller.yaml      |  2 ++
>  .../dt-bindings/power/mediatek,mt6893-power.h | 35 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 include/dt-bindings/power/mediatek,mt6893-power.h
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


