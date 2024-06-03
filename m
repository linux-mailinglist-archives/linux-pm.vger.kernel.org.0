Return-Path: <linux-pm+bounces-8515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76A8D7F3A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 11:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5881C20F52
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF88594A;
	Mon,  3 Jun 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXTNN9Xy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FD85935
	for <linux-pm@vger.kernel.org>; Mon,  3 Jun 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407718; cv=none; b=nQhk0Se0601LCoQostNvfvCXa8RN7m852n53p0CdCeJ6WFedTJNCUj8uhGYKWMy+rqlE3eTKisj2PZJg0/4KuG2tXbjD6rnHLqLfYPsV8ideIjbYPSB+CvfRS/E5/WvYgIxhZwB3FGS08X9qPrCYk79LVS8ldFLUeAiKs/UVXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407718; c=relaxed/simple;
	bh=QJ6kgVVjNLPyIWId444QEP06eFv2VCq6GqbBgggugSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRXtJiyZusUNuxqRKprGHgmnuaxtONh10h8VI4y+h3pOJIux3EiBlsQL7JJLpGWeXaH3yzC7MQNGeQr6aZ4Ym5UYajGU9dlE08kgEzFuh3/JkbX4KzC1R0rjOAbEYzx5+bFZZUhSJyuIuQypskvU8SQQ8hLnsYmo84/z8cYLyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXTNN9Xy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so3755124f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2024 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717407716; x=1718012516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USghCbUyJIkAuxV2+T41xHD5g1W2QLSW25YefyWhIG8=;
        b=DXTNN9Xy14IrP3ySeI92IIy1CHwidwujTpBp9t7m+0qmjquM88/mrYxoCkRdfxz1Bi
         szYoddKdThGHxM8k3RiiL7MzqjwpxZuIhtjzdHwkYYTyvlJI+5LT0g2bPUYx00v7zhEN
         2v5ENsqvxF2jN1u+51bGfe6VMHm52evSoGE2uKoumSRHI8un4xLskb7OsFZ5Jf24TTfm
         CaNXvI9sn5b921P/QXr7/8h4oxJUl9yE5X7V4kFo5dgKVJ0DS++WZ9agy/xXj8UEzfwy
         gUbfIMrujdMmDPvgnZc5IAjyINaDQSS9EfreKy1M4fB2jUpLXUyK7hCo9Bxg7fmiQSx4
         cRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407716; x=1718012516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USghCbUyJIkAuxV2+T41xHD5g1W2QLSW25YefyWhIG8=;
        b=vS8BO2sfEd5ef4oyy3NvOyf6TuoCzivPKZ5+k6H5fQ7y2KWGDLn0XpWtM+7Oll7VJl
         cJ9k6BBQUeFAIPOYahz2EkPAhr+MS7sh8QqmlIkivmz2EylAN4SNs/U3u+ZaESN29NVf
         dALTrmqItG75axr/Zg1SL32lnzL9KbnY1hWLPsaNk8F5DGavmp8cX2DwOkZIC6tXpoM0
         iiZW+EPXhRBQpMEzrdoMD1V7NK5hyuhZ/N6l34ZD6Q47Iaim+583j/xTvfbUgh24IQkX
         VHEmKho4+LJphWlVR33/I+1PgOvt1v3TQRSwXC3SPvkTQ56kGqDYrmtr6pYL/iPMBwgQ
         wydg==
X-Forwarded-Encrypted: i=1; AJvYcCWff/KWUpJY2ovacW+a+0pwtJ1Mvkx/M/2Lkb8QlZzA/ONSj3J5Z6chT1akaC0XVlagrP/YsVIGDQZHUCrMttnB/ncaz2g8FDw=
X-Gm-Message-State: AOJu0YzIlUGVF8sJRv+04krzXzKEyEirci5clm5RlHM7PwYtw25ArTjp
	VQ1svhNrcwgubopkQ4uyqJMxEZcE7WcGds2pnxFEFEtbigZitx0ncB0nK8WasSE=
X-Google-Smtp-Source: AGHT+IFRL8KKMxdcv97FZ7PweTJ8gpznKd+SdAWL8QlXQFsqHC59CsFCSxjI6m4NoXkXyzHpjA2y7A==
X-Received: by 2002:a5d:4406:0:b0:35d:c106:2db8 with SMTP id ffacd0b85a97d-35e0f32dc68mr6062943f8f.57.1717407715564;
        Mon, 03 Jun 2024 02:41:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:430e:1334:2eb3:2b19? ([2a05:6e02:1041:c10:430e:1334:2eb3:2b19])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35e5047f75esm5160133f8f.35.2024.06.03.02.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:41:55 -0700 (PDT)
Message-ID: <854d1b7b-074a-4bfb-8dec-5432a832e221@linaro.org>
Date: Mon, 3 Jun 2024 11:41:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
To: Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com, u-kumar1@ti.com,
 j-keerthy@ti.com
References: <20240425153238.498750-1-thomas.richard@bootlin.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240425153238.498750-1-thomas.richard@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/04/2024 17:32, Thomas Richard wrote:
> From: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> This add suspend-to-ram support.
> 
> The derived_table is kept-as is, so the resume is only about
> pm_runtime_* calls and restoring the same registers as the probe.
> 
> Extract the hardware initialization procedure to a function called at
> both probe-time & resume-time.
> 
> The probe-time loop is split in two to ensure doing the hardware
> initialization before registering thermal zones. That ensures our
> callbacks cannot be called while in bad state.
> 
> The 100ms delay in the hardware initialization sequence was removed.
> It was initially added to be sure the thresholds are programmed before
> enabling the interrupt, but in fact it's not needed (tested on J7200
> platform).
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Acked-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---

Applied, sorry for the delay

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


