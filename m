Return-Path: <linux-pm+bounces-6943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17B8AF511
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 19:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A471F23947
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3263F1422A9;
	Tue, 23 Apr 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iyd4pnPp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946113FD7F
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891993; cv=none; b=CKjsu6enREah9PvCKahv0Xai2TXTlPI872kltktXSoRWkRmYm9N+CQxmRSJH7VZW1yZMf/cBNO99D9E1vdnJfTuzU+w4u/9Sw/IbGAhOABwrWimLFneNKIdEHrWpj0srjAfuUrYl/qFiQII1pEGM/7pq8pS5BBOUGKW4BgziYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891993; c=relaxed/simple;
	bh=cadbqdxoCrgr/fQKYDJtFPwBcyrMsC1h7o4VyUXwexM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gxe5URsYiCxx07LGxUBQ20VfL7Oy7N8LKrMeo7j3YM0G9CVvTCoiaCRM4aHlydaw4G/GrKQhVtj2scoIv0nQm0motLniVBkWSiom1D2H83vV0zA1/aRZVDX9piHfMqXljSVJv1qEm4As29Cyrk5kt15jhCzHTg12V75deZd4fd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iyd4pnPp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2de233961caso8795791fa.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713891989; x=1714496789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXZVFoqKLEKB9pSmavX8lDsgDx8aHMUSa6gn/0P7/pI=;
        b=Iyd4pnPpCcrGVnUpPTE+A0k+RCxP9a3G8g75xGZ7EiWVxHpvfrqzZPG+qhkxDnH32a
         nXGr3LAddKT/ziLyST0QTwTg89eYBr9L7COb+8t02izwF69TlXzigVUvLaWKor598P+D
         FVvI0/A9acG8+u9yxKaFGB290ufE4SwjNkO3pSaFvwILl2nIgkJwxU8t1y2vOMInXUq1
         DIUBLo4OTIReE7BG1x8jn0poynF8on1hwJT9MVlge1+nOzinvTkinSY6KZWrYYOHwyxF
         PiqtW+U4teHjzh4xhpZp+C/ngqy59ionBMK0qLRxph9sZeeI7A1F5tt8vd1ji4en0NYm
         IbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891989; x=1714496789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXZVFoqKLEKB9pSmavX8lDsgDx8aHMUSa6gn/0P7/pI=;
        b=gxak1tSfPm4WEsSGaQHwkwRn938Cai2XqCABkjtN4TNjrPjuJpIqKP5gQReFF2NItQ
         fqV3Miy4ECaPDzYVtsJYJeDL//VS0P7wPiZpMyY6HJiyf9vG2Y+eQuVFFKXCOibWFLDq
         T+ao0QVgObMWngvS/gt2xWyCZDAvEy3C1B748nT4BD6dwV/RMFUi9qVMdjmTpXp5FgXj
         WBEy1SjyE3QeHX/A0RvfColTor2s9/eki6jXB6rcCbx+UnK9RL3WTv3poM6zhTPGLa6t
         O+qXllRYd2XdmkJ3L5bKbJHYhUG9nd8tl80O4KeOjcMDOOaHNphFxbRJNf8KbWSaRc9f
         nsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/zuuzeOmPrqcx84QLYV1w5koHY2mrk/3KIpRjWQxj6fpLpgzS05fDE+bwx7N6b41iEYo+Ir9BWfAVqCYrHSwh4qxChdYEhek=
X-Gm-Message-State: AOJu0YzXnFnTCceYbWhJWXH392o2r45FL0sppv4EONBPjc+w8063WhJJ
	oaaEPHQSiWE8hS3L+4emG4o0BqKENTkf4Aa5ST3XIBQgwvgs3A7/j35H+rqZk3U=
X-Google-Smtp-Source: AGHT+IFTLIFryToNiC7tozTvrbaJa5+9JPxbtu+C8ul5pe0yWHBv4YXKdKe+JFKAm0GKlNfIX8eAOA==
X-Received: by 2002:a2e:9798:0:b0:2da:a73:4f29 with SMTP id y24-20020a2e9798000000b002da0a734f29mr11163313lji.30.1713891989157;
        Tue, 23 Apr 2024 10:06:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0041aa79f27a0sm3735054wmo.38.2024.04.23.10.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:06:28 -0700 (PDT)
Message-ID: <91fb56d5-3366-4fb3-ac44-71c29654318f@linaro.org>
Date: Tue, 23 Apr 2024 19:06:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/16] thermal: gov_bang_bang: Fold
 thermal_zone_trip_update() into its caller
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <3827124.kQq0lBPeGt@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3827124.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold thermal_zone_trip_update() into bang_bang_control() which is the
> only caller of it to reduce code size and make it easier to follow.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


