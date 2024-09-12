Return-Path: <linux-pm+bounces-14116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C9977364
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 23:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BDE1F24A88
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB01C2322;
	Thu, 12 Sep 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="liPO5dG3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0A1C1AD7;
	Thu, 12 Sep 2024 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175559; cv=none; b=FoHL9h4sYvzhFHlmh5xABE6kOqzNkCR3n1MAOrBZZ4nanLaCYCWZ/m/He0bV0Tzglf2/SdY4LdElsGlbmUvzuOwWMh5y6ZVpKpZq3iSJADYjOOLZSZewAP+KxW7Mfqpj3XM3fx+jo27FyYQh0u8a4hpOPw0gSVPcj0R5DnFn3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175559; c=relaxed/simple;
	bh=LFZmYGo8h9oi2U1Zg50FRW+vhqFPWrbYW+NIhlWueZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh3nyeAukiQNRr7Tnr3uvZGBYjuJvY3WjRc6JL1LtscLPm/SbahDU65/XCab9yZUOjexdco5e8zqPJ3Y+hD4Yt+i1WoenT5OidUuRCU5xvmOAl7A85JEQ7ra6/FH1opIz44VWTG5ZXoIFKiiYqXnpP39KKhfa9W0OYs4939pA3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=liPO5dG3; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [172.16.225.84] (syn-076-167-104-212.res.spectrum.com [76.167.104.212])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4X4VWc4RF0z4DmW;
	Thu, 12 Sep 2024 17:12:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1726175549; bh=LFZmYGo8h9oi2U1Zg50FRW+vhqFPWrbYW+NIhlWueZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=liPO5dG3r0r3gORS46SnzZmwWyq9zjinhaHFujt7nM9gr+OG09bk4l4CvUbaik+iK
	 v1P4nr5r+qMRKAeA8IVhm4G2qV55QmAiz+2ph/P727Z9k5C+vqYIQ5lzb93sq5F50P
	 Xc03LDampk6OAhGig/vK7O3XvKEjVWZuzT5vow2s=
Message-ID: <0e5168df-894e-4e35-8785-6c48328f8782@panix.com>
Date: Thu, 12 Sep 2024 14:12:27 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Me <kenny@panix.com>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de> <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
 <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>
 <20240904122835.GG1532424@black.fi.intel.com>
 <98c3c35d-c694-4fcd-b8b4-6101c4764ae4@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <98c3c35d-c694-4fcd-b8b4-6101c4764ae4@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I'll run the stuff you need, but now it looks like whatever is breaking 
suspend/resume in Linus' master has been ported down from upstream into 
6.10.10; I'm now getting the same panic()s as I did with master. I just 
had a failed resume and the crash dump (which happened on its own) looks 
the same as the one I'd posted here.

I may try and find some time to bisect the issue, but it'll take some time.

-K

On 9/9/24 00:51, Kenneth Crudup wrote:
> 
> I can't get to the dmesg when it crashes, but I did a SysRq-S/C and have 
> attached the crash output; let me know if this is at all helpful.
> 
> I see I'd SysRq-S/C on a previous hang, I've attached that one, too.
> 
> This particular time it suspended OK, but hung indefinitely when I 
> plugged it into another TB3 dock (the previous one was TB4, if it matters).
> 
> 
> On 9/4/24 05:28, Mika Westerberg wrote:
>> Hi,
>>
>> On Tue, Sep 03, 2024 at 11:10:41PM -0700, Kenneth Crudup wrote:
>>>
>>> ... or, maybe not. Turns out that sometimes my system can't suspend 
>>> (just
>>> hangs, spinning hard somewhere based on the heat and the fans) when 
>>> plugged
>>> into a Thunderbolt dock at the time of suspend.
>>
>> Can you create a bug in bugzilla.kernel.org and attach full dmesg so
>> that you enter suspend with dock connected (so that the issue
>> reproduces)? Please also add "thunderbolt.dyndbg=+p" in the kernel
>> command line so we can see what the driver is doing. Also probably good
>> to add the lspci dumps too as Lukas asked.
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

