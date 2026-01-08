Return-Path: <linux-pm+bounces-40412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C8D00F88
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 05:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBE823002865
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 04:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D16928DB71;
	Thu,  8 Jan 2026 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkCz62HI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1F28980F
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 04:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847072; cv=none; b=pWLkfWrjNmsby1l0VOY34OtdKJpI2wGgodK7klD+tkzufXtpFXL0iRBOwBfDpArdRTPEdphOq5vAd/Lv0enQoZkndQz9t/LpU7p1Zj+4ROQFO9dltvSXJpF5zJn7azfvAnRIbdCoEmpEMUjEsB5c6CCRWWdf/Suj/2EqtLbv+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847072; c=relaxed/simple;
	bh=CBgo0xqNfeSqCa86Wp/Q1EPAyOdWJp7L+LKNrnQFcOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjPsfVjcH0Kll/ooT52zbFHmDOH9UFTbx+kFhssXn7FyNO/wVDKKvpyZFXnXHDG5dEWW1UzGGrRhvD4nzG94Mae/Oi3bmsHEHQbqTIHxsm2S8aKJ4wBbQJsWwq+1qwpwKt4mRJZGuFY7xzB22xuE19DWh8gXC+EE2tsYBPPB6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YkCz62HI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34ccb7ad166so1753984a91.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 20:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767847070; x=1768451870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sHwv3XimQhQRsxHnU8vNXeT+H6n1LFb0nKpxiDbRbzc=;
        b=YkCz62HIP5A68JWa11G+VatgGG1CdxOmkmyFnAbflZC8WxACKru3c7zXgjy/VylH8g
         huBUqtLjlgp2Bq23AS2WjDWvy8zEBtT41o8pT0PHLcTGmgeHYmbYtZlgAhS31jcqPxxy
         xxixNyA30bNzOmtVhD1s27269UtQYZX34+s9XJLelRKIGvDAO6gF8vu5ACOY/1tqZYSa
         PrXPyHyF8gBd9iGfRvztqhggZtNwA+gthyYb5Gb5kk2VQef+rrumPu4q6At6B8hqEvf7
         O8eZHS89mTR9tvQR9iijj0/yGjxJOY2uUS7KxcLarrcZYmQu9sNhGUrCjCC8+cxU3o3h
         jY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767847070; x=1768451870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHwv3XimQhQRsxHnU8vNXeT+H6n1LFb0nKpxiDbRbzc=;
        b=Vm6gf4jWqPAu+6EQHRTfRgN+uX3BJuaUeuhWEIkr0wa5f+OOKrL7mpCfBXBPfq3azF
         8EHj9ONZ9cynSYESpUt3tHh/kgxOV7VHiUV9YVokQONtAWuX5Yg3iYH+91foZHPnPise
         jxXyj1Mf1cSo7fFOY5t5p4GcY/NM36FrKi/ovR3I1cWDvqYR8QyQFzodEoIDuxChi78q
         z0pRTGF2ws+6YStCJAAjrKLtwP8H/dPUdAJAJunrDrqX4ufq8AQ2bpiH+GX6upkGuJcv
         6xf2qwzQSoGNyS+Bh34Wg/KInPAZmUV18ppGzl5MWbZq7Vv0ApYWDrdv9Dyi8qe+kAYA
         H2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVatxHO7l3fTobcuA4zqwC2gjGuhPvB/ALGy2zXPsFb7SeDHFejBi6zmHupx2Cz54cSXPP0n2AWVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGOAx5lzvGxFy2KryoJACzDJUlcnoEyMTLN/6nYBmvO/c+g7B
	8b5Sqnwijm1EVpKiwOH9kgdmh06Sjieh+Uxe8xw2J2S2R9Awc1pMsZQE42amGkybojQ=
X-Gm-Gg: AY/fxX7bCtEjGdO/WvU9zwy3i7WQ6N+Id9SImRi8szyCSw4VbGWbFkOcg2l+I/lpa5f
	I8omZWa4KEODvtJxyCJYIs5x6/Se4vFvaA6uu/5TRZFvxAp1D8u+cUgzy22ZRChfkc/uF2nug8+
	xvKFpEHmTFS4smWaPBoAeeWBF7h1wpVtb2q0C1XrxIaOoTkADXbkGPJM5ArlDtmzFnGRxN7Sz1k
	cLYBuvgH9sGh62+N8CzPOis6NH1EHeplRNIHAJfT2Avo/vchQtozl6+L9BVlltth4WN6MRZq9Lf
	6TpM0hUlKhECoVOw9wXLM+hPQu9EyaeTyA6h9b5TXivz5GGQoxLLDJSuF2jOrR03wPqphQSNT5f
	OCCmR6KNnrMYQ5trvKw8mvsL0ZhCWwW4HaBQD4LkcM9vCLEEd694HUI0pDtEGMnHGNZTw8wf39O
	qC04JFfQvh3S4=
X-Google-Smtp-Source: AGHT+IFnr7ng7RQXrDnhqNJuGV5q2M5sr9ovaOCCMw2mNTPYZFPKe0ASlWxFbM3BmCBKXb/y9NDJkw==
X-Received: by 2002:a17:90b:38d1:b0:340:d511:e167 with SMTP id 98e67ed59e1d1-34f68a2bda5mr4187985a91.0.1767847069913;
        Wed, 07 Jan 2026 20:37:49 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb64bfesm6483957a91.9.2026.01.07.20.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 20:37:49 -0800 (PST)
Date: Thu, 8 Jan 2026 10:07:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, 
	Christian Loehle <christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	zhenglifeng1@huawei.com, Jie Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] cpufreq: Introduce boot frequency QoS
Message-ID: <e7bihszshbwidgpgfri4lngwcnsowiwvpps34ealfabbc66fvz@llc5xlsd3gd5>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208105933.1369125-1-pierre.gondois@arm.com>

Sorry for the delay Pierre.

s/boot/boost/ in $Subject.

On 08-12-25, 11:59, Pierre Gondois wrote:
> E.g.:
> On a Juno with available frequencies: 600.000, 1.000.000
> Boost frequencies: 1.200.000
> Using the cppc-cpufreq driver.
> 
> ---
> Without the patches:
> # ## Init state
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> # echo 700000 > scaling_max_freq
> scaling_max_freq:700000
> cpuinfo_max_freq:1000000
> 
> # echo 1 > ../boost
> scaling_max_freq:1200000
> cpuinfo_max_freq:1200000
> 
> # echo 800000 > scaling_max_freq
> scaling_max_freq:800000
> cpuinfo_max_freq:1200000
> 
> # echo 0 > ../boost
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> ---
> With the patches:
> # ## Init
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> # echo 700000 > scaling_max_freq
> scaling_max_freq:700000
> cpuinfo_max_freq:1000000
> 
> # echo 1 > ../boost
> scaling_max_freq:700000
> cpuinfo_max_freq:1200000
> 
> # echo 800000 > scaling_max_freq
> scaling_max_freq:800000
> cpuinfo_max_freq:1200000
> 
> # echo 0 > ../boost
> scaling_max_freq:800000
> cpuinfo_max_freq:1000000

This is rather important, please add this to 1/3's commit log.

-- 
viresh

