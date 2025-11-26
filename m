Return-Path: <linux-pm+bounces-38674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A1C88279
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 06:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E53A3D0C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 05:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB173126C5;
	Wed, 26 Nov 2025 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="F4fk6Ow+"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266503126D4
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764134991; cv=none; b=qMlAZRlOQ8sJGEdZYlSUJsUEKXIdK2kgHSP/bO/ei/VPPnRD4Jttp4rGDsCqpcPVfAQIbiq5+LKY87u1mrRLAhjG/XbRuira1RiyoU29tmQi0N74rYkzyi+ynZbBdzd8On5pZUY+HLt/Tww7w3FPkLJ/UHeN3yupFIZ/piCKu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764134991; c=relaxed/simple;
	bh=MH6PhZqOH7/qk/hUl019I0pJ58AW5th3I1mxlblZdZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUSXXTmYaxicJ6zcv/C1h8b+tM5PPxsAQurvXZBSv2KH13WJSGt/Nd5rVDIQQJz+Nem6jtcNPYc6K19YerYpPcKPxOP7H2YvktXv+RHhR4yqEPMHZ+mW2XubII1g830DT7k9G+bbtqLkBquO2GNQuqpsLwzS7AU1BFpNCcRIenw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=F4fk6Ow+; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <aef3f079-c81f-4e3e-8484-d02fca793c20@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1764134977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLvSRiNEkjQwYv9rHqZs7Cd/sAeizIgY1FHze5NDxl8=;
	b=F4fk6Ow+XzA9seczvFgSd6MmILJQza2HhxAQ3VCkDklx28lclHX+eKhv6qAjl/min4owss
	fFbK6w/P1CPAE+5t4E5FJSEcaSydWTE/P+XnwIY7WPktFc02fhmJzLD221sXMWBdYDv8Ri
	t/BNEYFnkoOJP2LlcGlGsRBbx3S4AGGefIJkqDSViWHAzqtu+bEIAIzL3NK36eIVZygnFh
	sPIRBp1P/vtRxBnJFnfNMPnftCAEJ2iLhUJm/8aIC+EN+22EqVMAN0aRC6fyZ2ew0ct/QW
	PiPT9FM4oS2UyT4aCbqLxTHt22KT4TCqSeYV+5ar0lgJrl8HDBS7g5lxyIV8fA==
Date: Wed, 26 Nov 2025 02:29:25 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] cpuidle: Warn instead of bailing out if target
 residency check fails
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251121010756.6687-1-val@packett.cool>
 <CAJZ5v0h1VTozCKweKvma3dQiUCz8KkR88Hue1cL_jDaKiP+BEw@mail.gmail.com>
 <2808566.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <2808566.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/25/25 1:23 PM, Rafael J. Wysocki wrote:
> On Friday, November 21, 2025 2:10:57 PM CET Rafael J. Wysocki wrote:
>> On Fri, Nov 21, 2025 at 2:08 AM Val Packett <val@packett.cool> wrote:
>>> On Device Tree platforms, the latency and target residency values come
>>> directly from device trees, which are numerous and weren't all written
>>> with cpuidle invariants in mind. For example, qcom/hamoa.dtsi currently
>>> trips this check: exit latency 680000 > residency 600000.
>> So this breaks cpuidle expectations and it doesn't work correctly on
>> the affected platforms.
>>
>>> Instead of harshly rejecting the entire cpuidle driver with a mysterious
>>> error message, print a warning and set the target residency value to be
>>> equal to the exit latency.
>> This generally doesn't work because the new target residency may be
>> greater than the target residency of the next state.
>>
>>> Fixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and target residency")
>>> Signed-off-by: Val Packett <val@packett.cool>
>>> ---
>>>   drivers/cpuidle/driver.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
>>> index 1c295a93d582..06aeb59c1017 100644
>>> --- a/drivers/cpuidle/driver.c
>>> +++ b/drivers/cpuidle/driver.c
>>> @@ -199,8 +199,11 @@ static int __cpuidle_driver_init(struct cpuidle_driver *drv)
>>>                   * exceed its target residency which is assumed in cpuidle in
>>>                   * multiple places.
>>>                   */
>>> -               if (s->exit_latency_ns > s->target_residency_ns)
>>> -                       return -EINVAL;
>>> +               if (s->exit_latency_ns > s->target_residency_ns) {
>>> +                       pr_warn("cpuidle: state %d: exit latency %lld > residency %lld (fixing)\n",
>>> +                               i, s->exit_latency_ns, s->target_residency_ns);
>>> +                       s->target_residency_ns = s->exit_latency_ns;
>> And you also need to update s->target_residency.
>>
>> Moreover, that needs to be done when all of the target residency and
>> exit latency values have been computed and full sanitization of all
>> the states would need to be done (including the ordering checks), but
>> the kernel has insufficient information to do that (for instance, if
>> the ordering is not as expected, it is not clear how to fix it up).
>> Even the above sanitization is unlikely to result in the intended
>> behavior.
>>
>> So if returning the error code doesn't work, printing a warning is as
>> much as can be done, like in the attached patch.
>>
>> If this works for you, I'll submit it properly later.
>>
> No response, so I assume no objections. [..]

Right, only printing a warning is fine of course.

~val


