Return-Path: <linux-pm+bounces-18318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85C99DFB32
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 08:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830321624BB
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 07:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935DD1F9428;
	Mon,  2 Dec 2024 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0nMoGKU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599EC1F9418;
	Mon,  2 Dec 2024 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124511; cv=none; b=ALULShKaSBAz6T/yCIw4EqIOYzc9YPvDdk38UbWBoKnZ+aNVT1+SzxXNItyDQ0ol3mBGrtQCoD2Sk6O/T+RrV7Q/dt62ZkNVfxC0cXoJlzPR1iWrlV6L2xdFddo3WMRF3VUHERuSbYaXDpi5FwnxsLIkocuuMpVmYgDGBFGs0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124511; c=relaxed/simple;
	bh=EnysZ7zRMcevxzZrPHotIoBrdN8hMuJ09Y6hOQq4L4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNDrFti6949xPkyYehrqbSo4iAuneA6knERQqnct0BqWAecpX5FXZDdlE2kG49NjT0BhDv5iZdmFQlU56jyXvAxUDILVc1i4H/2D0oMyUg6rnBLq8Gzp/M4XzlWP4lCQ2YkFgATlU6DnD25oV8/nc2dzgKs2dZrBKEIIpytoVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0nMoGKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2A1C4CED2;
	Mon,  2 Dec 2024 07:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733124510;
	bh=EnysZ7zRMcevxzZrPHotIoBrdN8hMuJ09Y6hOQq4L4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0nMoGKU3iABfhTQJ9N6WwtPQCq5oHM74ef2DjMiA7Ld40xp4j7l+/aqazXbSptZm
	 uj/ees7CWH9Cs8U8pwwWKEmKxqqR+5IfSuIjaVyQ9cp1G7NkS/+fTCFv4MOr1TvC3Z
	 9fGtVhVy3Ml6e+tH2uWduC95P17SOSBXGwBaOdmcOQLcBpFNmDANpu1SloACwbrzmn
	 SdK87fXXYvOEtrey8mTmuaHedmiVf9qGpW49qrgkUkG8Yp1Y3n9LR8Cdn4gYsLzI0p
	 8r4VOGJjQ0n7GF0X6Ifk3O26giSHPWLfiH8dIy6YGz/v67ddWqi3XX8FOJA/EPP6O9
	 7dbd8jxxC37ZA==
Date: Mon, 2 Dec 2024 08:28:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: krzk+dt@kernel.org, sre@kernel.org, 
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Message-ID: <saixxbiree3iy5rsftxee5r2lpvwgipg5d2u54artlqs3vmye4@r5n7ihczlm43>
References: <20241130094531.14885-1-bhavin.sharma@siliconsignals.io>
 <20241130094531.14885-2-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241130094531.14885-2-bhavin.sharma@siliconsignals.io>

On Sat, Nov 30, 2024 at 03:14:18PM +0530, Bhavin Sharma wrote:
> The STC3117 provides a simple fuel gauge via I2C.
> Add a DT schema to describe how to set it up in the device tree.
> 
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  .../bindings/power/supply/st,stc3117.yaml     | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


