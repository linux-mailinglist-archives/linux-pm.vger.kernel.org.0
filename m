Return-Path: <linux-pm+bounces-16190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C74139A9A82
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008631C2093B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 07:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66D146D59;
	Tue, 22 Oct 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvgnbERc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3633ECF
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580969; cv=none; b=u75DmsLU5n755z1ZLNXEEoWEmxbqqFo30it/8JU1P+e3VSNHNMVNeCIQIxTRwOgIVsINKvmd6MnKIXySV/HuE4uXa/DTgeAwFLWEiZSNagaxUpzjz04RqgVNBQhftXq9x8AMjKzflqP1DMLFomlt9YJ+3w7szXRDOOrlVXInFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580969; c=relaxed/simple;
	bh=YugLXvrT09Rnhwr93uiJJs6LLzExmao6yYzesuX4V9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3WHSAtMzfrM6xVCzFAfVauRwTCW+r9X0Weav6P9H92LwLa/JyuTlOsoulazUtA1flcgmo1QpRSJAeKwaq/MmKjhKqZwfBbWXK/OOlxuNNnuT/IDginVOcxsKIk12uqMb1YiVelzHvayqFldYg9K94mktujLPnx1fkQtNuyYPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CvgnbERc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d5aedd177so4371549f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 00:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729580966; x=1730185766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XL+pXNxw4VXDHPynO3+ahb7bt3bEfsT6Nw+hlSz+jyk=;
        b=CvgnbERcmUttvBui48RRY5du6Yvyu+co1Ddo1darqSQ/eOlDlrSbVgNyh2Yt1ZwGWC
         s6qCeV8MrrcOI9lw+buhlFTSRpnoPhjf1WRwg75VpbzetrVSeukxSW9TKa9SH0wvWtud
         Aqo90mnQuB1iqvid8aIzO4eW/pZMzFDdYV80UxNbXPFXPUr6vIxUzzOeUV96DY9A2WJp
         gVzmy3vZahB6OtZ1NcZoGsizE1MrF3YRsHen3r1/2W+Z5QRnsOoxJtEWDovWJMD+zUxj
         fR577Ku+6MC7wUH0f4NUi+kv3XKyBcJLEZHg4610NuNx9/2TOAI1GkXJWasNu4lDgcF/
         CDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729580966; x=1730185766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XL+pXNxw4VXDHPynO3+ahb7bt3bEfsT6Nw+hlSz+jyk=;
        b=aXJpro2CKYoGSoND6vPT4ftTfPoUPkiQwoecn01JKe1xnzyxXGgXqGHP9Z5+5rPe4P
         eIHBm87iAwt8SbTurircAHnvHcvcdAXw/fK44lhEUSA1YqmaJSLjGqGHQt2xbfHU1lHV
         wKAfW28gj/DWEy0yr9gWhG5h9oRc3KLFKF0/6iVOAk1lK8owLMgISmxWi3fu0qPejz/O
         LO67u3hMB+U9h3z6ThOgDlJxAGfcDBy9ESYbg5U/nQ7bkejOJg6os7YAX1v+mEGo8u3O
         5fc5O/obYks3xq0xwjz7zAK10fR0nDkn5VfwoE2af/jDBYFVjY+W5QFK+VFeXYIBM0Hi
         eZZg==
X-Gm-Message-State: AOJu0YyVqaTS1rTrynBuZmBSWkJVS3BGbNRF79Tidq9aTkTSqtG9uro3
	ZsvpXYiYWsTUbtAWmaHRvuz3Oyz+wXwEIklmTurhXEPoja3ZeeCH1tIHF8zSKUg=
X-Google-Smtp-Source: AGHT+IG+c/yoQZwAmzocKeBzsq/y68jLVKdtLlT3fbbgXp691SLo7xIkg2qrwZOzf9O1c6Bm5WqURw==
X-Received: by 2002:a5d:458e:0:b0:37d:4706:f728 with SMTP id ffacd0b85a97d-37ef21bb0aamr1150777f8f.50.1729580966222;
        Tue, 22 Oct 2024 00:09:26 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bca9sm5884536f8f.101.2024.10.22.00.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 00:09:25 -0700 (PDT)
Message-ID: <c5df4aae-70af-451e-a1be-57089f5fd848@linaro.org>
Date: Tue, 22 Oct 2024 09:09:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] thermal/netlink: Add the commands and the events
 for the thresholds
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-2-daniel.lezcano@linaro.org>
 <46d25358-bf23-44ec-8350-711252560b89@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <46d25358-bf23-44ec-8350-711252560b89@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/10/2024 00:02, Lukasz Luba wrote:
> 
> 
> On 10/14/24 10:43, Daniel Lezcano wrote:
>> The thresholds exist but there is no notification neither action code
>> related to them yet.
>>
>> These changes implement the netlink for the notifications when the
>> thresholds are crossed, added, deleted or flushed as well as the
>> commands which allows to get the list of the thresholds, flush them,
>> add and delete.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> +static inline int thermal_notify_threshold_up(const struct 
>> thermal_zone_device *tz)
>> +{
>> +    return 0;
>> +}
> 
> These 'return 0' look a bit odd. We usually use 'return -EINVAL' in
> not defined. Although, since we don't check the output of those
> functions  - we are OK. We just have to remember about these zeros,
> one day when we would like to add the check of the return.

The return error really depends on the context of the call site. There 
are other subsystems returning 0 when the service is not enabled (eg. 
cpufreq.h, devfreq.h, device_cgroup.h, etc ...)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

