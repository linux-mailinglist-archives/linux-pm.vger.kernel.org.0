Return-Path: <linux-pm+bounces-12761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F20295BDF8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 20:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7CEB27CBE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9861CFEA3;
	Thu, 22 Aug 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il6XOhcm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579043165;
	Thu, 22 Aug 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349956; cv=none; b=QiCFVaQc1aBvU4VM7BbIyuVzy2GCRPPfcI8pbEmoToaR3jaMGFxJI01U5NK47utBqpAanWmSD2iz4ozwtfjAXVpw8C0jtA9pEXzQfF0hGBqc9roOc2ncD9Uu7ClYJOfDUvEIMjKulWMM/oNlZHUWfj1A8Nl6EjCsyvxV9ywqfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349956; c=relaxed/simple;
	bh=xxDajwvWaTQZsm5XsfIXvuOow4CpGD7cab9sLV4lt9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ2SXjLxD+cQ+a+JEebD4Mczr8BVrGe89jUg0uTzeWzwn9IXgL8eZySgcjBuuNVD8Zp0DI5tEyvMrYX+DoM7ZdVyvFZNVz+FsLmyg+aLTi61Dv3AMLso4DLsimVY8KISf5uADkZAEKIk7LOVc9lHwKu3g/pRR5GR5b+V8Al2uO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il6XOhcm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718706cf8aso542049f8f.3;
        Thu, 22 Aug 2024 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724349953; x=1724954753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChkEmDHJpLp22o9Gz9omg/yWXzIelShKRL284UjCVsM=;
        b=il6XOhcmIXXXT5RjreuETwaxk7Gw9tcsM7YWLeGCHdQaWdeNXpSO93WMzcG+zA2q0E
         IETJlv5OQyFC9jKaBz1AermovON9wPEp2T2gn3b0+0y/A1ur1Ttwv4hQYhpr+wz69JqG
         ZdCUmWK/ioF6o7eqGOud071weAQS8zWR468jOEHKpyFmPK4b5iH16NESZ7Z0Zwszh53g
         Siigi3PfvEgWBM5XzF2R6yBI8WN/vV0DVunHFtCTbi9qswkvdPpFbIgiU26H7iz630cj
         IxFJh5R69Q43YWMOYSlroaEMiPj1QBIn8LgQiLC+pPemMEFRHfPLnvQyr8x3FglvFJN/
         Bi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349953; x=1724954753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChkEmDHJpLp22o9Gz9omg/yWXzIelShKRL284UjCVsM=;
        b=YkIRfN2dHe/jLh1oXUluaquYxKYFxMiF89eFNt1tTcx2nQwEVKpL2x1iq095Q6QKMW
         T5+/4tj4324LuEQQmD/seK//QFUyvtZ8L3/gn8dzKnUVSamwmgcf+rtywKB/Ipft+dJ1
         wnpjQaBdrBOWaggORaUi1HrIV17UaKhmv9f9DHN5Mk5ePRl5LJldM1rwDFgAH06Mwf+b
         eJkOLaEbSYtuxYOLSp9fvdadohe8cBybztyU4uJlEyunkcm6oPt2OuAyxSMnxTFlP69Y
         Qcee735dKqzHQn/1Gbh7Jrqlb8F9QIEMdCgO6ZbSb6sHi3omCyrorXVZB7ZGJbsIIQ25
         DhZw==
X-Forwarded-Encrypted: i=1; AJvYcCVAGKMhrq0l7jcjLFoxG7e4vYFEf6QfEeAjtdWka8Mx60p3CzoYvHS/8o6NMCx8vI1j+fhnOA2+3qqj9Frb@vger.kernel.org, AJvYcCVnd8VvWVxvae+Z/PTrUOQ66M1T+94B27yg3QKg6Z2c3xH64Lkx+EEPHu0gjDlC71rS7+aOnewzg+AKS1U=@vger.kernel.org, AJvYcCWD/rW8e5qvO4smqeFbwKfIUMlFRHogPadyVfE36eh6+MpYZvkdPI2klz+vhix6OU913luL4ktMcimQ9zU+@vger.kernel.org, AJvYcCWVWeD2UeYw0e+9QkrjvHaIy74UsimZ9U6YbC4bjkcLGGChpQou0OVx/cb2snxM9yS2UUXF1pCAD6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQDNeM5PZ1nAFBDnDBvFI/2ojUO57vMsLcn/2G9KDpNAVNm3i
	GgpPdwzuVoAfM4SzfaQGo1tkbiscaZVj/aBhkEs0xQ90uzG141V2
X-Google-Smtp-Source: AGHT+IG98jZeG77SK35etXTcp87ViQArhUinVIMzyVgy9Spb4N3eb60A3B+uTymusmlOwGNs1PYB3g==
X-Received: by 2002:a05:6000:1803:b0:371:9388:2cdd with SMTP id ffacd0b85a97d-37308c1f88bmr1730818f8f.17.1724349952686;
        Thu, 22 Aug 2024 11:05:52 -0700 (PDT)
Received: from [192.168.1.19] (79-100-234-73.ip.btc-net.bg. [79.100.234.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86e9fsm68592305e9.13.2024.08.22.11.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 11:05:52 -0700 (PDT)
Message-ID: <bfb90d04-6885-4623-a846-f04b4fe4bff4@gmail.com>
Date: Thu, 22 Aug 2024 21:05:50 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] media: venus: Use dev_pm_domain_attach|detach_list()
 for OPP PM domain
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vikash Garodia <quic_vgarodia@quicinc.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-3-ulf.hansson@linaro.org>
 <0af670ae-8c8f-4e78-b1e0-e9ccb4fba2c9@gmail.com>
 <CAPDyKFr5xjE867rHRZxtKPr0iKh9B6_Ckyu=B4Jzn-ExDpQjVQ@mail.gmail.com>
Content-Language: en-US, bg-BG
From: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <CAPDyKFr5xjE867rHRZxtKPr0iKh9B6_Ckyu=B4Jzn-ExDpQjVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ulf,

On 21.08.24 г. 11:56 ч., Ulf Hansson wrote:
> On Tue, 20 Aug 2024 at 22:48, Stanimir Varbanov
> <stanimir.k.varbanov@gmail.com> wrote:
>>
>> Hi Ulf,
>>
>> Thank you for the patch!
>>
>> On 23.07.24 г. 17:46 ч., Ulf Hansson wrote:
>>> Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
>>> and manage the device-link, let's avoid the boilerplate-code by converting
>>> into dev_pm_domain_attach|detach_list.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>    drivers/media/platform/qcom/venus/core.c      |  8 ++---
>>>    drivers/media/platform/qcom/venus/core.h      |  6 +---
>>>    .../media/platform/qcom/venus/pm_helpers.c    | 31 ++++++-------------
>>>    3 files changed, 14 insertions(+), 31 deletions(-)
>>>
>>
>> Acked-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
> 
> Thanks!
> 
>>
>> I'll pick it through linux-media.
> 
> Please don't.
> 
> I should have stated that this depends on another series [1] - and
> they need either to go together or we need to defer $subject patch
> until the next release cycle.

Sure, then I guess we will deffer venus patch until the preparation 
series is merged to avoid conflicts. Thank you!

> 
> Kind regards
> Uffe

-- 
regards,
Stan

