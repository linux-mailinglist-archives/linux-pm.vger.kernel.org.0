Return-Path: <linux-pm+bounces-19961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38DA017EF
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 04:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619FF7A18E6
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2025 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE291BDC3;
	Sun,  5 Jan 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daall1yw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111CA63A9;
	Sun,  5 Jan 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736048234; cv=none; b=Xa//ut9YOgGr8egAUYPcZm9uDyq8lgncv4dEAOsSxyLvG70afwrCWlP9zcmC8lcPnrcP5htvh/iagA5Mk23PIAiXbU4EuInZKBMiWUSqboKCsz7XGUR0Z+lKYYgEYBjUH1PNTAQ3lDMhRvGKJ3tz2XNuEZVjrWPfN+kZFFPa6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736048234; c=relaxed/simple;
	bh=mLmGz/XxMDGsY0VpbcIUgsvv1SKTMC8Kz6zHyosMipY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mh4B7CfUuBXcJpsHxxCA/jwmbUM7QODDx9yu9MXl/edF8eq9ewQGe6ZALSqfR+bFBxSxUQxmpVkELSXqe3d4+TpzIFcyft72oCIo0Tg1gz7Dnyf+tA9bq3qOi6FubNdZIfrOxY2LXATBoV+a7th38NlHyJFyT9raxmiiTe2wg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daall1yw; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso14935951276.2;
        Sat, 04 Jan 2025 19:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736048232; x=1736653032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zhs1GeekqR+yhW2r7LReyZh0loVS1uNNv7SzsVVmAS8=;
        b=daall1ywcwqD4dFm9/eVr64HB3RsD6V3Oq+kDAxzMoS/8SdCoMWx2pFA4JG/ayWoVB
         qfGQXA+9uu22eWDRQDj+e0SbUDMKb11QmEaN8yjf5dBm2oEs00dFX3H9MM6su0Q7odZZ
         VR7jyC365z5xDB97tfOIha6f2w8CrMG03luDXtTT0A02h5bfzn5qVbykt3LJL9yI9Mj2
         qYWYFPDQyzuT3QUADh+D7idqouo72Rr4usZZDgQPkmUG8CXhgdxSIpp7ERsJ7Epj71jI
         CUGY8wxoCTJ9pbcv2nOmDz2mIIjyZpXJQ4If86H+k1Hn9v2aJrw1zmre74u1KdA57n4F
         ThIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736048232; x=1736653032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zhs1GeekqR+yhW2r7LReyZh0loVS1uNNv7SzsVVmAS8=;
        b=DJINCQRGj5G5Ud2vdDUlxS8HxiV5xs5Nz573Hyyf9BXw6JUswg8GFNUzwcqE8Aj0h9
         qSUJihKnicudrEScBfuQtpmB8zGdSkJmZrMwl7EvdgBErWuvmxPG7TJyj3+WHR4Rcfx4
         KanDpxyh9nPhz1YgakdqcgJYbuiyXmGPQ6sKnGqzyUqTaoGvKMRIRWcKm/+F0Adjp9F/
         7pcssUjV56kr4gxkodLbOp+2gi3xLb2r8pm8eSGL9tj6vGypl+BbVMsyDSRL/78owHzc
         0y1EuM79S03MTB5t8N2GK3GBTEsCASXEZlbzFdECQssfnKWoNcCrVIxpM0LHCI19lQNd
         YmQg==
X-Forwarded-Encrypted: i=1; AJvYcCXYwWPKcBuztYmBG5dgiaZaIiVjyXonPfFi4rHZZ4Y6ZtbrlZUi/EmhpnheijqAUzMB+0sQm3gvj1BbFy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1561tYjU2wvwnKhUWR2HwhVUB6VM6OlX0GSe806JqCZ34pPCH
	2dDF1BL63sa1HuwwR/FaIkmaMppVlAysFKJIFcMM7u2qw9VntI+z
X-Gm-Gg: ASbGncvynCfZ/33T6uhbRlf4696NCWynbGIFa2SUrwiuKqp0zkJ033ybqb++c34BHUP
	mWZk9NKwvknUyarEZxrLU4kiOWdAdr0r5rUpCYnNlLcunN01nU7FkUz25nGS416a7PbwLvZUkUw
	5sCq14Q/fz6wn/E5Keevh81kRH9oPm+eIWauOPTgiqJJf7u5u3uTYyruwU/8Mt0E5XynHKCoK7k
	Esg2TAhsyh9J31LlHEJnaTvJJZxPXLlw2pwlANEuReDmtr5gh9YXMXVHlFPX6XUVq6g/8I2
X-Google-Smtp-Source: AGHT+IH7rdz1OK60/3Jzqbq03lujYPTS14/OILrw7BMffcBY1KqFDaedkV2LvozM+Z4yaavW92Xerw==
X-Received: by 2002:a05:6902:2681:b0:e30:cd98:56dd with SMTP id 3f1490d57ef6-e538c223eefmr36360976276.19.1736048231747;
        Sat, 04 Jan 2025 19:37:11 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6f3e73e785dsm81302447b3.1.2025.01.04.19.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 19:37:11 -0800 (PST)
Message-ID: <1bb556a4-6b9b-42ae-98d2-15c8986cb88d@gmail.com>
Date: Sat, 4 Jan 2025 21:37:10 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cpufreq/amd-pstate: Set initial min_freq to
 lowest_nonlinear_freq
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
 <d89bfc1b-37cb-4d8b-b944-8dc385915bcf@gmail.com>
 <62f0402c-89a4-4ca8-b443-fbc9cc3b2055@amd.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <62f0402c-89a4-4ca8-b443-fbc9cc3b2055@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/8/24 10:35 AM, Mario Limonciello wrote:
> On 12/8/2024 01:54, Hanabishi wrote:
>> Hello. Maybe I'm too late on this, but I have some concerns.
>>
>> On 10/17/24 05:39, Dhananjay Ugwekar wrote:
>>> In other systems, power consumption has increased but so has the
>>> throughput/watt.
>>
>> I just want to bring up the fact that this change affects all
>> governors. It sounds good for the performance governor, but not so
>> much for the powersave governor.
>>
>> So the question is: don't we want the lowest power consumption
>> possible in the powersave mode? Even if it means decreased efficiency.
>> Powersave by definition supposed to make battery last as long as
>> possible no matter what, isn't it?
>>
> 
> No, the powersave governor isn't a one stop shop to bring everything to
> longest battery.
> 
> By your argument we should set the EPP to "power" by default and "boost"
> to off by default when the powersave governor is enacted?
> 
> All of those are far too aggressive for a default behavior.  Setting the
> lowest nonlinear frequency as the default lowest scaling frequency is
> about having a good default that balances responsiveness, battery life
> and performance.
> 
> Like all knobs anyone that doesn't agree with it can of course modify it
> from sysfs.
> 

If the documentation is correct, the lowest_nonlinear_frequency *does*
result in the lowest battery consumption unless you are running one or
more threads at 100% utilization until the battery dies. In that case,
lowest nonlinear frequency should result in greatest number of
instructions retired when the battery dies. I say instructions retired
rather than work completed, because "100% until the battery dies" is
only stress tests, malware, and damn-the-torpedos concurrency frameworks
that use spinwaits.

If that is not true, then either the documentation is wrong, or the
CPU's reporting of its lowest nonlinear frequency is wrong.

I am puzzled why the CPU even exposes frequencies below
lowest-nonlinear. They should always be worse than PWM-ing between C0 at
lowest nonlinear freq and some deeper C-state. Testing software that has
to run on much slower CPUs, I guess?

