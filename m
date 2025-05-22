Return-Path: <linux-pm+bounces-27508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15188AC0A6C
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 13:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF25B173A60
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCC1231859;
	Thu, 22 May 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Kd1sci"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EEC221F0A;
	Thu, 22 May 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912537; cv=none; b=ZIx/BFlTaNaTe6VxkC58Rh+t0WUxJir2NzCRhxPsX5dbz4OWEN4wv/DhB6Xoj8QyjhKywsE6ct/rrdo1TdxeYOWel7VpMgx9d3og/6GAnfvMkPhnisHzQ1vcwoeOKsHnR/9NJkwTm3IJZQkHHbkbNaQHRACcGWUjRNskfbQmAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912537; c=relaxed/simple;
	bh=ebDvpO1OwZKUNS75vF6+7bj47Ss2QdeMnQQ7n4rYyuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4q1ZS/mScPT6QREQv6jnChH7sNJx7erW/kuWJk8KwsGZJC7pUyu7ipgEU6Sraiok6xRJ3I+uQJUzT9gl4SbSrQ619wcXkDONQqydTZVzek5ooZ7qYN/wr5HX6XWUYKWc5dS8rrT4vKVAttw3ppKJ3bWvD30xD+mp4jXm991jiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Kd1sci; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8c53aeedbso110985416d6.2;
        Thu, 22 May 2025 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747912535; x=1748517335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruiAoqc5x+2/FUk28JhfABxTDDi+jme412UvmRvsGUA=;
        b=g2Kd1sciXmks+mgRV/pfWhQMQyqX5ND98UJ4L2cbKSudrJsW9xB/p2+VN8mnlv5Bws
         ARJLbN9FWJm6l4PUpReg3DBhXD9CKpRW89JpPG2MCGuHGWNr04fBQQC0xBmHN7BvRvmK
         9vYVKwqpO2OAzJAjXFwGrjxE1HYvCyF89M2ALkr7//+bSO+z4RD14KDa3POjkn9/aiPa
         rpLJik8P1veV3lwD5bg5GcnEayIUpQChQxR45RFDYFD1t8BG3eXcZYVlQfTK00Sj3k8t
         Jn5GZyUEh2xJQJfQgGuZuUsJIETHNIoLwvq9ropTeHb2FfnktQ+sXjZHetj0lKRYpgZ/
         xHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747912535; x=1748517335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruiAoqc5x+2/FUk28JhfABxTDDi+jme412UvmRvsGUA=;
        b=qM4imJT5S6JuO7dpuIv3j7WGHao73sfqFAcwdbqnNwPnGLsrAv5CZgPHcnCaLA18/C
         kiS+CwDpHpPK9JuLGkTdCOf136+/xYQKZivhhQY8tXClsIj9h4QJQZKg8XHmbp/MNl84
         9xcyuru2F7fNidDSLEmjV1ne144PNSNHfrT2qdqYZA+Ar0lD+h8K39TtfVP8HT/wyzqi
         j9vMIX9dvkZW97F4LzjT9gcTHWcLmKixRmcZDYEkqhEjzYDI6w+mzZIGyteEyE8LI4x/
         cjvgX4rvb1nH4yOetKPeU+NYaT1WNZvYDWW62MCOOYzfjcWZcMtaWoGCD8wzCzePuE2M
         cQkA==
X-Forwarded-Encrypted: i=1; AJvYcCUJp+cWBpmXPrp5154f8QXInPNHgSZJsl803PGdInFInaAyKtTTAzQqIIMvwaZ5SoMyAi4EicAcZNQ=@vger.kernel.org, AJvYcCVWusVCOb2UxBz6BmR4f6dqwmgqzW0gpjZsBdwoq6zaFN7jJfon60PIAcrbKf3vKKeZFeUaN0t8Qe8=@vger.kernel.org, AJvYcCXizqsa20+tJCUYMM4Jv7QzFtk7rSjGsj7k9KIphKh2qbi8PU1iXXUKdJ0tGcyeHZl6KsyT13UYDdx686Cf@vger.kernel.org
X-Gm-Message-State: AOJu0YxVD4FKl0FRQU5+biImGucqD9UX401eKqrGF8CDxKt6i+dmWOTc
	LWmyENgXwzWEibaY3WlH2lgS8GtP5A+exV55xLXXcnRDTNj3fssECuHj
X-Gm-Gg: ASbGncteLNwfMNg143NDDuEy//STbOI5zvPuYifsWncH1GuUVyzR8p5C4TgzuVKLz8B
	8WU1PvUEdZ7OTxJH5zvb6kYp5e0Qnou9yg9PqGrgTKNmbVngEPYe4jeODx+VuKfnCpHFut8Zbc6
	B0hLszFfn/wxk14Rq0y4AJil2u3WUjwxvt8oUq23jaXFVvCS9AV7JXUa/8Ew3v9ez6k9KLHraF4
	0H4yA/EnzVDA5Yr+Zq6NBVXvxa0+4DDlBdWcVDAmpMeF211U/BcrOY7Q2MJVz1/nFw7WOA11aDM
	DzuRYisDQLVJwZqXvC43tvRlvDb2Oc+NG97t5BfdP0Y9oO1tqQxzq2xFBOLleYE8Cr8=
X-Google-Smtp-Source: AGHT+IETHQOvQBgH6nIedb4pwNDnjs6C8JqC3hD4bVE8Zvo1pWISsIt/wBo148kg00t9t5mrY1pdDA==
X-Received: by 2002:a05:6214:20ec:b0:6f8:e52:ef81 with SMTP id 6a1803df08f44-6f8b2d2e23emr421101566d6.36.1747912535137;
        Thu, 22 May 2025 04:15:35 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6f8b08ac4bcsm97291486d6.40.2025.05.22.04.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 04:15:34 -0700 (PDT)
Message-ID: <8c9fc3d2-991d-4caa-8773-418bea0fdf21@gmail.com>
Date: Thu, 22 May 2025 06:15:32 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>
 <aC7yeQvKVQ1No9EW@JPC00244420>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <aC7yeQvKVQ1No9EW@JPC00244420>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/25 4:46 AM, Shashank Balaji wrote:
> Hi Russell,
> 
> If intel_pstate is left in "active" mode, then userspace can't use any
> of the other governors. Moreover, intel_pstate's min and max frequencies
> apply to all the cpus. Whereas, the userspace governor can be set on a
> per-cpu basis.

If setting frequencies on a per-CPU basis is how you discovered this,
you may find it to be a source of more automagic. There are a lot of
client processors that cannot (usefully) have different frequency
targets for each CPU, because there is only one voltage regulator. In
that case, slowing any CPU down would only harm its performance (and
efficiency, because race-to-sleep). So, the global frequency target is
taken as the maximum of the per-CPU targets.

Cheers,
Russell


