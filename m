Return-Path: <linux-pm+bounces-24343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98076A6AED6
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 20:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB478983480
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 19:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D8A22A4F2;
	Thu, 20 Mar 2025 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOpet2k+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF3227EBE
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499926; cv=none; b=YE9tieBT40xyItTUkjhTDgVi2Q8rbkO819pzZjEqbbGLzUfLVUg4fu+c5ZURU6zaxlw6rTapMgTjQKrjDH106n/PtSKCgD2wx8uAn3Tvg41Jk8X67uv+kMEUMj/pjSk8HSXXl+nftnAIw1UMnLER6TLKaDby/e1r/LQk52AHAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499926; c=relaxed/simple;
	bh=KThe2nutzd9mqonkSKay3Hl9cUyVPIB7fcY6wCFZQdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmRScxoizCHyLVQwNreQ+6FnZ9lOhAn5qWt0rHlkZtTGuve86z+Ya4cpoFjos/zB+sSpYRwFVnEDAZXxLpfdiCO//tItCAu4kSGzLe0y6MQY0wwDyYg9anYhVzXsbwyS0cnBYyO1rc7cOUUtvsPuuYfE2e1xpnoDa6p4f7chRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOpet2k+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22580c9ee0aso25825045ad.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742499924; x=1743104724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlpgaR0yQjJtGhaDJfcefOfylwG4dpk/sOugUwcoAf0=;
        b=rOpet2k+g6fhDQ2vHVB90Eh9EDW25tnXWoZM3Hwl7FWRb6vxR2EoDjKSVHJA5SssLe
         FKSqx4E3i5Vn3OZVlbRUHiv7m77JBSavjKfZQCUGfqNGDG3hMNxUMksQJ4BC1ajSNTJX
         UtM0laCgik1jbC2SXby8ItK1YH12ga5oRSW2E2DduIQWhgCcv0vl6vhuBtze1w35mHjS
         DpW8t8sa4dyxyI8ILI9rZdNo3WfAqpzeg2HWOdxkKeP9YrigOpdl1fA9qUEpkvdWIn+a
         G3vtBvSh4oXOdAi0lyf64l8eQLKCvQcIpRUMVhaXZERomfCo0YO9HtseWiuV6jvF+Q7P
         Lc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499924; x=1743104724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlpgaR0yQjJtGhaDJfcefOfylwG4dpk/sOugUwcoAf0=;
        b=ZdFq/uHWR4woleY95JWi5f+pPFPpmVeAXvIZSvKSIp2HKth6kaIR877sgX7IYIflLI
         Q1TzUKn3srtYWyhmzhL7ek575PkeE/7trqIyuJCJHsIPX9ECPtp/6QfVnkDR2fxjfuJW
         pPQqWkCDaF9K3a7Cn4p6pis9NSNmgs8AbrCUCRqTXFOwZyjKYw7rJbSCVYguTLS8qAFh
         7/zVR5NYU3huP4Ume6Dsit6gLcP4hwoETxfdGd0kyQKxQZ214R4Kv7gJzAxXpgidf95e
         jSprTbpLKUNpA9A80qV+BGfpBW6nzUZ6Ds7+U0ziJXncR5zYnDhTXpWdv5Ryzcsi0Ntl
         ndOw==
X-Forwarded-Encrypted: i=1; AJvYcCVfY6/XvF4CY8s/ercL4HyD0pXqqkj2tWcv6Mf6LT7nU3f2yfqfqIqlpI4HHoGT7OQ3hrN/CYwswQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/lod3p60HAtb+IHJy6Ox58Z0tlv1BYD5RdCEb7Sfy4lcUQTTg
	Kf67fbm9SIyD5u9RX9EsyA0dQoe+ZFV7xTh9vjmbeRkBPxhjZN5CQXmAIH2dFg==
X-Gm-Gg: ASbGnctFg3sCXa+raoyWU3NRwG1GdIl+KDzPEtRL0KOmYRTAU9bw3FS1DSc40ybiYNu
	LL657MO264FFN6qvESyhdR8vlq2tU7YZAezReGK/JJSqj/5EfwCPh+wbTcpuexiA5mqhcrdBa78
	pDYt3kUM6m6LZXYLhqWJF9yMy3EFIsAFuHl4l2Jnyfna+BscxHXsgU/o+L5hWmc7J9Xa7InrxX1
	Y1BGim0KfnhmtaQpai8aHFw/PtaicYVNBNR2KF+TevAYnE0QiXIsYfpIAMRbz6MbUht0WWrPScT
	VZQYEr0izRIiYb6HoU2ogdU+hVUlcsY82z0g484vrTKsPXrxWKXDvlaqWtup78KYbyfOVUC+CCX
	sOEGODJFNbhjp9FjysrsePG6e4lpwCZjEwif58cjKxXhaQHuC6OlWoA==
X-Google-Smtp-Source: AGHT+IENLKihrksiYGmmjoFVdGD3nmnNaE4lKfWVvWkc6djuSQ42SPGpugmxhc5MD8+aQ5CdkfkZjw==
X-Received: by 2002:a05:6a00:2d0e:b0:736:d297:164 with SMTP id d2e1a72fcca58-739059457d6mr1123691b3a.1.1742499923443;
        Thu, 20 Mar 2025 12:45:23 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:c50a:4138:6122:653a? ([2a00:79e0:2e14:7:c50a:4138:6122:653a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab7c0sm212508b3a.7.2025.03.20.12.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 12:45:22 -0700 (PDT)
Message-ID: <9bfab72b-d851-48c9-9cf4-d760dfb8e618@google.com>
Date: Thu, 20 Mar 2025 12:45:21 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: connector: add fixed-batteries property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Sebastian Reichel <sre@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
 <20250312-batt_ops-v1-1-88e0bb3129fd@google.com>
 <20250313-tidy-kakapo-of-abundance-eebf91@krzk-bin>
 <85c6de6a-f8b4-4e4e-8fa2-da53816abc89@google.com>
 <0e654a26-91de-4218-bd60-64e996d5378a@kernel.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <0e654a26-91de-4218-bd60-64e996d5378a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/16/25 9:55 AM, Krzysztof Kozlowski wrote:
> On 15/03/2025 01:56, Amit Sunil Dhamne wrote:
>> The intent of the patchset & this change is for the USB Type C protocol
>> manager module (that consumes these bindings) to be able to get info
>> (such as State of charge, design capacity, etc) from drivers that manage
>> the battery/batteries in the system. In order for such info to propagate
>> I need to hook up the references of these battery manager devices (fuel
>> guages, etc.) to connector.
>>
>> I have addressed the connector <-> battery question in the cover letter.
>>
>>
>>> If you mean chargers, the OF graph is already there for this and no need
>>> for this patch.
>> No I don't mean just chargers in this case. Also, I didn't follow you on
>> the OF graph. Please can you explain further?
>>
> You are duplicating existing bindings and existing practice of
> describing the actual connections via OF graph. And the binding already
> has the OF graph. What to explain more? Please open the binding and look
> at the ports. Maybe they are incomplete? Look how other USB and USB
> Type-C connections are represented.

I will try to use existing bindings. I will update my patchset and drop 
this property.

Thanks,

Amit

> Best regards,
> Krzysztof

