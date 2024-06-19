Return-Path: <linux-pm+bounces-9638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF8290F9AC
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 01:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC146B21CD3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 23:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C423915B143;
	Wed, 19 Jun 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mYOmcT9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDD15B120;
	Wed, 19 Jun 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718838851; cv=none; b=lmJxZU6uIQ69xmT7TdJWgADMWY2BWNACfhREtEV2mFWa0dFR4XNcspodR+4wNiw+3AFJrukW1yoR0SbWW4DGm99kvb5xAOangutMlnoBNFsOSKYG38q0/6MIZOvOGuaGjgRYo59vJjDCGb3Xa+kmvFsxcNOwuVjfPgfAVfWzK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718838851; c=relaxed/simple;
	bh=lqD73KbcTA9rE0QqwLDAzACeJNJS6kpCN78MphVDmw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfNQqTd++rDYeO0wrlePrFharUcP8vmzRQuvBgHv5ThTRdTTGJpXfK98fNVzKc1LmYYXNvJnZNVvbJUrwtyM2kgc5S6TymbWsxvoUZkRt2FZSu7C7F8IjQMeQ2/leqKm4CXV2z26rr6Qvke92YlR6ERG5lWWRWQwcA7sxyehcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mYOmcT9T; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718838842; x=1719443642; i=w_armin@gmx.de;
	bh=SMLL+EFH86lh6xH5HAHP6uEFcblvyJ4KgSaVly4ZCLY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mYOmcT9TreIk0JMHeM5TXWWPeDAz8U+QqQ8wvc7hK2jS2J5yXxAQvh3mI01cKF+w
	 M06cLmhzmy/cygbeF+IcPOof1xOhhAhGco+mjdGVr7s+g6RnqBwKC1QpIxYqBRCSW
	 B5v/EosDUxSedFBXMq+tCWRGO371zpE9kXDzieXANKPF2sytCD+O6YDTkH2szgcoV
	 E9DxzWFc1HUfndEYH7ZnDKzxHf+N0u+qrOL+rtK5AfQ0TxMLtY0ylR/m3P1agCB5p
	 JgcDlDZGgJVkKBPO5L6MTICEYnDqzJHYWwbzdH60ff1zC5GWaaJyQy4r7ZCh0QB4G
	 9G/FFPAXl76CpCvSYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9g4-1sA9va0FOm-00FGTn; Thu, 20
 Jun 2024 01:14:02 +0200
