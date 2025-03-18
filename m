Return-Path: <linux-pm+bounces-24231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4232CA66DED
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 09:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3808F3A9A5C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7F31F09BA;
	Tue, 18 Mar 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k25f/u+I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC30C1E5214;
	Tue, 18 Mar 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285849; cv=none; b=S5Tb1dGPsV0FrheBHObxkmns+qCPca9D/n0W1KUhWbFHBXZJbER1COnxEbbTpeyGjEvLxVCX4s6O3T9p+P+948QWQXTEbPjnKc022NNKPM9qt4M1+agDu/9SY/p+KhgiTCPePAyZenVLCIeyNfl+9djwKTwIytgEZKLwNEu7L+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285849; c=relaxed/simple;
	bh=wBOvQFZrbm68qWCuw7BUmd87QhpRhopVQqKGSZWDtO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPJBG2Ti3xXH0HMsfPFtcdgYob6PpeSwPKrzugLpqA8Sn0ZNSPTnpVZyxZHPgn0kY1XnCGdL9Y6n9MLZWUsPR3mdKWABVUgdkEIbsMu6zEp2r/9ELbH2TnbKOti6WTPwHdvVHIPnl2Xb2saVzVD3p0IhAf9sxzOMvLURJZG+lUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k25f/u+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B95C4CEE9;
	Tue, 18 Mar 2025 08:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742285849;
	bh=wBOvQFZrbm68qWCuw7BUmd87QhpRhopVQqKGSZWDtO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k25f/u+IhotN8mdTn8dmoBT0izFdN95TjAUjrd1fsKJzVQLD1++9P0r/LKT31GcZr
	 ogIvIw4IEIpFP3iv31x+mwXlk+cF6AakTumUfKKwDi1zxSQGxI4miNGjSk8TGdp/Hf
	 Ppsocg5BJF8KdXbuhyyUBJPzueDSsWL8X+Xb0T0ZAAkfF2jr6yDfcP+hDFlovAaEN1
	 RDw+0FwL/SmkKWIKUCbdKZMyNl4g7RUAnAacpULH1v70P2S7HW4cLUL0Ir4OwS8ljC
	 XEar2jZO6YAebAcg+Ak+NpNyMz6LfpyZ5qRFZabq4iA2BMtjCS0KoEmJ/obw0mW5ZE
	 qkf4Jn27Z7GLw==
Date: Tue, 18 Mar 2025 09:17:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: geert+renesas@glider.be, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	magnus.damm@gmail.com, devicetree@vger.kernel.org, john.madieu@gmail.com, 
	rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	sboyd@kernel.org, biju.das.jz@bp.renesas.com, linux-pm@vger.kernel.org, 
	lukasz.luba@arm.com
Subject: Re: [PATCH v4 2/5] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Message-ID: <20250318-venomous-cerulean-bullfrog-bbea1e@krzk-bin>
References: <20250317143442.100590-1-john.madieu.xa@bp.renesas.com>
 <20250317143442.100590-3-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317143442.100590-3-john.madieu.xa@bp.renesas.com>

On Mon, Mar 17, 2025 at 03:34:29PM +0100, John Madieu wrote:
> The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time
> temperature measurements for thermal management, utilizing a single
> dedicated channel (channel 1) for temperature sensing.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


