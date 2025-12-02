Return-Path: <linux-pm+bounces-39033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC03C9A0B8
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 05:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56BD3A4EBE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 04:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443D32F6573;
	Tue,  2 Dec 2025 04:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J19pqsUL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198B26D4E5
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764651512; cv=none; b=RrefpvSjoc1Onox+7T6ePTkO6wMtbhWXqQgf/wasjKzSAGkIGwaFOwUgLzk5dnnmJaTYxUrB518fuyVV4sMUmHEGTOhHJSjeYF+BnzSoLqpBYI9VEvIUWX1ibHihYY8vvj8Tu0rkL+lMPUsniFQM2NJtcHmxqexSV686sRrce3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764651512; c=relaxed/simple;
	bh=M/TyGUphsrSvy3mZwNzX+0bEbhjZrrKPFC855vN/Eis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTUpULQcPCP4RNrH69M5layexRPMszKbEoyCX/yDFt/CYMG4HpuyHYrci0D7PEpzkoTCjU7ktoHJE1U1czFFxLOIyWF6IzxQ7ESnFAwB5nLAaQde7YW5A1hi8QbSomyG82dlBAmZDaXXsW5r981uu6ozOvKih48+4GxTt3eq3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J19pqsUL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so5975062b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 20:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764651510; x=1765256310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzMbpRlfy3vFhBMgubx3Eekv9o7b3pRIxNgt142ueJ8=;
        b=J19pqsULCh6DUwFy+/RGEi7Vp5TCLGKVtfI1n+B7S0j+kmkcJZm9+NGPayHL7Sz3Ye
         dMT8wN9BOQfUcAiheqe12s0scTlNCD+g4MhO/v/aww/Ja9zON1LuD9AW4tfcRIS8L/sO
         KueXEfsH+azUScSOHgeyQbVA3MTycIft1wHsz8TfqwCZ1jvSTd6WvTG2Qp0pRmOm+8uw
         ZH1GyUynRrWWGUi1d7fgmfqBKOLJnghYGHtbFjhKLRRj5sTYMUp6GtGqpzfY4+TDfN4V
         C67tb/qRYsYnVAMVjnkVIQ2iUkr+tPHWn9Xwhc7xV5UgBiPm9pyEAzB7xiE/VgxmtSEr
         P9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764651510; x=1765256310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzMbpRlfy3vFhBMgubx3Eekv9o7b3pRIxNgt142ueJ8=;
        b=jJk+535TyJ4qFmD1t+0kt6kfntLTM+WupHQrQnssvRRadEjBbXghuPaKFroSMdWgol
         Du7iYpKQC+kKOBjmPthBJ+Y1BWfQh6du6xkL0w3oYgwuYgaYIimybmCmKBSwzw+eYwGz
         /ruqLro/CkQ9WpXTGI37MWj9XuZ1caqWpkeDp4FeIBe5qhEVMdcObTVOUlINfM1HBZd3
         lXgqOu4C0s4H4Q/hOOJTVEE9hYk34PR8Xyp8bqqASn7qnjEPzFYHC2ZNZB046GDhbag8
         ONOc4s4K1FPQoacPSu7xLIeD19vZ/bQtYyfZJexd/6XTO8QmeZmGuxExepjrfHvpTA3J
         DY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVB6tzmz3Dui02eKO2YSj+/dggbmBGw1b/x02wjdhhjB402r3/pv3J/JsIj9dbdDtNI2Nnzg5gsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrlw7qErFkvFM5Q/kfSHelZqmurBjRJWqZze54VfCmj6tQCXgM
	XHfHDn8AocAnhyvYPoS99CW4GIg/9IIMMF8ly0A0pFK49KEKJku7/XHP8rBsvZbF9A0=
X-Gm-Gg: ASbGnct2HrnMeFTIP8m1FYN0XNDofgINoxKS2X/naCgVCOJ66pde+xEBQA1DEjmGjU2
	Z49EdvU+7e5Vihjc0xBUshOY9iFwwrZpKkMVq4DtRHbNFu6kC04Fg4jI/We1wFgxbM7V0MkBUch
	L321IPQ3jAsGXtZ1sJzSSNiAUb32z4kkH5GG5zqItdb41n79m7WBh9Dp01QnXtsmy4IIa6qlHeD
	OiN6XPaWEZvtmSJ3cjobBW23r7/j+AQPxd3uPNzRy8/WWFaggBCw5MTMsVe3kCDj2JT/9k8g+YX
	CaQq9JA/BZepZmujbRPQJar8QZZLIwdNHjBt9lwfu1GvrQXVNeTS3bG6qGme7eklv/bOso4A2nB
	mhr8TPUvyxtEXhEm+DyXQMoDhhPJjVp0phwUO3hqfJeKgb+Qg8IrnASAZ3Tj8BEHZH32UVe1j+C
	7G6WZev9T9NB4=
X-Google-Smtp-Source: AGHT+IHACtSb08fNWFBcM076mQ+J0rTYWbg0PnObX4DUerQT2hw7+30Jm/mnDLLVr8SU5c25bEjF7g==
X-Received: by 2002:a05:6a20:3949:b0:35d:53dc:cb61 with SMTP id adf61e73a8af0-3614eb3f6a3mr44631691637.24.1764651509542;
        Mon, 01 Dec 2025 20:58:29 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150b68805sm15347325b3a.9.2025.12.01.20.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 20:58:28 -0800 (PST)
Date: Tue, 2 Dec 2025 10:28:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH v2 2/2] cpufreq: cpufreq_boost_trigger_state()
 optimization
Message-ID: <a6p3btn4ykt6rzdduww6ozunusfubv2dmczqfr4uuttgcnyjqh@kevefkumtidj>
References: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
 <20251128091352.1969333-3-zhenglifeng1@huawei.com>
 <3t6quaz6j5mbzewgrszuzmjmv74bzqrskx5k4ewgsfbaijmoli@y7goctaq35mj>
 <3f51db20-3822-4be7-ba13-e858aab25dad@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f51db20-3822-4be7-ba13-e858aab25dad@huawei.com>

On 02-12-25, 09:32, zhenglifeng (A) wrote:
> On 2025/12/1 11:42, Viresh Kumar wrote:
> > On 28-11-25, 17:13, Lifeng Zheng wrote:
> >> Simplify the error handling branch code in cpufreq_boost_trigger_state().
> >>
> >> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 11 +++--------
> >>  1 file changed, 3 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index a4399e5490da..a725747572c9 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -2824,18 +2824,13 @@ static int cpufreq_boost_trigger_state(int state)
> >>  
> >>  		ret = policy_set_boost(policy, state);
> >>  		if (ret)
> >> -			goto err_reset_state;
> >> +			break;
> >>  	}
> >>  
> >> -	if (ret)
> >> -		goto err_reset_state;
> >> -
> >>  	cpus_read_unlock();
> >>  
> >> -	return 0;
> >> -
> >> -err_reset_state:
> >> -	cpus_read_unlock();
> >> +	if (!ret)
> > 
> > Maybe we can make this `if (likely(!ret))`
> 
> For the platforms which are not boost supported, this will never be
> matched. Is `likely` OK in this situation?

Ideally they won't have a `boost` file in sysfs, and if they have it, we don't
really need to optimize the failure case.

-- 
viresh

