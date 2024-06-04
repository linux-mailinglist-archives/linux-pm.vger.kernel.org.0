Return-Path: <linux-pm+bounces-8581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9B8FB8B8
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60521C20B2D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC04147C90;
	Tue,  4 Jun 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FKYE8zvq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E8143C7B
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517978; cv=none; b=Kmg2KDLKu65mNX+n1622brdnuroYo63jZHuQxbi6zKMQ5huspp6oL2myya3dj1L9c7SnYAXBjmAknSrgYW9IgmGIA+w0t8oV44qT6EsBcZoL23MV42Apg0R1OBNISajST52CwNRcFHxN/ZNpUXu7NwdGNnEZVTfF6MUa8TnYLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517978; c=relaxed/simple;
	bh=UB5F7l+e1OXNoffNBrdmm83ZIeSjzCW3uwTD66TUo6U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SQv+wurSferwvoa24jVKiLCn6s65eY0VjZ2WjTsxtgUwFT4QFxIyE1KDyjBw2LJuAb3fIQO0VkTmqCuQ0MPl31FbaUcdSVnwPH0GCS0CqpTILeSv3Z5PzVxG2cxvoB7bdpnhheAo0cuYJIFuqhuwDGO+P58dSoR9yPe5rxC8pYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FKYE8zvq; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6aebdea932aso21065116d6.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717517974; x=1718122774; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CL5J75RKeSsjGaFERVr4h+iONwKJd6j+jNrY6jpR54Q=;
        b=FKYE8zvq7oc/vUcZbyKfCBsR/0nNTyocEnRSFLpHHg7iDVBTrmqtr91fBQ/kGARkYi
         EbWmPfsLcMfNAWKB6Y6hTSi0hbo3j8ku85kkiZCUAgOLJUPkYUHrOANniEVx5BtrSy4y
         XqmOjX5T0DK7AjQDeSBaGs4WQwusLYEofGewGWWKMQip4nMk/F+C65MB0ufBr/BtGLu9
         q/VRSYNcttxTaEQtMLGQ300fKj8HK6QUwb+qcN5qbgygwlZ5paQPlsymwZ+IGenZDOYu
         Fw4qdvuUjZug95qADbcgleWMkyEKdoGZE87JUmVbozSMEOb8WKG1MWgA0NL+RAwHb8Zl
         C7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517974; x=1718122774;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL5J75RKeSsjGaFERVr4h+iONwKJd6j+jNrY6jpR54Q=;
        b=ij/sagY5CEMNWQtn40TZ97SE9TmWBYqnzZqYwEWG8ESzLvq1t0WhH5XRlYSLV+yfQT
         5bScX1no4ksZnjq7ls+ngr3jhuJcphl4efsp9iXICb26QIRZmxW/yLwAFpKJZ3woT84D
         lN+uEOsR9SPzWf0fpvWi9a9s5PLW+qbLQpto3t4vUuIWfNnK71CFNnSMKX/1jfXj0xES
         qvhRRWGZAwh4m0u2+wyvMd188lL1I0I/dZuDDXP9cM/utgA/V18JVwCAXL0SPuXhkR73
         t4SNrTIuZPRIHXX5SYljjuejQf/8gnyv7vbP51+azRSFsUm1qJaMFA20QwbjiJpt/hHP
         hBig==
X-Forwarded-Encrypted: i=1; AJvYcCWGmnb5QaaQT0coCDbEMfWaelYM625kawTMyzUDa6muUCBxvwEpu/fExT8CVluzkV6xZUXhyNLFDhs73HClezmC94POEyW4dS4=
X-Gm-Message-State: AOJu0YyIfI+lyHqybQp5/eo31ibbwLpMFGPUm5cTGHfGyXnTaqMnrOzQ
	Ju/awEP3YCDzfAlpui4sAKLSNXjF18OrJhtZip4N180+ihPzOg9vMunFCBsa+18=
X-Google-Smtp-Source: AGHT+IFSAArPIaEjpMH4jgaXVYpVXpMimK68ul2RbeeR3lZN0wdr6tbhaKym2ezsrx+vrYGQeTnziQ==
X-Received: by 2002:a05:6214:3d05:b0:6ad:60d8:183c with SMTP id 6a1803df08f44-6aecd5a30b5mr139932906d6.20.1717517974480;
        Tue, 04 Jun 2024 09:19:34 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afb70d56eesm23119596d6.132.2024.06.04.09.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:19:34 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:19:32 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
In-Reply-To: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
Message-ID: <345r636r-487s-75qq-07o5-4n022ppro11p@onlyvoer.pbz>
References: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Jun 2024, Julien Panis wrote:

> This patch prevents from registering thermal entries and letting the
> driver misbehave if efuse data is invalid. A device is not properly
> calibrated if the golden temperature is zero.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
> Guard against invalid calibration data, following this discussion:
> https://lore.kernel.org/all/ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com/
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

