Return-Path: <linux-pm+bounces-10728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47327929655
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jul 2024 03:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781221C20E75
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jul 2024 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5651876;
	Sun,  7 Jul 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0/0eJPt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7B46B8;
	Sun,  7 Jul 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720316677; cv=none; b=Lkk7/uamdvT2DsMAjNgb9LpAvDawFwMOSa7C6uUoi2YrqX5SatEkcna+3R9wWG6FCPc1TA/ulr+yQW8PplbOHtoJcLVB4VfsoL7/6p4XO8nUk2gF0G0HXVFA5HkiV6Pcq0VZ0oZxbQyk1HUhxuck39rQ4va128h0VYb2sJKFEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720316677; c=relaxed/simple;
	bh=0Qhewd7KV2BAhhT5hTbByOo8ziUrqKMbApmaCZgk4ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmeQLmo0mpEi8AwYcWCdWKZDeivWj+ysg/+UaGE4KxKl38w5CxfkoXWeR2lMD6IC2W0HVT5X3GmsYqPDwYKzJP1qabOHQPnEOAzvj3f3InlaXgU+5O06eRYWbXlyhhbDGipEvBHlaxGXIO1OW8K9iMpIWca+onez6Le2eY4msEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0/0eJPt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb0d7e4ee9so18042885ad.3;
        Sat, 06 Jul 2024 18:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720316675; x=1720921475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKJvEZwbMUI0nGNvhsZvG2yied7e/iQ25VzWDk0C7Xc=;
        b=U0/0eJPtoCDgIiPOOhK2R3ccH4txD1v3PB+pSFOpTaxOTQ7Hmy96wNj9KE93B84oSq
         NsxMaNh8oKH4a73hBPfqHpx/2AEub7ffNLO0GsUkNKRB5llc9bCKQmVyP1/Ad6Sd+brc
         5Wqakh5Y9XAzYtDOxQmKP+ATF2gF+xS964RiqCk6cnpTIvzos5nCb9s3XHFTCnezKe5I
         8YEnmdjqAspOisyd9hB4JDeUslgP/r2ucElLg5JNvRJsujuayR2rjgmXStKX1hbmzR3o
         KxYOr+4MyfZSVTolsD+zFZpT6dyTvfssAUpNJh/k3P3vZZowh5OOaBs3ESV0OlAvEeBv
         qhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720316675; x=1720921475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKJvEZwbMUI0nGNvhsZvG2yied7e/iQ25VzWDk0C7Xc=;
        b=ptMFrXPbvutwujIInMRc2Fh5Xeut2dU/YEr53M+pv6Z3IRX0qnQctTxy2dTP7nkX7Z
         97D/7/RwAU7CchDR3R4XjUgvkSTYFKV9cl9Oux9mgseE0Mxn4qrXrI9Yu7mhd+wWkukj
         NcB7pc+j9i09hiW9oC8TQeklD1HhnaY3Avy9uP5Z1EIzMFAxvzpU5IJNp6tKVp8XgABA
         xpQuKompOKS5ooESRqyC6X5vQvTbb6vX8wcCCEPfchr3ZnijSseTqZ78JEA2mZC4osv9
         6biOiNFVDZXcAlSlfcuDExZU7SB4Anh925ueNvkP6BwRYrj1yP5bvdBMeTafPITGLe4e
         GkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEdD2Wuf2rFoDcPf9GKSA0HFmmP0v90jTw3G/MQEB3Vlk4Nh/BGd+m2KM79M+FKxci8MKmuw3uJ4AMHgtLqgBkQkr4bJXTNAKNvQnlMS5iw1chYIgZHbICdHwbcrnVeXcJvUmcy28=
X-Gm-Message-State: AOJu0YyRvo15m1llXzbqokPKF25FYAvoPn/qyc4D9MccDWJw9KWdV8hO
	Qcn0G/Djq+a9rgB2Du2MNV9lGY+xCEPFxHzR7DcHLzDSYQoiKWcZNQtUCg==
X-Google-Smtp-Source: AGHT+IF3dax0VqvVbRq38kfBoIY5PClgxCfRhtaNaG/TBs3mTgSAZxuqux4HhvlRJfGLSy2Zqd9hzg==
X-Received: by 2002:a17:903:1ca:b0:1fb:4fa4:d24 with SMTP id d9443c01a7336-1fb4fa4101cmr58168895ad.50.1720316675117;
        Sat, 06 Jul 2024 18:44:35 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb83cd6726sm2769905ad.241.2024.07.06.18.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 18:44:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 6 Jul 2024 15:44:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
Message-ID: <ZonzAdyd6zb2Sm06@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org>
 <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
 <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>

Hello,

On Sat, Jul 06, 2024 at 11:01:20AM +0200, Vincent Guittot wrote:
> > There's scx_enabled() and scx_switched_all(). The former is set when some
> > tasks may be on sched_ext. The latter when all tasks are on sched_ext. When
> > some tasks may be on sched_ext but other tasks may be on fair, the condition
> > is scx_enabled() && !scx_switched_all(). So, the above if statement
> > condition is true for all cases that tasks may be on CFS (sched_ext is
> > disabled or is enabled in partial mode).
> 
> My point is that if there is no fair task, cpu_util_cfs_boost() will
> already return 0 so there is no need to add a sched_ext if statement
> there

I see, but scx_switched_all() is a static key while cpu_util_cfs_boost()
isn't necessarily trivial. I can remove the conditional but wouldn't it make
more sense to keep it?

Thanks.

-- 
tejun

