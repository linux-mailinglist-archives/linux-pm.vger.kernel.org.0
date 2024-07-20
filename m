Return-Path: <linux-pm+bounces-11269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20ED9382D6
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 23:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774942818DC
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42059148FED;
	Sat, 20 Jul 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbsGy1PW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8BB12C53D;
	Sat, 20 Jul 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721509196; cv=none; b=Z3yOx19IOxPWpUB9/iTdVDMJbwF05rb1WCqAgy4wb/Ko3SgweTWjSBcG86N8ryagAtWzdtpFGnPRwpGGfRlf+uhqbYW20n1zOlfezWb64kJZJfQZyJZGXxOGS1nERvIB54KzBF+XA4MdRUxKFKCh8cXLrLrXJgfI1BN+gawleNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721509196; c=relaxed/simple;
	bh=SlGKA4DV6FGnIBjWZGbtVj/JmqmMFy0wLQN7pXsLwSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpUDJ3HPbNF+qjCW9wNubD+EX1NWAV2FAuF2KLTXiECVZkquj3FP6uckM7zyKt2XA9F/9i0xX6qy4gsDOlFGywNS93W/iTBmNYTzIIRUhFMNmSROFPh8T/YpbIgtv51ThA2IZMZWzuL1SlZ22blcylmcoh+kJPGpRIiGXBNnlbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbsGy1PW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so309692066b.3;
        Sat, 20 Jul 2024 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721509193; x=1722113993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67Vuv3zAuzzgj+Keqr3OaB52OBKHkioKfqjoF6CFvfk=;
        b=TbsGy1PWRmGD+b9EnEgVYMXtD039XbPVq/K+O6NJteqyQyu6zjr0DHTRdKONT8nY8g
         3D5uAcM7hz3fnkhFT+6bi6aZk8hX1SdGiJyEUOn31DZ5RKzNZQFGjo2Uh6bqELWY20IA
         400PcVG5JAyv8Z/Yl/N/lTtFbSsBTMPfZp9GN3NkQpvXyT8JyZMz5tfN3QpSzhppBfyo
         E1R+VFY9Z2KdOKKS7oafbZAWoE2/rObreTN6kNwmUdhxf9AcTbSyw93lou6KHYzKanUj
         Cs3lNntNYGzo28h1BddDDWKh+rUC3LBsq7MmCQWD6udFJmDsorwaf7/yykgKpxZi6/Ud
         Y3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721509193; x=1722113993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67Vuv3zAuzzgj+Keqr3OaB52OBKHkioKfqjoF6CFvfk=;
        b=aau9NUJSoBq0bsrzqRUYWiqraNO0kRCAJEVeFvngPUiRlWmJB7tVuDJCQ4lD29reGO
         SxyGBxsbEyvZ0Kj7P2E6XfcU/2/cyZmOBWXHXFgNY1shj8Nc1dJxRyYBBzNmHN38B+Rx
         f4rQNPbb375BM3Nx28jIOGRaQP9QczqqlolmqCJGNQNTjERwtiBguLTqBfQl99YFnuHz
         +JHyqY3SF2agz9ZHZWvD3K3bX67P015mxLR9mEzddbzWGJySQIjpu+IIE0EEopKiOn33
         CRoeGGhqGVvZ5/eQc8ys69iLsBlvOstxu9zz2R7HUC/IX3/MYjUl286g4fnN1+4P8qG7
         v+uw==
X-Forwarded-Encrypted: i=1; AJvYcCVrW169zmLneJRbDEAov49CKvVrbt1Apz0rHnPgAt4Yo/pFotF0DabDC5m+qSZ7IwS1yzBBUj1OT1ViXPGk7iL/hPzvdWqwPF3h1iEEHzo6oPMdJyfbII6XCZ3AadHbcNeEMV9qDp+JvSwWF8ohhWsT82Za6zQ3hmE+uBj3YWGsTTuwKDVpcR21/2o6uQKyFrC+S5IA3OsylJJ+ab/o8+c0LCPU4wU=
X-Gm-Message-State: AOJu0Yz95crVjLrm5gsmpjeZjFuxfIZ7yhXaU5dV5NQytQTV1xcdiPs5
	QQHFidvlJxVH2+VI9dRr0D64AWypGQtN+wrdGTlJx8ekBMz8UeHj
X-Google-Smtp-Source: AGHT+IHNEdJBvRJKbVIo+S/5Nm83uuH67pFaqEGP4SVw6APoYnJr7dz8GhawOqOHKw4QK8uU3/hYjw==
X-Received: by 2002:a17:907:3dab:b0:a72:60e2:bdf with SMTP id a640c23a62f3a-a7a4c22636bmr173086166b.50.1721509192460;
        Sat, 20 Jul 2024 13:59:52 -0700 (PDT)
