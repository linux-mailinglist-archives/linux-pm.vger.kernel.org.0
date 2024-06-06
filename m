Return-Path: <linux-pm+bounces-8715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A878FE86F
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 16:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FA21C246B9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B74196C6D;
	Thu,  6 Jun 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7SBjxGH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AD19643E
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682850; cv=none; b=N+6478aMim4XEwy4fLw68ZLg5pb9Nvh+w63mhEOPod4b5clwlnrYTiFnbtgJem9r0t66wPmwvUBUBjGa6xeldOCJTR7udsnmJ5oggMCj9elYWcg2NsJTdiuXWkEHi610s6MNjO/60RjbH2YqUrq3aU6hh8qXLbixMzhx1kbVgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682850; c=relaxed/simple;
	bh=4hNVwq7cQHTyBDF20Y8fpBPc7zzCmTIUwUsM/ZBouxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=opEuYYi0qN1Dpj0/JWxtXmi/pE4+vqPfeGzSHl1xRzFA6bFPNUZEIzN5KnbcM4796O5+s33GOA9CQ2/8c4DhjD5WDY6BZ4GIy0S3ZHwMsYUzaHLEQx91kAfC0/4ba44wSsxaBPQO1LfJenj47brW2kP26M6VzLW7bL+SDJASkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c7SBjxGH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6269885572so380453166b.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717682847; x=1718287647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WuYJQB/gpV+Bc6GPW32Ein19OoVtrm6WSZM3VYy51qc=;
        b=c7SBjxGHFa+SkS9v9Wezr2GzfjN2D80NzAMw4SvhK2b3o6z9HzcLT7vNAnidK2AUI0
         hF0XgnqdWWblA0qYLKS8hJdTalqnx7/GH48m6mLr/WttzFWucrnKMXJ715smZzK5lTqR
         ovknSKZZ2wDcPVMSzNaqYy9ptt41M3jSbKfgtA7+bDhjdnYnbvtog9nNnYZS0WPh9gpY
         aqoyEd6ZUHfgRAZqB7PmufRmHJJTetxOt09EASgeQ/alVcohbdixTQaO0Ut5e8Fc8Zrw
         hcQHnzbW1ESbhfvqf5ywcTq9BuanNIaktlo7725Jk3Yzyy/WyCullVjS7IHhXsFt46ks
         7fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717682847; x=1718287647;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuYJQB/gpV+Bc6GPW32Ein19OoVtrm6WSZM3VYy51qc=;
        b=q2CkxfcLLSnA9Winy3zgqL/qxKNFa3cZzXkMqxy+ihUghNcb7wi/Bx8XAjYWfDlQiL
         sSuyW6VLrTkKkbwPo6NfcfQM2gnCFhRfTeHJJOE/v3vx12BnLIsJb0pzfYlQwYeWrV8C
         vdtCW1PPTpGBgvIxhvUR2t91CINPAR1iafRYIWt7GC5nBiDbDfpzhXA9kEuTCmQUChWM
         rAdKoqAMNcFheOstmSCV+W4WC621vu6Hd6qfyWJlt1xFjoQlhosXXkbSzCGcaDN3j3+m
         cQ+TeKqBRcSuei3rlw4xhBf69r7jAjXMoKGAj7Zka/vnErOL5erypStrGWt4OTYAehlW
         qSFQ==
X-Forwarded-Encrypted: i=1; AJvYcCURCv4aKnP5w6BRL6xeIY0tkVZov4iqese2U/i7WI1q3GyaX9Ih0KQsGcK0ksWkytKRxRJy7I+X+ZkUXSl7DBsSSpGknHV/pcs=
X-Gm-Message-State: AOJu0YwpDqUbXx1MTiO8kC3g0Ob1Lpw0UJusxboUli1ig40yQvXtXVU2
	WcsQ7CcvUw6xkAIu6eAE14itHXb2YHsiZMQvHtcwxjEynz5+E7NJpWZpWRhdnnk=
X-Google-Smtp-Source: AGHT+IEJuB2kN44q8dic1aobVJvgm0GkwA2QTBAqO7TjvoBitMWf4fmH36skjlZte8txrFIr5rt98g==
X-Received: by 2002:a17:906:459c:b0:a59:be21:3587 with SMTP id a640c23a62f3a-a6c75f94214mr232595466b.8.1717682845919;
        Thu, 06 Jun 2024 07:07:25 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072ac5asm101513266b.219.2024.06.06.07.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 07:07:25 -0700 (PDT)
Message-ID: <90bb9256-d54d-4e01-aa06-4184e2b95d48@linaro.org>
Date: Thu, 6 Jun 2024 16:07:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/6] Add interconnect driver for IPQ9574 SoC
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, bryan.odonoghue@linaro.org
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
 <ZjXrTywO6+iRaEYk@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZjXrTywO6+iRaEYk@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4.05.2024 10:01 AM, Varadarajan Narayanan wrote:
> Bjorn,
> 
>> On Tue, Apr 30, 2024 at 12:12:08PM +0530, Varadarajan Narayanan wrote:
>> MSM platforms manage NoC related clocks and scaling from RPM.
>> However, in IPQ SoCs, RPM is not involved in managing NoC
>> related clocks and there is no NoC scaling.
>>
>> However, there is a requirement to enable some NoC interface
>> clocks for the accessing the peripherals present in the
>> system. Hence add a minimalistic interconnect driver that
>> establishes a path from the processor/memory to those peripherals
>> and vice versa.
>>
>> Change icc-clk driver to take master and slave ids instead
>> of auto generating.
>>
>> Currently, drivers/clk/qcom/clk-cbf-8996.c is the only user of
>> icc-clk. And, it had exactly one master and one slave node.
>> For this the auto generated master (= 1) and slave (= 0) was
>> enough.
>>
>> However, when drivers/clk/qcom/gcc-ipq9574.c wanted to make use
>> of the icc-clk framework, it had more number of master and slave
>> nodes and the auto generated ids did not suit the usage.
>>
>> ---
>> v11:	No code changes
>> 	Commit log changed for the first patch
>> 	Added Acked-By: to 3 patches
> 
> Can this be included in your driver changes for 6.10?

FWIW there is still an open discussion at v9
<CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>

Konrad

