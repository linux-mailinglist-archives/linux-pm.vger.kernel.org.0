Return-Path: <linux-pm+bounces-23928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84552A5E2B6
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 18:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53645189FD3B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146623A9B4;
	Wed, 12 Mar 2025 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRmNDp6D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBEF250BFC
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800136; cv=none; b=IZZCnfn10JNGihD5529M3WroUhO/ylz+8wgArK52aZ58kI4JLqb3HAF/+5P8mKVGMfFoAy5kgYcOURnXRWHWD2KIzi+Uou2nZ7ymfVMoQH1zsQhu6rbCLeTePLQTTOE0RfU3XPwKCvtgg0ZciSpIqoKUIgQgJHylLsTFNOjWFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800136; c=relaxed/simple;
	bh=L6a4kSgVy3RSwlSMSOjk8/41yNjs6IAArlYr/5aa8CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOBo40u+Hlu3oN+76WH4wgiAocaikm4Y0QtN9iKQ1Fu0FesWI7s2HAt2R3nXEDWjRP0sFjLgDm5uIqq0edU7ugOgzdDPnLxVBQwbnz1vSXSyDdySSuV1lRUIOasBmb3nsAE4kjb9aqk/A6nJuCSgADlhRlmaCsf7eP1mWUDKGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XRmNDp6D; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so76572f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741800133; x=1742404933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6JWf9s2rIuKyyKaAFeiZwziBKuCoBJFQKmV1DDqia4=;
        b=XRmNDp6D2M7hLPrvSmpKtourgRUXxrV88elnzuxZ2xkEG+ezcRvLTqXDvSsA20djGW
         HFGFiH6HMBIOJm5lZqNwCRihGh3qra867uRnhFEDDK2ybOhzUUGXvhqFZ8KvbVf+1xdx
         K281EwzhRtcgh8T8conh62OU2/mdwzUD5HBlia3iE4QBWWguftCMMQEnSnJ/Jo+67Af4
         Z2PdWf0nZ05zuqmWZR5bt/qAW7oZN90Vrm1o3ALBL9csOTGe0qhoe6nhT09IRDhVLNxF
         FChIqtV1svAVe9Q9Ncc9ZBtHBYtFkv877VlGJFJADTyYxLV3RYH8Q5W4zSlsrnaj9Uli
         dd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800133; x=1742404933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6JWf9s2rIuKyyKaAFeiZwziBKuCoBJFQKmV1DDqia4=;
        b=jz+wklgH0UWv5jH7azmX7dnAUbEL1EB0Gie9GbuiUpraYNHfbecrSMjywqMIheynMW
         E9kfPsRL2Q2I4GIZsnZTFGFZR+7viRnmHsiu198/00hBTsx1setVPpTXX+aaB7gc+dtE
         nPKnyjRfu5uOANk9RxhAw4cCTH5XA4A7e5lFLJDKAfC8U53GmOJOtrSaeHL5EzdaHvn3
         Mu2T7jraQZyLbQvarzxUpspBij5SeHzs6kgc2bdApy0dX/b3jOZ5JS/QIpfeWdcCm+hD
         2fvCfMw6eFUw/WDEnCQ4PimWTE7vPBTLrRxiu1eYz47KFRcjihz+uEzOD/kP2qNuNqC1
         jEEg==
X-Forwarded-Encrypted: i=1; AJvYcCVTw3fOM/xYpDBkqQ5LU3AksjdLIGm0ngG0uX4JJ4sSnjiNw/XrEWNPgqBxddqlRkOVhjjfLcGb2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lxHuJbb7sOvxnSwpowIf9upcoWv4Lgmd6LsAvYWSgHbZgBui
	ZGph7EJgiuMwHZHNpD20DC2RpqCaAUUh0Hr9Nv8Hca+IeMeNdh2f1XfHSugSwzI=
X-Gm-Gg: ASbGncv+Ag0KzmRu6xvbRf6I9730vpnN7D82N8IW8whoWxgUTADB4SM/iMgeaVO1Epo
	cZpLLrxnoKviKpWLaCMIIsyG2XUcyKQPmItOZGetpr1jx+cvo43knPDV/7xqDm42tZgB6ZC/l0l
	eVfWbxvKOQgcMV3Tp8PS83CvdNSa6IugwAZknTtU8aZarfH44XDLmEdZHhL5oU7ru7nXfkcFNJA
	ZCONx5545sQo+wuEz0BRKl+ZIhQpREz59YsOVyha/RBVpPPcpEs5ppblF53y/yEWpUlTmlhhbFE
	Ls1LLyNb6pMdvTsFsIe6glNareiHVt/kHcScqVLYjhiMHztU5DuSiygtB4PvRKrsB0r6iJ4wjKA
	pvn18xZlt
X-Google-Smtp-Source: AGHT+IHmUyQA0rYHqvGLoQWTP10z9aEu3s308pBbuP5uQ4P4qcJBt5u4uWFj/L5XlO6T2InaT4bWOw==
X-Received: by 2002:a5d:6d8a:0:b0:391:12a5:3cb3 with SMTP id ffacd0b85a97d-39132d2af8bmr18346729f8f.3.1741800132754;
        Wed, 12 Mar 2025 10:22:12 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f39sm21327715f8f.80.2025.03.12.10.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:22:12 -0700 (PDT)
Message-ID: <5ba39d01-f13c-4c4d-aebc-82929c6f3df2@linaro.org>
Date: Wed, 12 Mar 2025 18:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] thermal: core: Record PSCR before
 hw_protection_shutdown()
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20250306093900.2199442-1-o.rempel@pengutronix.de>
 <20250306093900.2199442-8-o.rempel@pengutronix.de>
 <726c6ffc-a8d4-4328-a849-2d59f3a0a1c9@linaro.org>
 <Z9G7g5fr8DkJtcLI@pengutronix.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Z9G7g5fr8DkJtcLI@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/03/2025 17:51, Oleksij Rempel wrote:
> Hi Daniel,
> 
> On Wed, Mar 12, 2025 at 04:35:51PM +0100, Daniel Lezcano wrote:
>>> @@ -380,6 +381,8 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
>>>    	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
>>> +	set_power_state_change_reason(PSCR_OVERTEMPERATURE);
>>> +
>>>    	if (shutdown)
>>>    		hw_protection_shutdown(msg, poweroff_delay_ms);
>>>    	else
>>
>> In the future could you add me as recipient to the series instead of this
>> one ? so I can get more context.
> 
> ack.
> 
>> Given there are no so much hw_protection_shutdown() users in the kernel, it
>> could be more interesting to change the function to receive a enum
>> pscr_reason and then in the hw_protection_shutdown() call
>> pscrr_reason_to_str().
>   
> Do you mean, make it work with CONFIG_PSCRR=n?

No I meant instead of doing:

+	set_power_state_change_reason(PSCR_OVERTEMPERATURE);
+
  	if (shutdown)
  		hw_protection_shutdown(msg, poweroff_delay_ms);

Replace it by:

  	if (shutdown)
  		hw_protection_shutdown(PSCR_OVERTEMPERATURE, poweroff_delay_ms);


and in hw_protection_shutdown() use pscrr_reason_to_str() to display a msg.

That can work with CONFIG_PSCRR=n


> Beside, the latest version is v5:
> https://lore.kernel.org/all/20250310103732.423542-1-o.rempel@pengutronix.de/

Ah ok thanks for the pointer


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

