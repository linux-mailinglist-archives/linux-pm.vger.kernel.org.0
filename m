Return-Path: <linux-pm+bounces-14472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C897CC0E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33974B225A5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853381A01B7;
	Thu, 19 Sep 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IKUfwYHb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447F12E4A
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762140; cv=none; b=prAD5H3dSxQZ2t/6ho9CQpWMaBB7LFYmH/FnTulGu2kE7BPxFn+hRgbHmvWHwtnBhqdfgtK4JIjQc7m9sNtsPYbBbOaJjdH2OOJO7PK0VyH0hZUltgfP0Omm6UQA7tkhxC4xYdaQRan14+AeobhmlXg8xikTwHkGBCku4u6ujvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762140; c=relaxed/simple;
	bh=KC5WkAgO61rI3xilryZW5iRihK+1blzw5avZe81Fhtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JxtTyAIxZX4/h/HDfnFmGdwaQ2A6k1b3/TTvQJs2uoeCzaenS+siO3p7V8697u6qJ65ICjgEicOLE6BNFLGAZBS27BnQ0m3kPu0lgKgm/zUOSaizxgPFBQRlr2r2fnhf61S6BT8Cn6tUiJ+AsvWQ0mqiqTLzOsCQsYjAsx0eV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IKUfwYHb; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82a151a65b8so52386439f.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726762137; x=1727366937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TjebIZiMDSMpBBb8yc9XfxDsWOq0MAVdzrKDo66TIL8=;
        b=IKUfwYHb1vBn1HEPAjVWAfuhyHEJWa2BVg762D1WISfFUi7pHmNlzTmgMypFwVwXvx
         pcXM17++8VyyRJ0nRoOmqKommto4h0Q56oA4dxilSC1FWRL3YgYK/5BZTcPV0/FpFFJF
         nl89fiZEd1MjehyXu3ExLt7UQLENxVIsiwwww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726762137; x=1727366937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjebIZiMDSMpBBb8yc9XfxDsWOq0MAVdzrKDo66TIL8=;
        b=eyZ6nbWCyT3+pn1SxlDUl/57l0oYBPfHCKVEyCALht8YUMNeNjrJiQ/ec25FPCTEll
         EQVm5uQj5BmLI0sjDMCSy76dSGOgJMceb69+fCfwb5GLF6yFKLLgK9Bul+bxwDhz1S7z
         RS5CP5NF9lYXlOV7lm941BkSLScLHb3DJuum6pRDLM6oixJhnebaLfFWTGdGVUNI83QZ
         Y3IiCjjx+sV+lwnIoRb2c8BNpz2wapUccAv9RDDUUkkOj6BLFoMSf6ijHXEZIRBLtD16
         xE86BnVkmk2RjWsHvn1n9nKa+XqXBM4UlKITZTEMJI/NF6EM15kJPdXT3jU3Au7KeRQ5
         wLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQmKQ6Fspzk/5eglnqdznahnoYYvsLRsucULIlPrXYmIxzj1BgvTiOxnun28UVoVhzi7qDDz1ssA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwvwGQuGBBZjgFY/oucgla6Q004BKjm9AVff0rY6BNYXSjPRpz
	7TZD++m0oEESgontN+lFqPApG90ehgu3KVbE2hqVMjJdxO+YcrgWpXJfxDfUSYw=
X-Google-Smtp-Source: AGHT+IGuUJG0PrbAJM1QvKO9p4kgNW0W8c0CXmDdLYoOiLJ/dIVrHb1oOYuQV5Xm9rimkAuIdhLG7A==
X-Received: by 2002:a05:6602:6419:b0:82c:ebf2:7aa with SMTP id ca18e2360f4ac-82d1f971067mr2873136539f.14.1726762137192;
        Thu, 19 Sep 2024 09:08:57 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec17e90sm3038192173.52.2024.09.19.09.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 09:08:56 -0700 (PDT)
Message-ID: <7da435e8-6fc6-4f37-bea9-a3f48557625d@linuxfoundation.org>
Date: Thu, 19 Sep 2024 10:08:55 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
 <e4d79b9f-3a8e-4e54-9033-cfb8998d06de@linuxfoundation.org>
 <PAXPR04MB845993F071E47D0C2DC6D0A688612@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <PAXPR04MB845993F071E47D0C2DC6D0A688612@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/24 06:37, Peng Fan wrote:
>> Subject: Re: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
>>
>> On 9/11/24 19:38, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Print out the config file path when fopen failed. It will be easy for
>>> users to know where to create the file.
>>
>> Send these two patches as a series with a cover letter.
>>
>> Also what is changing - you can include what change: use the same
>> subject line in here.
>>
>> The subject line can be improved to say more than fopen() failed.
>> Which file open failed?
>>
>> The message can be informative about which file:
>>    about which file.
>>
>> e.g: pm: cpupower: bench: print config file path when open fails
>>
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>    tools/power/cpupower/bench/parse.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/power/cpupower/bench/parse.c
>>> b/tools/power/cpupower/bench/parse.c
>>> index e63dc11fa3a5..366b20f9ddf1 100644
>>> --- a/tools/power/cpupower/bench/parse.c
>>> +++ b/tools/power/cpupower/bench/parse.c
>>> @@ -166,7 +166,7 @@ int prepare_config(const char *path, struct
>> config *config)
>>>    	configfile = fopen(path, "r");
>>>    	if (configfile == NULL) {
>>>    		perror("fopen");
>>> -		fprintf(stderr, "error: unable to read configfile\n");
>>> +		fprintf(stderr, "error: unable to read configfile: %s\n",
>> path);
>>
>> While you are at it, fix it to use strerror() instead of calling perror()
>> followed by fprintf().
> 
> Seems the usage of perror is in the whole file. Could the conversion
> to sterror() be done in a separate patch?
> 

Yes. That can be a separate patch. Please send them together in a patch series.
I will pull those in after the merge window closes.

thanks,
-- Shuah


