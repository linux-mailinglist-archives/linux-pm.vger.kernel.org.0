Return-Path: <linux-pm+bounces-20681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3C0A16927
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 10:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123C31631DA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C9619E819;
	Mon, 20 Jan 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IS/RTZ96"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1521885A1
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737364884; cv=none; b=hBj13Y3QyPUrFCtkJIDDOjcyXyjsay3vtwhy8u5XoIGjH5QvnQtyFPXzxcHsyIzcwpLL+z0WbpOf8nyWX446KAgfMC/6XLqqA107IuYNGbe1NvkuSCUIpcvr0ODtAzK3J4pYLZKUhDjSzYAX5KZZpVzarzNU/NEc1S/x9JpwTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737364884; c=relaxed/simple;
	bh=huN49ZIfrYiLeldLpEQdji8jU/PRpArFYMlGW6EtuYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox99ZpfJr0+20SCzg6f7r9dcGhadCVilOo7nXPrgs3z0wNFCAzevLE+S+p4Gu5GPjWaVX7qzoVjOWtPWWKRN18ncny8+vfixEK51D9zbRu1mjRYw1iH3h7YZp5w3AFADjMroIy7Wl1PxQXnON3oAx+RQ8+qTDrjJ7njv4sqaSOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IS/RTZ96; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2167141dfa1so73530775ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 01:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737364882; x=1737969682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihf78PH7YQSCoA2R8KFNJDNzng5phdFvGsE3+F717Xg=;
        b=IS/RTZ96Rpyj5DzSH+XFfSaN2ugRk38qWC4TSoTPUjWKIJaRGLkgqXbiEMKVzMOtq8
         XRjyTnr7z4W6S3NgwDQETkkONX/ZS5TiqRiq0RKe5YIFT5EuRDdoWDBr8yQYWUhzDHNY
         bykH3dnpkVUUI+bGeqJKdxpNokFw2rRWRGutzibww1CIlzYArPCKt88/PVvhFrmWLX3f
         1SLabK2f2G5Z3rwcSy/sRXhszkSn19uIu9MG7KCyaYcedkH9CYNO/fMTPK/onKjFFl6T
         FGm7RDNB7yMB1vjBBz8zu0Q9rtEhWIhp3ffYxRWwNI5cU/iEdD1nyfnRSxoqW4MpBVWR
         eZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737364882; x=1737969682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihf78PH7YQSCoA2R8KFNJDNzng5phdFvGsE3+F717Xg=;
        b=NZ4z0DVWrZ2np2/Ul07P3hO9EuQI3tkZBqBBHMwMkWKblEgM/PswRMaumGyFQLGyLo
         BTMkS+n4R/PP+F1r1Iiajpag+1dWU4K4z+xr5VgMt2eeNds+YCFX9KykuE6YyLk277tz
         jqKALAwcXCcSKZqBmRcbZLIF2YXn4iOgJeutNGBDqPmLpwHNNf2dp7M+c5qSs4+gW5xS
         6MJumT/rssHs7J23x31j2HLx5c8+vsW4ZThethDK7QBtsHNXZb4O1bfC5t5XhsQtEGaz
         +ISjGIhQGEWedQ5q6HQ+lsgDT1eawuvIqYWG4WxgmqoiIy8rtgHMAdmY88FaYEWaIPI5
         X0AA==
X-Forwarded-Encrypted: i=1; AJvYcCXM87As30zmT0mOt7bfb2444YY24U8vAW5d34RQWTE9pc4mtOecWBXbiuUOnOQ/wgXeje6mB14J+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgjXVo8Vf7iVKwvYYEGJUpN+0QKwFfybk+WHfmDe3BeOQwV2+
	UrlAvyGfD4X55wE48C/dSr2VDIRx0kHzqoe2u36Rgs/usFoc+OeFYftEMMQwyz8=
X-Gm-Gg: ASbGncvGOSgQYSqCdlu3dOeo94WPIEwqZb+Zgb+qwyTuyByRZa1h2EsRWdF/meVlbGM
	i9F628MkjtfoMABqelTReTmhTrTFKnVz2HPyL0sCY4UU4TnbOuz6xANiRW1yfkS7yjE8V+6pQuB
	YcT/Vdi1+EzuqhqtKPmBXOJmuvuxbjnm/8mZDlDj+vlEOIzDn068iAoNCAmeR+HPZKSuQ9AlsXY
	Vou2x7nyoNSyZy/BxUdPVs+r0+gi8Vrl8DW5fg6xQk8tHIKjMKSWi3GwV201PA+0wlwCL+FX/WG
	vuQSrSc=
X-Google-Smtp-Source: AGHT+IEIL7paIXHu1yHuBenzGHlkqKF5iX9yqDv7vA8oMtGOzM1XP8+WRR6IPAIIfx18Ymv37cStcw==
X-Received: by 2002:a17:903:2410:b0:216:2aec:2d54 with SMTP id d9443c01a7336-21bf077dbc9mr314160545ad.8.1737364882212;
        Mon, 20 Jan 2025 01:21:22 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea076esm57390805ad.6.2025.01.20.01.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:21:21 -0800 (PST)
Date: Mon, 20 Jan 2025 14:51:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 1/4] cpufreq: Fix re-boost issue after hotplugging a
 cpu
Message-ID: <20250120092119.ik63qbwqk4kgnupv@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-2-zhenglifeng1@huawei.com>
 <20250120082723.am7rxujmdvzz4eky@vireshk-i7>
 <6c58e779-db21-4553-a4da-dcc8591f8c34@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c58e779-db21-4553-a4da-dcc8591f8c34@huawei.com>

On 20-01-25, 17:10, zhenglifeng (A) wrote:
> On 2025/1/20 16:27, Viresh Kumar wrote:
> > On 17-01-25, 18:14, Lifeng Zheng wrote:
> >> 1. boost all cpus: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> > 
> > Boost enabled here, max_freq_req = 2 GHz.
> > 
> >> 2. offline the cpu: echo 0 > /sys/devices/system/cpu/cpuX/online
> >>
> >> 3. deboost all cpus: echo 0 > /sys/devices/system/cpu/cpufreq/boost
> >>
> >> 4. online the cpu: echo 1 > /sys/devices/system/cpu/cpuX/online
> > 
> > Boost is disabled currently here, but max_freq_req = 2 GHz, which is
> > incorrect and the current change you are proposing fixes it I think.
> > But it is not what you are claiming to fix.
> 
> Since boost is disabled, policy->max and policy->cpuinfo.max_freq will be
> 1.5GHz, this limits the actual frequency of the final.

Okay, I was thinking about the case (!new_policy &&
cpufreq_driver->online), where cpufreq_table_validate_and_sort() isn't
called and max_freq isn't updated eventually. But for the other case,
we will see max-freq as 1.5GHz.

> >> 5. boost all cpus again: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> > 
> > Boost enabled again here, and max_freq_req = 2 GHz is the correct
> > value.
> 
> In freq_qos_update_request(), if req->pnode.prio == new_value, it will
> directly return 0 and not excecute freq_qos_apply(), in which will refresh
> frequency. So the frequency will stay on base.

-- 
viresh

