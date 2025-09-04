Return-Path: <linux-pm+bounces-33784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF71B43112
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6D6188DFE5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 04:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F21E9919;
	Thu,  4 Sep 2025 04:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ysla949L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F584039
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959886; cv=none; b=WjReKvPY+pHj86ihv4FW1ERMJ6p11mS8FtrdUxgL+G9o+YmVfpTFYtlruwoY9NEEWywkSvpkyy+D+H9DQYf+A6/DIp1vulXWpe6gkuhkkXQj1a8ZAayST9uMWmdWJXIJJSqwmpDRoEqH2NeCps/tIFNSbdg4ndVUcSuobBoLWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959886; c=relaxed/simple;
	bh=BlocP7MwiM84zTw8l2xU0A4o7JLp4SDHYC7LCxGs640=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmBQGSva2n2N5Yh70anbH0rTGdOZvcS1JMgFpxshNeGPcQUvabmzopYTmbbLmsVLK2LP4OP8ChnFiYCTFdgSEvu134aEUKYzb20Pv51tB83F7a+ibBaMhT4c2DrJ6GdK2JMOVtNbAO95thLXVIQN259Yn5ZvmO+TsFHbtSMFLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ysla949L; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77290e32e26so247854b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756959884; x=1757564684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLY5VEpf6kI9v75HUPtjsvheqw5PZsBr+MuTXkiBsJw=;
        b=Ysla949LTE2Wd9hQIMADanUPTqltvUit+7oflVgEd/Se/UQyVmhMXayyaMJ2CYQx8u
         Q00+AT55YEdldwwLCPIJvP2USYTdphSUPo4LMgX3ywoYzqKQIHrLv501NpPNtgqlIDmS
         wDtzRsGAUVbs43zhDA652V/onOHURDjTfdidwUR3fdmeRf0qt3twcbuX6dpRTu3ZRz/m
         TpZsBbIzOeD3Z7tPcbiCvYIz6GF5IT7s2/+k+BpGuJvSvbbgm3Rvs0/wFgUZQxBuhdi3
         6uNy8QftFIYrW+dPimJHFsFMndozzoSinnbK5E21ZPVHwasYxaAtQ5ik71TrClpFQF6Y
         X6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756959884; x=1757564684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLY5VEpf6kI9v75HUPtjsvheqw5PZsBr+MuTXkiBsJw=;
        b=J5rk9N25ejFSNq9+/T9tNeIUGpYpV4P1om5ivMTqp1FGnFTAwzbHnV+5Qd9/y2T4Se
         LbTXVUO7yiScaKeh7uvu4BAlas4fRIip+mpDcqNy6vZFUc+Xl7jDKwLAYiirLugMUXlw
         YCcNdwXjb4mRLiSv4Mcihjcmyr4iGtMeAbFtCiRtwEvWXUXnh/KisWg/XMteGHE+t95X
         AJm3MrUwsgx5oAgAvCGpb2yOk/Giv4DRJ9Uz8BwEOo8YCWRSzgGvZhCIQ8JPvLYTJOco
         p1DOCg8hE1v8T9Rg3INPE/tehsPbKSAsf62DFeX29jIw60ZQEQb5/TOZ5Yobknsw+ouJ
         bKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZs58qa69h9kJIbzjK+o6pxVgOZDBpf3QVE+/yMrVpqHr+HjOwsirr0RfSMhGEwh9y2KH5DdcIgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2LCyc6PZsBHOx7LpeAqXXaCiZHvI0RHyWkJORC4sMIWLM14o0
	Ck95SqDMCE+c5SlK5RRN/GLY23bc+9PHx/Tcz1Bg3FRvIzK+nJY5+cnChyOOK6znJq8=
X-Gm-Gg: ASbGncs+uzreJBipOHBbQ9XydNif3TZqKkjj6ZBHXxTq/xrEpNfdlD73ujnr0j15NKW
	uV9kMvrbadpmX6dTf9gNdTSg6NzMdzv7twpvUOuosmBgeCp+LhDnqLTRzi7P25Sz7dKwMpXOFnj
	/QHTa5V0A0KoiPCkrRevfOBGBkTp8HrHo4jrG8QuIHmeOdkldEX9VsHKkgBBQNtye47hnfn3d3u
	R54OCKU11mbrU+I3Wa4QmE7r8I3qIMTNI4hKtunc8qLGmx2dvdDd8CTrH0MMCbiff+pdCOb4ada
	TW+9sg+DXgeIfJn+OCLoSma1sgCvHDnXX+auPx0mq9kewXeM9m+/CuvdNeBBX0mHxN9aPkmQtkn
	r45MkUj4dCAaDnVZNy76VHM9Jlb1D4UA/qjU=
X-Google-Smtp-Source: AGHT+IH6SAJ37BO+3kio8PbN58nKVnNdU3sLaoNCLGczjGVmoy/lbBbnmdm+LSrJv42mxLoEdacpbw==
X-Received: by 2002:a05:6a20:9190:b0:248:4d59:93ed with SMTP id adf61e73a8af0-2484d599595mr6862040637.53.1756959884008;
        Wed, 03 Sep 2025 21:24:44 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4e673ad423sm12919546a12.50.2025.09.03.21.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:24:43 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:54:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cpufreq: Clean up frequency table handling
Message-ID: <20250904042441.y6os6koxp5giglx4@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904032210.92978-1-zhangzihuan@kylinos.cn>

On 04-09-25, 11:22, Zihuan Zhang wrote:
> This series contains a set of cleanups around cpufreq frequency table
> handling.
> 
> The first patch drops the redundant @freq_table parameter from
> cpufreq_frequency_table_verify(). This has already been Acked, but is
> included here to avoid build issues with the following changes.

Yeah, this is not okay. You are resending an earlier patch, which is
already Acked as V1 now. You could have just mentioned the link to the
dependency patch here, and that's all.

Don't mix things like this, it doesn't look nice.

-- 
viresh

