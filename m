Return-Path: <linux-pm+bounces-37591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC66C3EBC9
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 08:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8053AB221
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527CD3081B1;
	Fri,  7 Nov 2025 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihHs0DEL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140FB302745;
	Fri,  7 Nov 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500397; cv=none; b=NpfHmd+jqE1tUQ11vrm0EwVo7HIU2uBxT5S8UpjbTyhKSPKmUOLFS9ybs1XYMa4+GQRH0xDJiXAYFK52PK63eabzJMh6hZw5amEW9zkIh2lp0pqG9/uv8fEjEZgaLXP7oBjU3PakpXtLjRn1AIAd39YWoIrModrIX/t53/+wbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500397; c=relaxed/simple;
	bh=jIST4hjxq5HplSFzRwdaLH4nRDcRq+Ij0iiF33GFWmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1/g0kG6kFtKSHSCAhKZwLyKN4H/Da7aMLcF4Cih0qDs0v1HMFsC/Jo6niWdUpyzAKDAZdGR1I1UELJ7uJwjUTAbiNV0KIBU0/IdUbhxKRrjXe6Uh1D7DrZnNQb+E+3lST43vuqH+j3v1fmeqR1sMrcGcbgnh/4g9ec1qbOQpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihHs0DEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10497C113D0;
	Fri,  7 Nov 2025 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762500396;
	bh=jIST4hjxq5HplSFzRwdaLH4nRDcRq+Ij0iiF33GFWmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihHs0DELxwvTDxAejhC7XR/P/lOOp9kNziuIGKr0/hKdLMvVafh8sWYxq1aSBHsBM
	 Ir5qPxk9ttx7nJXnowB3Fm5V8OU1Q7kLtLBxAgcCTdu89igvTwN8N9thlolYnOoAsm
	 /Nb9fI7W0UGw6ZONWsmpwuGCZJFWuvMcrKnDfXTpaxyS8TkGVNZPc8ML6adS52xHnl
	 vJgCvw+RoUgKqQ6H9GWgvZcpjlNNFa1X76UB04ocACm4X3jdxgwDL4rDBbfMwhubzE
	 tFUqqen+YkPk7HMxNJdQErgBR4YckhJSxcBGeJr6fEz01PJOPxewe+t+GA9StzmMS3
	 tkSPhTv2RLDyw==
Date: Fri, 7 Nov 2025 08:26:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	"irving.ch.lin" <irving-ch.lin@mediatek.com>, linux-kernel@vger.kernel.org, sirius.wang@mediatek.com, 
	Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, netdev@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, jh.hsu@mediatek.com, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Qiqi Wang <qiqi.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, Michael Turquette <mturquette@baylibre.com>, 
	vince-wl.liu@mediatek.com, Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 02/21] dt-bindings: power: mediatek: Add MT8189 power
 domain definitions
Message-ID: <20251107-polar-satisfied-kestrel-8bd72b@kuoka>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
 <20251106124330.1145600-3-irving-ch.lin@mediatek.com>
 <176243607706.3652517.3944575874711134298.robh@kernel.org>
 <20251106-spearhead-cornmeal-1a03eead6e8a@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106-spearhead-cornmeal-1a03eead6e8a@spud>

On Thu, Nov 06, 2025 at 05:17:39PM +0000, Conor Dooley wrote:
> On Thu, Nov 06, 2025 at 07:34:37AM -0600, Rob Herring (Arm) wrote:
> > 
> > On Thu, 06 Nov 2025 20:41:47 +0800, irving.ch.lin wrote:
> > > From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> > > 
> > > Add device tree bindings for the power domains of MediaTek MT8189 SoC.
> > > 
> > > Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> > > ---
> > >  .../power/mediatek,power-controller.yaml      |  1 +
> > >  .../dt-bindings/power/mediatek,mt8189-power.h | 38 +++++++++++++++++++
> > >  2 files changed, 39 insertions(+)
> > >  create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> pw-bot: changes-requested

I think this was bot's false positive - that's a different file, not
changed here. The patch seems fine.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


