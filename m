Return-Path: <linux-pm+bounces-15574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1C99B65E
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 19:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54B31F22121
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B12C80C13;
	Sat, 12 Oct 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9e3ggNM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181E73451
	for <linux-pm@vger.kernel.org>; Sat, 12 Oct 2024 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754612; cv=none; b=S6mmXsoOIwf9EOXARVhJEn1+nNwYLxgd2Dp4QVetfH1d4dNXbKp08arwafUq5bmnab4hTBYn/CqRdVmStVUE6NfFGUAJxqy4Gg5MukO58xPUEAtX5Yiul+w4bowGmisaKJGZxiVqlR2AkaFIeXd6D5vSgICiU7KAECBg8DWzAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754612; c=relaxed/simple;
	bh=VTFAZUo1jWroJup+5Oj1h3G2EQRSljNLX0E8GCBsdac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCux8QgZUdWx6LKpiAQXt9d5I46FIxA233+RIFowJ7mc7cBrYyvq1azZ87AODnyjKh5Es9fNKCjf+b1GMlcu3s0XDf4o7dMfY2cEgzDizEeFb9lDtSgkpo3PipLRaCQQVe5u5rLBIpx8MANElpX8tlhps9vXjlf/KErFkOSDsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p9e3ggNM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d5038c653so1618963f8f.2
        for <linux-pm@vger.kernel.org>; Sat, 12 Oct 2024 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728754609; x=1729359409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgo5+DAesyu/s+M+VpCsYqJzs884V/twSlVy87GZ0Xo=;
        b=p9e3ggNMm8ou8LuAZhZvd70mj8wpM7RX7AT0fBrNxPnCK+jekvAtA50NpQqQgMzMyw
         x4/RPTQoSweinCexRoHKPWQxB/aCIAcN3sRRZmWPCdmaY8WcWXZwzg8iDCjNJNL7/fex
         41SRG80o0hxzn2btpCEMStjOB42br+uDoqALWJueMOz9uJNyz2X4ec3STzuox5VnCFKH
         r3dandOLvJkgBTy1RuZ3UIb0JdZ7KaEZAngb8bRvsNjtEDX4HuvrhP7MLJMlswYCW7ie
         lDFvhj6I2hcpg7ndluzEzRuFbA81HOLQ6k5NwoW0ShFLThxdrmFny9p1eRcI9aBkFfHx
         OtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728754609; x=1729359409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgo5+DAesyu/s+M+VpCsYqJzs884V/twSlVy87GZ0Xo=;
        b=AAXNNsK0Hb1jykeQRZKnFqasIl7HrhSf4dVIpdReFsvjMHjxW8pkI3z66MtUhrZnxe
         fijffPGWj9xwF/GCkXyb4MCm6eDE+uAYCOcfb6h437OXzXZFQhKgmJsUaEwZJDoqrSSB
         fWYzoOG1YvLIunZi0oWMC8xEj/K7jYfe+atyWgaK2vGg76raR4/3iRb1XutUL66LS252
         IVDxPAUKXP5nFdCreP+ZWZFRyfO8bf9cRs0HISzdG1F0+yvrCrplT3aRoCR0Rt2W4CaI
         ioJFZTWRi5FRj+H3k1nt1/DwD5LHt2NdKYSo1qeQeqprwsWmw+mSvOsBIWbBrFY7A+tY
         oLiA==
X-Gm-Message-State: AOJu0Yycl+WSAeRpS9GFLUJtT3EkztHQQDxvaRLzq8+wpU6LM/GYPRfV
	nYXT/UKyq596SGklngX6uKf9V54h0plcDwykbhIzRyzj8IKkBBeTuszXp/TsZ00=
X-Google-Smtp-Source: AGHT+IH3Xc37kLOKDoz2wLO86kOQR1oYW3JWANAffm5w6Qw6xfMKIPU8G5yqdE5HhDLq6XSSIJO3tA==
X-Received: by 2002:a5d:5351:0:b0:37d:4870:dedf with SMTP id ffacd0b85a97d-37d551d3fc5mr4731093f8f.19.1728754608677;
        Sat, 12 Oct 2024 10:36:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d4b6cfc37sm6790078f8f.55.2024.10.12.10.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 10:36:47 -0700 (PDT)
Message-ID: <a7f39a96-d042-4ac5-99d4-825100a748d8@linaro.org>
Date: Sat, 12 Oct 2024 19:36:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] thermal/netlink: Add the commands and the events
 for the thresholds
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
 <20240923100005.2532430-4-daniel.lezcano@linaro.org>
 <CAJZ5v0gpHpH70YTRpNgPiAtCpkRS6i4h_YS4-a3HL8qLkk9zZg@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gpHpH70YTRpNgPiAtCpkRS6i4h_YS4-a3HL8qLkk9zZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/2024 14:53, Rafael J. Wysocki wrote:
