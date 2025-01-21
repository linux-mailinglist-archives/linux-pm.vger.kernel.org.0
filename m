Return-Path: <linux-pm+bounces-20741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E229A17764
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 07:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9FE3A800B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 06:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5F31A2632;
	Tue, 21 Jan 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSyL5MkT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3419E7D3
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737441500; cv=none; b=PCJTru2koWmDGAIJYNdXj+nG5Ox6RXHg7i7vhOAVBxq2KS5mhnz4RBnyhuxj2PKenvJorLBpVI/With7dgYDUc6HkPf6jUCJ2nqUagoBfRsenWPpnCheQZDgN6YzpqyxtNlbxw5qskMxDFuTwcvpzNRLaCJPpJvkd8ywGCG3G68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737441500; c=relaxed/simple;
	bh=l/nvJRdym5+NrLV9hCSmCraq6G7ZYR36R5IuPSuo4aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm3HD+H/A6W/c3awOdx0Q9wtDPWh5QrLbmoQEsAvGuG1zdi4amIzYGwqSfY2X5vOWmIELfEX8UHMigMiqtVJDrFaZOBiC9jmFrkd0T6HKQHlfPP99iO080FiDMUsWnPW6jhh9zyaUm2NIlryYlfFai8ygkdp4h4EEGwmkxgNfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSyL5MkT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so7203467a91.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 22:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737441498; x=1738046298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRufwChv4MdaJHMyB6cyYRQD/TJGCE25RrotEvK53F8=;
        b=lSyL5MkTKmeOeGg4mSm9KlvGfi89AZ6ZhSuJkgA8wf9f/uK/pQiHwTsE37qOatvuhX
         TNgaqTcljyD1N4U6JxgWXpGQjwc9lKhGMmenI1X32nZT0tjqFGqL/LgjWg8oqNLvctH4
         uOKD2arOPLzVpfXLMzxDXmbq79um9p+WCLbAKRa3qXXG9tlz7UrtispcT4tm9MHmjQ9k
         /TQCFhLMNB7V55DpB9KFj3eCe4QZDhUI4cXTnnLY0oXg0URMP6p9E9MV4vPX0OD66eRu
         3eKKVzcnRVTKl0HsJPYnWiGNKBAoAVOIUu3qhHUn4sv5BhD0q9p1fUrIjnRwvuieQVDf
         0l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737441498; x=1738046298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRufwChv4MdaJHMyB6cyYRQD/TJGCE25RrotEvK53F8=;
        b=LO26ziiP5TOBhVWX8meY5sikTk7qRPM/dobUPevmNObyxCnlAnoawN6dPH5cY/4MnP
         p5/aJLxjNcTH+lk9DpuEmPTfKA99LA2neDG2KPC57I/U0y55DqCCUTGLYq5J7RxhOG3S
         /yxT1G7Ef3AWt2ggGPI/a8HxBM2uCg0AjMUNL77hxAJ6yV6dlVopiSQxWT2kXAY8nY0q
         bTzD/4LvohzHbHC9GSd921TP1sVB5Q6YSHLAj9V2a+7DLbm7viPpQfouJ/eVM9ywqytv
         K1EWbu453SpcDOMLYemrfsn/fsDvGUUIQjvRAi8P+qJ5vVveYqPs0CXWaidVE/4EdlRS
         SxUA==
X-Forwarded-Encrypted: i=1; AJvYcCVtT1XCpOtWnrCPZBu022Xy/sa3EZywmyny3gRGqHC5UDJKe8SIP76YH8fT0RxCNQUxaIws64562g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VW30zlHawfBU+f7nxjdxcJ3N9WFlC6GLMRbW8mOYQjiHSYuy
	KA8p9W88wyMKKv8g/6vsAvi8pcbIOegYwk5hIeiSsHBqjz7eFcWTTd4JX1I85aw=
X-Gm-Gg: ASbGnctW0fnL82srjAJtSJbKVzKH1oP5KjyajZvAGAWuUsrmLTESb/PZ3VYS36Fg1jS
	emapA8JgHDZRer61u0DyY48t+tfQ6gv4kXzdH8K+jHfzBJBaazRR1K8I1rbjmwSoN8x+ERWcoEG
	HCk+PMl8cneaBcJHetbBSA6dkDNTD9dQkneOMuzvSkGjpC84pkjNb9MiCJZwl+BYfA+aUCZVDOK
	ni3CZ0oKAFqx1IigDm13hbWvcBsOgOdcH5b4ow8ICoQZlqlDOa9461F0gUQxUlPLLWMIIeL
X-Google-Smtp-Source: AGHT+IEClUaaJoaKoa8wsRdioCcuzH6zZftWsAVTKXgGmWvDnoRtcMd0FcjmRSyQSEktPUTWzRxlgQ==
X-Received: by 2002:a17:90b:264e:b0:2f1:3355:4a8f with SMTP id 98e67ed59e1d1-2f782c4c47emr22836667a91.4.1737441497988;
        Mon, 20 Jan 2025 22:38:17 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77614cba8sm9804112a91.15.2025.01.20.22.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 22:38:17 -0800 (PST)
Date: Tue, 21 Jan 2025 12:08:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, fanghao11@huawei.com
Subject: Re: [PATCH v2 0/4] cpufreq: Fix some boost errors related to CPU
 online and offline.
Message-ID: <20250121063815.ddqh7t2qt32cwx7e@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117101457.1530653-1-zhenglifeng1@huawei.com>

On 17-01-25, 18:14, Lifeng Zheng wrote:
> This patch series fix some boost errors related to CPU online and offline:
> 
>  - patch 1 fix an error that causes the CPU stay on base frequency after a
>    specific operation
> 
>  - patch 2 introduce a more generic way to set default per-policy boost
>    flag and fix a error that causes the per-policy boost flag remians true
>    when cpufreq_driver boost disabled
> 
>  - patch 3 fix an error in cppc_cpufreq that causes the CPU stay on base
>    frequency when boost flag is true
> 
>  - patch 4 remove the set_boost in acpi_cpufreq_cpu_init(), since it will
>    be executed in cpufreq_online
> 
> Change since v1:
>  - remove update of min_freq_req
>  - optimize the conditions for executing set_boost in cpufreq_online
>  - fix another error in cppc_cpufreq
>  - remove set_boost in acpi_cpufreq_cpu_init()

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

