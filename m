Return-Path: <linux-pm+bounces-37699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B0C44B31
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 02:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DEC3B0862
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 01:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C1C1EFFB7;
	Mon, 10 Nov 2025 01:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBA4g3Vg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A5F1E1E0B;
	Mon, 10 Nov 2025 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736546; cv=none; b=Jxzbu1oz73ppEuiWzM+10pCMwXr+Z19itCUn3EUra4OXV5QDf+63wLh7UWoGJOJ7dDyovVvsiTMuO3Xf8lOLYrNiHjhGgO7kDmVskmX/XvHIKCBxYuP/W5sd/TBoxJXUAkYM4iWjqYvktCmFTM/Y0VGYNjoYyQCjCjhgBCpC5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736546; c=relaxed/simple;
	bh=UWXdQGFsDCWdLjEts7aTIy9j8ao3fDq6SDKmrsymL+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFvE0eW+PRzcN3BNczp5r1Hy729wJr4AcqfZjHN4wjiRS2q3NsiOG5T4nvnsaQRSWpfBX0ATU1Dsy59O+TP/G9KMDCQRV5mkiTSEMQTEgOqkMps2YTHdGSdx2lUMrdM2mtZpqLt5RK7hkmIh1eW33O35EKj1y9gdOxxxdw080Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBA4g3Vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246FAC19422;
	Mon, 10 Nov 2025 01:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762736545;
	bh=UWXdQGFsDCWdLjEts7aTIy9j8ao3fDq6SDKmrsymL+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBA4g3VgF5vtecaT07fI8QJTLiuYIAwVwId16SQRR/GRKle1hahVd4/G02qiaOWUx
	 /JuBnGbxtEz6Qp1EfLXCEcXpjIz6392QGUDqay0aoEZoTOEPbtrG7Lx8s+t2yvZKYL
	 ZAQUUbusdVgCKuBV1CGZFQWPlr6XO1RbYMa8ldbkptYnlDRpjVjyP0d3x4LI2KblYr
	 ucED4IL0l0/VYyOG/Cj1X4N/QOElbf+izUXx+nRF4o7LqNySNZ6dP4SKeg+CVj8SMZ
	 APZNcqbJEF8a0D1wsJLTJ9BtxoRU8+F8ZxWRgFpygDn6GjmBu8LTQ6gIVdntCYkLpL
	 WasyhCkCFf1vw==
Date: Sun, 9 Nov 2025 19:02:23 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Scott Branden <sbranden@broadcom.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: Convert brcm,sr-thermal to DT
 schema
Message-ID: <176273654266.2479574.4714970695246643767.robh@kernel.org>
References: <20251013215810.783006-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013215810.783006-1-robh@kernel.org>


On Mon, 13 Oct 2025 16:58:09 -0500, Rob Herring (Arm) wrote:
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
> 

Applied, thanks!


