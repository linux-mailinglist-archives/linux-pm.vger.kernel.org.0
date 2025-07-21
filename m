Return-Path: <linux-pm+bounces-31220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD38B0C862
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977513A539B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C42D9489;
	Mon, 21 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuCa/DJM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8F1DF742;
	Mon, 21 Jul 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113742; cv=none; b=H5AF2paden5lejYV82JxJvySNi1yDEX6fGIKaiUAtdSQEJY4ciLvCuB1XXkVybYApkIykrKaquFBH2QMDgRDDe/7Vr6qUvpXxvHPjCZG5AuF/u1Z52UiXQAGRO9OlnRgbehXHCLtM93ruKynBx4+3D6ApUzmn2t00JpO8hhOv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113742; c=relaxed/simple;
	bh=75iuN3yPbeOMpiSS34AD1qt/4araipS42FE6hGVHkCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZFFHg0OmObZ46pfP9J7LCcxXx/hy1LaHzWdlLfeyiXlPrQM1L3MYegIJhIC+4pss/0W8jZp+d8N7n+VTvSmwoNtOsCnhpZTRp7LAR7yjlhbME/95O5YkmGHZRqkzE8GNHmpByGLtxzTIbJgrihoV5kLybB3KBNudvQQm8a+uS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuCa/DJM; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-23636167b30so40843755ad.1;
        Mon, 21 Jul 2025 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753113739; x=1753718539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LZOIw5e4/d1Ys1vEywwf3rOMyld2a0Motp3dRdK95s=;
        b=IuCa/DJMANeH8mRTN/zrej9sgJHJFiJDGxI5SE0Lixrwcd9Jv6qN37vwEC0YrLxsmo
         w++46J7S5nq2M2UbRdlGUSs2rZ6qQy2IOEypJAM+guY2xE/phnQSveYbVFA6HDtA0CLY
         t04MzhHX1FIr32DvNqlCwTCBNN+uzt4RHC6bHog2QdOOcki/19cTW4/mddyV8st2pHu5
         0Pa6YPIGSRiXMZx2gFnwOEbrvsy4imoEmy1JKmLO8g4e7HaKt+IHatgAAEw+DugDx1+3
         c2qj3XgWu6RSRXDIWFlnq4qnCZraU8hNVqIDo+qCcvNgsAhF8TwNIJ+jenR/JXvN40jO
         JwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753113739; x=1753718539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6LZOIw5e4/d1Ys1vEywwf3rOMyld2a0Motp3dRdK95s=;
        b=Aeo1NfDU4wMG7nazIVyXcFlP8jN2ccHmHJ9Dyzz5KfZo9CbXPmXifw627YA/v6KANI
         S+5040bsLMEW6/7cWTyAWAvs3TMvPSKPw0CvsEZyV9gQzD8q+shGySD4LzijW3sd0XBg
         9Xk7lOmPU3dlVxjJK8zBWfeXMYm0ZFA2QCgqP8foDMcdP5hdl1JzfM5sUBWLiFqJgL54
         d/41IGWupJREhvGuv12f+HermuoNOp04qNG6C3viMkTLN0Dpm9Kam2U31rI5tTQsmVhm
         mK1CVJkVsjkD46YLRSoFdgR+ETzlZclkRp4AXpLFgE/W8WbMqmZOV9lnlDORenl3bO1V
         CRdg==
X-Forwarded-Encrypted: i=1; AJvYcCUZFHPyT9rt+xedrPIYcxmb+pGgrt3YjsmwhHN365qt2esEf7M8FEiNmdSmUudEo6yV4fUx5v0GW3LCLEQ=@vger.kernel.org, AJvYcCX88YbsvfgM6Wo+u8J0VD9rl8xNCkeEk2hk5z+N/CKLS4m1p4eHkdJD/XlJ739JDWAHzrOLy7Gj60E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECn0JIr0YIpU3Fs/KUAAhNy4GMPKFBBCQuiR3rfckbBxKl+On
	r2W3eJywzySufKE+rjpZFLNRif+48wpArrpXatweUsRXThmf4Jxn7+TTuiMpRHJMO0c=
