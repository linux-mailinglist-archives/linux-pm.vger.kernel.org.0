Return-Path: <linux-pm+bounces-29841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EC2AEDD48
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 14:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DF87AACDB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC08928B7C1;
	Mon, 30 Jun 2025 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CYOzSFSw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755C28B516;
	Mon, 30 Jun 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287184; cv=none; b=c3vMW9jB+ls2o3XWxzp5W4NSyqCjxoyL1q+hx4twKYMIK37KVyq9JSO8r+a7JU0JWO79NB0HMLxsszCP1qP4/EkQ0ANt3Dng10TqvuvXZgMAr9EixnGbiblIUvxW09XKt97gNew6E+6TG3z+NlSpjHi+nxbBDxxE4zn0Rf5OyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287184; c=relaxed/simple;
	bh=xc802XULWRFNqf6QiiU4M3/aRIl29yCPgfbt7nZzElk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTzI2roRnXvEVLLPCNjpb+Ta1Tm3VklkPc3jgVx3dRcFVRsoQoohV3NTVvqF4GdMLvMSYNEc7iUQFD61CnI045LU5WTyaHwfy7aKvIj3A10fBk2hpW8v8LtJOlAMVBXmIsV0pOKa/NLKyIinN/eiegXt9JeRCSHx/j4IuGPL/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CYOzSFSw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751287170; x=1751891970; i=w_armin@gmx.de;
	bh=xc802XULWRFNqf6QiiU4M3/aRIl29yCPgfbt7nZzElk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CYOzSFSwYfFsMcS7HJuEy1gilhOglodT8YsxycS1+nUH7D9fzb0greMOaGE4Nkry
	 faWh4ADjmJDOfGiA/0n9MUHTfjNu9sf0Mcb6aZRuxMMaT/12YqAv2EvVD7eOagR1i
	 Y5QzG1LUdmXWF4IeuGsWwWO+zX76DGq2pqZ5VyhftYuNu6mki91pI9SqHYE7XHMrP
	 rHksvDMr7QrIONXexiPOLZbpsACD2Vi9sd0uTjB8ctfURj97r96FSzWFEHpnYb3ko
	 bHmMD2aSkpQPaTY1sL8ZBlpReOd8nZY1vtZzUJHhVbXIMTh/qltnv9tvzR9gC6Lhl
	 k3eqznm1u6XCt1KO8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1uCYIM0crA-00MYgs; Mon, 30
 Jun 2025 14:39:30 +0200
Message-ID: <bf9475d3-9131-4d4f-af05-411fdd4f032f@gmx.de>
Date: Mon, 30 Jun 2025 14:39:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
To: =?UTF-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>,
 Kurt Borja <kuurtb@gmail.com>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se>
 <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de>
 <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se>
 <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de>
 <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se>
 <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
 <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com>
 <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se>
 <DAXR1M1W2XFZ.3H2AWUO3N1X5E@gmail.com>
 <oZxsMVf4IphclLjVLbrpp1rHYXlgWYV7BXDzgP40QKiHSOUtVDtDwP_s2uKFel3aLTZyIh-KepV7MjdSN_MkRWpn1_v55BEs0MEVyhKK0fU=@benis.se>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <oZxsMVf4IphclLjVLbrpp1rHYXlgWYV7BXDzgP40QKiHSOUtVDtDwP_s2uKFel3aLTZyIh-KepV7MjdSN_MkRWpn1_v55BEs0MEVyhKK0fU=@benis.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RFcmezSC1rvT6nC29URI1y4svI5rRrBY5pzbjBX0jZQZowCGzKY
 HYNZGa9o35J9Etcxnik/vH+uyBBCTVtOvwHGSVz+iBpA/NGrwUWaLlyv2+3UP8AHv8S7jgP
 sC5l2o9LFl4SggpfY4p+lQHv1+PSb3WOj160wFAvfME3owUuq2LtcZ7vS2eSTOzfd3m91WE
 ko7wnDwiHSM+0erb0I98A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FISNo7SQryA=;CSTAc6d/c8epDoj1AL8An1v/d37
 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

Am 30.06.25 um 14:32 schrieb Benjamin Hasselgren-Hall=C3=A9n:

>
>
>
> Best regards,
> Benjamin Hasselgren-Hall=C3=A9n
>
>
> On Saturday, 28 June 2025 at 02:45, Kurt Borja <kuurtb@gmail.com> wrote:
>
>> On Fri Jun 27, 2025 at 5:49 PM -03, Benjamin Hasselgren-Hall=C3=A9n wro=
te:
>>
>>> Hi Kurt,
>>>
>>> I do not experience the same error messages as in the bug report - no =
error message at all. It respons to changing power profile without any err=
ors.
>>> I also tried 6.12 but same behaviour as 6.15.3 (just getting some gpu =
glitches - problably because of Lunar Lake).
>>
>> Can you paste the output of `cat /sys/firmware/acpi/platform_profile` o=
n
>> Linux v6.12?
> cat /sys/firmware/acpi/platform_profile_choices
> cool quiet balanced performance
>
> cat /sys/firmware/acpi/platform_profile
> cat: /sys/firmware/acpi/platform_profile: Invalid argument

Good, it seems that the firmware returns additional data when querying the=
 current platform profile.
As the driver does not mask-out this data, he cannot determine what kind o=
f platform profile is currently
selected and thus returns -EINVAL.+

I can provide you with an experimental patch, could you test that?

Thanks,
Armin Wolf

>>> I am trying to understand how power profiles work - I guess on a high =
level it's controlled by uefi and the profile is set by the OS? Or is it m=
ore complicated than that?
>>
>> Yes, as quick overview. Power profiles are usually a capability of
>> individual devices. Drivers of these devices expose this profiles to
>> userspace through some predefined interfaces. Then your DE enviroment
>> exposes this to you.
>>
>> KDE and Gnome use power-profiles-daemon. This program controlls mainly
>> two kernel interfaces: CPUFreq and platform-profile (there may be more)=
.
>>
>> You can read about CPUFreq here [1], although I don't know much about
>> it. The platform-profile interface may be used by any platform driver -
>> in your case this is the hp-wmi driver.
>>
>> This driver exposes some firmware defined profiles to sysfs trough the
>> following paths.
>>
>> /sys/firmware/acpi/
>> /sys/class/platform-profile/
>>
>> You won't find the latter in the Linux LTS version though. You will fin=
d
>> documentation on these paths here [2] and [3] respectively.
>>
>> PD: Please, avoid top-posting in kernel mailing lists, interleaved styl=
e
>> is very much preferred [4].
>>
>>
>> [1] https://docs.kernel.org/admin-guide/pm/cpufreq.html
>> [2] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-file=
-testing-sysfs-platform-profile
>> [3] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-file=
-testing-sysfs-class-platform-profile
>> [4] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
>>
>> --
>> ~ Kurt

