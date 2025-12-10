Return-Path: <linux-pm+bounces-39394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E91A2CB1EAB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 05:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E8D93019BD8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 04:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889FE2BE02B;
	Wed, 10 Dec 2025 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7PuoLGL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08B1F1315
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765341656; cv=none; b=suxk5TYcPNpvuSWbtsWIzE/gChJ2hwsqpfQLqqdbeuC6Ywc5eZp3chvKy9eCSxIVry7hRIM0WQ7UMEFBvI7GU6hgLqc0JF0ExtvcULJHHgQ2H+3xJlmINzpgYZ6Z0UaFVAIu1WJ+cHuHr2fY/cGNmpTduZYberzZ1qX5QIGjTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765341656; c=relaxed/simple;
	bh=JfKtboyVO2xk//UN2c7it0BJFknldiZ97H5SDywpQmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLFeqhx+O7o9Pmm5acMO/8RQyHWXZwlgZZ81sD0F6O9imN2nKgf9LIwK6wPkoNcoCclFVUCezRk/PEen8B6Vy2cf0KSQ2eG0ho9AWWGDjQynIyUUBZziPYNLu+c0cmfhARC2EVeWuiQalCx9cS1WzFAvm2S8OXVnHcXbo7BdHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7PuoLGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23402C116B1;
	Wed, 10 Dec 2025 04:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765341655;
	bh=JfKtboyVO2xk//UN2c7it0BJFknldiZ97H5SDywpQmc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h7PuoLGLURjE7C+wp4vMnDuISZ0dyAvNa0GlHyrdLM2hI9dkPpDIoQ1efoGwbQEZO
	 gz266oSrbTDbnECaMtnX8EnibslRhBPWB+F+yG6xR+VGnnEm7HEs5jC5uzh3Ow4jOI
	 cIkUwbmXOW9oiCOkO7DiSWPRlpm2psq/F3nXzKUVsyHrVy+sXCPqcQrE8Q8324kH9P
	 V5FDTQXhxB/jtnQbukupVmthl0O/cNNK+n20GNQdXEzwVyfIdt7/roYpj7vlLt4vNL
	 yRmbwdJdvBNeVMyBgtt6xFcOdRh7Mi0AT3djDkXsAnaSnndis9DsSjHF+ein2YM2bO
	 kTTCx3zb3JqEA==
Message-ID: <02ebe8ea-d3fe-4bce-bb84-256603ad6c6f@kernel.org>
Date: Wed, 10 Dec 2025 05:40:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm:xlnx,zynq-7000: missing CPU freq in /sys after
 6.18.0-g8f7aa3d3c732 from 2025-12-04
To: Viresh Kumar <viresh.kumar@linaro.org>, Pavel Pisa <pisa@fel.cvut.cz>
Cc: Michal Simek <michal.simek@amd.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Pavel Hronek <hronepa1@fel.cvut.cz>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <202512081758.02574.pisa@fel.cvut.cz>
 <6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz>
 <202512091447.26580.pisa@fel.cvut.cz>
 <nitrtsck5moqc2xfovcgc2tppkbfd7224jb6iaezetjgfjmvjf@hhdr6hwqwknl>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <nitrtsck5moqc2xfovcgc2tppkbfd7224jb6iaezetjgfjmvjf@hhdr6hwqwknl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2025 05:12, Viresh Kumar wrote:
> Fixed Krzysztof's email id.
> 
> On 09-12-25, 14:47, Pavel Pisa wrote:
>> Dear Viresh Kumar,
>>
>> thanks for fast response.
>>
>> On Tuesday 09 of December 2025 06:37:02 Viresh Kumar wrote:
>>> On 08-12-25, 17:58, Pavel Pisa wrote:
>> ...
>>>> and we experience problem that attempt to set performance
>>>> scaling governor though
>>>>
>>>>   /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>>>>   /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
>>>>
>> ...
>>> Try reverting:
>>>
>>> commit 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with
>>> of_machine_get_match_data()")
>>>
>>> Also if you can provide your boot logs, it could be useful. Either the
>>> probing of the cpufreq driver isn't attempted, or it just fails somewhere
>>> now.
>>
>> The cpufreq is back after the revert.
> 
> Great. Thanks for testing this.
> 
> Geert already highlighted an issue with the commit earlier [1].

I did not get it... Why do the people do not use get_maintainers which
properly handles mailmap... or actually check the commit on recent tree
because that one would have the old address properly mapped.

> 
> Krzysztof can you provide a fix please ? Or do you want me to revert the patch
> for now ?

I will take a look now, but I am at LPC so I am less responsive.

I did not get any logs though, but I will take a look now.


Best regards,
Krzysztof

