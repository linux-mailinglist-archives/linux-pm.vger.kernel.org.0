Return-Path: <linux-pm+bounces-23314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA8A4C356
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8E9188A6D0
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A501212B14;
	Mon,  3 Mar 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXmZDD4Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117E78F39;
	Mon,  3 Mar 2025 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011969; cv=none; b=BLNX4FQCctH5GaTQgddfa3ShoFwIG36OBQbCKjhBGCi4jVuV8DboR/nit/xdHP+FCX8PIxfqwE/mdvRZFEiitYO4KXY5mv+O19BDVrhyBPvDhi3/iQKWWTHAWT7pvxhqySGCs1VktafROfomylisgoLTkoNsSQp+XJ/5FLwbb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011969; c=relaxed/simple;
	bh=0g9fQWh0Jv15zl9OPaLLQofjM1L8RSDKnVZdipTRZCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBYCyeHsnq5bmLXZDnP8TG3gHco3HuHOoA+liuYL00lvn2ISjzQjiqzd+4ZIJW8TBS0B32SuXQ/Q2WNN3CAWT7pWcs1OpR6LCUiaUAprlAWGkPYvaIw4oNOi1C/MJxYS3pzwkQsIfKgyQk+J1CYvLzL8kcYQ6Q7/FAj239YBpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXmZDD4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A38DC4CED6;
	Mon,  3 Mar 2025 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011969;
	bh=0g9fQWh0Jv15zl9OPaLLQofjM1L8RSDKnVZdipTRZCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXmZDD4Z9JhXaUrSlitgAjv2ProElafpbv8DEBeM8BFxzkXJaqr7hxgnvWCNxKnXg
	 FpnnEOFIsP87R/dqG0i/j4TOH95iuIhzu3WHBJk239wRqEbMNg2y9dxsV67+PaIbvo
	 01L4IIQpyjRChsYJbNunusnwgpusho9cFVWb77cLG4HN015/DME/JiNlr8wNWxKMU6
	 eVsiPkCMqat8MCAj9PO8x+sKvOtRCVFnfbtwLwHKCb4UDRnoVv5+OD1cj8r3zxSjnI
	 HE87mpYyQ3HaC2xmnZt2ZgCuAe/BijhRSQL8W6R4I2MnmVGrcJBP01yg+yEiJUM2Ca
	 iRG1yvmq7s1qw==
Date: Mon, 3 Mar 2025 08:26:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 4/6] dt-bindings: thermal: rockchip: document otp
 thermal trim
Message-ID: <174101196712.1786336.17880487519994518563.robh@kernel.org>
References: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
 <20250228-rk3576-tsadc-upstream-v3-4-4bfbb3b699b9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-rk3576-tsadc-upstream-v3-4-4bfbb3b699b9@collabora.com>


On Fri, 28 Feb 2025 21:06:54 +0100, Nicolas Frattaroli wrote:
> Several Rockchip SoCs, such as the RK3576, can store calibration trim
> data for thermal sensors in OTP cells. This capability should be
> documented.
> 
> Such a rockchip thermal sensor may reference cell handles that store
> both a chip-wide trim for all the sensors, as well as cell handles
> for each individual sensor channel pointing to that specific sensor's
> trim value.
> 
> Additionally, the thermal sensor may optionally reference cells which
> store the base in terms of degrees celsius and decicelsius that the trim
> is relative to.
> 
> Each SoC that implements this appears to have a slightly different
> combination of chip-wide trim, base, base fractional part and
> per-channel trim, so which ones do which is documented in the bindings.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/thermal/rockchip-thermal.yaml         | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


