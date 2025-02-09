Return-Path: <linux-pm+bounces-21612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B8A2E134
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 23:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA081164850
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 22:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA79155753;
	Sun,  9 Feb 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="usu+PO98"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7CB143888
	for <linux-pm@vger.kernel.org>; Sun,  9 Feb 2025 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739140477; cv=none; b=ICDsrttyCkvnSfYmhyamAPstboFP9bsMl95laA58ucuvoMNl4geSNcY/8UzHR7l2jUcLD0iruPMGBIXZ7R0/GiYae9DpH1Hqh0zpZLqgd/Fs3lMog9yjXxs8h2WnD0BkQYkPMAKhMmTUuQM730FXnnS0uBdZTfpXpQXcNTR0Jl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739140477; c=relaxed/simple;
	bh=OZ6XhT05wj0HtVAfQr2aHu+yKa9kgIqUxOt58CUHgbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msPHK+KwPRPpaSS3DPyVYbKNa8iv4ibRa++VyJ/1ukiyb890t91v24BmDtuaT0y2s4uYEpi5BA7/iv1C9Xi7gZWxe2MFXrAU8SN+P8E51n7L5nZa9SgfCUAf0Zr6aOsF66bjbbm6F1rIP5bMGLaNroO5YKYjJjNvkniLb5Yuh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=usu+PO98; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1870934f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Feb 2025 14:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1739140474; x=1739745274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6VqhA8OJ2B/T8LcGnvokM/21lxU4fJgLMXRUipbc15E=;
        b=usu+PO98CemKvbMYzf1+9Ygr30JjL/GOX3hnICp0L2tpbu8TqrKGsBSzsIKPHfmZJd
         Lw8IR8l4q5S33z5FHbiJQVDhAPIJKLIaVfQD99WjgOX2fpT4gjMff0DrIgCJaO6toG/n
         TBCbDUw/dSZ3ze4J9BziSwaZHbnz0LYmuU3MYr699DBcyOCOLGJ8jxA1+la1+rztRk5z
         rANeD5AKTkFKLXmQmPfG1cQOvx8ASYnP1hkNX8vCg/RqqjdhACylbnEMDQq+AOyPf9a0
         rphrCekKOlh21EgGDD6ZhKz9tbNhqG/AA+r/9TW+1R4pR72O4DNx/e7awVincwz0n7c9
         DQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739140474; x=1739745274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VqhA8OJ2B/T8LcGnvokM/21lxU4fJgLMXRUipbc15E=;
        b=Hdu0Erkq71Fvi2uiR3ojtiJwH2WW7MXV41h0IcEK4D7xLKRyexUNbWvz9EnupNoT9x
         f3pmk90sMkuG1Pyrd+3Mcf9h+DOy1ImSVosrrV/VEdhjltPN1IyFCK5OtEjpK1+wlSrf
         KpUgi/cGtICU/tzRXNSGQvKEUQJewyveRXi2WLMCwhGYv4D70w1dtcTUi5TTOzOCDNWC
         n0REeHbpu+KSLSEvTKuq5R0zNuLLg/Fhk+fLbb+7kEdzQcNJqmXUnv0xPchJ0rGbCxU8
         7SfToXAIuo7Fet+E+eL+5/OJWsJsciVPsJpN7ZDg8OoT/tTy0h8kXZZpHUMGUGKbFKJq
         qyMw==
X-Forwarded-Encrypted: i=1; AJvYcCW5PgMV3yqnWhy+InMCnpCzlGinkW6ryn/p+YWCxvyZuQwJEINlIkLuZhp1krdGncXQTwLuqOKJ6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6z7Kwsiib24Na7NGt/k/WNRV2owNAj5kCUz2z5gW3fFX34pj
	DVwNHKsCz/Bi7BUtavkREasvvd/YaeC3bbJ2VFB/sR4xbnsb/zTaYZUzU7y3Buc=
