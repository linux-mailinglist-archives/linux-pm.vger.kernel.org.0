Return-Path: <linux-pm+bounces-39591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3ACBE8BB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 16:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BDDD301825C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856B30BBAE;
	Mon, 15 Dec 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wv6BWm5a"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667730B51A;
	Mon, 15 Dec 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810902; cv=none; b=ICiW7LcCmD4rYJbvCLTAsAcIFo1AVRYIJWi7uWLNM3Ekf/z0hVAVYILaSrSSKqcHVXDOVn0AHF8mWUq0lBMismjRFwsTNT67dm/HeS9HyhXjD+ocNLsT6pCRp0pg2WimpufEhYt4iaFQRcUc9vaTjP7nshWpWP8mAK7KgOAvb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810902; c=relaxed/simple;
	bh=Br7ZtHWqeIn4lK/n8zGIv1KNoZrKj+RIUkwAmWsZpoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rR//H/HA1H5gxnpgqptiKiVnp0bZ4Ql27Hco86u/gVS5emaAg7cfWSF5AWWZ2vSTvS9wG6WTxFaFGZx/Abw0LCEzeVf7qsfjDQvE7N18wC1ojtXIzbb7xUn66WsYdNamf1Lq9mrYYvh/3EjsixeSbQz+241bYLR3RHE4s4rkm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wv6BWm5a; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fkdD8ZWkNIYfxMsPfYnrCv/yh8YXAEPgYx1w5ZHz3OM=; b=Wv6BWm5acHLkA7DZRafmKqacc7
	LPFaNBvf82iqz9snLcpXRUg572LQmPxM6HQrC8Xr+nVqVma6T+NSHhs6KPkIM6DbRVZX6HO8/eJu8
	52Mo1eeWiZGZy42XN9B35MHjduqLTITqDUE/DASpPzcNIZcONjYVoyWLgnEDwQ+oWXQh6vu5MmJN6
	icJoUeKldOqC4Q7M+D/kmfoIjLpAHftEMe+FHGJTGkIRW3ZyccNeCVpqx6OucVc780jc+tzjYg074
	5XBPE7zbGY7oza3OSYPRmziyZbftpPO0vGoYnQ5L+evCcZk3j1QTMp2In0jgxbeArcr8FBJ1ooQgZ
	ZhV/mQTA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vVA4p-00Cz0C-H4; Mon, 15 Dec 2025 16:01:31 +0100
Message-ID: <d5b50da2-bc1f-4138-9733-218688bc1838@igalia.com>
Date: Tue, 16 Dec 2025 00:01:25 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concerns with em.yaml YNL spec
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <081e0ba7-055c-4243-8b39-e2c0cb9a8c5a@lunn.ch>
 <4bb1ea43-ef52-47ae-8009-6a2944dbf92b@igalia.com>
 <bb7871f1-3ea7-4bf7-baa9-a306a2371e4b@lunn.ch>
 <c65961d2-d31b-4ff9-ac1c-b5e3c06a46ba@igalia.com>
 <CAJZ5v0iX39rvdaoha18N-rpKLinGZ1cjTb1rV1Azh0Y7kYdaJQ@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAJZ5v0iX39rvdaoha18N-rpKLinGZ1cjTb1rV1Azh0Y7kYdaJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks, Rafael, for the comments.

On 12/15/25 19:30, Rafael J. Wysocki wrote:
> On Mon, Dec 15, 2025 at 2:57 AM Changwoo Min <changwoo@igalia.com> wrote:
>>
>> Hi  Andrew,
>>
>> On 12/15/25 01:21, Andrew Lunn wrote:
>>>>> We also need to watch out for other meaning of these letters. In the
>>>>> context of networking and Power over Ethernet, PD means Powered
>>>>> Device. We generally don't need to enumerate the PD, we are more
>>>>> interested in the Power Sourcing Equipment, PSE.
>>>>>
>>>>> And a dumb question. What is an energy model? A PSE needs some level
>>>>> of energy model, it needs to know how much energy each PD can consume
>>>>> in order that it is not oversubscribed.Is the energy model generic
>>>>> enough that it could be used for this? Or should this energy model get
>>>>> a prefix to limit its scope to a performance domain? The suggested
>>>>> name of this file would then become something like
>>>>> performance-domain-energy-model.yml?
>>>>>
>>>>
>>>> Lukasz might be the right person for this question. In my view, the
>>>> energy model essentially provides the performance-versus-power-
>>>> consumption curve for each performance domain.
>>>
>>> The problem here is, you are too narrowly focused. My introduction
>>> said:
>>>
>>>>> In the context of networking and Power over Ethernet, PD means
>>>>> Powered Device.
>>>
>>> You have not given any context. Reading the rest of your email, it
>>> sounds like you are talking about the energy model/performance domain
>>> for a collection of CPU cores?
>>>
>>> Now think about Linux as a whole, not the little corner you are
>>> interested in. Are there energy models anywhere else in Linux? What
>>> about the GPU cores? What about Linux regulators controlling power to
>>> peripherals? I pointed out the use case of Power over Ethernet needing
>>> an energy model.
>>>
>>>> Conceptually, the energy model covers the system-wide information; a
>>>> performance domain is information about one domain (e.g., big/medium/
>>>> little CPU blocks), so it is under the energy model; a performance state
>>>> is one dot in the performance-versus-power-consumption curve of a
>>>> performance domain.
>>>>
>>>> Since the energy model covers the system-wide information, energy-
>>>> model.yaml (as Donald suggested) sounds better to me.
>>>
>>> By system-wide, do you mean the whole of Linux? I could use it for
>>> GPUs, regulators, PoE? Is it sufficiently generic? I somehow doubt it
>>> is. So i think you need some sort of prefix to indicate the domain it
>>> is applicable to. We can then add GPU energy models, PoE energy
>>> models, etc by the side without getting into naming issues.
>>>
>>
>> This is really the question for the energy model maintainers. In my
>> understanding, the energy model can cover any device in the system,
>> including GPUs.
> 
> That's correct.
> 
>> But, in my limited experience, I haven’t seen such cases beyond CPUs.
>>
>> @Lukasz — What do you think? The focus here is on the scope of the
>> “energy model” and its proper naming in the NETLINK.
> 
> I think you need to frame your question more specifically.
> 

Let me provide the context of what has been discussed. Essentially, the
question is what the proper name of the netlink protocol is and its file
name for the energy model.

Donald raised concerns that “em” is too cryptic, so it should be
“energy-model”. The following is Donald’s comment:


   “- I think the spec could have been called energy-model.yaml and the
    family called "energy-model" instead of "em".”


Andrew’s opinion is that it would be appropriate to limit the scope of
“energy-model” by adding a prefix, for example, “performance-domain-
energy-model”. Andrew’s comment is as follows:

   “And a dumb question. What is an energy model? A PSE needs some level
   of energy model, it needs to know how much energy each PD can consume
   in order that it is not oversubscribed. Is the energy model generic
   enough that it could be used for this? Or should this energy model get
   a prefix to limit its scope to a performance domain? The suggested
   name of this file would then become something like
   performance-domain-energy-model.yml?”

For me, “performance-domain-energy-model” sounds weird because the
performance domain is conceptually under the energy model. If adding a
prefix to limit the scope, it should be something like “system-energy-
model”, and the “system” prefix looks redundant to me.

So, the question is what the proper name is for the energy model
protocol: “em”, “energy-model”, “performance-domain-energy-model”, or
something else?

Regards,
changwoo Min






