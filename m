Return-Path: <linux-pm+bounces-14125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7979778A6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 08:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FD81C211A7
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 06:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2B4187849;
	Fri, 13 Sep 2024 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="tBiYMI1O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C76224CF;
	Fri, 13 Sep 2024 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207896; cv=none; b=D9e7HJQNlho4V3e7q9OlZaBnOzUteW5SYOSMjxi4MliZNskmsxMBBf+aQLRUfu21OshIb+OjZBaHn5vFAHLHjIOWOEWD2F5ShhownQsCPKyn37bzwijUhAjcsOs/mI64PI9ykAua9YFN71ItqOytZN4bJQ/8cStlnUZqlHZyqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207896; c=relaxed/simple;
	bh=6NrzvveOY/zjepMB9eFxUAY9/nbJDLg4rrAStSAfO3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOOW/YrRWK11cfQzA/684nt3iJit9lGjhfN2SRxvd+Iejgx4xiDiECO5Dmi3o4rlzmzds9/CvFuP7F8IaEFH0DMoDVHAdcBSsogGXTEz4fzPN22X3D2nDRmqF4FYMuiXf4Rvx0H/KKBFH0O8jf+5JBZWFJrGpAKEAfZnYxwJLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=tBiYMI1O; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.123.3] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4X4kTc0RjHz4ZMj;
	Fri, 13 Sep 2024 02:11:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1726207892; bh=6NrzvveOY/zjepMB9eFxUAY9/nbJDLg4rrAStSAfO3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tBiYMI1Oyp1Ub3T6WHj+BlqB2DZiGRNMDyNWXBVKC01MoGU1XEIL5nyxvutLUj7jX
	 pMqVBztUsL8kUA4FsPlWiP0kQ7llIK2FUwuMT4tBsn08W7BLwthYMbOzWjRSu2zR8R
	 0Jwp5pe/WbGVYRF5k6JBROQC6sFEMcbKFJDo7poQ=
Message-ID: <7ac9a400-fdb2-4d78-bacf-2e502c7338e8@panix.com>
Date: Thu, 12 Sep 2024 23:11:30 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Me <kenny@panix.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de> <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
 <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>
 <20240904122835.GG1532424@black.fi.intel.com>
 <98c3c35d-c694-4fcd-b8b4-6101c4764ae4@panix.com>
 <0e5168df-894e-4e35-8785-6c48328f8782@panix.com>
 <20240913052540.GN275077@black.fi.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20240913052540.GN275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Well, now get this- I'm back to running Linus' master (as of 
79a61cc3fc0) and I've been trying to get resumes to fail and they 
haven't (which means the next time I try after hitting "send" it's going 
to fail spectacularly).

My SWAG is it may be related to commits 79a61cc3fc or 3e705251d998c9, 
but I'll see if it breaks and if it doesn't, all the better :)

-K

On 9/12/24 22:25, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Sep 12, 2024 at 02:12:27PM -0700, Kenneth Crudup wrote:
>> I'll run the stuff you need, but now it looks like whatever is breaking
>> suspend/resume in Linus' master has been ported down from upstream into
>> 6.10.10; I'm now getting the same panic()s as I did with master. I just had
>> a failed resume and the crash dump (which happened on its own) looks the
>> same as the one I'd posted here.
> 
> Is the crash you see something different from the hang? If you can catch
> that with the backtrace and the register dump it should help.
> 
> Couple of additional steps to try:
> 
> - Unplug monitors from the dock and see if that makes it work (assuming
>    you have monitors connected).
> 
> - Disable PCIe tunneling and see if that makes it work. This results
>    that the PCIe devices on the dock are not functional but it can point
>    us to the direction. You can do this on regular distro (Ubuntu, Fedora
>    etC) like:
> 
>      $ boltctl config auth-mode disabled
> 
>    Or got to "Settings" -> "Privacy & Security" -> "Thunderbolt" and flip
>    off the "Direct Access" switch.
> 
>> I may try and find some time to bisect the issue, but it'll take some time.
> 
> Sure.
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

