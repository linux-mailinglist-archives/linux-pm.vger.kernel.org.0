Return-Path: <linux-pm+bounces-27497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3280AC07C0
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A64A20B26
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB83235C01;
	Thu, 22 May 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwUHr/S5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9687D2356B0;
	Thu, 22 May 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903861; cv=none; b=YC4ko/NN7obx4qaMh+apQmWJGrLS3Zfcs8+RNw5qXO2fpFN/UAkkrhokl+mcwnFVZygIBxrKTslIqiWftNuLdweQDHdmZc8EXuTGHxGhaPf6Wf56z6cM3GOT4v63TRRXFZelllQBZTsf5b9WOj3yJs6UnpaNzm3GXrimO33KFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903861; c=relaxed/simple;
	bh=vCtAwPKsS+J2jeMoni9nfCTO0QYTaGxynNQgOruhtB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DndrgL8QjneEn1TcqPdfIuBdifMIpXu15nSC8LARpbdYIm7di0dWlzE3EkIjozdzGBiFQm6J+ozaAdzAjIXNPyVZJv+AbfNVcdp2h/393hmBad2EsMr1CVNogcnVdWdy94XWJFbSu8GkskAxi9Pclju8B/7m6eBPSJkiyyUeTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwUHr/S5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4769f3e19a9so52593291cf.0;
        Thu, 22 May 2025 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747903858; x=1748508658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCQ9z6t4IW6K9Tkhuy43bBJfJ2LcpjBVMC/j6CP1IIQ=;
        b=CwUHr/S5vB5Osqf+n6qQbd0V3HPXsxzyqf5BA7KD0v9ngfAflfrJ5qIcMP2OT37oJy
         +hkohcYQ/2M+wKTnn+xkNaodO72ezL4w5rUDdp2RHHNFywvn19e7Qg/ZZGlxjmmnnT+v
         GJpac+68SsD50OZaTJjxmictzoyKtN1yU1lxL/GxU3iKxKwsX9XB9TiC595JwliOckxD
         7ZCEvXStFYde3mDAK9TFKCuhZYxRcFk+2UGlqH9b+2bq3u5k3PLGOKBarDvw2igri4GW
         YuOZb72O1icB90pmCg7CCezTRsASNjpu5THCgqqj4SyxzOL8jz57W0wPb0NWM74JmwjA
         UXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747903858; x=1748508658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCQ9z6t4IW6K9Tkhuy43bBJfJ2LcpjBVMC/j6CP1IIQ=;
        b=nQeD5f276gqsDykK7xQKiffpXTCWcXiP4hZWP8CocO8JQe+zjJDwnFOnaCgZIqg/nD
         HENsyc8/7jS4fuBQiaiOY0sg4OD6zHvLFU7AeOdluaLVwxWBKvgiqjx4AayXhdnB+a9g
         77eUWIHTvyyrcdRpC4rhsOrWWjJwrsSYLrwsy8a+nFBbljfHUrJP0/6b6HssKac4Qf62
         nb7/P+pDAN7pwh1OxmSWPym4WO1dhSoUuNiVoP9Cm8TNFf7dwsH+S+EyIkqbgPcmnPp2
         YVJ1mWHuciR0FSVb+6EMGcOCT/V83EVWgLvkyVX7kb4iLzysHtN0S4JsLLUNqDfxCIns
         +ELw==
X-Forwarded-Encrypted: i=1; AJvYcCUoCTKWfOK5wkdAYAl8Wg7CSZjcGNvB+nOuKmkf8/IWz2MKjXHgLWyG5bgtg+zGPxbWw5YFENCFmS60Z7ZC@vger.kernel.org, AJvYcCWRrViPBzpBFPv4r7PFS7r3BH9RFR5P4UNOFS8BOoiWU2YoF3eLuT3TF2vuTqjxG2m63YEKM3lFtmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7e41Z9JrZBEc5Z0s3GsVf+SIFIx6lsEkxy4sJ8rugNb9GdlB3
	b2LsjLPBqjcBryZkklQrSkLjERF9WjXRb4tNcrNGBu/l7crO4SGitu5B37wWlEvY
X-Gm-Gg: ASbGncul0wyI2SkfoiSW4DPxQ6lMVJGyVbOOzwNNjlAxw1BkkxoTXgaJSpdGPCjUvTS
	mJP5XQtC0DgBIOMcG77hNAGnRJ+viDE/pUt1d/E8EDK4F68s6pGRSX7cBdcJqcO8z/upLkE9NIb
	2yYiyqjOTjKzaPVwI+f2C/rBvfRaW7dCS5/ts2tEOTLP9Vl84wFqUlTKV3moM9Oy9jZEDUExi1M
	WA9C8sXy8+UsE/HS+AuvpQZV0Q6a+64HK4Y+OVYIwT5Aw+aVAKm2bm6EXG2AN5fO+R8Be/Eek88
	uOD7/f8OGkKMJ7+Uuj0joos2zJbJ3iNNm3bgXIzRl0dYtL/bISphJW2iNFJMyOCIUbo=
X-Google-Smtp-Source: AGHT+IHOyxo6I9Vnm74dVmcNYWy1/xQqPxP3wvHGsNE3PL5cS7byPNmY6cxzJiC8bu7KyyjaHHNDUQ==
X-Received: by 2002:a05:622a:5591:b0:498:111:93bb with SMTP id d75a77b69052e-4980120dbd7mr324505011cf.37.1747903858317;
        Thu, 22 May 2025 01:50:58 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-494ae425388sm95564141cf.39.2025.05.22.01.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 01:50:58 -0700 (PDT)
Message-ID: <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>
Date: Thu, 22 May 2025 03:50:55 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: Shashank Balaji <shashank.mahadasyam@sony.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/22/25 3:05 AM, Shashank Balaji wrote:
> The userspace governor does not have the CPUFREQ_GOV_STRICT_TARGET flag, which
> means the requested frequency may not strictly be followed. This is true in the
> case of the intel_pstate driver with HWP enabled. When programming the
> HWP_REQUEST MSR, the min_perf is set to `scaling_setspeed`, and the max_perf
> is set to the policy's max. So, the hardware is free to increase the frequency
> beyond the requested frequency.
> 
> This behaviour can be slightly surprising, given the current wording "allows
> userspace to set the CPU frequency". Hence, document this.
> 

In my opinion, the documentation is correct, and it is the
implementation in intel_pstate that is wrong. If the user wanted two
separate knobs that control the minimum and maximum frequencies, they
could leave intel_pstate in "active" mode and change scaling_min_freq
and scaling_max_freq.

If the user asks for the frequency to be set from userspace, the
frequency had damn well better be set from userspace.

- Russell

