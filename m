Return-Path: <linux-pm+bounces-2802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65183DAE8
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 14:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37981F24A25
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71F1B59E;
	Fri, 26 Jan 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOYTEzaG"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E31B81A
	for <linux-pm@vger.kernel.org>; Fri, 26 Jan 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275986; cv=none; b=JNziLqfvek8BYZMV1f3ZZ0FZQnvnUTKJg4gs4jMhb7E67qfYJc824VYpyQlXivvn4auqa+Mw86C3QnbNTgIcPNQADgwq0TMa0MOATbXLTUxkIwN/VmcixV8x/FyuNtBjjohIZA8oYmHdzfxULDSkqbuOOwu10LucvxqEcWG0bnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275986; c=relaxed/simple;
	bh=t75+ApVE4O2pChN2R4h66dZ7fB5ab5Ao7eh8CU5ennw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QE6/j+ILJxNqmpiibaCyNVGTb16OMwGFXjC8hx1eVJ8tcv1QzXT7J/pum1u7XFm6La1tIURIhGYH3tG7AbGQQLqrTGkyyZ9Lp0l6fK33DDa2Jmmm+Gh+B146Gg5ukGfd6svxUY4FnX44uNNtAJvFZ503UPZq+AVnJVNvktvqoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOYTEzaG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706275983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3CYoF7To3W2OvR7Q0XItMhTSU3L3ntABi2tsSEqr9s=;
	b=eOYTEzaGeqDyJTQ0LBWUYDAPoRYW8Ph+FqihlfnJdWpXwZIduNMfWEnFEJRyM+rYeWPq5X
	4INJp2RtrBgjIICjqQ3DP9vz/IBCOnyg7IcYq9GIDev0nZnQxiWOGSJopaDdDrMY7dF5XZ
	8sGi1/O6ksStmKMIS1OF0n7/ddU12ag=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-rtM-BAbsOE2hflwUthhmeA-1; Fri, 26 Jan 2024 08:33:02 -0500
X-MC-Unique: rtM-BAbsOE2hflwUthhmeA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2c653c7b35so34464166b.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jan 2024 05:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706275981; x=1706880781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3CYoF7To3W2OvR7Q0XItMhTSU3L3ntABi2tsSEqr9s=;
        b=EbRQMaIrrsL8gnjZDjZZhs3ZveU5cZh/yr3CnSoN0BLDrjTIfsSGcOQMAAuo2QZjZA
         Vnxl3967+NHVA3m5Zqdi5mvsLe7lFmgRu+wJ5oSEhO4UYuWEhLYGu6rixf/5kfzDfgFW
         U4Fo2xCTktIniYLssRtY7t7zsWcn7ibHtis+seCNtlAVGdm3E/SQA38uC7hAZ2WF6WSu
         37zhxLzd5E5kciFjHTuucmo5oGQe2QCHj9q6T9MbPC7l0o2EhfAKbqiLc9iOm39mlZNG
         g7/wozmPdf49eW7gzXJ/UyoAoEnk2PsIDYYfyEeY0wqvA4NJuYaYN+sKrGas2HXD1IHx
         sLqQ==
X-Gm-Message-State: AOJu0Yxb41T+SxtNnYz1t87JM7oQv1asST3aG4tf/MqLb/EciPFJwJ0i
	DwI6H6XgqdFyCKcBAgP1Tdz4rEvmCq0tb1EpVmd6eVpfaCtinFsayjEQY4GFmoo5PTuiZRhmfe2
	5gPAQ4GmCwXbz99V/lrX5ktFlMulHjs8UQ3+YvSjoR4oAM9VSBasFkmo/
X-Received: by 2002:a17:906:1949:b0:a33:604d:2a42 with SMTP id b9-20020a170906194900b00a33604d2a42mr527113eje.25.1706275981143;
        Fri, 26 Jan 2024 05:33:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhKBLsSu7OcWJcv0AZ4I04EUiwRYyjkq++HEtrw6QvawvzQb9UNe2gW7BIw4ofNgZSMFoQWQ==
X-Received: by 2002:a17:906:1949:b0:a33:604d:2a42 with SMTP id b9-20020a170906194900b00a33604d2a42mr527109eje.25.1706275980797;
        Fri, 26 Jan 2024 05:33:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id un3-20020a170907cb8300b00a3516240ab3sm118189ejc.215.2024.01.26.05.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 05:33:00 -0800 (PST)
