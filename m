Return-Path: <linux-pm+bounces-33675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DDDB41370
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 06:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDED93AD2AF
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 04:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A972D2494;
	Wed,  3 Sep 2025 04:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiKu1nye"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538421771B
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 04:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872813; cv=none; b=R06LL82Bzl+3fBbaLCf70We1uL+jX+1mN4IYHf+MEN+XXspUIK8UZuopU2ji9GUTGLfj6QlOL2QgY5AeNy3FLsaGAWU9kOwoVNGvjvlZDpbWKJgAbbvJGLjwqYEWZ/BiiZvC+ueOC9NRaw7a3dn9bQt3UCC3/iIhFQ+gpKm16tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872813; c=relaxed/simple;
	bh=S9vyE1+A5amQRaGkXPBUxr7nXJObiO+2MUaiaVpTblE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ9Jb1YGhCdi7WKaSRF1MJ81nlbq3l4SqTkG40oc4TpuwDLa3eVk/dadcejcnJ9nQeI5CsbpA079bDIxDAVGXnvqqnzc6N3kiEiGtB4ndzbyUPVRyFo4DpqLh7hlBi8yQ6eeyMJTDU7USGVcjBn/EVxmK5UHK1shgBLfRpuA/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiKu1nye; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4dc35711d9so3108943a12.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756872811; x=1757477611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmjwLG7Fq+yscSPUHiCSFMVINTU2Z5qiOL+YOu1V9RY=;
        b=MiKu1nyeIGJlmExOn/3T+VeJ+z10VI0Ml6iNUvkACcC/2YcBTBKc1js6YQTXwHMKR0
         IYyOSq9bxjC/Tp8vEn9ot6li4mwEumo6BWmmc6qY5Rgb2CEVXWruKp9inHoVS9MjirzZ
         X220br6Hf7lT9NDPx0C6AiiPgch4Um1PKbFGwiB/8bzjQTLAtgWst6kAT7Oxu9u5Ct4s
         MoZHhfEGNab055DGaRByzNAYuBtucLBqPetQLRUPlpPzkc9ADfmm41DrwInLmjZF2y4c
         fVh6FGxygo1dFxF6JdPEFyhQ2eLu58DEcAE7WDLcerTDLNwUnLrpC28adlL7z7gfBeVP
         JYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872811; x=1757477611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmjwLG7Fq+yscSPUHiCSFMVINTU2Z5qiOL+YOu1V9RY=;
        b=mZooF85HXucDek3LNr1cNf9MgDRaw4LbKYMehaiz2tDF93zCkomDpZqcZrlneMy5dl
         DrBACqlLSiDkHNZslzqET3+ATdl4haQolk0rB3U38eMpWBRZz4hSf4AdblzeUP2aytpr
         ngonaq5OEAmwS3s8HSRvcNsJrxe+3mKkG1FwAHgdtqbH3CEY/qzjGK+ZcO7aG+AwhQAT
         r7jziOgwZS/irCI92stqdPsoMye4VgKZ5SubkncBRSoU0bXkhdTEtWdDKOZz+yrfQz2D
         XK4s3SIraKUR2S7MfAGjopL50Kt2dppCvanEytiatyI2pQ0yo+fdFn74UtbX9gaAwYCj
         bzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX77XzG4n1sn+7jBUvf/8BRlRTXlzny98FPDaeu2EGG5BS2AFgX7IVtxfS0D34pMLokShGJHw3V3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPNGAlEWBT/mJ4TG4d9/Q8zuc17BDuTHMqtPiwjjABGeim62a
	uwbTbcnerfVjtKkJO7S+Q/aZJy91yAhR5Qft2o2XnYiixXwjktyLOEpBQsqfPS/XRm0=
X-Gm-Gg: ASbGncsevZKe3+nlpli7wSJdp02Na1kc2ov1yvLcau8VnsOpMos8udvfBYGVwAbk0Jj
	5cygfz0WsCpbHCt4h+wZ4mx23s5aVjxNvjcq3A7QrQ+yRRdlI9IsUzjMOthe+9GsHYG6fMNYO7j
	hHKLsmXr598WzrAzuM+MBiJWxUCaBB0owoBHe8Mi2RhaqiuiDtuvQWZmQj0+XNTb9c5mR3hTo5a
	JVuq/zB+ir2vckA0ZWlYL6VNtw35RuIIsOaO+cdJV9j8sXAp9ty7AVs6n8zYXuVXFAz/OVaRhB2
	FYZAWIjtM5aVKRt2SwGhnA4s/eHB9DJtw5Kcio836njEBH9UG/wHO8ChGenL/SgAHdyrxK7lv1O
	lw0wpsp1kA98ADSmA0gh9lwQT
X-Google-Smtp-Source: AGHT+IHRoC10EpzarKMIN2A5R3VhBRRZPbEUCwSIAdpKvzIs5DQQWKr8xbqFsrKLC9z/vlEp3fqJSg==
X-Received: by 2002:a17:903:388d:b0:249:1f6b:3268 with SMTP id d9443c01a7336-249448e3b08mr201309885ad.18.1756872811622;
        Tue, 02 Sep 2025 21:13:31 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b020a7cb5sm44572215ad.115.2025.09.02.21.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 21:13:30 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:43:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] cpufreq: speedstep-lib: Use int type to store
 negative error codes
Message-ID: <20250903041328.qgxv5eoajd6yg6jv@vireshk-i7>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
 <20250902114545.651661-4-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902114545.651661-4-rongqianfeng@vivo.com>

On 02-09-25, 19:45, Qianfeng Rong wrote:
> Change the return type of the speedstep_get_freqs() function from unsigned
> int to int because it may return negative error codes.  For the same
> reason, change the 'ret' variables to int type as well.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/cpufreq/speedstep-lib.c | 12 ++++++------
>  drivers/cpufreq/speedstep-lib.h | 10 +++++-----
>  2 files changed, 11 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

