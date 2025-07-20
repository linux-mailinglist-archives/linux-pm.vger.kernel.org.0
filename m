Return-Path: <linux-pm+bounces-31124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9158CB0B891
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E7818892C9
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07582264A1;
	Sun, 20 Jul 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAmaYJ9M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9622425E;
	Sun, 20 Jul 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050301; cv=none; b=M4aRK2hwJih+ysijBJ7F/yB+m3gIBj+aDkB+wMn0Lg87Xj/hgDCMZLjb/6fQ9LQkd1e7oBD+vosm5Q6rq1Y9CC101/qkJMv3H4vRdjFhVGu9ccmUUetMESQXwkEKnBRQqkzOFcwcSHWLo4OttJjcC2fzu/lHK508z8MgTx7rM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050301; c=relaxed/simple;
	bh=5RcuFJB9Y5p7jCcuQ2vJJofG86pDVaTQDpH/U0Cu3c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZZI1QAK7gbaTBTejV26P0J/namqbwYv20jWi4k1JGnjvTDsFfkQTov/7ySTU8spm8db205GDi2YYVB2mIAyo+GQGruRojTxZ1hy3u/91BhFpfykBLd5LvDpLKCgh7HTY4RMZkPB+IKRnb8eSyPFwi+wHhPsBbB5zZWiqlEDxgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAmaYJ9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17751C4CEE7;
	Sun, 20 Jul 2025 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050301;
	bh=5RcuFJB9Y5p7jCcuQ2vJJofG86pDVaTQDpH/U0Cu3c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAmaYJ9MApQs3QCf3MCrPfihyfMAuSOfBnOzd0Be3RXIda5JG6EqjhcFe6+txUlow
	 Kk6Juwh3lTZJYLTW8Y4LiX5lOs9wVgljH7TuHnp4NKPTrhGOfkv2qndPxsw+6f2GRa
	 rn14wgrr0Njx20JYvz88Am4zH1/OwUR9DiLvQ7jvJq6x/DE5HAfuBqnOkaxxUPQdss
	 afrXFEmvsHPJxWSnBZppz3R5sMAXEx/yKiLR52LgiYYaXAD+m93LSohCioVUxEk8PQ
	 4E3FgYQYdadvNWaOGU7DFIJUugdZ66erMBhpx5gxY5m/WcreKIawJ+SKqmrj1aZk9s
	 4GTN477Ge/wlQ==
Date: Sun, 20 Jul 2025 17:25:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, linux-clk@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, Nagarjuna Kristam <nkristam@nvidia.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, JC Kuo <jckuo@nvidia.com>,
	linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 03/17] dt-bindings: usb: tegra-xusb: Document Tegra210B01
Message-ID: <175305029991.2880969.16366334174770530150.robh@kernel.org>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-3-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-3-e3f5f7de5dce@gmail.com>


On Mon, 14 Jul 2025 23:02:46 -0500, Aaron Kling wrote:
> Add the compatible string for Tegra210B01 XUSB
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


