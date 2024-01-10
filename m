Return-Path: <linux-pm+bounces-2040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E881C8293C8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 07:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FF1287CBC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 06:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8332C72;
	Wed, 10 Jan 2024 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkckBDl9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011332FC59
	for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da202aa138so3099774b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2024 22:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704869007; x=1705473807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufriYbCxMamJExkyO+DSziDprmr/nvohHV8KvnEcisE=;
        b=GkckBDl9tyDeaKoq1OlLbr6jEBwdbjzMGB0I45CAU6xI+pgxYAVVcgVcq2AKQpBjM7
         3wnDntahFoAcep5K8VnjbMQzSJIofcavO4I7WeCodBVsVW8sbbAy3vuCAA23d10llbWQ
         O0Sa1BdzkP2xMT49yTz2ONeRQ0t3IdlTQum1qPOpfmaOziYsSz+6XZRSr9zXz8ZyI7IT
         OorO6nPNXk+DvFyUSi31O7tQPj6+WQAiDZdAp8KoiEEuE89AijmVyZCZabZe5dKcdwdV
         PbKiXXhbg5q2qGY1BdIQLX4bb8S1WkyNIE0CjOlaKMneYqwUl0Y8joqktrM0wx4EbVEw
         JFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869007; x=1705473807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufriYbCxMamJExkyO+DSziDprmr/nvohHV8KvnEcisE=;
        b=ufIQW2LFsrBr4SqkgLF+tHOl1Gb4ygIklCFJj9JfI/T0A7ghhsOsYOjE8otAcm28qu
         3U+NtcL4dDzSf9BZCbQeFXDtUAl44yTfIXQKF/LuML5PSp/gFKAuriaR83hK7MyXjm+X
         50pAeN6+CVM3jsMn7PaoXWfvb7Lt1DX84SHOI/nnJeUSNGZ4NI8cM2tYoBdEi2LeoftO
         YhM9yHEas+5bqmv/SzWh/ZsHTwVAmDFjNDlaiHp5kjlsre4cqWch5SyqGBmb60kQqNw1
         LJPsLslzh+mCUcwZiqHDZY0JhYMGDwOjtNmxt1SysU0/3qu1ZNtcOw8MSz163JL16Yvm
         3cPQ==
X-Gm-Message-State: AOJu0YyxG/sXHMHY7pArG8qVVbui8rlbFeYjxPpQLLN1k6O1NUx6qagK
	585HzBUvSXM/9zHb2zWibb6Cqr0SnR4OIg==
X-Google-Smtp-Source: AGHT+IHVmZ9O2UiKApFYg6a+2bvUEeNRE+QH24QgnpIssMtERJd0DP+8Dglnh788IGmlXjBYlPjMPA==
X-Received: by 2002:a05:6a20:1682:b0:198:7feb:97ae with SMTP id q2-20020a056a20168200b001987feb97aemr365175pzc.123.1704869007250;
        Tue, 09 Jan 2024 22:43:27 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id n5-20020a634005000000b005cd64ff9a42sm2618582pga.64.2024.01.09.22.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:43:26 -0800 (PST)
Date: Wed, 10 Jan 2024 12:13:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
	daniel.lezcano@linaro.org, amit.kachhap@gmail.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, qyousef@layalina.io
Subject: Re: [PATCH v4 1/5] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20240110064324.bex3ssej5ghie6cu@vireshk-i7>
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
 <20240109164655.626085-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109164655.626085-2-vincent.guittot@linaro.org>

On 09-01-24, 17:46, Vincent Guittot wrote:
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 10 ++++++++++
>  2 files changed, 46 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

