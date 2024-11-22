Return-Path: <linux-pm+bounces-17952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3B99D5ACA
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 09:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92AE280FC8
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF918A6A0;
	Fri, 22 Nov 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHz9BAUu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01351741C6
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263190; cv=none; b=NK17nSj1n5kEVHXG8r6kcBTvqYO6CTPxJFk6RWDYilXIMGDXiHj/OtNnH9/APzntByQOThoDPm5WsQac4gJ91xpVfQ8toYSnw6zBSoitplMKqva+GwgYUxF5GN7ZP0Z76J0+Tza5UXCNBt6Zk+nyHBtviuc5/I7nlqaxnMmsCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263190; c=relaxed/simple;
	bh=2cC5+ylqaAyXDN4/QbFBkSVRcxQfIpjqqG260ixa/b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjLmpN1zIqzbJ2bxFYVTCP6c4wBijat3xH1Cy/U9BcWqDnfttlY6Eq6nwxRhc0kJM6nZD9qY4q/NPnRclP3rZyz77uAoit9KYm22lQOU1hSLnGiLwVgDZ3s1MZ4HnBYbJsnL/n/DLVVAvbk4FVs657ieYBa6luWDwjAgpR5oT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHz9BAUu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso1258015a12.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 00:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732263188; x=1732867988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtiM7FGfMA/9Bsc4nOUQdU11ZmJTmqiA1GxS7HwsgKQ=;
        b=dHz9BAUu7Y1/Z9lGnVDXwT5kPGIgQN9zzr0YX0ulX23DdNsDgflpvYzURB5zkwbUL9
         77ebqswHThX2nFRVc8bq8lUtAHMuME18CqIb7W/eA9J+Sp6Yx3rLp0tjiUmiMv/bJsCP
         P4LtGPuR7PgF9BufivCB3tGDYa7GY/vrkdLW1LA6YTPLe4lMvduezQQskMXTAg1Z6uFw
         cnPGwUOnttYFxE+ULLbAoBs3jmL2s5ooJgKcwnrBC5cCiLS9ykJzgA98D7rLXfuDXtZS
         wzpfXvHzlEsiSjpdItsNJ71xwcx9MPN6lK79zIGR36KInb4fJfkl+w+ik3eq3kLhcaLG
         5TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732263188; x=1732867988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtiM7FGfMA/9Bsc4nOUQdU11ZmJTmqiA1GxS7HwsgKQ=;
        b=AmBx2RZaySNdXxjDrdDW/19CIeX/diXHRmCMiBhdQVabKxDxEw7vfxV2YB+eykWq5v
         tJ3JqnBdXP0fuloovNOUVg5jkK/07UbpmFT3R+5un724VSkYMOfT5C5CHhVhW/py0Vot
         3JXsmPTdJCAsldCXBmfDWgNZ/mATOdDyEp3IZ4xyufOCZCBYIQnis2a2LFjMmFYk0zrI
         JNLfgK1B2q6wLZTVM8004Au5huxvrcTp9xFxqFvSpjuV4Ltz+hAJ8ZEB7YBjCBWFNo1u
         92K//kspdcVfoajzS2QM6+11EtADJU0T4YcehpUCnjX91wOQhjcjMZMSE2n0HqhNMoQh
         H8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTPaK4YjXFVfdScoETvufm0z7ZfFRWG79SZySN1w5uvqEjZgMa045stMkq9QB+w8BF4HW9zhDdYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMLDwWsbIqB+fPrdDgmgjuPaX9UIevuNpW4E/fivtzNLA3sON
	1lC6p696S9Ujy69V/J/lUerjsdXMwmnW6mhbPUzyy2RSuYNYfwBMw8OnMNiLUy9Vdp+iXnb4+Sx
	F
X-Gm-Gg: ASbGncs+FJbvhBUG6zMaknvesLI2KWhSJolISLt5aA5Vb5qDtbTqzYzXu2dOXOfekkc
	IWiOGV29XpHM788ta2pQk8LvGJ7hUVIJE4lppvHTpl2SSVgSfNtkFQRLV58AJQBQfEIBTz/Owvf
	0guSPY+oRgp1dABgpM9B4wa8DiELL4G80vQ0rU15BFUqIJquqp8IKUe3kwGt8FteinKq5o7KMbL
	nWBHGHZgb2WURRs8BWWCdoglHAj4zUqLzYo7HLD9RvsTNeyXKs6
X-Google-Smtp-Source: AGHT+IHev06k9pGAl1nqt+OQo9UbIc+5qm1amkYSvGMCzvONl7a9WGyQtu/RSPc8s9vIp3SP7KWhDQ==
X-Received: by 2002:a05:6a21:6d88:b0:1dc:3023:bd97 with SMTP id adf61e73a8af0-1e09e5da6ffmr2314612637.41.1732263186820;
        Fri, 22 Nov 2024 00:13:06 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e2490sm1064181a12.31.2024.11.22.00.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:13:06 -0800 (PST)
Date: Fri, 22 Nov 2024 13:43:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH for-next v3] selftests/cpufreq: gitignore output files
 and clean them in make clean
Message-ID: <20241122081304.j2zbjvmgd2nnfca3@vireshk-i7>
References: <20241122074757.1583002-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122074757.1583002-1-lizhijian@fujitsu.com>

On 22-11-24, 15:47, Li Zhijian wrote:
> After `make run_tests`, the git status complains:
> Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>         cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
>         cpufreq/cpufreq_selftest.dmesg_full.txt
>         cpufreq/cpufreq_selftest.txt
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

