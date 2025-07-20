Return-Path: <linux-pm+bounces-31128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627AB0B8A8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7EB3B0049
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80D226D1F;
	Sun, 20 Jul 2025 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+ExFZVS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADFF226CF9;
	Sun, 20 Jul 2025 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050437; cv=none; b=ICNISfpI2JTy3UyAoNfCwgAa0a26cO652mZ1lVSG2Fv1oNGmbeuqofhjS2Tw3L/Cz0QK4wPgvO3WKdtUftacEeFw3WKXkmmou72M6aRpJuU+Q7NxOTE+GOGp0gfJdz79VNFWsQBeLUKT/2O+lBu/Rf4D131M4NsXPok6bO5ptfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050437; c=relaxed/simple;
	bh=aBzL39ICb2FNSxlBfy6jZasMlzeZjneJ1X+Ot4J2fXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SST3+RavECyncUtSXqrISv/2flSbCoYG5Nnyssil7pmDYiJGue+gRh0fT84GPyxQE95GGLvozirU/dkm4lWSVhDAG178OMhsllwYm/8oZUffjtuu4xFZHICsR2PudO9s/3UEK8eCsFI2WomVGAxAR5HdN0aFdRl2ijmyHKS5p+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+ExFZVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF164C4CEE7;
	Sun, 20 Jul 2025 22:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050435;
	bh=aBzL39ICb2FNSxlBfy6jZasMlzeZjneJ1X+Ot4J2fXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+ExFZVSjV702qfvSkc2BwdGvr2yMPaUIUcA/gvj9W7UEoxkinOIOTq8jw/v7xB4j
	 pAskB/OxnQwCrMpSOYz/Eqsc73canPENkttZietRaBCn5QELQXGOeOvqKNPTw3RDMm
	 oYyzxTpeQ6FAsCZuLNupVAk+/VvfwvLaVlh8jIrYhDOH99fA1xVbjejXlKbaMW63OK
	 zUV2bR/ZEvdWqqWFFOpBi3PlP+Uh1vsX1yUktNmLPXLMq442cciNGNweDtJPgNThgB
	 yiQ/wgMBsAygQgSDUsVLO9g0/HhvMotZMd2rBMA1Izh4NN48OB5OgQp9NzrsTm6mbs
	 R8tJMKovM4/iQ==
Date: Sun, 20 Jul 2025 17:27:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-clk@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	JC Kuo <jckuo@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org, Prashant Gaikwad <pgaikwad@nvidia.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	linux-phy@lists.infradead.org,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 06/17] dt-bindings: clock: tegra: Document Tegra210B01
Message-ID: <175305043461.2890555.15106518834252394208.robh@kernel.org>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-6-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-6-e3f5f7de5dce@gmail.com>


On Mon, 14 Jul 2025 23:02:49 -0500, Aaron Kling wrote:
> * Add the compatible string for Tegra210B01 clock and reset
> * Add Tegra210B01 specific clock bindings
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml | 1 +
>  include/dt-bindings/clock/tegra210-car.h                        | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


