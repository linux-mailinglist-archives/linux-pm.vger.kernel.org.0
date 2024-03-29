Return-Path: <linux-pm+bounces-5704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEDE8923C4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 19:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12EC1F2291B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1601B4AEED;
	Fri, 29 Mar 2024 18:59:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123063B293;
	Fri, 29 Mar 2024 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738780; cv=none; b=neRCNbiLBzU49WnZZfT3CE4W5WFC7wZCJjGb4BMHw8H06QOHF4DxvVu++LQb3asIRsSsAsiN+jnVS3WYT+O6NSG6KZgU23WVKDQZOoIniCupwUgxq9qh3G4CsbbJ2723RadwI65xjCXZ4mIK+HeFF0t0cIedb9ju2oY/5X7XYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738780; c=relaxed/simple;
	bh=LRMKwu/ap0QLihMA7EqVXj8HuqIldcCnL+d0oAI08Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0VDmcJ89fjW47D/+tD40drelYcKeB3MOJ+1EvqrDIDa/mXoqT/FmuEbiAC3NcEhjCICNdzF4SHRytF+9+N+vCMvLAGeXMpS4jQJAokgDKi4jJlEdD6SBFWD4mFF9pP0D6KfjLxkjmUF4xTHH2F3ePueJp8kVm/RI8qE9huHTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af39e.dynamic.kabel-deutschland.de [95.90.243.158])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 12CCC61E5FE07;
	Fri, 29 Mar 2024 19:59:15 +0100 (CET)
Message-ID: <31aa7758-f854-4f96-8041-26b7197982df@molgen.mpg.de>
Date: Fri, 29 Mar 2024 19:59:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PM: hibernation: Image allocation is 28906 pages short
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <58c89870-f7cd-4116-aaea-2ef53a1ab6c7@molgen.mpg.de>
 <Zgb0RlS8QipgVZgW@duo.ucw.cz>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Zgb0RlS8QipgVZgW@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Pavel,


Thank you very much.


Am 29.03.24 um 18:03 schrieb Pavel Machek:

>> On a Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022 with Debian
>> sid/unstable and self-built Linux 6.9-rc1+ with one patch on top [1] and
>> KASAN enabled
>>
>>      $ git log --no-decorate --oneline -2 a2ce022afcbb
>>      a2ce022afcbb [PATCH] kbuild: Disable KCSAN for autogenerated *.mod.c intermediaries
>>      8d025e2092e2 Merge tag 'erofs-for-6.9-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
>>
>> the system tried to hibernate, but failed:
> 
>> Where is that image allocated? On the disk? There is still 65 GB of space,
>> so 16 GB of memory should fit? Could the error message be improved, so users
>> know more details to fix it?
> 
> In swap. See docs.

Thank you. Unfortunately, I am not seeing my case described in 
`Documentation/power/`. Only:

> Q:
>   If my application(s) causes lots of memory & swap space to be used
>   (over half of the total system RAM), is it correct that it is likely
>   to be useless to try to suspend to disk while that app is running?
> 
> A:
>   No, it should work okay, as long as your app does not mlock()
>   it. Just prepare big enough swap partition.

I have 16 GB RAM and 8 GB swap partition.

     $ LANG= free
                    total        used        free      shared 
buff/cache   available
     Mem:        13828768     9760192     3115932     5383256 
6681400     4068576
     Swap:        8387904     1531820     6856084

Shouldn’t user space (systemd or GNOME?) then know beforehand if 
hibernate is possible? Is there a script for users to check, if 
hibernation would be possible?


Kind regards,

Paul

