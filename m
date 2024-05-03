Return-Path: <linux-pm+bounces-7485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFBD8BB03E
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 17:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D01B21F63
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99E152DFE;
	Fri,  3 May 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uJgIVgtN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98152E827
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751196; cv=none; b=fZ3AWmrfxMATj7fGtli/j1AAgDZ3IkpXrvE2jq6rCf6frkcy8DKoMVDzmIZHNGuCkzY6CNKfynrX1RxMRLvLo+3s1jGUQEbgx1OjkX3x1hMMZIRfdWuD7bB9GsKIanK2JinutL5ag8TScwpge103TYEFNCJEleIRvOWjrPN6xTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751196; c=relaxed/simple;
	bh=ZbkeRSrkCPNwDcLhX1qJ1sjDEzYFshDiprBjhPwS3Lw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CxgGnUFD2s9bKTSjzPXY/sQ8BjvDIg7PeFdgBx0jGfFIxc77lkb4XCj3KA5ws/56ni6MwJ+8nm4D/Jafo6H1GORzLycCA3xyR88QuT/wj0U770BvOZDQ1xpv6rPvkfeK1DBp2vnGeh7f6MRDT/YAI34/9jtWuCifIPqsnFL3jYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uJgIVgtN; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43ae9962c17so16848531cf.3
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2024 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714751193; x=1715355993; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DD3fGBfG9/zPLRqWphhAvLBiOO/6wCBUgxf5dozP1a8=;
        b=uJgIVgtNU1GTc3ydKfGZuINqMF6LvaqfNZb2a+xn/P3kFf7WZNGz5Cnbi/J88oC4h0
         FvHtdJf4zVGwYKfSmAlWDqOYAhpga7XliewbAddRvavO9+QqS8RmvSMgPgl5r1DxBFU+
         OVlJx72xcmJOvxWof6/UFHW0XJRALm9HZMB4aAraqjns2g+bFqDZoKWZxOVYmyRUJWLI
         +hvg2LhIdBA4WJfHqmQ2GT6QA6gGTqMP7f1gecV2lCymKRwsMKK31TVOFhEVbjWBUeQs
         Ep7qxttAZhqCDOHW1gL7bPoe4Eva7s+SkFs7I79wNz3rTADF913qB9PBCYsQupovy64c
         pAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714751193; x=1715355993;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD3fGBfG9/zPLRqWphhAvLBiOO/6wCBUgxf5dozP1a8=;
        b=DZJFnB3ZBGWKAEYUjHKEleUNmr6yiLa/dioAFBB9omlQjkh+xWqUwR0qLdsPpImi1b
         JlDxNy81iEPLPck5Cxag1+NmHDiNmkFHFBddxLGm77z9JHsvWq6bLo/4nAdIVr4JQ91y
         XXseV2GQ/oUdbe7zdYfUOv13Lr6Eg9CZj2cprn7Sk6mKBy5jLOMbMo33JfnAG3Lqfs8O
         WDA56f3Evq4dcR+Aay+FIT/iWsSNYP4w4nAe4fCXWMLMP/pVPHGR3LlNG23LJhtODyPJ
         /fI8OffbgdUqOAq4OjOjYAMDfO6lh4pxYYkEC/mEU+W2E+p9w3LTeqrGh3QssWV41YEk
         UQKA==
X-Forwarded-Encrypted: i=1; AJvYcCV9MPaX4DAfUUtJD9LcRpNn3Wm3nkB3p2zHPFFaqXtiUbmE9mZ4elxXUPRJsK0uMRIGRf0Oif+SnjTiGfsShtlHJOfLkBeAVgU=
X-Gm-Message-State: AOJu0YyA1wyvTKi1Mihezg0x7/I+NgceWwQ/U3IGZTaix2IWMgN3PLJX
	EppazdTxq1qdAeuY2/t3kR8S5BitpSKSGsbgEI1LZXAit2kfsE8PPL3sjqHc/iw=
X-Google-Smtp-Source: AGHT+IHvorLKVldcwPuXub3vxQ9aDpAAyxM3M6JDKLRxX/G+y4VOONQbkGOltiMGMq6o1FuWaPwO5Q==
X-Received: by 2002:ac8:7f01:0:b0:437:87f9:5ad2 with SMTP id f1-20020ac87f01000000b0043787f95ad2mr2820051qtk.45.1714751193620;
        Fri, 03 May 2024 08:46:33 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id dr12-20020a05622a528c00b0043c58b6d941sm1703704qtb.42.2024.05.03.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:46:33 -0700 (PDT)
Date: Fri, 3 May 2024 11:46:32 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] thermal/drivers/mediatek/lvts_thermal: Remove unused
 members from struct lvts_ctrl_data
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-1-f605c50ca117@baylibre.com>
Message-ID: <n7os6420-s4n1-1874-6qs4-409818807pnq@onlyvoer.pbz>
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com> <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-1-f605c50ca117@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 May 2024, Julien Panis wrote:

> In struct lvts_ctrl_data, num_lvts_sensor and cal_offset[] are not used.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>


> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 86b2f44355ac..18a796386cd0 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -105,8 +105,6 @@ struct lvts_sensor_data {
>  
>  struct lvts_ctrl_data {
>  	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
> -	int cal_offset[LVTS_SENSOR_MAX];
> -	int num_lvts_sensor;
>  	u8 valid_sensor_mask;
>  	int offset;
>  	int mode;
> 
> -- 
> 2.37.3
> 
> 

