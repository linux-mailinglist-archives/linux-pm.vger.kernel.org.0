Return-Path: <linux-pm+bounces-24837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FFEA7C7B3
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 07:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33522189DC6F
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 05:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE1219E998;
	Sat,  5 Apr 2025 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="WC/Jj2uS"
X-Original-To: linux-pm@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796641C27;
	Sat,  5 Apr 2025 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743830132; cv=none; b=moW0jCMXTOHozp8ZIn+ZH7ExcwZYthqIBXWtGm4rUPHjWGHs2MN56Qz1cQD5vF5Ua7ulxRdEG4hAxSD8HntVNwb6nJHPO3lMv2SSk/+pRR/j372tMy3MvY/MHO9CVoWnppKNmCAL4EImxrEumUm3MNtna+ZqLkYaHsbFDkZ9vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743830132; c=relaxed/simple;
	bh=i2DeLSvosoDmthVPnFC9xDx3X9coPCSU4D2OwPh+kNA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PTHGV923e3uY+zqitljMG0OeY5s3aJzybuYMgA+E/1T0ptbMKDlfDhDqTwR7lVv8srLTGRDygpY3vVQZXApeACaA6rL9+oU4/0GNooPr8ANhbgculnTH0eFQ9X+PEzE6j4N0s/TSzYH4y8jkI8NKRD2pwvfsV8ZLggGUn8hYH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=WC/Jj2uS; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Message-ID: <b09aab52-8fba-49c4-8dc7-9d5cca0f5b98@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743830128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYhB80NQAEOdELsTajiPWw1wUNFuHRaAVe3BXK9EaeI=;
	b=WC/Jj2uSSBgrctke8lvLcxJfUYYOWf5ktSNDeGd2JRF9/8K3BMadYBjX7si/0FkQpYEozs
	TAT2hjGjSnQ99oP5s6oaIgNx0KhAMZ4PDoj+CoOczq6IQEdwBATSwrBt2GpxFDiMGYHfhE
	eJW4rsq1R+xMMJaBoMo8Ro2uA9MHL7GidG3yZmW6mgZsydLvf3tQQEsr04495XHTC0B3I1
	DLz5b8IEvjFYDnNrATl4uR546D6zy792Ub3hVgqXgs3BXqdqSfDAEb7woCbjelDFX6AcdZ
	qFbWJROMbvUQle+DkdGsHLZLh5yYvKxLSjn9vIsSWkQR4d9mmQO3Qf4wCoj41Q==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=msizanoen@qtmlabs.xyz
Date: Sat, 5 Apr 2025 12:15:20 +0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
From: msizanoen <msizanoen@qtmlabs.xyz>
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
 ytcoode@gmail.com, kexec@lists.infradead.org, linux-pm@vger.kernel.org,
 akpm@linux-foundation.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <Z4WFjBVHpndct7br@desktop0a> <Z4WGSMdF6seQm9GV@desktop0a>
 <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
 <Z-8E-LLs1dFWfn6J@desktop0a>
 <691be719-7d4c-4cb1-87d6-cca7834547fe@qtmlabs.xyz>
 <004d85e4-d23d-43af-87ca-8d037abba51d@qtmlabs.xyz>
 <4081fbd9-0a5f-49d6-9553-4f964bf5ef27@qtmlabs.xyz>
Content-Language: en-US
In-Reply-To: <4081fbd9-0a5f-49d6-9553-4f964bf5ef27@qtmlabs.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

Submitted for review: 
https://lore.kernel.org/stable/20250405-fix-e820-nosave-v1-1-162633199548@qtmlabs.xyz/

On 4/4/25 12:50, msizanoen wrote:
> Here's an updated version of the patch that better handles 
> pathological e820 tables.
>
> On 4/4/25 11:56, msizanoen wrote:
>> Also, can you reproduce this issue with a target kernel (the kernel 
>> being kexec-ed) that has one of the patches attached (select the 
>> correct one according to your kernel version) applied, with either 
>> kexec_load or kexec_file_load?
>>
>> On 4/4/25 09:54, msizanoen wrote:
>>> Can you send the dmesg logs for this case (6.13 + mentioned patch 
>>> series backported as target kernel, using kexec_load)?
>>>
>>> On 4/4/25 05:00, Roberto Ricci wrote:
>>>> On 2025-04-01 19:59 +0700, msizanoen wrote:
>>>>> [snip]
>>>>> It seems like `e820__register_nosave_regions` is erroneously 
>>>>> marking some
>>>>> kernel memory as nosave in the presence of sub-page e820 regions. 
>>>>> In theory
>>>>> backporting
>>>>> https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/ 
>>>>> should
>>>>> be sufficient to avoid this but a fix for the actual root cause is
>>>>> preferred.
>>>> When using kexec_file_load, this patch series fixes the issue not only
>>>> in theory but also in practice.
>>>> But the issue with kexec_load (see
>>>> https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
>>>> ), which might be related, is not fixed.

