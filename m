Return-Path: <linux-pm+bounces-14677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E02986023
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D691F2657E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02374185936;
	Wed, 25 Sep 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDQSeQs+"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F518593D
	for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267813; cv=none; b=iYkYHcgPqEdAuPCdxfK2lb0k+5/LalmfFxP+cCGDNz0S3Utl9MrcWR8SY7ammEsF5pUNhbf8OwTOK6Moh76YAphahlVCdu6i6gkYgx8dWYR36yXcMWIUwHe7N7fEpbckacnhE5gS9fyb1ZvM6oelB7dThRTc+DHNYdiUx/qef08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267813; c=relaxed/simple;
	bh=gQ9ns3v1e+JoVEichbexWd8YKRC7Xlsv9R9WgknrNtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jECfR8kI/K1XI/tsBqPivGWyURfac3xeB84AXR7WwjiAY7ne/X2wQIjBS/w4XGGqRYjPlwLXXHYUM2f0CxfvYqIm4P8k48NkmJyetvJBhnUTL7OZCNzGARd4OQQc6rcHlpvgujPHfXqyYmxcgb9GTUSQwJ8oBMTYAKmJdLUvu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDQSeQs+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727267811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyRMd2ZT8uh48chGGXhpc+Qi9coPe+eqTvOBfCoOaTA=;
	b=CDQSeQs+oeln1S/FpY8JBvWg50PMoWzzYCYL4hok8jEG38ANv1HkHXfvUHs5FXnqodAYG0
	o43844yKTvLtGsjyVGFh1EuCpQY4P0JXiSJGwnTQ7kV7Aq+rwZwy8KR9XAJGG/ek3G8yjf
	ckgmnlz2Rx69Gjv5mA17biL7GwcnED4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-6Bv6F2DpNzWgd_g2nK9EuQ-1; Wed, 25 Sep 2024 08:36:49 -0400
X-MC-Unique: 6Bv6F2DpNzWgd_g2nK9EuQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8711c48990so581236266b.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 05:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267808; x=1727872608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyRMd2ZT8uh48chGGXhpc+Qi9coPe+eqTvOBfCoOaTA=;
        b=Ul1BVaCLGHBkntHTmctPh0WjYX+EiNHK4T8w4up0qjBYlJOup9js/74LoThidS5ogU
         sLieoHRVSG0w7DiG6DOgQdpBjXk6jYMsNMx6hymeWuSNPTtzGsjvmwRmghtZoJWxuuE2
         LAaYq7hqbnuuVzPWroPo/L3zYvr3HgAN4LLMtt+SabHlikAr+grznlfI2NH6haiAoEgG
         B7h+HQ7DLF2M68DRVkLArRCA6gO36Wn7IG7RURVACnFh1Rl7lVgl5/sSdaCnjjv4mDXJ
         ZKT2sMpLvL4vZPFYrCW2+cv4UwG4n8TcFkwDoLJoa2EFW9YdgqziSRkGhmXT5UBMcEFB
         DVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrQaIkXIcTIUxb3mT75aveRVEV3dVAItQDzJ93fhmZnL2tt1IX/FF9xrEnXiEv8IS2UcAIy2Fh+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiiZMFEvyosk67vyyaj5T9ZtOmesvrugoQ0axay11CUNrm9mbP
	o/pOqw5TdYBPN8TGBdo1GYGtjEagO7xpQe2qA4wSzkAa1JzcR36Q7lZizeeXBBw+6XXag6X/v8N
	8Mih2SiwxUIXl8DPINKgAuPN36vvSOm992CjY3HhAcAKsg2ZiFLYBTFZa
X-Received: by 2002:a17:907:7286:b0:a86:7b71:7b74 with SMTP id a640c23a62f3a-a93a06a3e81mr251372366b.55.1727267808254;
        Wed, 25 Sep 2024 05:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv7YOI3w+oy8/4wAMxx/Mhw8ztDgsS5AEoaAxcEGVTbGdlOe+ZtraZbzrnM7BNlsHxiUF9Fw==
X-Received: by 2002:a17:907:7286:b0:a86:7b71:7b74 with SMTP id a640c23a62f3a-a93a06a3e81mr251369966b.55.1727267807769;
        Wed, 25 Sep 2024 05:36:47 -0700 (PDT)
Received: from [192.168.39.203] ([109.38.139.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f188bsm204963466b.153.2024.09.25.05.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 05:36:47 -0700 (PDT)
Message-ID: <b92b57d0-41ee-46a3-ac44-4705a116a593@redhat.com>
Date: Wed, 25 Sep 2024 14:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Marek Maslanka <mmaslanka@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, Petr Mladek <pmladek@suse.com>
References: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
 <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
 <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
 <1c10c0c4-f4d7-490f-85d2-0278c062fb87@molgen.mpg.de>
 <aa60da75-7931-462d-addd-49adfbd9893b@redhat.com>
 <b3cc0791-6334-4143-90bc-d3ae04aae0de@molgen.mpg.de>
 <10f1c736-33e9-4e04-a31e-0f095cdd08d2@redhat.com>
 <28bef0a7-bc6c-47b8-9545-e6d867922e14@redhat.com>
 <f037f25b-153d-4fb7-92fd-e3900c9488f6@leemhuis.info>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f037f25b-153d-4fb7-92fd-e3900c9488f6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On 25-Sep-24 12:46 PM, Thorsten Leemhuis wrote:
> On 19.09.24 18:55, Hans de Goede wrote:
>> On 19-Sep-24 6:53 PM, Hans de Goede wrote:
>>> On 19-Sep-24 4:03 PM, Paul Menzel wrote:
>>>> Am 19.09.24 um 13:57 schrieb Hans de Goede:
>>>>> On 19-Sep-24 1:03 PM, Paul Menzel wrote:
>>>>>> Am 19.09.24 um 10:17 schrieb Paul Menzel:
>>>>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>>>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>
>>>>> So I think we can fix this by limiting the new handling to s0ix suspend.
>>>>> Can you please give the attached patch a try?
>>>> Thank you so much for the instant reaction. Indeed, your patch makes ACPI S3 suspend work.
>>>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>
>>> Thank you for testing. I've submitted this upstream now.
>>>
>>> I'll include this in the first pdx86 fixes pull-request over 6.11-rc1 is out.
>>
>> That should be 6.12-rc1 of course.
> 
> Out of curiosity: why not send the fix to Linus this week to get it into
> 6.12-rc1 (and thus on track for stable backporting too, assuming Greg
> will pick it up)? Just asking, as I have seen some developers wrongly
> assuming it's not okay to queue fixes due to our "no newly developed
> patches should be merged to -next or mainlined during the merge window"
> rule.

The commit/regression this fixes is only in 6.12 (1), so there is no need
to backport the fix.

Which means that AFAICT there is no big hurry to fix this and I'm currently
traveling (I'm at kernel recipes in Paris atm).

Regards,

Hans


1) If I'm not mistaken, it was certainly first introduced in 6.12 and
it is not a bugfix, so I don't expect it to get picked up by the
stable kernels.


