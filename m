Return-Path: <linux-pm+bounces-22741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9CA40C4B
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 01:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E11517DE37
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 00:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8352418D;
	Sun, 23 Feb 2025 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="mOKFcCHn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CAE17E
	for <linux-pm@vger.kernel.org>; Sun, 23 Feb 2025 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740269041; cv=none; b=seNCU05tofnkQ2RoXCX/bPE/C5mNYEc2mSu8iqaJkcjtBT10L5C+rpItjGVLmzDU2iUPFN0dNEpQ627FVHdwyj+Kfk5d1heQPkVjW6TIgIE6tvmqeyIP6pE98l+0haJLEEUj8D1iVyoUg6ntK5KmuKotzEF0uXq5y5MgtHqnRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740269041; c=relaxed/simple;
	bh=xbhd1vIniw5dlIi5MuetY2VBB6uB4CtAu44S678U88E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adfYGAusAGlD/eeAJwtNLId6vcUmw5Uf+3AAmdUJ2jFxVbL/zuqeb6caKT1t5gpsc0BPuFsmuHo+zpOPw0lUY0Ve1qdiW4Q+7A6FbDIquG1JTSdXyil9O0rvPAfOseK7h6qECTEKN9DJhGMjjYh6oMaqxwimAmdZOnldQHUT6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=mOKFcCHn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7430e27b2so530515566b.3
        for <linux-pm@vger.kernel.org>; Sat, 22 Feb 2025 16:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740269038; x=1740873838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LUUt0pnX00zf1HcZ8kQqou3gDEYCTh7HwQ/hK/Ge/A=;
        b=mOKFcCHnMjjtrxXAKND4DjOI5AX/47hkEQU88UB0gPTIJqprlgdaYZPAEiSQDqmHb4
         eAGLshFpd5pEr+KPqur9S/jk+MWs1F7NtUTZ0SVPosy6MIlD7/2UIyCbse3XvCaWCmqc
         mgPDKMBKDfQOiei33By6lZ/BDErRYuB+LopqOVtREp1OeuxW7lpvqehOeG0dIL+AIwFo
         axrqvavGsjD8PQ76dodJKnV7t+4nAEl0RCMC3qdefey7SUGmsElEEYTrtvlRj0guNiO+
         RBBCR7ngir55FymILTR6VymPNtH6WVw4KO8NkpsLDa8pBcYSYvV56r3n3NJWlFLN/Kp3
         R33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740269038; x=1740873838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LUUt0pnX00zf1HcZ8kQqou3gDEYCTh7HwQ/hK/Ge/A=;
        b=V5tav/tpZT+U3/rmpSAniVm81Fw0hR+Ri0bBTqYWWYFTEonyEK3TyKoTv4p4JC+2Yq
         i7zo2JhMjfmHpZLV/5FYP+ADMl5c1VObXGmhz3HRy3wOFTrmq3Uj9RB5dV56xPdmgnG0
         +k5jDBRbAqNHcdpGpMx6H8KNQg3ZQBktAYMdqWIs+fZTKm6ddg3G7ZQC+bg1kOZuQ/EC
         pwaDxOhp7705Xyaaus5c+V/klFmHF+RaxpsyyOr030r3gSCxbs+l7lE+jLUkGbsU/yPW
         ute7BSZCXebgGoVxs3Rx0rHU6bW5ZV8L6rLR8M5Vutr+uHbXUQCzWl237GEWIj6jFj+5
         mMMw==
X-Forwarded-Encrypted: i=1; AJvYcCXbylnlc+bxQhnze4MB2M4b3LOOflOfgvPiUjppuRUMRO8iOB5D5B1Tq3onmaM4y8wQF/hh9XRMeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7mJv4xXIJwWRspD04NrSHXG5wUUmfjtW/4fIFCMFmE9XRT87
	O07T37ePpPt1S8/oKqIhhkpe9/aWlVWF9s+gMEPFFjC3bZIGP6YOz2yRqntgIMM=
X-Gm-Gg: ASbGncvDNTgbMZVjjG2OJtTFC7kZNe46M9tSzXEnpkFudOwOsOmcbDpEdqaGexBXysw
	yWYnB5u2kAU1OT/76mrRSegaSIO6ymTpln/07CN6ZiuuMSV8n2P/rd7PP2wI955VNlClKN+hlJD
	oxVYAwmBqEUPceZCYZ2GAQZ/u054BO90gjbt8ksS8LEg0qFV13CDHsKKSIXVKzcJdK/Dzs/UwuP
	fxM7JxGvPqYexplSsD4Zw64EqOJ4vZDlyPaVbPsdxombbgybKi56iEkrnl9XjW5//Dvn/TA/ofU
	pIHCCGo8kBVwl6IVrdN7
X-Google-Smtp-Source: AGHT+IFlsdbxEyAvhf/3tNnJQ0FtJe91bnosTyxBkr8GjcmYiyBU50dJsfVDnmOUvWRS9Xuvx5zwfg==
X-Received: by 2002:a17:907:6d05:b0:abc:a40:4192 with SMTP id a640c23a62f3a-abc0d994e7cmr788310766b.9.1740269038057;
        Sat, 22 Feb 2025 16:03:58 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb94329614sm1321959766b.180.2025.02.22.16.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 16:03:57 -0800 (PST)
Date: Sun, 23 Feb 2025 00:03:51 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, Anjali K <anjalik@linux.ibm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] sched: Consolidate cpufreq updates
Message-ID: <20250223000351.xg53osxswsxxohye@airbuntu>
References: <20250209235204.110989-1-qyousef@layalina.io>
 <Z7igK4w4PW1T_PCw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7igK4w4PW1T_PCw@gmail.com>

On 02/21/25 16:47, Ingo Molnar wrote:
> 
> * Qais Yousef <qyousef@layalina.io> wrote:
> 
> > ---
> >  include/linux/sched/cpufreq.h    |   4 +-
> >  kernel/sched/core.c              | 116 +++++++++++++++++++++++++++--
> >  kernel/sched/cpufreq_schedutil.c | 122 +++++++++++++++++++------------
> >  kernel/sched/deadline.c          |  10 ++-
> >  kernel/sched/fair.c              |  84 +++++++++------------
> >  kernel/sched/rt.c                |   8 +-
> >  kernel/sched/sched.h             |   9 ++-
> >  kernel/sched/syscalls.c          |  30 ++++++--
> >  8 files changed, 266 insertions(+), 117 deletions(-)
> 
> The changelog is rather long, and the diffstat is non-trivial.
> 
> Could you please split this up into multiple patches?

Sure. I did consider that but what stopped me is that I couldn't see how
I could break them into independent patches. A lot of corner cases needed to be
addressed and if I moved them to their own patches I'd potentially break
bisectability of this code. If this is not a problem then I can see how I can
do a better split. If it is a problem, I'll still try to think it over but it
might require a bit of stretching. But I admit I didn't try to think it over
that hard.

Thanks!

--
Qais Yousef

