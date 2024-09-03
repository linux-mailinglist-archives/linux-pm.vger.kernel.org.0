Return-Path: <linux-pm+bounces-13392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914CA969828
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E67E2872C2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E11A3AA2;
	Tue,  3 Sep 2024 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJ4nHeFU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC019F43B
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354098; cv=none; b=Plg+3FogoeM8VtcofZqP7TTpGbFMothnEIfndacpjWE6+Eurl5ikug2nilBIhOhqBN579JFYYebeKGjk+B8VVhi/CjpY7Iwf1eQ4YwOmudp5YSIlGLDKalJd9E09r1u20colP8rN36IbMeb0pDyScrb6xTSOE3O7GrBsdFg28vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354098; c=relaxed/simple;
	bh=XXc/crLCNHxzSDDZAy6Ddze/85mA/zk8QXL4gwHqt3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/wJ1yPhQR1tCG4vmmmErpxauNPuFoIIt+3h7lADvYqrPm8FfuTWn2Yzq8i+qcwyioRzccG2+5o98OzO1eoFYjf2A7kt+kaTYWmgxP/AqvJOVpXJB+IWIQ3FVcuON6gtGmU3vRf3fqO/2eoI9fg0RNYVZgV9ElWgiHTg3e2WZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJ4nHeFU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d1fa104851so2844417a12.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725354096; x=1725958896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwokYJJ36zRTwb7Es++/p8+iOX4crE17pq6UetC4fjY=;
        b=MJ4nHeFUi0xDMiwI9XuzFqVgEPN79IcIFcczV3Enr/d4bfMPvzg2rwSmgoRRqBtCVk
         czDGfda94LEulrdcFckapJqmwkBCVm/SHxmhy94CiugFxQbttBndP1NXTO7iMfnthdqv
         Ef5TothsreELnYucaCnxyAo/GQe7SE3XtYdthepXzqaFRPEPhdkAKllYiPHSMUwnYYFf
         hGlqWtikPI3XYfPQsQeMUCPtkS+MMjvwCEiiZTPgckvkXdt0Hq9IkZWynpqtMY+g/H0V
         hPa6wFHMYimJe1iK5I1qo+U0tIDFIdUjsXS3Y5eUGSg8mMPfxR3xpqKGaC60LrknqUUF
         1hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354096; x=1725958896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwokYJJ36zRTwb7Es++/p8+iOX4crE17pq6UetC4fjY=;
        b=WFlGciHSErr2iny/Rufcs5vpCdw3p22haOqcjGYNS2rfNfg+IGeD+m33kErf1hzpA2
         sYwTKdcgbqidVv3yUO7bMiqG/kFerg6l/yqhZC8rqqNDOtCbXrGFqxyYUVXWLHLRI6E6
         J9j6SwZoU58xdyYPXMFHznb6mL8bSpoNcq7iCrslvQDUMFBXghTrMLE/gGI0/fnnArNj
         fWwHOvvg7BNoJN7YqzGA1ZlhHO2LXTbeySRrVsGZC+4oFZ3E5GPA44LAR0hMMpcD7hfy
         VOCmVNgZzNTR0gBsbABoZ2aroZjRWprxuNYia7Zrig0QytwRiD+dksU40Xb9gYDOM7GJ
         cExQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuGwEOHR29EJFSC4rHmFpLOtyJAJwlAerdr7Cbas6dPyy37MtiuBoLxS9AIWoAba89eeIJkSP+Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSJZLJpSnhNcym4zyXD327moXzkYTQN0B8nULnr7XyjG9GNzb
	O1ASk2/Ui3k9G9Ss+7Df7ZTDyfWM9UhjZY2/4V3U+dU4uC9IlUA+f+E87JqTtBs=
X-Google-Smtp-Source: AGHT+IHpyFwad5VKly9RnWl8Lsn1HCK4hUN/kvD8gp4deaWLKbgiLnxTpU8gsD2DZXdwowBQlTervw==
X-Received: by 2002:a17:90b:4b0a:b0:2d8:99c4:3cd9 with SMTP id 98e67ed59e1d1-2da7482c876mr189982a91.3.1725354096268;
        Tue, 03 Sep 2024 02:01:36 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b119b3dsm10803545a91.13.2024.09.03.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:01:35 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:31:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Xi Ruoyao <xry111@xry111.site>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH] cpufreq: loongson3: Use raw_smp_processor_id() in
 do_service_request()
Message-ID: <20240903090133.tqmsitybuutzsup5@vireshk-i7>
References: <20240828062459.1853837-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828062459.1853837-1-chenhuacai@loongson.cn>

On 28-08-24, 14:24, Huacai Chen wrote:
> Use raw_smp_processor_id() instead of plain smp_processor_id() in
> do_service_request(), otherwise we may get some errors with the driver
> enabled:
> 
>  BUG: using smp_processor_id() in preemptible [00000000] code: (udev-worker)/208
>  caller is loongson3_cpufreq_probe+0x5c/0x250 [loongson3_cpufreq]
> 
> Reported-by: Xi Ruoyao <xry111@xry111.site>
> Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/cpufreq/loongson3_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

