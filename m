Return-Path: <linux-pm+bounces-30295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC0AFB645
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3B51732B0
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8281D2E11BC;
	Mon,  7 Jul 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm7GOlYa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85652D97AF
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899341; cv=none; b=kEHsHWYxFLpaG/wVMk6Y1tjFT0kN5TOBGBFjvrjR6/AS7MotjdkRmYXu7dxT5Uv3dlVfGbxJnZfq6jfvgTDalR4aB9kkBHASxPk1tGSfof6xlafdvSzGlabN7O6jBl4kMR5o0y8HfOrgT6i0/IAHx615jvrTboGb4lq4l7bGD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899341; c=relaxed/simple;
	bh=WdArDEtLe89Q6g7L4LligwAlwWkbQ5MDMZfw7t5oEXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahiTJvxHINocLsj3djxOrhUobeiJCBl+Rx9kmg0oPjuP8JmGR7VkmB5J7iykYais1bmPh2f8T1g+D4cQvDwgXHBrT2Tbi+pFgxCpWHJmHnaTNxk8SQ4pUJGrNwYtvXDCxYsR5CF5vWOl8s12QxmL7I8zqokIVvSPOcW7w4w6pFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gm7GOlYa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so2707014f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751899336; x=1752504136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PG8mV4pDhYymeozzS82ZZcM9xZV+pEOeW3uE1qROtU0=;
        b=gm7GOlYapgAzIhHWkI9PQZFa/3JYUN7jYeN7v9dgRIDXhT9JPSIZQKhYHHOYEJ/I9F
         xVMxX5vhx1Zixu95kLwJcnYkUvtM9vKTBTa24j73pR0VdQxVSy0pg2+Jhi+gKBMQD3Sg
         iyT7duN/l0rL1wKkdeD+u8vc0d+YpA7kUeNfAzHCIGKhzG1deGPKYANhbRdWsWZYhJjq
         zN/c4ZJGaDvjQGKDxJuHe4Kg89KydPzCUYTZiDARUGVPYFmVRYqV7Yu3CbRNBpmS227l
         akRAwE6vdKJX1sfIhmHb9Ts+o3GKGpJIwhwCyll3554vDzJEp9OO2b+891+7mklueidY
         Ua0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751899336; x=1752504136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PG8mV4pDhYymeozzS82ZZcM9xZV+pEOeW3uE1qROtU0=;
        b=Zuzazn+mBdWsR/f2bgPTJokCzdh64nFwob+eJO9/StArO4kcQGnCwygibLcEFN1TxZ
         Q28GcORkUno9P2WhFFpyobA7n9sRf94fHecpBN3K0HjLHr8KYhdyIJjNOLruz4t2tgVC
         yE1+eJce0Qd5OcfxOCW4Eb27odGoIts8Z+wlyLah5wljUw2PhpxLSKgWSFb9Xh0upw2H
         msGK4R2vKr7w3vm9OdoxuX3LD+P4fMnjeJLs7ESMcag77DspmJ+f9hNM0H4sc2+QOWUf
         dWd0Kmn9iGMd0nzeJVYdIr7NylyxqCyIGhIaPPQFT+mFnXRaS+5dzXkoZlinzehREXtR
         KM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCViTZ3itjuW/2sU9BLbu88Mh5o+n6Kz/u04gQ66kn2xU/WjzkI6e1Pr+EyS23IUJuhE6kObhmv/FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1OZZOgOJ5ZTMEOo2mbb8q5SPs8UXksTjKopzw2WeGyUtaTmb
	6DgD/JtLmXFTQPJpJoUBpRm0iika5P25dDQhcxvAl+utP5SSlJRIjpmbR33gnnt1SX0=
X-Gm-Gg: ASbGncsO906YY90XBEuNxkOprcPMxxK34GX0LsQMsuYzOsCTBRupBABYVeERl2LV+0b
	oENOWdWR9zgGRe0VbP1IfNF+pnSxTio7O92DOy/sC1n6/ZzcrhwPQQTUjr5ocg8Bk4iiqJ0+M7m
	myY1hI2EdPOyvcKu6P/5y1z51bZuVjpTkJdzSLdW71QouWSgmyqqYEbWb7FMEJnO1r26sLkuy7J
	fYEpI96rkqXwbFKmARBuhLA07bI+rRHYjJwcuFD2H3VtMcbbamjrBvDy7DydwL/SGUgqfKC2T8d
	zbKo4H7OdmQ29SZQV6DrZX5A5hgQE9SD1GO1ykuEaHBRPEsCuquZVr87GgCVLXxusDIgbQZ2TW4
	LCHv04wrJ7SKLFy+4YU0ei0giOTJ57Go=
X-Google-Smtp-Source: AGHT+IGyYoZy50qjmAjoyeY/+RRpyL9VdrWvFAUJlbX9qLSoaWQqvRrm9Uhn/ZI8f2iL8dQXzws9/w==
X-Received: by 2002:a5d:6f0a:0:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3b49703dd84mr10413739f8f.55.1751899335190;
        Mon, 07 Jul 2025 07:42:15 -0700 (PDT)
