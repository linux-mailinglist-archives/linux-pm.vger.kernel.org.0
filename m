Return-Path: <linux-pm+bounces-30645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD1B00F03
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D905C44E7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C56292B3A;
	Thu, 10 Jul 2025 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP+sVKUD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A72397A4;
	Thu, 10 Jul 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187663; cv=none; b=k5Cc16xxN1NuWj8biSQmTS82W2enpwjZpHyNuUWkSGXewrStadgGADO5+q1EGrNGHY4Xolkf6P9MD0ZUbUH8KKShSwQRPuBG80vyB/EVl04IsfS9W9sqiHQXNXiWWCSt52rpXqPmKhVvv+L9tuaAe3DqIpSDLckZ8Y1/oyTMdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187663; c=relaxed/simple;
	bh=4o95IkNEz5qpXJwUn+JNDIWRtNDnZj8MA7Si8Zwy1S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC+1cvMJ5ethpFEAdmsMLP2seGWNTz9W3w2vGVEPX/8nsbKWsk4NX+Ur2iVrsZl/DVTfDExCGLiCLZW8IUNGMVnKcpJnwtt9+E4NtqyoePFawEG33iznAV4c2DlYtUBgxGWsV2IypoQUw5vAijHuwaYzp122wH7tKFSVkHNPjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP+sVKUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B54C4CEE3;
	Thu, 10 Jul 2025 22:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752187662;
	bh=4o95IkNEz5qpXJwUn+JNDIWRtNDnZj8MA7Si8Zwy1S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KP+sVKUDFDP9NafAD/jq4V4vwbBR9xx9KDdzk/xN015ABez2x6loPMO18npmrWcQJ
	 kfZBpXkdQ078YNC6gA/UabJEBdtDYAgsHAzHYjSUxy2/zjRGYyZ7xIVZxxHcN4j7U5
	 JVPAOAu/7uMLrPR2SFSPlPNBTbWgb8/ZTUrw62PROOVUMFpc3GK9oj16D47lbNQAJ7
	 JjsUmLGSqQgz2LhdN2IF6/FSjFt1AncRUXBvNZjzL45KHCwrf0WNf1RqfQUtO+L3a4
	 jA8x2i1SRVmSSNmjTi/SdJaS8+HJzJUu0Q4AdbMRuJXthu4J3Q7nMx+NLHXQ4qHZho
	 RWHPOFGlqqaiA==
Date: Thu, 10 Jul 2025 17:47:40 -0500
From: Rob Herring <robh@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Elliot Berman <elliotb317@gmail.com>,
	Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Andre Draszik <andre.draszik@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
	linux-rockchip@lists.infradead.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v10 02/10] dt-bindings: power: reset: Document
 reboot-mode cookie
Message-ID: <20250710224740.GA15385-robh@kernel.org>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-2-b2d3b882be85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-2-b2d3b882be85@oss.qualcomm.com>

On Thu, Jul 10, 2025 at 02:45:44PM +0530, Shivendra Pratap wrote:
> Update the reboot-mode binding to support an optional cookie
> value in mode-<cmd> properties. The cookie is used to supply
> additional data for reboot modes that accept two arguments.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/power/reset/reboot-mode.yaml         | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> index 3ddac06cec7277789b066d8426ea77d293298fac..a4d2fe1db51e0c1f34ebefddaad82b8cc0b1b34a 100644
> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> @@ -10,14 +10,15 @@ maintainers:
>    - Andy Yan <andy.yan@rock-chips.com>
>  
>  description: |
> -  This driver get reboot mode arguments and call the write
> -  interface to store the magic value in special register
> -  or ram. Then the bootloader can read it and take different
> -  action according to the argument stored.
> +  This driver gets reboot mode arguments and calls the write
> +  interface to store the magic and an optional cookie value
> +  in special register or ram. Then the bootloader can read it
> +  and take different action according to the argument stored.
>  
>    All mode properties are vendor specific, it is a indication to tell
>    the bootloader what to do when the system reboots, and should be named
> -  as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
> +  as mode-xxx = <magic cookie> (xxx is mode name, magic should be a
> +  non-zero value, cookie is optional).

I don't understand the distinction between magic and cookie... Isn't all 
just magic values and some platform needs more than 32-bits of it?

>  
>    For example, modes common Android platform are:
>      - normal: Normal reboot mode, system reboot with command "reboot".
> @@ -45,5 +46,6 @@ examples:
>        mode-recovery = <1>;
>        mode-bootloader = <2>;
>        mode-loader = <3>;
> +      mode-edl = <1 2>;
>      };
>  ...
> 
> -- 
> 2.34.1
> 

