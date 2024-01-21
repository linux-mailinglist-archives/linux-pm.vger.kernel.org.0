Return-Path: <linux-pm+bounces-2412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1A9833726
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jan 2024 01:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA931C20C85
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jan 2024 00:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4523644;
	Sun, 21 Jan 2024 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="UjPGCFjV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44739F
	for <linux-pm@vger.kernel.org>; Sun, 21 Jan 2024 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705795490; cv=none; b=FSgLZrB4vmHL1oYJ4R5TbBRLK07C2Ihvi1DXU+Vbs8mswBj8FCWEP1yg2vYyoVD9eX0hCmF2DzULxqY4QQUdJ8tsJYy30JaCOFrMPbakuzyQZDxUhf5943fyQt3RbdTtk/fWtG115UYTeAttl31wNsg4T3EC+VCUwB0Oi735OgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705795490; c=relaxed/simple;
	bh=7zYfoge1wGb12dswxvvyl9Z9+xVSot71rsCj7fShR1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPpwZ2O1NLIriqfqlVZBVY76ZR3WE2uSvPZEqjrNCO3stycku3Kr6bHDqtUhHpjfIWsQVQZXO12WJmHCYSKSmtFf2RBddW+tysXLT4B7oS9FM+Fx+4OMEhw/5KfmJpE0OJAqPmPrlwnG4J856hpuoXb52Wv3KZhDE8OdgNCUuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=UjPGCFjV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so25230415e9.3
        for <linux-pm@vger.kernel.org>; Sat, 20 Jan 2024 16:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705795487; x=1706400287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=st7iVNZ+1V2FHY2fuEvOmKbUbqLcSSt8iKDHfulcfHE=;
        b=UjPGCFjVuUwHKMk7opIZM+q44XE0suuL/19K17Hbs1Fk1dn1b0MpqSkTjZ/zSi81xm
         guXLx96EqlzBj8/VSu9QKfpvOj193+jEMYn81Tf+/lCxNP/ZsoLhNUPP3XpeukrkHwKC
         h+pB+Qrs5E3yCSP6t2dXALSFbjCDhj7AN75kKKgReQZSUPfm3dcBw9dIqwJTfdsolOg9
         y+6jPj0qdIS9miGgflPP/S0jpPXQEUIwpH9mxGN4PGzq01CbjMuOBZZZjXmNEUER8/WB
         jCsawl6U9zyZNl4edkuUktCAe/Sj3h1CHqADkTNv5FngzEn6amos0T7oo24wjY963HuA
         S5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705795487; x=1706400287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st7iVNZ+1V2FHY2fuEvOmKbUbqLcSSt8iKDHfulcfHE=;
        b=s3G+PbLsZjQraCGPBTD5RSTpctPULk3zBqihOBu7k+qYHwvHUeaxOZi9C8tsMLbdT5
         HnmQptm6onJllMTtvDeWdnBd5WoLV9a2n5Hc4q9RbgyVoaoQ4j3skC8uWfEWxaPVRCK9
         /LDjHbn7KkgglC38obTDwgxVsYunwIKs4Zo7fGhzeyzohqmoP2Hmb9S9maVb9uoRkdGw
         FA2Wib7XD5rT4OXsOFIlESEbcJ5JMICKHXlD1ZGEIB175iG/bZSX9A940QPys9VwILB3
         gzsWgLxKSN96cyqVOg8iHfxMi3l8rLNNv74TKhZEmqyAryRvt0xe47t7uMDUeWv9Y+ol
         nLeA==
X-Gm-Message-State: AOJu0YyOdGw0fiXlHh5POxx+Tzl8DttafsKU038sjZ3Pk554JH4JLn17
	s1pjxYYEdb7uJtAflo/4sEwkf+gqwx9TjxkPm3zWJVKr/WmEhuRwRo6rmvxKVv0=
X-Google-Smtp-Source: AGHT+IEhr5RVkhton0lM00+Dc1bE3USu+bPMllWNz3bvRVWC6pSpNSSoeDLzOb3k4bTiILyLs6D/Dg==
X-Received: by 2002:a05:600c:310f:b0:40b:5e59:ccdb with SMTP id g15-20020a05600c310f00b0040b5e59ccdbmr1130429wmo.188.1705795486980;
        Sat, 20 Jan 2024 16:04:46 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c020200b0040ea00a0b75sm1255381wmi.0.2024.01.20.16.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 16:04:46 -0800 (PST)
Date: Sun, 21 Jan 2024 00:04:44 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ashay Jaiswal <quic_ashayj@quicinc.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	quic_anshar@quicinc.com, quic_atulpant@quicinc.com,
	quic_shashim@quicinc.com, quic_rgottimu@quicinc.com,
	quic_adharmap@quicinc.com, quic_kshivnan@quicinc.com,
	quic_pkondeti@quicinc.com
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
Message-ID: <20240121000444.ghue2miejmiair6l@airbuntu>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-9-qyousef@layalina.io>
 <a561029e-993d-726d-18ce-0bc014e6533c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a561029e-993d-726d-18ce-0bc014e6533c@quicinc.com>

Hi Ashay

On 01/20/24 13:22, Ashay Jaiswal wrote:
> Hello Qais Yousef,
> 
> We ran few benchmarks with PELT multiplier patch on a Snapdragon 8Gen2
> based internal Android device and we are observing significant
> improvements with PELT8 configuration compared to PELT32.
> 
> Following are some of the benchmark results with PELT32 and PELT8
> configuration:
> 
> +-----------------+---------------+----------------+----------------+
> | Test case                       |     PELT32     |     PELT8      |
> +-----------------+---------------+----------------+----------------+
> |                 |    Overall    |     711543     |     971275     |
> |                 +---------------+----------------+----------------+
> |                 |    CPU        |     193704     |     224378     |
> |                 +---------------+----------------+----------------+
> |ANTUTU V9.3.9    |    GPU        |     284650     |     424774     |
> |                 +---------------+----------------+----------------+
> |                 |    MEM        |     125207     |     160548     |
> |                 +---------------+----------------+----------------+
> |                 |    UX         |     107982     |     161575     |
> +-----------------+---------------+----------------+----------------+
> |                 |   Single core |     1170       |     1268       |
> |GeekBench V5.4.4 +---------------+----------------+----------------+
> |                 |   Multi core  |     2530       |     3797       |
> +-----------------+---------------+----------------+----------------+
> |                 |    Twitter    |     >50 Janks  |     0          |
> |     SCROLL      +---------------+----------------+----------------+
> |                 |    Contacts   |     >30 Janks  |     0          |
> +-----------------+---------------+----------------+----------------+
> 
> Please let us know if you need any support with running any further
> workloads for PELT32/PELT8 experiments, we can help with running the
> experiments.

Thanks a lot for the test results. Was this tried with this patch alone or
the whole series applied?

Have you tried to tweak each policy response_time_ms introduced in patch
7 instead? With the series applied, boot with PELT8, record the response time
values for each policy, then boot back again to PELT32 and use those values.
Does this produce similar results?

You didn't share power numbers which I assume the perf gains are more important
than the power cost for you.


Thanks!

--
Qais Yousef

