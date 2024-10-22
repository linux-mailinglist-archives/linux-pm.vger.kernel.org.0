Return-Path: <linux-pm+bounces-16191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B725D9A9A93
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D9DB22FD6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CB450EE;
	Tue, 22 Oct 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mofg4v35"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3F811EB
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581131; cv=none; b=gaeY/21+i8eopkYrQ/Dy3JrDydGWED0zJEFKPV49SjKpgN8i/AHx+FundXDqYzSdfyS/4aegrcfcmhw4/5qOEu79pUtS5SQFdfYyWGMAwVN3oflSxPAlADG0i5eQ1C1RV2cojkLPvTHeSkSCrJthh7KbVi/fugV6DByaZsXtCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581131; c=relaxed/simple;
	bh=zio9BmfNHD1Odx7fkjtRSoDw9rPW60idEUZC0ORxa4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mO7AHS6RxW93anUivjjJwznhd7cgtHS2L4pEQKvhouEaxgXRLDUSFhMYTh0O9hIW0UQMxfY6cwlZReuUfQqLkUG/5BTdLoBheHyAwLywalPOmM/SkqURBR/tra1jPdOXp2EZvuaIJE8nc1UuetAh463unlPNlBS2Q6xqxw9MyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mofg4v35; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb599aac99so51729131fa.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729581128; x=1730185928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hs0dFa0iziE10y5OwFSCs6wt1K3m+4LTffWn8eAhjV4=;
        b=mofg4v35Cf0guZCo59kCdjfd7Z0/NeJszmv0y6xxcyqfEjPV6WVaZZJFiK87B1s/O6
         CnC67lX2XSbNxM5xcoU6/EvErLZUZlXMJjktbABeKo1SGuE/hTlZ21gABFrn9OSrCUTV
         t1oc+z/o6e61F1O6ngLb/lUShaEc18Q4A1X9GmXBar+rK5qOBJ8dSXNBrHqYkGlJuVFx
         PQ4VqU1nrTBCeFsqxQEi7vT7V1Y141l7IWKar7QFpfG8MRnLVf+7tar2TzKO+J2eVOvc
         24h6D83z4/hKbQvcsJX5frpWma5GbiHg0iYMOSAcnUPYjAbL3So0VlkDjUXv/Uyjk0o4
         85RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729581128; x=1730185928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hs0dFa0iziE10y5OwFSCs6wt1K3m+4LTffWn8eAhjV4=;
        b=cFRejY7IxhgW80jSFVngqEpHhNuq5hxkvgp/fhHKT8r63oFaw6QCARkcbROdlR5U/1
         90+1ebn/dX3dFhN3Icmw+QaVWCGULeSipiQrcDCmlD0X7VPUaTmWRmd/LTM016KEVXWB
         4ME8j152ZuZtpeDaZ0EqKy/A+/cacvveE2cRuMCirnZKCK2VKtw70ZagFgFRjOWg9oq9
         /n7kufQreL2SHKPrN738HYreltpubNOflJGkQU2rspl/6wgk5IppZuQAesibjoELcS0q
         iFfT3WhUF/bAIt9anakQ5XR3SvZ3d4f5hiIfmsr9j0x7xu+Cznk5h51+JvfbcQ7VZShH
         kYpA==
X-Gm-Message-State: AOJu0Yxre94nhhbRSL4wpnLIdB0RZ9lBmyL9rOcbjccE5fe+4SJdG5+I
	32clsCphdpmIAy5ELRbbueU+IUd9rgC+cDurzHGJffioGN4eG04e7jXg/2+SU3H2EjFyXLsWXGC
	i
X-Google-Smtp-Source: AGHT+IHzxfSXzY+omY0P5Q0Nx+aSFQIaZLRi0R+qiNJYAswn7SFidy+e9PV1MBWt0QCouE3s7DB9Fw==
X-Received: by 2002:a05:6512:b98:b0:52e:9ac6:a20f with SMTP id 2adb3069b0e04-53a15449604mr6663085e87.37.1729581128096;
        Tue, 22 Oct 2024 00:12:08 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0ba7c27sm5933823f8f.115.2024.10.22.00.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 00:12:07 -0700 (PDT)
Message-ID: <fe159d33-477d-4afa-8bcf-4bf8340a3e92@linaro.org>
Date: Tue, 22 Oct 2024 09:12:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] tools/lib/thermal: Make more generic the command
 encoding function
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-3-daniel.lezcano@linaro.org>
 <73d9ce78-c608-465f-9452-1f309a2e2437@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <73d9ce78-c608-465f-9452-1f309a2e2437@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2024 21:49, Lukasz Luba wrote:
> 
> 
> On 10/14/24 10:43, Daniel Lezcano wrote:
>> The thermal netlink has been extended with more commands which require
>> an encoding with more information. The generic encoding function puts
>> the thermal zone id with the command name. It is the unique
>> parameters.
>>
>> The next changes will provide more parameters to the command. Set the
>> scene for those new parameters by making the encoding function more
>> generic.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> +static thermal_error_t thermal_genl_auto(struct thermal_handler *th, 
>> cmd_cb_t cmd_cb,
>> +                     struct cmd_param *param,
>> +                     int cmd, int flags, void *arg)
>>   {
>>       struct nl_msg *msg;
>>       void *hdr;
>> @@ -276,7 +291,7 @@ static thermal_error_t thermal_genl_auto(struct 
>> thermal_handler *th, int id, int
>>       if (!hdr)
>>           return THERMAL_ERROR;
>> -    if (id >= 0 && nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id))
>> +    if (cmd_cb && cmd_cb(msg, param))
>>           return THERMAL_ERROR;
> 
> It's not in this code but also in older:
> shouldn't we free the nlmsg_free(msg); before returns in this
> function?

Right, thanks for pointing this out

If it is ok, I will send a patch on top of this series to fix the entire 
function


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

