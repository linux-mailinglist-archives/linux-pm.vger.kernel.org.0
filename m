Return-Path: <linux-pm+bounces-21611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B160A2E132
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 23:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B06D7A26DC
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1E814B08A;
	Sun,  9 Feb 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="nJ6g30Lj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5A82488
	for <linux-pm@vger.kernel.org>; Sun,  9 Feb 2025 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739140427; cv=none; b=mQzoVuirD00zXQj+bjcjXkOKfRL0e3AwSot389fltYmYlOQIpS34jWnEu58A5ydrDTSYEfvM8LZAX+EL7hHfU9bCEXQx5/i9E3pdVETSBDVRoTPdJUv4ALz4qFtyKbawBRp2UdO/1vRv1iNEYX930WP66Wm/x29WVxylWs1MUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739140427; c=relaxed/simple;
	bh=+P3tdg9iMDc66bQa985ioY/Fj7mfeqTDr8xxkMSy2tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fii5aPOP4Jv6mT/4II73yn9KOhkFAfa/n3LNF0oO0jPp4YGDYlxXSXsaRvlK/TBLsH7ExwA5fSis1cW3ZBhk851s8Bj3bKS+aDW+89KeRZsn+d/T+7bAI/U03xrBa8GL82EWGbZAHCjatsAATYhdv1XrC5VDGmS2FWQ5adFfhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=nJ6g30Lj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso12859685e9.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Feb 2025 14:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1739140424; x=1739745224; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=duXjXnbM62DysI4qooaPXahdOWhIB0d6HrRdQoSPGQY=;
        b=nJ6g30LjCirc4njoV0VjYnViso6iXTJQLg5KLJJYuXT6QIu9n2lq6GJMY5m81luabc
         3V0fIH5v9H111M9Az3P4iq+jlhBsyTaGRMKtzjwfUvZDo9jbR1vTOpku+6c6RwrO/JDs
         8B17vI9pEulMdiZ5nHkz2EIu3K7NrhLot9nYo0FzPTCajVrZDQ9CNsyO+Vxwe2g9Z15d
         3d0loEVDl/CAMs1Y+In8cYiiODNEG01/zLHTJcy6G1EGwRQHiUUZtvv3J9QaiWvnH0Dq
         TjVGaBLLDY3z4tuZTs6+So8UxgSYHmStbId76ichYSvKEIkXdZQ/ZteTs+g28HvmKBCe
         GV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739140424; x=1739745224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duXjXnbM62DysI4qooaPXahdOWhIB0d6HrRdQoSPGQY=;
        b=KeYyWl1ymlwD7h/7YRcKNgQflEdel7nrcJwIaAgN0QJ/5rbKe3tF/ZSDG6+EAF4xd2
         g0nrQtw0dtsjDZhWgnD8HtGQSVaul97Qste/6FDgjfVa2zRr8jTZTwD2PrJ76369fUvT
         69qM65WTqkVBImnnIcgAYuCQDHyxFMIQ6Fajg18oEfGeYs1hAhAA8YZbDfvjlMHAjMof
         1qs8iz68QpCE41CdzMRvgKjfVoZ31GozTbOmwWRww/PqDMPzph+XckXBmXagHe8VDC/Z
         qJ3ju2C4qL59NnX2Oe/lgA91AFJTp3RBDwnuYIpM7cNNp9H3G/nBlu1zu73+5Pvi51D+
         +ncg==
X-Forwarded-Encrypted: i=1; AJvYcCUlxOeqBxIzjWfr7euxQhhfQW1yZ9vTJ8KsOMktQxlCgQ0k7+XDavucJcd5aucDTb9vrO7msyCIQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQ5iSbi2+8RJzyms4BrVzREg4jf9ZrDJkXKw5c8qaAi9jIIhf
	8N0RHftfqUKZUAYT/YPYhHXVOTuHBP5YL4t7QwykKtnhT/nxXe/UCBYYot4OGHE=
X-Gm-Gg: ASbGncub+LOI/4N+7dyF/XqbeW6AM0FSKG3377eevHOqI73G6gAlY6DRZ3zJmpprZc1
	YTH0N/J04LQEtO3kg3NurjC5b6DFJPfwDJ4pZBp+66EagN1KpeA4Nmaptt72+K/wWyh9Bao/mCH
	K6BoWGLi//fWRhLCUbNgDEwq38Fsh9hzL94Y+BYlavStveuqb1JPw5zcI8B0tRhQV/fR0pwPYYt
	TfIKoQhjO+n+Ly5KETYpH2Gj4Op9uWI3pcZOdp/TJXr400wnz5GBend+ibNAxKU6KO/8h1Kn+M/
	1OgwwXxQdKEaNA1AUTj0kOHkSOgX1KP/ocW4EVaKJeVTm73gI9zayBteHppGrVc8Nlud
X-Google-Smtp-Source: AGHT+IEB9J7x5rWSAxdzxoM5bZVttLHbnLt+Pou177UacCJ0/autU4OuH6vfhczYJeafLOxd4akORw==
X-Received: by 2002:a05:6000:400f:b0:38c:5bc1:1f03 with SMTP id ffacd0b85a97d-38dc8da6dd9mr8384874f8f.7.1739140424018;
        Sun, 09 Feb 2025 14:33:44 -0800 (PST)