Message-ID: <2b7d9f31-a24b-4dac-b57e-8cca165a79b1@gmx.de>
Date: Thu, 20 Jun 2024 01:14:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/5] power: supply: core: implement extension API
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
 <20240608-power-supply-extensions-v2-3-2dcd35b012ad@weissschuh.net>
 <76dff03c-08f6-4edc-af57-c0b8dbf55293@gmx.de>
 <3491c641-bee2-4100-8eb6-8e90d63330b0@t-8ch.de>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3491c641-bee2-4100-8eb6-8e90d63330b0@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RDSSts2+cwtXXQRUmCJFPeJ2G9Cco0JpFX0u3x2iRslb3YTKmzn
 oZXfFfwzPRaeVsUYWJf+yV+b926FKrBFVjCIwQpacAyOdy+O2V68Q2jRJexIQmGc7OAf9nM
 fxYKA/d6DbET4AeMSErKZVPWG17vcI/TpTX87cKsaEBuHhYoqQ8njB6JtyEZno+sLHAPOks
 neZK3VrbNJhVhsEKG3bSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NWSbAzhsFLU=;Li6LgmfJhFWaWe6ii7NbCAgR3Cy
 iAkafZD1M3KH2Dloho+eptJFmt7+10wPfg8gu+ErOF/tOszPFz0JUcMKYgEAJkWj3dK14hHNf
 j19nBw5t6fmHtf/zRElG7Gj0dlkeRDeMfbrvWrIP+ys+KU57WG/fhCQDvJ6xzG9jGfbDXUf0L
 vNOqfKGl7EOZfT9wLxnfzsOUhK4+daePtC+EEMmglzKlPB0PNlWAVNDJX8ElC3YYTnl+MXw++
 ES+IUlDa75WLiLdGbIENNIqY7Y3jSIECf84lvpPpE7bl6i4UK3ZLCkUYS4O52OETfXbcWiggK
 ZyOIe0979v3Ln/n49qKi1X3cc/xrveavrV7+WDWfVTsokP35xBR4ctDFpIF+aDnUphrlShU+4
 rr4Mo7yknQ/qfJDNp45rlGrMycpSkA/bstFVS5aSj4FTlDCQaPDTOHuTvqX8q9W8mhX67GbrO
 j7IVL0HixahZR5GwMvNiLVFqiF5NV1zi8N0vLD10B3jpYptpfEbnEJASxyCCTevhSBgWurTn6
 4W8zgNf9u1PrjdfbXq+6jYkjMiYO9yN0fyxF11FeDUIZF7l3IxRe2X08cHDZbZtvcYDd/kLXu
 NUOqKCYa9zLjoVsP2jl4oH5STGcDsGOrAduhFthEay2skEhGc3emPMAUm6kaEfJ1EsTiJbe14
 fRlNlsFHj3scGOVDfeWR+JDSdZTi4Qhuzk7e2lLb4X4e9a645S8o1+dTPb/bYx+Yi1wYm8bYN
 pYQzk0lRYS1GOPV3LVH0k5xZw5OtZgHrAG8PVNOSrfheZzHhnBacq2kHzZXH1RB1JmaIlnKBa
 luxm+UtkOkDgpNNXWzl67MJHH4ECUD98SoIRW8MBkaLM0=

Am 14.06.24 um 09:02 schrieb Thomas Wei=C3=9Fschuh:

> Hi!
>
> On 2024-06-14 01:11:29+0000, Armin Wolf wrote:
>> Am 08.06.24 um 21:19 schrieb Thomas Wei=C3=9Fschuh:
>>
>>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>>> ---
>>>    drivers/power/supply/power_supply.h       |  13 ++-
>>>    drivers/power/supply/power_supply_core.c  | 128 +++++++++++++++++++=
+++++++++--
>>>    drivers/power/supply/power_supply_hwmon.c |   2 +-
>>>    drivers/power/supply/power_supply_sysfs.c |  37 ++++++++-
>>>    include/linux/power_supply.h              |  26 ++++++
>>>    5 files changed, 192 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/suppl=
y/power_supply.h
>>> index 622be1f0a180..686b66161900 100644
>>> --- a/drivers/power/supply/power_supply.h
>>> +++ b/drivers/power/supply/power_supply.h
>>> @@ -13,8 +13,17 @@ struct device;
>>>    struct device_type;
>>>    struct power_supply;
>>>
>>> -extern bool power_supply_has_property(const struct power_supply_desc =
*psy_desc,
>>> -				      enum power_supply_property psp);
>>> +struct psy_ext_registration {
>>> +	struct list_head list_head;
>>> +	const struct power_supply_ext *ext;
>>> +};
>>> +
>>> +#define psy_for_each_extension(psy, pos) list_for_each_entry(pos, &(p=
sy)->extensions, list_head)
>> sorry for taking so long to respond, the patch looks good to me except =
one single thing:
>>
>> when removing a power supply extension, the driver has to be sure that =
no one is still using
>> the removed extension. So you might want to add some sort of locking wh=
en using a power supply
>> extension.
> That was part of the v1 of the series [0].
> I dropped it in v2 to focus on the external API and semantics first.
> IMO now that we have the loop macro anyways that can also take care of
> the locking: psy_for_each_extension_locked()
>
> [0] https://lore.kernel.org/all/20240606-power-supply-extensions-v1-4-b4=
5669290bdc@weissschuh.net/
>
> Thomas

Sounds good to me.

Thanks,
Armin Wolf

> <snip>