> On Mon, Sep 23, 2024 at 12:00 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The thresholds exist but there is no notification neither action code
>> related to them yet.
>>
>> These changes implement the netlink for the notifications when the
>> thresholds are crossed, added, deleted or flushed as well as the
>> commands which allows to get the list of the thresholds, flush them,
>> add and delete.
> 
> The last three commands need special privileges I would think because
> they essentially cause the kernel to either allocate or free memory
> and they may interfere with what the other processes in user space do.
> For instance, one process may flush the thresholds for a given thermal
> zone while another process is using them.
> 
> What controls the level of privilege required to use these commands?

I would say we can start with CAP_SYS_ADMIN and then if needed we can 
introduce later a new capability CAP_SYS_THERMAL ?

>> As different processes in userspace can interact with the thresholds,
>> the process id responsible of the action (add, delete or flush) will
>> be added in the notification.
> 
> This may leak PIDs between containers which has been pointed out as an
> issue (for example, see
> https://lore.kernel.org/linux-pm/20240704-umsatz-drollig-38db6b84da7b@brauner/).

> OTOH, the thermal engine should not need the extra information because
> it knows which thresholds were added by it, so any other thresholds
> would be added by someone else, wouldn't they?

Ok I will remove this information.

>> This way a thermal engine is able to
>> detect if another process is interfering with the thresholds. A
>> process id of zero is the kernel as it is by convention usually.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/thermal_netlink.c    | 239 ++++++++++++++++++++++++++-
>>   drivers/thermal/thermal_netlink.h    |  34 ++++
>>   drivers/thermal/thermal_thresholds.c |  38 +++--
>>   drivers/thermal/thermal_thresholds.h |   6 +-
>>   include/uapi/linux/thermal.h         |  28 +++-
>>   5 files changed, 313 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
>> index 97157c453630..8d92ebeb72fc 100644
>> --- a/drivers/thermal/thermal_netlink.c
>> +++ b/drivers/thermal/thermal_netlink.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/module.h>
>>   #include <linux/notifier.h>
>>   #include <linux/kernel.h>
>> +#include <net/sock.h>
>>   #include <net/genetlink.h>
>>   #include <uapi/linux/thermal.h>
>>
>> @@ -49,12 +50,19 @@ static const struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] =
>>          [THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]           = { .type = NLA_U32 },
>>          [THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE]  = { .type = NLA_U32 },
>>          [THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY]   = { .type = NLA_U32 },
>> +
>> +       /* Thresholds */
>> +       [THERMAL_GENL_ATTR_THRESHOLD]           = { .type = NLA_NESTED },
>> +       [THERMAL_GENL_ATTR_THRESHOLD_TEMP]      = { .type = NLA_U32 },
>> +       [THERMAL_GENL_ATTR_THRESHOLD_WAY]       = { .type = NLA_U32 },
> 
> It would be better to call this THERMAL_GENL_ATTR_THRESHOLD_DIR IMV.

Sure

>> +       [THERMAL_GENL_ATTR_THRESHOLD_PID]       = { .type = NLA_U32 },
>>   };
>>
>>   struct param {
>>          struct nlattr **attrs;
>>          struct sk_buff *msg;
>>          const char *name;
>> +       pid_t pid;
> 
> I'd rather not add it as mentioned above.

ok, no pid info

>>          int tz_id;
>>          int cdev_id;
>>          int trip_id;
>> @@ -62,6 +70,8 @@ struct param {
>>          int trip_type;
>>          int trip_hyst;
>>          int temp;
>> +       int last_temp;
> 
> Or prev_temp?  It should be less ambiguous than last_temp.

Makes sens

>> +       int direction;
>>          int cdev_state;
>>          int cdev_max_state;
>>          struct thermal_genl_cpu_caps *cpu_capabilities;
>> @@ -234,6 +244,36 @@ static int thermal_genl_event_cpu_capability_change(struct param *p)
>>          return -EMSGSIZE;
>>   }

[ ... ]

>> +static int thermal_genl_cmd_threshold_get(struct param *p)
>> +{
>> +       struct thermal_zone_device *tz;
>> +       struct sk_buff *msg = p->msg;
>> +       struct nlattr *start_trip;
>> +       int id, ret;
>> +
>> +       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
>> +               return -EINVAL;
>> +
>> +       id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
>> +
>> +       tz = thermal_zone_get_by_id(id);
>> +       if (!tz)
>> +               return -EINVAL;
> 
> What prevents the thermal zone from going away right here?
> 
> It looks like thermal_zone_get_by_id() should do a get_device() on the
> thermal zone object it is about to return and then the caller should
> do a put_device() on it.
> 
> Granted, this problem is present already in the thermal netlink code,
> so it needs to be fixed (I'm going to send a patch to address it) and
> this patch will need to be adjusted.

Ok, I'll have a look at the recent patches

>> +
>> +       start_trip = nla_nest_start(msg, THERMAL_GENL_ATTR_THRESHOLD);
>> +       if (!start_trip)
>> +               return -EMSGSIZE;
>> +
>> +       mutex_lock(&tz->lock);
>> +       ret = thermal_thresholds_for_each(tz, __thermal_genl_cmd_threshold_get, msg);
>> +       mutex_unlock(&tz->lock);
> 
> I think that the locking can be moved to
> thermal_thresholds_for_each().  At least there are no other callers of
> it AFAICS.
> 

Ok

Thanks for the review

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

