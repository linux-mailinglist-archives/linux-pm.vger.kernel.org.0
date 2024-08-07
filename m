Return-Path: <linux-pm+bounces-11958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA23B949FCB
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 08:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267D01C225DF
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 06:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF41B32C0;
	Wed,  7 Aug 2024 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfXnjQD4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFE1B32AC
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012000; cv=none; b=JFGsbMdqi7lOYnpZtSkiHBmepeKuHAAfyzX07EfQmymiFD6bf4heOI/4CiK34WgUovOP53mgMmZ/eNde0Qqhxf8qAUjDdCciWkXSJySyoA8BqDwD7KuiudYtMCBdfTZjW2ru77INuWWUP2sHm0Q/2kjjVbTvJctgZuhjSrb3kG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012000; c=relaxed/simple;
	bh=SmflkcuMDJIW8naPbm/v9DBM5XF4zog+gRlw/8dQf7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW/uJCugUwGO52OYduTK23IWwqlD+nfT9IJamIX7d3zANIICqJl/owVFlPnk1YL4tKr7/9hzNMLH9HxwkODI0ddg7ZhbDMQRzomI1WW1naA6G5gGrEdm6igGxYqQVsHJjuWz5NVCFm92VAOWUqJxJ0eg56RGjOkBB0hHpgNmYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfXnjQD4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso1094349b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2024 23:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723011997; x=1723616797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xgv4Lz4y4hdpusu1y11h6gCcVe+Xzav2jc2y5Yt+/PU=;
        b=gfXnjQD4z4OArTgSnqqw8Q//IOPBlbqHd4t4YP6Xo61Vp41dB6I3n+2gql3bIgxAJe
         cyVFQmfppiUlgMHSZUKiXM6PTvT6xAugt5vz0/mBlC0hl5raaahaJCq/wLkN8kn09pDe
         m5tpETqd64r/QwVOo4+YrQCUpsJeoOPnfys6bhs0XrwFTzVcCwXyVZCdC716yG3GoJRS
         J78ZiNTHRFg+S/GtGEbcqMo02EVaditHmTDAbLLIUN6Rm5C8pQXNPT6cuoJBB3oosQm4
         g4vQxLzmImOLP+oHDFiZNAVivpc5hDLFuIk62/7z9Zyq5RjIglW7IhnZDemU50vHVY30
         AiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723011997; x=1723616797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgv4Lz4y4hdpusu1y11h6gCcVe+Xzav2jc2y5Yt+/PU=;
        b=l7ZAZjO3OU9UYRfDMRlAfuBb7I752gihvN4ywaE3YVcjFYKBYjKEpckgfEOVsRrE1f
         GJ0wRsp8JEZSFSSrY+LJpFdmeDMDxOUnCm1EO1/YtrfXsWJr6lNCvdti6qaQj1r8OjhT
         9Fq9UEGLwvaIhUaj3fX9EkLgWa3hsavI5g5EJoBy0l3pG/yHlhgAqpXz2N/lhTsa/Uyx
         Zsl4JN0LwnanPuaq6RcOpxV1dewnClP6Fcg4HRU8VmhpswY4+TXCy/Nt68+u+rYh3XyD
         Gln2JTFD3YY4qkMNPfGrFK6Jgu2uFZG7gpORS6h6OODbj5R4tIm9u9+Ogx108NjJ4viE
         Fwxg==
X-Forwarded-Encrypted: i=1; AJvYcCVKqqrpUd+N0lj2HbQ1FZUH4EUxmcX8yp/DsWhQU8kMykoPsUZijrGppPJj6/BC1r/+HWUfBDHtseafXouab6lWaf5XXN9hfq0=
X-Gm-Message-State: AOJu0Yx6F9nnW1jKsBsrJ8s3srCJ++WPOD40Z5PFAgggOYLT4OjDQ9Kv
	Jgj5POk9BzxmVWjE6aniYu0yBjYuD5iGipPiFGRJxKwY51pM2/UHOR8HiBonWyY=
X-Google-Smtp-Source: AGHT+IG20fXp71pe3D6UGQgRh1rVmAZGcmBn1yO/PMuCn4PndSdnVchYjgLooIp6izXKPApmK0kzPg==
X-Received: by 2002:a05:6a20:4323:b0:1c4:8492:88a8 with SMTP id adf61e73a8af0-1c699580a57mr19116232637.19.1723011997207;
        Tue, 06 Aug 2024 23:26:37 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b372e028sm640455a91.45.2024.08.06.23.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 23:26:36 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:56:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] cpufreq: spear: Fix uninitialized variable "i"
Message-ID: <20240807062634.egqwyeqwjpvwjwsb@vireshk-i7>
References: <20240805202042.3229190-1-robh@kernel.org>
 <20240806044928.2j6z2ucnzk6lg5y3@vireshk-i7>
 <CAL_JsqLVj2sCuQFYFwR8QnB9jHq_9z4axeNzid1d7+ZrWzmgYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLVj2sCuQFYFwR8QnB9jHq_9z4axeNzid1d7+ZrWzmgYA@mail.gmail.com>

On 06-08-24, 10:08, Rob Herring wrote:
> On Mon, Aug 5, 2024 at 10:49 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > We don't increment 'i' anymore, don't we need an i++ in:
> >
> >         freq_tbl[i].frequency = val;
> >
> > ?
> 
> Sigh. Yes.

Fixed the original commit with this, hope this doesn't add any new
bugs:

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 777f7f5b3671..d8ab5b01d46d 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -173,7 +173,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
        struct device_node *np;
        struct cpufreq_frequency_table *freq_tbl;
        u32 val;
-       int cnt, i, ret;
+       int cnt, ret, i = 0;

        np = of_cpu_device_node_get(0);
        if (!np) {
@@ -199,7 +199,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
        }

        of_property_for_each_u32(np, "cpufreq_tbl", val)
-               freq_tbl[i].frequency = val;
+               freq_tbl[i++].frequency = val;

        freq_tbl[cnt].frequency = CPUFREQ_TABLE_END;

-- 
viresh

