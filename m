Return-Path: <linux-pm+bounces-8355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF978D3463
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DA01F257A6
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB4F178387;
	Wed, 29 May 2024 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="rbrNXJCu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7315B138
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977996; cv=none; b=jyEe/HY7YOezToRPD4FDYZxgrjaZ3QAmYv84laeo9tnIDHgj6u2JUPoNOob895itxucPOql5ELkKcrhE9X8AfC/TJkrGgNOk3OGpV7obbRWflhqBYh1X2tYbmiZLuquUJ58ynEkXHggFEV7q67YzEqN94KAfbh8Jny1Zqoy3p8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977996; c=relaxed/simple;
	bh=y3thffplI068yYu57YdvPagafUX4wQ+NY9L5I5mBWEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RChSbPEJzfbyqqvqtazNxZx8IeXt8Zg+0zCZZH45cz8Hvzkv4wKDExRptiEY6AsUfseD1kGawBSvC0iN1fc0EVhtAtRzFjUJ6Z+1uvyTKN9ttKt01qlAvFUKqDATJzkZkwtFoI0FLctWmZcaeNNRLcqObeSaNu4K99WTrEKc6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=rbrNXJCu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-355080e6ff9so1785978f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716977992; x=1717582792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRLUKPVZheHa4awySJcQtbU/PGwXhazZ6r/BRMRHT7g=;
        b=rbrNXJCuJ7IkckXikKw/VXrcM8o85vW4jQMqDfB9oDqBin9yt80DJsf56DRLJT53Iv
         zzzox22mchbPPrqbCGa/aSofMaiYgcx2Rj7rUFEVwo5H23Z8J2VmSCUiV7UgbPuFe5CL
         w8b0rBNRqPmq601wdDOtMA5uTM6+KTBZVbinQdT8EjWj3yHtw87VSNtancd5fvhEGHlV
         oxzY3bxTCxl/XAPAUhmmwfsn5V21uEfxbpi2lSslOYKl8DGYB8NZJy/rvyzHh6b3atZ0
         x1NLd8ioyb5kQrH32XjV9o5D2uS7hnmq7G/L2iw/HhNByh0VYmxKlDO5R7ON1rbeAueV
         8WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977992; x=1717582792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRLUKPVZheHa4awySJcQtbU/PGwXhazZ6r/BRMRHT7g=;
        b=qWt+BX0LXQSu2NgrcPGFmkfD1oqZZ+1RWZ6rxFOyf4/INeQyuxlvLOLuM9DI7b/CO0
         EEcKVNEULcsUekX9i0oKyWqZNENtjyF4iLov1SZXRB9Fz4KdU1gMUrAuIDVyzZ9/AP/X
         RfdAAxzaFZgn6aaJAXzQWuFg6/g7CFx/ss+qLlW1p+hhaKobJ7K7PWXXOqBBgpwFN1Xf
         Q55EVz7zghxHMMF42KA3RqrCdPV/vWGOrAwZfIUONneteDeUO+KswMdJcP7g5oa+Qkqg
         3OxIVwodEg2Jn9cEsi7Laat6edtoNhqOfZmzZlJFhvK3F/VdnAn3QpiFKyrqfMbrlxMC
         9JOg==
X-Forwarded-Encrypted: i=1; AJvYcCU2PbxFeOihMs/6nlv2eiwRV9WCbrsYf64yfu4trjB3Vg80W75iLZCNdX7vkgeLS1ZJOCe1HC4YU/1bd563rWU5flzQwKgWpxg=
X-Gm-Message-State: AOJu0YxBEaAbpaVlEb2lUHGpZECr59iLuyQm1ObPcUGVm1SV+3bBFFx3
	XRYRdqKysPGHsaYMhZJdcTiwU7H5o8kjGOkNotVHQU4nSM0WLA3HXYxkmvzimnQ=
X-Google-Smtp-Source: AGHT+IG4p+30F8o+O2X96lTQYosc8vp0UzDc2ZcPHbsRDzeJ7tx24ukNIznEUTIUVMfqEuaZPGHwLA==
X-Received: by 2002:a5d:5692:0:b0:34c:9a24:7a40 with SMTP id ffacd0b85a97d-3552fe19565mr9346574f8f.56.1716977992402;
        Wed, 29 May 2024 03:19:52 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-357ad6c2fabsm10780485f8f.83.2024.05.29.03.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:19:51 -0700 (PDT)
Date: Wed, 29 May 2024 11:19:50 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org,
	daniel.lezcano@linaro.org, lukasz.luba@arm.com,
	Dietmar.Eggemann@arm.com, dsmythies@telus.net,
	yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <20240529101950.bjpmmdqfhjg3aol6@airbuntu>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
 <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>

On 05/28/24 11:29, Vincent Guittot wrote:
> Hi All,
> 
> I'm quite late on this thread but this patchset creates a major
> regression for psci cpuidle driver when using the OSI mode (OS
> initiated mode).  In such a case, cpuidle driver takes care only of
> CPUs power state and the deeper C-states ,which includes cluster and
> other power domains, are handled with power domain framework. In such
> configuration ,cpuidle has only 2 c-states : WFI and cpu off states
> and others states that include the clusters, are managed by genpd and
> its governor.
> 
> This patch selects cpuidle c-state N-1 as soon as the utilization is
> above CPU capacity / 64 which means at most a level of 16 on the big
> core but can be as low as 4 on little cores. These levels are very low
> and the main result is that as soon as there is very little activity
> on a CPU, cpuidle always selects WFI states whatever the estimated
> sleep duration and which prevents any deeper states. Another effect is
> that it also keeps the tick firing every 1ms in my case.

Unfortunately I think we need to revert this. We've been seeing the power
regressions for a long while now and it doesn't seem we'll see an improvement
soon based on last discussion.

> 
> IMO, we should at least increase the utilization level

This won't help. We tried different values, unfortunately the logic is flawed.
Utilization value on its own says nothing about the idleness of the system.
I think best to revert and rethink the logic. Which is something we're pursuing
and we'll share outcome when we have something to share. As it stands, this
doesn't help. And we should really strive to avoid magic thresholds and values.
They don't scale.


Thanks!

--
Qais Yousef

