Return-Path: <linux-pm+bounces-24464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30345A6DF9D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 17:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4A71889CE5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95056263C69;
	Mon, 24 Mar 2025 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG2yiK96"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE92638AF;
	Mon, 24 Mar 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833614; cv=none; b=ZbvOKzho6Eu5ewcxcvnu386k0F+Gv6Hy2kX16WTm+3Htu6CDPxL1eRvNqndTPdg27z877wItvhNR+N8yL7196FtMWLJdVsMW8YArYMFEYfcndt/Z0CM6IXuRrUsOYAKoIlRLsjLub7nv+R3sxTmmvuAMhCp2qwGJV3V/LseE25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833614; c=relaxed/simple;
	bh=0gLtJyAnqL44iedTPEdVxIW54/Vqkaj44jUE2b94qM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDKi0z9TxiiTYgcLct4mAXJBbbLfnJuscZLAtsakeFmSOIcDgTWOyCPC7UJW5ItX7IY45dRYIEu5jh2/y/8LSQZCxMmw2FRjLF4balWH/N3ALadqHx0LdWKfiIZUHZYv8ChTdyL0EothrTAce7hagVvlzrRgHAaHN34V554xF0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG2yiK96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948D9C4CEDD;
	Mon, 24 Mar 2025 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742833613;
	bh=0gLtJyAnqL44iedTPEdVxIW54/Vqkaj44jUE2b94qM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HG2yiK96x2RVX/x7ce9nXCLRnUyrT97Bng8dQUkHiUkrFlULpGWpBEYIbZbB88L4U
	 nD3VEJoI4v6Kd49kW1/Wp4CuOnpNoGLTuIeMeL+B1Ug9r5kuu52nfBW19qArj+GqEc
	 Qth87csM8FNjqJ3HKCl4J8RONDBiFlkEdUC2vFASoiDJ4puXy9FfSNkbyP72SouKzQ
	 RfDWDMG1d1joDWO1PrfgSF+dRX+VCdW1tdR/bnxaLxHHSkAunpKIvIZWDLEln2DhpI
	 8+VyoPJuRHuV8OC52MvcMGiRO0NDeKZWUs0Uks/6Kp4VLDfapIEte/5GyfhncN05Y9
	 YdntNb9nxflcw==
Date: Mon, 24 Mar 2025 11:26:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-tegra@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/5] dt-bindings: thermal: Document Tegra114 SOCTHERM
 Thermal Management System
Message-ID: <174283361193.266110.10374521310809657861.robh@kernel.org>
References: <20250321145326.113211-1-clamor95@gmail.com>
 <20250321145326.113211-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321145326.113211-3-clamor95@gmail.com>


On Fri, 21 Mar 2025 16:53:23 +0200, Svyatoslav Ryhel wrote:
> Document SOCTHERM Thermal Management System found in the Tegra 4 SoC.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml   | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


