Return-Path: <linux-pm+bounces-20056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD4A048FF
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 19:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A26161607
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1673218CBE8;
	Tue,  7 Jan 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ri0qJUcJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA1199931;
	Tue,  7 Jan 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273475; cv=none; b=aGhAsh7s+5nLYA9S8xaqo30L5xQXTIR7eCG5eZUJScgcKIfCnptIY+DmifdVsY7Ru30Ht7xElOeodbohHXZFOjN/Sy45t9LJPjeDCB47TLO2jXwLG3PmvtOAZDgutJcY/1iVPHNik39Nu+gOX0K9l5yhIqudxtI4VpBwEKeRais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273475; c=relaxed/simple;
	bh=skNssl6xvHgTtpAlsh7GChQj+T4UJ5GVJHooqLIkAHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTEr77CxI0W+ac7K8tjArKTMzkWJQbrVnsvDPyOFhmrTS4VzQ7X3snoW0OGeCCNkID+AKxG7ocbWXfocAGUhsB+yiiW1ibZtSQgavhjmz3/p1aCKvbQ18S/SQkmxtHwK9Bas+tCCwn4UBOtIg1fWr/1XH5tq91Pu39Zd41gEF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ri0qJUcJ; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id VE2ctVpn8nktyVE2ftbwd9; Tue, 07 Jan 2025 19:11:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736273464;
	bh=Fe08/qfQPQZoDkTmwGi4NLr9fr1hHVIqUL3BbD3l/v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ri0qJUcJLvITLMHUtWvDDZIWvxaCRscvs+394esqr8aNJ/cBtbH2FjnF8krv9PjsS
	 SlrNC+k1jfNPetSNWLJOqju3DhZpaOoA1xkBkYFcNmMtAwLIUycs7lxhssENP9tJcq
	 /uJXro2/f3gZ4F4HnmeXRx22Syf0FCaZmc/xflCyKT6R/KPR1gGBdaelyVtqePA/7i
	 MN69q2u4jmu2Be2OfeHVef5hrxFMYgJPwu3mFkEO6VqZHI3shz8iXAn1PHZztxngZs
	 qTzNuuIP7fvhbMus0j9FYXUsW7kp658q0oyv/fgNBOItsmytOCvfwje/dwAjM+UoXZ
	 5ZWx8Y2K7LU+w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 07 Jan 2025 19:11:04 +0100
X-ME-IP: 90.11.132.44
Message-ID: <6abdef3d-95cd-4afc-b5d4-880c58f60e9d@wanadoo.fr>
Date: Tue, 7 Jan 2025 19:10:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel gauge
To: t.antoine@uclouvain.be, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
 <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/01/2025 à 12:15, Thomas Antoine via B4 Relay a écrit :
> From: Thomas Antoine <t.antoine@uclouvain.be>
> 
> The interface of the Maxim max77759 fuel gauge has a lot of common with the
> Maxim max1720x. The major difference is the lack of non-volatile memory
> slave address. No slave is available at address 0xb of the i2c bus, which
> is coherent with the following driver from google: line 5836 disables
> non-volatile memory for m5 gauge.

Hi,

...

> +	ret = max1720x_get_rsense(dev, info);
>   	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
> +		return dev_err_probe(dev, ret, "Failed to get RSense");

Missing ending \n.

>   
>   	bat = devm_power_supply_register(dev, &max1720x_bat_desc, &psy_cfg);
>   	if (IS_ERR(bat))

...

CJ

