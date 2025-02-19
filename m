Return-Path: <linux-pm+bounces-22449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB0A3C1C4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8631C1892075
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047431F2C5F;
	Wed, 19 Feb 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+NLQTUM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R8r0Ax+L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+NLQTUM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R8r0Ax+L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545141F2B8B
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974209; cv=none; b=a09RUDbdJCoK75DcuG+eP2GlyFd5Ket30xzEwtlPCuO5k4vzOJwW/CSJoTshihGjNigwmbJBc/U/7Js9nWG/mImzQIhekLmZE8LJiNeIdh0sRYZukXFDpyVPWNm3myDpeyP5h5X8XPr5s9nuNVqVM14OHL/f5m79rOUeexYEA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974209; c=relaxed/simple;
	bh=ftdCmDrYrqznox9ADQ4gf+hDnwH6vudTD6dzNIMQxbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlZSXN9QSjqfU+6Q8eFX0zVxoPOX4x2NEib5tETqGZ9H/8kElH+tq5uonQRVMGs5B/x8D4drISMC3Ie2UOnsb77othKQKHXI67a+dwMVVuf2SPfnJFkASrQJ8WK93+tR8j41li1XAPclQBnoQ8LtMtMqZjkFRb27UYgzNLwvTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+NLQTUM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R8r0Ax+L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+NLQTUM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R8r0Ax+L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79275216E6;
	Wed, 19 Feb 2025 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739974206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j0qvW9Ted+2fuZYC8Zw4Q6pvkin9Y9rXhmhvHhpbsXs=;
	b=2+NLQTUM01xofWCr15NmORqyOX215/vzarmlAKGe1ka94Nc/Kct1uSb9ok6CtuUWQstnhF
	lKh66iO3AdKVFUMbm3wSK/dBLm5JzJG3y/WMEsGsB+EjsC72i5ScKQqNmDntO/JSD7UXJ/
	37yBUCDXJLCoSCOcLn5X0puWuAkKFiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739974206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j0qvW9Ted+2fuZYC8Zw4Q6pvkin9Y9rXhmhvHhpbsXs=;
	b=R8r0Ax+LaUrZP3ReaJlNwEtlm4J7t7O/NTrEy2g0u+Sga0+lHr40eR5gklYrG+8gour/pj
	GnrJOO4EAfD/dPCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739974206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j0qvW9Ted+2fuZYC8Zw4Q6pvkin9Y9rXhmhvHhpbsXs=;
	b=2+NLQTUM01xofWCr15NmORqyOX215/vzarmlAKGe1ka94Nc/Kct1uSb9ok6CtuUWQstnhF
	lKh66iO3AdKVFUMbm3wSK/dBLm5JzJG3y/WMEsGsB+EjsC72i5ScKQqNmDntO/JSD7UXJ/
	37yBUCDXJLCoSCOcLn5X0puWuAkKFiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739974206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j0qvW9Ted+2fuZYC8Zw4Q6pvkin9Y9rXhmhvHhpbsXs=;
	b=R8r0Ax+LaUrZP3ReaJlNwEtlm4J7t7O/NTrEy2g0u+Sga0+lHr40eR5gklYrG+8gour/pj
	GnrJOO4EAfD/dPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 526C813715;
	Wed, 19 Feb 2025 14:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q0LXEz7mtWdCFwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Feb 2025 14:10:06 +0000
Message-ID: <9155f04f-74d9-41a3-9690-2ba38b3d79f0@suse.cz>
Date: Wed, 19 Feb 2025 15:10:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How does swsusp work with randomization features?
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>,
 "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-pm@vger.kernel.org, GONG Ruiqi <gongruiqi@huaweicloud.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, stable@vger.kernel.org,
 Yuli Wang <wangyuli@uniontech.com>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg
 <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Kees Cook <kees@kernel.org>, GONG Ruiqi <gongruiqi1@huawei.com>
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
 <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
 <Z68N4lTIIwudzcLY@MacBook-Air-5.local>
 <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local>
 <CAAhV-H4BSWC+K=qQfmHfdXuDqUgGcBLZ7Ftb6VEKs1QYVd6wxg@mail.gmail.com>
 <Z7CfLlEw9vtbFJwI@MacBook-Air-5.local>
 <CAAhV-H40eTo+tUx8b8=j4_9sfq7i9wo-LSO9pHKmRU7=wDDdbw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAAhV-H40eTo+tUx8b8=j4_9sfq7i9wo-LSO9pHKmRU7=wDDdbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/16/25 06:08, Huacai Chen wrote:
> On Sat, Feb 15, 2025 at 10:05 PM Harry (Hyeonggon) Yoo
> <42.hyeyoo@gmail.com> wrote:
>>
>>
>> You mean when SLAB_FREELIST_RANDOM enabled?
>> Assuming that...
> Yes.
> 
>>
>> > the CPU1's idle task stack from
>> > the booting kernel may be the CPU2's idle task stack from the target
>> > kernel, and CPU2's idle task stack from the booting kernel may be the
>> > CPU1's idle task stack from the target kernel
>>

The freelist can have more objects than the number of cpus and then it's not
just exchanging stacks between cpus but also with whatever else allocates
from the same slab.

>> What happens if it's not the case?
> SLAB means "objects with the same type", right? So it is probably the

kmalloc() is not objects of the same type, just size

> case. Yes, there is a very very low possibility that not the case,
> but...
> 
> In theory x86_64 also has a low possibility that the idle task's stack
> or other metadata be overwritten, then should we also disable random
> kmalloc for x86_64?

Does x86 really have such possibility? Can you explain in more detail?

> On the other hand, if we really need to handle this theoretic
> possibility about SLAB_FREELIST_RANDOM now, we can simply move
> init_freelist_randomization() after all initcalls, too.

I think a more robust approach would be to make sure any allocations
critical for hibernation/resume are static? Are there really multiple CPU's
idle task stacks involved? Aren't the critical paths single cpu only? I'd
assume when multiple cpus might be running at that phase, all bets about
determinism are off? So there could be a statically allocated stack for the
single cpu?

Note I don't know much about how hibernation works. But it seems fragile to
rely on rather complex allocators (slab over page allocators) to give me
exactly the same addresses accross boots, and hack around their
randomization features to help with that, if there's an alternative to use
static allocations for the critical pieces of the hibernation/resume code.

> Huacai
> 
>>
>> > but idle task's stack
>> > from the booting kernel won't be other things from the target kernel
>> > (and won't be overwritten by switching kernel).
>>
>> What guarantees that it won't be overwritten?
>> To me it seems to be a fragile assumption that could be broken.
>>
>> Am I missing something?
>>
>> --
>> Harry
> 


