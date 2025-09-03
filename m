Return-Path: <linux-pm+bounces-33756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D6B428EE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5413B29D8
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 18:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B88736809A;
	Wed,  3 Sep 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="kgl1Yhpx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4D3629B8
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925016; cv=none; b=ciVxVSRm3y8UmhwTDmVD+Qt9nPtFsVQHWGqUOAlSBoNzPamL+uAKhbloYo+kSu+5EI7Nuc/m9IE+aimjjDgTtTHsYgqC6ErdGcrXp6r+a0JI9rAOSCw5EgQZcevGLHKyuIGuSvsT2hcrRKVBMRLtayiqmIVMIITvPDANoDs1fQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925016; c=relaxed/simple;
	bh=8Tolsgar68WKQ7ljNjMIcBI9fk5becSiVo8kIRtMF7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9iqqCT9c8vAb03UUffknM0pORStm6NorR5TR4LU/3wKMcgIZEVsZo159XN//Mg5eKB+TmAtmunKwFeVJW04NJjbZbPlsx7SCxC6zzPHMpWQzQOWl8SJ+htBXEVosPNQPbApYX38Z+tt+aDC+G5u8O5qtCTkVvqpi41eqUd98hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=kgl1Yhpx; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.36] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cHBMT0GQ2zJvY;
	Wed,  3 Sep 2025 14:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1756925013; bh=8Tolsgar68WKQ7ljNjMIcBI9fk5becSiVo8kIRtMF7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kgl1YhpxxsJ6oyr/q2MMuIFc+NMUsC/ssDUyWpvUeYrOAEqwL/iWOveV40uLCcpjm
	 QZ9Sb0kf/qbe6Sly1E7bAc1nSYgvaeM46tEqGBRWeOBt7uwNW7vgJZWLNdxLjwjLul
	 TmUqU5UGlYh+ShyLF+S1rdo1iXIbUkJ5ZJKceN4I=
Message-ID: <e08a1424-6873-4c61-b97b-94c4e9a9077c@panix.com>
Date: Wed, 3 Sep 2025 11:43:32 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU
 topology
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, lukasz.luba@arm.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Kenneth C <kenny@panix.com>
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
 <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
 <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
 <fbf349ec-f200-4eff-9a5b-6674a1eef52a@arm.com>
 <d9e8f92f-08d1-4006-accd-7a2b65b0bc6c@panix.com>
 <CAJZ5v0jmMbWjFZUZe56ZYzjsHYE1=fSb+5MWNLMN_K4ZCJPu+Q@mail.gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <CAJZ5v0jmMbWjFZUZe56ZYzjsHYE1=fSb+5MWNLMN_K4ZCJPu+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Is there a way to distinguish between "offline cores" and 
"'non-'existent" cores?

This way we could just skip the ones that "aren't" there, right?

-K

On 9/3/25 11:40, Rafael J. Wysocki wrote:
> On Wed, Sep 3, 2025 at 8:39 PM Kenneth Crudup <kenny@panix.com> wrote:
>>
>>
>> On 9/3/25 10:26, Christian Loehle wrote:
>>
>>> Yeah looks like we're dropping that debug message.
>>
>> Huh. Then I guess the whole thing's a non-issue after all- but that
>> being said, the whole point of the reschedule is in case cores come up
>> later, right? So in a case like mine, won't it just keep constantly
>> rescheduling?
> 
> It will, but that's a separate issue.
> 
> I think that it needs to back off exponentially or something like that.
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


