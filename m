Return-Path: <linux-pm+bounces-36830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B800C0A1AE
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 02:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92D7C4E42B4
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 01:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0407F1DF982;
	Sun, 26 Oct 2025 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqhu0AF+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFA1A9F87;
	Sun, 26 Oct 2025 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761442284; cv=none; b=fS1yLQmKqdJF3/FeyCvUum0txXdhokOrEZn3b1bNX8aex+w9gcqAaGI3T8AlUGJ9LQJDYZIsK4VZHDlTPPQdv0z52BKh1At8i6TCwvAc1S0J2RiH4VS1EW+rKgse3mH4LAnhzhTatgLCxTzc2j3VzAOw5cgHsDZf4TIiB9EoXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761442284; c=relaxed/simple;
	bh=idYAbqf0v2257DIEdVXDo9dzrQq/Thb+gPb8TBKEY/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbGUoTgOdYbwylamHMvbjwmm9x/X01Z6ToDD3M7hIKHR/a+eyRhKR84/o22omdJ4xpvUBsdNurZgPWhIGYgCJgq/zRdsHuHeeWQJBsQu2AfnCOEFV+psUMCSOevbAMj1s2IQGbsJ4D0NeaICIF7oOjuxQZ9ZU6FYCNj+KQFYdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqhu0AF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D0EC4CEF5;
	Sun, 26 Oct 2025 01:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761442284;
	bh=idYAbqf0v2257DIEdVXDo9dzrQq/Thb+gPb8TBKEY/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cqhu0AF+RTOrwaRE5jzqOBVM5efOiAY4QXweVgRe371O9PTdeyRnjsa4Dg5OfiROM
	 HLug04f8Ze9T+MWlb/Z0vMkFyQfGjemR5tt6zZZYLoLj9WxmZpN4ynmlcsvQshro7L
	 07jTS6Di4Nbhy+P1NyEXBQNw/u7oTLYPBvLPCld7lwGRoIJi+qEEwIw1bygq5qvbCa
	 t6SAJlkgSZxM45f16wTXwW+4I2jD6l8lkqpJYFHhC4/wt23qLqHQZP4Bi2RlR6Q7Dy
	 zVF11NAuac9bVzvalTccEzK9dnOUZuOtfpvAvQQ2LbGdXFrY49ZNIavbxQYBdEV9PH
	 FLrpMS7+7zCcw==
Message-ID: <a2563b83-e5d7-4d02-a317-54d51e718d32@kernel.org>
Date: Sat, 25 Oct 2025 20:31:19 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Hibernation: WARNING at
 kernel/power/main.c:48 pm_restrict_gfp_mask (was: "[PATCH v1] PM: hibernate:
 Restrict GFP mask in hibernation_snapshot()")
To: Askar Safin <safinaskar@gmail.com>, rafael@kernel.org
Cc: gregkh@linuxfoundation.org, guoqing.zhang@amd.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 mario.limonciello@amd.com, todd.e.brandt@linux.intel.com,
 torvalds@linuxfoundation.org, regressions <regressions@lists.linux.dev>
References: <5924662.DvuYhMxLoT@rafael.j.wysocki>
 <20251025050812.421905-1-safinaskar@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251025050812.421905-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/25/25 12:08 AM, Askar Safin wrote:
> "Rafael J. Wysocki" <rafael@kernel.org>:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Commit 12ffc3b1513e ("PM: Restrict swap use to later in the suspend
>> sequence") incorrectly removed a pm_restrict_gfp_mask() call from
>> hibernation_snapshot(), so memory allocations involving swap are not
>> prevented from being carried out in this code path any more which may
>> lead to serious breakage.
> 
> #regzbot introduced: 449c9c02537a146ac97ef962327a221e21c9cab3
> 
> This commit introduced regression: now I see WARNING every time when
> I hibernate. The bug reproduces both on real hardware and in Qemu.
> 
> Here is script I used to reproduce this bug in Qemu:
> https://zerobin.net/?aadae7117a208c0a#Xh8aI5+u3pyk+vKwET7j+yXolLeoSLe/AedcvnNeCLs=
> 
> Here is resulting log (dmesg) on current master (43e9ad0c55a3):
> https://zerobin.net/?471d17d0632e7f85#uYne0yUu+rP4KnDbOFFqtCrcDIi6UpQz2uIQw85lcdQ=
> 
> Here is the most interesting part:
> 
> [    1.735001] PM: Image saving progress:  90%
> [    1.746611] PM: Image saving progress: 100%
> [    1.747208] PM: Image saving done
> [    1.747403] PM: hibernation: Wrote 30164 kbytes in 0.13 seconds (232.03 MB/s)
> [    1.747837] PM: Image size after compression: 8908 kbytes
> [    1.748190] PM: S|
> [    1.750351] ------------[ cut here ]------------
> [    1.750627] WARNING: CPU: 0 PID: 1 at kernel/power/main.c:48 pm_restrict_gfp_mask+0x3b/0x40
> 
> On real hardware exactly same thing happens (i. e. WARNING at kernel/power/main.c:48 pm_restrict_gfp_mask).
> 

Thanks for the report, and especially for the simple reproducer!

This is pretty similar to the problem we had with hybrid sleep. [1]

Link: https://git.kernel.org/torvalds/c/469d80a3712c6 [1]

I believe this should help:

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 14e85ff23551..e15907f28c4c 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -721,6 +721,7 @@ static void power_down(void)
                 kernel_restart(NULL);
                 break;
         case HIBERNATION_PLATFORM:
+               pm_restore_gfp_mask();
                 error = hibernation_platform_enter();
                 if (error == -EAGAIN || error == -EBUSY) {
                         events_check_enabled = false;

