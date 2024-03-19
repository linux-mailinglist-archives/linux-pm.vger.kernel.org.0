Return-Path: <linux-pm+bounces-5106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB45587FD0D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932402819D3
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220D7F47D;
	Tue, 19 Mar 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOFTWEOz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903E7F477;
	Tue, 19 Mar 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848423; cv=none; b=JVyMM6ewzvXCWz/2AUOMDjtlGkvyJsMa4Uz2IFl7xOFmI6fP1+i26pl0B4KIqKxzEpPlzzdFYhVB2xGKTaKVGeaRPPjqxRexacC918mncQkvwmeEU+mSSDq00LvUgwxudWL2fmaUx8eLPnrPHwQa7an+dzdDQpcbfdjLBz/TNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848423; c=relaxed/simple;
	bh=QCABlmmQRWtKI06jZoMFlB5Yrgasl+VafkEPPnZ6XrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xxh/+K4h/Jb2VhxOU5WgFhgEqPKYTj5IoNVPsVXwZcCARvIhy2J7SmA/m5zodUqMgSnB7dWxbg6YiQrr3WQ1K3+nEIA3LAItOWh3gz6y+8DlrCGikQX8XdlPly82UhRrm8J/4KnNUsGj05B61AsJYjK/UBUuC5LQa3OO7Mc+eiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOFTWEOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2287FC433C7;
	Tue, 19 Mar 2024 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710848423;
	bh=QCABlmmQRWtKI06jZoMFlB5Yrgasl+VafkEPPnZ6XrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kOFTWEOzUnCMkQtyxvj+LkfkJxx4r05vJHBoolV6B9rpwTeHHLgGu3ITGBHg2ZHLg
	 Q7t1PWIE0dTEo2CquMjRyfzt1ipnGVbgdk0M2BA6ZuW7+Jxhc0Wv4YsgZiqcn9vYVt
	 t+McN7YdZ7NFvsks+UDQSmZevVTdPVHUCuOzLdeb5ndUWRiJ6h9/HMBlGEVF6OiZ2e
	 p6E9TyUzYW2Tcne1nMQSeDtffk8QUseLaf3e/JSq95AHkiMFxiuNYdEco/VdXhOUxI
	 H6B8dd3D4gy9g6DiHI8E/eY++Wg58fWajyE7gWayOfPjSKipfsEwkSDADH8qzuvSsQ
	 wZ76FrDFs2BJw==
Message-ID: <7a529bd6-abac-42d0-980e-3b1b5c46946f@kernel.org>
Date: Tue, 19 Mar 2024 12:40:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] thermal/drivers/mediatek/lvts_thermal: retrieve
 all calibration bytes
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240318212428.3843952-1-nico@fluxnic.net>
 <20240318212428.3843952-2-nico@fluxnic.net>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
In-Reply-To: <20240318212428.3843952-2-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/03/24 22:22, Nicolas Pitre ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Calibration values are 24-bit wide. Those values so far appear to span
> only 16 bits but let's not push our luck.
> 

I wonder how much feedback you got on v1 - I didn't even look and will not lose
time with that - but regardless, if you don't add the right people to the Cc field,
I really don't think that you'll ever get your patches reviewed (and probably also
not accepted).

That -- especially if you don't even Cc all the relevant maintainers...!

Please read:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

P.S.:
scripts/get_maintainer.pl lvts-8186-8188-patches.patch

"Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL,commit_signer:21/22=95%)
Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
Lukasz Luba <lukasz.luba@arm.com> (reviewer:THERMAL)
Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE 
BINDINGS)
Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE 
AND FLATTENED DEVICE TREE BINDINGS)
Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE 
TREE BINDINGS)
Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC 
support,commit_signer:4/22=18%)
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 
(maintainer:ARM/Mediatek SoC support,commit_signer:13/22=59%)
Alexandre Mergnat <amergnat@baylibre.com> (commit_signer:11/22=50%)
"Nícolas F. R. A. Prado" <nfraprado@collabora.com> 
(commit_signer:10/22=45%,authored:7/22=32%,added_lines:128/453=28%,removed_lines:45/98=46%)
Balsam CHIHI <bchihi@baylibre.com> 
(authored:4/22=18%,added_lines:235/453=52%,removed_lines:22/98=22%,in file)
Chen-Yu Tsai <wenst@chromium.org> (authored:2/22=9%)
Minjie Du <duminjie@vivo.com> (authored:2/22=9%)
Frank Wunderlich <frank-w@public-files.de> 
(authored:2/22=9%,added_lines:72/453=16%,removed_lines:17/98=17%)
linux-pm@vger.kernel.org (open list:THERMAL)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
linux-kernel@vger.kernel.org (open list)
linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)


> Found while looking at the original Mediatek driver code.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 98d9c80bd4..8aa6a8675b 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -679,7 +679,7 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
>   
>   	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
>   		memcpy(&lvts_ctrl->calibration[i],
> -		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 2);
> +		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 3);
>   
>   	return 0;
>   }


