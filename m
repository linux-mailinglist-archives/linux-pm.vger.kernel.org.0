Return-Path: <linux-pm+bounces-27600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C7AC291A
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDD51BA5BF1
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A14C29898E;
	Fri, 23 May 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeQZgAd2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B14081749
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022826; cv=none; b=A43dmA3DpXr63UmRGo7FB0ybJmbRE/NDt0aJ61vKEltxxh9Fu+hkuEQ7ErAd0xzMznVtZUFbvI48pico3089/daqwU3gyKI+L44i2bIOWzAcQ9wT3mXT72Jc3CW22lSsq2JMxhyl96OTwpho/zAMX8pyO7hja5cYE4HmbI2rQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022826; c=relaxed/simple;
	bh=vXYq8BB2rUVZGOa5wTp+SSLFH2/G2/wBeCcy6/RZFME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOI7XqXCG9NZ/f9csH8KwMAIgY/jmZeLxwUQsCVG1SnqC555/7ToEYoNLQJIwNfvlc85egLI0BjtARqsMeNt8ApAN7SwbUpvVB9di7kc2yrwKC41ODOSPpDLpsymHuRx3QM/0jCOxNu1wS4PAdCli9mfDB51BHqLGrxX108fT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UeQZgAd2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a36e950e41so122473f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748022822; x=1748627622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j27xIbPdujh3p9oIQQHW3FhXdAxHTtSk1vtfWEm1vCU=;
        b=UeQZgAd2HrqhaiP88Cl9RsbD/oVetoumGUq1fACbHoMCLg/5GKxHbK7nMP+FahuYTJ
         H+QZ6Qf4XKw6zz3lBSTcnZInj/dGSr+GwxBXJQeimyZGt5T+SIu8mFmtjvIySx7CECEX
         E2po0Nl+fPJMto8S03dSoDxUFH8fdjbjEKj3iq8+/lZuRUhN2say9UykBPa4I4RWGWpY
         2V9gbRxEo1SGAAIgeuBep5oaCWKAP9E8bKG4QmU0BA8JGrtt7EL+4tWhmcN/1MfeKK+Q
         cNMp9G7+eQXUz5HmqgxnjBVPhjzs7yNgPXDWETlNiwx0Kcf2xJU6BdlkPeRU79MJ+uM4
         9LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748022822; x=1748627622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j27xIbPdujh3p9oIQQHW3FhXdAxHTtSk1vtfWEm1vCU=;
        b=q2jibbuwGOLWoR9vRhtWlE+zgJ5I+ve09ByZVytr1Y16IQA0jmUVFIf7I1Qvi+e13j
         CoDZp9MLaKVmEX8T783Ad3l076Slkr+iV65Wi6NKSr4RBwtRVUX9I+3Z9oPRfAm1lSdk
         IX/GSk/uMDpQFlXYQW63SqqBWGLHYA8Cn1eSn3258bPh3quXtBqlR7t+bDbKsz2lb5kQ
         XTpH6rFwP57ZpqtIghrdz6ijdP12pWq51huFrN69kNU54TGXA+K9RNGra+O67hATcn1R
         5PE8VRSOAxzhqRso3+BGGtmYLjRYe29e806MdEU7aXfhMvu4ca/rn86A0MRk/6JUihsC
         1DvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3wt2/plqBDKzIbIoVuH1aDgL0hS7PpcXHW0UAz+OP84z8vbTIhOVmw0kkuju2YPEogYlO7epcQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5rn2GNnNo7X0QjimPZPZdOKlyYH6t54CQ4F/C4Gm8PBU/B0y
	BVjGMRwAyRU4AIFszZ+pIY6gkLFB8SJwy2DfNz64Y8VUfaDu8vXskVcGEQOtiNOFK+A=
X-Gm-Gg: ASbGnct1iQHS+8K1FAAKxifMWZpJBzLufCsq2vfCnOTlXQNK8umXG8vxYVqbsHeIOYE
	5GbJyYK6ZfwnKesBjaFc6lR5jb7bkxAV7tdRUzl4H0zOeSr9AmayVNMchbWcLI93k4/d3UCmgUT
	xCj/Ey+kqMepDgzyCox9q7GKPtqi6iErDc/svQiBSs1+xr4dMdziUzSCUTyjIjAnXeXTjIymU25
	/sYZqzOv2OJ9fxYh0UfLyO9GNFh0rj4iQG+1+puq0m3YUjWKQueAT05XPwqQ8/NIkvUnJM0TmZy
	eZcxznnju0iWdrwSsutV6WlQy2LPdqwtqCumYb00+YGmCrm7bys3+UkIUiJrBUS+k6/qgXrsFNI
	IKAE5uPlanXWyr4Y=
X-Google-Smtp-Source: AGHT+IF+pCJEN6fAtU2OQjQiLzZXS6kTu/snWPWn3LeFtwjKkIRXZRDAPlOO0y0AgoCanNs6EZta+A==
X-Received: by 2002:a05:6000:2489:b0:3a1:f653:85dc with SMTP id ffacd0b85a97d-3a4cb4a9ef5mr231518f8f.58.1748022822647;
        Fri, 23 May 2025 10:53:42 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a8cfsm27604102f8f.37.2025.05.23.10.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:53:42 -0700 (PDT)
Message-ID: <9e494704-6098-463a-932e-f1b8311c4cf8@linaro.org>
Date: Fri, 23 May 2025 19:53:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] selftests: Add perf_qos selftests
To: Eric Smith <eric.smith@oss.qualcomm.com>, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 ulf.hansson@linaro.org, arnd@linaro.org, saravanak@google.com,
 deepti.jaggi@oss.qualcomm.com, prasad.sodagudi@oss.qualcomm.com
References: <20250505161928.475030-1-daniel.lezcano@linaro.org>
 <20250505161928.475030-2-daniel.lezcano@linaro.org>
 <36608326-52c6-4d82-a51a-b802920312b0@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <36608326-52c6-4d82-a51a-b802920312b0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/05/2025 19:43, Eric Smith wrote:
> Hi Daniel,
> 
> On 5/5/2025 9:19 AM, Daniel Lezcano wrote:
> 
>> This patch provides somes tests which depend on a kernel module
>> creating a dummy performance QoS device. More tests will be added
>> later.
> 
> Thanks, I did not see a test where the perf_qos_is_allowed API is used.
> In future patches, can you add a test using the perf_qos_is_allowed API?

Sure, thanks for pointing this out


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

