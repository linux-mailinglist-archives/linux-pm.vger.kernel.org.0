Return-Path: <linux-pm+bounces-15806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0279A1507
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 23:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137041C22832
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846531D31B6;
	Wed, 16 Oct 2024 21:41:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D01D2F42;
	Wed, 16 Oct 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114919; cv=none; b=lVfO1DeAooyboy98HqM2DxYW1wACgAS3CXVUkg4ifSzHt1IBIymxVGBL0zGPpO+CW2t3oWHmMEwPuQuOHWsAZZnt+uBaUYAvr+EiS7tVxSs8Gf3wlIDIPB/3zAFOE1NFrXZcpzxEQ1bmh/gQGBIxDkCDxOGoRfkN1Ry8pINWGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114919; c=relaxed/simple;
	bh=4iRkuo/ixekJiaZID2LT6tM7WIVS0D7PrdnJUM1P39k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PR6RM1s7lLsfM3SjAsDPZ9GMhpRwC+pPhCydJvljQFkJor/Ycj+NIc482i417G6RFPPlFHqUzI0t+44djXa1SxTjSAMBLNFIsQ9mCLcKWM+zOV+F8hUcf8zsbl3TqLhWeDnPprLOXOxH9MaflHyy2+2WKoJmFDGZNQhjH48csL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC340C4CED0;
	Wed, 16 Oct 2024 21:41:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 5160C106045F; Wed, 16 Oct 2024 23:41:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240926213727.3064977-1-robh@kernel.org>
References: <20240926213727.3064977-1-robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: power/supply: qcom,pmi8998-charger:
 Drop incorrect "#interrupt-cells" from example
Message-Id: <172911491632.630785.3556397523712919564.b4-ty@collabora.com>
Date: Wed, 16 Oct 2024 23:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 26 Sep 2024 16:37:26 -0500, Rob Herring (Arm) wrote:
> Enabling dtc interrupt_provider check reveals the example is missing
> the "interrupt-controller" property as it is a dependency of
> "#interrupt-cells". However, the PMIC parent node is not an interrupt
> controller at all, so the "#interrupt-cells" is erroneous.
> 
> 

Applied, thanks!

[1/1] dt-bindings: power/supply: qcom,pmi8998-charger: Drop incorrect "#interrupt-cells" from example
      commit: 5d121065a6993e5ab4ccc0c9629241f256d11ad0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


