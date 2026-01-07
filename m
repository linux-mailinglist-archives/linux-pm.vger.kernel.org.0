Return-Path: <linux-pm+bounces-40347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867DCFC0A8
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 06:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F18D30034B2
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 05:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBEB24BBF0;
	Wed,  7 Jan 2026 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1D1OOHl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3A225402
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767762512; cv=none; b=dzDVdIKSkwrA/2tkejCv0Or09Mp4eqigJxrJ+niHRlXZWr50Ifu+K//kbCNNAvUKR/4bPYajTLSWIOx2gexZMTGbR4ubstCeKyel6RXLd9GvkhGVdD6wBae8z1TDQww+nCan/5wo9Vn9AVBYjsHsM4lcuWyOgvfOiV1dv5+kfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767762512; c=relaxed/simple;
	bh=88qWZTn2mDcOSNE2vdWtCzUL/UvAo0squ4kmcbicKoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsMFxk6iFuBcs75fbwKlxqDe3GcCpCC623oNPcC5LgyaZ7c5URCL46B/6ICiV9e54M+0mOkQVz6HEzNgcLYJjNWlrFVG/psd2cgUXWi6ZW/Uq2On4LUNBcZoIhB7sgD3q91XDPIB75INe0mRi2odUjMq8MVzJmTRxRpnodBS/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G1D1OOHl; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a1388cdac3so12724175ad.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 21:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767762510; x=1768367310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=at4X6VqEFh529Zi30zW8MQksBOuqXFLRVDa3Tf7QCho=;
        b=G1D1OOHlZz76SzXVpIL3ZRVil7QTRpPl7hdzPl04xbVGt+b2Isk5E0yiu3rSGSo/qt
         MaZbYDHvBJeUflwfIaM2/BYRlnRVTdrqbXPTgBbPAxZvXFNPDSKl4tAovWSjxH3yjNQH
         TdHO6xAREnvzcVM+iQASYz9+KiZIIYDs92dgCqC4FuP6bdtAkrwg2LmctuoBPPt4Pc/E
         Pi3CoE2uzUWVFrQuodPlhv/F1KPwSQOYw/yeOz6squJ3g4HXk8zrz6DxmOAb2ziw8CS8
         fkNYovyy48c0p0n63xZe0iSRRaNAQWuC5x7JDS3EqOENUxK+a5bHFWNN0Ck/vnHHKc7n
         IwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767762510; x=1768367310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=at4X6VqEFh529Zi30zW8MQksBOuqXFLRVDa3Tf7QCho=;
        b=od8wXz+VWheT/3lAAP+oJjcw5OOjbNz1nj3CN2Zn9hzgB71l9btbHcYtcaHGs0hXhB
         HOhGMwtT+q3ZqRRmjbXu8ztpfkMFhNJR9sgdh+zR3sVUbI9uTQOG6UYu7TEhWdLW/8AO
         9i36T/xPPJjYWDEmX9xAfyswf82Bi/11BVdiAlXCnLnkh9LiSxYCTM8X4MZrqTo6pOPY
         Hh5mx0qmBpevPl0RSOuJDh9rY0a6nW62ps1W6r43j/Fc1j3wUigJ7SmN9p9RgpnyrdaS
         MF9K4zLjPoRx4gVM1UB4fEZ6b6Cp7gmc8KRtOyp+oebOYpPc3UoGUCgUj3QYRv/CDCW8
         lP2w==
X-Forwarded-Encrypted: i=1; AJvYcCU7mriuQtL426ljR9RS8QnvTT52kJEZA1VLa41V+kNSJr0fOXuECdldTzeuRYTg/ySD3MqfAgyonQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzph3MPYuD+KtP96b1QM88GK4Ehkrh/PuGTYon6XQIyom8zTX0Z
	tKQtH8wT/vX3VwhQFTWC1q57ukhdg1TGeLinKT16YiydvfYGv7qeGyN1mbKYb5OcXY8=
