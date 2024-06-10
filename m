Return-Path: <linux-pm+bounces-8873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69C9022A8
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 15:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE8D1C20839
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDBE82495;
	Mon, 10 Jun 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZOmxgHm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC374048
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026039; cv=none; b=iFZkO5N85wdI3kcMOY7nTWbLXiJl+c2tmC0BbUr0vdFIocr1WghYru4D/P/id0ARlNLW2BKggZX2QPyrvTXTf6fM5s8HICwyD01TmOtChHS6X7oJBuBFtrXlRItFx06KlUtsxdd34+HljFj8C1/nQw+cx5bLv3vkN+AfsZVf2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026039; c=relaxed/simple;
	bh=tP4cMxiktUOhqc/zUuS5OIvwc0xqblZZPOTX4zoLGuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfI3HRVkFLpRTC6WBOM+stP+CSP0W0hE5mIjlyl4VQ7+yUewPkZCvKEKcz64JHpzL/lFW/RhGFH3atP4IY6/mXjzZTft0s60q6expDR6A3ma0sXUl3fSnu5i6WtGsp439M3hsoHbG9MSxhRJn3viLeRHervemHMpshHI5n2BPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tZOmxgHm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f22d3abf1so1033397f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718026036; x=1718630836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+zykISSn9jNpLz4ChBVpl9zCS8hteHdbqsrW3djfz4=;
        b=tZOmxgHmf4anXdBjkT8YKRH35lYOtxDzP2eTYxpkSqDAO94lccaVRqp+SWhPyYQG+t
         Nhl6c/V68nL3GZswSW4jP3spPu5jOooBJoJyqDXvcT8CI0WIx0uuvdZeZkF3ENhPe3oJ
         RaGkoDjwOQ5D5fFn+8PHrYGjvdNppiyyVntoIL1NX4R50eDhaee1JUDMZvq5uYU7Q0X8
         XzE4mx9rNKMuPSXfVVpGBo10FEiHnyN0gOoKH1oFp4NLXRAqgCM1LUj3L1ms2BNoB8m/
         1gkeip0Lduen1EsyzOusIaqEBAI2yqhB7JSiKAw89HsJzXppxIPZRxwl6EIEVBSWMFJE
         HzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718026036; x=1718630836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+zykISSn9jNpLz4ChBVpl9zCS8hteHdbqsrW3djfz4=;
        b=i9lcIX05vs0V37QzIzNMlK7aQjA6+EImMLRr82UubmtmsTThXJnKXa+gzsWSDsDoTh
         W0En4VFB2zW1zIuw+tUDGPQYua/wscbmZPW3ReDn9zN0eFIQnSr5CT5I6E+q46eJu3v8
         0osuYdqlxUxHDYd6RV3j1PUTIGd3KLxtZmBPY+X/wvtHPSMmqsbAb7XUSDo4QzwlBKOY
         nK28s7KroGa2HxogoBmhvifBwBMOTZHkylGqy7n1ZwSNFJc4ZbnISMQwxWbrq/LvmOKU
         HwqdHsFVh03PXd/OQphtVRQxQ0ytw9g3iutYbghwtX/XSyEAa4iTt/EwIXp1oGAjokhx
         VfEw==
X-Forwarded-Encrypted: i=1; AJvYcCUtL6fe4mOKjzMzbIOkLXJr51Qai+SXkddIc3iW5bQm4fWwZW/OwlSesxVb9o7XtDZ3OAEhlGqtc4NUeaR0qO/Za297rFtVgkk=
X-Gm-Message-State: AOJu0YyeHp8aPVLIz1A4zlbksYJZBFU46u7oZtZ8eGGDAP09Lr45gFx4
	fMM8+rAdQ5Qv1RgabRCIQxEK8lsjx2YVdyTT1ozKQq72Y/w/CYhnc3hIzfKRLa2Fxa7EoRbFu0i
	1
X-Google-Smtp-Source: AGHT+IGcDbFcsNiE9xkJCyhwDgjAPzRcCOM+Tlhvr/7Wgc6AOdwO/N/aHTEyDeDhDZ1AReJuvCtrsQ==
X-Received: by 2002:a05:6000:1f84:b0:35f:204c:889f with SMTP id ffacd0b85a97d-35f204c8bb5mr3672297f8f.56.1718026036220;
        Mon, 10 Jun 2024 06:27:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35f231d5761sm3203497f8f.35.2024.06.10.06.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:27:15 -0700 (PDT)
Message-ID: <d497da6f-adc4-4141-87bf-5b3e2fc0e926@linaro.org>
Date: Mon, 10 Jun 2024 15:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] thermal/debugfs: Move some statements from under
 thermal_dbg->lock
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <22311651.EfDdHjke4D@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <22311651.EfDdHjke4D@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 16:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The tz_dbg local variable assignments in thermal_debug_tz_trip_up(),
> thermal_debug_tz_trip_down(), and thermal_debug_update_trip_stats()
> need not be carried out under thermal_dbg->lock, 

May be explain why ?

> so move them from
> under that lock (to avoid possible future confusion).
> 
> While at it, reorder local variable definitions in
> thermal_debug_tz_trip_up() for more clarity.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


