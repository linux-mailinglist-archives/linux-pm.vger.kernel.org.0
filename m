Return-Path: <linux-pm+bounces-27379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9519DABC8F8
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 23:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6D14A154F
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 21:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232561A704B;
	Mon, 19 May 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE/R2W23"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2BD2FF
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689368; cv=none; b=ksr0wRgcpIVWJkGQoXWqvKSIR5RDRxwyzPhf8xrbTjCCqHUVOarHCImWn8RsY1mCo73hRBc26oNACbNbVEvaEDy/IX2LjiNec8ABuWdTWLi7/IoqXI6Yrk/qGYc1tMldHAjKjVtJSO67TZyfwwJ1xA6DVlV7z2JT1JVKZUkq1Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689368; c=relaxed/simple;
	bh=Xy6HiSEYCErWmGoi1cCXef/5iBu5QArWPQPMFezVfbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKFj4ogW+k1E/FyFTcjMPKRYL/Zi4neH/9FZtmFfdqz3ILqpAPiCRARO2ZCvpdpu2SED1WrJoBcR1zWtZAUPIRGxJ2db4JAu+X6pyyRQS0NOSBx6ki3lsSQ7N0KKVP3mTkGk+6rirtGjr7kWIx0FotzICYA82qx0rkBWewy8j30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE/R2W23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B26DC4CEE4;
	Mon, 19 May 2025 21:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689367;
	bh=Xy6HiSEYCErWmGoi1cCXef/5iBu5QArWPQPMFezVfbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UE/R2W23gJVA2eLHyd7WFiCbwNev694FyiDZnwhxhsrjhLZsSipqqUrPFquz/FdNn
	 8LPlrRT2dECwxNWa+GLMBzLRAHvY+eJO8XXSrNUPTeldUUdqr9OgnnIRnn9Hd2j08e
	 uQSgn5BYYEfMRPEZnRLyQIozVBru3iBSXwnKFM8O/aOMRn8fCJWF6aSBRisu1dadM6
	 jOC6uPTw4FeWMIGZ48WJyTNL9KdWN/zRn6mRBpjoio8483v/3DrWy0PWSafzXcWUf6
	 lOZu5584yUJfIS1SWajd+h9ARmvPhHvhPBkHeqjzSxIfJLy4tyJ0Pd9G7aiqdua0f/
	 RsF0I8RcGzLuQ==
Message-ID: <4a17230a-1340-445a-a8a3-33ca31f1ffa2@kernel.org>
Date: Mon, 19 May 2025 16:16:05 -0500
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
 dakr@kernel.org
Cc: AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 linux-pm@vger.kernel.org
References: <20250512212628.2539193-1-superm1@kernel.org>
 <2993537.e9J7NaK4W3@lichtvoll.de>
 <7274e7a9-d645-48f6-b672-f5d8366fc813@kernel.org>
 <5890366.DvuYhMxLoT@lichtvoll.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5890366.DvuYhMxLoT@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/18/2025 3:24 AM, Martin Steigerwald wrote:
> Hi.
> 
> Thanks for your reply, Mario.
> 
> Mario Limonciello - 14.05.25, 19:06:03 CEST:
>>> I will eventually see I bet.
>>>
>>> Currently I only compile my own kernel for my current ThinkPad which
>>> is not affected by this issue.
> 
>> As a debugging tactic for your problem you can try to save your shutdown
>> log to the EFI pstore by adding this to your kernel command line for a
>> boot.
>>
>> efi_pstore.pstore_disable=N printk.always_kmsg_dump=Y
>>
>> Then the next boot if you have the systemd-pstore service enabled it
>> will move the log into /var/lib/systemd/pstore.
>>
>> If you don't have it enabled you can run this to manually do it one
>> time.
>>
>> sudo systemctl start systemd-pstore.service
>>
>> Hopefully that log will be helpful in identifying your problem.
> 
> Thanks for the hint on how to debug things like this without some serial
> console or so.
> 
> As I use Devuan and thus do not have Systemd installed, I will need to
> find a different way to obtain the log from the pstore. But according to
> kernel documentation this seems to be easy enough¹:
> 
> mount -t pstore pstore /sys/fs/pstore
> 
> I can indeed mount it and there are a lot of "dmesg-efi_pstore-
> [timestamp]" files where time stamp seems to be in seconds since beginning
> of 1970.
> 
> [1] https://docs.kernel.org/admin-guide/pstore-blk.html
> 
> Thanks,

Great.  As a word of warning - you will want to clear these out manually 
while debugging if you don't have something like systemd to do it for you.

Now that you can debug, does this patch series improve anything?  Or 
it's a completely separate problem you're seeing?

