Return-Path: <linux-pm+bounces-8401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335EA8D450D
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 07:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650E91C22482
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 05:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B1A142E8F;
	Thu, 30 May 2024 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXMmBblu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05368139584
	for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048589; cv=none; b=r7M0ZCurVL/mPxd8NTSSrb+p5apT9oPIOlCa1WX/bj2VzaMTBXawvHxivLmXnWtjl0q1JhqgPssLSlAaeY6u8HLEXEAsTzXfW/GWTDoL4D4g8HGwBT8LCqmCO8yDuAae05QE+UUBuoo1Tp7soMGS097nXMuYJw7uM9VjAPJM8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048589; c=relaxed/simple;
	bh=0KUB5FxRUV2MT0U7Be8ZwRXORw110A7ia+XITG3Rdtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTLYUTk/AxQYl8yQQ08By2CK6LpJIfeUoSuiknTQGWwHGfxqz77xaXsfgoLulRoDicrYNf9Vo7IYJrxoJBS/dP7t8sM5wMRV0F5nkh6lHvu7mqlvKaSgYz3jqmtm5jg72hfWebN15XXUYiAN41IU9iWFCPL+eLPUUWpedUcF+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXMmBblu; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e8e7b01257so19115739f.3
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 22:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717048587; x=1717653387; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cajcfr5PrZRSpJanDJb+clIAFAXBRHtzTBtQ23Shils=;
        b=mXMmBbluFN5HakirfGTEmiRCj2K0hhcS8S8Z9Crkr3uOnXr5ZLj+aukxZyALgg8wu+
         iNpAhSPdzR65DVZZ5c4Q/f5HTdtsYUoeJvDcQ6Bzz0rf7fsc40AfyJooAIYywD62ePYi
         TSyk67HmSUhFg1Fr5prQpt+gwInCRE3eTxTIhqXPVGFz7ZbNJwa11HqlE/1H75eS3Iog
         Q0IbPTKdM3qgR9+D22oppuMDx/juCMOq5myoWih3LkDMHyr46la0KmV28Qh5lAtGDSxU
         8ANiQHxzphf8/u1DYoZQWRU1gPtoJjbmSpurGx/iFiNS08fvJjMtVF9SSb+/WVpx7rXc
         /OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717048587; x=1717653387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cajcfr5PrZRSpJanDJb+clIAFAXBRHtzTBtQ23Shils=;
        b=SZuNrBD7nMiSfulAfJ9oHhrtFfPOTOiwc9IPPL/wAedS8Y31Vnjth+I4LYU/BDJPOm
         PpCumRtpgw9Ssoz8Hhhs9GhrNqPIuWoldfTtSRGgLEpHfN9QEC4i4Dqw327ALMU1J+HR
         QuV27PuEz/Ggkcm/bhhP7yXk0njUY+Xj5nvctcsXG9fw2yyBMeaw4bmTEz8RdVVEWDGF
         w6lna9SRFceOWfMZkplaFq6TFCtHA8vgznNad5YhMZE/CFJEv3hO4BUI+TE22Dm8hVEs
         cMg8DlJJqKlMu3pstwhnjnnvo1MzvIr1jCTbIVQDAq22aL09Z6qmlaYydzEu01WaGKZW
         SekQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG1UE/b483Pg0G0BG8S3XPbK2Rh9MQl24tzkB9/NGP8sqMuzE9brDUfxiXkaUcpuRKcc3LqqdazBH+o5umNlMU7T7rCoDPTNs=
X-Gm-Message-State: AOJu0Ywz4J1keNd8WxkzrX2wXd+n3uhXOybzgsHthSW/VNA0j+4du783
	GNyK/FrpWSngJ6dgg+FLPCQdBASLrZfPjzNMwxUopCL7QtAa1ublLtZ/KtMPwFdmCmuKlf1dC6J
	u
X-Google-Smtp-Source: AGHT+IEu+KIwSjxuXqz/UAw/2UabJCUDf4DzNrnC8Wlxs76hbkdgnteozLo8XFIQBj/19hswGK+YAw==
X-Received: by 2002:a05:6e02:1448:b0:374:773d:96f2 with SMTP id e9e14a558f8ab-3747df6fe90mr11693605ab.14.1717048586933;
        Wed, 29 May 2024 22:56:26 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6849756f31fsm9657632a12.7.2024.05.29.22.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:56:26 -0700 (PDT)
Date: Thu, 30 May 2024 11:26:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Hoan Tran <hotran@apm.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] cpufreq/cppc: Take policy->cur into judge when set
 target
Message-ID: <20240530055624.quutkzdd44l3oevc@vireshk-i7>
References: <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529053652.pzcjoyor7i23qc4i@vireshk-i7>
 <TYCP286MB248669BCAD7A7E54C5071EF9B1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529071244.vwognqagaa4347dm@vireshk-i7>
 <TYCP286MB2486B1D734F8E2D74BFBEEB1B1F32@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCP286MB2486B1D734F8E2D74BFBEEB1B1F32@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>

Cc'ing few more people.

On 30-05-24, 09:06, Riwen Lu wrote:
> 在 2024/5/29 15:12, Viresh Kumar 写道:
> > On 29-05-24, 14:53, Riwen Lu wrote:
> > > Yes, you are right， I didn't think it through. In this circumstance, the
> > > policy->cur is the highest frequency, desired_perf converted from
> > > target_freq is the same with cpu_data->perf_ctrls.desired_perf which
> > > shouldn't.
> > 
> > Please investigate more and see where the real problem is.
> > 
> The boot CPU's frequency would be configured to the highest perf when
> powered on from S3 even though the policy governor is powersave.
> 
> In cpufreq resume process, the booting CPU's new_freq obtained via .get() is
> the highest frequency, while the policy->cur and
> cpu->perf_ctrls.desired_perf are in the lowest level(powersave governor).
> Causing the warning: "CPU frequency out of sync:", and set policy->cur to
> new_freq. Then the governor->limits() calls cppc_cpufreq_set_target() to
> configures the CPU frequency and returns directly because the desired_perf
> converted from target_freq and cpu->perf_ctrls.desired_perf are the same and
> both are the lowest_perf.
> 
> The problem is that the cpu->perf_ctrls.desired_perf is the lowest_perf but
> it should be the highest_perf.
> 
> In my opinion, desired_perf and cpu->perf_ctrls.desired_perf represent the
> target_freq and policy->cur respectively. Since target_freq and policy->cur
> have been compared in __cpufreq_driver_target(), there's no need to compare
> desired_perf and cpu->perf_ctrls.desired_perf again in
> cppc_cpufreq_set_target().
> So, maybe we can remove the following logic in cppc_cpufreq_set_target().
> /* Return if it is exactly the same perf */
> if (desired_perf == cpu_data->perf_ctrls.desired_perf)
> 	return ret;

This is what I was thinking as well yesterday.

-- 
viresh