Received: from airbuntu (host109-154-33-115.range109-154.btcentralplus.com. [109.154.33.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d933523sm163902735e9.1.2025.02.09.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 14:33:43 -0800 (PST)
Date: Sun, 9 Feb 2025 22:33:42 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Anjali K <anjalik@linux.ibm.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20250209223342.4f2akan6ctxhzsdg@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ae65e4aa-3407-4fb0-b1f1-eb7c2626f768@linux.ibm.com>
 <fa2f15b1-1602-4fd0-80ff-9d33303b7b5a@arm.com>
 <a1cac0d3-c17d-478e-8a6b-40399a9428b6@linux.ibm.com>
 <886aa016-a439-4981-892d-3e92df526f41@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <886aa016-a439-4981-892d-3e92df526f41@linux.ibm.com>

On 11/25/24 12:02, Anjali K wrote:
> On 19/10/24 00:02, Anjali K wrote:
> >> Do you mind trying schedutil with a reasonable rate_limit_us, too?
> > I think the schedutil governor is not working on my system because the cpu
> > frequency shoots to the maximum (3.9GHz) even when the system is only 10%
> > loaded.
> > I ran stress-ng --cpu `nproc` --cpu-load 10.
> > The mpstat command shows that the system is 10% loaded:
> > 10:55:25 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > 10:56:50 AM  all   10.03    0.00    0.02    0.00    0.18    0.00    0.00    0.00    0.00   89.76
> > But cpupower frequency-info showed that the system is at max frequency
> > root@ltczz10:~# cpupower frequency-info
> > <snipped>
> >   available cpufreq governors: conservative ondemand performance schedutil
> >   current policy: frequency should be within 2.30 GHz and 3.90 GHz.
> >                   The governor "schedutil" may decide which speed to use
> >                   within this range.
> >   current CPU frequency: 3.90 GHz (asserted by call to hardware)
> > <snipped>
> > This is not expected, right?
> > I will work on finding out why the schedutil governor is not working on
> > this system and get back.
> Hi, I found that the schedutil governor is working on this system. I 
> concluded this because when I printed the util parameter passed in
> get_next_freq() when running stress-ng --cpu `nproc` --cpu-load 10, the
> util parameter was always 1024 ( equal to the cpu capacity) and so the
> frequency gets set to the maximum as expected. Adding `--cpu-load-slice 10`
> to the stress-ng commandline, I got lower util values and found that the
> frequency is being set as per the system load as shown below:
> 
> +-------------+------------+------------+
> |  stress-ng  |    avg     | run-to-run |
> |   load %    |  cpu freq  |  std dev%  |
> |             |    (Hz)    |            |   
> +-------------+------------+------------+   
> |     10%     |    2.80    |    1.51    |   
> |     30%     |    3.53    |    2.47    |   
> |     50%     |    3.70    |    0.01    |   
> |     70%     |    3.61    |    0.08    |   
> |     90%     |    3.54    |    0.04    |   
> +-------------+------------+------------+  
> Note that the frequency range for this system is 2.3GHz - 3.9Ghz.
> 
> The results with the schedutil governor for the same set of benchmarks is
> as follows. Each benchmark is run 3 times:
> +------------------------------------------------------+--------------------+----------+--------+---------+------------+
> |                     Benchmark                        |      Baseline      | Baseline |Baseline|Baseline |Regression% |                                                                                          
> |                                                      |  (6.10.0-rc1 tip   | + patch  |        |+ patch  |            |
> |                                                      |  sched/core)       |          |stdev % | stdev % |            |
> +------------------------------------------------------+--------------------+----------+--------+---------+------------+
> |Hackbench run duration (sec)                          |         1          |   1.01   |  1.60  |  1.80   |    0.69    |
> |Lmbench simple fstat (usec)                           |         1          |   0.99   |  0.40  |  0.07   |   -0.66    |
> |Lmbench simple open/close (usec)                      |         1          |   0.99   |  0.01  |  0.04   |   -0.51    |
> |Lmbench simple read (usec)                            |         1          |   1      |  0.23  |  0.41   |   -0.05    |
> |Lmbench simple stat (usec)                            |         1          |   0.98   |  0.13  |  0.03   |   -1.54    |
> |Lmbench simple syscall (usec)                         |         1          |   0.99   |  0.89  |  0.69   |   -0.59    |
> |Lmbench simple write (usec)                           |         1          |   1      |  0.27  |  0.80   |    0       |
> |Unixbench execl throughput (lps)                      |         1          |   1      |  0.44  |  0.13   |    0.17    |
> |Unixbench Process Creation (lps)                      |         1          |   0.99   |  0.11  |  0.13   |   -0.68    |
> |Unixbench Shell Scripts (1 concurrent) (lpm)          |         1          |   1      |  0.07  |  0.05   |    0.03    |
> |Unixbench Shell Scripts (8 concurrent) (lpm)          |         1          |   1      |  0.05  |  0.11   |   -0.13    |
> +------------------------------------------------------+--------------------+----------+--------+---------+------------+
> I did not see any significant improvements/regressions on applying the patch.
> I ignored the Stress-ng and Unixbench Pipebased Context Switching
> benchmarks as they showed high run-to-run variation with the schedutil
> governor (without applying the patch) of 10.68% and 12.5% respectively.

Thanks a lot for running these tests and sorry for the delayed response. Life
got in the way and could only now manage to look at this again.

Cheers

--
Qais Yousef

