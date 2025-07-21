Return-Path: <linux-pm+bounces-31241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8AB0CB7C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 22:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6026E3AC376
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602723ABAE;
	Mon, 21 Jul 2025 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf03Mbgm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF62236FD;
	Mon, 21 Jul 2025 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128944; cv=none; b=TtJfmjsfs3BAtCQL+t0P2TcTRmQN4o9WkMvYisLGq/fIXlSI/Ko6JruhawVypKJ0EeD+FMuYzDAudKNicXgtheZAXrfIPNIBrjK1biTxVlEHv5qgDjMrfeUt8AHtJNl9RW2koa/Meg4nf2cMysvFyS0MkXZ1qxBdAZdqxcw/4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128944; c=relaxed/simple;
	bh=nkiA1xZGAUGjmHRJ4jMF5cNu7pJ2iZ4JK/ULWm22zkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4Abuj4D0zPsnCkotun39+dW5wYAVBbZnJzyyVRcKnMcy4eToWrjST1qPqnFvGv9+zNZFZLwOKDVsGtJ25xvFe6l6oX9G4lSt+yHW9FMkzxss20JrHvzChmtvYe1IGldfc28Zxr89KjsQnVYobzecOe+jS4Vaek4HoqLTXTDJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf03Mbgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C3BC4CEED;
	Mon, 21 Jul 2025 20:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753128943;
	bh=nkiA1xZGAUGjmHRJ4jMF5cNu7pJ2iZ4JK/ULWm22zkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hf03Mbgmg8UXAaiSvZVsYNOpxI1lRgk/w+kb96/iEtNZKUdI3zi8yMVwwXluqmn2d
	 l6oupsCI42Oj+s1HLGqgdr5P/1Gzt9zxAegC/2cKzvPeF7ZATTLqV2RfzjTmSvW5O8
	 FgJTzDtUo84QX/jzlaYmo2owrMl1pS41LWPUJA4VK4prBr+8JR3Mo4XlW+NsdW5LAM
	 gVoebTmOHJOode+RHExAM6EsQWKOWk3fj6B4KDbldu04+VpFUgdmLDdjFgtGbIm3Gz
	 eM1GX0hcpBiGYw1hqCd4aRU6wmZ9ElqjEdUINq2dlAhcYDjTE6/YZuYKqVyZg6TIE2
	 R7/Tfu/qzT1RQ==
Date: Mon, 21 Jul 2025 15:15:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: JC Kuo <jckuo@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Prashant Gaikwad <pgaikwad@nvidia.com>, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-clk@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
	devicetree@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org, linux-phy@lists.infradead.org,
	Thierry Reding <treding@nvidia.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 08/17] dt-bindings: tegra: Document Shield TV 2019
Message-ID: <175312894245.1247819.6745937548885403054.robh@kernel.org>
References: <20250720-t210b01-v2-0-9cb209f1edfc@gmail.com>
 <20250720-t210b01-v2-8-9cb209f1edfc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-t210b01-v2-8-9cb209f1edfc@gmail.com>


On Sun, 20 Jul 2025 21:15:02 -0500, Aaron Kling wrote:
> Add the device tree binding documentation for NVIDIA Shield TV 2019
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/tegra.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


