Return-Path: <linux-pm+bounces-31743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE57DB17EB3
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 10:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AF1580438
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8AF21421D;
	Fri,  1 Aug 2025 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2JfY//8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54916A956
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038727; cv=none; b=b7CaXwL8JmAV+546+lTHLZWBszifLgj2K9ANYA8E8LkntqydfJBWAbIwwMZImxFA6myi7gGSwa12M+/oDM9044r3VbsGfboGjUlVH+vLx8/0fW7Y7gqnxkf09cAcVnSJdv37w3hSe82LLFIlJVO0p9JGV+EdLLvjFu+h1KC/wKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038727; c=relaxed/simple;
	bh=3txe69c4r3/mtA7HOmXZzOu7QHDTYMCFM0j8pcPXR9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haEMi8EUJiy00TxcyspckOH7WJuzxTkRFo5CHQyCPGBH1QYu8uZUKgHvVrFTFuWjMP452yHd7pwkB/O24gIPtswvJ7vi+abXEjzNfzqrV0K/zC0yylwlQZPmV4gfwgQan1Fw1pg6EZDvTvUviX4s1xedL8lTv9TSIJWWqG73x5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x2JfY//8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso328271cf.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 01:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754038725; x=1754643525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JOl1MSYefTojCErZh8qsltNJ6k7ijFO9awKdnwF++pk=;
        b=x2JfY//8EP5VeNUFJgXtn6HcJuAa9Ar6OL1qfVlMCvCgNmDwYw8wHFB0x37mJbfqGP
         w53WmsdH2me48nVC9zAdYjWKxPOKi79AxKy5fLXD1sW1LwAl8KhwNJeTNzbfYYdWwPBC
         RflbSrmM3FPe5WPqb2a49sRW2L6EfHUmarMntAJIkjghRUOkHSyEsA06ixRSCSP+5guS
         PHdDcP1JDHAMRY5DEcsFjsNlpgMAp/Zqh7Gb9xEUTLPidC7Bja0ur9ZFOkogcPC3THT1
         bUIu9Daxph84umtbpAP8Sdfci+p2dPXr0vHxP8hc0TdAEpXwFw8tGKhHj0OE169ebojp
         u/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754038725; x=1754643525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOl1MSYefTojCErZh8qsltNJ6k7ijFO9awKdnwF++pk=;
        b=dgntafL3NobCkZhQop7gSlbJknIpuYgLDtxlNN2OSKJDtWB7eAFRGjvI/605tBE1P+
         JCYLUSd0am2VEaLvDPWi3bJpK2yaUrI44VyileiFE3xrzdQmm2PNtZDBn4XaER6I9s3G
         AIcMq2l4m3nOSVoJzVaRnbAM4FPW6iyAHBWqVIZze+yvqrTgRMYIOmZLfjMEgosQqFkH
         r03zxkp0Q+xBmJribEg44YvmOX9L/c0YFEzvfJZbnzek7EubNQqJ7jf8QrbHt7cJKSfh
         wXfIDrAF5z2RJ3ZfLWDNgVVnGNIF43l6GB/EV+ehvxoCl7kgoeLbMZOMIp+xR8uQxELH
         Dsgw==
X-Forwarded-Encrypted: i=1; AJvYcCUgWBpA3yJOBwAwOnoTajXRQb8KPa9st+MkqapzWJUvpWo63WUR4n7g/u1tb/5JQ1R25EaDwh/Vyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwICPhTeyXi09TcPU0lcqhcJbGxqBEd2aYQxyRteP9AsGt0Qqk/
	6PKWNk+eBZg1cZHFAOpTSOKXVPCsDEr6ZtASd0M42FB5H1uzGULge8swuC8RYxjiiEJVxz4J1Af
	+HGTuSfoxMfuesGl5rmo00MfLY0iZws6TxWENrace
X-Gm-Gg: ASbGncvno9MD8UpxkPxcH3FB/e9oTzAzyqkkR8rqJY3z8dw2+kLPL4RabdKVyGseGdo
	NY5jK7B+fCuM8NZlu/q73YjtdcuyYOqA8gjpwNSTbNe1xbuMAn479rznUlwOU4P6nhmyQmGU/xT
	eAKDbTHnSGq7BNTzMULyKk2b2tlp5z54P7i0jhc4fCqEYNe7agVgMQ19I6yis74I/TECWAMicSQ
	9z+4Bg=
X-Google-Smtp-Source: AGHT+IGZPZiZmkmsedPPxEFK1Zi9PX6A5w9q/2u2I8oM7+JwumozueAl6dLcW1n5UHd4+U/mtefW/B5M2HP0G1G56zQ=
X-Received: by 2002:ac8:5a16:0:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4aefe4c3990mr3789441cf.10.1754038724829; Fri, 01 Aug 2025
 01:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730032312.167062-1-yubowen8@huawei.com> <20250730032312.167062-3-yubowen8@huawei.com>
 <20250730063930.cercfcpjwnfbnskj@vireshk-i7> <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
 <9041c44e-b81a-879d-90cd-3ad0e8992c6c@hisilicon.com>
In-Reply-To: <9041c44e-b81a-879d-90cd-3ad0e8992c6c@hisilicon.com>
From: Prashant Malani <pmalani@google.com>
Date: Fri, 1 Aug 2025 01:58:32 -0700
X-Gm-Features: Ac12FXygzDscixfovYhnPuPs4Q4VoA30a7tpfkC611rVjiBE56c-KasZPY6RYqk
Message-ID: <CAFivqmLr_0BDkMhD4o6box3k9ouKek8pnY7aHX36h1Q9TaT_HA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in cppc_scale_freq_workfn()
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Bowen Yu <yubowen8@huawei.com>, rafael@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, lihuisong@huawei.com, zhenglifeng1@huawei.com, 
	Beata Michalska <beata.michalska@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jie,

On Thu, 31 Jul 2025 at 01:32, Jie Zhan <zhanjie9@hisilicon.com> wrote:
>
>
>
> On 31/07/2025 06:34, Prashant Malani wrote:
>
> Hi Prashant,
>
> The perf counters could return 0 when a CPU is enters a low-power idle
> state, e.g. reset or powered down, and the perf counters are in the system
> memory space (the target CPU is not woken up unfortunately).
>

Thanks for the clarification. Reset and powered down are not typically
considered "low-power idle states".
Please re-word your commit message to specifically call out the "reset and
powered-down" CPU states.

This begs the question: why is this work function being scheduled
for CPUs that are in reset or offline/powered-down at all?
IANAE but it sounds like it would be better to add logic to ensure this
work function doesn't get scheduled/executed for CPUs that
are truly offline/powered-down or in reset.

BR,

-- 
-Prashant