X-Gm-Gg: ASbGncufwNETU7K8ViDCICZ5NYZ+yF5GzZg1VmWJDi+CiCj24m/MTbdcdrseCybD99i
	WgsUzmLK6nRFkruxExYBWJ8pz/YpxHw4m2LW1hiNDi0vQrdtbuwMxKKpuXJ8sSVYeAGUBTBmnLG
	mRU5RHIqJ1EDxWVRveBlMGnqa6sXwKL2lwDbmQu4Kxb3/6gw/+GDtbuJ1JGfKIhtVfYJri19SUV
	MLqlNyf7eMsGMybzMTawor1K9hTwKCj2JvwZt4j7ka6FrFnjJC1feE2YaTPdZK+MAZuzyNTJS/3
	27FyVdukiKONgyzfDEbHgUue1kq+M0xCRYDM+QILVoZQdXJLXIblv48j7dnZsaEZgsVUQW/HoMZ
	24sBeqSGTSiLzo+Z/IDtT1TZv1igIF/wuCfGP5q4T3kssLYhc
X-Google-Smtp-Source: AGHT+IFETu42y8ChWlez3rl2QpRCBASMj4fpCrx83eCEmI92ZUEgZEd9o/QS8SOZbmEyNl0aURvdSg==
X-Received: by 2002:a17:902:da8b:b0:238:2990:6382 with SMTP id d9443c01a7336-23e25522cd7mr338406005ad.0.1753113738957;
        Mon, 21 Jul 2025 09:02:18 -0700 (PDT)
Received: from [192.168.1.101] ([223.166.23.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef682sm60013325ad.192.2025.07.21.09.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 09:02:18 -0700 (PDT)
Message-ID: <4581ac35-b879-4d32-91fd-ab486ec4b63c@gmail.com>
Date: Tue, 22 Jul 2025 00:02:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: Avoid creating sysfs link for offline CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250721153656.5103-1-zzhwaxy.kernel@gmail.com>
 <CAJZ5v0iyAWdh=_2jcc7P5umR4T4yoatiK8cE+yT2vTiY87mxxw@mail.gmail.com>
From: Zihuan Zhang <zzhwaxy.kernel@gmail.com>
In-Reply-To: <CAJZ5v0iyAWdh=_2jcc7P5umR4T4yoatiK8cE+yT2vTiY87mxxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/7/21 23:51, Rafael J. Wysocki 写道:
> On Mon, Jul 21, 2025 at 5:37 PM Zihuan Zhang <zzhwaxy.kernel@gmail.com> wrote:
>> Currently, cpufreq_add_dev() attempts to create a sysfs link
>> even when the target CPU is offline. Although guarded by a NULL
>> check on cpufreq_policy, this behavior is not strictly correct,
>> since offline CPUs shouldn't have their sysfs interface created.
> Why?


Thanks for the comment.

The idea was to avoid unnecessary sysfs operations for CPUs that are 
offline, even though the existing checks make it safe. But I understand 
it's not strictly needed — I'm fine with dropping it.

>> This patch cleans up the logic to only add the sysfs link
>> when the CPU is online and cpufreq policy is properly initialized.
> I don't really think that this change is necessary.  Thanks!
>
>> Signed-off-by: Zihuan Zhang <zzhwaxy.kernel@gmail.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index d7426e1d8bdd..0a77892d366c 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1660,12 +1660,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>>                  ret = cpufreq_online(cpu);
>>                  if (ret)
>>                          return ret;
>> -       }
>>
>> -       /* Create sysfs link on CPU registration */
>> -       policy = per_cpu(cpufreq_cpu_data, cpu);
>> -       if (policy)
>> -               add_cpu_dev_symlink(policy, cpu, dev);
>> +               /* Create sysfs link on CPU registration */
>> +               policy = per_cpu(cpufreq_cpu_data, cpu);
>> +               if (policy)
>> +                       add_cpu_dev_symlink(policy, cpu, dev);
>> +       }
>>
>>          return 0;
>>   }
>> --