Received: from [192.168.0.37] (082139000187.radom.vectranet.pl. [82.139.0.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8bea1fsm205169266b.111.2024.07.20.13.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 13:59:52 -0700 (PDT)
Message-ID: <9eedeaa3-ceda-427a-80d8-de6b59eb1f4d@gmail.com>
Date: Sat, 20 Jul 2024 22:59:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] power: supply: max77693: Add USB extcon detection
 for enabling charging
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>,
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
 <20240715-max77693-charger-extcon-v2-6-0838ffbb18c3@gmail.com>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20240715-max77693-charger-extcon-v2-6-0838ffbb18c3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.2024 14:55, Artur Weber wrote:
> Add a device tree property, "maxim,usb-connector", that can be used to
> specify a USB connector to use to detect whether a charging cable has
> been plugged in/out, and enable/disable charging accordingly.
> 
> To accommodate this, also add an internal pointer to the CHARGER regulator,
> which is used to enable/disable charging and set the input current limit
> (which will be done in subsequent commits).
> 
> The extcon listener/worker implementation is inspired by the rt5033_charger
> driver.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ...> diff --git a/drivers/power/supply/max77693_charger.c 
b/drivers/power/supply/max77693_charger.c
> index 0ddaa03669a2..2dc273dd96ee 100644
> --- a/drivers/power/supply/max77693_charger.c
> +++ b/drivers/power/supply/max77693_charger.c
> ...
> +static int max77693_set_charging(struct max77693_charger *chg, bool enable)
> +{
> +	int is_enabled;
> +	int ret = 0;
> +
> +	is_enabled = regulator_is_enabled(chg->regu);
> +	if (is_enabled < 0)
> +		return is_enabled;
> +
> +	if (enable && !is_enabled)
> +		ret = regulator_enable(chg->regu);
> +	else if (!enable && is_enabled)
> +		ret = regulator_disable(chg->regu);
> +
> +	return ret;
> +}

Nevermind, the regulator-based approach simply doesn't work here, 
because we pretty frequently end up in a situation like this:

[   20.162612] ------------[ cut here ]------------
[   20.162618] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:3015 
_regulator_disable+0x140/0x1a0
[   20.162645] unbalanced disables for CHARGER
[   20.162649] Modules linked in: fuse brcmfmac_wcc hci_uart btintel 
btbcm bluetooth snd_soc_midas_wm1811 st_accel_i2c st_sensors_i2c 
st_accel_spi st_accel brcmfmac ecdh_generic st_sensors st_sensors_spi 
ecc libaes brcmutil cfg80211 rfkill exynos_adc yamaha_yas530 
industrialio_triggered_buffer kfifo_buf exynos_rng s5p_sss cm3323 
industrialio
[   20.162737] CPU: 0 PID: 29 Comm: kworker/0:2 Tainted: G        W 
     6.10.0-postmarketos-exynos4 #82
[   20.162747] Hardware name: Samsung Exynos (Flattened Device Tree)
[   20.162754] Workqueue: events max77693_charger_extcon_work
[   20.162770] Call trace:
[   20.162778]  unwind_backtrace from show_stack+0x10/0x14
[   20.162804]  show_stack from dump_stack_lvl+0x50/0x64
[   20.162824]  dump_stack_lvl from __warn+0x94/0xc0
[   20.162838]  __warn from warn_slowpath_fmt+0x120/0x1b4
[   20.162855]  warn_slowpath_fmt from _regulator_disable+0x140/0x1a0
[   20.162873]  _regulator_disable from regulator_disable+0x34/0x6c
[   20.162890]  regulator_disable from 
max77693_charger_extcon_work+0x1e4/0x268
[   20.162907]  max77693_charger_extcon_work from 
process_one_work+0x154/0x2dc
[   20.162925]  process_one_work from worker_thread+0x250/0x438
[   20.162941]  worker_thread from kthread+0x110/0x12c
[   20.162958]  kthread from ret_from_fork+0x14/0x28
[   20.162970] Exception stack(0xc18edfb0 to 0xc18edff8)
[   20.162979] dfa0:                                     00000000 
00000000 00000000 00000000
[   20.162987] dfc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[   20.162994] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   20.162999] ---[ end trace 0000000000000000 ]---
[   20.163007] max77693-charger max77693-charger: failed to set charging 
(-5)

This can be reproduced by booting the device in with no cable plugged 
in, then plugging in an OTG cable. It prints the warning on connect and 
disconnect. More importantly, this prevents a switch to/from OTG mode in 
the scenarios that print a warning. (I've also encountered some issues 
with similar warnings being printed on unsuspend, but wasn't able to 
reproduce them; I'm willing to assume they were related to plugging in 
an OTG cable as the wakeup trigger.)

As far as I understand it, this is because regulator_is_enabled checks 
for the hardware state, not for the in-software regulator enable count, 
and the charging bits are flipped on by default (presumably by the 
bootloader). I thought regulator-boot-on would handle this, but clearly 
it doesn't...

Best regards
Artur

