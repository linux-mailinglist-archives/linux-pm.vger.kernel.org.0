Return-Path: <linux-pm+bounces-28172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67DAACFA2F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 01:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3352D18988D2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B227A927;
	Thu,  5 Jun 2025 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIKNNcuk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201003C465;
	Thu,  5 Jun 2025 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749167343; cv=none; b=C/QE63k4i0DX8rw9r/ly4MkCQ8wIYK3j+49kluK+2vqixwEsITCBuMsO5h4k6tjUusBgfUf1D6cHJ45ehKU7NFB8dpdGJQFnc9ahZBJNUX5WTjAgOxtwaVxqBttmkwemRPPDRJeyCPwbaW8uRYvU0A7TBfKgFErzhYjIeHUHZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749167343; c=relaxed/simple;
	bh=g2l0xw2YqveNWEewJqmbBDGNV3httJi1IBdHEF4xqNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKq2X8Mz3ezLBcov3Zw3TDthnMOehOa0yaoo65O58oqFCqzGe7hrFZg6u+48qwuBGujxgNecICCUexy0n+vs0bDPU4jNh1No7bh0uo2e+//5kYLhXrq+OPdKBaX56WsP9G3Ly+jT6oe1zobeYpHQq+j2v3QcF8HAugCF76RQj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIKNNcuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591DEC4CEE7;
	Thu,  5 Jun 2025 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749167342;
	bh=g2l0xw2YqveNWEewJqmbBDGNV3httJi1IBdHEF4xqNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIKNNcukSh03Z7tTG2B00Jbxsd9ShCS5ns2E1k/Q5BwUymKAeEZH+mSPgY3tXmluX
	 AHJq0j4RP0gZZdHRIcULT+Ajc0A7O7RVVfrxg8QcTjnAoH7nXht7KwVgdr+QC+voq9
	 mmD4zhiUWtnUiNfyqxLhPG/A7BBjP0SvtJPilvlwuJclyWqzSEXCbRki5UTWB1Tela
	 SgClrATKsUvE1vgTfUrERdWEj2YBLpEaHJrjFIrvoQTtJuD8DWt7+cvRgEtLU7znLh
	 BojgW4+O3py0R3wiG4CtIT935bFg752YtPArEg7qjVACgjhbe9tX+KBEa8VsfgjbH5
	 aDSUGiLvExMgQ==
Date: Thu, 5 Jun 2025 18:49:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org,
	Johnson Wang <johnson.wang@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] dt-bindings: interconnect: add mt7988-cci compatible
Message-ID: <174916733838.3486621.4521189465385649614.robh@kernel.org>
References: <20250531112425.10525-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531112425.10525-1-linux@fw-web.de>


On Sat, 31 May 2025 13:24:23 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible for Mediatek MT7988 SoC with mediatek,mt8183-cci fallback
> which is taken by driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - no RFC
> - drop "items" as sugested by conor
> ---
>  .../bindings/interconnect/mediatek,cci.yaml           | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


