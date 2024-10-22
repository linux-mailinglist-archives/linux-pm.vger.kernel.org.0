Return-Path: <linux-pm+bounces-16201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489019A9EBF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E873B1F21FCB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEA1157487;
	Tue, 22 Oct 2024 09:42:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078522083
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590140; cv=none; b=OplIRc8yB8EP2fSIACNZuJMarnDPyQ60O+L628hD7no18Xb4WyxA6An/0irbxNHbxjZsV2A1cmBPiVqaZytCQOzDiieyFGkGNhmDpnhdua2jieEO9VRm1/FBWdtp/FbCcjnf6okNUekDhhD1Zc5y6ohRm+c7pxPDbxS28mdFMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590140; c=relaxed/simple;
	bh=VCuJwIGM35aooo9GCH9xCO4LtbkmxnAZ7AuoSRSVd1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oP0wasmQNJwpEz0fgAyQIrAX5pNBBgh2Z/jOYplDk+2OoympQbSZwpDQruc1IZD6qkECQ3ubBHbyV4vv0LDfoTSk1kQJ4tJHnFsW1HuHEa7hH7H09metGutSxkG32lqCKlfR2W4k2a0ZFlUfLIuaxHdw5uvGaPcWdgZQaWXg64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F4B813D5;
	Tue, 22 Oct 2024 02:42:45 -0700 (PDT)
Received: from [10.57.65.67] (unknown [10.57.65.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA23C3F73B;
	Tue, 22 Oct 2024 02:42:14 -0700 (PDT)
Message-ID: <60c9b672-9571-4208-bb68-8e5ac32cea55@arm.com>
Date: Tue, 22 Oct 2024 10:43:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] tools/lib/thermal: Make more generic the command
 encoding function
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-3-daniel.lezcano@linaro.org>
 <73d9ce78-c608-465f-9452-1f309a2e2437@arm.com>
 <fe159d33-477d-4afa-8bcf-4bf8340a3e92@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <fe159d33-477d-4afa-8bcf-4bf8340a3e92@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/22/24 08:12, Daniel Lezcano wrote:
> On 21/10/2024 21:49, Lukasz Luba wrote:
>>
>>
>> On 10/14/24 10:43, Daniel Lezcano wrote:
>>> The thermal netlink has been extended with more commands which require
>>> an encoding with more information. The generic encoding function puts
>>> the thermal zone id with the command name. It is the unique
>>> parameters.
>>>
>>> The next changes will provide more parameters to the command. Set the
>>> scene for those new parameters by making the encoding function more
>>> generic.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
> 
> [ ... ]
> 
>>> +static thermal_error_t thermal_genl_auto(struct thermal_handler *th, 
>>> cmd_cb_t cmd_cb,
>>> +                     struct cmd_param *param,
>>> +                     int cmd, int flags, void *arg)
>>>   {
>>>       struct nl_msg *msg;
>>>       void *hdr;
>>> @@ -276,7 +291,7 @@ static thermal_error_t thermal_genl_auto(struct 
>>> thermal_handler *th, int id, int
>>>       if (!hdr)
>>>           return THERMAL_ERROR;
>>> -    if (id >= 0 && nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id))
>>> +    if (cmd_cb && cmd_cb(msg, param))
>>>           return THERMAL_ERROR;
>>
>> It's not in this code but also in older:
>> shouldn't we free the nlmsg_free(msg); before returns in this
>> function?
> 
> Right, thanks for pointing this out
> 
> If it is ok, I will send a patch on top of this series to fix the entire 
> function
> 
> 

That fine for me, unless Rafael wants a v6 version with those
new locking. I'm OK with both, I will review any version.

BTW I'm still struggling to cross-build or native build that
libthermal, so I cannot give you test results.
I need to sort our the headers and OS packages on dev board...

