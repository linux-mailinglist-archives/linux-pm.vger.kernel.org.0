Return-Path: <linux-pm+bounces-30260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60122AFB0A9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F3C18953C7
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3476E28CF77;
	Mon,  7 Jul 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw7tljgQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC92877FA;
	Mon,  7 Jul 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751882686; cv=none; b=ejilbX9IEn+q13DJ3wB2Oi4jvRvo8J9d0QMKoP+WecU7emGLvi0NJllquwO2MAstgdD2AFcmwVG7l+n6FGm/UdnFoPDOYNW1r0OT+wSlGWLpgQN1qg/dafCEzRegPuR9/bUlnsyxSnDJlLGU9pCLSkt2Rc9p8ZZk8FHW14IsDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751882686; c=relaxed/simple;
	bh=vp9ywsjl/JEMhIHCA38Yt/LN7Gjc9ppK3dA+sfupOwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkhA/UW24ImMqZrHizUs3YUK0mil9uef/waRkyi4CQGqqZbsZNKuHc00wSZg9JeDkgjRKJXJLUUi5NMZ3Z7rDuT/RzStIcS9+/hwDdstr9QLr7SgdWVQRv5qjjKX6aITAdxd8lZi24g5E2SfYIVYSwwLnpWuxh2aXf3attBIoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw7tljgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CF4C4CEE3;
	Mon,  7 Jul 2025 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751882685;
	bh=vp9ywsjl/JEMhIHCA38Yt/LN7Gjc9ppK3dA+sfupOwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sw7tljgQc58h7W12oZUpa2NJlCaK0pqB/mcZn2e6jaCNWx9XRVmWr20jiY7wEA1Ej
	 3C0z3kyjV2UwlKF3GH+B/MVAwPMkZ2Z1VQrCU6z/hvJYr0TPfiIHB2B7pTjnDDrF9t
	 Ykrx4z8pnVs12iuUX1OZ0UZbbu8QytnOKiGZqD8tEVJWxvBZ4V5hohXPiFr1xwPyJV
	 pNdUHyjfFFJdgkr53PdHixoasY1ggFmJR4qM2sJciMSiI7Sn6jmvVIsNchoHaPs4zQ
	 ZEyj2VEBTdAcfSICtrYOhn5B7KJ9aOM/o/hMIypb5kpFmKr0bqzJjQViU6RB9W4VDt
	 kbJsuVYUiuUtA==
Message-ID: <e62e5fb9-17bb-4e1d-8c67-3eedcb895fbb@kernel.org>
Date: Mon, 7 Jul 2025 12:04:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: core: fix static checker warning
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20250707-fix-psy-static-checker-warning-v1-1-42d555c2b68a@collabora.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250707-fix-psy-static-checker-warning-v1-1-42d555c2b68a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7-Jul-25 01:26, Sebastian Reichel wrote:
> static checker complains, that the block already breaks if IS_ERR(np)
> and thus the extra !IS_ERR(np) check in the while condition is
> superfluous. Avoid the extra check by using while(true) instead. This
> should not change the runtime behavior at all and I expect the binary
> to be more or less the same for an optimizing compiler.
> 
> Fixes: f368f87b22da ("power: supply: core: convert to fwnnode")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pm/285c9c39-482c-480c-8b0b-07111e39fdfe@sabinyo.mountain/
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans


> ---
>  drivers/power/supply/power_supply_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index aedb20c1d2767309ae716712f8be8002b988f1b4..7c3913155dc0b7e51cdefe2974b09a9259ccb4b9 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -212,7 +212,7 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
>  			break;
>  		}
>  		fwnode_handle_put(np);
> -	} while (!IS_ERR(np));
> +	} while (true);
>  
>  	return 0;
>  }
> 
> ---
> base-commit: f9335bb4f5d4f3b913efd5872c2794d027dd85a6
> change-id: 20250707-fix-psy-static-checker-warning-f6aac00b24dd
> 
> Best regards,


