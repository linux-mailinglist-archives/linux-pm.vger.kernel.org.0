Return-Path: <linux-pm+bounces-37698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F761C44B25
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 02:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67E194E23AA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F91EFFB7;
	Mon, 10 Nov 2025 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQigHvft"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2C286A4;
	Mon, 10 Nov 2025 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736535; cv=none; b=cKX6reHtV/bXMNBhJY3mrU+0XFQ1kTkRyzt0ghL3P7jac+0r4c1pNH2y9AnC9ZAaElSMEH+zZQNm/5ty/N+opuvvPkHMUrd/Ai3/h1dlT2irqZAfuDdKgv6ha9nkSaXXt+pFzIl2Sl/7lmrupvbUus4PD5p14NtMwkqXRTbzDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736535; c=relaxed/simple;
	bh=oBcaZh1qoZimXINdBHzXXdRQi11+sXet/4lLUm29sII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4tFfT9gIfVRAbAQ7Ql2d9Bs+2D2oCDvCREajefGhas6+DcgzTV7qzqpbUd0V6Ceh5qIezjcRBzC70qmftUxXb9w4J8sAQK7fKbstaWjPxh86NdKzCLDCodxC3SdoQIO+GAZUStGy8Ny9cPHoFCFuCFiKNa3lf24LPuHvo0C9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQigHvft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE79C113D0;
	Mon, 10 Nov 2025 01:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762736535;
	bh=oBcaZh1qoZimXINdBHzXXdRQi11+sXet/4lLUm29sII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQigHvft0XyaOg3B8fTi/gzcVUI2jWQ+uITPAV6ScJMOeMSFMQXlDS9acnhOMSaXs
	 zGguu4ulo3EOlZMDW81H6dq5Sakz/SZXKKgq7c27fmMqmKMH6AJMuIZgmqbZm1ALsP
	 5jJpEP0gPnonmw27jXcjtW76KsrNhaPLIomTgvxejyUZIGLHzB9wR+UEg3qVpdDICG
	 pQlmUuBZnc2TenoYa7jCDWc4/YxWAneLs07oSNkqKpiJ+sdIOLEHVS/tYOlkOGUrpJ
	 ZashiyUeNuBxWah1Kx9RWMFkRg5Qclvjqlshobpm8r1FlDmynTX3NYeIUqCCA9DYFH
	 xjQP7i9cDCskQ==
Date: Sun, 9 Nov 2025 19:02:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Talel Shenhar <talel@amazon.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] dt-bindings: thermal: Convert amazon,al-thermal to DT
 schema
Message-ID: <176273652966.2479173.17037713949403770424.robh@kernel.org>
References: <20251013215820.783272-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013215820.783272-1-robh@kernel.org>


On Mon, 13 Oct 2025 16:58:18 -0500, Rob Herring (Arm) wrote:
> Convert amazon,al-thermal binding to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/thermal/amazon,al-thermal.txt    | 33 ------------
>  .../bindings/thermal/amazon,al-thermal.yaml   | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 51 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.yaml
> 

Applied, thanks!


