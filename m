Return-Path: <linux-pm+bounces-30790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E0B03E6F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5277B17DA33
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9452824502D;
	Mon, 14 Jul 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2wYO0fN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8BF33991
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495301; cv=none; b=obo4HgWs4/YJBTXe0aZq2VW23UOF4VxdYfUyYDNjgz3sSmwWp6n5L3JA7c/YU0/m+vS+RemK7SSYyFXUkucSbwhmRXdXbqJiiwevnlbe8FHeHYKJ1Zkw2LfLFYcnm+xl11Dx6BPfre2V3g5JOWYPAZCOwtFdDyMtVVESPIeOzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495301; c=relaxed/simple;
	bh=BYzBPfh/ytviOirTkWz4504u4O0RE0FqexEQaYlECV4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W06puQXHuO+MGSlunvfYyIa1rTGmUw7uPcjYXFpt0j7H6GZzXIZQQfwD1VmsArlEHW3FAyEopLH1iUDt9/AKbfAP8WOi8gE40u+uR1gP/hgXu4QodpRKZ8my3+k+AyCEJWYDjKh0YwO88DDpNJEyBGlH8RjZMVayjBNr4U3YIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2wYO0fN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so879790166b.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752495298; x=1753100098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KsBsNedKx8xGt4I6WaKkCB8jsWquCjMbNNOAEnJdX54=;
        b=v2wYO0fNllNinMF0JVTpFgsGwXhvAhLR61DG4MT/u45zZNwrxwuB60jlY4wLD/fj3n
         ZvWFEkCJ4B1nkN4dKfkN/fwsZq8nslmSVj2IfFDXhA8LSlYZpVwZY9O6raWY9f8MJqXL
         hsdbC7DvQ7Xuk2anEUL5Y6ct9g/WgjVUI+8mx2nXe6VwdZcVDHp4B7nyCYjKM3OnrIzW
         Z28LHVrZsA55p/l+Ut10S9olhI83ypopN8AZxRS7zLYm9A41yaCqaIXpqX6i3gmegcon
         rAnYlX8zZVYW4W2S/cEZ7ilhmgKGxMWByOldsLVuOLU8pmW0+hiGKjFhuUP4ArfBOn2H
         VuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495298; x=1753100098;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsBsNedKx8xGt4I6WaKkCB8jsWquCjMbNNOAEnJdX54=;
        b=iD75XhU7mvNQIVRp21SM31yixgQmLc5iPKrAUD1CrUaCoI675Iu/tQl/kTEIgNS0Fi
         PaQX/UqBYVEXsdIufYJj3jlLALdS/GZk3f9+eqqMhypXhxoTcAa0qeLgHGv6yUyk5vpO
         5NjVLq3FPcY/PDYzY59Luk7kzLyKVDlCGPwMQ14vuDBgnRMyQs3RQ05k5xthzRXB1agL
         pU4qd4t2QmtVF1FiEbEZjFlWToJC9ty697b8KAkGww/7lBTAZCvQWW+TbR3Mh2bVhjcR
         NrT0BwWRSJSyGPiZ3zhbMP6eo5eg5yFoFVp1nQI7+IrEc+re5XBYTsWWNmbFX0AOgVw9
         x6VQ==
X-Gm-Message-State: AOJu0YzNuztlsOSOQVnqoBb3sLCw5P9RZ82N5059jdgm5ouvlaybnDNC
	jSq4kIyKvujpEmd6G+3vLn9SyKTOneCyjgiKKv3c4/TeFADV8Zgb1THhW/iQc6evodd6mmYsfk+
	NZRAI
X-Gm-Gg: ASbGncuz7Lxp7TDwwl9MXvAHjqac6fwGucDnVmOpAkYted9TxHFWKVGJOdkA2FN2VCe
	ljcvG+EMPNDtDlWU+8eh2z21BDX9x7IRq4eoq7FVPfrs1yJ5rxoes9zjnpeUtd0eAup0YRi7J/A
	oGJupktw9nAabhRhfVL2XlkXdqR1rlpiLVyupY6LK9pjpgv1+8IyNCnSF7vXh00OZNqTb4WEWSk
	JHG1zil1mSQNDr+Cx48OgoiGcVej4ndw8grLFMR/SltfNmZLwAZyKxUri07BF/rYKwrCxxt1yvU
	rprqqEW7mP4wRj/4zZ4uZwtUIW818aTHnVGLALLHHjhYEo0fPeCYf2v4lzwv+k7yXa8+a5HGATd
	fhWc2fTuCgjysW0M0At8uZ6xPXfgmgwlo
