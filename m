Return-Path: <linux-pm+bounces-33789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52307B43162
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 230914E53E7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 04:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F221B9CD;
	Thu,  4 Sep 2025 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7ws/55A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BB23A995
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 04:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961472; cv=none; b=e7jB7unGSX/jZ3IhLK1WT+uBp20STkjb+mbEqHUv5sgwsBr3/Oelj6Vv8rDoVlTKEXAq/mQ8Yd8kIDhieaGQRZcUnLFzZhkQcuks0sNnD/Jkt3NCxHUCX1cJEIuFe3IgCCmO3SSRIgWTz//gLuKg+r1a65NcRjGFlpnQ46zbAtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961472; c=relaxed/simple;
	bh=wjqjIiSphWPTyvtrvZeyKZpf4cqcuUdpwB5iI5kacjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtN063hY+BBltU8dyNe8ybm8u8BjdQW3L1M4vmhai3jfRu/Gt7cUZuxlUHOPmqZv05JyiWvmXm29AhoXzhtt8oTlBTAvDV30YjMUBb6o8X85iGX72/7NBIUB6Ofd/t8rCZTPs1JzqQiPAWs1pMSVyxEbuGEohf5Seo7J85Z3z/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7ws/55A; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4e84a61055so392295a12.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 21:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756961470; x=1757566270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Npc2kRdoiAQT8Oq6xsDbKE8d7v4q00xjFvwRzwJUB5g=;
        b=E7ws/55AMyZm0/qk4+73N7RZTJwmW4fJN0Yr9mPd5UJj1V7f6YXAI9yXbjxPq6w8HY
         sMa/W+Dfob+uXVySkztVN6VtsBtvnnwPC7gd+CwFz22NHQAycNteHWaMlACvbWPHsLRr
         MvhNaXG8OXPiUAjbql4LaANf6I/RuNaAYz+RI4GsAf6rpdH/F3l9WoeCDUINAzD0QsS8
         gqxOnm+ps0UYdGOoPXA29kwL7pt4Lq/qwGE3LZw42kM+ScuBVOUB5gnAZuqR28JeBOuP
         NzgeaxpD3BfWM1PYYPb8sTQopNxxRZaYl1qNKgobaSg3BfB9YCd09Iaqjzvi9jkZ20S2
         gqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961470; x=1757566270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npc2kRdoiAQT8Oq6xsDbKE8d7v4q00xjFvwRzwJUB5g=;
        b=aX8N6a7kOaQhiDSY397Is/kg/L6EAJUATAxfa69Kq9z44SSu0lZmig4h84aJVToGQM
         lmkVeA2v9u5mHKelObNAtjbYrYX9NA1/wGcwQljvmH8Bfnl80RRvo12v6D4j012oC2U7
         FNsiHsYX35OupfA5Ff+TeSmhSrjr4R0MUVzknJC4HqTNtsCGqOu6wL5xFq0l3NA2Mezi
         3lFYzBFhPLZrMgnd0PrFtz5NMjtIFccABWWpF3+Jg5YW0CWI0FgWDlzPPtpLqHIUQQzB
         T9B4dE2KVQALPiLn5q+h88mdSXbJQiHnQ4ro7otYpthzuGTr16sbtHRjDav2t6DOOanV
         YTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQFo0dDZsZUqNHnsPtPiKOenEYGhBSrTK3xP+V+E9D4ewpxQ6ardXbq8Vb4Ib8GOng4fG4xpIFeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLSORsA3HspIpOwO24RFNzwbFaiUP4WiRS1kX8ulBc8zb22pF
	LLESlsNl+nwY2tqYQy3VFjQdk7rkDaWK+yPF6daxyflW+Gpp0vtSzBd4gx+BzidZH28=
X-Gm-Gg: ASbGncuY5tb4O0yPfzke5efXYSTTOpsXGp7yv/IqoXaRoW5TYzMQk84qVzHTZogY6VC
	hWiW9rX2m4ggfcLzk5AXRX/dlrnEu0qZD4KLQc5lOr/k5gn2t4XyA0UcxFgsOsCmDNwtuLVaJAh
	+66PLerrzbBdUdAbyl3xHg9omQ6cBH90K1+PX/hUG8n7cA2NQX2sE78olyxBHhUVKSFSb9+WzAI
	SHbU8Lojv+uSINU+fkvH6caqxHa+cZBruJRwEljOQ366S4elAtfvFFbc/R6U0Yx1txwVmeDBL0r
	gMuS2gRgVcrQPLeX16StllkKqfLCWVTCD/zCfT2LJDQI9gkhFiyCB8eIf1zqU7JdcgDVOOQZRIu
	uLpUX9ai9rG3N8yTdgfbcdkPUJZKoXIpMK30=
X-Google-Smtp-Source: AGHT+IE8fhkKtW59L/QwQVMzIGYIlMT+Sa1j2ECntDz+uUUuSYYnswDb8stymALrifXH0JUgm5Q2WA==
X-Received: by 2002:a17:902:d501:b0:245:f1bb:9bf9 with SMTP id d9443c01a7336-24944870959mr275858785ad.12.1756961469626;
        Wed, 03 Sep 2025 21:51:09 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm177058085ad.109.2025.09.03.21.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:51:08 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:21:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] cpufreq: mediatek: avoid redundant conditions
Message-ID: <20250904045107.rweiwjv3glbehuwb@vireshk-i7>
References: <20250903121228.385766-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903121228.385766-1-liaoyuanhong@vivo.com>

On 03-09-25, 20:12, Liao Yuanhong wrote:
> While 'if (i <= 0) ... else if (i > 0) ...' is technically equivalent to
> 'if (i <= 0) ... else ...', the latter is vastly easier to read because
> it avoids writing out a condition that is unnecessary. Let's drop such
> unnecessary conditions.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index fae062a6431f..00de1166188a 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -123,7 +123,7 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>  						      soc_data->sram_max_volt);
>  				return ret;
>  			}
> -		} else if (pre_vproc > new_vproc) {
> +		} else {
>  			vproc = max(new_vproc,
>  				    pre_vsram - soc_data->max_volt_shift);
>  			ret = regulator_set_voltage(proc_reg, vproc,

Applied. Thanks.

-- 
viresh

