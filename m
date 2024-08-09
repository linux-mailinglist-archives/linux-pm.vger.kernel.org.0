Return-Path: <linux-pm+bounces-12022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BBC94C983
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 07:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FD51F2369D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 05:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342216C440;
	Fri,  9 Aug 2024 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXEypYFx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1542D16B74D
	for <linux-pm@vger.kernel.org>; Fri,  9 Aug 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723180501; cv=none; b=qEC+i5S5J4TyZ9sQmi6jqqqY6uA7pM8fetRN5Ydv2V95XJLFklCTl0CP/kZ4bLZVjFLXVWR901RL6QXuJrjOxdGJZXwajx6XMV2Z2TkHMV80HRR5qE1qwSSjl7Els1c1nLeoFWRWXRuU1VTjzm8gwDkuIokBMvXgOS5iegmWOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723180501; c=relaxed/simple;
	bh=TDCPxuODPaukuKZsL8kyvuCYXndR12/ClqxBAqUEu/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK1kpr3NS0BnoE/yhf6nFo36c14xRvi/CrODJeiQHx8kEvr05T5tK8KdvqxXsxTRUUkDvcooX/9xcs5zj6cy8GHc4mgc6XxemOkHfP09FUIRQ/p4V8bnOo1fLvHQWtPIOZamdKNhbVmvJRidRdAQ8N2oaJcXIMd2GPCcj8ZeKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXEypYFx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1210905a12.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2024 22:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723180499; x=1723785299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai4n1ojH4BrMxHYhxOPvkGHen4LMeRJtChl2a3se8Cs=;
        b=NXEypYFx/362L5oG2CgLh6t1L98NQ1EEU8m9GKaVDqfxWQ1lN0M7u5UQBBdXdrtcBw
         ys2i1NEDi5kKlpNNga2a17t/ikSDt+hfg9kOZi6YeZNHLvs9cwu/ckn4mCuT120b8A+M
         u2LA/DjJlA2O2UmrGlO9vNs2O7RI0SFrW/ybzPlndq3OgKbxqcS3hgwiQzj6gG1IWixj
         m/cFTtwD5iQQBrMviP4z/IuGThvyATrJ89GYvc2/86WVbnblS8Yy09Djdw3CypTRBvV2
         +4v/ZaHTfmYkmO/AoYsOUdhO7o+heUi2yWVAdlGS1RrSpVeu9IZOcpfO6Nq00g372eaw
         Dnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723180499; x=1723785299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai4n1ojH4BrMxHYhxOPvkGHen4LMeRJtChl2a3se8Cs=;
        b=VNaebdQLxbDU0MEMPwKFCVGJ8r5duOgRKJjKy0XCVV7JqCk7vbkMdsz5p3qaRGeQ2+
         ILH3LF0r2Wd4rlUHI8tW6Pf3Jrf3Gbq3s3W4ZG+nESNOe6ASZIs87AvgD2iLkGxHy3mf
         5gserfZehcazaFF1PYcXzhB6fWvYICHxfC7uqdOdzOnexDrZ18PxzkAssuShPy1v0FuH
         LJwGLvAU78hMSVJHA/gbpy4wGwz4d6MXeiUcSfUkp8EkTX1enrMeQVmGr2dCiKbl/ONT
         6ZYzxsRCsi7JTrrNNyhtMFFmlSfyIYnRCPHokyPJLfEYvISn9lQVGdQE/X5ypQgAY6Mq
         QZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhm3KUzTka6XSSkMN3iE1jwZYWJL+OyiBSimpOi/GcmbfqVDFe0gLSIiijxWkNvIjHdIPO/GCULIbcNxbGgjV05AOC1uagtCg=
X-Gm-Message-State: AOJu0Yz/mX1samHvmmBYdBxqBAe9GGikYixrlf2kCF/6rlHyPoE66A42
	lUolqn0j7z8/GicmnrCQifqwnqq6xu7W4dC6mBAXqswqYo7a1I0qTFxpH7+kyMY=
X-Google-Smtp-Source: AGHT+IE/QAvLW2koC535BQ4c0HdzUo6YI0VqTDy0Vl7iBvIPYYqVQatuesL1BwYWFpNjl9gKrC8TPg==
X-Received: by 2002:a05:6a21:3a4b:b0:1c1:89f8:8609 with SMTP id adf61e73a8af0-1c89f9c0f53mr723935637.0.1723180499370;
        Thu, 08 Aug 2024 22:14:59 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c9d745sm2050554a91.28.2024.08.08.22.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 22:14:58 -0700 (PDT)
Date: Fri, 9 Aug 2024 10:44:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, rafael@kernel.org, li.meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Message-ID: <20240809051455.eswe346caiee6gpp@vireshk-i7>
References: <20240808123651.3741-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808123651.3741-1-Dhananjay.Ugwekar@amd.com>

On 08-08-24, 12:36, Dhananjay Ugwekar wrote:
> Fix the reference counting of cpufreq_policy object in amd_pstate_update()
> function by adding the missing cpufreq_cpu_put().
> 
> Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 804fab4ebb26..36edae40db1a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -560,6 +560,8 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  
>  	amd_pstate_update_perf(cpudata, min_perf, des_perf,
>  			       max_perf, fast_switch);
> +
> +	cpufreq_cpu_put(policy);

There is an early return path in this routine, which still doesn't
perform this action.

-- 
viresh

