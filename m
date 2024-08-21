Return-Path: <linux-pm+bounces-12642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1185959E94
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 15:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228F6B20BFC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3519994C;
	Wed, 21 Aug 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBH/N9EF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8D18991D
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246753; cv=none; b=vFMjzkADirnrXEkvp+I47oYQjh6JmN4DZEtnMQwyL2eePL5mMhc/CVlhENYwejJR3VHgNMUwj4yzWWezf6NCLeKgznWN+4SLDQDc1jQ3WgbB4qZvD1mTT7B+0zw6/45QIjnqrW80cx7oElPGflufeZ43Z8AJnKFjiipc87xFK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246753; c=relaxed/simple;
	bh=EFsAtmpxBfkmqyoFEOCZFst//LhOUbhdQqC3QFQdw/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGrEck/NKfBL0KnC9WPr8OKaCikyxk9hVGP45QtFpZKTFmBcPFfBikB5/jAc5MK/bu7IvHuWSGUch6SX1X56v4OAC0pV/fFIBvcSBJt/zuUCd94Vw1GL0uFGBK735884CtZDshRMycp0nALuDdnt6XNRudLPhkmYAtU/6KK46bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yBH/N9EF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso53187025e9.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724246750; x=1724851550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjLi/KAAI/PKbdExf+68AXZG/A3FesNOUEX4xlJJoCk=;
        b=yBH/N9EF5/M+vlQ/u9DoD8PdEfzIm5mX4tjyfFN/Wo8N5H/bBPk4pINFZyXAWzfaEk
         jRHYK2n0iJz7PWNLKXHGvVcqNTMItY5jmCQFk0fcCgNNt9dihGqXfI95gfG8kQncVB+D
         +yFCiR7OnuQ8jF1M11aPAcEk89P8C8Zm+XGSUTHnN5IBjF0aRcwkuG2fR1IKhigE/tiF
         MrgWAB8GN9e5Lc6qnq5V+XBvoXtgepzQkLDH5PKt6ikYxkraRXV7Ng2Vcytq79aYnjWl
         zzUVMZPukF4z7FuYtnvFcF8Fe8Qzh8dPWZxO/yzeC2R9oXV+rhOyXYEmpbGuFpELfkEo
         NRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246750; x=1724851550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjLi/KAAI/PKbdExf+68AXZG/A3FesNOUEX4xlJJoCk=;
        b=R9TRX4HocSsHS1Ib7LLMegIBK1lvVqcNa+ynmqXvuk0StLJ3N6t/ncn/xMIlncOBeN
         hq+XxW6TKVxRA8Tm0JwvYHwcUCbn5cJTTx1NTx7R7/cZpMe55/AzdOzru7EMDcO+zSKN
         9KW/qJ26h80eWuQ3uKPvI8u+qcW3u6zN1pgCeczhEosk11tsurXOdUx/sAnba9KPssyi
         5PKI1uz0VaSbpLnH4xMUl3caOG0oeKj7azJMMhGZzls9YpILCGru3o0BnDKBjHlWaL68
         FNgN3I+LGiM+TlHHgfalTQmsIWslSZDiD4DC52IZ/h8z45zGVKQzw3YwKo1SNdx6hNKn
         eetQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZgCDE78w287OH98qxx3Onb6tMiODNyBKwk1zHgd0UJVwP8RWCXKIQnAKXIRfAVyCv1veUwrxmlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygMbn2wMRnpbjmpKSzgSVpQAkhpQk4mYO7xwL7wI/42fS+jTU1
	eONtGcQ5iaZEWZHI7dfBImLtUNxHaeW6QF1/oy3TwWRxOzY0Rq4QOkiOUF03gR8=
X-Google-Smtp-Source: AGHT+IECv4c7UUWm/smcJlWte8h7hndViQz7hioIczt5zHH/4DxCO4/6bfIo2S3t25go5OUkcOOT5Q==
X-Received: by 2002:a05:600c:3c84:b0:421:7aa1:435 with SMTP id 5b1f17b1804b1-42abd25dcb1mr16347945e9.25.1724246749515;
        Wed, 21 Aug 2024 06:25:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718985a347sm15750551f8f.60.2024.08.21.06.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:25:48 -0700 (PDT)
Message-ID: <43c8dade-4b6e-426b-bde7-769b50383145@linaro.org>
Date: Wed, 21 Aug 2024 15:25:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Peter Kaestle <peter@piie.net>, platform-driver-x86@vger.kernel.org
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3779411.MHq7AAxBmi@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3779411.MHq7AAxBmi@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the acerhdf driver use the .should_bind() thermal zone
> callback to provide the thermal core with the information on whether or
> not to bind the given cooling device to the given trip point in the
> given thermal zone.  If it returns 'true', the thermal core will bind
> the cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> The previously existing acerhdf_bind() function bound cooling devices
> to thermal trip point 0 only, so the new callback needs to return 'true'
> for trip point 0.  However, it is straightforward to observe that trip
> point 0 is an active trip point and the only other trip point in the
> driver's thermal zone is a critical one, so it is sufficient to return
> 'true' from that callback if the type of the given trip point is
> THERMAL_TRIP_ACTIVE.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