Received: from [192.168.1.159] (p4fc3d4fa.dip0.t-ipconnect.de. [79.195.212.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b968ebsm10252375f8f.47.2025.07.07.07.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 07:42:14 -0700 (PDT)
Message-ID: <fe454257-aa21-4304-868f-aefbea9963c4@linaro.org>
Date: Mon, 7 Jul 2025 16:42:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add Milos power domains
To: Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
 <20250707-sm7635-rpmhpd-v2-2-b4aa37acb065@fairphone.com>
 <06760125-4800-4068-8936-dddf27c28d17@linaro.org>
 <DB5VDDKCAQQG.LDCMHXAZN17S@fairphone.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <DB5VDDKCAQQG.LDCMHXAZN17S@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/7/25 15:49, Luca Weiss wrote:
> Hi Casey,
> 
> On Mon Jul 7, 2025 at 3:23 PM CEST, Casey Connolly wrote:
>>
>>
>> On 7/7/25 12:18, Luca Weiss wrote:
>>> Add the power domains exposed by RPMH in the Qualcomm Milos platform.
>>
>> \o/ codenames!
>>
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>    drivers/pmdomain/qcom/rpmhpd.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
>>> index 078323b85b5648e33dd89e08cf31bdc5ab76d553..e09552a469264f28952fc46c3ab8c125e87310da 100644
>>> --- a/drivers/pmdomain/qcom/rpmhpd.c
>>> +++ b/drivers/pmdomain/qcom/rpmhpd.c
>>> @@ -217,6 +217,24 @@ static struct rpmhpd gmxc = {
>>>    	.res_name = "gmxc.lvl",
>>>    };
>>>    
>>> +/* Milos RPMH powerdomains */
>>
>> I can't find any public docs telling us which SoC is Milos (the only
>> relevant result is Bjorn's email asking you to use that name instead of
>> SM7635). So for the sake of future generations could you reference both
>> names in a comment somewhere? Or even the commit message would be enough
>> tbh.
> 
> I don't know the full list of model numbers for Milos. I assume it's
> SM7635, SM6650, SM6650P, QCM6690 and QCS6690 based on the info I could
> fine, but such info is hard to get. So this is not a definite list that
> all those are actually Milos, or that this is the full list of Milos
> chipsets.

oof, I see... that complicates things. It sure would be good if this 
list was documented in the kernel though imo.

> 
>> Off-topic here, but maybe it would be a good idea to add some Qualcomm
>> platform docs to the kernel with a table of all the publicly known names
>> for each SoC? This would also be really helpful even ignoring codenames
>> just to know that SM8550 is Snapdragon 8 Gen 2 for example.
> 
> So far my source for this has been the postmarketOS wiki, and this
> Google Doc, but the latter hasn't been updated for new chips since a
> year or so, and is also probably not very complete:
> https://docs.google.com/spreadsheets/d/1WrKHLj_oSoiykhSc6xqXAkT3nlD2hq-fzUPSGiq3Kbc/edit?gid=1270863184#gid=1270863184
> 
> And I've got some notes locally for a couple that I regularly need.
> 
> But I'd love a more central place that isn't specific to postmarketOS
> for example. Not sure where though?

kernel docs seem sensible to me? Maybe a wiki on gh/linux-msm?

> 
> Regards
> Luca
> 
>>
>> Kind regards,
>> Casey (she/they)
>>
>>> +static struct rpmhpd *milos_rpmhpds[] = {
>>> +	[RPMHPD_CX] = &cx,
>>> +	[RPMHPD_CX_AO] = &cx_ao,
>>> +	[RPMHPD_EBI] = &ebi,
>>> +	[RPMHPD_GFX] = &gfx,
>>> +	[RPMHPD_LCX] = &lcx,
>>> +	[RPMHPD_LMX] = &lmx,
>>> +	[RPMHPD_MSS] = &mss,
>>> +	[RPMHPD_MX] = &mx,
>>> +	[RPMHPD_MX_AO] = &mx_ao,
>>> +};
>>> +
>>> +static const struct rpmhpd_desc milos_desc = {
>>> +	.rpmhpds = milos_rpmhpds,
>>> +	.num_pds = ARRAY_SIZE(milos_rpmhpds),
>>> +};
>>> +
>>>    /* SA8540P RPMH powerdomains */
>>>    static struct rpmhpd *sa8540p_rpmhpds[] = {
>>>    	[SC8280XP_CX] = &cx,
>>> @@ -723,6 +741,7 @@ static const struct rpmhpd_desc qcs615_desc = {
>>>    };
>>>    
>>>    static const struct of_device_id rpmhpd_match_table[] = {
>>> +	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
>>>    	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },
>>>    	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },
>>>    	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
>>>
> 


