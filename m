Return-Path: <linux-pm+bounces-14856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C998816D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 11:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89C31C21EA2
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903EA1B982B;
	Fri, 27 Sep 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MetjOqmo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499A16B75C;
	Fri, 27 Sep 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429723; cv=none; b=nuuP213pzuPbGVMKnMmIPTKneYjrnEWXX3nIKu8zN0n+Q2uxKkhiVbotX5QszWKjbo4NR4Q4UZbVJplMWuo2FlGoCGAEK6slWkx2qK968vAd8FhYxl5s0Mz2xj7+crPu2eIy7/hBHzoxpsZ9XZaQ0jQkPacL1hbeYSr/bSoXy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429723; c=relaxed/simple;
	bh=xeGRmkPdIZIBxgJNn8xEkplsHyNoNurO6cJ68KdCFcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc2bOkT23JK+aPFq9I/wakauWuuJ+MF02yw5YXUBsNB57EfxWoFvrAIuTifY3EE7mf2yzWCPtf7mODnCJgWDOPGzyGHO1yb1mJz/TfUs7x9bb4d2Keorq6O6K2AmzzoXR1KoyYpHV4rc8ZS7JtmzX9kvswrFr+kZnkKrNH4Qa2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MetjOqmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41EFC4CEC9;
	Fri, 27 Sep 2024 09:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727429723;
	bh=xeGRmkPdIZIBxgJNn8xEkplsHyNoNurO6cJ68KdCFcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MetjOqmodU5FLBFaedlK53vKIZiuJqwnw/e+YESoWwUzggvoujMMBFD5TJuGGNhyc
	 ROAEm5NGEUf6dXSZldoi/Y3k2+YsK+m9NhWx18mnIxCwBp3To1YZKkYQ1FT5X//QQc
	 TS20pYoMDWmYHT6Go4m98H5zAT/m9gzhMrQKoJ1lohr4D0ZlBfnFWGgoFVE7Cj8D3n
	 biMClFLQ71PXBNR2C43n4IjXdjjzn7l+IuK8ZtajrhVTLJtRR4Z1VYPHTydJCewYiT
	 rxCNZffWq5KrRiWCY0lDWM/tCG+oUl2QuIhEVAGZ4XsmtUbZJObARU0za6VUg/Wpp0
	 b001s5A9FvorA==
Date: Fri, 27 Sep 2024 11:35:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: power/supply: qcom,pmi8998-charger: Drop
 incorrect "#interrupt-cells" from example
Message-ID: <tpjxumq75zjg6m2ucqat6vbzvtnku3msnqc6xpmizwtzdkwxwr@deqo4dbretch>
References: <20240926213727.3064977-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240926213727.3064977-1-robh@kernel.org>

On Thu, Sep 26, 2024 at 04:37:26PM -0500, Rob Herring (Arm) wrote:
> Enabling dtc interrupt_provider check reveals the example is missing
> the "interrupt-controller" property as it is a dependency of
> "#interrupt-cells". However, the PMIC parent node is not an interrupt
> controller at all, so the "#interrupt-cells" is erroneous.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>  - Drop "#interrupt-cells" rather than add "interrupt-controller"

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


