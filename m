Return-Path: <linux-pm+bounces-40231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA7CF5B92
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 22:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D30303F0DE
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E464311968;
	Mon,  5 Jan 2026 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvEM7Wkt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4041E2D7DF2;
	Mon,  5 Jan 2026 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650048; cv=none; b=G2Fp06WGA5RZEkhN0wDv2mQVUZkBmstcgbOgpqSYIPhLtrn49yHS0RKbgrdROQEvyrMZ6iBXZEsIUxfolvaOASnlFhbGytxDHolPr9BJGME+8sVyZvhJDKT7hVCh+pM0Iz/4u3kSta2Z/IUtuhy1NwOgfBKJ4OIKsZkxfXmruyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650048; c=relaxed/simple;
	bh=fSxEszskjXa2WPvc/WwjGdvfjh4SXaVRFL2NhtYH4v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX9gj1oTdfrIbjACN8u9o/w+nYno1jx86VlZF43BvQBtjgjc6t9QHn+02b7Kj6COnOV5Ub2rvErYy/2fx7iVVE4DCceqSvUl3DTVYKeRxaRBJbwiOKo2UsKulcVzaL5IxPm658Zq3rSdPO8Afyxd4Dzd7zUbPGothSoyNgkKQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvEM7Wkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9576EC116D0;
	Mon,  5 Jan 2026 21:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767650047;
	bh=fSxEszskjXa2WPvc/WwjGdvfjh4SXaVRFL2NhtYH4v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvEM7WktIBZJGSadijdbFHGXIzgH+V0H+HzMPUxzl9BWuaokVuNXvIfQ5CKizK+tc
	 /0hnpUn9AjzMiIlO/Z2s6mS0FAepa2lrqpZwchwfk6MhtHTu9hsBL52geT515tjMRO
	 KklPU1dZZ4x45cd0lKMmnd1BFdbTqEWxpT1pb2c5BTncC+tmVsm2ZUFccBOSscERFp
	 XRSFsiMW69r/ekGSUimhrLJ2hiSUGvdFA1K8wqShT43EGQnGdnM0purqGoqB957ODw
	 d4EIVVwxVTqEZbks2C63zMx8pksjOnZfu/89Ccj20XOzUv24xya7mUeEM4Mrz0yNeP
	 cQ57Y3VU5Cf7A==
Date: Mon, 5 Jan 2026 15:54:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: reset: syscon-reboot: Allow both 'reg' and
 'offset'
Message-ID: <176765004615.3490206.10897252686864993866.robh@kernel.org>
References: <20251215212648.3320333-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215212648.3320333-1-robh@kernel.org>


On Mon, 15 Dec 2025 15:26:47 -0600, Rob Herring (Arm) wrote:
> For compatibility, it is necessary to support both 'reg' and 'offset' at
> the same time.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


