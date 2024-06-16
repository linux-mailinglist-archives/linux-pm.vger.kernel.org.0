Return-Path: <linux-pm+bounces-9265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FE190A001
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 23:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C22B21213
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD604E1D1;
	Sun, 16 Jun 2024 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="bdecUUpd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB210224D7
	for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2024 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718574498; cv=none; b=O5jUNIL4li/2cGILJs4skMcsihMa7si0c2EC61VgzbwH+otknSJSJrqEAWfXge6JqySetzgqOkhzNlUaJyIqnyr2ZGKRSpJeHAOmKuyI7EFwWAomTOhh4YpU5zp4RTCLKK//2x86iSAe+MR+5hJdS00xKPO4zo+1Z7PPGxo0Y90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718574498; c=relaxed/simple;
	bh=Zuc/Ggghj130+Sym+AFD6T0uzfrBUstigJUa7+Dc9YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8cny78sav9+YFfB+bRuDCyTmSPnwGUa3h4gJrCzvz6sThnebhZ0VLi44wv43upq4S8VYRZz9Lw6UvI0FA537v3kFfKl9rIg2tAKm3DeXlEQYzTsLjYimIdjoaT4PRJzUAi5LYHqtTx10BuJq7glBaTV43fMjnfbUG7gkI7xKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=bdecUUpd; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c94cf4c9bso4549568e87.2
        for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2024 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718574495; x=1719179295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpwm9CARdGAorSzv02xokLNVFRaZA+rnkBCqOeL9mCc=;
        b=bdecUUpdDVEijJPubIhZxDUh6wFDX/0Fk7CF0tNf/m+ZfWum5tERiQ4e54eAylZBP8
         CjPfuDDVyycyaLRQfSnVtUwuGtHlepqgdBzew3kEOdSFeW5oDheV5GylR6fdF/z7sGWG
         v3HO4LeqHcCi11E3W6ZUcHG0F31X7g4QSyhoioH7Q0AgxtDfJjyelqwScAnKOjSf2+Sz
         df+UyYnaRPqI7yk+Tm0ZDgIS/SAVGk4rWu/IDvHp22CEdT+s6jKKc4eyRC57NzIPf9zI
         BJrYTa73XEdrhZzRy8g69kfISgf3hESbf3VOU1R/6DTf/saQCEtAzbGIdVXBuGobGwup
         kyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718574495; x=1719179295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpwm9CARdGAorSzv02xokLNVFRaZA+rnkBCqOeL9mCc=;
        b=VZKo3fzh3Ry0lqBWR41bfj4CAKRG7Bpi1CXREscu/hrC3DgDxApW8ni8/UOUBKSxRr
         CQ3Vd5o1ENFPwk95VhvTS8QvF5M8nCD3BwKxd0GVd8liq/XdviAncfnLuavZ/I0tpJ0L
         pQ519eprx7WrVubRkO2qe7SXfuO7CQ5t70j/+eLi6MtShfqAUOrXB5KEJvmuH1/ZGpwk
         4zww/4e6jJqaxC7Fxl09OMHEiXMvhZCjubTsrPYFtYBYAhf4NQx7FLDfUf1zuDJIddhL
         XcEOoM0m4Lhp1lbGKY0BM4ZR6lV9ClRvcc1UXfDPXfGt8kutzHDj3WcxMa7YIwu+DGgc
         oglQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ACQa5KHJ5gX7kmISUfG5RATD2AEZUzGe+qCdBvHYQwgwcqQF75N0wPFs6PO+XwZWW0DjIoRMnpGSQDuw0KrRK1N5VzDoW6E=
X-Gm-Message-State: AOJu0YzCFSH+M5LB84D0TBE6REdm9HLPp1KPTx3j0brWBzcepzjaD5/R
	lWBKY6jvbZ5dVqLzopgJIho3GyVBqNIHtuILx3EeYSjuNeAp1BgHGAGot1Kfcs0=
X-Google-Smtp-Source: AGHT+IEkGI7qsN2Qu57fueX7aD87rAXC0O9v1gs97A8V4JagsW+BKvG0HopDEZEGIA/1m/MAwtDUlg==
X-Received: by 2002:a05:6512:2396:b0:52c:9942:b008 with SMTP id 2adb3069b0e04-52ca6e564bamr8609789e87.2.1718574494900;
        Sun, 16 Jun 2024 14:48:14 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f612800csm139712185e9.28.2024.06.16.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 14:48:14 -0700 (PDT)
Date: Sun, 16 Jun 2024 22:48:12 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org,
	daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com,
	dsmythies@telus.net, yu.chen.surf@gmail.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Todd Kjos <tkjos@google.com>, "wvw@google.com" <wvw@google.com>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <20240616214812.nxtz2kt3svo44mbe@airbuntu>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
 <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
 <20240529101950.bjpmmdqfhjg3aol6@airbuntu>
 <d539bd2c-89f9-4a04-900c-41d257123163@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d539bd2c-89f9-4a04-900c-41d257123163@arm.com>

On 06/12/24 08:53, Lukasz Luba wrote:

> > This won't help. We tried different values, unfortunately the logic is flawed.
> > Utilization value on its own says nothing about the idleness of the system.
> 
> This is not true. When you up-migrate a task to big CPU, then CPU idle
> gov can instantly benefit from utilization information and won't make
> mistake based on old local history and won't use deep idle state.
> So migrating the utilization from one CPU to another CPU says a lot
> about the idleness to that destination CPU.

You can migrate a 1024 tasks to a bigger core, but it could run for 3ms and
sleep for 40ms. So unfortunately I have to disagree with you here.
Generally a high util value doesn't mean we are not going to be idle long
enough to satisfy min_residency of the CPU.

> When Christian removed the util he got -4.5% lower score in GB5, so
> this util has impact [1].

We need the idle governor to help with power saving. We can disable DVFS and
all idle states and always get a better performance.

The residency is ~50% worse on some clusters with this change. Overall power
impact is 2-4% in many use cases.

GB5 is not really a representative use case to measure the usefulness of the
idle governor. Task placement to avoid the cost of idle exit latency is
a completely different problem.

