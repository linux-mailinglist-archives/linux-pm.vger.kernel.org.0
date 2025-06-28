Return-Path: <linux-pm+bounces-29723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA357AEC390
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 02:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEE562324
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CE67346F;
	Sat, 28 Jun 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="eKENPQEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76910E4;
	Sat, 28 Jun 2025 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751071227; cv=none; b=dF2F8Cw/SH5mydnzkVLPLigEq391feWUOvwsglI+lzh/nkQdtLxvOHojigOiJtwWJ54oPyJUPFti+CAjrDNBg90sCIP6xtO6zn7kFti2b1u18k3HLzMzoOpFcCH5RPFUa95AtFqoqnVpzbV6s/Zw+P1+V9KCufk969QyUz6SdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751071227; c=relaxed/simple;
	bh=fdYM3PluZ6mEPt71D8xt2bMQ7vOrjUg+fukapeY/SX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNFwhK9bp9pRaHcZKhwYf5d6atU6fPYwUHfCixmXvQoDdhriqqGlpNG4FgPoTYdfc5o8lLOGGaQVDOm46RgytVrmO+Rjw7McpkpB2/7asnE1ahgLAEObXmY9qZ/aAyDR9MggMeY3PVkJRZXaY7CuVwBrTC+LCHsYQsgj7QT2j6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=eKENPQEn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751071218; x=1751676018; i=w_armin@gmx.de;
	bh=fdYM3PluZ6mEPt71D8xt2bMQ7vOrjUg+fukapeY/SX4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eKENPQEnRLGVg5ZGtt1akO6h4I3mcxP8I4EeWCAafBShbmC2NV1BMRlNjvRoCOX/
	 MhrT6HKSjzbzQbb0fVS9ITelFYLi8tLOfyA/+r/R1Ae5fJDg0LU9bE9XNZtgqTRT0
	 Bcm2M9Dntcm4vE2Kl7bbul/idal7VvpuMWMxDLjuR/+f4773ggPBAVclwuAo0Kjbl
	 CFNXaEgRdg3Vr9PRF3GQhCq34eGu0Y6mhFwHk11X9dv8PGgEPHgFwMaXfRR91bS2Y
	 n/DmsBP0tBFyOcxRDv1m2G6fHF0jNlSC6AjQUNMADH0+CLZfil/59H/dvg1PWX8mO
	 m2rx2WJT/hhacraekg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1uZx6s2T7P-001Taf; Sat, 28
 Jun 2025 02:40:17 +0200
Message-ID: <032bba69-7f74-4181-9398-d9d370195bd0@gmx.de>
Date: Sat, 28 Jun 2025 02:40:15 +0200
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
 <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de>
 <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se>
 <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de>
 <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se>
 <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de>
 <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se>
 <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
 <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com>
 <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se>
 <ilIo-AIjpnkWmahXpgmQeK_6mFWl5s7x7jf0qSdGlpHSGMK1KJDdFjKLQ3t--U-cEUKtpx7s49njQx1I_nU100aE_ca4frY50L4miN8LCks=@benis.se>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <ilIo-AIjpnkWmahXpgmQeK_6mFWl5s7x7jf0qSdGlpHSGMK1KJDdFjKLQ3t--U-cEUKtpx7s49njQx1I_nU100aE_ca4frY50L4miN8LCks=@benis.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bwog6pcaG04btMvZ+5d4RrO5V7MH1L4VXLSRrTA6of5SSaj2m3p
 tbgCHzwn2MOa1agwddeavsCYQXTsxma9MrPi7C/0HDwxScNgi6SeeFUgNmmTcyE/ybwT2Wk
 gdxDQ1HBW5bIkXFkHYHE/oWqyaB9VOvX61Dheu5nKIG0GWbBcRrUHksZCO39MYZdKRGaUMO
 MwDQFoa8UFb02j+NZNSUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5TM9nvaMoos=;6VgOYKOqwuHTvjcdxpJLvlzz+K8
 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

Am 27.06.25 um 23:56 schrieb Benjamin Hasselgren-Hall=C3=A9n:

> One more thing: I noticed this during boot (before entering password for=
 disk encryption)
> https://drive.benis.se/s/5wMkEMKs6SELQzt
>
> Thermal trip point bug and other stuff, might be something?

Yes, it seems the trip code AML code try to access an array called CUZO th=
at is only initialize
inside a ACPI control method called _WAK. Since _WAK is only called when t=
he system wakes from
a sleep state CUZO remains initialized and thus causes this error.

Can you check if a BIOS update is available for your device?

Thanks,
Armin Wolf

>
> Best regards,
> Benjamin Hasselgren-Hall=C3=A9n
>
>
> On Friday, 27 June 2025 at 22:49, Benjamin Hasselgren-Hall=C3=A9n <benja=
min@benis.se> wrote:
>
>> Hi Kurt,
>>
>> I do not experience the same error messages as in the bug report - no e=
rror message at all. It respons to changing power profile without any erro=
rs.
>> I also tried 6.12 but same behaviour as 6.15.3 (just getting some gpu g=
litches - problably because of Lunar Lake).
>>
>> I am trying to understand how power profiles work - I guess on a high l=
evel it's controlled by uefi and the profile is set by the OS? Or is it mo=
re complicated than that?
>>
>>
>>
>> Best regards,
>> Benjamin Hasselgren-Hall=C3=A9n
>>
>>
>>
>>
>> On Friday, 27 June 2025 at 21:15, Kurt Borja kuurtb@gmail.com wrote:
>>
>>> Hi all,
>>>
>>> On Fri Jun 27, 2025 at 2:10 PM -03, Armin Wolf wrote:
>>>
>>>> Am 26.06.25 um 15:20 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>>>>
>>>>> Hi again,
>>>>>
>>>>> dmesg: https://drive.benis.se/s/2crz7zPzkrzaqXN
>>>> The following message intrigues me:
>>>>
>>>> platform_profile: Failed to get profile for handler hp-wmi
>>> This might be a regression.
>>>
>>> This was reported a couple months ago and I completely forgot until I
>>> saw this thread. See [1].
>>>
>>> @Benjamin: Can you please check if your power profiles work on Linux
>>> v6.12 (LTS)?
>>>
>>> Also try:
>>>
>>> $ cat /sys/firmware/acpi/platform_profile
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220008
>>>
>>> --
>>> ~ Kurt