X-Gm-Gg: AY/fxX41+x4AdXFEEuF+ijobGlvea2JSjWM2ntf0aMd+TSt47uhktkipI/Rm1ZqSMLd
	ROpvhv6Z5Ua3dXVANztoE3wzywaXn/1O9shWI9sxqaVXENWVcsypY9h8OsnwVBBddM/bpR/oXbH
	Y44UjsDfMui1FEqniX5JWW1DLfoMyeje26mh3p2tlWr5Xj6ItTgooOoj2D22Cn26wBhTWWf3FPS
	R8X8mWkL8/4wbuJuB0U+nH/TBohivANLkQlqixXlCjEXTsH8e65BPsH4VCjgtFXIJlCsVhXMM9T
	od76GYkeVsn35qLMepK+fEPy/AUwj9zzWLeJJBchnNQaCkfG2pRM2pMj3mw9mxiGcrbDul7DhNj
	ecbffjYCy7sqi82hR7gNa133coIIgCmM7Hz/S8APe8Bg+R2fTVf/UlKA338VlQk/QZETJ+7n7zB
	nh8A/I1mKi4ZE=
X-Google-Smtp-Source: AGHT+IE6DIWAPI6xhj/dvOFpGf1N/JyjFHBr3QBR1usdNPYk3+KTAjPz87Md2+NySEM8eS1qf1OW+A==
X-Received: by 2002:a17:903:2341:b0:2a0:a09b:7b0 with SMTP id d9443c01a7336-2a3ee4c456amr10088815ad.61.1767762510009;
        Tue, 06 Jan 2026 21:08:30 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a560sm36452645ad.21.2026.01.06.21.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 21:08:29 -0800 (PST)
Date: Wed, 7 Jan 2026 10:38:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Perry Yuan <perry.yuan@amd.com>
Subject: Re: [RFC PATCH 0/2] cpufreq/amd-pstate: Prevent scheduling when
 atomic on PREEMPT_RT
Message-ID: <oeyvz6463yujz63q4ijqsoobvaudtjymrokgb7jesa537vi7ds@jx5c6bgokwx7>
References: <20260106073608.278644-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106073608.278644-1-kprateek.nayak@amd.com>

On 06-01-26, 07:36, K Prateek Nayak wrote:
> Bert reported hitting "BUG: scheduling while atomic" when running
> amd-pstate-ut on a PREEMPT_RT kernel [1].
> 
> Since reader-writer locks turn sleepable on PREEMPT_RT, they are not
> suitable to be used in the scheduler hot-path under rq_lock to grab the
> cpufreq policy object.
> 
> Unfortunately, the amd-pstate driver has a tight coupling between the
> cpufreq_policy object and the cpudata stored in it as the driver_data.
> 
> Trying to grab a read reference on PREEMPT_RT can cause "scheduling
> while atomic" if a concurrent writer is active, and trying to grab a
> nested reference in presence of a writer can cause a deadlock (manifests
> as lockup) since the reader fast-path is disabled on PREEMPT_RT to
> prevent write-side starvation.
> 
> The two patches included removes cases of grabbing a nested read
> reference to the cpufreq policy in amd-pstate, and modifies the
> cpufreq_driver->adjust_perf() callback to take the raw policy reference
> cached by the schedutil governor respectively.
> 
> The policy object outlives the governor and the driver making it safe to
> use this cache reference from the sugov data. Any changes to the policy
> will end up calling cpufreq_driver->set_policy() or
> governor->set_limits() once the policy is modified which should ensure
> eventual consistency despite not holding the read-side.
> 
> Series has been tested with amd-pstate-ut on PREEMPT_RT kernel which
> successfully passes without any splats on LOCKDEP + DEBUG_ATOMIC_SLEEP
> config. Additionally, the driver switch test from Gautham [2] was run
> for 10min on the same config without observing any splats.
> 
> [1] https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/
> [2] https://lore.kernel.org/all/aJRN2wMLAnhDFykv@BLRRASHENOY1.amd.com/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

