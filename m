Return-Path: <linux-pm+bounces-22519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAA6A3CD33
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 00:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 776767A48A1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E71DE3AE;
	Wed, 19 Feb 2025 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWWeuj1z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78D1C0DED;
	Wed, 19 Feb 2025 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006916; cv=none; b=st7obgZPN0WjAcHIRP4ykFY3g4LbWgemXAt5EowvkNQ2Mw1drxGY79+TtClQPgqVSnqCGXv0I+ne9tAIWvKmGC9t5ygRPDeqLEOZbWYb5SqHn6GrHN6GEPCQcGlOpKtEkIzthWxf3+MXm+IucrNMzEso74R2mqa5MCWQU/O/cIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006916; c=relaxed/simple;
	bh=FvIWJPGMEfhh3+fEPRnaH4CeGSJ/t8a5mgLzeJj6/3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9PrmHCzCEHMSlmCwmg9X5w7fHmk0rj1yC5+lokwfh5JX4xBJcrGxVCE3gIMdDZaXBZ+ikUkwgq3/OJ6lLjF/omvwlUsBAaJVjcqGLHUffO7NLJUCjhbOgknM4kpFDTV/+cZSrF+qWP6z2PyRsOy/rRRVrsHcxiPy6bKtNpFOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWWeuj1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2E4C4CED1;
	Wed, 19 Feb 2025 23:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006914;
	bh=FvIWJPGMEfhh3+fEPRnaH4CeGSJ/t8a5mgLzeJj6/3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWWeuj1zn2Iuq6sH59qroWodU/O9ONCrcpKKM33LnZ/JF42dEB+jeGO8zqmdWGVAa
	 ybCyL8OS2UzrtVynrlTvybGpkjCiBlDvLUh0k/AkSGHlTDk/A/FklHsZppbaXTZTfW
	 sA/LOIY/jCOvSUXxFg8dId0YBMsqnnB72lv32JY9tfYRkAOTa2zFsjsEupQWGnOENw
	 Fk4YI2gZFzGrE+K2gJXLyImQW7uI5Ycg1GpPlAm59kTWsEsq2bCIJWxjmug2Z6wC3o
	 Vz7sR9WEHaBADgbqU50+skob+Mg++lwUsqxNsK6nRHvf2NP1stLUb+ONyAJrFO0Jjv
	 dbpD4oj0HKH5Q==
Date: Wed, 19 Feb 2025 17:15:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	git@amd.com, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: reset: xilinx: Make "interrupts"
 property optional
Message-ID: <174000691329.3154277.6728737996238490277.robh@kernel.org>
References: <20250217095226.12606-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217095226.12606-1-shubhrajyoti.datta@amd.com>


On Mon, 17 Feb 2025 15:22:26 +0530, Shubhrajyoti Datta wrote:
> The "interrupts" property in the ZynqMP power/reset binding was previously
> marked as required. However, there are multiple mechanisms for
> handling power/reset events, including:
> -Event management registration,
> -Mailbox (mboxes),
> -Interrupts (interrupts).
> 
> When event management support is available (default on Versal SoC), the
> "interrupts" property is not used hence not required.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
>  .../devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml       | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


