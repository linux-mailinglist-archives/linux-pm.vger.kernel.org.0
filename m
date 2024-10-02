Return-Path: <linux-pm+bounces-15068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B198D8F7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 16:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AFB1C20B3F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF01D27AB;
	Wed,  2 Oct 2024 14:02:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF401D0DD9;
	Wed,  2 Oct 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877730; cv=none; b=gNl9uLMbElpQ1ERMMpNNjiRIfTBCkofG8OtKjEZX/ZBZr86yNwAC12lLDI4+h7e/rw1bYBna3g9VEwvWgy2tTW1vQevT9KvYUUVRiit+dcqUI8sHTCj4pw2QMQmwjFoVPI5btljMsVYIUZ+vds2WjAGzLPro7e/vGwa6+rwU/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877730; c=relaxed/simple;
	bh=VOJQuCqdUBhRksuB8YpG1sADNdGbpcrZPuEXdhuf4HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkr4DqQXyHAj8wZha+BCaDCRgrKkrNKuYDqvE9rYT3f8hHrccN7Fqz3u77pksnc1GzwgfiwpZBP3eX0J3oRU1/pln3+LFxsHhwx4iFG17/35z0gjjckWpzYu3KeBiiWOHA1q1C5v6BGa3BvCXfvT/Do84dkEhclpWCgvWAPJMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89A51339;
	Wed,  2 Oct 2024 07:02:37 -0700 (PDT)
Received: from [10.57.75.246] (unknown [10.57.75.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 997F33F58B;
	Wed,  2 Oct 2024 07:02:05 -0700 (PDT)
Message-ID: <2ac9bab0-2a00-44c8-bf43-2469b6d60b92@arm.com>
Date: Wed, 2 Oct 2024 15:02:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] dt-bindings: power: rockchip: add regulator
 support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
 =?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?=
 <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai
 <wens@csie.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, kernel@collabora.com
References: <20240919091834.83572-1-sebastian.reichel@collabora.com>
 <20240919091834.83572-5-sebastian.reichel@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240919091834.83572-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-19 10:12 am, Sebastian Reichel wrote:
> Add optional support for a voltage supply required to enable a
> power domain. The binding follows the way it is handled by the
> Mediatek binding to keep things consistent.
> 
> This will initially be used by the RK3588 GPU power domain, which
> fails to be enabled when the GPU regulator is not enabled.

Note that this applies equally to RK3399 and quite possibly others too, 
it's just that so far it's always been bodged by making the relevant 
regulator always-on (e.g. [1]).

Cheers,
Robin.

[1] https://lore.kernel.org/all/20210619121446.7802-1-knaerzche@gmail.com/

> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   .../devicetree/bindings/power/rockchip,power-controller.yaml   | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> index 0d5e999a58f1..0b4c5b174812 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -131,6 +131,9 @@ $defs:
>             A number of phandles to clocks that need to be enabled
>             while power domain switches state.
>   
> +      domain-supply:
> +        description: domain regulator supply.
> +
>         pm_qos:
>           $ref: /schemas/types.yaml#/definitions/phandle-array
>           items:

