Return-Path: <linux-pm+bounces-9211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 898B3909289
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 20:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051BD1F2208A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB519FA96;
	Fri, 14 Jun 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxQ+XCmd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16C49638;
	Fri, 14 Jun 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391118; cv=none; b=iREeMR9pjnlSYicy/HjajowWs0cA5YKOAtb3gWltbXeliEK+EH8AaXWpqiIQ9CKtgUbwHoa6fA7S9UMzfyO+Pfi23JUTWUz4Xq2xd8mNUEtLXGJJvDkZUNx1mgd1fjk2FrUmG5WM+lKzQkYhIPAA2GwbA3wVOiHky0yQTR8rIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391118; c=relaxed/simple;
	bh=enWuKqXUz9GyFxoLZijvMKS2fI5yH9PvWddd77Gg2lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQ6uKkkcqOAaaBlhWCo6EVyugqEvSTNyC3/B3VQbTtvT9MTVnVzzlGDGsZMNbyq7FnYRjvzACCskNKGOrv+8SXny0bXjwzA/0V6HH6ApSRswgiqaW0aDCsxKeYT5gys90P38PDrjoSfAzv0J91C7wnW3TAGfXouFyH/voSDH1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxQ+XCmd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6ef8e62935so338902466b.3;
        Fri, 14 Jun 2024 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391115; x=1718995915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rprkihQjKE8Wxhdq2UGmvX5wHNUhwtUN5I71Y/SB64=;
        b=IxQ+XCmdCnjp5J4su+sEK7wsCGD59lNDd/HL5jxxpoePqziA9XJStGHuHzn2sG9rAk
         Cd9mCzVzE6Zq2I21rEtEk/LJ8KIpEW73k5B0QExASV9glTgtsECygicXjUyhKTpydT7E
         YTXl4sVbT9mA1P6yj4OzGrF+/H3Z2y5NL/JtsgVX60SuTGgVkdasG0hQ/hN1wqy/8aOS
         emTjfAiDS2T3FH8Y/YCiKPqaNVriQ3OHDl2UknWmmGur2tAxKstfevPvmH9Gw1Sc7C0A
         M4/LRbV9//yqab7XFHINx6b1oXr951ROcaSAXwCFC39iloAj2Lf5ISlfwupRCFTt5hBz
         3KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391115; x=1718995915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rprkihQjKE8Wxhdq2UGmvX5wHNUhwtUN5I71Y/SB64=;
        b=ZFe1c34JfxF/ygh34tGD6nAC49isJmElt4GUuzsji6PvvXLWBR2aYKNkbqLJu/0ANT
         WBRgNcy03aAgHUSuZfWMJMQW9t0NQXA44wZoI7r5Ocuw2yL/PGPsmk/lIUqx8aFR2D7T
         0VJmo/yIT/Qa2EwqfFjeO+AzwCkH91NxZjq8xI4r2n8FtcH24HimtPbfndciN+wDnKaj
         49CJgwtop6euXNWkdgAAMbeowcdTQz3D5IoNPpUvKhoNNQy8PuJm3XcZ3+n+GP9P9U8e
         AemjXZNITQAjNtUEKpT5s5SreLQoPl9wp0kQTQlcPrgN9rUu1ijxkefBniobzQMK7bPc
         +l9A==
X-Forwarded-Encrypted: i=1; AJvYcCXo7H2YAuOOBPP9CkCCOIRhLbDwC1WpVYwWxJvjFYtGxf6BW8FnnVzF5W8h4Tlanvuu0cf8j0mLdKVNx9iR7yM+S03xX8XO12wXlq4vWOfJG/ybiu9Xhxe7xt8e2jdVU0gZKIjVn672Gw==
X-Gm-Message-State: AOJu0YxYanOJNz+uD2TjC9qp+aus+y0XrF6nGpfKLp4ZHPEqXOWcsv/D
	NK9UQs+R1KVfUayEh8x6WebK/iRvtENvx7mQ6gsQZSL34A2fttmh
X-Google-Smtp-Source: AGHT+IEk36S7X2t8cMYmuX/ZpaUrMMUzSoVxsy05fs448iah9EFGdw++b7+nZbY9DlgFWQzzLo5QBg==
X-Received: by 2002:a17:906:c34b:b0:a6f:14b8:a017 with SMTP id a640c23a62f3a-a6f60de601emr271162166b.74.1718391114401;
        Fri, 14 Jun 2024 11:51:54 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f72e7e9f1sm393366b.147.2024.06.14.11.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 11:51:53 -0700 (PDT)
Message-ID: <ab09447d-45be-4af9-9bf9-1debc9e5943c@gmail.com>
Date: Fri, 14 Jun 2024 20:51:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: convert hisilicon-thermal.txt to
 dt-schema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240613224204.185844-1-abdulrasaqolawani@gmail.com>
 <afb7551e-404e-440b-92c5-6927c61417ab@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <afb7551e-404e-440b-92c5-6927c61417ab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/2024 10:49, Krzysztof Kozlowski wrote:
> On 14/06/2024 00:42, Abdulrasaq Lawani wrote:
>> Convert the hisilicon SoCs tsensor txt bindings to dt-schema
>>
>> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
>> ---
>> Validated with dtschema and tested against `hi3660-hikey960.dts`
>>
> 
>> +     compatible = "hisilicon,tsensor";
>> +     reg = <0x0 0xf7030700 0x0 0x1000>;
> 
> Oh man...  get this past your mentors first.
> 
> 1. Messed indentation.
> 2. 0, unit address looks unnecessary.
> 

Sorry Krzysztof, it seems that this conversion went "live" without a
preliminary review by the mentors. We will make sure that the first step
is not omitted for v2.

Best regards,
Javier Carrasco

