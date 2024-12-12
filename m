Return-Path: <linux-pm+bounces-19081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E6E9EDD83
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 03:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87980283940
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 02:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B4126C17;
	Thu, 12 Dec 2024 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VHbPmrX3"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4B3F9D2;
	Thu, 12 Dec 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969841; cv=none; b=YO7afH1UXtKO9EhVTP0MFBLOQEyGWoKKgYy0zS5FqrllHaBIt/DH9ADyQU7mRUmhD9grb4rJuGz0Yh5lKJLyf5/bNcd0Hg7nBZGMnb7jC79W3UCmmCqnqk7SGqG0u+ZYuTJU68gN8QSHuT+oVBVln03whPl6XSsZGAfzXW6FBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969841; c=relaxed/simple;
	bh=LEPNFYP7EYPloBVAVbgMf5tdwV2VmtSkK9pdu8Hhjg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ql8Pe/HO5lPtKUzxY+04hIAKMnG0TuOy44/eyvwu2/pCVvLBwawBd54XdmwZf/EPcVeGjw4ce6oQzt8rBHf0uw89kKsHapD20hHLepAWgmvmZSZjWIdBdphliNUdHiTkS+yLL+pohNyQZAO9z4SBvO41j0XotqN3ZbCHb3sgtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VHbPmrX3; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733969831; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RHl2zonSRRgA7E6sA2xDM79Swj9CSqWpiDyjzI1zzIc=;
	b=VHbPmrX3YCMomMe6OR38r8++FOjGJDLtY5lTmoOthV5stB6kZjMcqKBHJ7VVoj4cx+IJxqPWK0Ha37ycuDeH3Pu9zCyHIxQrbLwSyl7yxs5wcL2UVCZ7wDD8TdcajthIHx4OH4BVwtdZPXkuvWuyGih24eAc/IZSwFg8B7+EfGY=
Received: from 30.221.97.226(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0WLK-nJx_1733969829 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 10:17:10 +0800
Message-ID: <20783138-2bfa-45f9-8127-5a55c1741613@linux.alibaba.com>
Date: Thu, 12 Dec 2024 10:17:10 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: fix TSC MHz calculation for Mperf monitor
To: Shuah Khan <skhan@linuxfoundation.org>, trenn@suse.com, shuah@kernel.org,
 jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org
References: <60562222-6186-4eec-9c20-08b1cebb1311@linux.alibaba.com>
 <0985bb0c-091e-4e5a-b066-5b9cfd072aa8@linuxfoundation.org>
From: He Rongguang <herongguang@linux.alibaba.com>
In-Reply-To: <0985bb0c-091e-4e5a-b066-5b9cfd072aa8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2024/12/12 4:54, Shuah Khan 写道:
> 
> Are you sure you sent me the right patch. I am seeing exact
> same errors. How are you sending your patches.
> 
> Here are the problems I am seeing:
> 
> ERROR: patch seems to be corrupt (line wrapped?)
> #103: FILE: :173:
> double *percent,
> 
> WARNING: It's generally not useful to have the filename in the file
> #108: FILE: :177:
> +        timediff = max_frequency * timespec_diff_us(time_start[cpu],
> 
> WARNING: It's generally not useful to have the filename in the file
> #119: FILE: :210:
> +        time_diff = timespec_diff_us(time_start[cpu], time_end[cpu]);
> 
> WARNING: It's generally not useful to have the filename in the file
> #130: FILE: :230:
> +        clock_gettime(CLOCK_REALTIME, &time_start[cpu]);
> 
> WARNING: It's generally not useful to have the filename in the file
> #138: FILE: :245:
> +        clock_gettime(CLOCK_REALTIME, &time_end[cpu]);
> 
> WARNING: It's generally not useful to have the filename in the file
> #149: FILE: :351:
> +    time_start = calloc(cpu_count, sizeof(struct timespec));
> 
> WARNING: It's generally not useful to have the filename in the file
> #150: FILE: :352:
> +    time_end = calloc(cpu_count, sizeof(struct timespec));
> 
> WARNING: It's generally not useful to have the filename in the file
> #158: FILE: :365:
> +    free(time_start);
> 
> WARNING: It's generally not useful to have the filename in the file
> #159: FILE: :366:
> +    free(time_end);
> 
> thanks,
> -- Shuah

I am very sorry, it's thunderbird auto wrap my patch, sent a v3, currently seems ok:

$ ./scripts/checkpatch.pl test.patch
total: 0 errors, 0 warnings, 60 lines checked

test.patch has no obvious style problems and is ready for submission.


