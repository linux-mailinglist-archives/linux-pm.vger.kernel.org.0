Return-Path: <linux-pm+bounces-8321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C28D29C9
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 03:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661B41F26491
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63D15A850;
	Wed, 29 May 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="WxkaUUTw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D4D2FE
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945110; cv=none; b=jtXDs+5s8Sdw+xzd7J78tGj2xnEueHKmqTfbdmLapVHZ2WTgkn8xEpuysjx5Y8xdjomLTlPsjAU8Urcqi6rirDSVO4h+Oiicu4W7EUOgXY1OmslVXTEwccjZWh9k9RXJT4i95f6PMcTyu7mlVdckf5rLVzcv7BXoPI1mSoK1ka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945110; c=relaxed/simple;
	bh=mtCLC3el6bEP3xWXKXrEM+Cdpht1UY4rwfRbaeK/mLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReN5Xrevq7i8ENBwpoB8MJ0+oK6PB5tV39jTuvEWcx70RLXG38VCVFtrHunEZhDZl/TjNeDb/BnvbLfYT7cUx6TtQ2PP7xdL4hLBUuUJBfDdLNaZm5MhDVj2fITw0GpPNTr6PCvMnTMFlKRW6YbuTPFOnXJflYBT46AkM12uutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=WxkaUUTw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420180b58c5so13383005e9.3
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716945107; x=1717549907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPNZaoaJtA1xZK2fsp/RvQvPvLoyRAgx50EU+G39ics=;
        b=WxkaUUTw2N8ZpnXqIblNsQ4Ekbqrh8odr+U3cr5TyvdUzp7lOgjlg/aKb2J9h5Eis/
         kSsjT0mfuP2D/h6RSGrFAKd5Isf314lkMY/HmVXurvEDs3PManfhpcV2FrTk6MpLV262
         MPVLzx4T5hn7B58l4zEUPDZwEmMdmEYg53Iz319xJ2w23twGt8gHB0ttq10jmCy3CNT4
         mbiUjLUJf/dQLpBK/skv1ULF2/aHTAxvgyBXBqsQSnnfEay+7n5+g1ucu3nQSjaGPg7X
         5Dg3690NAe2JAkgbH+SDsY6KgQF24Luq3lsRZgJ4flXEDrKaT//ZIQrLXIMXC/ax9Q2I
         xWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945107; x=1717549907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPNZaoaJtA1xZK2fsp/RvQvPvLoyRAgx50EU+G39ics=;
        b=Cb55GiJQB+sGA4Yse07yVpGuMDI8BZWd9EBbwdx86Zp6eT7ZOvUNZHmgyEkIgDDCme
         gYK/vo4YKcPLI/muuvJH7MQ1E6ZDDw5AwRZmsgdpkiqSjiW4Rw7w2FFq66IqUcZPJWpN
         QcgFJeCqUeUMvaITAXRx+Mo0sVeMD6viYQj76Y/qiYsUVTp7KdTV91UPdi/w40Uu/0vK
         Tgo0a2SMczi/FSioF6qB7Dtd7QkMcolGO8akrBvZM+RgiJ7iC5QnKgG0bta4uLt8LZ2X
         dXdW/EWKuxlyv0J5F/S1kwnHU9RG8aji01DMHmzNQbGfqSBu5+Iprfk9UlSPjNGOekYU
         oJJA==
X-Forwarded-Encrypted: i=1; AJvYcCUog2f8k5GsbXi9k1LFjRSQJQzhCHEVYINLA+s8dIJP3awH6AkfFa0h7FnImoW1UbUryk0oaRuEojGGqvsKycfTeeU3JPchOHw=
X-Gm-Message-State: AOJu0YxUwL2Yp83SHoxDtYSwGDfasFHVEpPzRjFmqHU6E2+CWO9xda9j
	A6Zu2Svr/7qMGwGye2itB5vcNnU8eVmYZ9a/yIC+vz4Gy2eKm+ergCz1zik+2zo=
X-Google-Smtp-Source: AGHT+IEMCKnHbB6p+UdL/7W8I4STKw4+5Uw4acnirh3UUgvFatwuAO+P0FEkARvVha8lh0p/kUK4Cw==
X-Received: by 2002:a7b:cd06:0:b0:41b:d4a3:ad6a with SMTP id 5b1f17b1804b1-421089d322fmr116587215e9.17.1716945106551;
        Tue, 28 May 2024 18:11:46 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm193491525e9.4.2024.05.28.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:11:45 -0700 (PDT)
Date: Wed, 29 May 2024 02:11:44 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sched: Consolidate cpufreq updates
Message-ID: <20240529011144.smuq6dbaxvulxy4e@airbuntu>
References: <20240516204802.846520-1-qyousef@layalina.io>
 <b4036b48-7d04-4bba-b405-f64ee309e874@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4036b48-7d04-4bba-b405-f64ee309e874@arm.com>

On 05/17/24 12:06, Hongyan Xia wrote:

> > @@ -1997,6 +1999,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >   		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> >   			      attr->sched_util_max, true);
> >   	}
> > +
> > +	/*
> > +	 * Updating uclamp values has impact on freq, ensure it is taken into
> > +	 * account.
> > +	 */
> > +	if (task_current(rq, p))
> > +		update_cpufreq_ctx_switch(rq, NULL);
> 
> Do we care about updating the frequency here? p is dequeued during the
> __setscheduler_uclamp() call, so I think it's better to do this after the
> uclamp() call and after enqueue_task(), so that uclamp_rq_inc() comes into
> effect.

Yes!

> Also, do we want to limit the update to task_current()?

Yes we only care about current because it is running and asking to run faster
so we should honour this immediately.

With this patch we don't do freq updates at enqueue anyway.


Thanks!

--
Qais Yousef

