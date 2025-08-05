Return-Path: <linux-pm+bounces-31974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4408DB1B9A9
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 19:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E711E3A80C8
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C0D2957CD;
	Tue,  5 Aug 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDIK0c9m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EF2264B8;
	Tue,  5 Aug 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416576; cv=none; b=YtcHxqZf2mW7IiasHF0PTpfITojbupUPIFgVB6ID06GMTHakxChMD9yagAleVQ49g8Y729f4fV5zBqzV0s1/T4ojpNpa3yTCjxbpnySMw05lOD+dGspENWtPgk6bZ3yLr8QKOui1g84aoSoO5bTk8Nw4lhFBKpoBERfZFDm+oXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416576; c=relaxed/simple;
	bh=xoZA+uUKJ8g3le1aL8FGyrdIWdGhhNTmI8dVLAWUCOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5Y6YqLe5Dfpxms5/dgwezgOuNYrjOEsaQ2coDRKRia2KoZR+h8SggMrkGA6NHnErDlfrVQITqiKHyk4HK8e+HPWR3yftVBFtpMU+Fm4ERAdq6sEBmdtOXEVlfUgtM2LCRgUwvoJkp0UHXTDQ2zYQCYqlzlX9W1uP8GD9NNvvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDIK0c9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD950C4CEF0;
	Tue,  5 Aug 2025 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754416575;
	bh=xoZA+uUKJ8g3le1aL8FGyrdIWdGhhNTmI8dVLAWUCOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDIK0c9mv9LDR8SNvohHlyAKw9MYIIglVHWG/YpuE5escfKmrGg2Crfjd5kLYN1zl
	 woHNyxS2MJpmaPbLuo9GHFQ+4kbrR+e2DzHaYxE9nwEvYm3L7XxLX0XbeFvIFTQS6G
	 8HQWrzGRuF5hNcNyK5p60Jn5RB62l3qRRpyqx2q62fbW4pPXGuKND5FirUcOtm1vqw
	 hquOKXg+mjUhv2u5q1+bpO8JbP2vtXA1BbkCh+gRN3A832oQzhMnxmqMHM3kC2gRrE
	 xm8d+uQYNo0wZsh8JR5pO1dpV0l0CzHa8b4G6hHufnRPKv+3CW2mPARQ7tsCqFmWIn
	 EKMfnieV3CkcA==
Date: Tue, 5 Aug 2025 12:56:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: y.oudjana@protonmail.com, linux-pm@vger.kernel.org,
	mandyjh.liu@mediatek.com, linux-arm-kernel@lists.infradead.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	lihongbo22@huawei.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	ulf.hansson@linaro.org, mbrugger@suse.com, matthias.bgg@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, fshao@chromium.org, wenst@chromium.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 03/10] dt-bindings: power: mediatek: Document
 access-controllers property
Message-ID: <175441657381.2010253.3126745610510211797.robh@kernel.org>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
 <20250805074746.29457-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805074746.29457-4-angelogioacchino.delregno@collabora.com>


On Tue, 05 Aug 2025 09:47:39 +0200, AngeloGioacchino Del Regno wrote:
> Allow specifying access-controllers in the main power controller
> node and deprecate the old mediatek,infracfg, mediatek,infracfg-nao
> and mediatek,smi properties located in the children.
> 
> This is done in order to both simplify the power controller
> nodes and in preparation for adding support for new generation
> SoCs like MT8196/MT6991 and other variants, which will need
> to set protection on new busses.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../power/mediatek,power-controller.yaml      | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


