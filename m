Return-Path: <linux-pm+bounces-39495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E36CBC382
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 02:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626EB3009814
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 01:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2933126D5;
	Mon, 15 Dec 2025 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QWrNr/i2"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B630E849;
	Mon, 15 Dec 2025 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765763840; cv=none; b=Kqi8y9sPbgZ1palsZSFCVIetH8rkyB1Nc0L9pyyzqcHBT0uUUhWfvpo1r34IYvvvSqGtgzKwKsB7aNl016tMceFkNmXFF5fJ8GGDAM6nTCsQ8IhrMrK3nL9+YdicB5W8kps2UzEsJ53q5bPrrhcmW4mi4DfBvY50FEUCglWIdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765763840; c=relaxed/simple;
	bh=oVYoxKaO5jEMCOPtg5MEMVE2JM7Y0BCfMC793W6Eqdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBc89CSLJTwZvtDQdja/I0IuHYAvxXl/bhRpz0Cxb61TiRs552GpASYHiuczW6//JWU05se+T8CXX6ThkRHTMnbVlGaVQ6EinjpDCCpVaIx0tCtUabW0QJHit2paGo4SCrCWJS8lu0U8/YFlYSdOXhD6ZQV7j9Q9iLIKkPebteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QWrNr/i2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8eBldRCRCTTRrHnUPrnOC67vnaaSzvn9vfN//FNjIv0=; b=QWrNr/i2yT8m/oo3n+2dsqm48A
	3KjlvMp1QhWNMjh1LwcX4OaS9syQ333zpd0fXpm5iRg4GbGLI4qJsUrXuBNeq5UmilLzyYqx8EIqf
	LYQR4rfsZ9H9WcY1mMa8LeavosoDHRchlOwQlpG6azssNbUA2rnSLzS1jDEXVs6AuhML6CVSSumkN
	hzumD9KfO29Fp7NUOSGfCxSy+y/0JDCKh5dWOCQcp+GF2HyM46hWYuDoi7D/CqN6DSSnhSTOmqaob
	7ylYJJowzcU1BZ6dWmMv4dC0gSPnfwKO3B2mCGIPlOt/XcsGTeXflQabhhdmPyLy5GP4DHN1aYaFm
	NdlYZSRA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vUxpm-00ClGH-2p; Mon, 15 Dec 2025 02:57:10 +0100
Message-ID: <c65961d2-d31b-4ff9-ac1c-b5e3c06a46ba@igalia.com>
Date: Mon, 15 Dec 2025 10:57:03 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concerns with em.yaml YNL spec
To: Andrew Lunn <andrew@lunn.ch>
Cc: Donald Hunter <donald.hunter@gmail.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <081e0ba7-055c-4243-8b39-e2c0cb9a8c5a@lunn.ch>
 <4bb1ea43-ef52-47ae-8009-6a2944dbf92b@igalia.com>
 <bb7871f1-3ea7-4bf7-baa9-a306a2371e4b@lunn.ch>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <bb7871f1-3ea7-4bf7-baa9-a306a2371e4b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi  Andrew,

On 12/15/25 01:21, Andrew Lunn wrote:
>>> We also need to watch out for other meaning of these letters. In the
>>> context of networking and Power over Ethernet, PD means Powered
>>> Device. We generally don't need to enumerate the PD, we are more
>>> interested in the Power Sourcing Equipment, PSE.
>>>
>>> And a dumb question. What is an energy model? A PSE needs some level
>>> of energy model, it needs to know how much energy each PD can consume
>>> in order that it is not oversubscribed.Is the energy model generic
>>> enough that it could be used for this? Or should this energy model get
>>> a prefix to limit its scope to a performance domain? The suggested
>>> name of this file would then become something like
>>> performance-domain-energy-model.yml?
>>>
>>
>> Lukasz might be the right person for this question. In my view, the
>> energy model essentially provides the performance-versus-power-
>> consumption curve for each performance domain.
> 
> The problem here is, you are too narrowly focused. My introduction
> said:
> 
>>> In the context of networking and Power over Ethernet, PD means
>>> Powered Device.
> 
> You have not given any context. Reading the rest of your email, it
> sounds like you are talking about the energy model/performance domain
> for a collection of CPU cores?
> 
> Now think about Linux as a whole, not the little corner you are
> interested in. Are there energy models anywhere else in Linux? What
> about the GPU cores? What about Linux regulators controlling power to
> peripherals? I pointed out the use case of Power over Ethernet needing
> an energy model.
> 
>> Conceptually, the energy model covers the system-wide information; a
>> performance domain is information about one domain (e.g., big/medium/
>> little CPU blocks), so it is under the energy model; a performance state
>> is one dot in the performance-versus-power-consumption curve of a
>> performance domain.
>>
>> Since the energy model covers the system-wide information, energy-
>> model.yaml (as Donald suggested) sounds better to me.
> 
> By system-wide, do you mean the whole of Linux? I could use it for
> GPUs, regulators, PoE? Is it sufficiently generic? I somehow doubt it
> is. So i think you need some sort of prefix to indicate the domain it
> is applicable to. We can then add GPU energy models, PoE energy
> models, etc by the side without getting into naming issues.
>

This is really the question for the energy model maintainers. In my
understanding, the energy model can cover any device in the system,
including GPUs. But, in my limited experience, I haven’t seen such cases
beyond CPUs.


@Lukasz — What do you think? The focus here is on the scope of the
“energy model” and its proper naming in the NETLINK.


> Naming is important, and causes a lot of pain when you get it
> wrong. Linux has PHYs and generic PHYs. The PHY subsystem has been
> around a long time, and generic PHY is much newer. And sometimes a PHY
> has a generic PHY associated to it, so it can get really confusing
> unless you are very precises with wording.
> 
> We need to be careful with any generic term, such as energy model.
> 

I absolutely agree with you. Thank you for sharing your concerns and
examples.

Regards,
Changwoo Min

> 	Andrew
> 


