Return-Path: <linux-pm+bounces-6259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1B8A0870
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 08:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7051F25938
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2886A13CAAE;
	Thu, 11 Apr 2024 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="tRYL1WpP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72A13CA9C
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816805; cv=none; b=p6yIPb8G4D0532w/tUDbETiAX63sad+zTXcYMZvq9JXLVwuVE9t/xTzI7mimz9Ho7dCOwmYi/M3TdDgP65PaRCH0X4UZCDVL8NGK2AcL5nI2kv5tWbOAjjfkz5pdI+IbMF7CyrBM9+dYH1nP0zgKJUhjdwrWlcv+pfjOmu7oyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816805; c=relaxed/simple;
	bh=NShf+u8DNtXFzrZE0/9Rdcy8z5WHE/GYnNzx6CFVFwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIilTf+A+rbzvbzlbgKRdvz/QcJGIiUEJMOomGY3mnfiIq9Mbf6xzTAiosyXV1o2lBmIimS9wUdYwe3KliXM+boF96Go7qTLpCAcOZA5kmPRxGEyy1m0t5L42fMcrNfWCj95E2X3WBm2JkKXNjlNhsYLEqO6PFDFn+yAcQSgvFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=tRYL1WpP; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.8.249] (ip72-193-154-75.lv.lv.cox.net [72.193.154.75])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4VFV8K2gTXz12Nv;
	Thu, 11 Apr 2024 02:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1712816785; bh=NShf+u8DNtXFzrZE0/9Rdcy8z5WHE/GYnNzx6CFVFwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tRYL1WpPDPwxO/ufG/QNFJ37M4R501FRfdxtA7Rv0Me9RP5y7B4yd8G0trNZ79PIN
	 GRJqOIFR6lNMYXPWo5zGUZz+BVXmRbCcquUuQLdOQoy70zUUEsDnB0Z3AJdWyRWB/F
	 xVZsTgA8v8kLltfbMYXoWyJ1QejKZIaP5j9pHuyo=
Message-ID: <56308bc8-0fd3-4693-9218-63348da8cf36@panix.com>
Date: Wed, 10 Apr 2024 23:26:14 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit 0c4cae1bc ("PM: hibernate: Avoid missing wakeup events
 during hibernation") prevents my laptop from hibernating
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: chris.feng@mediatek.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <cb5d3388-3d2c-42f1-9e93-026d14c7e827@panix.com>
 <124e6b11-ca62-48dc-9401-7932845e19f7@intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <124e6b11-ca62-48dc-9401-7932845e19f7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Well, the good news is the patch in the commit fixes the "bailing out of 
hibernate" issue.

(The bad news is resume from a hibernate still fails, but that's an 
issue to be bisected later)

-Kenny

On 4/10/24 12:00, Wysocki, Rafael J wrote:
> [Resend with the linux-pm address fixed]
> 
> On 4/9/2024 10:40 PM, Kenneth Crudup wrote:
>>
>> While in the process of trying to fix kernel 6.8 hibernate issues on 
>> my laptop (including bisecting why my laptop crashes on resume from 
>> hibernate on my machine (a Dell XPS 9320, i7-1280P, and using a 
>> swapfile)), I'd determined the named commit prevents hibernation from 
>> occurring in the first place.
>>
>> Are there any other reports of this?
>>
> 
> There are.  Please see
> 
> https://patchwork.kernel.org/project/linux-pm/patch/878r1tpd6u.fsf_-_@gmail.com/
> 
> 
>> What do you need from me to help fix this issue? I'm assuming that 
>> whatever (pending?) wakeup event that's causing the rejection does not 
>> seem to hinder previous kernels from having sucessful suspend/resume 
>> cycles.
>>
> 
> If the patch above does not address the issue for you, the problematic 
> commit will have to be reverted I'm afraid.
> 
> Thanks!
> 
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

