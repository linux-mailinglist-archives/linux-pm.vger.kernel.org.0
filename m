Return-Path: <linux-pm+bounces-31971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C65B1B91F
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 19:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7412D7A27DB
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D180A292B5E;
	Tue,  5 Aug 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTk+blBX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755A1400C;
	Tue,  5 Aug 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414255; cv=none; b=pK3Ic8DHtuf1VpSg/jtk9yv6UhxC5W6VonjVdrtjVfOhhgDNqTuzdXlYEsKeTqPI6ezd4VzNRGd6qqLb/tdALvyXt2YAVaVSgzOTcdbf/fRwwiTKaJPOw3JgGYXSZbbuxAz4JVYxwkbikmUBMc2ZBUAgVwvBMvmFui8RPpME6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414255; c=relaxed/simple;
	bh=zPti4vHQ72c0KUJK1MFtmTjRrvlP5Fdb3fbdUSg7DhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqC5d0H/1YsTj6/wq4ssTDsxyYf5y645kryk2CHW8VjBA59x4QcDH/aiwrpfJmI1KdTdlm16i27cTaxnHEkusPmmMnLQDqEeKfdsMkFklVz/4U9CoiDdn4+Zs2WXs9v6nefnOuZU8JR1irAI+ZkcVEcrktZ6qFKdGOmWuFnlq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTk+blBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14502C4CEF0;
	Tue,  5 Aug 2025 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754414255;
	bh=zPti4vHQ72c0KUJK1MFtmTjRrvlP5Fdb3fbdUSg7DhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTk+blBXu+Mhx+4uUQU5Gv/TlCK62jDarbWpdTCEI11qqCUJ0shwy5gSGTG0ZkRGM
	 GVn/0CuULcFpf+yUCB3kJo4vTZX5Mq5mzPySaZX1y3kJ/gqaeK5dShUe8qNguzewsL
	 1DfEpC87mz1fV0lSkKZ2OqSsW9wlhz4XLX5VEFtFAM4yhXvc1106qV2F8X6dx2LeMt
	 yJLMMvuFSzcREDDcFjmTNdvUUtxzawpdlR1d1Pd0rrKKQIBZhoPyKOQDuO2KLbB4NN
	 owm5jYt31sZvANBU8Rz0aqtrZSM2NzBPGjgl/2SrcvnSn1Uuhk7mElcoDCyA8ajAZB
	 Qg8SgcertQPxQ==
Date: Tue, 5 Aug 2025 12:17:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: bchihi@baylibre.com, srini@kernel.org, rafael@kernel.org,
	linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
	arnd@arndb.de, colin.i.king@gmail.com, nfraprado@collabora.com,
	linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
	conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, frank-w@public-files.de, lukasz.luba@arm.com,
	rui.zhang@intel.com, kernel@collabora.com,
	daniel.lezcano@linaro.org, lala.lin@mediatek.com,
	andrew-ct.chen@mediatek.com
Subject: Re: [PATCH v3 9/9] dt-bindings: nvmem: mediatek: efuse: Add support
 for MT8196
Message-ID: <175441425377.1957748.9727174250578457285.robh@kernel.org>
References: <20250804133035.309990-1-laura.nao@collabora.com>
 <20250804133035.309990-10-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804133035.309990-10-laura.nao@collabora.com>


On Mon, 04 Aug 2025 15:30:35 +0200, Laura Nao wrote:
> The MT8196 eFuse layout is compatible with MT8186 and shares the same
> decoding scheme for the gpu-speedbin cell.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


