Return-Path: <linux-pm+bounces-33325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E9DB3AA69
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 20:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BC41C2580B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB36D3128C8;
	Thu, 28 Aug 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QOZcbAzl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A152E1C78
	for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407225; cv=none; b=cv2yw3LxdTSbgX2Zk4GVbxeQC85jf43cX8R2a+K7lytftgmN/yuVe1z8AgrmbSK7pHrJeLbT68Wx+lCv1x/qK2kdvekNCIg8mjrEar/sF8RwT8J1eOwK2pie1GAYlyGPhaNZU4q+ujPKXRdBAp1mn3Q/HNjPI98uKmxLxg+truI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407225; c=relaxed/simple;
	bh=FQ1rdKGi9R94HCP+YGbh7p78J9PEq/G/b/AdDFMY+jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rptFtGZx9PP2BcObYhrqgeDvnu1NQdY+OVhbZiEE36p9JqY7l997QmVccSzBQdWa/ocPGfKQunJ5z/VXAX5PtU+jhXG9wuZod5K6mu5i64NGvQ/N/6lhvlc+dq4yzrZ9UJkKmBZBZo2Q8OzrwdKZWJ9JTwpyq4XxAgv/L/Ak/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QOZcbAzl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7c01a708so3747265e9.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756407221; x=1757012021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQxssGI+raI+XkRI8ea9mGLdtxL/7Ytn0lgOA6dMPAE=;
        b=QOZcbAzlqtiDVq0p0SK2wIYjMIrVjLkDoxQG9YQq0g3CVrOpaPI2SAOa8YMr/u5uSx
         qoXS7ucnnv4z7nBLgs05zJ2+o8cggQXg0mWMCV3bV/UbqPIuiz8/+sEHQUMFdNZhxCPu
         NTfriGwrOQ7TmTthVIA2jz0BEKyCWT7QF+wIwziliqiDFhHKQlE2/kYSaK7TEL5nfSZV
         6GEArmB32Q4qiuOk5I5keQqcEjcmeCemI+XbvM54DtUDzRvcvqAUS417eQkX4frwmCM7
         JP+ZZBqVLq2JyEH4MS242ODQQ+1QPjEtYMpX5TygGzdcbs80AkNkx9dtIhdDkwBFDNC4
         5T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407221; x=1757012021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQxssGI+raI+XkRI8ea9mGLdtxL/7Ytn0lgOA6dMPAE=;
        b=WpVSXsyH1vrBc8mPdlzXtShWBR1SyZA29XDqLATJ71e57ebspeCeXLkeNF3oOfIWop
         PIkJ52lLgBeCsMSBiqMTuJbyLY4tLZ+sZTMFyLccr4Jmz0cMgZSLSedwx65wGj4UWrJY
         9FUZy2mZ90chQcKTH/b4yhy879HbK5/y6BesZ7mjBq/Et3o5G4LQqLNnsgke/e1AleSX
         WdZ6mbZF76mgZrL1NMNBVXkqXi+dEB9l8succbgE1ow0apjqMDwr1emcgifum5dA5oIZ
         0djmwQu+xKcXVdFV2fhixEWd1QaG4FIm6oD7+AWXRDzUZnMmwGNm7GJi7AZ0IlCe08M7
         r1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWSmOEvptqwJ+JjHoNULdmdPmzJLz/cZWD9LlokQHm23lc5SXPV/zZpzpNKhEyWtHYwc/ThvvijEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKDiXRi8ZWI6nS2OOxqDhJWZFPJm6TPfSpKTSZlsc+UgfRyWte
	s46neTuEMV9mRY0FsNTNd3E4J78Q0TZ0yDPAd/QuPdVsRYLIMpaMBwafk9htkLNkMcU=
X-Gm-Gg: ASbGncuGAtM+K2s0UUrmj3Jag94sZsL0NCOLrCYIxe+zxOb6AsU1lahgEp8oJ5y/sV8
	bD8ftQOi8brR+AuEEOMxZV0JG0GDFmWXEewtNJbOh9GhPvtPSo04EkfmB+3NDpM/4v+82yWb/vh
	J8+sm2DiZkzL4kMoj+n01w4ujUtuZ1l5oEU+pJkSVNgzpdcRBkFNdu1uYs0CIMREtozeusA0RoS
	DQrNdR6GVnVGsAeimZ/mPQygrfWo9p9sDCy9SbEjqsFe0HR4l8l0tCHrKEYxltxqpO9nbplnB+p
	QU4a0wJyxaI6YMzgt8gJ39rxGjG+052KbR5ZNl5RGuNCVyjIZKWojcWfz09Z7T1tfcOS5TTUkPx
	PLryvw3o/4G8PIG/p1KTlEnjpbqMNXpmcT/FklU5zXEgAG/kq7Pu8fOEuKDiJ0G5JOSA49QDr8y
	JMSA==
X-Google-Smtp-Source: AGHT+IEsQ4LuJqJJ8bLH2sEiTn/a4xu8JBjHjhH5JH9gsrlNMbO4Yfh55Kjm7XpwgoiSOdsGhAur2g==
X-Received: by 2002:a05:600c:46ca:b0:45b:7c54:7518 with SMTP id 5b1f17b1804b1-45b7c5475a5mr21923185e9.13.1756407221350;
        Thu, 28 Aug 2025 11:53:41 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6103:4200:a4c6:4e84:e72c:19fd? ([2a02:2f04:6103:4200:a4c6:4e84:e72c:19fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm85978075e9.14.2025.08.28.11.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 11:53:40 -0700 (PDT)
Message-ID: <a27c5e51-14ab-4f6c-8da7-3733c1c89abb@tuxon.dev>
Date: Thu, 28 Aug 2025 21:53:39 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] thermal: renesas: Add support for RZ/G3S
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 niklas.soderlund@ragnatech.se,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
 <aLAWLZBenSWWqqkK@shikoro>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aLAWLZBenSWWqqkK@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Wolfram,

On 8/28/25 11:41, Wolfram Sang wrote:
> On Sun, Aug 10, 2025 at 03:21:21PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hi,
>>
>> This series adds thermal support for the Renesas RZ/G3S SoC.
>>
>> Series is organized as follows:
>> - patches 1-2/4:	add thermal support for RZ/G3S
>> - patches 3-4/5:	add device tree support
>>
>> Merge strategy, if any:
>> - patches 1-2/4 can go through the thermal tree
>> - patches 3-4/4 can go through the Renesas tree
> 
> Series applies fine; I can read the temp (36°) which increases
> reasonably over time (40°).
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you for checking it,
Claudiu

