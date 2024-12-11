Return-Path: <linux-pm+bounces-19016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835239ECC88
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 13:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C818D188AEAE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C08222912E;
	Wed, 11 Dec 2024 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bZ1Nsttz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB2323FD03;
	Wed, 11 Dec 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921320; cv=none; b=XLCnCp2MgsTzE/xL3U9vUoT64+pvghUA9qdo69HJ4hcbQDsx+VgkmT+5UbiGdWwsRLrRH8GO2RsOOMl/J6VtFOBl+2+iRXvuOKqqeMptQDRqaZ9WnO1ZzLyZOGUDrOaWSj0QtCB095zpuwzRIu5qBHtC6OFubXq/svNU8jqkBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921320; c=relaxed/simple;
	bh=0HQD/T+EhtMZNzLVWLdZpq19I6Pg3sk0nuO4ieD0m6A=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=PHZcR/s1E3ueO+HGUiZMh6C1GcWciCnm6+aregQswAX6wX9qEf49kzPfZGcNDcg4h6diPKeUjfP8flYdVFfk6KG1nXP+H5UYdfYk1nSo3x1Xvx5F2trYWLUy8Ivh0qTTOYf7tCl4Dj/yx6EpokNIbpb7hB7ZdMnaLIXljfXNfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bZ1Nsttz; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id LM8itDHmLTOxlLM8itkffp; Wed, 11 Dec 2024 13:48:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733921308;
	bh=UgB86qgQ2Cldtwlv8AGFJ7+9eSzwqxjNruEPaNLHTLI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=bZ1NsttzSOG9q9m82N/J+l9fKHHDLq8DILJdUGJulwHCR8sVjTYHohmXAu9scOf6N
	 02cFsP7EOnG4JVVrSh7sPmew6oWXg6I0b3DWt0M+/cw0gMgD7CyRUWDzdZFkIJtMfG
	 k0upo18ie7cjxuasVjrlYLQMYsDintXKPE/r0yemX5EG2jYHflrRBofZQWRcLELb+R
	 kK2IQ4PzUogCBqdaONZWkKXEx7S8ViG1km0/u1xqtdwt3XPjNuq3V8+OSAo819kp9C
	 A1Tp/rBqIoF7+7eD+/OjYDTBT9XBhnjXy4ax3TWWNq+RQEhwixsJBe7V0THWUWqwbH
	 T+a9wq2dQpsZQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 11 Dec 2024 13:48:28 +0100
X-ME-IP: 90.11.132.44
Message-ID: <8f629dca-7085-43c2-a245-050ecba53fa3@wanadoo.fr>
Date: Wed, 11 Dec 2024 13:48:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] power: supply: Add STC3117 fuel gauge unit driver
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210080954.5067-1-bhavin.sharma@siliconsignals.io>
 <20241210080954.5067-3-bhavin.sharma@siliconsignals.io>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "From: Bhavin Sharma" <bhavin.sharma@siliconsignals.io>,
 Sebastian Reichel <sre@kernel.org>
In-Reply-To: <20241210080954.5067-3-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/12/2024 à 09:09, Bhavin Sharma a écrit :
> Adds initial support for the STC3117 fuel gauge.
> 
> The driver provides functionality to monitor key parameters including:
> - Voltage
> - Current
> - State of Charge (SOC)
> - Temperature
> - Status

...

> +	ret = device_property_read_u32(&client->dev, "shunt-resistor-micro-ohms",
> +				       &battery_info.sense_resistor);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +					"failed to get sense-registor\n");

Should it be "shunt-resistor-micro-ohms"?

> +	battery_info.sense_resistor = battery_info.sense_resistor / 1000;
> +
> +	ret = power_supply_get_battery_info(data->battery, &info);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +					"failed to get battery information\n");
> +
> +	battery_info.battery_capacity_mah = info->charge_full_design_uah / 1000;
> +	battery_info.voltage_min_mv = info->voltage_min_design_uv / 1000;
> +	battery_info.voltage_max_mv = info->voltage_max_design_uv / 1000;
> +
> +	ret = stc3117_init(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				"failed to initialization of stc3117\n");

"failed initialization" of "failed to initialize"?

...

CJ


