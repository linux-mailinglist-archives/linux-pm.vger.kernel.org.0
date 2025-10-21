Return-Path: <linux-pm+bounces-36540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD1BF4C35
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 08:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AACB4ECFDC
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9726E16C;
	Tue, 21 Oct 2025 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hof/auDC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466521CC4D;
	Tue, 21 Oct 2025 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029674; cv=none; b=m4u4sBSDmKuW4eRzytcvOhyzx/mwLiOBFZseZJzUzdicNBvVMOvTGsT4++Jl9nFkD04UbQSKeZEZ8gkxjlUf+1Du5nMeTevHLsknDh+NUPSHYxVIFqGdj5WY0GDYBVX/x84yGgSCEe7YDzf1JNvqSMMRFrAJU/TwKRt7qpB1M4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029674; c=relaxed/simple;
	bh=9WB4EVogPdGF0Akrmle9uP/wAUzch7W/R+uufjJAdRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj9/9Deat1XEWAltt3vpxglTclUPhZyASJUGuW34SRpUTT+eKcutTYQZILNOz3jeFN34ZniMg5kUbh/UH5KHVNonU4Tv4QzIK8FibMeSWCDf/KBsMIeaKrRvpSFu73ZwhK5+klz29Fk9nJJ6WwctiVaJL/f8ptUMdZWYuWqdGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hof/auDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108ACC4CEF1;
	Tue, 21 Oct 2025 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761029674;
	bh=9WB4EVogPdGF0Akrmle9uP/wAUzch7W/R+uufjJAdRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hof/auDCKl8/8cKpsSdADoojtDXT2jnghuG1iYHdnGBkve22m90p5LLo4IZFIod5X
	 8T3Hp4BWDBmeydKF9GFVFsRz1ofJ0QnqXzBhKcjJ85XSiqURlyTcxU12bhND69PPM8
	 HE1LQOSK1jjtsPns+yUAtNgF0wLehsFUorePPPrixi/FfzBibNvMd4BKP82AQ7pJUJ
	 7EIh0st62KlWPbVD2JDbwe58CiCq5yiR5l5FzfXgGxO0ssLdWpipZyeblt1GpZwfjh
	 YH2g/5jTUPCVWIMfKa4nYSjheXmaeS1MLM4FMolUl5CZvWk0/eNMcUeIdRPvmU1VFp
	 j7IHR1cp8VWkQ==
Date: Tue, 21 Oct 2025 08:54:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: Convert brcm,sr-thermal to DT
 schema
Message-ID: <20251021-arrogant-horned-auk-e1fab7@kuoka>
References: <20251013215810.783006-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013215810.783006-1-robh@kernel.org>

On Mon, Oct 13, 2025 at 04:58:09PM -0500, Rob Herring (Arm) wrote:
> Convert the brcm,sr-thermal binding to DT schema format. It's a
> straight-forward conversion. "polling-delay", "thermal-sensors", and
> "temperature" all apply to the thermal zones, not the sensor node.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/thermal/brcm,sr-thermal.txt      | 105 ---------------
>  .../bindings/thermal/brcm,sr-thermal.yaml     | 121 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 105 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


