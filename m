Return-Path: <linux-pm+bounces-26303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12195A9E50E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 00:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848E51897C5E
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98A204C18;
	Sun, 27 Apr 2025 22:50:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ECA2010E6;
	Sun, 27 Apr 2025 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745794219; cv=none; b=RTRiwmQxENT1Ioho2EyrxR6+YGYJRYRtyCIzoLE9usPZeTe+2IDmsxvBGlsjhafDFWUPCU+JM7MBPbzx2naqezT9mcUMYrEdGtXTPH5MmFxait3PimBEVA9pJFjROsXeVgXt+7vMEnHIBa4GfpJO+8BImwKxkVg2BiS2Rcq4gA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745794219; c=relaxed/simple;
	bh=xjqAkUOb/EeiOEeAKJ9ZZ897oHHUSN9p4svCjPItI4g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IEkulyAgak5x2PPmAjQwClZxdmdf90fQqntO7c5vNT1165kYFBGH2bzmf2sqmwa7rdIZ56byFs+g9m72iRuPtNqCtP6/+jJq4CTWzU4wsbtppkS+w/01W0FlCegjZ8/w/Hgxlz+/wi+lEU2WIRlaMPckbnP2ASGhVH+TJWKTnYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02B5C4CEEC;
	Sun, 27 Apr 2025 22:50:18 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id C36C3180F9C; Mon, 28 Apr 2025 00:50:16 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Artur Rojek <contact@artur-rojek.eu>, 
 Mike Looijmans <mike.looijmans@topic.nl>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250318081428.33979-1-krzysztof.kozlowski@linaro.org>
References: <20250318081428.33979-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: power: supply: Correct indentation and
 style in DTS example
Message-Id: <174579421679.295785.3901100556922007748.b4-ty@collabora.com>
Date: Mon, 28 Apr 2025 00:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 18 Mar 2025 09:14:28 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |'. Correct mixtures of the style or any other
> indentations to use preferred 4-spaces.
> 
> No functional changes here, but saves some comments during reviews
> of new patches built on the existing code.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: power: supply: Correct indentation and style in DTS example
      commit: 1e3e2cf2df60521eee257b2c77a8f0d8594242ff

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


