Return-Path: <linux-pm+bounces-6778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4241E8ACB25
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE403B23164
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C0146A60;
	Mon, 22 Apr 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9CpuyAd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957CD1465BC
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782691; cv=none; b=nWmxuUbybCpy11SvedC2CGJBsbI/KgDT5HvrqRdLRTa1LI6AnrKXAvGmwF9PcTGIblybi+lB6GeekvPAt2J7rwXUATztAbqN4UmvuU1+8PuEsczoWXNy/DSq7NbpiyafjEMLX8TrOV4s8eq7MNPMqZNx3smZpKLnnveD9Z64AEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782691; c=relaxed/simple;
	bh=bzcewTEZp8Wbd6KSaSgbrbH+qvbZxzp23uj9WiUjdUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrNUhTdeQD2d8HdvrPjKXVkOM7RQtCb9+p2QhYDXLWTlTUCxouC5gX2W41xIO6BKxyqA6B9cs/1iuzkdbsISXAI8TscYSQbKUP8C5PrMJcYjoy7enHGUNr80teaeqb8x5MMnsU+isoybc/XwSsFpp9t2r/qhuqL3Iek04mDFto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9CpuyAd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-417e327773cso28600875e9.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713782688; x=1714387488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wR97KP7K22vcCUiLNn0X4KfDnNwelS8JUEnq9UX2UNk=;
        b=m9CpuyAdmtDXEQV035cywFXV5WJmesQilOXrkjzBZmTJHssq+aOYgtu19zy8X+uVfJ
         f1Wi6YKaP+aSgMSmeORYODqY08dcXSaRf3TNxBzDYQQsyLQMzdRJIuhNKccNmIVaEgrY
         EVD++Co14+VZzs+9yQdsvwiIg5qgBADxvhbklx6DtKP3fqEcG56HyWZ6a2mw3S6BU2oi
         Rjd2WU6IyGe5OxWS9UrqQ3Su0QtuCAllP4gkXM2DZAT5BnOksBJ0v2pENzySrVeKMsFX
         +xod4kFoLOFOPIxiUn1hQp0n4GSuF01N1hTjqsfVFJ4KCqSXNjPOAjlOe7B1TvGkwpw+
         4wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782688; x=1714387488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wR97KP7K22vcCUiLNn0X4KfDnNwelS8JUEnq9UX2UNk=;
        b=wVOB07Vd7+s2RpUnvz+bbRd43uFRWHRDFYkZxTTxmW8xtlm0DPYhsKtWusqDgZDHQB
         EkbLxrzCgLBVMRJ5b6FDlP/2YLuZpszGTPWEfoDYQN+gSuWCnKHUZ74vdG4d6kstnHEB
         1RXS99U14txqtDtC+xHG3jaW1tKIGHXGoPvEUxlrAlIibiYnOItVWPnQMZr4leajeYS3
         oJuK3mknvY6dDY+bcBW3Uhdh0V8Sycgc+P1nFiwa82eOHlSgq6HLSx/6tlV8evT0nxOW
         clJ2h8MhbqHH3bfLsCODZ1XbWcHikTJVxP7EZk/cyHdBwvqC35Y4Cjp8qWdEsJDN2uyC
         co7g==
X-Forwarded-Encrypted: i=1; AJvYcCXcaUxZSMuPF+eJsm/5tJyiGatA30LBAAW1uCxr+c+Wh909R/egy4HngTFQy0Q/x9xuUbiHSiTQDvYIvkJKPotI70HXy4MhIn4=
X-Gm-Message-State: AOJu0YwgF3PkoiVzI7epOv6ghNj2aeYe9juFITwpOEWuVvF2a1afnadi
	dCVvCUI+7302HhtKcLCS65PcHr2ii5CEC2ZwrzkWz8l06/MamhehtVyavkWPiU4=
X-Google-Smtp-Source: AGHT+IHEVYgt9vgZzUvOGj9DvGZzF9NFHN00yyy4hZi+7IPr9wmffeRfEUo3Gjiacp8SiOwFg51jtg==
X-Received: by 2002:adf:ec0a:0:b0:34a:eb4e:2633 with SMTP id x10-20020adfec0a000000b0034aeb4e2633mr2464786wrn.10.1713782687876;
        Mon, 22 Apr 2024 03:44:47 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g30-20020adfa49e000000b00343f662327bsm11845256wrb.77.2024.04.22.03.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 03:44:47 -0700 (PDT)
Message-ID: <5020e895-2810-4895-9f1f-9e15f7cec357@linaro.org>
Date: Mon, 22 Apr 2024 12:44:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] thermal: rcar_gen3: Use temperature approximation
 from datasheet
Content-Language: en-US
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-renesas-soc@vger.kernel.org
References: <20240327133013.3982199-1-niklas.soderlund+renesas@ragnatech.se>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240327133013.3982199-1-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/03/2024 14:30, Niklas Söderlund wrote:
> Hello,
> 
> When the driver was first added the temperature approximation was
> reversed engineered from an out-of-tree driver as the datasheets of the
> time did not contain this information. Recent datasheets, both Gen3 and
> Gen4, now contains this information.
> 
> This series changes the temperature approximation formula to match
> what's described in the datasheets. It has been tested on both Gen3 and
> Gen4 with minimal changes in temperatures reported.
> 
> Patch 1 is a cleanup making the scope of a constant more clear. Patch
> 2 is the real work changing the approximation formula.
> 
> Compared to v1 patch 3/3 have been squashed intro v2 patch 2/2. This is
> due to a suggestion from Geert where the precision in approximation
> could be increased while removing the need for the changed done in v1
> 3/3, thanks Geert!
> 
> See individual patches for detailed changelog.

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


