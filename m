Return-Path: <linux-pm+bounces-39037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A14F0C9A5DF
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 07:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723884E01C8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 06:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33403279324;
	Tue,  2 Dec 2025 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trWRIn7B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5092245019
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657973; cv=none; b=SgtRDx7XzQXUW9K1e0uucenLbuJ1OvsDM82IPoaXX2ocO1c58xY3b46lKUrQzHLHpR+GgUUEiYO2LJX0F62lGM/qMd4SQg6MhHsFydHXNLdj1LUl8APlHKtnFgeEKAXDohF1u/wn1ICurcnDVWROdUcMRy5F3Vbqlp3UoIRoOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657973; c=relaxed/simple;
	bh=LPti0K6WY5CYkDxc/hg7dVammTH3ohTWFxCjFOamokQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEAle9PwfNSP3Peb4IJT4kH8bVztoZlESaMKyReg3wo+OTfhq9O3ahdoI93NdQvXVqZG+5s+9WVyo9P7h8GfqVwaM4GsrsXxGUBXfb97i8wQ3Ie6lqcS4tlx1zeJYbyoKGtGHcZSqx2DGVTeakKniWubPgwovqLqXAktXfvbNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=trWRIn7B; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3437ea05540so4115916a91.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 22:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764657970; x=1765262770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+xjrJF5Ba8Lcz3qV7HKUxI9SOOGkNCfXItb9Gfndl4=;
        b=trWRIn7BkqOpeXqM4qSaQyFu/QekVgpFpaHC+ZhRcZh+fGgcUxwXpCQSsRFXWTqXkJ
         6ywcYX9awI/SI5UxIWRqEJ8391MKXuGj5jlGIjKpTq8YIXnzfbE9gNpS9AdkH0w7IFPz
         +kyfYv4/1qIQSfkz4VgGMk7t7FfRSNF34WqhwnIJqS9gASFdfTbI6Gu6c9GOO9G95fpZ
         vemRwMQbnSv/dp/WO+qEQcAJl7/7qvcT5H+7gM0KMf2WP+Ix03Fjqqu4ikRQ5m4CEZ/+
         V/cGEYFvOVtswaxyPfILBrqRJvFR4LIyr0TTgsuB47YvH1AwxiUx00qEx2JsIsFvSb3o
         EQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764657970; x=1765262770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+xjrJF5Ba8Lcz3qV7HKUxI9SOOGkNCfXItb9Gfndl4=;
        b=sB8zSzpq3znwfHIi9lMt8bQIYyCRY+XlO5FjzABEF8lAoHOPO1h19p5cCYl3eQZt4g
         CZEGf6MdwopdTF5EWY7wtE3WWwwD29FpdUxZiz4WUnC6HJw9nOzIblCa0QBj+RRHSr8i
         F+rFz7SLx1Q+jKLNLPsAJW9pEQLO2SW6xU7/wO7yF+7DXXvQTDzA+31dcDk4o3Vs8ciJ
         8hN3B9TNApY054a7h+TcYK2dQee3Zr+aM5IsyCMyfEmAPIfu5Zhl7pVVAbUBj8tJv6MW
         53oZnaRQrKZGMz7n33zs5fP9WhVqIEmH8dGJipoR10c9jy5HgYCxPj8DLKea/45gBfK+
         WM8g==
X-Forwarded-Encrypted: i=1; AJvYcCW025XlIsBBGb5oZq0fp0SyrXPBxqg0Kg7rbZYcJ90CBoO07QpT542R40njkGcYWrZj6XzJ03s0kA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDro5DFvFAHm2ZnX/6ANyX2mZGy/ThgkGBlwq4VDuRGeC9XMf
	kAW7+QLAlaM7YbPyH/4LjE3AKZuFeDbEWZsTN6C/icYllD8VXBvSx/ddW4yKEyF3cdc=
