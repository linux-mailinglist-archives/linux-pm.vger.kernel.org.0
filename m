Return-Path: <linux-pm+bounces-12604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60C0959670
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 10:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1530A1C214B7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3A15C139;
	Wed, 21 Aug 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsuvvHzz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD11C4EF8
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227028; cv=none; b=i9QvadNSYyf3bByudxacIYQM9IR/irZouekklIaru9jKyOt4L+mOGt/e7WQ5aV4cTp89tv2YYpwevPnLyTQIMIWhuhW8p51ej4RasyaAGIOOdmwNrI98TryquJ1wUzDLVy441FUsnml8aT0j9puciZ7FKcwIz+eFiEr08wKJOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227028; c=relaxed/simple;
	bh=I+Sk7rzN6bKZfOhoWqfhZTQXFrwxODAV7Zj+f+VxKuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Crg7Kt2+/Qv2I2c4HMd9hVgmhUWAONqw7EZykWRMvK3c88psjT2SAFMVFVSJyb/eo+paKbXVI6sHsEAWoRY24XylTskIX4XjznHxaGFRYG7wDvGlV0SKFYobhZn0NaUrukz7+afjpUIWpk3GEGJY0lNVK45WXPeWCsRfClKHgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NsuvvHzz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37186c2278bso264080f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724227025; x=1724831825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hHhuCWz2yguQ8Cont7KNQfFc4rp2L7+lsdkVawErtQ=;
        b=NsuvvHzznKv3/M/nmDNznOLH3C+NKUbBFZdRB+8PVqgcKYbBnYZ/I4k68mom+X/iDx
         1F4okAqe+MkJ1ooFPBLU08jKq2j9GTzhvwUGQhpqLs/AD06iXdUTTenjY7XwXFpmmrfG
         lxhge4wmgTkYIJu5/lkho0X0qezOMcw/smH2Xi1WyTTfT9kqvKUnE6drsoOZy+U8kiVD
         9YxFLJsk4MtdGkZ5leizggmOaWIUEzS/f35Zrvko+hpkiDGpX3goir5SENUHZkMYI15V
         YCowJpRbE2beNgVT/fR0QJaVg4VeYLbgdzhwcV8idbk6zDQHOs17felj5Mp1EIzh0jz9
         iovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724227025; x=1724831825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hHhuCWz2yguQ8Cont7KNQfFc4rp2L7+lsdkVawErtQ=;
        b=d+7BtpBX4q145btEWg7GZtDujGqM1o+H0ZHJrznCPjjqIxTze+iDrLCiWJfV60l5C6
         cZYkKZ7Ys3CTp91AlGZIoSf7vXziSJAYkn+zmI73kCxiaMMTG3DZ4TCK7ATYleRwd99U
         OS6f4Ovu9W7RHwTs7YH6O8gBOOYeKFojYCub4neuVwanTKdFtqqnpl1uwxg0vbLprwFG
         vrRSJ0/9S2S2t8dySC+Njl3cs32JbEIUQbp/Z6ACKApdkgYFVA6+lVEO1b2oFjq4HOrD
         QhpGzhEFrH1vBF/BE1W4dqm5Eqj/y9jpFaqWYEDTx60w4I+whzZ9BTxY1tmhuCc+74u2
         mo7w==
X-Forwarded-Encrypted: i=1; AJvYcCWLO4XSPejdy3e5U70RxB0WDbT/4zkAfr4xZAgsJ/l4m8pUlQkQoVuZ/FM3D15pTJLA+5s08dE59g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5EepMfiC0NS5/kHWnnQQlXy6aoAqLrxRIZ2Bt0dveULBMJxHv
	5/c9Tl/WVjD9Z9rqznwCneTdw503J6qPRhgLVole3HFBc5b7R8eqwZ/SSIzKgdU=
X-Google-Smtp-Source: AGHT+IEyvnU1ZsLtBik2T1MKLIyDtzHAUvyEpY5Q5iToTp/S21Ph4wAq81S0hl+3j/S/baOB2ggvbg==
X-Received: by 2002:adf:e748:0:b0:367:8e52:3bb9 with SMTP id ffacd0b85a97d-372fde0fd4fmr658417f8f.22.1724227024479;
        Wed, 21 Aug 2024 00:57:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37195650163sm12963684f8f.98.2024.08.21.00.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 00:57:04 -0700 (PDT)
Message-ID: <6d7cce54-f22d-4810-b13d-68061eaea5b4@linaro.org>
Date: Wed, 21 Aug 2024 09:57:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] thermal: core: Fold two functions into their
 respective callers
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <2962184.e9J7NaK4W3@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2962184.e9J7NaK4W3@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 17:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold bind_cdev() into __thermal_cooling_device_register() and bind_tz()
> into thermal_zone_device_register_with_trips() to reduce code bloat and
> make it somewhat easier to follow the code flow.

I don't fully agree with the description but anyway I understand it will 
be more relevant with the next changes

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

