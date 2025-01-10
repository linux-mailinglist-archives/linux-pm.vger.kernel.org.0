Return-Path: <linux-pm+bounces-20250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536BA0963A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBD0188D57C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC131211293;
	Fri, 10 Jan 2025 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur4ru0ae"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E432905;
	Fri, 10 Jan 2025 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523958; cv=none; b=QOXtHrbVyDFrFPyxrXIfKTLi7jJyeoYiJo6BbU+4/MC6QRWfL4I0iv874FncjX7bezrr8sfblGoaZzPS83XWtUwQv2abgh65EmapiSCvgviNvvSUFwUR9VjQBYSkwskjOv9sF2vlEc1nHktaUDgwP6XUI4gT5uBWfcUHNbruBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523958; c=relaxed/simple;
	bh=QfmaRoHcJUdGvJKJWhaJqO0KNHOHH67k1vAJT62x7hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMs54qHzY/ei8W80S4KEga2YxQxOTXxtSWJcAdeYan9BV1Czs4S6/wevYFGTDvlTysqBJlOuR1g0V6+e8TAVLHf49bN3qys8IXLS32kRviWsGOs/f+4qz5OQdy1r7qjft4bAHcVEEx1u9ywgzpM+oGSEddsPz08jGBK5ME/KxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur4ru0ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96B3C4CED6;
	Fri, 10 Jan 2025 15:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736523958;
	bh=QfmaRoHcJUdGvJKJWhaJqO0KNHOHH67k1vAJT62x7hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ur4ru0aeMO1UPqUMUz4EgMGX/ni3ypzALyQ2ZgQF6bsm1joJ7tjl+xM1mCybt7TQa
	 x/p4KLyKxKt+EZ4YodzOhkZv2Yk8vmhizyCAUOxmNltvpoJpTKBT9Ady5aVakQD2IU
	 YO7B+Fl6oGTYYBkUyynpGvvpFwQohewEONwavwSBuc/bCXqCyZj5futz+KFEFwoNSC
	 3OKikCx21msO8bgmWGN03E7tQ/0Bt5zNbSwHgpjYa+V3C4GBQ94rNzXHLzY8uD18xq
	 XhPK1NsZC/ZPiSgz7GUK3IzsLManGKV/VElWNhz2NZB531JkUp6GADNr4aPyZ6NkJH
	 gyDk9xvrQCzMA==
Date: Fri, 10 Jan 2025 09:45:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Vasily Khoruzhick <anarsoul@gmail.com>,
	linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-sunxi@lists.linux.dev, Lukasz Luba <lukasz.luba@arm.com>,
	imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: Correct indentation and style in
 DTS example
Message-ID: <173652395667.2926063.1624072219753897598.robh@kernel.org>
References: <20250107131027.246608-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107131027.246608-1-krzysztof.kozlowski@linaro.org>


On Tue, 07 Jan 2025 14:10:26 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 48 +++++++++----------
>  .../bindings/thermal/imx-thermal.yaml         | 36 +++++++-------
>  .../bindings/thermal/imx8mm-thermal.yaml      |  8 ++--
>  3 files changed, 46 insertions(+), 46 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


