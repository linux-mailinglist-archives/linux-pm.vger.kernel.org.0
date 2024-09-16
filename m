Return-Path: <linux-pm+bounces-14318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B971B9799AA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 02:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31873B20A47
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 00:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E37360;
	Mon, 16 Sep 2024 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="V/mXpnHl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5268819;
	Mon, 16 Sep 2024 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726445674; cv=none; b=t/MAwxyl2dxgqmoqY94ATbIspswU8dw9w8W1RS55NC4kJTqgTz8aMcjiG3mrA90VHIMee1dVThG/1sm38JalexzZr+YBs3uw4IBVsIyjkvIlINFgngA/dcZUltK5zk9pR2NcMDt+HR6Z4jOxhAAjH89ESp8Nl67sJjjmp05brxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726445674; c=relaxed/simple;
	bh=rSml0PNnVYxR1O5pSCLr3TfEZ63jOVurEePRPalBOq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUVsDfV7MXio3JBQJtyyQfgMHt4DVfNqGJcC2okVYdY/3ay146qLQefBvULUueCt2fK42nhhhCyO/nQVNbHlTgwIGd3K/9moztHFkbmeeRpCgk0yaAdR5iwkrvvKJw3/9ygHdikp8bq9uMvVcZdc08eQFRuSTLVSNtHaRS0M2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=V/mXpnHl; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.189] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4X6QQ73XYCz1BDM;
	Sun, 15 Sep 2024 20:14:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1726445664; bh=rSml0PNnVYxR1O5pSCLr3TfEZ63jOVurEePRPalBOq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V/mXpnHlZfOXdwT951ZTf7GJVQT0Z7mG/R1iyj0otPkcxP0hNMJq14jb1+UcEAm3G
	 8BD2sTFtxRL+zU7OF76qqq1VUMf1RC6NhsobA/JoKssRVkI6ESEHze06NhF79NMjsV
	 Uuuh3OFKpjE2f01ipxAy9HkkeH+s3ybe01cJBkxE=
Message-ID: <b29b8750-5235-4097-a880-d8620da2520a@panix.com>
Date: Sun, 15 Sep 2024 17:14:21 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Kenneth Crudup <kenny@panix.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de> <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
 <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>
 <20240904122835.GG1532424@black.fi.intel.com>
 <98c3c35d-c694-4fcd-b8b4-6101c4764ae4@panix.com>
 <0e5168df-894e-4e35-8785-6c48328f8782@panix.com>
 <20240913052540.GN275077@black.fi.intel.com>
 <7ac9a400-fdb2-4d78-bacf-2e502c7338e8@panix.com>
 <ad0458ee-b75c-46f9-a012-1e0615aecf53@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <ad0458ee-b75c-46f9-a012-1e0615aecf53@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


OK, looks like the changes made to the (now-recently-released) 6.11 have 
fixed all the suspend/resume issues.

... and it turns out that my crashes on the CalDigit TB4 dock are 
probably related to a Thunderbolt-to-NVMe enclosure that was always 
plugged into to the dock; apparently when resuming "something" was 
waiting for the now-disconnected NVMe drive to come back, leading to the 
hangs. Disconnecting the enclosure from the dock seems to prevent the 
resume crashes.

I may try and root-cause that issue later, if I have time.

I guess we can call the Subject: issue mostly-solved.

-Kenny

On 9/13/24 14:59, Kenneth Crudup wrote:
> 
> Huh. This particular kernel is proving to be quite resilient, as in 
> "announce that it's been fixed, as that'll definitely make it break" 
> resilient.
> 
> I've done at least 5/6 suspend/resume cycles going between no dock, 
> USB-C/DP docks and now TB(USB4) docks and it's resumed properly every 
> time (and thanks to     9d573d195 even seems to recognize topology 
> changes too).
> 
> (My main USB4/TB dock is at home, A Caldigit 4 with a 7680x2160 DP 
> monitor on it; this tends to be the problematic dock for suspend/resumes 
> and provided calling these suspend/resume issues publically "fixed" 
> doesn't invoke Murphy's Law I'll know if I'd had continued success 
> tomorrow).
> 
> -K
> 
> On 9/12/24 23:11, Kenneth Crudup wrote:
>>
>> Well, now get this- I'm back to running Linus' master (as of 
>> 79a61cc3fc0) and I've been trying to get resumes to fail and they 
>> haven't (which means the next time I try after hitting "send" it's 
>> going to fail spectacularly).
>>
>> My SWAG is it may be related to commits 79a61cc3fc or 3e705251d998c9, 
>> but I'll see if it breaks and if it doesn't, all the better :)
>>
>> -K
>>
>> On 9/12/24 22:25, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Thu, Sep 12, 2024 at 02:12:27PM -0700, Kenneth Crudup wrote:
>>>> I'll run the stuff you need, but now it looks like whatever is breaking
>>>> suspend/resume in Linus' master has been ported down from upstream into
>>>> 6.10.10; I'm now getting the same panic()s as I did with master. I 
>>>> just had
>>>> a failed resume and the crash dump (which happened on its own) looks 
>>>> the
>>>> same as the one I'd posted here.
>>>
>>> Is the crash you see something different from the hang? If you can catch
>>> that with the backtrace and the register dump it should help.
>>>
>>> Couple of additional steps to try:
>>>
>>> - Unplug monitors from the dock and see if that makes it work (assuming
>>>    you have monitors connected).
>>>
>>> - Disable PCIe tunneling and see if that makes it work. This results
>>>    that the PCIe devices on the dock are not functional but it can point
>>>    us to the direction. You can do this on regular distro (Ubuntu, 
>>> Fedora
>>>    etC) like:
>>>
>>>      $ boltctl config auth-mode disabled
>>>
>>>    Or got to "Settings" -> "Privacy & Security" -> "Thunderbolt" and 
>>> flip
>>>    off the "Direct Access" switch.
>>>
>>>> I may try and find some time to bisect the issue, but it'll take 
>>>> some time.
>>>
>>> Sure.
>>>
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

