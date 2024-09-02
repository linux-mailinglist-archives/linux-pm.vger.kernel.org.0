Return-Path: <linux-pm+bounces-13363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28015968EEA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 22:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BDE1C21AAA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB5185B70;
	Mon,  2 Sep 2024 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="jIPbssxT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2651A4E7F
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725309788; cv=none; b=M7l1RAeS8/T3qDL2dOPPOQyaTaJ0I1sdd6srJLk3BjoPfoCp0HZk/Ofc33fpmXnstlO8x+W6V+P1yv/cZE980/zzLk08DZ5hPnsdbqcqOT6k6c8xxojZl6CofvsdHOJf55MX5/aMxi6jJISsLzrQc+uTHYklFfwz+RwF6fWNJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725309788; c=relaxed/simple;
	bh=2pzx0cEcSe4li1KrxmXMQ9xUtR2Ujpwtv1QhY4L6EBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdKqX3Ri8jBttFGRItOROnnvYhhLk6xAu71LQu+HXpzsjzSE1pxKyAuXf5PTW1sr1f1Ez1QerSSSxJvCCBOKz4/ONwMx7M3U2QEq2YAPeAYfjlsl11qbna698//EbFsgtJr74NwDMRdqbja1kZ4JiK+0Dup+imEnRJQeV59jG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=jIPbssxT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so5991427e87.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725309785; x=1725914585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL7FkBuEHp0RB7JLTPCHyfRNqy0CmQ95XZXKOkuvJT0=;
        b=jIPbssxTTI1NLCAgu/Q79ruZCCP70kfTRkbTSmvchLp8gO1ai1Cmc4c9NWxXw83sIO
         xB4Q8aHbJyZiKU99BFGQqxV5XZRNDukhWilgz6TWj80lr6h16FWNrjkUq2Oh0j02er7n
         jLfRTDpGz2FXrkr0BoG7v3xSYs4ZwQSDADSXuN9z1Z+CpyL4Va8YX5mAQnnjzrdCq4If
         dzT9MDry6fPz6Fx/4PkoaWRvXa2N047EjbxmJLFFf/qhWlMaxlSOVXPvRJVWDV/MtzAy
         dmbzMDKP85dnpOB8zymrsd1jSxKRmiNQYIfBHAuwdwG12F1JtYF4zDk3Zk/E/GFC56t3
         m13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725309785; x=1725914585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL7FkBuEHp0RB7JLTPCHyfRNqy0CmQ95XZXKOkuvJT0=;
        b=brI1QjiHdO4QNHrMM3QuCWoFhcVC6sq8UzT3nRENmFc+Mnq5k9U4UmEurGUA9kzcDZ
         HBUmsJN77wiwjwWKLGb97lfZfItMvW/puI6qNTfhNFROvOZV033LQq4miE9g3I0YuGdx
         jBVWh4aEXTgB7q98n4esXc8eXOa/CDyjHjQ3Xp6AlHD0rTaVSM2sXIt5moqnT1Q6Zrzn
         8e/ocpkmWbniT/TSfjr4UpQ1XHBmOp3PvUXaquI+7NPCMm13vRBqiHFo79LkIgY+QuM/
         7wtnsgmzElQMqez9IsjFPpQo3eRhF36EwRd3XJ643yTTyS9zTfsYVotZHxPYgA0fRQXF
         +bJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWkSvstdHUbcGxhOa4TPbUI72qw7v1ewdAXne8n5pAY+wiQK9KHKsuEaY02+h8NyhvwU9z66CKKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWRHGS/FiyuNFuTkPCb2Y5I4oofWjc6JR3mI/nNpCxfLDEf6d
	5fO3f8V4oEn5TGBkt9o8lcUUkshemJ3ZVCUmW/NOHblrUk8QTyX8Eb1nOCO9hyg=
X-Google-Smtp-Source: AGHT+IFkOkpk8BJOobO5aqLxZe3h+clvdhm1jvoZFktYDp896OY0KvlM1qPoTYygnoA3KOmfuPJbPQ==
X-Received: by 2002:a05:6512:3054:b0:52e:7542:f471 with SMTP id 2adb3069b0e04-53546b34bb6mr9317552e87.29.1725309784653;
        Mon, 02 Sep 2024 13:43:04 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989215cb5sm597380366b.191.2024.09.02.13.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 13:43:04 -0700 (PDT)
Date: Mon, 2 Sep 2024 21:43:01 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20240902204301.v55w7id3d2kw64qy@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
 <20240901175149.46yfk335niccmfq4@airbuntu>
 <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
 <20240902125815.vu3s25ciib34eu3a@airbuntu>
 <CAKfTPtDr5nEHYJ0=_-3a6wVZ25TPoiohBNmhGBaZMCrYHydh8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDr5nEHYJ0=_-3a6wVZ25TPoiohBNmhGBaZMCrYHydh8w@mail.gmail.com>

On 09/02/24 15:36, Vincent Guittot wrote:

> > If we have 1 CPU per PD, then relaxing affinity will allow it to run anywhere.
> > I am just this will be safe on all platforms of course.
> >
> > But yeah, I don't think this is a solution anyway but the simplest thing to
> > make it harder to hit.
> >
> > > The problem is that the 1st switch to task A will be preempted by
> > > sugov so the 1st switch is useless. You should call cpufreq_update
> > > before switching to A so that we skip the useless switch to task A and
> > > directly switch to sugov 1st then task A
> >
> > Can we do this safely after we pick task A, but before we do the actual context
> > switch? One of the reasons I put this too late is because there's a late call
> > to balance_calbacks() that can impact the state of the rq and important to take
> > into account based on my previous testing and analysis.
> 
> I don't have all cases in mind and it would need more thinking but
> this should be doable
> 
> >
> > Any reason we need to run the sugov worker as DL instead for example being
> > a softirq?
> 
> sugov can sleep

Hmm. I thought the biggest worry is about this operation requires synchronous
operation to talk to hw/fw to change the frequency which can be slow and we
don't want this to happen from the scheduler fast path with all the critical
locks held.

If we sleep, then the sugov DL task will experience multiple context switches
to perform its work. So it is very slow anyway.

IMO refactoring the code so we allow drivers that don't sleep to run from
softirq context to speed things up and avoid any context switches is the
sensible optimization to do.

Drivers that sleep will experience significant delays and I'm not seeing the
point of optimizing an additional context switch. I don't see we need to get
out of our way to accommodate these slow platforms. But give them the option to
move to something better if they manage to write their code to avoid sleeps.

Would this be a suitable option to move forward?

FWIW I did test this on pixel 6 which !fast_switch and benchmark scores are
either the same or better (less frame drops in UI particularly).

