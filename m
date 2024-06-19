Return-Path: <linux-pm+bounces-9562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313190E853
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BB2282FE4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F6C82C60;
	Wed, 19 Jun 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOK7hK+Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EBA77F0B
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792876; cv=none; b=TWSRxUU85VVsPsqgu+tM605qgXOaGv5Xn/8zI5QmcjxFVM9tbqtDHJN47G49RjdgMbx50m7vdzLNwL7rymWqJrV4eyLtBvrkIq/+2w53589mw+rqTmIegfS5ClHS5g7EVe7qWHBdtMtV+/U66Q0NCgdm64fYjP8EbTK5yVCoK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792876; c=relaxed/simple;
	bh=i+Vh5IEf6ap5Zu7o39yGmTLNUILpgLoegwAAulUElVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyO5kamb5tfdxOnkoUvbQW9rp4s4cSKLMcdHO8rwZMma3LuJ3F7rTPGHCr4YwH/+c2An3wytYTTmCGvVCPkP2NqwYC/5/O6J3seGTojWdK1dGQ2E4M4B5N0Jo/b2WP5F+tik9TpxMkcbU0oikLfVf4mTa4lcG58tiX4OnD2BK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qOK7hK+Z; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-363bd55bcc2so258301f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 03:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718792873; x=1719397673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CyUIVE4d7f/WSt+yhhaSrSEXlrd5/Sf0m/XuQDZqM4=;
        b=qOK7hK+Z/n9BG+FhA9S7J9Nn5Ec5Xp/JGVLpHoaQBM/ON9Zwv5t4FCLSQAcqsFaQHM
         Rg6aXYLcbf+15slquCy78vFpW9QkpX7w+ItkpUvevvB1p1bfe8twJv58CtHzWkZG9sLu
         LMWAaiQsuWaEjfeU4AtbZm+D2lOvIO0YTVMiA1TjHL11S0zYUYE9l0WJ1ewKvhYXIxXD
         D90OUX+35n32uWzNNqGqYdpUUH2DJhJl+f4XgSeT8x7h1Cqi1TMEaMaXCYAQh8RZG4YA
         FkzExkJonU0RDQz8AGmCJ8UJP5k/tC8hNIF8bliPbhGLl5zYVrVbIlmjSOiJh2SM7cT3
         ToZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718792873; x=1719397673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CyUIVE4d7f/WSt+yhhaSrSEXlrd5/Sf0m/XuQDZqM4=;
        b=HKxlRJNwUgyM9CLH8ysDd31z1dqN4FqzR56fPcx2f4Pj6tkbCCgqRU95Tj16J3Phcg
         k7DQuB7oAlODCH/+4aF794yIaj9kty1RSCjRCR6ZntHUgwxEt5Nc1ClGWGSqrO1oasAt
         rHPoM1omFj1F8ky1BG5WOEmPafEOcJ6JBMUbOXH1l0XuBqVeoxMhsxEo8r5WJwW3l7/f
         zaLE8yUF0e+KFXXAbYXvdrd4UkknOaBtdI9eHZYzJVYgIYSwX0kt4oQ6jvJnX8qlTOC6
         sGtxfmvycBS/mwkIfBOPPM4WmYO1np4fJH+yrclRTWirQUvfLwj/8Jo6EME9ov+oJ58F
         Hfcw==
X-Forwarded-Encrypted: i=1; AJvYcCUrcP+BgY/OimZFrMfk59dNAVaVvF0qlTx7UbUG+fTt+VxNvNGueVFtYR+OSwqa47BNOKwxW0fKMmSVLmpBzeJn9FccTP0mYpg=
X-Gm-Message-State: AOJu0YyuVZBBXMq0Zzg/QKueMXlIMBDUqqV/AeTFWaM7nDv3svjtNKQk
	Ht7djnm7Y5uRkumqu0DQ8S0vudASGCIMmOjNdCSSdR4X+lYRBrC6x7lWANY00jQ=
X-Google-Smtp-Source: AGHT+IGtec/lgCxyi9AgTK89DVz1wHvGWI1ABFZYclqKo/M9rdfeDf4DrnxhbsWhUsYeH8EB8I5HaQ==
X-Received: by 2002:a05:6000:d41:b0:360:73f4:7937 with SMTP id ffacd0b85a97d-363171e2cffmr1500634f8f.6.1718792873117;
        Wed, 19 Jun 2024 03:27:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a784:959b:8c69:567e? ([2a05:6e02:1041:c10:a784:959b:8c69:567e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm16634591f8f.76.2024.06.19.03.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 03:27:52 -0700 (PDT)
Message-ID: <5f894bbd-3301-4305-ac8d-10dad1e6939d@linaro.org>
Date: Wed, 19 Jun 2024 12:27:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: thermal: convert hisilicon-thermal.txt to
 dt-schema
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240618-hisilicon-thermal-dt-bindings-conversion-v4-1-7eba97fbe6d0@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240618-hisilicon-thermal-dt-bindings-conversion-v4-1-7eba97fbe6d0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/06/2024 04:31, Abdulrasaq Lawani wrote:
> Convert the hisilicon SoCs tsensor txt bindings to dt-schema
> 
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