X-Google-Smtp-Source: AGHT+IG5VtsLFvFUDT520ex2RKhAB9eBro+IUiGxHRhjbk7jTorQ4ULKI2K0vvCF0z4O054xQO9Yxw==
X-Received: by 2002:a17:906:9c82:b0:ae3:6bb4:2741 with SMTP id a640c23a62f3a-ae6fbfa7d75mr1203346566b.38.1752495298018;
        Mon, 14 Jul 2025 05:14:58 -0700 (PDT)
Received: from [192.168.0.251] ([188.27.143.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee4607sm827250566b.57.2025.07.14.05.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:14:57 -0700 (PDT)
Message-ID: <30a08478-824b-4ac5-91e7-c985adcf4d09@linaro.org>
Date: Mon, 14 Jul 2025 13:14:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>,
 William McVicker <willmcvicker@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
 <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
 <4677865.LvFx2qVVIh@rjwysocki.net>
 <ae6d65f7-990a-4145-9865-63f23518405c@linaro.org>
 <CAJZ5v0hatwNn_Qh7n7wjDyXDZK=L4vkB+aotZRfn4Zi21sGKxw@mail.gmail.com>
 <7186da1f-4d16-48f5-bdc0-cb04942b3a5e@linaro.org>
Content-Language: en-US
In-Reply-To: <7186da1f-4d16-48f5-bdc0-cb04942b3a5e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/14/25 11:35 AM, Tudor Ambarus wrote:
> 
> 
> On 7/14/25 8:29 AM, Rafael J. Wysocki wrote:
>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>> index d9d4fc58bc5a..0e186bc38a00 100644
>>> --- a/drivers/base/power/main.c
>>> +++ b/drivers/base/power/main.c
>>> @@ -1281,6 +1281,27 @@ static void dpm_async_suspend_parent(struct device *dev, async_func_t func)
>>>                 dpm_async_with_cleanup(dev->parent, func);
>>>  }
>>>
>>> +static void dpm_async_suspend_complete_all(struct list_head *device_list)
>>> +{
>>> +       struct device *dev;
>>> +
>>> +
>>> +       pr_err("tudor: %s: enter\n", __func__);
>>> +       guard(mutex)(&async_wip_mtx);
>>> +
>>> +       list_for_each_entry_reverse(dev, device_list, power.entry) {
>>> +               /*
>>> +                * In case the device is being waited for and async processing
>>> +                * has not started for it yet, let the waiters make progress.
>>> +                */
>>> +               pr_err("tudor: %s: in device list\n", __func__);
>>> +               if (!dev->power.work_in_progress) {
>>> +                       pr_err("tudor: %s: call complete_all\n", __func__);
>>> +                       complete_all(&dev->power.completion);
>>> +               }
>>> +       }
>>> +}
>>> +
>>>  /**
>>>   * resume_event - Return a "resume" message for given "suspend" sleep state.
>>>   * @sleep_state: PM message representing a sleep state.
>>> @@ -1459,6 +1480,7 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
>>>                 mutex_lock(&dpm_list_mtx);
>>>
>>>                 if (error || async_error) {
>>> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>>>                         /*
>>>                          * Move all devices to the target list to resume them
>>>                          * properly.
>>> @@ -1663,6 +1685,7 @@ int dpm_suspend_late(pm_message_t state)
>>>                 mutex_lock(&dpm_list_mtx);
>>>
>>>                 if (error || async_error) {
>>> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>>>                         /*
>>>                          * Move all devices to the target list to resume them
>>>                          * properly.
>>> @@ -1959,6 +1982,7 @@ int dpm_suspend(pm_message_t state)
>>>                 mutex_lock(&dpm_list_mtx);
>>>
>>>                 if (error || async_error) {
>>> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>> -> There is a bug here which is not present in the patch I've sent.
> 
> My bad, I edited by hand, sorry.
> 
>>
>> It should be
>>
>>         dpm_async_suspend_complete_all(&dpm_prepared_list);
> 
> 
> Wonderful, it seems this makes suspend happy on downstream pixel6!
> I'm running some more tests and get back to you in a few hours.
> 

Solves failures on pixel6 downstream:
Reported-and-tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks!

