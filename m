Return-Path: <linux-pm+bounces-40125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5156ACEE7EC
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 13:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188FE301F5E7
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9364630EF87;
	Fri,  2 Jan 2026 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGxSmZ+z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A92D780A;
	Fri,  2 Jan 2026 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356378; cv=none; b=nd8x6j7YMEGRueWhElAB+wsK/aWPNojZyN4VFSubT1FpBGghur+zH7d0jBJRmNhbx3VdAaqhYeJRdZMCMCbIxFP4skuRASMfin6il/YdKeRwkcSpqA128Ocj3XeCW/TUyhOox9FD2YX/2HIAie8uw650ZoOJU6LhsrepxfaEblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356378; c=relaxed/simple;
	bh=DuFbu53uVycRjhiI2jx7UQcyXapBe7nmlDM/y0cpp9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/em7J2VQdnp09MCOMBftiiymjvVOWt/6vu9Fe1WQD2fGiWzs/BvYCpVSC0FgxdWms+3liDIuRRDPFgXYgx832eRwtwVvj793Zzr1azk3Z1L0/2mXsfmtXPm26NDzGUGyycQB88Le/Ba2C65qwimhOyXwmc3PNmhibQFaRD3Lx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGxSmZ+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710E7C116B1;
	Fri,  2 Jan 2026 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767356378;
	bh=DuFbu53uVycRjhiI2jx7UQcyXapBe7nmlDM/y0cpp9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGxSmZ+zUXvRf71q7PeKNWNYQMFapQD1q5ly/GaqG1Ww3UgggOp5QZ2vnnqjq3my2
	 uhAe9Xz/8ZxHIM5g7Or/HwCvHhlyuupVmjFSyCPnKr5iz0zb23KYZTGNyngldBd/HC
	 CV6wDRsaHyIOJDAFUc6rr6sSrs8JtsOJn7hw6m9lvWmRXMuBmX516j1X8Jkmte17L2
	 7xJFOYUpqA0X658Jj7Thp2/eSG9mdwbNF71soJd2Hh/CQ8WgMeZBr9iyAAJ1+mkniW
	 F0TMM3LX8DtAc9vrj0IErp08x7RXlZAcVHidNAXjvKWjtBeg93Ir7vJskU42/+wM5i
	 rREy+G966n/SQ==
Date: Fri, 2 Jan 2026 13:19:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: misc: google,android-pipe: Convert to
 DT schema
Message-ID: <20260102-unselfish-nimble-gecko-722c94@quoll>
References: <20251230181031.3191565-1-visitorckw@gmail.com>
 <20251230181031.3191565-3-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230181031.3191565-3-visitorckw@gmail.com>

On Tue, Dec 30, 2025 at 06:10:27PM +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish QEMU Pipe binding to DT schema format.
> Move the file to the misc directory as it represents a miscellaneous
> communication device.
> Update the example node name to 'pipe' to comply with generic node
> naming standards and fix the mismatch between unit address and reg
> property in the original example.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  .../devicetree/bindings/goldfish/pipe.txt     | 17 ---------
>  .../bindings/misc/google,android-pipe.yaml    | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/goldfish/pipe.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/google,android-pipe.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


