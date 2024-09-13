Return-Path: <linux-pm+bounces-14212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AC978AFF
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 23:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFA82847E0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC4155CBF;
	Fri, 13 Sep 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="Dq37+OLs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE8126BE6;
	Fri, 13 Sep 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726264753; cv=none; b=P3rqqUK9e25TMkYzaw+TvN3dw98CW+nxUvs1CkMUTa+DIEwXLsdwCiFSTxRc4G1QAOVUaBYhnA+ZDDZRgFpdj4QDD9EHfP8w9lXRxrt/1l7ETcl7eAgzkIwD8hFGj6758da+ERycwNRnY9kKmMLhBVKB+7lEp3witTJFTUQqH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726264753; c=relaxed/simple;
	bh=UTm6ACR3Fr5v/JNoDjfcOje9uZzp0NsX2AMJLzaMnY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EboUKNUNZb2k8tIK2363hqhMZjbfdm8mWSaff2ShIy0TLOPUomRnyfOrtW+bEHoSV0NFAKKZkaTxn4lMY8dE92HQmz9Rp88ngj/foGqWtO4u0AMsqBl2l8eoK1ytKUx/AkfUDefhsGvH7tmA7AZi24V02xwr/HXHvyCOvWk2xMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=Dq37+OLs; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.123.3] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4X57Vw1T06z4MZM;
	Fri, 13 Sep 2024 17:59:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1726264744; bh=UTm6ACR3Fr5v/JNoDjfcOje9uZzp0NsX2AMJLzaMnY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Dq37+OLsyrkTA2cAsLieiQZkxbLkZ5Q3TgZ4LjQv3aqua88A6B+zFR6KZOVeiqgEL
	 2NX7xZvcpcnbfAXaBTRKmnkwny5uq3Ij4+QW1QLOKLm0bjVMBISvRA6lgZ9vY6/tom
	 uyGnO2Ux4h0Az1i92xNE858+iD3C8uzW4CKE1zUY=
Message-ID: <ad0458ee-b75c-46f9-a012-1e0615aecf53@panix.com>
Date: Fri, 13 Sep 2024 14:59:02 -0700
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
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Kenneth Crudup <kenny@panix.com>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de> <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
 <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>
 <20240904122835.GG1532424@black.fi.intel.com>
 <98c3c35d-c694-4fcd-b8b4-6101c4764ae4@panix.com>
 <0e5168df-894e-4e35-8785-6c48328f8782@panix.com>
 <20240913052540.GN275077@black.fi.intel.com>
 <7ac9a400-fdb2-4d78-bacf-2e502c7338e8@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <7ac9a400-fdb2-4d78-bacf-2e502c7338e8@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Huh. This particular kernel is proving to be quite resilient, as in 
"announce that it's been fixed, as that'll definitely make it break" 
resilient.

I've done at least 5/6 suspend/resume cycles going between no dock, 
USB-C/DP docks and now TB(USB4) docks and it's resumed properly every 
time (and thanks to 	9d573d195 even seems to recognize topology changes 
too).

(My main USB4/TB dock is at home, A Caldigit 4 with a 7680x2160 DP 
monitor on it; this tends to be the problematic dock for suspend/resumes 
and provided calling these suspend/resume issues publically "fixed" 
doesn't invoke Murphy's Law I'll know if I'd had continued success 
tomorrow).

-K

On 9/12/24 23:11, Kenneth Crudup wrote:
> 
> Well, now get this- I'm back to running Linus' master (as of 
> 79a61cc3fc0) and I've been trying to get resumes to fail and they 
> haven't (which means the next time I try after hitting "send" it's going 
> to fail spectacularly).
> 
> My SWAG is it may be related to commits 79a61cc3fc or 3e705251d998c9, 
> but I'll see if it breaks and if it doesn't, all the better :)
> 
> -K
> 
> On 9/12/24 22:25, Mika Westerberg wrote:
>> Hi,
>>
>> On Thu, Sep 12, 2024 at 02:12:27PM -0700, Kenneth Crudup wrote:
>>> I'll run the stuff you need, but now it looks like whatever is breaking
>>> suspend/resume in Linus' master has been ported down from upstream into
>>> 6.10.10; I'm now getting the same panic()s as I did with master. I 
>>> just had
>>> a failed resume and the crash dump (which happened on its own) looks the
>>> same as the one I'd posted here.
>>
>> Is the crash you see something different from the hang? If you can catch
>> that with the backtrace and the register dump it should help.
>>
>> Couple of additional steps to try:
>>
>> - Unplug monitors from the dock and see if that makes it work (assuming
>>    you have monitors connected).
>>
>> - Disable PCIe tunneling and see if that makes it work. This results
>>    that the PCIe devices on the dock are not functional but it can point
>>    us to the direction. You can do this on regular distro (Ubuntu, Fedora
>>    etC) like:
>>
>>      $ boltctl config auth-mode disabled
>>
>>    Or got to "Settings" -> "Privacy & Security" -> "Thunderbolt" and flip
>>    off the "Direct Access" switch.
>>
>>> I may try and find some time to bisect the issue, but it'll take some 
>>> time.
>>
>> Sure.
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

