Return-Path: <linux-pm+bounces-40270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B88CF74D1
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 09:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CFE430A27DF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 08:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C030B507;
	Tue,  6 Jan 2026 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="g0Kkb94X"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3A30ACEB;
	Tue,  6 Jan 2026 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767687931; cv=none; b=SNFWx89F54LqktW0BpFbF7lqKh2L493BY7mRsgtOEAFNyUP3nXSAYjfgItpBAnX4elX3JyE3CVW/O7OSGUVHu06wU54lZcmf5/zCjQES+cI/kxrlQJ7qFFq5wYwoJYGIzkftyhTByovziu/Znn1DDfdwYqweA0NBjBXcGwcWolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767687931; c=relaxed/simple;
	bh=DgI8Fc4rTrkUhHVxfd4nsPZshZ915CBlnpO6gpVE4DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGWYc4TflDYzuaI+LRNR31ysRdVXEzFX3C/MI9y0BtqmCoRNucMJLgl6k1Pb6wxVBa2mi9mQVhKvq2YitsMZk4wRjR67RQE+K6v78gHeWrnDDvNNYBKGm+cgb9u0Dg/Y9orx7Tm6y4VdQQ95X5JbcCfPGNR8wMEO5fRnfh/ZKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=g0Kkb94X; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F/TRE4AJ7/DxDFGbDd7kjbKCM/sSy4a/Cr0X7sMo+2w=; b=g0Kkb94Xtcpxcp1Av2CaR0kHEB
	/zcJBuYG2pHeKunn9cziy61Ufb+DwZQM9VBp0SqTFP2V34eo3WbByB7W0qR0vaYPL+sX65FaZGJzk
	bwy8f9XJgbYrY8FHxNy8vebiWe/LaDd3rtY79GjhigSvN9cpn5gfkkYcXlVPoEZWZkHBWyZcoqLfu
	18EVzaoRT8bfWmYIBnfFAcb16DmnSDWwRYnojctsYWqDac/uHDYHWo559Ui9ejPiEfqD5j96qyIag
	e+zy5h+G4UCQFhE5HZWFUVw/XffZzRqYZiND0qnfNIQXo9FImgEEkALNazeKsLGreKSrdUoPzqHri
	3CR0Osow==;
Received: from [49.174.255.4] (helo=[192.168.100.20])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vd2NR-0025fj-Cb; Tue, 06 Jan 2026 09:25:17 +0100
Message-ID: <61c00aaf-1920-4f60-93ee-68e25f90218a@igalia.com>
Date: Tue, 6 Jan 2026 17:25:06 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 6.19 4/4] PM: EM: Add dump to get-perf-domains in the
 EM YNL spec
To: Donald Hunter <donald.hunter@gmail.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, lenb@kernel.org, pavel@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251225040104.982704-1-changwoo@igalia.com>
 <20251225040104.982704-5-changwoo@igalia.com> <m2bjj8i9xn.fsf@gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <m2bjj8i9xn.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Donald,

On 1/5/26 8:19 PM, Donald Hunter wrote:
> Changwoo Min <changwoo@igalia.com> writes:
> 
>> Add dump to get-perf-domains, so that a user can fetch either information
>> about a specific performance domain with do or information about all
>> performance domains with dump. The YNL spec, autogenerated files, and
>> the do implementation are updated, and the dump implementation is added.
>>
>> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>   .../netlink/specs/dev-energymodel.yaml        | 12 ++++
>>   include/uapi/linux/dev_energymodel.h          |  3 +-
>>   kernel/power/em_netlink.c                     | 58 +++++++++++++++++--
>>   kernel/power/em_netlink_autogen.c             | 16 ++++-
>>   kernel/power/em_netlink_autogen.h             |  2 +
>>   5 files changed, 82 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/dev-energymodel.yaml b/Documentation/netlink/specs/dev-energymodel.yaml
>> index af8b8f72f722..1843e68faacf 100644
>> --- a/Documentation/netlink/specs/dev-energymodel.yaml
>> +++ b/Documentation/netlink/specs/dev-energymodel.yaml
>> @@ -47,6 +47,11 @@ attribute-sets:
>>       doc: >-
>>         Information on all the performance domains.
>>       attributes:
>> +      -
>> +        name: perf-domain-id
>> +        type: u32
>> +        doc: >-
>> +          A unique ID number for each performance domain.
>>         -
>>           name: perf-domain
>>           type: nest
>> @@ -136,6 +141,13 @@ operations:
>>         attribute-set: perf-domains
> 
> I think this can be changed to 'perf-domain' and you could remove
> the 'perf-domains' attribute-set.
> 
>>         doc: Get the list of information for all performance domains.
>>         do:
>> +        request:
>> +          attributes:
>> +            - perf-domain-id
>> +        reply:
>> +          attributes:
>> +            - perf-domain
> 
> If you use 'perf-domain' then the reply attributes would be:
> 
>    reply:
>      attributes: &perf-domain-attrs
>        - pad
>        - perf-domain-id
>        - flags
>        - cpus
> 
>> +      dump:
>>           reply:
>>             attributes:
>>               - perf-domain
> 
> You can then change the dump reply to be:
> 
>    dump:
>      reply:
>        attributes: *perf-domain-attrs
> 
> The dump reply for multiple perf domains would then look like this, no
> need for the 'perf-domains' wrapper:
> 
> [{'perf-domain-id': ...,
>    'flags': ...,
>    'cpus': [1, 2, 3]},
>   {'perf-domain-id': ...,
>    'flags': ...,
>    'cpus': [1, 2, 3]}]
> 

Thank you for the suggestion. I will send v2 soon with your suggested 
changes.

Regards,
Changwoo Min


