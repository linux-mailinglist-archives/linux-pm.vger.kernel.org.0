Return-Path: <linux-pm+bounces-27331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB982ABBA8A
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 12:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9783E188487B
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD13269AFD;
	Mon, 19 May 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvTsOyYy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384035961
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648977; cv=none; b=q/7zoSRs1TuyJOrxWryHQ7RvJHc8ORU/nxAKJjlmKv961MPwIUpVpzcdcIgXJg90lZbUiNlhiqw6H8NZqVUCvpnQMw0vYgd1VZ2o2raRQcV2oc6Ey4Aqf36wwodgen7/cKBDuQ47BoM7e4wU9x0Rm7eWqgDhCV+OmVibfTSEHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648977; c=relaxed/simple;
	bh=rYj7MqOM64QRmp+/C5FKJsL9QHVa0o1AU7Ui2HtSwIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb7fTnY7SiCPLtJOA5BxWtHxmPHZrFtl5jOwR26D0BWrg6+lWDaySDQpsE62gA+rAxD5ZkY9mBKgeDXKBTVEmODwYYDMuf89eHG6lBr2niJgtRotDS94YvJ5mMq00MJ9sG1s4UHkMnEXgoLDML8QLRQ2fcWy2aNDGP3OSHvfEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JvTsOyYy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742af84818cso1977804b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747648975; x=1748253775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+A3f4LcWplGbhyssnSLFwJnEojTcFJ9ydF25cRQg1M=;
        b=JvTsOyYyeBHy+Z8psOYPni99Opw7W5+uAkXVAyB3qU9FRQsmBdcOecfNE2FcJ51brz
         7VM0SEgT9GU0+ppXc6JeZ+H+OVpXTrcQNjl9ZUanqGkErvjp3lWUh9A7VPVR5gqECaOk
         v0hhopDFwG6K8dWvzcy9AdfwHtXE+b6BRGjyKOeOsFSYT+OUmOTSyFoqywooFjvzn3ZQ
         0HdnTIR1yv8o0tMEbM2mk3yg5v14SFIbisdbCd6FLFQeW47TdmWC4OjGHGV3DozUM+Ai
         yA5cS0DShG5cqH6XupAg5oTuCrfNcMMpiZEwVyz9vt1LydAls11bOhWm4f2jpJHzUixS
         Spzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747648975; x=1748253775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+A3f4LcWplGbhyssnSLFwJnEojTcFJ9ydF25cRQg1M=;
        b=Tsvp5GQbAZWClX3hTfpNGIqk9G8IPZg8RFY7yYLlcnQ/l/apHUtcCtDi36Wnx2B+xL
         hunDOg/uN5cPWxT/cJcf+fuKzXRxngS/Uwe5Hwo8xUGJF8FfAeVe+7FL00PvWTziE/Pq
         wHH3MXZAEFjsDQqOx2zbdqPehAbNSOWV0yO8XESl+0OEWDIwiLEMojsJsrv56reIuSL0
         ZtxnT68P5oVE7hr++oIUim6N6oTq2ktmO69S2Zx5/uXqUOV+R5gWWp69FuKmlP9r1s5V
         R8uM1V2HF+dA38AdSYN3WNU0BM7KUS83aYgzYupJwx+U0i6yuis98XNvkVULmH+AtEgO
         u0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWSY46dNt69pLCqwPC8AAbtQ2wyIOspgYaqqu6p/ZBuWyWgv2ziEvhKuKjFfDNQNawNy+QO0y25cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRtKXMSE2pesl+UMvraMMKp6nSIXxNZk1pGh9WlRejv29otPbC
	rIPweAjQtUPh/SarbscYope/uQLXZueGsaNoEutkELUEVvp2hBACNoVCkgIjCtk9/92B81H+NoZ
	1g530
X-Gm-Gg: ASbGncviLzf8rLK27byA277V+Qrt/ljQHb/jHqHfzp6TJezNhR0VWM9otdeTFTQZInq
	pVx8j9xWkitVIgMCF0dQz8BVjc/q00vcr13FGVbLCkcN8qD7DfzEValSoD0dCrMBgadlww0Jzwr
	72xUSz4nqypxYFbRFo6Vi99P4h98AYQDoWCCSgAnDztclQfCETr5x1SWqiWW6GL8/b/JfUnJvm6
	QMdrYZAHab+gcAvWQ3s3Oj1vlS/J/xgZQWVI6wx7gQNhWihpxG6qSDTYuR32RsE6I8S+9ku5rHc
	VjjuvhfxwRLJG+g8PFLYCR7NSpQYFIAW3arU13iwX+dBi1T26xi0
X-Google-Smtp-Source: AGHT+IEJdanszISLWDbmYOQ7WlA7HzgrJl8GG9AsDfB8VFNBB0tqhXCjynngqe+PSU3JARtFE7Mqpg==
X-Received: by 2002:a05:6a20:728e:b0:1ee:b8bc:3d2e with SMTP id adf61e73a8af0-21621882819mr19035889637.8.1747648975483;
        Mon, 19 May 2025 03:02:55 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf5a34bsm5044895a12.4.2025.05.19.03.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:02:54 -0700 (PDT)
Date: Mon, 19 May 2025 15:32:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bowen Yu <yubowen8@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	zhanjie9@hisilicon.com, jonathan.cameron@huawei.com,
	lihuisong@huawei.com, zhenglifeng1@huawei.com,
	cenxinghai@h-partners.com
Subject: Re: [PATCH] cpufreq: Replace magic number
Message-ID: <20250519100252.wme2gfdvl752efe2@vireshk-i7>
References: <20250519070908.930879-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519070908.930879-1-yubowen8@huawei.com>

On 19-05-25, 15:09, Bowen Yu wrote:
> Setting the length of str_governor with a magic number could cause
> overflow when max length increases, it is better to use the defined
> macro in this case.
> 
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0c842edd1a76..a3a376f030f0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -809,7 +809,7 @@ static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
>  static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
>  					const char *buf, size_t count)
>  {
> -	char str_governor[16];
> +	char str_governor[CPUFREQ_NAME_LEN];
>  	int ret;
>  
>  	ret = sscanf(buf, "%15s", str_governor);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

