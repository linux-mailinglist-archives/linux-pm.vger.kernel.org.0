Return-Path: <linux-pm+bounces-38922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D80C947DF
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 21:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A528C4E1914
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 20:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BD0262FD3;
	Sat, 29 Nov 2025 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="BFQ4nHE/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58F1EFF93;
	Sat, 29 Nov 2025 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764448355; cv=none; b=cCH8m9kBn/vMtsjQF9PG28mWmInImUYvBbUiiuWCRxsCfpbKXYOguGGrSdFdDJerw+f53Hvv0n19hs0p0ZGxOfFAo7xLl0L/PJlt4NtEJ6RnKse/NbomhNNJNh1wLY9YhLdgGDxaWohRQ+hrgRW4jO4Ml0FIXYTPRrHMhhpbczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764448355; c=relaxed/simple;
	bh=9VIrky/LnMu807LE95sXQsjpfQSpCJFC6T4hDWxJWI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvU/x/m2Ai8NyWzWgeSyfzqZ8XNsZ+fXQi/b+zYkemn6RIur5l6mwsX+BPd0CQXEPdRwKNofKX//AnPG0OQLvfwVKuFKxv/C+lwjIhIqQpaeNgXyuDvGiD+iH5x6PXZKxgHFW5qT9MiWQxWsgmrkP1/aSr4qP8AYSrdovC3Br5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=BFQ4nHE/; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=+SALvQ1WKQOKgbvkBCd0ESc4r0VDqVsLEMufbJYstbA=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1764448341; v=1; x=1764880341;
 b=BFQ4nHE/cRtmTK4QTadzvMvUYDcy1sN9LBYXR7rMfNn9g0Ck1y0jTP1nGtacQiJ0LjR2j1zQ
 OmPYKsRjlUlz2L5yHCuWXGyljP2DISwTJgc8a+H7nvZ4MP6PGeebRLHcTzWnU/5gu5oj1VymaI3
 vpV126SghH1z3Ot6k6tt4GRYEergXPH+vAohULkckXwmpBFIODqCyLR9J0+7xNK0J4TzRflLenT
 kFl7Jz1FxWAG1ySAeFshMQPCRmQ3aOpZVdJxsUlm/OhhnV1Wail6bcNpW1QF7ocKCppkWUa1SoD
 SeXyM3JI6iGpaINSgQ+Ly8Ao0gz90+shfT1NSBZexAXrA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 045234a5; Sat, 29 Nov 2025 21:32:21 +0100
Message-ID: <4b22283d-3553-4e7f-9a50-a5b6e6d20155@dujemihanovic.xyz>
Date: Sat, 29 Nov 2025 21:32:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pmdomain: add audio power island for Marvell PXA1908
 SoC
To: Karel Balej <balejk@matfyz.cz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251127190237.745-1-balejk@matfyz.cz>
 <20251127190237.745-2-balejk@matfyz.cz>
 <51c9408e-45e7-4ce7-9e95-6e0a45bcc8fa@dujemihanovic.xyz>
 <DELFWFLO1M8G.1AMPX0VKEOJND@matfyz.cz>
Content-Language: en-US
From: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
In-Reply-To: <DELFWFLO1M8G.1AMPX0VKEOJND@matfyz.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/29/25 20:53, Karel Balej wrote:
> Duje Mihanović, 2025-11-28T22:30:55+01:00:
>>> -#define NR_DOMAINS	5
>>> +#define APMU_AUD_CLK		0x80
>>> +#define AUDIO_ULCX_ENABLE	0x0d
>>
>> I would group these with the other register definitions.
>>
>> Also, it's probably better to be more consistent with the naming, so I'd
>> prefer APMU_AUDIO_CLK.
> 
> So would I, but this is how the downstream code calls it so my idea was
> that it possibly matches the datasheet and it would seem preferable to
> me to match that even though we don't have it available.

AUDIO is indeed nicer, and IMO it doesn't matter if the names are 
perfectly matched with downstream. Matching with the datasheet would be 
a stronger argument, but it indeed isn't available so the whole point is 
moot.

> I could then do the reverse of what you say and call the other
> definition AUD_ULCX_ENABLE but AUDIO seems nicer to me too and this one
> is not defined in the downstream code.
> 
> What do you think?

I'd still prefer AUDIO, but don't care about it that much, so up to you.

Regards,
--
Duje

