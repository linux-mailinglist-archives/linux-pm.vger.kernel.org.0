Return-Path: <linux-pm+bounces-12924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1449600C5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 07:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFEA1F22BD3
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 05:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D4131A89;
	Tue, 27 Aug 2024 05:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPg11gFe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DF4C92;
	Tue, 27 Aug 2024 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735051; cv=none; b=s6h4CJrbuExsIRWaIy430yO0giaka1do3IHTl2G89lpV1eOvYmoZ62icXBFQHEM+rpzC8bF6CVfo44ig4XkaK7I7aZ0Dp+5O2Ju88sOeave7h5UkOie4OuzR1I+iWGXqbMNmtJWLp/5vIhOs0EEDNPlSwXsSG0mmXHWIxTDIfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735051; c=relaxed/simple;
	bh=GO0zNOW/uhkO9YPbWUQ7p2nEfAJZKu25c78aYjvnEXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5g93hrUFViIJ9Y6RZFXQp1Cmq1CR9AZ7VUbsMu3JEFVjHOBEL87kgn40m7l3kW2cJQ0PubYpivBtz39iioUTyCh3Jj+Fb8lrCDCOb91p7VTYvyGZDeuB06vjPLSvH6ziLnBhOovLGHeDHBNZ4SZjY/CAMuT09bmdmK8JPxyeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPg11gFe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2020ac89cabso45033085ad.1;
        Mon, 26 Aug 2024 22:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724735049; x=1725339849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pS15vPEb/TE1/EitqKs+W/XYfjN7muJ2TfqmqJCODDk=;
        b=FPg11gFej/wmvaQYP+Mnnxn7wXxtw8yGC1ue6iVTDVg3AFpKkwi5RzFpuQxeuN+GEw
         VXp0/uiGWZDueVH0F+Ed9lHlMp5ZaznnGZreoeK5puuq99PM/Egg/P7IenqPHCe8Hk6s
         Fx8NTswrBu5j9XE/W51rNaYej2xjtPtVzNoE65GxEkbjNxhBxou52PKViVDQwb1Pi5fx
         x5GjpFfUD7eR3mLqDn3PRknKwjr3YMwIjbscoqx4ycobSSvfv4y0Z/LtcgtxrYX2vFhM
         P7+l6JC84O2VkV6cXOHT4ljKOc9wQ6seo0/X8/gRoJwoijsIa/XrWh8OD57kgfGzq8cP
         5J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724735049; x=1725339849;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pS15vPEb/TE1/EitqKs+W/XYfjN7muJ2TfqmqJCODDk=;
        b=uaAP3k8eiTwOsUwa65lj66XM8Jh2SkZ6QRuglpzxTafA7Uz5Y/vjEQSv6VD360lOwB
         Ftv7fzJ1eeJFqRvkDyJHALcw4/bSjGCh1Mph5eYg/SihzEMhmnyrQnZ2fAXBaj48/e7d
         ZbGrB272ChEfwlVFgi8x8903dQFrbiTdPcF2ycgVnYzXKiFhm6DTRK3kK3PqCmZP5krA
         X3xLLUQw0ARl+CBPwHxD78EXcod9v9I5SsV6lcd2VNIckZWLxVcbs+MBp5yqFKt3CtaA
         n1ahAhrzaO/RBmyq6wty4QGCHJbcIoS0Nrp6ZtlOEaYlFAaVi46jUv+1Ms3rbR5ZnQHh
         hYvw==
X-Forwarded-Encrypted: i=1; AJvYcCU6LD0KOS2/Xs8pgUzQ2+JKiHMPvnD3TcF1+H/TIsM8ADmMnE/6O+C+ngE4dpbhT5oKqsHYLxEvsuM=@vger.kernel.org, AJvYcCVdVO/K5fzTTr0yF6DJ3bi7A1zERlGGblYQa72cJU77UbnTz+Tifzc1+Z1EgD7Iccpr16monMIj8VGdhWlB@vger.kernel.org, AJvYcCW42uNGLJ6Xq2vnKWvEQ0bOO3SHQq5gP5lHIEFC3sQs30Ky83+OuhkPKn+m2+pHvDFw1x7SuN+W8iE=@vger.kernel.org, AJvYcCXyPdeTqHSedKEqqgU8wzBVda85P907D4zofBXJesqeIh81O+w5nQxx1EQkgEBWoT1Y9rDPrzBPwxdl5avKz18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMuRag1hlhqF+80gU1gH2CMzZCvNxaM2SGzUQ+PpnQlBBKUw1w
	ZE92C7bBtVZB1n4Ek28QtCiXp25MG60ejiTP9xQ5+0esZ87nEdLT
X-Google-Smtp-Source: AGHT+IHYMlAJ7cseyBWWV3t9xPn+jhmKSnw0GVJdJSMZSjCeZH9bI3KDUJ3ytLkyMDvyWzQWl2op4Q==
X-Received: by 2002:a17:902:ec83:b0:202:883:bef with SMTP id d9443c01a7336-2039e4ab20bmr100966045ad.30.1724735049361;
        Mon, 26 Aug 2024 22:04:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbf57sm75480025ad.147.2024.08.26.22.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 22:04:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ee11fea3-3e77-4870-837a-ef6147ac2bf0@roeck-us.net>
Date: Mon, 26 Aug 2024 22:04:06 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in
 the restart handler
To: Claudiu <claudiu.beznea@tuxon.dev>, geert+renesas@glider.be,
 mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org,
 ulf.hansson@linaro.org
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
 <20240826152529.2080248-4-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240826152529.2080248-4-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 08:25, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> On RZ/G3S the watchdog can be part of a software-controlled PM domain. In
> this case, the watchdog device need to be powered on in
> struct watchdog_ops::restart API. This can be done though
> pm_runtime_resume_and_get() API if the watchdog PM domain and watchdog
> device are marked as IRQ safe. We mark the watchdog PM domain as IRQ safe
> with GENPD_FLAG_IRQ_SAFE when the watchdog PM domain is registered and the
> watchdog device though pm_runtime_irq_safe().
> 
> Before commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") pm_runtime_get_sync() was used in watchdog restart handler
> (which is similar to pm_runtime_resume_and_get() except the later one
> handles the runtime resume errors).
> 
> Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") dropped the pm_runtime_get_sync() and replaced it with
> clk_prepare_enable() to avoid invalid wait context due to genpd_lock()
> in genpd_runtime_resume() being called from atomic context. But
> clk_prepare_enable() doesn't fit for this either (as reported by
> Ulf Hansson) as clk_prepare() can also sleep (it just not throw invalid
> wait context warning as it is not written for this).
> 
> Because the watchdog device is marked now as IRQ safe (though this patch)
> the irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() returns
> 1 for devices not registering an IRQ safe PM domain for watchdog (as the
> watchdog device is IRQ safe, PM domain is not and watchdog PM domain is
> always-on), this being the case of RZ/G2 devices that uses this driver,
> we can now drop also the clk_prepare_enable() calls in restart handler and
> rely on pm_runtime_resume_and_get().
> 
> Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in
> watchdog restart handler.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>


