Return-Path: <linux-pm+bounces-2906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E60841155
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 18:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11206289FBF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C774C76C99;
	Mon, 29 Jan 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1oUzxO5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB33F9CD
	for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550885; cv=none; b=GmwgnHvwVOSYLC3bqDPrHF697UclM6HgKwo2o37/o6MxFkNVk/oKNSJpqyTo4ttwoqG7bVJqVUtyHYQYNaWIYWQfVqOm5jQKyN33fWdZq68SECMat+Zp5VKo2cnpRNbYNzu+RAPqAjOf53fIxZ1LrFYwiUqWWCaWvqMp7bd8no4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550885; c=relaxed/simple;
	bh=sAiDrWDvVVNWIyyIYoWKyxgVvvGZG7qFK/Y4jjOK1X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ok7vXBp1reAJrgISH3YOlQ49GC78qbLroBfHSPFTgnfpEwyCemHDrvGP5Wm0RqzKeqBo/7DbbDpttNJNYzre0wg4fJf8j3EFAC+vPOOW9Jn/rcTjN0pay6okAsoGly3wmiXlzcAgR6V2O5TC7p2ufvqUjuZA5ODBfR0UtA5ZdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s1oUzxO5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ae53eb5a8so1247848f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706550882; x=1707155682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVR5nbml2aTFOfaqC+3gdwm2ez6gyOkqhxn8ov2iG9U=;
        b=s1oUzxO5TcDKxerv50P2Eu+maFVK90LzeNaoEKygLuTcqRWHzVgIKA+6EbaCSHDlts
         v3oUIxwq5Cq3OIqW6N1R5Ji9yPhsMkdISfY9JvfK/hRYYprgjCUaUOoffyJrweiDNAbp
         C8Yut6D3YV5tuylenpmKonVs1G0E1efBrEnh2A4MtimiblSkfVN//embb3TCplmhQOXH
         nBcCKx9G/WsrWaMa0BIVTtgSBhAytMeGAwwvb+ziXOBL8Km87vkrycMF+4HKnxmktfMg
         2brdOf7WZ1PQihSFjxBiKUh/uWdQrcwOSs1pebA1T38tCJFHggAAo3foGy36DeE6+R+k
         8TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550882; x=1707155682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVR5nbml2aTFOfaqC+3gdwm2ez6gyOkqhxn8ov2iG9U=;
        b=Avu4YjTQS1Dozo9alNesulaPdIo5lwp0ofDWohyEMcIr5otsJfvkt4zqlOftJEcBkB
         L0TACQ/IElNBuB3aEa/t+/qg4otnJ32cDK7DRZH9ygNb7vVoapjIAuEhQTfXn+d73Qsa
         4V8G+5f8Op0MY93/vsKPLmv1vuTxx5OgyaDFJWb2C9aB4zHyTLcSzjyn6hkuBljYf/lA
         ctBijxH9RomHtWQy/oXUu+4XHDlwM8zb4FInqOTT975apSN/Iu4OmK44i3XzWzJVdJJj
         zkVu5zTQEmihaWui3dHy+VNthpJMTlpdbvRc3zb8O+4QFisMZmtQ2a1KTUhn1FpZNBSC
         z61A==
X-Gm-Message-State: AOJu0Yyg3B4E55QlfXv+E543Z9wBn6KaTHWYRMuPMXlaREOANrw5w1U3
	X/7cL/7DAWEFTye9kNHaxPuOX5gJg4MXORB0KSBtamzFy+mx1Ph2OmQVRx6coZ4=
X-Google-Smtp-Source: AGHT+IEauaKrcKGiyoN2Xoj5HFoaMjvt5k+EqMXaiXSNB17XmoJT9k5CaAzrvbvkQlKtnhHo/F+H4A==
X-Received: by 2002:adf:ea4b:0:b0:33a:f024:271f with SMTP id j11-20020adfea4b000000b0033af024271fmr2073808wrn.68.1706550882039;
        Mon, 29 Jan 2024 09:54:42 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id az27-20020adfe19b000000b0033af4fbce50sm1306081wrb.3.2024.01.29.09.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 09:54:41 -0800 (PST)
Message-ID: <a522d8de-c871-4a2e-8b07-d5693abb4a7b@linaro.org>
Date: Mon, 29 Jan 2024 18:54:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
 <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com>
 <d7b82fc8-0ed8-80b8-9eb8-c77f9277178f@quicinc.com>
 <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
 <921c2f90-fb8b-4e70-9e3d-6e185fec03b6@linaro.org>
 <CAJZ5v0h+93YBsYsA5rOvzp+b3JMGyjUStHA=J8P7ynv+-ym-4g@mail.gmail.com>
 <41b284d7-e31f-48b5-8b21-0dca3e23cb1c@linaro.org>
 <CAJZ5v0ina=7R6x6Ff=8_rRR9Kkmz2tkojbs_WWCN=JPmzhg+HQ@mail.gmail.com>
 <CAJZ5v0hM9Y+cV7WrEHe6WjzQ0ATnBce4NO1wxvZh=fcLWPkqKA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hM9Y+cV7WrEHe6WjzQ0ATnBce4NO1wxvZh=fcLWPkqKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 29/01/2024 18:07, Rafael J. Wysocki wrote:

[ ... ]

>> Index: linux-pm/drivers/thermal/thermal_sysfs.c
>> ===================================================================
>> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
>> +++ linux-pm/drivers/thermal/thermal_sysfs.c
>> @@ -474,7 +474,8 @@ static int create_trip_attrs(struct ther
>>                       tz->trip_hyst_attrs[indx].name;
>>           tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
>>           tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
>> -        if (tz->ops->set_trip_hyst) {
>> +        if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
>> +            mask & (1 << indx)) {
>>               tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
>>               tz->trip_hyst_attrs[indx].attr.store =
>>                       trip_point_hyst_store;
> 
> So it looks like I need to submit this, even though I'm not sure if
> anyone cares.
> 
> In any case, I care about consistency.

Yeah, sorry for the delay. I'll have a look at it tomorrow

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


