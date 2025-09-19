Return-Path: <linux-pm+bounces-35052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB98B8A76C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C98A1C8439D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C1E320CCD;
	Fri, 19 Sep 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDhgMlHZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7C320CCA
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297521; cv=none; b=ioxAJqPuSC71/AfXJR7jaQh6DqfzTInhZrAv04tRNmjYJrM/OCfmwRwN6ABax0flp0pMpRCAWj8CqaEFip83h0B35bqxg/fQkdenPydPPMF5VZOlQBySFpscjgwOLv5NjgSAKSp5fh6GRF+H07jM54zNj9T21QOybTl53qifbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297521; c=relaxed/simple;
	bh=t3P2GEOcwivP3t6/urkttM5U23eccg5yH/vgb1kPN6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgmxcJ/VDlG1Z+sAN1awpDpO11efUT4Iw+cVXtpVXCJg1QCCKOkLiL+7tWSh0RdgXQ2duHhD/AADGxcaQ7aguFV815GiVCYewHhwKXSttWhcFDjsMo3Y4UW4PdB5m3Akr8R1FIfWiQZpSvbLTwrQxwvMdi0CujCuGsq/DIxYjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDhgMlHZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so14714845e9.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297517; x=1758902317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnqHCvU7rGwJGGO0ESYLZHhX3MxXPvdCUBjgSC9Fnxk=;
        b=WDhgMlHZ/7SIcNS/sdeAzbLsJdC9l9L2i1QStGYhztxbV8frEod+OeF6hbWIsLPjcn
         wNEU/rWo6fAtDwumz4JfIxza7Vk2a6cAV28/zdrh+93EXxPWnjTdKqAOW2MS0o5tDsbK
         3jEiWFZMAh0eoMhs5dL6w8CIBseTEtY3OPmSRTtQZYy8fC0aQ3Z5lJEQ+babT58AmCQ5
         /XKcd9I/iwotj+HzjmvBU+ToDTtvJ6Iii0aRoCnhCVsge33I3uCREXO1VcqXCKgIOCFU
         z+5gtlMO+PkQFWnjdSQBDZ9dXgLmW4rg/uafOmVsB700oQMA0RtCoHX6+mTdwA8mKRtK
         LVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297517; x=1758902317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnqHCvU7rGwJGGO0ESYLZHhX3MxXPvdCUBjgSC9Fnxk=;
        b=E+KML4BYcmeoiUILvTmBlFk4vfaCwKYkW3oPEtkmQpHtnP3bcC7H2Kh9gHnn2uovx6
         F+mt0J+3pH1Jhjj+5TaZckbq3rVLNV6Mx3gewNowiNQv7rG+yLZf11vW7Rx2BQV2K6lx
         geSehe4UnyuQ/eUgauxJbwVVSwWvtVB1sjUoELZdtMGchq1+1I2/R024HohdB+lpffr2
         KyjCGA39qytVCoQkUtyqaeRzrXL4onN4bloimqJGxWWlIpHPtuEnMWVUWW676GFbkjoG
         +PN/cnNeUcJ09t/J/18KY0NOKodD+68uDcL3yAAadhtjgADE1OEHKA4lPSZS+Gqq1FUv
         Vdpg==
X-Gm-Message-State: AOJu0YwEEXRlh02Y7T5ziT9j4KksP2afUqj6eqdJXtL58orIVvuzHL9o
	HVRo8N3N861dxWzflefnoCbtGZBvqbU1WQBWoKD6I+i/v0jaf6UxO/25q1VfWnheWSQ=
X-Gm-Gg: ASbGncvxmQB5maiJhh9ZJyTDzHHjjVOsMDMMYZdNcTzSzCX1Vk7YR2+Y7FZ3CKA97ly
	e53Kf6yZCkDC7zzcQoWcWgr/D0hXpj4nsCdWMYJGlhJiAR8NQBxb1xxAMl7ZRYNt11vsYzgMitS
	vN6dwaFW6Dz91v3JYnsgMs1bhqaiFWf8Tli2ZbSSZIeaPM/f3ruT6fW6M7nMb81vx8XSjXpDf6D
	+8tylD4wbAa/fHR/aNIheUEfMS41wObMmS3gnAoD2E0nBUbHdQxuHRSH9LOikzCEQQOczJ15dBA
	vPLYtRzXqyekECzAGnxQrcrhEZDTWDgHEXxBkKGiWjI92F7CuciU6TgIF5/K80nmRr6n73ovgYu
	LBieEhnCHoXicXKe668wBhIWZ7Z0oIoOFNGwMV52dSPbQsVYrnvRzSOnCvnPVy+/seD/q/xPjTM
	a+FA==
X-Google-Smtp-Source: AGHT+IGiHVqCid6jiNXmY7e2HfatNlHZD3vTyoXsmvvtSGKovpZ2+7Stv4IcOLATQICU8wnyJ6SpuQ==
X-Received: by 2002:a05:600c:1f90:b0:45d:e110:e690 with SMTP id 5b1f17b1804b1-467eed90607mr31739365e9.14.1758297516735;
        Fri, 19 Sep 2025 08:58:36 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-464f527d6cdsm106682695e9.12.2025.09.19.08.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:58:36 -0700 (PDT)
Message-ID: <54b7e9b7-e2d5-404d-9410-06b62a11d073@linaro.org>
Date: Fri, 19 Sep 2025 17:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1 RESEND] thermal: thermal-generic-adc: add temp
 sensor function
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250903162749.109910-1-clamor95@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250903162749.109910-1-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2025 18:27, Svyatoslav Ryhel wrote:
> To avoid duplicating sensor functionality and conversion tables, this
> design allows converting an ADC IIO channel's output directly into a
> temperature IIO channel. This is particularly useful for devices where
> hwmon isn't suitable or where temperature data must be accessible through
> IIO.
> 
> One such device is, for example, the MAX17040 fuel gauge.
> 
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

