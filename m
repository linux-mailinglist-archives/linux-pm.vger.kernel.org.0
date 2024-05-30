Return-Path: <linux-pm+bounces-8403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2D8D4562
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DEA2847F6
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2D14373F;
	Thu, 30 May 2024 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r53BVgUU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE5CA4E
	for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717049786; cv=none; b=rrRf8nK6+z+NQPoK5aO8LDtETshAwXXv2OVp+5NwDOYVz7jelDfIxDA9Ab2AjZX9WqmzkYq0j1b1uH3o91C6HnrQ3/yTwKvWUWymu4jKvFhSsv9/YHr6aPoT41Mtlj9YG88qvbtsHvr0Y60GeLcZA5tLGPwA6sX1l7gndpr6kPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717049786; c=relaxed/simple;
	bh=cJlNRabZ63c4rwDvW/6pW/RB3/AqAq1C0anVNyFoUqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th2v8Rj0Y/w9gnRQS3k84AQineq4DayCFXon7vGqRhybzAnEnjvdPY+3J/T1lbHDXLNg/aE1oZoQMvbNK2wb/indvhn28AWjqtxbx37salYzJgVcUtft4u8PPZ8/Yf3z43oXFtERZbwR+zI4P30q8GNjZQgTsiN/KLoXMLu1L0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r53BVgUU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2bf629ff55bso395390a91.1
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717049784; x=1717654584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9x8sXCDajpYUsltQRGScSRDo95HG23BSUbceELtrjcw=;
        b=r53BVgUUpHkQIk0DeEAoAWZLDKKsIBUdpcSjQCEQdbgcdb137UipjVLQc11U3dtZDO
         7BrOGf+EHAPQjEu00Yow6w48yq8XI67/AGTJIfPJiLDDcVzlzn2XBMNpWYLaDTJEVMuU
         +BdgvdhujYCy5Bpta2rw2OvHcOf+cJNR6CyRBJ4FGbElxiif/9NT2LEr//FFxxqyqp9V
         qCuyj1vxEt3Odg/y1U0cdan3c3qNTm0/NZP7HehTTfI9UlEv0gKcfvVU2OPSoPMT9f8g
         RzDwLdnNp22l3TryPj/sJk3bSTpXE6jJ4+hNpx9vdSQ3NSE5s6ulUKVby9ifssKBlYTj
         d4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717049784; x=1717654584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x8sXCDajpYUsltQRGScSRDo95HG23BSUbceELtrjcw=;
        b=f/+h/LQhLTZOKxznfqP7QUTYdmpRqEo7nLom8OiomRo4U7KSr69VDN0nOGlZubdG+v
         ax13CbIrbiNwiAiau3Jhbm9atIb6SFQwtivQT1h+iIy2Me70hnvDIdvZAjnCFeO2vD5/
         c3x3YMT201EGAlwT8BxQL5MUvIn+IO7mKkRO2gRB8Y//fp/gIEE3m3YIuNWYs/OfXWV2
         OjPoPBw2AFVDR4gpYzyBt4c9PdcKzVpIGSBuYZR3yEx2scNpC57UoNvebLZbldb9zV6C
         FW0JZNsv9247b4SkGR3YAwwmDG+nN9PO1U6hZuedftoEGHRQfoQLjBEYjdSdnyMYOie/
         UJSA==
X-Forwarded-Encrypted: i=1; AJvYcCU0OdLg4k6g/DnvOh0jucZmA4giWQOdHN/jO8x6CVr1qQb8ocFdt6J0s7zQh9FVKzK1nCjAVNTp9MsZ4yVBBqaUggBX80gU2x4=
X-Gm-Message-State: AOJu0Yxm0GsgQPGlbEX2yRtW3cmOUJxFHkrmH/Vzrf+Y/G4ZsT2BFX2p
	pMullUMoKnM1GYxPNO9lEIvhcCDLM5PiN9mUwDN7fHDblZwHbJhI85lFeMh8H8o=
X-Google-Smtp-Source: AGHT+IH6pbLwPJIs+k7aqwTxKi4mh3rtMT7+SWv2j5qj/8dKBkbaRat6jBUKRChGlBm8+KPJ5BBhcQ==
X-Received: by 2002:a17:90a:bb12:b0:2bf:ee29:1a64 with SMTP id 98e67ed59e1d1-2c1abc328d9mr1296620a91.23.1717049784218;
        Wed, 29 May 2024 23:16:24 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77afb24sm850173a91.46.2024.05.29.23.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 23:16:23 -0700 (PDT)
Date: Thu, 30 May 2024 11:46:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Hoan Tran <hotran@apm.com>, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] cpufreq/cppc: Take policy->cur into judge when set
 target
Message-ID: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
References: <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529053652.pzcjoyor7i23qc4i@vireshk-i7>
 <TYCP286MB248669BCAD7A7E54C5071EF9B1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529071244.vwognqagaa4347dm@vireshk-i7>
 <TYCP286MB2486B1D734F8E2D74BFBEEB1B1F32@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240530055624.quutkzdd44l3oevc@vireshk-i7>
 <TYCP286MB2486A0F14AE38F83F425F506B1F32@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCP286MB2486A0F14AE38F83F425F506B1F32@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>

On 30-05-24, 14:02, Riwen Lu wrote:
> 在 2024/5/30 13:56, Viresh Kumar 写道:
> > Cc'ing few more people.
> > 
> > On 30-05-24, 09:06, Riwen Lu wrote:
> > > 在 2024/5/29 15:12, Viresh Kumar 写道:
> > > > On 29-05-24, 14:53, Riwen Lu wrote:
> > > > > Yes, you are right， I didn't think it through. In this circumstance, the
> > > > > policy->cur is the highest frequency, desired_perf converted from
> > > > > target_freq is the same with cpu_data->perf_ctrls.desired_perf which
> > > > > shouldn't.
> > > > 
> > > > Please investigate more and see where the real problem is.
> > > > 
> > > The boot CPU's frequency would be configured to the highest perf when
> > > powered on from S3 even though the policy governor is powersave.
> > > 
> > > In cpufreq resume process, the booting CPU's new_freq obtained via .get() is
> > > the highest frequency, while the policy->cur and
> > > cpu->perf_ctrls.desired_perf are in the lowest level(powersave governor).
> > > Causing the warning: "CPU frequency out of sync:", and set policy->cur to
> > > new_freq. Then the governor->limits() calls cppc_cpufreq_set_target() to
> > > configures the CPU frequency and returns directly because the desired_perf
> > > converted from target_freq and cpu->perf_ctrls.desired_perf are the same and
> > > both are the lowest_perf.
> > > 
> > > The problem is that the cpu->perf_ctrls.desired_perf is the lowest_perf but
> > > it should be the highest_perf.
> > > 
> > > In my opinion, desired_perf and cpu->perf_ctrls.desired_perf represent the
> > > target_freq and policy->cur respectively. Since target_freq and policy->cur
> > > have been compared in __cpufreq_driver_target(), there's no need to compare
> > > desired_perf and cpu->perf_ctrls.desired_perf again in
> > > cppc_cpufreq_set_target().
> > > So, maybe we can remove the following logic in cppc_cpufreq_set_target().
> > > /* Return if it is exactly the same perf */
> > > if (desired_perf == cpu_data->perf_ctrls.desired_perf)
> > > 	return ret;
> > 
> > This is what I was thinking as well yesterday.
> > 
> OK, I'll push a V3 patch.

Please CC everyone from this email.

-- 
viresh

