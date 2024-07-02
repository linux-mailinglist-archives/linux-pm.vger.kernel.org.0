Return-Path: <linux-pm+bounces-10362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C05D9243AE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 18:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56A5B22B66
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E8C1BE221;
	Tue,  2 Jul 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efdt5UHI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D71BC094;
	Tue,  2 Jul 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938275; cv=none; b=bZqYd5Ebb5MIYUVPD387PC9AyURpcCwaqeCj65FDB+WHHHYiCO0t5xX9vqu2lLECoZk4jOs4WPT+Fn6IPWx6EPyowxBKFoMeyRFNpccZ5rqW+J6zeYNskkQbGgPfJtcI+E4SvNrODOYzGHfGBlTHxHerYOC5YH+7U5AuiZwbaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938275; c=relaxed/simple;
	bh=QTHInueh2zOhyM/NnMXkSo+K/bvg50RVXZ0RIEZKrtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3X7OegB24YaOwTgm4rZkGnd+jSV6v6lic8kWXcOu1NCZ4SqmfIz1lcAsNYvCWF04SP6MNqo5645llvNnlDPwqDuewTHoOGRFadRtty6gFzzmCKJ0w7x2jVsFmXvT+x99Bq6DzQ2fIdgE+GFtcCq7Q3/jj8x8+8KxCQWz+imDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Efdt5UHI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f480624d0dso33594595ad.1;
        Tue, 02 Jul 2024 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719938274; x=1720543074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVslO6h8F/lYJAAohGQ7HU3YjE27gn7fwMIXd36HBZw=;
        b=Efdt5UHISr/NjsSosBC0f6bV6QudRSK78Ai+LuG8Jt0S45Ui5M6eGxB9x3dREzaUBp
         SY0MMv/ReKoMNBC7LNxH2ib2UTNB0GD3YfFYuHnLwZHwTKipSDI3IJWMskgzr4ywB9tf
         unIsa1YLNtdADuXkUXiAi+fW94GOyyJzcLJ3TaNMJ0yt6FejGbTCsisfbaWd5sRkVmN/
         xIL8Xyv18MTNNfpRmIByMJSLTElBpSUt2+0TCYuUTRn5lh084ylJhTkwgElOgec8svqk
         oV12Xi/CVDA6LtEjGkfTYhhIA6WICks8Ej7up/giBYhStEv5gKiP4R5FTvjHY3DT0get
         zzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719938274; x=1720543074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVslO6h8F/lYJAAohGQ7HU3YjE27gn7fwMIXd36HBZw=;
        b=Le+c7fR30xsprGwRTZg9kDxUyml+KWvjBPE4I2wA5bXv8FL2mjJT3hnVVcgfhHtxkZ
         qi4BrjZIHpNPpyGgDel6u7S0rcMo6WSuX1inFYqgtfVnycFjhuiO5WqdqPew0sfmMZmC
         NhqsAzQfgiIcEcs30Sr/pnQfqPP1RrMIhvCqsHK8/Ge1S9kAmTRt7rUdmCEyVMuuNb0O
         /dj5iS2oRIkR2CCI3MTqCU54r7GyeOkChcH3Ng1O9sYBVmvA02/f0uOQg+GrUIC87VUQ
         6vMmxsXkHS7HKDtxMwrxQHCKwLA3odu0W8NTABxPOdpWeSzSFj8l+aa3+ODImFu2Kv9I
         IvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBjr8eiTYYOUxqehFANNkvAneaWaJfM5AwiFL8JNlgmF43qAhyO5+PgVxOHYoVGAjE99/79LKvEeyiVPiWIjM4oNsgfZ/5Pa0aLY7N1yBEypxBmjVfIU0ldtFqFfrfNqkfyvtGDjw=
X-Gm-Message-State: AOJu0Yw+8RAwqRLG5LoJhvqqUGbx+OmDEmuMH1SifoffwwgxwHYIv/7q
	HQxQS3jMaJsOnxVenFTUfmmJSQZzhuzo/XIdohXrPmF8O+vlCuZP
X-Google-Smtp-Source: AGHT+IGy3+3dhOQC3GorSUqhxQxMJCe+2RDDLlpK4bQXMcr6CPV+V4mtkgOWevwjKc4SnPbpn9o1Rw==
X-Received: by 2002:a17:903:1c4:b0:1f7:1706:2596 with SMTP id d9443c01a7336-1fadbd07d45mr99542045ad.67.1719938273566;
        Tue, 02 Jul 2024 09:37:53 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3311sm86082035ad.79.2024.07.02.09.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:37:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 06:37:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] sched_ext: Add cpuperf support
Message-ID: <ZoQs384bAMuaeDEs@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <63c76af4-6451-4d6a-8aeb-0bc4812c4101@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c76af4-6451-4d6a-8aeb-0bc4812c4101@arm.com>

Hello, Hongyan.

On Tue, Jul 02, 2024 at 11:23:58AM +0100, Hongyan Xia wrote:
> What would be really nice is to have cpufreq support in sched_ext but not
> force uclamp_enabled. But, I also think there will be people who are happy
> with the current uclamp implementation and want to just reuse it. The best
> thing is to let the loaded scheduler decide, somehow, which I don't know if
> there's an easy way to do this yet.

I don't know much about uclamp but at least from sched_ext side, it's
trivial add an ops flag for it and because we know that no tasks are on the
ext class before BPF scheduler is loaded, as long as we switch the
uclamp_enabled value while the BPF scheduler is not loaded, the uclamp
buckets should stay balanced. AFAICS, the only core change we need to make
is mooving the uclamp_enabled bool outside sched_class so that it can be
changed runtime. Is that the case or am I missing something?

Thanks.

-- 
tejun

