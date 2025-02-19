Return-Path: <linux-pm+bounces-22490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2908AA3CA5D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074DD16D9DC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05424E4A3;
	Wed, 19 Feb 2025 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DMzqsYWa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511024CED5
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998299; cv=none; b=m4dPXNW8j+JpxwO5F8idUWS5rqHuLZ9Q9tbFve8wup8J3sGtPfODwJ5RY6UwOF67hJgafPYWAqdWXBKgESuwtLOvLJNMFmjvjpPMlYsbTQYHujczRlmIIPAGKBLeHFuJJiT+Vrw1S5qQmxBLYprIPEtMNSw+lTF05MmyfLOG5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998299; c=relaxed/simple;
	bh=+uHdTRHxNDfBVd3zhnH7kveAQzlfhzBsi9i6T6xdxJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaNzzuvBOSeMKdQomWsfXtuLLC/A5HXmfbZgdto2UCKWsgmA7vTpqbgmRmB5Iqzkf4WM2v8BmYnIK18Snlq7leXja6WB3Mthw/SsZwPErrdrkj9ZnMSZ51s4B31M21W3uYDLF8wPfLra8VTFdLUnp4M7wbN38PScP53m6DR8Ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DMzqsYWa; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-855bb6041a6so6772339f.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 12:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739998297; x=1740603097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2o5IeA7VDXTHKtaj62YbAWTuLHaB+wX30y2aehqoy0=;
        b=DMzqsYWavni4q+a4KghpQ6zyHCnbtkfKbUWJSrgCRoF9D9s4Rlzv2wUJryPbyeC88a
         Nt/klUmxYWh0DTIXu4+8/PpVeNUgJpfD5i8Vx/DsUPkAL4hSW4BI5J3TBSQaDfo33o+B
         qgbeWoP9gTiTEH5XkMPhsKKM5WxaiJxXRbc5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998297; x=1740603097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2o5IeA7VDXTHKtaj62YbAWTuLHaB+wX30y2aehqoy0=;
        b=ppbIhnfRZ1JMP4lf+T+0wjPN8WRLW6pyRE8jz4Lh383qITRYlWeGGKZW9j2U6sZKAS
         vrh+YsNI/3BUId+9QapPDGtNfb0w/ny16d5c0t9y0DgVM1zAj1/z9PqrKh/9ah59i3Wj
         zglFFnvNeXb0JVfyNa7LigEKi5DNn9PnmSulalylxcdp776DY4/40A2zX1IoAXy7zrpr
         dWAol7im65wn4JTdtMUXviEHlhjzJL+YULL32ovZ0UL9rlpSo+ZDMBq1yHhNRBw232Lu
         quW22iJCvc9Md7IYEp2xRblQP0jarPxWrfvbuCEiegtQfJhraFnw7SaMLGNBPM6cT1IB
         QHtQ==
X-Gm-Message-State: AOJu0YyKmPhoEFGNbpmMfM3HRaCYTKkiS3e8jG2sd7pFh/K8WkpWxZbp
	dUQK0go/12QobB/Vrc8aRAmvy+zV1yQ7e6Sd96yZ4fAJ1ehUJ0Ldfx+7+cQQ3Q4=
X-Gm-Gg: ASbGncu29N2LF/y3qcz2JpldH3zpjPsI/AlALO90wu1fJOLg2vbZ3qU4zyptzq0QClW
	O36V/If3GHZFdFETHILVWq6Zh2YXqj7AF/uQBaR9Xqk7RCdANTsSZb3NJ/SFCGlrpD9zWz6sijb
	NHzLnGmaNiMUoxEYk7upbixD+Kg1M8DeuoKzADxMOnlDj22Ueb+wARcI97dwNj++aRiHe/SKG5H
	VUAKIX594fauznlOAwJJFqpsKrV8OwuNGFlqiRIulmIFflmiX9FiRygXhecggFWMXVGgiImGcDu
	KU7+MDO7uCYHl9Iroxmwl2Ujfg==
X-Google-Smtp-Source: AGHT+IHMYP6GsM4Y2iBZ0krD9AR16rOibJ64C+QYYXdRt3JS3ZCwEwZHaU6pgXrYj2XeSJIsteCc0A==
X-Received: by 2002:a05:6602:2d86:b0:855:690e:ed8f with SMTP id ca18e2360f4ac-855b3a01ccemr621360839f.12.1739998296814;
        Wed, 19 Feb 2025 12:51:36 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8559c37b07fsm120999639f.0.2025.02.19.12.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:51:36 -0800 (PST)
Message-ID: <9f137f62-e182-4f00-97c1-5dca6e25b316@linuxfoundation.org>
Date: Wed, 19 Feb 2025 13:51:35 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: bench: Prevent NULL dereference on malloc
 failure
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com, peng.fan@nxp.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219122715.3892223-1-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219122715.3892223-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 05:27, Zhongqiu Han wrote:
> If malloc returns NULL due to low memory, 'config' pointer can be NULL.
> Add a check to prevent NULL dereference.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>   tools/power/cpupower/bench/parse.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
> index 080678d9d74e..bd67c758b33a 100644
> --- a/tools/power/cpupower/bench/parse.c
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -121,6 +121,10 @@ FILE *prepare_output(const char *dirname)
>   struct config *prepare_default_config()
>   {
>   	struct config *config = malloc(sizeof(struct config));
> +	if (!config) {
> +		perror("malloc");
> +		return NULL;
> +	}
>   
>   	dprintf("loading defaults\n");
>   

Thanks. Applied for Linux 6.15-rc1 - will be included in pull request
to PM maintainer.

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

