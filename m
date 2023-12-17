Return-Path: <linux-pm+bounces-1320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4A4817948
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F2C288FD3
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66A35BFA2;
	Mon, 18 Dec 2023 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="u2X8kVf5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154DE1DFDE
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso34192775e9.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702922273; x=1703527073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Si/lj7TYrj1EQV7uvuIQU+/15baXlgXTB02ptVQd3Dw=;
        b=u2X8kVf5CILKV+Hg//cH5KNrenUc983jedgAD5cvNLCH2nQrzwqh9SpCKYQk4IpWn0
         +CkVA1mmwAZwL0oeCg2hEbI2BXXioxeKjd/g6L58dWopCrF17x8sH1+QTBOz++ElMj0A
         ApNdaP+J7XBem2qFdQjOyIkwXyUWyPEPQU0J1/f6BKaD39PpSg1/EDqCa9jmKjVlsVqD
         OqLjx3bG2LByu+Ek/RjoBUmb9i3G+mwyjYVn9R3hLvO6pFvnhDKg0R5Nyef+LwVxjZkX
         208FaGlTeVX0XeuAoVR/yj202anBXnivkE8thD1ebXtl5Ihxg5uN0eh78uoOFR1AP/fY
         rgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702922273; x=1703527073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si/lj7TYrj1EQV7uvuIQU+/15baXlgXTB02ptVQd3Dw=;
        b=blBOrQQdMbvKz1pa3Z6MUG3rsuCvQAfUQALdsPM98sDyVtJcO8B5mfXRcjnQ2OYYMP
         imStPMHbSSdUJmJQOIRsjvOZSdodiCYrsrNZGdOmW597AYo/qEbG2hgB9Dsa9YHDdExy
         xPXMEtUY1tzmRM09zyfLjAnIEVFM+0OB1KJ0cjFV4DcetGlT/W2jYsjAnZ9VgBmKq2p3
         6W494CIwhK1ti4RGjxKSEsJqJt1dlJlmiVTKaYxGsYPi1LYfb1lBoED5XYbL6CwxiUWz
         papdWmYxVJPP6on7bionJr8ztUCwBJuMjlaJBB/alezQCk2Rnthst8ajkNXVL2+XIWBr
         AHvw==
X-Gm-Message-State: AOJu0Yw8g5h+mnUYSPrk3KL7KZyAwi3ZWonLSDgnvpqxYXtO3WKJKHNA
	wnMMGxZtMyO7D+sF8IYv1eVOmg==
X-Google-Smtp-Source: AGHT+IHZKJ/UKJ+nkHDxiesjP7qViZt2HAVd17G4Oil0HrvjYqIWBWhWyUafPyzAeXIebNMMKPSlBw==
X-Received: by 2002:a05:600c:c1b:b0:40c:27af:2ac8 with SMTP id fm27-20020a05600c0c1b00b0040c27af2ac8mr9182228wmb.6.1702922273209;
        Mon, 18 Dec 2023 09:57:53 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm43547595wmb.30.2023.12.18.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:57:52 -0800 (PST)
Date: Sun, 17 Dec 2023 21:23:12 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 0/4] sched: cpufreq: Remove uclamp max-aggregation
Message-ID: <20231217212312.igyy5ydjwywmk5x3@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <c34df726-33df-4188-8010-3b268dfbb607@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c34df726-33df-4188-8010-3b268dfbb607@arm.com>

On 12/18/23 09:19, Dietmar Eggemann wrote:
> On 08/12/2023 02:52, Qais Yousef wrote:
> 
> [...]
> 
> > ===
> > 
> > This patch is based on remove margins series [1] and data is collected it
> > against it as a baseline.
> > 
> > Testing on pixel 6 with mainline(ish) kernel
> 
> How is the Pixel6 configured in terms of per-policy rate_limit_us and
> response_time_ms ? Is this the now default 2ms and whatever the systems
> calculates for response_time_ms ?

Yes.

> 
> Pixel6 is still a slow switching device, rigth?
> 
> root           297     2 1 08:58:01 ?     00:00:13 [sugov:0]
> root           298     2 0 08:58:01 ?     00:00:03 [sugov:4]
> root           299     2 1 08:58:01 ?     00:00:05 [sugov:6]

Yes.

> 
> > ==
> > 
> > Speedometer browser benchmark
> > 
> >        | baseline  | 1.25 headroom |   patch   | patch + 1.25 headroom
> > -------+-----------+---------------+-----------+---------------------
> > score  |  108.03   |     135.72    |   108.09  |    137.47
> > -------+-----------+---------------+-----------+---------------------
> > power  |  1204.75  |    1451.79    |  1216.17  |    1484.73
> > -------+-----------+---------------+-----------+---------------------
> 
> What's the difference between baseline & 1.25 headroom. IMHO, we have:

Baseline is the remove-margins patches as specified in the quoted text above

	> > This patch is based on remove margins series [1] and data is collected it
	> > against it as a baseline.

The series were stacked on top of each others. Results from this run should be
compared to remove-margins[1] tables too.

> 
>  static inline unsigned long map_util_perf(unsigned long util)
>  {
>    return util + (util >> 2);
>  }
> 
> on baseline?

This is not baseline. See above.

> 
> By patch you refer to the whole patch-set + [1]?
> 
> And I assume 'patch + 1.25 headroom' is 'response_time_ms' tuned to
> reach 1.25 ?

Yes. Which is done by multiplying the response_time_ms with 0.8.


Cheers

--
Qais Yousef

