Return-Path: <linux-pm+bounces-39372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 071DACB14F5
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 23:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 958D530D7021
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 22:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B52ECD1D;
	Tue,  9 Dec 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrzM7SZI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854DE2DF13E;
	Tue,  9 Dec 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319907; cv=none; b=GdRN9ZTmdX2B1mr440tbX2IYPzpJYsGL2OSUTNSxd8h6QN3gUOYoiReACKMSn21VnGt8N7kzDkcFaZoZQHBwEzsD9ZkpmAijG5nCftryv7IWqYIhoaGpconjMu78tbeAbuA0YU59DQBGG7iktmNaU+WkekJR+ROrlVx6/whJT9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319907; c=relaxed/simple;
	bh=vD24s0bunHknwtVdHkYxMUpz5WPWdJEacfKCk1wqSw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isZ/UvwUKlwD5dYRe859kYJiqWW2HvCm0vF9CDu+LJpuq7ZqmFn16y9QqtIQMqVq+j7uzvAnYKX4HmqhXSWUPe3bVxFucXByuVADphqrT4mx2UMhEduMYiCE3+uVaxPxEgdZ83t/FJrObDgxvp3pcykc6dd/8/jD4QBs85Ao7U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrzM7SZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD9FC4CEF5;
	Tue,  9 Dec 2025 22:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765319907;
	bh=vD24s0bunHknwtVdHkYxMUpz5WPWdJEacfKCk1wqSw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrzM7SZIr3gCaB4y4ZKjrfBlRSJglrviC1fd65ko1+YVEmEyS7dvFINUjoGYkbP1O
	 afns0Lxb6wMihPIwwyCSRQTk3GnTp19WtYfB4NdHZyQcmFCCRAdqA66NEhJRvd7CET
	 e+6Pc2c7ts4ifvV4ooaYrtbxX0b2BUaQN7cIwQChNLCgT3o/mrg4nZkrmhba6wOvtl
	 kc9psazzIFHSOoJZMSG2y5laPKAiSTvC/DLnU68xFd+ULJQgRljr5d6eMWLJh/WihM
	 MqYsK3jEzleBWDqGY//JC1/dSKx6wsuQhMkH2R6IMYPkUWPJOpkq44B0mrqCXrZc74
	 Npjp3iaEFy2jw==
Date: Tue, 9 Dec 2025 16:38:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: devicetree@vger.kernel.org, lukasz.luba@arm.com, conor+dt@kernel.org,
	sboyd@kernel.org, linux-kernel@vger.kernel.org,
	magnus.damm@gmail.com, geert+renesas@glider.be,
	mturquette@baylibre.com, linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org, krzk+dt@kernel.org,
	john.madieu.xa@bp.renesas.com, rui.zhang@intel.com,
	rafael@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N
 TSU
Message-ID: <176531990213.1290341.12301174162121325549.robh@kernel.org>
References: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com>
 <20251209091115.8541-2-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209091115.8541-2-ovidiu.panait.rb@renesas.com>


On Tue, 09 Dec 2025 09:11:13 +0000, Ovidiu Panait wrote:
> The Renesas RZ/V2N SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time
> temperature measurements for thermal management, utilizing two dedicated
> channels for temperature sensing.
> 
> The Renesas RZ/V2N SoC is using the same TSU IP found on the RZ/G3E SoC,
> the only difference being that it has two channels instead of one.
> 
> Add new compatible string "renesas,r9a09g056-tsu" for RZ/V2N and use
> "renesas,r9a09g047-tsu" as a fallback compatible to indicate hardware
> compatibility with the RZ/G3E implementation.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---
>  .../devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