X-Gm-Gg: ASbGncto9tqcMYTiSCfdNst1QCGQi26JW6BvrTVMFf0FDRFrfp+Lw3I6AIscE8vUwNo
	zV0qaqcMoLzDbMK+AedMy/pRL+sJTrnzqecLpPKRGoDZWMNcdSnBrvMX9VvCnpiZROiT8GQ70S5
	hBLELrYTm4TIH1zfYrsRTN0H/wkV+sqm7tCtoB3YBp1dN90H5ajNDszgV0bURFLmnMqsl3hKaHe
	GI3g/i19zMm0mmIgBk8g/AGVn9r96JA5Dr0XrcKYdQdhA2l8VM5PtPjnvl8Yzn+fhitvqHmzpOb
	npePTwSAAujnnrKVZrfitwavpDN7R22WK+NCCoEBrSBF7deqF0JUDS7QV+07RPZbrO79
X-Google-Smtp-Source: AGHT+IHYmQpg+MN1qA0nug7LeoGLzcXDskmffzXoPho8X3ciY2KFjA6cPoU5YmUL849kQYDu9L1IYg==
X-Received: by 2002:a5d:6d0b:0:b0:38b:ed88:f045 with SMTP id ffacd0b85a97d-38dc90f0daemr8186759f8f.33.1739140474424;
        Sun, 09 Feb 2025 14:34:34 -0800 (PST)
Received: from airbuntu (host109-154-33-115.range109-154.btcentralplus.com. [109.154.33.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dce18d6f9sm7071108f8f.29.2025.02.09.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 14:34:34 -0800 (PST)
Date: Sun, 9 Feb 2025 22:34:33 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20250209223433.symtjwbkcbwvhlc7@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <6e4a4605-f6c5-4948-ac38-c4ddf4990754@arm.com>
 <CAJZ5v0ieB4hppC8fHnjhNNpfFZzEL4Y96irSTmCmavXCid2xtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ieB4hppC8fHnjhNNpfFZzEL4Y96irSTmCmavXCid2xtA@mail.gmail.com>

On 09/12/24 13:33, Rafael J. Wysocki wrote:
> On Wed, Sep 11, 2024 at 10:34 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 7/28/24 19:45, Qais Yousef wrote:
> > > Improve the interaction with cpufreq governors by making the
> > > cpufreq_update_util() calls more intentional.
> > >
> > > At the moment we send them when load is updated for CFS, bandwidth for
> > > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > > sent in a short period of time and potentially be ignored at a critical
> > > moment due to the rate_limit_us in schedutil.
> > >
> > > For example, simultaneous task enqueue on the CPU where 2nd task is
> > > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > > the first task will lead to dropping the 2nd request until tick. Or
> > > another CPU in the same policy triggers a freq update shortly after.
> > >
> > > Updates at enqueue for RT are not strictly required. Though they do help
> > > to reduce the delay for switching the frequency and the potential
> > > observation of lower frequency during this delay. But current logic
> > > doesn't intentionally (at least to my understanding) try to speed up the
> > > request.
> > >
> > > To help reduce the amount of cpufreq updates and make them more
> > > purposeful, consolidate them into these locations:
> > >
> > > 1. context_switch()
> > > 2. task_tick_fair()
> > > 3. sched_balance_update_blocked_averages()
> > > 4. on sched_setscheduler() syscall that changes policy or uclamp values
> > > 5. on check_preempt_wakeup_fair() if wakeup preemption failed
> > > 6. on __add_running_bw() to guarantee DL bandwidth requirements.
> > >
> >
> > Actually now reading that code again reminded me, there is another
> > iowait boost change for intel_pstate.
> > intel_pstate has either intel_pstate_update_util() or
> > intel_pstate_update_util_hwp().
> > Both have
> >         if (smp_processor_id() != cpu->cpu)
> >                 return;
> > Now since we move that update from enqueue to context_switch() that will
> > always be false.
> > I don't think that was deliberate but rather to simplify intel_pstate
> > synchronization, although !mcq device IO won't be boosted which you
> > could argue is good.
> > Just wanted to mention that, doesn't have to be a bad, but surely some
> > behavior change.
> 
> This particular change shouldn't be problematic.

Thanks for checking and sorry for delayed response. Life got in the way and
couldn't get back to this sooner.

Cheers

--
Qais Yousef

