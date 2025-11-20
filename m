Return-Path: <linux-pm+bounces-38308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA91DC7495A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 15:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D93B3580FD
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B7279329;
	Thu, 20 Nov 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXDetQIV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E0275112
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649271; cv=none; b=diPyN9SDmhYoxNtFqGQqAjr7J1KZ5EmJsmo0xCHGrlqNVaWviuQeG1opumRC0dKd7KsZ+x31f1QhIZf0hCwJY2xHk7qaXBD6xBIi4IYRTvy2gNa/xLftPS92AMDXC9laVVoGENjfAKdHTcPvkzQR6oHIi9ncT1LtMT9KeeGPmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649271; c=relaxed/simple;
	bh=k/anXQYyC8uDbpNp42AfTNRPu/3ez5b6k2Iagre1OUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MexGYhWip4j8ruFkeJorDcSUQ1OAjtWuQPZjEROV+oFdLqBSww8VYFSCi6/JvhJ/ARvKwShpgJZKpiCXwohPigorsgar2Kts4GxwcPKVcpWsw3TXMKqMyCn3d+jKWnY4exvqW6EVfoaaJDydh9QrYuwWbbMeWRXBt+0EJJGGyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXDetQIV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c7869704so828107f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763649268; x=1764254068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUYcc4r+tgGERHiw4sLi/QfnZHQohgOhqd7TsTez+tc=;
        b=HXDetQIVtlgxTjFrAcClqsqociPjP3QQAeTmkq/XnzqPC5xrteFx0lAnOZ2ZdxkGeo
         lo0h2SvVmihr3/2QA/D7hUg25SA0Doc7zKJwRwi/lrEbRD9Erl8x3hPFFIjDlX9yZXc2
         zSf6YwI+edkS8pgZEwnjuROXPqLWjvn/HUWM0ZF83mDLLbWcGpsfawBIDbjvLVRVfgwI
         snyIUxEU0Rb+U0XMJSjWx0w2Bf4FH5WW4fMbH3LnuORyRmMo781O6ka5V6CkfrmN8Qur
         +326cmzJI37jCj8/3x9xIpQikGee3oc1OVCwAft7lDVMP0SsmHSlGHCRmoX1gqes8SNN
         o9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763649268; x=1764254068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUYcc4r+tgGERHiw4sLi/QfnZHQohgOhqd7TsTez+tc=;
        b=Ud3sL9igvCWOtyD2zkIdaZXmdZFuOxQR2MJbSQZnLrN247Xm7puTJ8Qzr+yIkbCTkI
         rNiG+OTlJiZ6HvwZAtwUqEPqLXC8F3sBLTvAO4BYiy0N/ue8YpYZ94Y3k3lB44TqDfuw
         XbhsvHfEEUkKiTJ2Hp/GJT3sBJOJd9dJ4/YKxQ2VY2QIWpDbdcbgbI55z12hfe/KlkZd
         /aQslFodXQkVIiXG6vpXDDf69YnMm3FLakqy/HtPqWuKXaRLFcys0C2rCJqW1Yyzfbww
         piXG1x2k6nWRsutBbFSbB2jREGlq4BY53UzmTdzi5wxymm1gASSQU26Df+CdhVR3piEm
         ypbA==
X-Forwarded-Encrypted: i=1; AJvYcCUD8d+pFdjvU62mvv85wf+35FYyEbMGjMaHaBQTzQFsfmDKZO41y9Wtbh1vd8yeHnXghB2KZEmn8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsgQ8iIST9I1PS2RCP6jJUk0mDhf68VGJMNxZ6vQUF5AGIzPq
	awC7c1IRDdwxT1ZX+6wid14TnCKuSY/Cd7nUeRM1z3RuJugM2LrMHc/VLhBNYerL6w4=
X-Gm-Gg: ASbGncutmYZFf1KhniVh80qk3y/w8RhySvVjUbGd966dB5UJlzynJjf81kQjmZd9D4j
	Gz/vlWoy69I1wwqMPIcRXWM6nSPyXKGELhAZ7mAMZ0AtVgBkKpl0F3muhx0sosQ42S1cyqNdZka
	gTvD2nIw9BFmQoKyoQuKwg9YWO56aiuzzFQZ6wp23FB7Qn75+rjnux9aKac79LSzzQTy1RwvRDu
	APPviY8X1smcIJ5S+kNSsnPLEadujrjFhP37M3SF74nUSGANI2xTrvHPVg/V8wGe5dlxY+er9MX
	ImVCM5gC1GO9OU+8WOb8q3FDxD/QEbLGTcBato/lixcmv8LbVNqLeNo5ENeci57ElN58eER+51a
	ky3tjl4dStEuJ+F85stWcaIW1iqbJVqRx3Z9CtWDLl0zGL8sLvKBph0LHq6crxwDHo+KoKa0X2L
	CppE8r0hZYs8AVhD2fYJFpk/BDsVLknCRXNYNWdPVzjLVicWdvQogHFzZYJCDCnangjQ==
X-Google-Smtp-Source: AGHT+IGlbuZs8w8XYO72pvmixBSISGeoWm04Zxu77OszgrCqdgHQMAvfuKgHEp2RwOwTG71ENxpMCA==
X-Received: by 2002:a05:6000:290b:b0:427:697:c2db with SMTP id ffacd0b85a97d-42cb99f6693mr2936843f8f.20.1763649268247;
        Thu, 20 Nov 2025 06:34:28 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm6577098f8f.10.2025.11.20.06.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:34:27 -0800 (PST)
Message-ID: <15b02217-9381-42bd-92db-ce6c6877d023@linaro.org>
Date: Thu, 20 Nov 2025 15:34:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: rcar_gen3: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
References: <813ad36fdc8561cf1c396230436e8ff3ff903a1f.1763117455.git.geert+renesas@glider.be>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <813ad36fdc8561cf1c396230436e8ff3ff903a1f.1763117455.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/25 11:51, Geert Uytterhoeven wrote:
> Convert the Renesas R-Car Gen3 thermal driver from SIMPLE_DEV_PM_OPS()
> to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
> __maybe_unused annotation from its resume callback, and reduces kernel
> size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

