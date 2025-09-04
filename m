Return-Path: <linux-pm+bounces-33844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E3B44000
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3721C84CCD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6466205E25;
	Thu,  4 Sep 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS/Od8SV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1695C8F0
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998531; cv=none; b=dk85AufauB82milv9rp837Eq6zQJmO5WnsHXF4fHas8u8VIpwgfZy/epRYx2wtpNYlE/6+VYrkWiTRQs/7gvoA6XRgu8SFlZ8sZYKvgqmF5aXliBf8o71Sn9tYcTVzyW9ETRGN+BEy/M/JBzyrIpvip8TL7vroeaV/+iS+Mfsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998531; c=relaxed/simple;
	bh=Gw4O+G0PhtA9vAN65fgilqG7QYFXkCkwV70c7+U9p/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmKJOjEAH9utu/pX43u77ydBwN94SdsiKLfIwD8/X+Dblym6a1UWV1r81lJcnjs5A8YhzwAm8g8+L+CNpiksPDv9OJ9eeFz654g2cIZjN6i9Dwgv/nLQqeAtXOubkDei7vwRROlul4vjoF3MPRA8DfP1NzztLSIPOw/UbZ7ftEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS/Od8SV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B90C4CEF0;
	Thu,  4 Sep 2025 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756998531;
	bh=Gw4O+G0PhtA9vAN65fgilqG7QYFXkCkwV70c7+U9p/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LS/Od8SVLOw/ucyhvcYZ7BBChDc5h85CahOzjQr2Bcq9QvN817PH3I7EPnlShPNxa
	 BiA/9B5hjKzkRc41ltgO4h5Egcrjb9uWNb/62wIAUrwG6BxuPRQetyW2Vq2JEy1f+R
	 CV3kv3Q8WKzV/1AB/mJbayb/AQmxLhyzUpKwkUJvIkK3ejdcenkI8Vun9PsTVNhf0B
	 S6ojqsXjtSEP3PkLkC7cBu1oVV1o2tFj/L4zQ7QHMzuIEpJ01jfWyfpxJeYtf2fRBy
	 5FgZZqU0rW6PrOzD1KHAkZxjQtRdwbW1X7zTpmzaEllbaBvfE6K6nZ1ZR9Hx/Dn2Xc
	 dO/qMhsIAWHhQ==
Message-ID: <5369f2b5-dba1-4b25-a093-7aa79c578975@kernel.org>
Date: Thu, 4 Sep 2025 10:08:50 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted
 s2idle wakeups
To: aprilgrimoire <aprilgrimoire@proton.me>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me>
 <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org>
 <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me>
 <7a3a3a35-27d3-4b46-b297-475deda04656@kernel.org>
 <lyy4riGTLOpvYTPUeUx6krjnYdeE8iYbWRrLOJLOChOKMcys00nhNWJ_JD8V8kkVQk87ktMK8w7BAEosOs3KGipyHlvkvQ0_j6cipUfxYtA=@proton.me>
 <0fb5a890-63f0-412b-8d88-79b40e2c564b@kernel.org>
 <El5fBf0AkhefzH0LWKyMF3vOCNsHYBCEwxtvXD-tJfLGAFCeJ5ZVbgZE6ibf-KfMxtlkTwr3g1-feqSgfcafGzVGjulc-8QggWHHoJlRDNY=@proton.me>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <El5fBf0AkhefzH0LWKyMF3vOCNsHYBCEwxtvXD-tJfLGAFCeJ5ZVbgZE6ibf-KfMxtlkTwr3g1-feqSgfcafGzVGjulc-8QggWHHoJlRDNY=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 2:38 AM, aprilgrimoire wrote:
>> Got it - so it sounds like that IRQ1 quirk is probably enabled as well.
>> Feel free to send a patch for that and CC me (as you already proved it
>> helps remove IRQ1 from spurious wakeups for your system).
>>
>> Make sure you base it off this branch because I know this was touched
>> recently for another system too.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes
> 
> Hi, Mario!
> Sorry for bothering you again.
> 
> I didn't do enough testing, and it turned out that this laptop does need the quirk to stop lid from waking up. The unwanted wakes aren't triggered every time.
> 
> However, this quirk comes with a significant side effect: now I'm completely unable to wake it up with components builtin on the laptop. Maybe usb events can still wake it up though, but I don't have any around me. Shall I still submit a patch for this?

The Linux kernel will break from the s2dile loop when a device asserts 
to wake the system.

If IRQ1 triggers when the keyboard isn't pressed that is absolutely a 
firmware bug.  We can work around it with a quirk entry for 
pmc-quirks.c.  The obvious trade off is that the keyboard can't be used 
as a wake source either, but if you don't disable IRQ1 then another even 
that normally wouldn't wake the system "will wake the system".

For example if you plug in the power adapter the EC will assert the SCI 
and will notify the APU to wake up from hardware sleep.  Normally the 
kernel will process the EC events and go back to sleep.

But if IRQ1 is spuriously active during this time then it will wake the 
system when you plug in the power adapter.  So I think it's the lesser 
evil to add that quirk.  That being said we need to figure out what GPIO 
0 is tied to for your system.  Because maybe the better solution is to 
disable GPIO 0 and just "rely" upon the spurious IRQ1.

With GPIO 0 enabled, can you check when it gets triggered besides the 
lid event?  Try these:

* Suspend on battery / power adapter plug in
* Suspend on AC /  power adapter plug out
* Press power button
* Click touchpad

Ideally GPIO 0 is only used for the lid, but given the ASL notifies the 
PWRB device I don't have high hopes.


