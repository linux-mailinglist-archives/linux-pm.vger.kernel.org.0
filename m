Return-Path: <linux-pm+bounces-17648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC979CF45F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 19:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B532835FF
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F20C1E1027;
	Fri, 15 Nov 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S/Hyl0PH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD81D9346
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696810; cv=none; b=EyK/A5KfeEbSHzMBfqmAtc0uymSJmP4ZydrZDBawAakDOxpr2/v2wOJR6SuSOswnxzs9t2X4oBvrnO4yD2pW6yVokJz/aPoADonBotZha8KEu60z8Fm35BqfoqCgIGHeG4I4+PHXdvaCFU5jo+gucU7MYKo9vOLmsqDZsOjKRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696810; c=relaxed/simple;
	bh=GQ4Qs0p8XMC/WMNPSORrd93CRSeBC/fXwGJrkwfWQFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkluOvc9BdgDs9OZUfzZ233Euu5u++qgFyrHswKLGTmJOQdg6VKCMY+0BhJpUj47eemLZE/kJf9+2FW8uhRDlAzJsiRiD5R7iQhNtHdsMZ8g8r6/VMePR+Qv+JP3RaVELuUYID0w8vXVzMlzG4kw17AodAA97vMW/vZBYR6MoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S/Hyl0PH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so18222316d6.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 10:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731696806; x=1732301606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5elQBFEHbJlxFLK/U8geAkzp/tbJO8V9jLQWafGrL4=;
        b=S/Hyl0PHR7oLcnx+hcpZjhUOZM63QAvA5qXEa4/NIXHXqinMNHpLNW+/owoj9/QpjS
         BGFLBKJzYKrkVydWlW5CTdH2QXnVrgOZb5rVAvOGV66woxCjJj17P5G6iHvvsZBL6mJn
         Z1BpwE05dnb2qdWl6fAqYuMkQYexqP33RTV60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731696806; x=1732301606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5elQBFEHbJlxFLK/U8geAkzp/tbJO8V9jLQWafGrL4=;
        b=ve9gdQof8klFNioHzUT7S83VrQsgyTIeZJk2mZTbItued2R4K9MjCTa+c7tbiIsIeW
         in6pPhmW5rgrEwYvLPFkxfGDl35ac2q3ztSc7otLGUuzhG5W6NvSPDGiLKE6jcP4tIx4
         5W/MstgNMjdm1EU6fdjlGXjwMqz9yxdWl710Khgmed4q4/GhchsIua9XGiQLX0nUkWqn
         ueUBsIv29N4/klJkikBVbuCuUBdofH5UzPx4Vy0inXztOFdNYmr6JvyJGyQdfomIpAPo
         QqmM7SHoNJSs29V+T7XTDlm2HyuBTpgu8Oi0lEnJYu1uUoKntl7hY0D9OB5RVFPW/6CP
         midg==
X-Forwarded-Encrypted: i=1; AJvYcCUxZGgmMju4BTQ1YT+A6/1vEhCEiR9lmD7z5QM54VnD6EJBvbQa2GMmhLVNX5om2lo//pBAc05S1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBuz/z1oHWFyy6bVDun5GEqO/dmuWIAh82F6qfkj8et8VOcan
	3cG/OVOd0oB/JHpVqOD8+LUEDTUAzl3g4I5MkZQnh0GXYXYeR2HvZZm4/fFAKg==
X-Google-Smtp-Source: AGHT+IENzcn3L8l6GMiTpIvz1WW2qSAUSbXEx7SiZS3NLUHADjwn+UVn3VsP/poiLGJW1U8cFqG/Aw==
X-Received: by 2002:a05:6214:4988:b0:6d3:8e50:65cf with SMTP id 6a1803df08f44-6d3fac951d6mr67538556d6.20.1731696806055;
        Fri, 15 Nov 2024 10:53:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee773205sm20958426d6.16.2024.11.15.10.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 10:53:25 -0800 (PST)
Message-ID: <3cd75897-df45-4938-9d19-60df062a5b9b@broadcom.com>
Date: Fri, 15 Nov 2024 10:53:21 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] firmware: psci: Read and use vendor reset types
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Elliot Berman <quic_eberman@quicinc.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Andy Yan <andy.yan@rock-chips.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
 cros-qcom-dts-watchers@chromium.org,
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
 Melody Olvera <quic_molvera@quicinc.com>,
 Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
 <20241018-arm-psci-system_reset2-vendor-reboots-v6-3-50cbe88b0a24@quicinc.com>
 <CAE-0n515sUkmTWptgY8pOaMDBPfDp5pZBy9Nby+4cMdMAnAZfA@mail.gmail.com>
 <20241023092251529-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZzdOOP0KuMMdo64W@lpieralisi>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <ZzdOOP0KuMMdo64W@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 05:35, Lorenzo Pieralisi wrote:
> On Wed, Oct 23, 2024 at 09:30:21AM -0700, Elliot Berman wrote:
>> On Fri, Oct 18, 2024 at 10:42:46PM -0700, Stephen Boyd wrote:
>>> Quoting Elliot Berman (2024-10-18 12:39:48)
>>>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>>>> index 2328ca58bba6..60bc285622ce 100644
>>>> --- a/drivers/firmware/psci/psci.c
>>>> +++ b/drivers/firmware/psci/psci.c
>>>> @@ -29,6 +29,8 @@
>>>>   #include <asm/smp_plat.h>
>>>>   #include <asm/suspend.h>
>>>>
>>>> +#define REBOOT_PREFIX "mode-"
>>>
>>> Maybe move this near the function that uses it.
>>>
>>>> +
>>>>   /*
>>>>    * While a 64-bit OS can make calls with SMC32 calling conventions, for some
>>>>    * calls it is necessary to use SMC64 to pass or return 64-bit values.
>>>> @@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
>>>>          return 0;
>>>>   }
>>>>
>>>> +static void psci_vendor_sys_reset2(unsigned long action, void *data)
>>>> +{
>>>> +       const char *cmd = data;
>>>> +       unsigned long ret;
>>>> +       size_t i;
>>>> +
>>>> +       for (i = 0; i < num_psci_reset_params; i++) {
>>>> +               if (!strcmp(psci_reset_params[i].mode, cmd)) {
>>>> +                       ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
>>>> +                                            psci_reset_params[i].reset_type,
>>>> +                                            psci_reset_params[i].cookie, 0);
>>>> +                       pr_err("failed to perform reset \"%s\": %ld\n",
>>>> +                               cmd, (long)ret);
>>>
>>> Do this intentionally return? Should it be some other function that's
>>> __noreturn instead and a while (1) if the firmware returns back to the
>>> kernel?
>>>
>>
>> Yes, I think it's best to make sure we fall back to the architectural
>> reset (whether it's the SYSTEM_RESET or architectural SYSTEM_RESET2)
>> since device would reboot then.
> 
> Well, that's one of the doubts I have about enabling this code. From
> userspace we are requesting a reboot (I don't even think that user
> space knows which reboot modes are actually implemented (?)) and we may
> end up issuing one with completely different semantics ?
> 
> Are these "reset types" exported to user space ?

AFAICT, they are not, but arguably you already need custom user space 
which is capable of doing:

syscall(SYS_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
LINUX_REBOOT_CMD_RESTART2, reboot_cmd);

in order to utilize the custom reboot mode. I could imagine that with a 
discovery mechanism, a wrapper could be written to check that the 
specified command is actually supported before issuing the system call, 
or even have the system call do that under the hood.

I don't personally feel like this is very important in the sense that as 
long as a fallback exists for an unsupported reboot command specified, 
the system does reboot.
-- 
Florian

