Return-Path: <linux-pm+bounces-22383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40BA3B111
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 06:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8737E3AFA91
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 05:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695981B81DC;
	Wed, 19 Feb 2025 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RG10Z7Hb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61C8BF8
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944189; cv=none; b=gyc8YT1XgRgMKYpDEdic1J25bGSO9B8ZHn62wHVB6qxEquA5vBbcJ2q++QnZ7tCQ8jOWy+TNEgzwayiRpCRioM9hZciDaUyxkaB5FEKv/LW9+rlSdPRiiWaqS4wTU/QsVQoLO1pnQL/UrGc7pz1yiVdVrMtX8wfCjAiv5lSc1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944189; c=relaxed/simple;
	bh=gGRwfgPpTpK82Oyia/6u3CHtfQpPTB9d5xrWF187gz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkkFnyuIZgDuJKCSu4Fhy8afDcrOqb+oHuM8J1JClkSitWK30vHu76EC/T044ZS6WNkPm8BQohzdmmlhg4NabVLfebM/YLU0OSCXTPwRl6IUJztO0cYzA7sD3G0KzOMBRRx2hFd6cZ5zbgX82gD3dxGT4ZXtOobLVAzcRiJ2FA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RG10Z7Hb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2211acda7f6so69693725ad.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 21:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739944187; x=1740548987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nf8/3/DreRNzXlFHg2AgTTtfjDRLaudroEyy156u0qE=;
        b=RG10Z7HbWIm0Eh41GAQyiQ17uV4pN8Qf4586+QXFdrEvwgC4m/musdMUcIM5bZ4uLG
         3Va4Q4Vhl9ZR8ZfIOZRrFa631KSOc3ve4I+T1J1KRpLWGp1KX8oBb8f6TAq4/SV+4xoV
         /Lzct7iImH1z5hkVIqhMJKgqNy71FfR2TB1doIQGKNN1JiPnXo4TdkUvml6g4VQpYyog
         s72XU2ufT0epoxc8xKxVvS+N5qxhUTw5mkZt9rkYD3em0/rvroI/epy8OkGfsoXkzVzo
         5nT/ydb297wFVxU8NRm4qwMZEoDV3qG0qdTRUi9NnZJe+K2SSMx3wlQbkMrlE0OxQsq0
         dVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739944187; x=1740548987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf8/3/DreRNzXlFHg2AgTTtfjDRLaudroEyy156u0qE=;
        b=YKynQ4GwXwhu+i+cBbulo+fJ6rYB6aq5dZ7k3Ml3p/FmlN2Q5M52dksYPYD2XDWe+1
         JObZsFwvgkhhtnIwIKhKWEwKVSBnJcHsg7XC5KQRCOWRT7ckl4tmWr8dMxpV/QuG0MZY
         5uLG4sAlBsEhGcqH8W8XvQGoTiIXlOPWBTQouGBDsbQucyqpYqDDvaIde1Tj7oMGRl7V
         B+3OPe/SHl+F0lXNBKrbOG8T1DF/Zsxqf0//lib8qMZ20lJUkcrVvcV+aw7UtW0KuRoy
         0R3yGqgCAq4WyvgQV/ZAJ+jkF0S69oe53bmrozzJzfjRamf3HEZ1+1KKUU1DrkvMRf2G
         aa/w==
X-Forwarded-Encrypted: i=1; AJvYcCUn8ij5V8R7dW1bsyZT2HVhxZrs0I0xmjO6sp2EGGYsfYwViMUfSHcbK998a3PS/meaLOkgVyCk6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVpyEsgMVW0xJq3IQWoaQxPjxqwuAIX/RFKob3Zt2Ogqovwm6
	hyfg5HDhXs4vr5H8IhXVDemIo13IkKTTwJiln3CAh52h7Lz8C2tQmPdkXf0BTxo=
X-Gm-Gg: ASbGnctw7E1SO7Hv9/G67iDjoVvyAuV8bfxVjmKdspbKHxPol/GrfwBpjdRQiU6DZAV
	mZaHpq1Bz/nLmj5e59WdJBWDJUrsgtRRQAdyIQLsfFdlSrZOe72BDEyX5fvM3zuG2FbdCy2H83z
	+e0kYyZagufSXH22/e9Bo+fkXf1kndnaYPvb4BSeUIzY2MTV+7HeBY05OG5vkTKwEUsbzmdjgrI
	7bqYMz4DutYl4qHAJagwWDF9XUwv53DgkQYp3Q3kjTgirBU4OtnhfQSwbvLibcMxi8VOSkYp4OE
	8Na9JcomcOyCePtoSQ==
X-Google-Smtp-Source: AGHT+IGTrwUiHai/F6Gc6jLbRLvEYwLeRI5NCdNzX1yb+2FEyc1a3QDq5aXdiTbSDtTZsAlf5lbhwQ==
X-Received: by 2002:a05:6a20:b58b:b0:1ee:8bd5:81c4 with SMTP id adf61e73a8af0-1eed4fb2d4bmr3091062637.28.1739944187132;
        Tue, 18 Feb 2025 21:49:47 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73274399467sm5972331b3a.140.2025.02.18.21.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:49:46 -0800 (PST)
Date: Wed, 19 Feb 2025 11:19:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mark Tseng <chun-jen.tseng@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 3/3] cpufreq: mediatek: data safety protect
Message-ID: <20250219054944.4kztb6rtumdt3x7h@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-4-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214074353.1169864-4-chun-jen.tseng@mediatek.com>

On 14-02-25, 15:43, Mark Tseng wrote:
> get policy data in global lock session avoid get wrong data.
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

I think there is some confusion on why exactly locking is required and where
exactly you need it. This patch is incorrect.

If you really think some locking issue is present here, please explain in
detail how a race can happen between different threads.

-- 
viresh

