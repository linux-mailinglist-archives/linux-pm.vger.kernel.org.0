Return-Path: <linux-pm+bounces-14994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B99198B4C8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 08:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DC61F219BC
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96E61BD016;
	Tue,  1 Oct 2024 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iqfkntfk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282E1BC9F8
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765036; cv=none; b=PNNaxKzDE1/rsdm7T2xBbqRprAmWNbdiVpYOub0kDcG4vR3kTBURcsWyt+UWdZR4NWe5RXYV4gtJ2nhqjDNq1fvq4EPqK3yq/DT2hN6U7WidrlpaAaHO46yc5u2tUL62WLGoI7toTYPEBtFG7dNFOILMRaLHuyZHei709P+R7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765036; c=relaxed/simple;
	bh=SXzSKD8jJ2iXEdYuKRsGqR7JGqJhWk9AWaqO3Qj04L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeGnSBTcCAeCDHhOm+E3zGx8QBdFGsf2CA5ab0IHeMtjN3HYqDXgWkd8QTtTYIP+LnlUX08y1ak7ND21dOE3cKiwGlo8/7G5HbPtw2VFfJco2WZBq/RRanlwf2S5Fw9fO9nAbwkT9XcO1wTx/iNHMOQ4bDCNimTT7AIFau8jFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iqfkntfk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71798a15ce5so4697072b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727765034; x=1728369834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+9r8/ELl7iDlCWa/yccfFSqcqOg6/F/KEEgCukawR0=;
        b=Iqfkntfk8jCHPUFL7ICF4g1ivBQW9NzIanlJIEsde8ZD9nmnPtoQyyq4CNhHOnIRqL
         TS+IsOWdLci1dLkSo+w9sSI5tnaUlvjgRXwuOKeiFFiLO2GC2+KEZn3qfD+B4nuGAQ1u
         U428j4nJbLcgCkYv9q7+0nF6k2fA8iievTuHmtZWt4JJ0H3TT4fnUtA5zxpdJzmw6z3m
         AGy79r9bTxF4rBmq4aqxqpyIGJBZUhxsCb7XX2yIIWYbyuXqLJulH2al3S0ZB6F4oBNM
         HllkCtdCoTyRY1xad1APmSedoyJC7rS1TKg45qmv3hGiMAi+AlzfkHHWakIac1Q3QFGL
         Igzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727765034; x=1728369834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+9r8/ELl7iDlCWa/yccfFSqcqOg6/F/KEEgCukawR0=;
        b=jVx8d2LAbo9IOQEh6Uhfm1zr6l43r62AbalocGihVNSvkJhKsh1wEVtBFOWFqi2ouT
         IRGottKVBISx+PmFpbOoYBuRvgdpAv/1405+42LlbZ3R6eskaw7aB9R1535TNyGu6xrl
         yBOoyVFfx0v/6ujgwjMu6dF6QdBbYkGwKUSfDG/vzVRgHAoIkTPE7AkxkRrdGpfu3Elj
         RRzDUzlMklsSowdscxeoud2TgqEwBPC3IgB+pIgnOoF3zpbx++U9Jt6RU0bcBkkej9op
         cc3va5aH7sve022y5Mg9BjsaQoEviMOBATcBJAnwbcvyklDLzpYPMA/FxH8i5QcfuUU+
         3FsA==
X-Forwarded-Encrypted: i=1; AJvYcCWVAweoFy4Pj0csmikKsrLYNGNBm3Eb40OfgCEojy974v9znd1VpxUVXIoQcE05NI7G2UZIdMqbVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4NCaS9n2pbrcPSvjeX4bBNwz2FL787G/87I6O8eHQC0/CSat
	EXROXhtRhEa+I8jZ1bKuMkKPBxomhr0eSVnKrsAPmca+Ko+ZrKxVCF9/v7RngrM=
X-Google-Smtp-Source: AGHT+IGo9nDsPPgqeOWUQkdQH/9wmb+SBZj3pDfJ3l1Mq6Sz6MV6DgwxCFnauB+HR6NC6KCwCRh9/w==
X-Received: by 2002:a05:6a20:2584:b0:1ce:d403:612d with SMTP id adf61e73a8af0-1d52d10a3f4mr3324373637.13.1727765034276;
        Mon, 30 Sep 2024 23:43:54 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2963dasm7613444a12.2.2024.09.30.23.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:43:53 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:13:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mark Tseng <chun-jen.tseng@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 2/2] cpufreq: mediatek: Fixed cpufreq has 2 policy
 will cause concurrency
Message-ID: <20241001064351.vpahvdwzmvjblnd7@vireshk-i7>
References: <20240913103933.30895-1-chun-jen.tseng@mediatek.com>
 <20240913103933.30895-3-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913103933.30895-3-chun-jen.tseng@mediatek.com>

On 13-09-24, 18:39, Mark Tseng wrote:
> mtk_cpufreq_set_target() is re-enter function but the mutex lock decalre
> in mtk_cpu_dvfs_info structure for each policy. It should change to
> global variable for critical session avoid policy get wrong OPP.

I am not sure I understood the problem well. Can you explain clearly
why the current locking doesn't work with details call chain ?

It is normally okay to have per-policy locks otherwise. Are there any
common resources being used between policies that need locking ?

> SoC with CCI architecture should set transition_delay to 10 ms
> because cpufreq need to call devfreq notifier in async mode. if delay
> less than 10ms may get wrong OPP-level in CCI driver.
> 
> Add CPUFREQ_ASYNC_NOTIFICATION flages for cpufreq policy because some of
> process will get CPU frequency by cpufreq sysfs node. It may get wrong
> frequency then call cpufreq_out_of_sync() to fixed frequency.

Don't do so much in a single commit. Separate commits for each logical
change so they can be reviewed well. Also don't send cpufreq along
with devfreq changes, unless they are dependent on each other.

-- 
viresh

