Return-Path: <linux-pm+bounces-3639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E14F84E358
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 15:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF605281C6A
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEEC78B63;
	Thu,  8 Feb 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFxvUNvN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798A78B75
	for <linux-pm@vger.kernel.org>; Thu,  8 Feb 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403348; cv=none; b=VKcS8dKGVNaaJfX2q/nKAtID+YoMr83jDjsQxFmlWOjsgfJWdfgu0EHVavJvgiJ3jURAwMAKyefipys9nOKtVnzc+Xer0YD0HytL+Mier1tZp1zSVbqRrImf9RqcN0A1qDbYTHHDdHm5NC+wFGAZujkX+jxB7B9gf1GmL3hII3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403348; c=relaxed/simple;
	bh=2gXIrNisH2hKYE3dM+XT24IW2MyW7r93VSxDstBmgLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvhxWA+L+2uTLhLi30lCTxNbrQt7/iA37CK1RibnDv0LZo0kTGFWa/8Z4kFUBEtI7QbWE2/qzXs3rawOu41EBHUk2yuPpBPM7E24FQo62fKbGq3SoQCehBj8gNLIYRTR2CZCrjcLVeF6bQxi+yf/pWK+BWacsotfp5hRvAlNa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jFxvUNvN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5116ec49081so719316e87.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Feb 2024 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707403344; x=1708008144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FI0X9SGfQHVZCt/eUyPJLLykZcfBLBRlY/DY9DXaGCk=;
        b=jFxvUNvN07XdkGTwoyPMmdH8b+6THpuSGxAACSILHbYSaYSBTxbtzB7Ngo1dnQjhFi
         jNUuBAhTByef54yrnTJV8sDRrBzOSIxgV2GvQTEyj5xwVnNBOmKkFjVCcd9pzv+JwIqT
         6mJxGQmP2A+mbABh30uTSK77T79RI0mA1qPmkRr20E2lTiFwzfOG4Qapb5X17F//ItGq
         6NGc3EcBXhfda4DnI9QKQePd4E3Xrg3MQXJbYqFvh169Tf8VaPELNMnPat72RDED6C4k
         OQ43BG4nyeoWwRrySDlSe1JwEkVAZeiocaiBfIM2Z/S8VliRCJRk3+BWP1EhEfLAb5Hd
         +hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707403344; x=1708008144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FI0X9SGfQHVZCt/eUyPJLLykZcfBLBRlY/DY9DXaGCk=;
        b=fgNCYA5SxR/DdyEEr7kNI/rla02XBTw632C0UntMSjCQMAN2cCyoJ1vQVKIuQg52sd
         ESk2dbaM0/vHwzG0sv7EuAfbvZx56cnKwH/cNqCJZ0DsjRrlIpWLG6rjDCiU8AerlI6p
         TuCGVomPwacPqSUIQjANjdoRtbI1yIkGDgSgBB9z+fOYLk9J+a56mdi1ftXdmCJ+SUwf
         /7j/VtB4iFB8UNZSoPrPQrC+TTQS7FCwCS1vOYiDLWrbAPXMfonONwGqhwQoXxJCwAsl
         bWe9k5Hua7gYp6VgWwxfMexvgHhBXipvO5H7B0SkvVF4h44Tbar6hTP0Lh510OQSd2ox
         zIgg==
X-Gm-Message-State: AOJu0YyVSXD8m9jfOeJMvJJNi6Y4n1QVAditTbzCZRd7E3FpvL76E3sR
	ySorYl106+aAb+p26MFtdZZmnEtNgo8N/7rrvMFQr3Bum0OOlshUf4VzF+NMFfc=
X-Google-Smtp-Source: AGHT+IFM+CsES7jSUYs9qU5grm2yAeu8FWGKBN38pfDbLlG0ZK/4bdMOnK2N5Na94svSr8UEgzmtyQ==
X-Received: by 2002:a05:6512:128a:b0:511:2088:df39 with SMTP id u10-20020a056512128a00b005112088df39mr8196198lfs.1.1707403344404;
        Thu, 08 Feb 2024 06:42:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi4YM86Ets8Vg5hFtp/T1sGjJOA+PTt1xOgCDJvoXyqWCN4B6CtooQgZ5IHX/QJjy7PZoQje8XfEDXGmeD2O9vU/Jun/u+30wb1vIJkQ/9knDod2NTNFv0IjwzjllyiRKqHarHkuwq0AYujC0DkBbZfyBKRLT0q6x4N2c3OX8rRj/l5b0ONgKTYTg5LK4HhfG+0uN9XTGNO4UwYczNocQY8dt2VKtRIi9K7JxQILe3bQ==
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bg10-20020a05600c3c8a00b0040fccf7e8easm1827260wmb.36.2024.02.08.06.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 06:42:23 -0800 (PST)
Message-ID: <b068b36a-9964-4d32-bb00-227893f9e47e@linaro.org>
Date: Thu, 8 Feb 2024 15:42:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: sysfs: Make trip hysteresis writable along
 with trip temperature
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <2731410.mvXUDI8C0e@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2731410.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/01/2024 19:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Trip point temperature can be modified via sysfs if
> CONFIG_THERMAL_WRITABLE_TRIPS is enabled and the thermal
> zone creator requested that the given trip be writable
> in the writable trips mask passed to the registration
> function.
> 
> However, trip point hysteresis is treated differently - it is only
> writable if the thermal zone has a .set_trip_hyst() operation defined
> and neither CONFIG_THERMAL_WRITABLE_TRIPS, nor the writable trips mask
> supplied by the zone creator has any bearing on this.  That is
> inconsistent and confusing, and it generally does not meet user
> expectations.
> 
> For this reason, modify create_trip_attrs() to handle trip point
> hysteresis in the same way as trip point temperature, so they both
> are writable at the same time regardless of what trip point operations
> are defined for the thermal zone.
> 
> Link: https://lore.kernel.org/linux-pm/20240106191502.29126-1-quic_manafm@quicinc.com
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


