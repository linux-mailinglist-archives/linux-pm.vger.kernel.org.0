Return-Path: <linux-pm+bounces-8741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156A88FF5C7
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 22:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E22F288DDD
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 20:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A217346D;
	Thu,  6 Jun 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPY3czMJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A371B27
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705257; cv=none; b=tXzzYQO/UXS1kKwmUnGpmaP76m5ABHHYTw8hx4kQlH9BV0Ne5jG0W9MHVzsxiNbIo4iRMWZYppZpeBhsYbNCAvNeLHHTzvTgEoo2deaux8qiGNNtmEZn8gP3j5CJAuhDKaT0CX42Q5anYhPjE+BVcRdTl9xgZmvczZpea02uF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705257; c=relaxed/simple;
	bh=ZhN5psr88O1rTZYnaj0Pp6eojbRqBJN+Mq+LrsdNdOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUk/uxueprWdkny31CErw2UbdOCPTdAKNbn/N7NL8aCU4zfX/Bvjlx/dGUVMIRdCd09/Jm1n0brtjQ/VV50uk0wPX0ty+ZbMgyCw61EVMBKkhio0VC8MZs0LdEH17P566yBs42UuPYDSWXJ13n7eT3+I5dbDxy3VEgN8HWCKj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VPY3czMJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b912198a6so1783113e87.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717705253; x=1718310053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83UooEInBqzhI2DlCSt/csP7JuwUOhdJysD+ewzTrGo=;
        b=VPY3czMJ3YejXbhqCZ9aBdOLp6TvNZcxgEm59A0kdPfyU46Jc2JGICqxrFhqjmcWC0
         G5smW9rvX8Tc4sv89t4ZZ3LKMdYltI9p9AOFpVxPWeJkTxczd189ZFZXnHATg4StWRIE
         8i92JcUnhdWMchcVvHPFEW0i74qtynEelcagmJKlCf9ng2ruI4F6kqvQoTlHagU3qBsl
         VLCeFwV6TGNYAfuMjyfvIC4Wi2mEu55hczNFF1KIgFYm9oWF9WMsro3qaiCQEYfwOAeT
         G9wL6+NM+yk5pVKgxBRuuLmqU3SI7TonNHbSuJhOgRuOVSpGh4jxNNJthwmxECt9dIFO
         LegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717705253; x=1718310053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83UooEInBqzhI2DlCSt/csP7JuwUOhdJysD+ewzTrGo=;
        b=V59EAtxR0ul5W6/4Re3bl9pwWelP6P7evjdhwQx1xSHssIh1VVmwDPdES4Ql9JC8g7
         Ii0QfOBQ4mws4a9vOuR0cyUspPxBSq1Z5ZPlQ72HSjt4blEkW3Ga1ih6hDCiEx1n04Qo
         rknolm0dAQT+P/0otqfI3lUGuYF5d4BPfU0i3tj3vimng6GEgN83Kh3bMRPJVDOrlVjU
         VbB6ia8bQz68RZRF24nIMhbgri1p2d+VuBni9mYeCdpe8VltcHBfJz1Z9tn1Pqn4jfvi
         Bf1Nde3s2SYb9va+vdr2F5KFj8ipRwPKxcGWsQU2r9oyLppaCudAYVoLf5+75+90mHb6
         EwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfLDt22qJR/NcgDhHE4HKE+TehE9nFOk6rbt9lBypXlpcB0f3cKltr6+cxWxGmN8A89lLATCB3e1Kq9I9f1m87HjGTbQoo2Xo=
X-Gm-Message-State: AOJu0Yw8ADsfSYBncrgiGXIRkuQstQ+rqdisw40N2KkKOgXvddRWPmKO
	sCXogiIcfeyYJ2j+++m4trz05qZuaUdUqlxHA2X15JQW3ty4DkazLUjMgcqOH5A=
X-Google-Smtp-Source: AGHT+IEdG8vgcBO9N+bQsEADxiJZEJ8P0VduttpUVKLHZAp+J5ZqcCuSthLDPZi8nT7v2tqh/BTMPA==
X-Received: by 2002:a05:6512:3e01:b0:520:ed4e:2203 with SMTP id 2adb3069b0e04-52bb9f64915mr689722e87.8.1717705253100;
        Thu, 06 Jun 2024 13:20:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f9a9:3740:b905:9995? ([2a05:6e02:1041:c10:f9a9:3740:b905:9995])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4214a4aab93sm70618805e9.0.2024.06.06.13.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 13:20:52 -0700 (PDT)
Message-ID: <710ce159-728b-4dec-854c-bbfd6b4bf6bf@linaro.org>
Date: Thu, 6 Jun 2024 22:20:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, Laura Nao <laura.nao@collabora.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12456961.O9o76ZdvQC@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12456961.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2024 20:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v3] thermal: core: Do not fail cdev registration because of invalid initial state
> 
> It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling
> device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> to fail probing on some systems which turns out to be due to the _FST
> control method returning an invalid value until _FSL is first evaluated
> for the given fan.  If this happens, the .get_cur_state() cooling device
> callback returns an error and __thermal_cooling_device_register() fails
> as uses that callback after commit 31a0fa0019b0.
> 
> Arguably, _FST should not return an invalid value even if it is
> evaluated before _FSL, so this may be regarded as a platform firmware
> issue, but at the same time it is not a good enough reason for failing
> the cooling device registration where the initial cooling device state
> is only needed to initialize a thermal debug facility.
> 
> Accordingly, modify __thermal_cooling_device_register() to avoid
> calling thermal_debug_cdev_add() instead of returning an error if the
> initial .get_cur_state() callback invocation fails.
> 
> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
> Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


