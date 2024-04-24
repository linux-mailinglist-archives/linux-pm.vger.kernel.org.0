Return-Path: <linux-pm+bounces-7004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2E8B0860
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 13:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17332287A11
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3863715A4A0;
	Wed, 24 Apr 2024 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyjNgCLI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934A15A491
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958479; cv=none; b=JG+nV+6NyiVMO1cAX6USHVH9KndaUvKE09qdrCtZ44cmYZwHvgJClyDdsjHKzKmQVFf+MfnaOzfb5RN0cxm/j3iCWFcK0Mpuvyc2wV0BTdCR+Wdhwe20Gn5Umeso5GChLc+59FHjJT1WWXnl3SVYoBTTEHMnbi+f1KX4Y/JNlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958479; c=relaxed/simple;
	bh=YcUfxhUcQApT1mNwyIlAfJBq0C+KxLwY6/CxV7Yz34E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1XX+syIjRPrOqqgavUMg/21cc3E7//cQwvzT1zjnfXMl1sfmM5nDLADgViz346YP6juNpLmsOTMsUmXiTw/PiRIzXyv0wPRvIDWYJNXcC7p23DADPx5lPdiJhzvOWVWCJrsTd8k644hvVVI6NWH/NwWUV+91NOBK1Ba9U7aek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dyjNgCLI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41af670176cso5547385e9.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713958476; x=1714563276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k25tPjMFnxZGYgnKJKp0dkB0J/d5Y8BkULxm1XocePE=;
        b=dyjNgCLI+8hS8qaZyK26/0ZFyeQ+xfIIbktz7Em+kwHxKinVXEZaki3lbDs9vN09RC
         bBjCXHvKVSIgLIRNdL+jSSA+N+98qhJcgC20Pn8a6Vxrm8wUaw/Lfl31dvkdvpQZJ41p
         V/j1nvSuAsuIdBxgWjWAmK7MlpSzDFur6m6nv/ExOPOskb4N+pskqD7uzJxgMInQUioo
         BdCe67LvXk8hngA+tfbJNb3IA73R6B2w4DazvbHU+f66eJyvYaiB2RYsxzxcjMciuTAR
         FDZ0aDLhpxyM4YHkp921wVLMvrRqpWzyEUrN00knLwx6+gQibRdF9PsrqP2WSCadJRNf
         dAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713958476; x=1714563276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k25tPjMFnxZGYgnKJKp0dkB0J/d5Y8BkULxm1XocePE=;
        b=EQh8F4VmvPtHMgK6icxGx6IUFzS0jdR9+0kdj84NhPAdu0oGdwMM62Ip8KW95t1Xy8
         n1n9qXxjy8w6lPWUIKncKsfzs9EWgYPzsTDGF4rrTrCyd+qkoM+6vjstI2eHXbrqncb6
         ttkfppKoPC63IhjVI2SfIILQlTWDLBvQ8xKZRlSvMPKWJh0IAhUXyMIh65B/ilr4J5IA
         psHdXvvFY1jsXa/5RX8wuXT4lGGLJXXgbb11lbrLAV0rKkF8YIMYeYBiq+S5debB+Svn
         s/0FZCpfLtIw7vp/+X6vaeMAlhZBb9jYYsGFgYm83+cgc47jNVm2gUxbSKwtX1qOwrhH
         87xA==
X-Gm-Message-State: AOJu0YyNeUGU6sUiBuVvgqA0eXMIe7gPy1MCoTPkjBL8f0dm8qx/uaCc
	TIH+okqB5OrePH/UCu8ezPsKyU5pJ+IZ8vg9bvZytS1Y37NdInTsssJFbiJDTco=
X-Google-Smtp-Source: AGHT+IF7nndGnjcSyHSKcy0fsxfNLV5bYy8H6C5JEFkHVts2E5ZYVuz34KpOvWk+i4MbUAfOVCjbxw==
X-Received: by 2002:a5d:6709:0:b0:341:d3b0:ae7d with SMTP id o9-20020a5d6709000000b00341d3b0ae7dmr1725373wru.45.1713958475772;
        Wed, 24 Apr 2024 04:34:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ea7-20020a0560000ec700b0033e91509224sm17003566wrb.22.2024.04.24.04.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:34:35 -0700 (PDT)
Message-ID: <917f9bec-80f3-4d10-9781-7b27f361101d@linaro.org>
Date: Wed, 24 Apr 2024 13:34:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/16] thermal: gov_user_space: Use .trip_crossed()
 instead of .throttle()
Content-Language: en-US
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <13515747.uLZWGnKmhe@kreacher> <15186663.tv2OnDr8pf@kreacher>
 <ZijNj7DzL9e01Vnt@mai.linaro.org>
 <e565a9c3-9244-4a0b-9ad8-4beebd03d681@linux.intel.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e565a9c3-9244-4a0b-9ad8-4beebd03d681@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/04/2024 13:32, Srinivas Pandruvada wrote:
> 
> On 4/24/24 02:14, Daniel Lezcano wrote:
>> On Wed, Apr 10, 2024 at 07:03:10PM +0200, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Notifying user space about trip points that have not been crossed is
>>> not particuarly useful, so modity the User Space governor to use the
>>> .trip_crossed() callback, which is only invoked for trips that have been
>>> crossed, instead of .throttle() that is invoked for all trips in a
>>> thermal zone every time the zone is updated.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> I would also consider removing this governor which is pointless now 
>> that we
>> have the netlink notification mechanism
> 
> That is a good goal, But, not there yet to deprecate.

What can be done to deprecate it ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


