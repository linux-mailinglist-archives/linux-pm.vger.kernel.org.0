Return-Path: <linux-pm+bounces-7874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA0F8C6992
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 17:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C3BB21A88
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D205155759;
	Wed, 15 May 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OCb7BGKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A815574D
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2024 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786574; cv=none; b=cyDL39BfpvSxr5kSc5c5ic1ui7M7u/Aw1eN/zdep454yw9ghuhpYx5qroB6pnco5ujPjdyDiirSxCdsgfBoaFTYPxWvv3etWPHaY5n+FcVrux23EQf0ajbKhfb6tMQ/TZz80tc/GAkXnXykQU1xrH5tgMGKXOE/88BoyH6bsfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786574; c=relaxed/simple;
	bh=LZdlNOSTbe6hze4dhwfW5nwE8DrpSomA3jo7BRPo+rs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O5FESX0FTsTcBZOjDu+YdJprTk5KMKchO6pe2OCpVFDfd1E5wrW6yfPlocGJz1mgfcPRoIsIXnbGjnvhAMonQnuYVQjLUXs69HuQdc2ycJRKO6HQ0Lui9y4dup7TqCPAJk89r7P0v5r4tdRuhxXGaaIqcWk2aYZ/DmuCU96MHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OCb7BGKi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-792b8d31702so437954185a.3
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2024 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715786570; x=1716391370; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7fuG8q4vN8I17KIqwuUEjtG/Vg923yjRqjA4jq2rhI=;
        b=OCb7BGKizVU9isgcKz/8QB2lCIAkV9BxwtIaAfsIc8aGMuuSJFJi57oGk0CfAaeVmg
         g5xbyu6kbQM/mZqx8CplYUovQzxDZmJeas94S9V9Y7C00wBwg9zqJYfkvdyGCs8CNCtb
         21vW3LDAYBe8bAg65yN2matYcQHUueHR2IM6z0kh4SEIrDN0JQjd3AYFuxqx/RjmKmsF
         lSZR6Wn3icvQwdaxuwFkza4agHNQf9YJynQ0LxQ3I4sZ5lU4RoT4A8LwQ3vegD/Mmt7R
         RVygSroJS17avJZutb/dlg4SWUhfpcQizdhND3FVTmFAkTSMnbtMb5Em/l+nsyjFO7fU
         21BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786570; x=1716391370;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7fuG8q4vN8I17KIqwuUEjtG/Vg923yjRqjA4jq2rhI=;
        b=PjDhqlc+eIwLWTTpiXQQwJKgh+LuWygS2qQVhUv7Co7wJ3H3S0qeWP1SDTSoUYMwUS
         3dH8H26HpZjYuL/5u3XxhSe5e1OUumeBcRfOxZxzFkm4dtKe20bRgI6U5oLuB2mAfSkC
         btXtbd/PWHnnTGt+pbxNMwGi/q9TBrfSqShdDMITuHGJax+O72v6BqQ719LMbjXWeORf
         LL7t1wayRbd8Ji5PzF4Lnx4xtewxTtmV6e/C2bPzrb0yyh0y9KwM2T7/th2oJCIpjIHI
         NhlRQI+6lPW/EllW/yfKTJEbokciy1d59brUlNHtxl3Aj4ugOq25BdxUNQ0wJ4uSiKM/
         2wAA==
X-Forwarded-Encrypted: i=1; AJvYcCX7idXl1QpxNeygAH8z27mvxwZCGi4l1xZnNPgnsn1j3zq+pQzI+nDVhB7dIfbML6g1/rExzVEOyV+fKLOPBacfpnTO2fAHdfk=
X-Gm-Message-State: AOJu0Yx1WXYGHoCLqLVYrNVbBQFpFqXhvleGPUdUKtOAjhV3AzMGvqVv
	gsa7TIj7eCB0Eoj5hU2q/RpgtiIwWAWliWuSUv/nZYoGN8LsvjR5WRYYVGsE4mI=
X-Google-Smtp-Source: AGHT+IGw0aDYjqBIiQz2ro5yaFEoOd0FlTaGJoFh4u+ygsAdhEHrwkLXERLT8RI/xzS13PWtMHd3jw==
X-Received: by 2002:a05:620a:e14:b0:792:c413:f827 with SMTP id af79cd13be357-792c757412dmr1767831385a.11.1715786570417;
        Wed, 15 May 2024 08:22:50 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792e91acc94sm245912185a.26.2024.05.15.08.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:22:50 -0700 (PDT)
Date: Wed, 15 May 2024 11:22:49 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Remove filtered
 mode for mt8188
In-Reply-To: <20240515-mtk-thermal-mt8188-mode-fix-v1-1-e656b310b67f@baylibre.com>
Message-ID: <06np453s-183n-68qn-o33o-97q4163oro4s@onlyvoer.pbz>
References: <20240515-mtk-thermal-mt8188-mode-fix-v1-1-e656b310b67f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 May 2024, Julien Panis wrote:

> Filtered mode is not supported on mt8188 SoC and is the source of bad
> results. Move to immediate mode which provides good temperatures.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>


> ---
> Filtered mode was set by mistake and difficulties with the test setup
> prevented from catching this earlier. Use default mode (immediate mode)
> instead.
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 0bb3a495b56e..82c355c466cf 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1458,7 +1458,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
>  		},
>  		VALID_SENSOR_MAP(1, 1, 1, 1),
>  		.offset = 0x0,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>  	},
>  	{
>  		.lvts_sensor = {
> @@ -1469,7 +1468,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
>  		},
>  		VALID_SENSOR_MAP(1, 1, 0, 0),
>  		.offset = 0x100,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>  	}
>  };
>  
> @@ -1483,7 +1481,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
>  		},
>  		VALID_SENSOR_MAP(0, 1, 0, 0),
>  		.offset = 0x0,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>  	},
>  	{
>  		.lvts_sensor = {
> @@ -1496,7 +1493,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
>  		},
>  		VALID_SENSOR_MAP(1, 1, 1, 0),
>  		.offset = 0x100,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>  	},
>  	{
>  		.lvts_sensor = {
> @@ -1507,7 +1503,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
>  		},
>  		VALID_SENSOR_MAP(1, 1, 0, 0),
>  		.offset = 0x200,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>  	},
>  	{
>  		.lvts_sensor = {
> @@ -1518,7 +1513,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
>  		},
>  		VALID_SENSOR_MAP(1, 1, 0, 0),
>  		.offset = 0x300,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>  	}
>  };
>  
> 
> ---
> base-commit: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
> change-id: 20240515-mtk-thermal-mt8188-mode-fix-e583d9a31da1
> 
> Best regards,
> -- 
> Julien Panis <jpanis@baylibre.com>
> 
> 

