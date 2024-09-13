Return-Path: <linux-pm+bounces-14192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B5978627
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 18:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896EFB252A3
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35FE6F31E;
	Fri, 13 Sep 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T0pWkR+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE402D052
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246125; cv=none; b=AY+IanwoOD3MwG27e51PDwMi6G4Ut2k2Li2lwn/+KUzGzi3+2mDrNxtKP9nUGwDFjFkwtxymgzanQFZJwLPH/n+WKIyh0Z9RbGLW3PEWlzstj5IWphpqqejBE+Co96XtDicLwbrDZ5ZG2qDYNKHMfr1buo6RF0gbs++EnyWFsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246125; c=relaxed/simple;
	bh=+zTJgyJqVywynjJkOZsN8T6rAAR9NXuTLXz50LOECkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnqV6xCRLJD8yUly+IM3EHSDz9DfWDz+MzdW4Vu9KjDq47VU0NE7sX9lfQTXxVFUY1O/h1GSVv8s6qJ/HiAwwdehaX0AW/WA/xrLMBkRGYyYW3uGjyR7lIikvW6hMowAAEUqFf1MzcfRoyHVGXRC6zXp5s+C8YY6EKqbwOINL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T0pWkR+K; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82aa93774ceso117256739f.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726246123; x=1726850923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReW0m/5Yz+FZyKQtEYV/Kkq1KJtzSn0264yh0o5bURQ=;
        b=T0pWkR+Kzvnd996RLEm2g5NqDbJPJKqQcwkCxXwanIA/2lIXEj1VQe/Cjw1UxrA11G
         hvNtWDWi/tFpTtwrVpi9IpDB/ullwGvyyS5Fw6Pwe1JQxUC3INar2o4m0pgEBAMiOpAv
         UcHrb9LJ2JOM1RGlXze9CujAKeFEF44J0f5LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726246123; x=1726850923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReW0m/5Yz+FZyKQtEYV/Kkq1KJtzSn0264yh0o5bURQ=;
        b=erOcvo5gc0AObcB8kfYSnc9hu1w/B0OgfzF9LLAYZj1D0XNf2e5p3VCPAU03t0gDMG
         iPYE3fi9iXs/Os5YCz6wagYEyPjvQSijJdVP+HLRD/N13KPUS1NsE9v9a0VgcLrwLCpC
         U2xq+fGh7Y4iMQe/l5HY2WzBAWd5IjYp85/r4ZBuLVy2ltoYCA5I6zlfoX1up6IwcaSN
         91L+I63EL7c6nhi2VL2GxuX4wUKz32wWyuqQVRrRs2i0RejzERUF3hkc1+5y3phCBpbe
         qs233D72abDjsEoD4zvlddeLIn2HirmszTtVIXw3/VDjevMpoLCInUOXOX2FHlwZCauR
         0wiw==
X-Forwarded-Encrypted: i=1; AJvYcCUevL5acwklBFLVarxMFeA/hvEZ9tG9As/92bLa1E61mzpSIRDMCSD9aZkNNCxrg2FBvJWr/aQ0yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtaALjEYZ4lAyYQTWmz7vvqhmD5jfkSgw73Y5mlri4L41MZ3MK
	YID1pchwZG+RZTiPhggfxQrcRd1uXcQp9mixoLx7TyXN9p+BRXgbPv33xq9ByyY=
X-Google-Smtp-Source: AGHT+IG0iy0TYcrdtAOxYoAi8QT+bUWCRbCq1fB9g7J/Slnos62IyzhRK2xzaUZk4I0W397+VIw0QA==
X-Received: by 2002:a05:6e02:1b07:b0:3a0:4df8:1054 with SMTP id e9e14a558f8ab-3a08494ab1cmr72801895ab.25.1726246123109;
        Fri, 13 Sep 2024 09:48:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0590160dbsm38719405ab.80.2024.09.13.09.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 09:48:42 -0700 (PDT)
Message-ID: <e35af04e-a8ee-42e2-a2e0-c369a118044b@linuxfoundation.org>
Date: Fri, 13 Sep 2024 10:48:41 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-next] pm: cpupower: rename raw_pylibcpupower.i
To: "John B. Wyatt IV" <jwyatt@redhat.com>,
 Min-Hua Chen <minhuadotchen@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>, "John B . Wyatt IV"
 <sageofredondo@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912230102.157534-1-minhuadotchen@gmail.com>
 <ZuRqkbJixRQEScYA@rhfedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZuRqkbJixRQEScYA@rhfedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 10:38, John B. Wyatt IV wrote:
> On Fri, Sep 13, 2024 at 07:01:00AM +0800, Min-Hua Chen wrote:
> 
>> To fix it, rename raw_pylibcpupower.i to raw_pylibcpupower.if.
> 
> Would you please rename this to .swg instead?
> 
> '''
> 5.1.1 Input format
> 
> As input, SWIG expects a file containing ISO C/C++ declarations and special
> SWIG directives. More often than not, this is a special SWIG interface file
> which is usually denoted with a special .i or .swg suffix.
> '''
> 
> https://www.swig.org/Doc4.2/SWIG.html
> 
> I tested it and .swg is not removed by 'make clean' or 'make mrproper'.

That is expected.

.i extension is used for a C pre-processor out, hence the need to
mrprpoer and clean remove it. Because of that reason, using .i
will not work for swig interface files.

We build files to debug problems and to check the pre-processor
output. So changing mrproper and cleans to not remove .i would
leave the tree dirty.

This is the reason why I wanted to understand the problem to come up
with a solutions than renaming the file with .if extension.

Please add this information to the changelog so it is clear that
.i extenion will not work for swig files that get added to kernel repos.

> 
> My apologies for the extra work Min-Hua. I can send a quick patch
> instead if you wish.
> 

+1 - Yes please send me the patch with renaming it with .swg extension.

thanks,
-- Shuah

