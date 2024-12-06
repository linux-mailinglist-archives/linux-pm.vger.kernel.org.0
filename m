Return-Path: <linux-pm+bounces-18715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A919E794E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 20:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1DC167D51
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63601D6DBC;
	Fri,  6 Dec 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="k8ZCinCr"
X-Original-To: linux-pm@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3C21C5490;
	Fri,  6 Dec 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514684; cv=none; b=BhG8lyPNz8K7PA0FH5r3xAWPx1xkv2BdlX4nNjDRGRISojRENVRHdgsJmHr/D4qaJmJrsP3UBPzGjd/43BVmnQyt1JTrHazTnD2BYZi/LaFDN7AkWq/JR0nz4lQkfuG2bkE4qajGeH3elvo8lDPAWXzmGoveZ0SkBLfq+X7NMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514684; c=relaxed/simple;
	bh=U5Hfzz0+AAl6GEPSfxjhuaIYeEAEYiOJ8XyJDnluGow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTPxvLy76Len4mW9YCSxW02ph7g4R/Froyuq4YOn9p7c3NcBfWjGmoC8ESJHpjS0ozVkKivZHpuOfkv/2s3hMxZ/Yb8LRq/qXHb7HoYipKl/spq9PsuSLbcjbJg54MJ4PqrVDSyg1VZexFY8JZVZ3Pa5c6mNrOFYYVQoLbowU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=k8ZCinCr; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1733514671; bh=U5Hfzz0+AAl6GEPSfxjhuaIYeEAEYiOJ8XyJDnluGow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k8ZCinCrkiJn+Axj4i1Q0aSjI2sze7RuAkNyze25hQqCBrcVBlxApIo+EqZK4wlnf
	 fniK2hKQLibhUsxiyYZmHB04X+2axk88QL5tSh6U8uo0AFK6eIxWpArjTecUpHQ5Ti
	 ApJXxnMQQzzKpnpsvATY1YFsNabAd0l7jN75m6TQrX0eiCNmHYHAlhETYbJoktF25i
	 m0VyjUAVIrlxhn1xQ/xBtk41a2e8x6IRywL0r2UGw7Wxv5mnpiQuhxmJ1YPSyGU9/O
	 d1CakWiCpTY4lcsWi8nTJwl89ugwcXZCp0zpcMgEibwr1R5cNmAhnt6Y5fymbj+Vh/
	 pG5n+UG1ED1qgIp45FGhEsifmjQ7XwY9MPNLBAbe0MilddIjBjIXZwmagzhyJgPcVm
	 YcbmQVZjzOCdQwMRrJg3DrmVYXBE2S+neE2O/Mqj18UDcHPYAEvLwe9yG6kPInUOoR
	 UTRwbGx5OqJw4Tn8H86JPmbsud/qK0JMe/ST1Wde7nUtdHdV8YG5mORyt7FP2koSGw
	 QAwJ2kFSN/+cwdmjVxgLFEE++O2m3SURZ/AdVRFVUuu/7o7I8OpDqmvytdh4lw6NJF
	 HiiJO1AiAxU2glRV87i6wPFaRRar86EmyvCO6n9huxR6qmWQzAMZjwicp7Q0q10RBP
	 Gw6+wTjliDXS/pMnYJsX49pw=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id ACA3018E22A;
	Fri,  6 Dec 2024 20:51:05 +0100 (CET)
Message-ID: <b547c228-df70-4137-9e96-175923f62404@ijzerbout.nl>
Date: Fri, 6 Dec 2024 20:51:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] power: ip5xxx_power: Allow for more parameters to
 be configured
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Samuel Holland <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
 <20241119180741.2237692-3-csokas.bence@prolan.hu>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241119180741.2237692-3-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 19-11-2024 om 19:07 schreef Csókás, Bence:
> Other parts such as IP5306 may support other battery voltages and
> have different constants for input voltage regulation. Allow these
> to be passed from `struct ip5xxx_regfield_config`.
>
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
>   drivers/power/supply/ip5xxx_power.c | 43 ++++++++++++++++++++++++++---
>   1 file changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
> index 41d91504eb32..a939dbfe8d23 100644
> --- a/drivers/power/supply/ip5xxx_power.c
> +++ b/drivers/power/supply/ip5xxx_power.c
> [...]
>   /*
> @@ -328,6 +348,9 @@ static int ip5xxx_battery_get_voltage_max(struct ip5xxx *ip5xxx, int *val)
>   	if (ret)
>   		return ret;
>   
> +	if (*val > ip5xxx->vbat_max)
> +		return -EINVAL;
This is introducing the read of an uninitialized variable.
You have to check all the callers of ip5xxx_battery_get_voltage_max()
and what variable *val is pointing to. For example in
ip5xxx_battery_get_property() the variable vmax is not initialized,
while its address is passed to ip5xxx_battery_get_voltage_max()

But maybe the intention was to check rval instead of *val?
[...]

