Return-Path: <linux-pm+bounces-13788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1696F343
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A533C1F256D5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954051CBE9E;
	Fri,  6 Sep 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMjP2dQk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344A15852B;
	Fri,  6 Sep 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622871; cv=none; b=BsWJyBpR63WdUHXgZ5ccPhCxMRb1cZaiEMKBE4/Pvl/YPiCdeBAprGe/a00UsxFXAgl9lF2fpTDILDd3miwGq86SH9Hl16bU4m5pjvv7Ze0MAMuzAUbW5mODO9ef6/6drsdwPP4o/kv48/5e++dESVLsgU2uQonPt16abw+OvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622871; c=relaxed/simple;
	bh=8aSJOWgx+cnbeHGiojisRHuWB5MxjZipaJDi/7kDI2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpJuYR3v/wHJW10FILUMsy/ntPSztvd93AFrclPXcxl0VVC8CQKkz7D06sC7ASOtu7n5LaLA4H4caMykgRjbN9dkDtsT0KRg/5gPtxG4NFOiLelAMC0BvOpwpbrZTkSEieJHR+l584mwEjA+Oth6i6jKpx/cJnRE+jMB8DppBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMjP2dQk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d885019558so1437632a91.2;
        Fri, 06 Sep 2024 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725622869; x=1726227669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nSE4UbmLPT89Bj18HP/jHu8JFDfgkM64ZTAP/BuhzBM=;
        b=KMjP2dQkcEJotvFA7eX1clmdCx6AtBfcg+/M62WloehFiy/4sG0mtTT8Bfo8VdQF8y
         Jo5vPw2glWUXXQdv0yjsixWSfAidtd+pABfxbyELANhtjqfak7ZCJjbjzwVEqKP3gvsR
         0+jBXHp2cD/fDbOFs1FGeWd/X1Kk78T/UBNlqkK+vRqXyLVpa/4MCIde2JapF9aBFJAP
         5ZNlMV93jYInJCz5CWtp/HzBJRVLAT65msLT/S0gdSE0rsXg6Zly6WK8obE3xYjLWm0f
         CXz5/OhnZdXpF2cwVPy8GS4THF2p22dWgVWgYLb9p43Mz9uqTXJ24kfReih1NG61P+AX
         YKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622869; x=1726227669;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSE4UbmLPT89Bj18HP/jHu8JFDfgkM64ZTAP/BuhzBM=;
        b=oRw2e4BsRlCJgh8oN8tLAbBnWFQ4IAAjcRAIf1NYAQLtKtH8imxLs0I/7pf4D5NwxL
         zu7IByr1Ae0h6wheeSqSubmSmrkgCHOrZdL9oQOvwovnIGqb0OUubTMswot7vyxi9BR6
         lD6/iaI4g4Jq+65/JDxioZkblFep9ZHviiFO0HCqZ36YCppwsDEUNtvfom7V+pjzfnuN
         fQZnEE7AoV9ERNP48LEhpLT+Ejq4QPBs4jcVd/PI4wWoXClyHNvQE842QnRrJ26n9IaN
         TdEgO27Xoa2us/+a8uw8lig11gp05ZPzOLtyee1eXS8yciP46LCTZHNsXJLXkjrdESjX
         ZfDg==
X-Forwarded-Encrypted: i=1; AJvYcCUQUaHTKNcrzUAWgKZQpdkPy2k/e350dJ65DKer0enmp/HwLJ9Em/QStNC7YBEb3/DOZKOccwJAeMc=@vger.kernel.org, AJvYcCVf7JT6z5uT02Gdm9ZEx4RsRvD4zrdiBcv6t4QnEqZpez1dSeO+AFlpwmfM1vnJQGrvP8/xRVdZNFH8@vger.kernel.org, AJvYcCVhd58Smb8QUNRD1jgFTlLILxflIh1nSIulLlovKcnES/PbbiJQxjX0Vn0HRTbAvVbs+8cEBLDsFuowbg==@vger.kernel.org, AJvYcCWJZswuOQjy8bCzLSPzpAzSbpxzbp4YZZcyph8FCKoTN82w4OapQv0rm+kxxp4Tmb4B3Z5jQz7rrtNuK0HVV0A=@vger.kernel.org, AJvYcCXJReZyKlMipucwmgRwbwqLQ1znIo2YR4er2erGhSyJZZdtk3Isc/OZeryqsuWw+x0R9lIwFKSSOLjV@vger.kernel.org, AJvYcCXKAeouMBmQXyUwnNpaoeypol4+fzh4uexutZfL3rzuQTDsPipn40/uGrZBKweqJw5OUUlNUplkOZY8bW4S@vger.kernel.org, AJvYcCXoLu+ddit1Axyif81iO5utgzLYxh72CPo1GLFnyquF+tnx5sC4/rxMfpDO62tdjbfFjsXzFmGcOSjK4PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYQQnTtjLMHerk+mTERo548YQ+7Xw3YZjtWKVAClAXMmord8+m
	TjEimPBIr0KbHnp6CA3sdzwIXVBhZ2nKTiXCBAwKkfbVUde+SUJo
X-Google-Smtp-Source: AGHT+IG8+NKJVVHmU7dMZkptp8cuB6+8HX7Zzy6Yj7AiC4L2InjShBKLgIME0ueterTApmKVtZTUtg==
X-Received: by 2002:a17:90b:4ace:b0:2c9:6a38:54e4 with SMTP id 98e67ed59e1d1-2dad51bfdd9mr2390340a91.41.1725622868829;
        Fri, 06 Sep 2024 04:41:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfeebaasm1334056a91.10.2024.09.06.04.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 04:41:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a33633be-800c-4ca0-9d1e-f190e23384d5@roeck-us.net>
Date: Fri, 6 Sep 2024 04:41:05 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hwmon: Add support for Photonicat PMU board
 temperature sensor
To: Junhao Xie <bigfoot@classfun.cn>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-7-bigfoot@classfun.cn>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240906093630.2428329-7-bigfoot@classfun.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 02:36, Junhao Xie wrote:
> Photonicat PMU MCU will send status reports regularly,
> including board temperature.
> 

This is not an appropriate description.

> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>   drivers/hwmon/Kconfig            |  10 +++
>   drivers/hwmon/Makefile           |   1 +
>   drivers/hwmon/photonicat-hwmon.c | 129 +++++++++++++++++++++++++++++++

Documentation missing.

> +static int pcat_hwmon_probe(struct platform_device *pdev)
> +{
...
> +	dev_info(dev, "Board Temprature: %d degress C\n", hwmon->temperature);
> +

Unacceptable (misspelled) noise.

> +	hwmon->hwmon = devm_hwmon_device_register_with_groups(
> +		dev, label, hwmon, pcat_pmu_temp_groups);
> +

Please use the with_info API. I am not going to review the code because
it will need to be completely rewritten.

Guenter


