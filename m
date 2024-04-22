Return-Path: <linux-pm+bounces-6821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5AD8AD19C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 18:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C23B22C16
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D232153566;
	Mon, 22 Apr 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvPQGwEr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724315357B
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802348; cv=none; b=tfxDWhdsIU3pGpCjz5iu0BoYJoDQ1CgY2w9+LeUttIMiZ47LJvtWlZOJTD7pwELLAr6Ub19mF6zxSsNouRkng1HyJJ6zoi7Bt9L08/5gdk0/tL965/J1Tioov8fSNTIgq0aGJmpUAgkxp2vc80p1w+n8nx3T6oguW7LG1TBcc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802348; c=relaxed/simple;
	bh=pyespoIenYOvwr+vFAWDKTKpySEFKhKzEmeVBB6ayjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7+h+58kMiMA9T1FTz2mjBRWIoSxDlUqEdKQgcqcgnd9vopgZYW62pEqfAqbNKiiCYxllWKBy+LpxsIFHtQhXamJbK3/MnZDo7NPglPkyW1FJfVvem9O9QzFMjPPUo9DdC+z9FnVXOH+ksGbRsYpAn8tidVpatWtkKEHJm4cj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvPQGwEr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-418c2bf2f55so31283085e9.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713802345; x=1714407145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnFFhvINgBkGoeGxt72lLRxIj0jus3I5w0uDFrtanEw=;
        b=gvPQGwErFwllCkbn3pU4ylHAktTYu3QKFDkqJT/+hHGLEgFPUxS/nPxMXCuhS6pILp
         o4z5UHtjnhaT8G9kdcaHEq583d1OgaqoTit0w3t4kzCFF3tq3NyCuZRkIo57EmPIDVcn
         OUzDG5WecjuzyvO6WnpDVU3COv/rNFRiGFS+1rpdYyYPZYcNrDLlweiX8olkJWbDaYR4
         KPUOr1V33UWn+2MxNz96gQWrbw6Ej7qXhXm4eewwxTEiSRAk107q06gVs9NMVa5Q+VEr
         6u/5grM9tzGlrEk76WQROD1v8ToIVdoP50c1jeUP4SFfANIuHmjLsua2vx3tnRAFKKh5
         0SlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713802345; x=1714407145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnFFhvINgBkGoeGxt72lLRxIj0jus3I5w0uDFrtanEw=;
        b=neIetN2WRk1jlW0jZ65gaxth6AZQfxqzb7HWrzkFsSgcWUCvh9rl7zNbFP005K0wOZ
         ORqLuwwVbKkiZqpj3TkvSodM238rw9i0F6qMdxQRq8HJN+qyyXuHcNmTo8T+dDVfNapT
         labnDA6lrRgRLokaOAzZ8jpV/xfuHZRosRQ2FKx86xjrbHALWl9qCjyg2vtelHLqBulG
         z6VvqcnEksw/jtHzI45M3UZ0Ldc6z63GuswKUxBfNRHVObHInbD/yiQdB+aGEGnbEqyA
         Q2B3VDxFJIIt6Gwo/TqLzIDodyKnykeCw/6ad6xma2a36Q7PsIVCmDa40dfkIEgvee83
         kq0A==
X-Forwarded-Encrypted: i=1; AJvYcCXunXCctvWFYAg1I1KoLFkWZpft8u9mPpPdylMYBKisFzlESQ2EYtYPokQ/GVa8EfZwpoU2v6klQHaL/TI//FnPlCDBmWL+dQo=
X-Gm-Message-State: AOJu0Yzd4eqGqqHdlijxxEiM9i0cdP4dQPCzVjJ/BKgM74Tog7+0mzjS
	fFngECCSS1zLZdruDJtqDbBbdD0iOQ5G7AuhfQRk5V0poQ4seXAYnkD/Kv7ZJQQ=
X-Google-Smtp-Source: AGHT+IHr5ZN8Vuq2/rI8TUkOzEMqB0i773L+TnbVRnQcQznM1VMn2gKZ7tsYNkoxi+P2H8/Ew24caA==
X-Received: by 2002:a05:600c:1547:b0:418:e08c:817 with SMTP id f7-20020a05600c154700b00418e08c0817mr7012270wmg.32.1713802344362;
        Mon, 22 Apr 2024 09:12:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v3-20020adfa1c3000000b0034b61423d54sm22412wrv.106.2024.04.22.09.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 09:12:24 -0700 (PDT)
Message-ID: <2acea3c3-5c8f-4f3c-a275-743c3fbfd2e6@linaro.org>
Date: Mon, 22 Apr 2024 18:12:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] thermal/debugfs: Fix and clean up trip point
 statistics updates
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <4918025.31r3eYUQgx@kreacher>
 <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
 <e8193798-4c02-423a-a9d8-63d29ebd7faa@linaro.org>
 <CAJZ5v0i2pvTLwj7jTzwhoQMap_cvjvNnK2Beuje2COo+F4hBzA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0i2pvTLwj7jTzwhoQMap_cvjvNnK2Beuje2COo+F4hBzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/04/2024 17:48, Rafael J. Wysocki wrote:
> On Mon, Apr 22, 2024 at 5:34 PM Daniel Lezcano

[ ... ]

>> or we should expect at least the residency to be showed even if the
>> mitigation state is not closed ?
> 
> Well, in fact the device has already been in that state for some time
> and the mitigation can continue for a while.

Yes, but when to update the residency time ?

When we cross a trip point point ?

or

When we read the information ?

The former is what we are currently doing AFAIR and the latter must add 
the delta between the last update and the current time for the current 
state, right ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


