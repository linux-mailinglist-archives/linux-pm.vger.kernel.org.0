Return-Path: <linux-pm+bounces-35926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628DBCE91C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 22:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B37401071
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 20:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C59277CB6;
	Fri, 10 Oct 2025 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iFLkQlRf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8902594BE
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129796; cv=none; b=XhteBLMBVyYgpdrE+dlgIlzd061ejTPmCbhS4iukg3Pmq2A5pBueRrLZVPtWsyxtQUG0qo0JCefJBPlFBdB7oe31KZobSVX/fX48af1I/xRQwuxr00h0g00bDtiUl514YggvM95v9JjFozaYutjXjKhJaUVuLxG4fGAWU+FFrO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129796; c=relaxed/simple;
	bh=CCuYNuIIVsY7FaNQiEz2s+18rwWUhIG0BCeJOEXr7Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qM8jbcwHHfOmVn0AqD/nc0/mjnT6J07mNl/MTd0dKJZdZcRHYiNrPIQhZsdo+CdmWAsiUiJz8Zu7lxgJZpGAotUwNAPxAXadzC8gebf7aaZ9S9mx9IPQ3JDM0aKuXs93e60MO9hZ3Qiv/kawds/9z3b8TYVGtLAyd4SehouyD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iFLkQlRf; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43fac2df7d4so1199364b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760129794; x=1760734594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpaXFAs8jrvhj5Iwajcw+7el/YiNtrh4pH3E6yC24YI=;
        b=iFLkQlRfKAxRQ6MLGsgDryfgmis9DO4UmlLwTj6IOitWDT2N6udOwDK2I/b8wr4h3z
         6NCYAIBWqfrZL3cFwJRP+F0xb6t0r/HpWQcAvdhMaOK6jo+1+NvLyLkqN3iSv/WjATSl
         qPX3xdlR1sT23/gRer7D0dis1yu1iw02luV8hQSgmAs6N9SmykQpZLEv4PPuXoj3sb8m
         NZ+8x1dvsyafeR0GyvVLlB5AjsQhwfPP21eRS5CZLVywWn3PmNxq2WG4wxaIu+sJdoph
         y/FV8l9+RSWWLv3/rmRArBgB2LBfvhCh2vwTr1YuPPlynT0oVzaE4k/TmVCNMpUMOf2Y
         3lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760129794; x=1760734594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpaXFAs8jrvhj5Iwajcw+7el/YiNtrh4pH3E6yC24YI=;
        b=K1hK1/z5vs4GSnlk7VZ//pADQJaI6OC/uuBCW9i/mlZikeYBRzQjWV2QEYgxtPjXIM
         52T0vxbymNE7Y8eE1b7vhoFV8E30MdgoUt1s/YsLvS8x371cG+YQJafgz1x9qt8Oaq4/
         5HKwkegycOuspK8UJvKS5Q3WnvcUN7JFV7QPPC6KSjw/v8WXkXss+xX92CBuMiS4mwVM
         8cGuNDa86yFguCg4sJlsLC3AIrVrzxjn0NkHUH4kr4k3opq5pw4Lov870hrnVjVajoOA
         86orq4uL5WLAeNQWfxWeYbZGrBqpC9Zk2s+6gowbPA2N/FdgKMRa7ghl2nnFevUZ+b//
         Wo0A==
X-Forwarded-Encrypted: i=1; AJvYcCUm7kchoV0VR2nAvEV8/+vN2RUkDUdexf1RvxaCdVwyhzFOKTQ/3nZ55UEfd+RVxRVhFu0OeippQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn92PHzbhaGTt0pTTqmanrJWZdVkieHNvvEepi648mRCN77PKb
	D6+ONfYiLAAfbXigIHFu1dtqXpDVa+waFLKcgi+BpZVTI2yV0EflDgX0vwaSTICR++Y=
X-Gm-Gg: ASbGnct1OWw+uZiZpNSekZcO0HOYpOQaOrRr1/bNejS2uM3wLZysXJgeenAX0qsRApE
	bi/5SmfbBQL9b7jVaEiCvslPraawLGn9yPFN3AERcX0/90M//b7NjcLtI7qTuUj3PBWdc4VcTFm
	SYxq+LyjSaPaf6Ymdk/Nbx4VNqRZTgRF1p84BAdYKFYDD9zeNWYa/Yv7K1vLavZtuN2Auui5NId
	McxelP4rv7f3NVPMptmScvrUbbrPKodhcQUfabWodFLRsUivwI0dLBqCNSMNvr+OdNdzG/fI3Ik
	Ue91L4848zFGkTlb9iyWqii71ZLMzfDPlTexriovFi9NcnvhQqvAMqYpU0WCQbEFF5HRJ6sNFjv
	YNCpU4irO93EyzgsCc70OiKEW8X40a9Csbhtpwk4dHoOxy5EAcA6w5+vih1qA/JjcFvpCEpsNXz
	9YddJAKWRyepuCYIwSOVjFDymd+w==
X-Google-Smtp-Source: AGHT+IFDRZYD0tvp0ZMbppnD3D1rHut3LIprbR5X32btFAwVwdld60PTV7/IdSY1ynz2HldpOFeF3Q==
X-Received: by 2002:a05:6808:4f4f:b0:43f:7940:69bf with SMTP id 5614622812f47-4417b3acf95mr6013690b6e.26.1760129793687;
        Fri, 10 Oct 2025 13:56:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8a0c:c02d:81d3:2e7f? ([2600:8803:e7e4:500:8a0c:c02d:81d3:2e7f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65018200761sm952285eaf.19.2025.10.10.13.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 13:56:33 -0700 (PDT)
Message-ID: <c770c799-4318-4c40-bd62-3cefbbbef731@baylibre.com>
Date: Fri, 10 Oct 2025 15:56:32 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] Battery temperature ADC plumbing on Qualcomm
 platforms
To: Luca Weiss <luca.weiss@fairphone.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Jens Reidel <adrian@mainlining.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 6:21 AM, Luca Weiss wrote:
> This is an RFC which implements a potential solution to get battery
> temperature readings working on for example smartphones with Qualcomm
> SoCs.
> 

...

> 3. Add temperature-lookup-table as property to simple-battery
> 
> Since the NTC is a part of the battery pack, adding a
> temperature-lookup-table property to simple-battery would make sense
> instead of having this lookup table be standalone in the
> generic-adc-thermal node. However being able to re-use the existing code
> in generic-adc-thermal lead me to the current proposal.
> 
Did you consider creating a specific compatible string for the battery pack?
Then the battery node could have the io-channels property for the ADC
connected to the temperature sensor. Then a specific battery driver could
handle the conversion as needed rather than filling the devicetree with
conversion tables.

The simple-battery bindings are already far from simple! So I would not
be inclined to add more to it.

