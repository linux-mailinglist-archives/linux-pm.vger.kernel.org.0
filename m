Return-Path: <linux-pm+bounces-27147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BBAAB724B
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247521B682EE
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3571F5423;
	Wed, 14 May 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxH9dgsM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0923CE
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242365; cv=none; b=rWP7UyW4E2akuK45DyUragTwQNfI4ECWP1ts7Oegujh9TgYZDuGHI8tUHu8cn5KCqylTzSuHcZpy8KXyPXRRGZo0/+H/S114Y226NPYBo2uDSu2IEmomlR9igJ4PlePWlA3p/n6p0epvbOw4HtUsVE8sxLa4YnPILUPJ3Y30qiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242365; c=relaxed/simple;
	bh=zeakI3717Hx2wD0raI6YRU07JQpgH8VrAtCJT1R1yyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be4scZGtIyPAlP5XWnIzlh5CCnw0hD1rSrBSS0Dl8kDOouJ+AE+lEuuYJ0uw7xV0BIw61J37UYSu5WNCneBq8YHpvPHqW6x0cm7FcMO7rrjZlzATU9IrCpUF9vgJwsNOzk4XeUz50eNybJlhIiZnUnmH6mD2TQ2Gi2XGXNHCHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxH9dgsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B38C4CEE3;
	Wed, 14 May 2025 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747242365;
	bh=zeakI3717Hx2wD0raI6YRU07JQpgH8VrAtCJT1R1yyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qxH9dgsMuKswMR30hqS6qzvI4sqNUerys1MvBc38kVvXdJMsWVOJW0Z7c8uCs007f
	 GZ40hIKLOvgU8RKiYRmAUQhvf5k63mIBAlt2VUZODTsQoKXDJU3stuyn6DBZsK7kfK
	 hSEm6UVnlRxWRLqGGaUXZGpcNT9cin54VjLqeLuPoRruYes6hS4PqRoxIWJWbc+gu2
	 XTUAHONT5mdu8LNIThaOpioUd9jrpjEt2Xvb/4B0qHY3uTVGDNsHHRMo2IX4xWU10R
	 Nyqz1hvoMTrsQC6ar5jAnet0KlRcSgurvHncmvvJFCI4cdWX0aqK20VhPZ7rHkXUeO
	 6GMFIvdltvg3g==
Message-ID: <7274e7a9-d645-48f6-b672-f5d8366fc813@kernel.org>
Date: Wed, 14 May 2025 12:06:03 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: Use hibernate flows for system power off
To: Martin Steigerwald <martin@lichtvoll.de>,
 Denis Benato <benato.denis96@gmail.com>, rafael@kernel.org,
 len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org,
 dakr@kernel.org, Mario Limonciello <superm1@kernel.org>
Cc: AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 linux-pm@vger.kernel.org
References: <20250512212628.2539193-1-superm1@kernel.org>
 <6cc4caa4-ca75-4b32-83a9-1dea761046ef@gmail.com>
 <e3aa4d7d-e854-4ee2-aa5d-6371e8aa4ed8@kernel.org>
 <2993537.e9J7NaK4W3@lichtvoll.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2993537.e9J7NaK4W3@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/14/2025 11:30 AM, Martin Steigerwald wrote:
> Hi.
> 
> Mario Limonciello - 14.05.25, 18:15:00 CEST:
>>> Hello,
>>>
>>> As for the previous version this patch makes my laptop shutdown
>>> cleanly very quickly and I could not link to any regressions or
>>> change in behavior while laptop is on.
>>>
>>> Tested-by: Denis Benato <benato.denis96@gmail.com>
>>
>> Thanks Denis, that's great news to hear.
> 
> Thanks!
> 
>> FTR I noticed that this needs some error handling in case the hibernate
>> flows fail, so assuming Rafael is generally amenable to this direction
>> the next spin I'll add something like this instead to fall back to the
>> previous shutdown flow if that happens.
> 
> I do not know the context of this patch except this mailing list thread.
> 
> However… on various ThinkPads I had the issue of the device not powering
> down with certain kernel versions. Not even during a normal shutdown
> attempt. Also not with hibernation to disk. Still holding on to an older
> kernel version for a X260 for example. But also a T14 AMD Gen 1 is
> affected no longer in frequent use currently while a T14 AMD Gen 2 is
> absolutely fine. Could this patch help with that?

If the root cause of your issue with the inability to shut down is that 
there were devices left in D0 at shutdown and the firmware was expecting 
them to be powered down then this patch may help your system.

If it is a different problem then I wouldn't expect any differences from 
this patch.

> 
> I will eventually see I bet.
> 
> Currently I only compile my own kernel for my current ThinkPad which is
> not affected by this issue.
> 
> Best,

As a debugging tactic for your problem you can try to save your shutdown 
log to the EFI pstore by adding this to your kernel command line for a 
boot.

efi_pstore.pstore_disable=N printk.always_kmsg_dump=Y

Then the next boot if you have the systemd-pstore service enabled it 
will move the log into /var/lib/systemd/pstore.

If you don't have it enabled you can run this to manually do it one time.

sudo systemctl start systemd-pstore.service

Hopefully that log will be helpful in identifying your problem.

Note: Don't do this "every" boot; it's going to apply more wear to the 
NVRAM backing.


