Return-Path: <linux-pm+bounces-4652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C910C870865
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E30E2827BB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4DF61680;
	Mon,  4 Mar 2024 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxjlboZU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD66612FF
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573808; cv=none; b=digjEN5csRTsZTUq6XJ940OtgbWBYMHAhOxK2WcRAEl8eDwh0KU9VGpNgDXwXxbaeiALNVQbuwZy5PAUmoNoyNq1C1S7/EIBKfuvCGSid3Q7EDS+zTuNkXQ/X1zHXSPnjwZcbUNBpDNhvqsHbV2vVF8gyyt9idtCOYVcoVVCiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573808; c=relaxed/simple;
	bh=HpONkFOmk9WCDOiqE/57zwq8lJstKwLF4gqAsKfFXQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYoW8iVYPuuQvtEs2teMlslX8vRE4pHVOMtiF7/Bt+cNoJgygyDqTPumpKLTxZ84tOyTbLAKgnt6MiXAkhV+fWqNln+XI2B97QuPsbF3yyleT+C2P87xobQc/BiLFBAScT5LVkRztbcFVAGR19U5i+YEOkrNiOPNvAaOwk6KFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uxjlboZU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d29111272eso76392231fa.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2024 09:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709573804; x=1710178604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXEvMA5w5rvjI27ttLhue2/cB4ftFG6hZNeiSaW+NeA=;
        b=uxjlboZUO+FUxmOv28QVSxusXalT+RU6CoziCqpGr/MO+6fQTu2mMeiwaToxflNFFI
         7/ihKJgw+S1K6g/v8rsiCOvk41S/iao3iKghg/3G9dOHzJUPpDprlmU6RnnqA2GWZRNm
         fh/e22c6SeTzokGY+gaUrp6aRjgUpEm6N2ATrApUybWiPxRbcwiCgp1EajWjnxz+1Glq
         1T3DljyUwpUsw00925wCSRW1tvTsJONPaqsg8gBCB+q3SJCJcA7oi4aC+xTDKrP+AaZI
         f+EIAwA2gFtDa7qtyPhvPkca+JWvFxu5cS0uecvH8bmd0WvhzpV/dUMFW8A/JzPu/kSr
         NXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573804; x=1710178604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXEvMA5w5rvjI27ttLhue2/cB4ftFG6hZNeiSaW+NeA=;
        b=igf1JnWioUT8+LyRakN+vHkD8OstgSYTz39B0nXWBO4BsL5pDtX7zqZ8m7jxXgxwcZ
         OoZ8hyud7tac2cMDeutZUiohxFwI1YMutoL+7U29R4BAolqO9/vrgbX1AYI4gd60yjWT
         C5AcCKyPapMxIsii8YEbcfvyaS5w6mKDhjaA2CeMbYYTVEYUMEtfPESdqSPT2a8p0Zlk
         3non+WXAXasieyg5QUWX3GzcqWGo6QBrwoBbQ5LvYYzISZWnM652NnTeKXeBdnPT52gK
         9UpO8dpM9dU2bZO0dOfux55IuW6KscSQcoNccvuU3jTJymNfguOEu30v3pbg5V/kyh1/
         /zbw==
X-Forwarded-Encrypted: i=1; AJvYcCUnPXEmFCyXmSEGc3FFq1rOjdIz/aCAWcGlgwA4c1rvXsoAxb1RBQHorHtMTnpfKFy89Jp8BfDaemRma64KnEBAmIoevGykj/Q=
X-Gm-Message-State: AOJu0Yx+XNb+8Z5L0kqZ7l9QB47RtYBb6HClP8criNK/yQnXEyI8lDt+
	ffSUUNFhzyGGWPi9i8HxJy9skOg9q2p7bkspK7LPp+aE0CBmF4dbbWsO1E74Z1M=
X-Google-Smtp-Source: AGHT+IGFq4RAkfHr79J2Xhsh8YYiYxntXslFUyjgCDcsPphD5lS7JnGn6fRFVDEb9nHHQFLLMI1nWA==
X-Received: by 2002:a2e:9ac5:0:b0:2d3:93dd:a192 with SMTP id p5-20020a2e9ac5000000b002d393dda192mr3263691ljj.45.1709573803913;
        Mon, 04 Mar 2024 09:36:43 -0800 (PST)
Received: from [172.30.204.149] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w15-20020a2e958f000000b002d277882eb6sm1827909ljh.83.2024.03.04.09.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:36:43 -0800 (PST)
Message-ID: <98e154f7-a01d-43d0-bd0b-70122ad880c6@linaro.org>
Date: Mon, 4 Mar 2024 18:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: x1e80100: Remove inexistent ACV_PERF
 BCM
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov
 <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240302-topic-faux_bcm_x1e-v1-1-c40fab7c4bc5@linaro.org>
 <20240304164009.GB25492@hu-mdtipton-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240304164009.GB25492@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/24 17:40, Mike Tipton wrote:
> On Sat, Mar 02, 2024 at 03:22:49AM +0100, Konrad Dybcio wrote:
>> Booting the kernel on X1E results in a message like:
>>
>> [    2.561524] qnoc-x1e80100 interconnect-0: ACV_PERF could not find RPMh address
>>
>> And indeed, taking a look at cmd-db, no such BCM exists. Remove it.
>>
>> Fixes: 9f196772841e ("interconnect: qcom: Add X1E80100 interconnect provider driver")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Reviewed-by: Mike Tipton <quic_mdtipton@quicinc.com>
> 
> For some background, ACV "perf mode" does exist, but not as a separate
> BCM. It's controlled by a separate bit in the ACV mask. By default, the
> ACV node only sets the bit indicating the HLOS voter. It doesn't assert
> the perf mode bit.
> 
> Enabling perf mode toggles different trade-offs within the DDR subsystem
> for slightly improved performance at the expense of slightly higher
> power. There are limited use cases of this downstream, where we expose
> control over this bit to clients through icc_set_tag(). It primarily
> improves certain latency sensitive benchmarks, AFAIK. I don't think it
> has much impact on real world use cases.
> 
> This is true for many other targets as well, not just x1e80100.
> 
> Voting for perf-mode is entirely optional and in most cases also
> entirely unnecessary. So, removing this broken way to control it without
> adding the proper control is totally fine.
> 
> I have a local series to add the proper support, but haven't posted it
> yet. There aren't any users for it upstream yet, nor am I aware of any
> near term plans to add them. So, it would be unused for a little while,
> at least. That said, anybody could use it to set that tag on their BW
> votes on the off-chance it improves performance and they don't care
> about the power trade-offs.
> 
> I could post the series soon if there's interest.

I think adding a sysfs entry for toggling this could be very interesting.

Userspace could toggle this based on "power profile"-style settings.

Konrad