Message-ID: <5f70a174-7f18-43c0-b3a3-b72544a2631b@redhat.com>
Date: Fri, 26 Jan 2024 14:32:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PS/2 keyboard of laptop Dell XPS 13 9360 goes missing after S3
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
 <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
 <0b30c88a-6f0c-447f-a08e-29a2a0256c1b@molgen.mpg.de>
 <dde1bdfe-7877-41bd-b233-03bcdba0e2de@redhat.com>
 <f07333d2-ebb0-4531-a396-8fb3d1daa2c3@molgen.mpg.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f07333d2-ebb0-4531-a396-8fb3d1daa2c3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paul,

On 1/26/24 08:03, Paul Menzel wrote:
> Dear Hans,
> 
> 
> Thank you for your reply, and sorry for the delay on my side. I needed to set up an environment to easily build the Linux kernel.

No problem thank you for testing this.

> Am 22.01.24 um 14:43 schrieb Hans de Goede:
> 
>> On 1/21/24 15:26, Paul Menzel wrote:
> 
> […]
> 
>>> Am 20.01.24 um 21:26 schrieb Hans de Goede:
>>>
>>>> On 1/18/24 13:57, Paul Menzel wrote:
>>>>> #regzbot introduced v6.6.11..v6.7
>>>
>>>>> There seems to be a regression in Linux 6.7 on the Dell XPS 13 9360 (Intel i7-7500U).
>>>>>
>>>>>       [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>>>>
>>>>> The PS/2 keyboard goes missing after S3 resume¹. The problem does not happen with Linux 6.6.11.
>>>>
>>>> Thank you for reporting this.
>>>>
>>>> Can you try adding "i8042.dumbkbd=1" to your kernel commandline?
>>>>
>>>> This should at least lead to the device not disappearing from
>>>>
>>>> "sudo libinput list-devices"
>>>>
>>>> The next question is if the keyboard will still actually
>>>> work after suspend/resume with "i8042.dumbkbd=1". If it
>>>> stays in the list, but no longer works then there is
>>>> a problem with the i8042 controller; or interrupt
>>>> delivery to the i8042 controller.
>>>>
>>>> If "i8042.dumbkbd=1" somehow fully fixes things, then I guess
>>>> my atkbd driver fix for other laptop keyboards is somehow
>>>> causing issues for yours.
>>>
>>> Just a quick feedback, that booting with `i8042.dumbkbd=1` seems to fix the issue.
>>>
>>>> If "i8042.dumbkbd=1" fully fixes things, can you try building
>>>> your own 6.7.0 kernel with commit 936e4d49ecbc:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=936e4d49ecbc8c404790504386e1422b599dec39
>>>>
>>>> reverted?
>>>
>>> I am going to try that as soon as possible.
>>
>> Assuming this was not some one time glitch with 6.7.0,
>> I have prepared a patch hopefully fixing this (1) as well
>> as a follow up fix to address another potential issue which
>> I have noticed.
> 
> Unfortunately, it wasn’t just a glitch.
> 
>> Can you please give a 6.7.0 (2) kernel with the 2 attached
>> patches added a try ?
>>
>> I know building kernels can be a bit of work / takes time,
>> sorry. If you are short on time I would prefer testing these 2
>> patches and see if they fix things over trying a plain revert.
> 
> Applying both patches on v6.7.1
> 
>     $ git log --oneline -3
>     053fa44c0de1 (HEAD -> v6.7.1) Input: atkbd - Do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID
>     0e0fa0113c7a Input: atkbd - Skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID
>     a91fdae50a6d (tag: v6.7.1, stable/linux-6.7.y, origin/linux-6.7.y) Linux 6.7.1
> 
> I am unable to reproduce the problem in eight ACPI S3 suspend/resume cycles. The DMAR errors [3] are also gone:

Thanks.

So thinking more about this I think the DMAR errors are actually the real cause of the issue here, specifically if we replace: f0 with 00 (I guess DMAR uses the high bits for its own purposes) in

`[INTR-REMAP] Request device [f0:1f.0] fault index 0x0`

then the device ID is 00:1f.0 which is the ISA bridge and [INTR-REMAP] errors are known to disable interrupts. The PS/2 controller (which sits behind the ISA bridge) interrupt getting disabled would explain the suspend/resume keyboard issue better then the atkbd.c changes I have been focusing on.

So then the question becomes why does the 6.7.1 kernel not show the DMAR errors. I don't see anything between 6.7.0 and 6.7.1 which explains this. But maybe your local build is using a different configuration which explains this.

Can you try your local 6.7.1 build without my 2 patches? The quickest way to do that would be to run: "git reset --hard HEAD~2" and then re-run the make commandos, this will re-use your previous build so it should be pretty quick.

If things still work after that then the problem is not with the atkbd code.

Regards,

Hans





