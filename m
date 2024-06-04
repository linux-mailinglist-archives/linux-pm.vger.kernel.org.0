Return-Path: <linux-pm+bounces-8590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8FD8FB9B9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 19:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB96B2031F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16D146A7A;
	Tue,  4 Jun 2024 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FA00H4yk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB284A11
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520414; cv=none; b=iNmJcFeji7Vpwjhho6KJwiEswIhlucR+deIkrGl3XFhOabss7QfHmHRTPUO3fx9lpZiLMEwvfTb1NGHeeD9H1UODF87M34FyXHMFq1IM2kFMCZgnrnJR+BCORuJgNGFxKB4s+jhQWR3fUVonaW8TIgWhS/cSspzAMz3qXCFrwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520414; c=relaxed/simple;
	bh=fF0TXTSu9ZdxYplCWZn8PgJSYBNCY54cocf6M2ubMLI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HkgYzY8GZh6d3ztqMPFAPsTrBA1Q46NBoNBfQEK5/hthRCFqg3IQo8WY072moXwQAGyd0aiJvT/xpTIjDo1ZDYcKEydVqtok8nqPZ8P1VTfSYH6o5rjb3/fFpFpl/UVlF23zFzjqDshlb0bV8N4uTcgN0MR+D+dpuNrNDLFMZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FA00H4yk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43ffbc0927fso22303321cf.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717520411; x=1718125211; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0FXev4Iglq7vn8M9/xJrlzCWzECxyOY6UHQcKBzcM8E=;
        b=FA00H4yk/h7q82N0C4w7B0Eoh2pttxFxTnQg/3vD25KwYA4gsPTs1SY9hfdxz6br1I
         HChpAQWnho9/OBJtOW31ArDdPKvbWOi+1B0fXSK334hHW0ZRU3Ab3sE1zUKUcQRfHDy+
         048BeVG3+9dQkXH9K3fkS1J39CDavAuv80BFF3sbnSXX7nqcUJAGinMks8hCGqbKICTG
         YDc88LRRHk3iVMdr/FMxMIIr6vrGKi/s0DyjTQpE0pCTKl+cyAKbHcghMSG6ICdFPpHf
         LoJH8Y/lfKBBz2hmUiiwLMckEGnvKdGOwomFXZ0UxwUxWGwAcsbHjf9A4RnZl8xwWfAN
         9BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717520411; x=1718125211;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FXev4Iglq7vn8M9/xJrlzCWzECxyOY6UHQcKBzcM8E=;
        b=rs85L8w0NhX1DhEONEokVwRFD2PsNlI4wjpRd6m6kdKRB0mx4epXPkZoMui/prUOA6
         jGE4wowwKJIfj7WLb6SNYcNdy6USoLuk6XA4p5NGaZqhF16uSrbd0l4+BXDJbke7uCaM
         B2/OD9WPmLppaf5GsqoRbcfa3N30u+3AoN3wKmoXZFnQXMwhER4sEka/V7W70R4xYDFb
         YlGA0aOdoXOxsFekV6BfwLfTp+k7mG+pzH54SaKn0fMr5uk+gtEN8eA7Ho4NW7sSCGuG
         C2Q5SM5CUaoDsf5xcEnB/yqPCPsIDJ2mVNLfTinZyCQit34T391Vulor5+tmI2rhkv0F
         LnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmliQaUWtm7ddKON0azBblsKP1YhU7AWE9njOKrrbGbMQBOKVBspAaHQtZ4Ua/WAns3tZgK8zPHacu+IOP8ubEvd93DLB/I+k=
X-Gm-Message-State: AOJu0YzSLINUjFbm0RswCVQKWk/GdoUl0SosOpOuxaT34Oj7Smh5jm7F
	fmB83OaJAtu+el64zl6aM/btMdk+LPegZLnPPg+oA/PHz1X+9A51hNxN4/YuVj8=
X-Google-Smtp-Source: AGHT+IEQ+mgjmHq05bdk7xACEVNcsSDNdul6POVLs6t8LHbGadcCJYvlJlevhDqW8d5ZOSNb/8F20Q==
X-Received: by 2002:a05:622a:20b:b0:43a:f89a:6631 with SMTP id d75a77b69052e-43ff5250db8mr133406231cf.8.1717520410432;
        Tue, 04 Jun 2024 10:00:10 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440204b5420sm7471591cf.17.2024.06.04.10.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 10:00:10 -0700 (PDT)
Date: Tue, 4 Jun 2024 13:00:08 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Return error
 in case of invalid efuse data
In-Reply-To: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
Message-ID: <25528q8o-73p2-25s2-5o2q-on72no5s91qr@onlyvoer.pbz>
References: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Jun 2024, Julien Panis wrote:

> This patch prevents from registering thermal entries and letting the
> driver misbehave if efuse data is invalid. A device is not properly
> calibrated if the golden temperature is zero.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
> Guard against invalid calibration data, following this discussion:
> https://lore.kernel.org/all/ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com/
> ---
> Changes in v2:
> - Add Fixes tag.
> - Link to v1: https://lore.kernel.org/r/20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 0bb3a495b56e..185d5a32711f 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -769,7 +769,11 @@ static int lvts_golden_temp_init(struct device *dev, u8 *calib,
>  	 */
>  	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
>  
> -	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
> +	/* A zero value for gt means that device has invalid efuse data */
> +	if (!gt)
> +		return -ENODATA;
> +
> +	if (gt < LVTS_GOLDEN_TEMP_MAX)
>  		golden_temp = gt;
>  
>  	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;
> 
> ---
> base-commit: 632483ea8004edfadd035de36e1ab2c7c4f53158
> change-id: 20240603-mtk-thermal-calib-check-ba2ec24a1c32
> 
> Best regards,
> -- 
> Julien Panis <jpanis@baylibre.com>
> 
> 

