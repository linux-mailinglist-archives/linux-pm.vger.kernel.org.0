Return-Path: <linux-pm+bounces-13258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE6966A33
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 22:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511101F23055
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3475F1BF32A;
	Fri, 30 Aug 2024 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="iKRAcafK"
X-Original-To: linux-pm@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FE1BD00B;
	Fri, 30 Aug 2024 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048491; cv=none; b=s0FwnFljfAz94ZQbW/hN7S5QyOBrLD1dsdvbR7nA/Zdkfj01BGW3RX0iaPRW8KCzsRc6MXdoEzQ+uixE0Wq5D3eTbBYPssFH6YDWvtuORzDE0JvsGSsV/lTaQCnIlw3OX9TQ16zJupun4VF35gwXWXf4AKprw1YB86tGmUOjLbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048491; c=relaxed/simple;
	bh=/3fz10zRJVpyXK6sRaezWJ1/uIlBgVuX5fdAmisj53k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRt/O0cJGXJKLFONYcqA4gpF5W1mcnnylzafqUTJEk10kMgos9OhHmvxqmPNRWQbpglQk1QUxPLFzuLLbmfRfEcBdovhgICggY3q7cx2kcKTTPSREgx7UNxe0dy+O/cc8OzbTt9ZCabKAP+qh+M5ih62Pj+d/D1SiyKzonP4C98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=iKRAcafK; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4WwTMx2CCTzDSJ;
	Fri, 30 Aug 2024 15:53:01 -0400 (EDT)
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4WwTMn4Cpfzjym;
	Fri, 30 Aug 2024 15:52:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1725047574; bh=/3fz10zRJVpyXK6sRaezWJ1/uIlBgVuX5fdAmisj53k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iKRAcafK4SaOBv2EPbDHbwl2KZVb9FeS4GFDBoI8J4yLkhIdaCbn0wK9eMY1fhbmt
	 5orAaoy9ORkB9v17k/gdpzUPLuQakEifTN+ZjRrfg+l+7guquZREAE/EIuaCfJto0O
	 SMx83jbe9saV+bFr836WCqA2BCq/0aHeCquTNeOc=
Message-ID: <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
Date: Fri, 30 Aug 2024 12:52:52 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
To: Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, linux-usb@vger.kernel.org
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Me <kenny@panix.com>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <ZsvxR-dQAZtwNi0g@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Huh. So I checked out Linus' master (currently up to 6.11-rc5) and it 
seems to be doing the right thing now; I left a USB-C ALT monitor setup 
plugged in when I suspended, then came back to my 4K monitor setup via 
TB and it came up in the right resolution and everything.

Excellent news, so I'll keep using Linus' master until 6.11 is released.

Oh, and to answer your question, no, my system doesn't (perceptively) 
wake up when suspended if I connect/disconnect USB/TB cables.

... and unfortunately all I have now is (power-hungry) s0ix sleep.

-Kenny

On 8/25/24 20:06, Lukas Wunner wrote:
> [cc += Mika, linux-usb]
> 
> On Wed, Aug 21, 2024 at 03:05:59PM -0700, Kenneth Crudup wrote:
>> Subject says it all, but to recap my laptop doesn't detect Thunderbolt
>> topology changes when resuming or coming out of hibernate; i.e., the only
>> time a TB topology change happens is if a TB cable is disconnected while
>> suspended or hibernated, but if one is connected, or a different TB setup
>> altogether is connected when the system resumes it doesn't notice the
>> topology change until I disconnect and reconnect.
>>
>> I'm currently running 6.10.6, but this has been going on for a while.
>>
>> [    0.000000] DMI: Dell Inc. XPS 9320/0KNXGD, BIOS 2.12.0 04/11/2024
>> ...
>> [    0.136807] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P (family:
>> 0x6, model: 0x9a, stepping: 0x3)
> 
> This commit went into v6.11-rc1 and will at least detect replacement
> of PCI devices (to a certain extent):
> 
> https://git.kernel.org/linus/9d573d19547b
> 
> However PCI is layered on top of (tunneled through) the Thunderbolt
> switching fabric and that's where the real problem likely is here.
> 
> Maybe you can open a bug at bugzilla.kernel.org and attach full dmesg
> and lspci -vvv output in the working case (device attachment at runtime)
> and the non-working case (device attachment during system sleep).
> 
> Does the machine wake up if you attach devices during system sleep?
> Are you suspending to ACPI S0ix, S3 or S4?
> 
> Thanks,
> 
> Lukas
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

