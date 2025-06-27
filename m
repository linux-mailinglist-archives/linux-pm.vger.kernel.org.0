Return-Path: <linux-pm+bounces-29686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B24AEBE41
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CCD3A5CD1
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7F2EA72E;
	Fri, 27 Jun 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="j8pDk5Rr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450022EA72C;
	Fri, 27 Jun 2025 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751044253; cv=none; b=f7Ay0cWqrtKUTXFV5qxEmIhN/44k1Yk8AdKmAWipuyAX53wMOnFZNP9mCnvsfVVF+XUv3oOucvnAfkBxX0tDkcGVeK4/1UQoz+VOAdDjvdAm8vrzlOrmEetNM9it0qbJjmKHklmzjKHaQqSsVAib5+gUGFnACXl5H82jQ1n3Sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751044253; c=relaxed/simple;
	bh=5DG+Hn29ojlyC/wYhZQZlUA3ryj50/eJZjkChwWgE+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk7pSc2z7hEc90uDpaQJdNdgfKpWVDP5pQEqTca8XGibEjjaJZOoNYrmimKreg7mOI6KSdjoFGuKSdteFno8r8ju4RbK/WhRvjvTwz5ymwRD8v39RImM4RBYM6K2qQ6gda+YqU7Eil9M+wn3QFh6he4xgR7WrxP6g1/hG4WVfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=j8pDk5Rr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751044247; x=1751649047; i=w_armin@gmx.de;
	bh=5v7v62qFvk3Pr4zoImYf+hTEY6oTg+7MIzk+eI4AkKI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j8pDk5RrlPba29JGNtHhUYo4wVYeDNjvaDequqAWxSVYLHs9aaWQ5NPYF0sQT5a1
	 h+RbzNFEaG2cS0BRTDzrGPEpE8WQjdNC4RuB3RNVtMIQA2VzwsNChyp7wou7gCZ23
	 Ec/789VmG4UnUMCHRp9OYKhNBu3yMGHV3+j7uBAxBXs9fOG2rqsNJLXq+tL/BFcqr
	 Ce+yEqSlturIQmdlN6KWijU6+dot+8ar2KpiiBdiI6m96BcNRbsG4uFGmwoPZt4wv
	 k1F9nP86SZPoxmSkT+j0wZEzI1PsIg4pa8r7X5oHdFO2MVablqxbss+ePaJLeqxKF
	 jv94sQK8CUQep+m1rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1upMsj0F78-00ydV3; Fri, 27
 Jun 2025 19:10:47 +0200
Message-ID: <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
Date: Fri, 27 Jun 2025 19:10:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
To: =?UTF-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se>
 <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de>
 <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se>
 <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de>
 <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se>
 <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de>
 <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V9MiEsApZmt03gSa02gggx+R905F+PfCb0s3UxEjH5ipPggMzj+
 hpFyQs2AamXM5NhdRRtlt9wLFRHM6wnxNzbEel0fq5jdJePJmVnAcDemdYQEr7QaI4OVLuD
 fs2LHkhEV1WLKkhzj7WdbCWNWQgrr8VVvPkHw5JCnB0bhOrRNE7JO7f7neEbaDiftNo8prS
 8/pqR5yK2IhJ79o6C0GCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1nCgoBfnjgs=;PQrwQuF8XFXzedwaV31OUX0eMup
 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

Am 26.06.25 um 15:20 schrieb Benjamin Hasselgren-Hall=C3=A9n:

> Hi again,
>
> dmesg: https://drive.benis.se/s/2crz7zPzkrzaqXN

The following message intrigues me:

	platform_profile: Failed to get profile for handler hp-wmi

Can you tell me the exact error message that is returned when reading the =
platform profile over sysfs?

> So I tested thermald again. So here are some results.
>
> Before:
> Running Valheim the power draw is 35w and the fps is 41.
>
> After I have installed thermald:
> Running Valheim the power draw is 44w and the fps is 46
>
> So it's working, but I also noticed that it doesn't matter if I change t=
he power profile. Same performance and power draw. So something is still w=
eird.

The ACPI code seems to suggest that your device support 7 profiles, while =
the hp-wmi driver only supports 4. Additionally the drivers fails
to properly mask out the platform profile value returned by the firmware, =
so that could be the reason why it is not working on your device.

Can you test kernel patches?

> Also the bug with the fun still running while the laptop is suspended is=
 an issue.

I CCed the people from the thermal subsystem, maybe they know if this is e=
xpected behavior or a bug inside the int340x_thermal driver.

Thanks,
Armin Wolf

>
> Thank you very much for your guidance Armin!
>
>
>
>
> Best regards,
> Benjamin Hasselgren-Hall=C3=A9n
>
>
> On Wednesday, 25 June 2025 at 23:43, Armin Wolf <W_Armin@gmx.de> wrote:
>
>> Am 25.06.25 um 23:22 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>>
>>> The laptop do complain about not being able to load hp-wmi during boot=
. Same on Fedora 42 as on Debian 13 (with kernel 6.15).
>>
>> Can you share the output of dmesg?
>>
>>> I did install thermald and that might have increased the power budget =
(which is good) - but introduced some bug that keeps the fans on even whil=
e suspended.
>>
>> Please elaborate.
>>
>> Thanks,
>> Armin Wolf
>>
>>> Best regards,
>>> Benjamin Hasselgren-Hall=C3=A9n
>>>
>>> On Wednesday, 25 June 2025 at 15:44, Armin Wolf W_Armin@gmx.de wrote:
>>>
>>>> Am 25.06.25 um 10:06 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>>>>
>>>>> Hi,
>>>>>
>>>>> The acpidump is here: https://drive.benis.se/s/pcKLAL7i8zncX8q
>>>>>
>>>>> Best regards,
>>>>> Benjamin Hasselgren-Hall=C3=A9n
>>>> The hp-wmi driver should be able to control the platform profile on y=
our device. Does this
>>>> driver load and register a platform profile handler?
>>>>
>>>> Additionally you might need to install and setup the intel thermal da=
emon for the platform
>>>> profile settings to work.
>>>>
>>>> Thanks,
>>>> Armin Wolf
>>>>
>>>>> On Monday, 23 June 2025 at 20:52, Armin Wolf W_Armin@gmx.de wrote:
>>>>>
>>>>>> Am 23.06.25 um 15:52 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>>>>>>
>>>>>>> Hi dear Linux friends,
>>>>>>>
>>>>>>> This is very much a long shot and I understand if no one got any t=
ime or motivation for this.However, I am trying to understand how HP Omnib=
ook Ultra Flip (a laptop with Lunar Lake platform) working with power prof=
iles. The reason is that it seems to be very limited while running Linux (=
to 30 watts to be exact, no matter the power profile, this is for the whol=
e laptop, to compare with something the Omnibook Ultra 14 with AMD Strix d=
raws up to over 70 watts, sure more power hungry platform but still). Also=
 the gpu performance is not as it should be.
>>>>>>> So if anyone got the time or so - let me know where to start diggi=
ng!
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Benjamin Hasselgren-Hall=C3=A9n
>>>>>>> Can you share the output of "acpidump"?
>>>>>>> Thanks,
>>>>>>> Armin Wolf