X-Gm-Gg: ASbGncuGoFNU+V+Ol8mPYBP7cH9aWqcxr+/72X/NDetxr5yCJ577ZDyvjPW88XFofz4
	acOQm4XRFsob+B4R7G7mwXL+RdCAIahj0mHzhrJT2qn+b267rU6qD15pqhpzb05TfMqRkUj4Z+a
	qUVY65eovr+rlmqMsvBAjX3mdFLdJDUYi6vgXyZ0tLmRDVsw/cl7gvFRKlXoH1w8/4gkdsFqGwm
	Chs0vGGvfp3I5XH7kt6DPHhEuyVehZQ33S38ab0qf3BQIHlNMB4OeOqNprbSZmUuCkXSHqI1lIB
	b14+OYoJJzBrjg6BAam7u/Eg8ArH2swDbZ4GzBFY07AcCsXoXJ315a7YkWALfikElBCGwH5mdq5
	k+cqwmuhDz/HVD7su/VCSuC38DDzQtvR+l69NQM1zYBADKDs4tQN7Kg4ZG2Jnk5e72a+2sV5mUy
	pdPsnq+nSx0e4=
X-Google-Smtp-Source: AGHT+IGfGot1Giy2bEbRlTda6UWAG7CzAx1snBfunDMI9BkYU6vxsJnDa4jixBG/yERPTOHcv5xKRA==
X-Received: by 2002:a17:90b:2690:b0:341:212b:fdd1 with SMTP id 98e67ed59e1d1-34733e74fc0mr43794743a91.16.1764657969475;
        Mon, 01 Dec 2025 22:46:09 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34907d4a569sm722890a91.0.2025.12.01.22.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 22:46:08 -0800 (PST)
Date: Tue, 2 Dec 2025 12:16:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH v2 2/2] cpufreq: cpufreq_boost_trigger_state()
 optimization
Message-ID: <uehurs7co55efvav7actgvfridw4ekieg5lldcldx4cunjhsqs@bk45k47mlfmy>
References: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
 <20251128091352.1969333-3-zhenglifeng1@huawei.com>
 <3t6quaz6j5mbzewgrszuzmjmv74bzqrskx5k4ewgsfbaijmoli@y7goctaq35mj>
 <3f51db20-3822-4be7-ba13-e858aab25dad@huawei.com>
 <a6p3btn4ykt6rzdduww6ozunusfubv2dmczqfr4uuttgcnyjqh@kevefkumtidj>
 <9590b0fb-f297-4e6a-9265-ba7a17abef31@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9590b0fb-f297-4e6a-9265-ba7a17abef31@huawei.com>

On 02-12-25, 14:24, zhenglifeng (A) wrote:
> On 2025/12/2 12:58, Viresh Kumar wrote:
> > On 02-12-25, 09:32, zhenglifeng (A) wrote:
> >> On 2025/12/1 11:42, Viresh Kumar wrote:
> >>> On 28-11-25, 17:13, Lifeng Zheng wrote:
> >>>> Simplify the error handling branch code in cpufreq_boost_trigger_state().
> >>>>
> >>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >>>> ---
> >>>>  drivers/cpufreq/cpufreq.c | 11 +++--------
> >>>>  1 file changed, 3 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >>>> index a4399e5490da..a725747572c9 100644
> >>>> --- a/drivers/cpufreq/cpufreq.c
> >>>> +++ b/drivers/cpufreq/cpufreq.c
> >>>> @@ -2824,18 +2824,13 @@ static int cpufreq_boost_trigger_state(int state)
> >>>>  
> >>>>  		ret = policy_set_boost(policy, state);
> >>>>  		if (ret)
> >>>> -			goto err_reset_state;
> >>>> +			break;
> >>>>  	}
> >>>>  
> >>>> -	if (ret)
> >>>> -		goto err_reset_state;
> >>>> -
> >>>>  	cpus_read_unlock();
> >>>>  
> >>>> -	return 0;
> >>>> -
> >>>> -err_reset_state:
> >>>> -	cpus_read_unlock();
> >>>> +	if (!ret)
> >>>
> >>> Maybe we can make this `if (likely(!ret))`
> >>
> >> For the platforms which are not boost supported, this will never be
> >> matched. Is `likely` OK in this situation?
> > 
> > Ideally they won't have a `boost` file in sysfs, and if they have it, we don't
> > really need to optimize the failure case.
> 
> I see. Then I think the `if (ret)` in the loop should be
> `if (unlikely(ret))` too.

That can be done too.

-- 
viresh

