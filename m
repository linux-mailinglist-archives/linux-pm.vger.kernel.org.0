Return-Path: <linux-pm+bounces-20801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138CA1907A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 12:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0857D3A1966
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CD1EE7B6;
	Wed, 22 Jan 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYGtcph2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E13136A;
	Wed, 22 Jan 2025 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544719; cv=none; b=TVY2U6L5L7JXQhCCzj9qKbsMCS9hPJLzSbg1rCELaPqa7iAAx3aWgJIR/LfT/vEIEQ3B0aFLxk78oRxCjDwmKSk5NFBSUtrid0mvnDuZqwUtHg3a1U2uL+bukNLXrkQ4Qq+tOSkVShWwROxpxG6so2ToW+RQQsl9UuDoXPW8Uz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544719; c=relaxed/simple;
	bh=VkIsIxFqNnFXBeJpYhyYhbtCp2L6Z0FpexhGbCLsYwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGWRBItwvuqdfGn8u8L26oT96Djn5RK/u6oXF3XaLSREF5P8ZLjAIJCC4fIKkxe6q0poOvL+oE3AHbugpQdQ/XCdAF+Yc7uFq0zdPb1zWhz1f8i7TXuwKWMrYHKpnmtPvzNtxCVkh/h13BVvxCgRsHiXGSlPe73Cj7aTi6aD2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYGtcph2; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3043e84c687so54882241fa.1;
        Wed, 22 Jan 2025 03:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737544715; x=1738149515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHnhEphz7DnDm4X924MxgWq7ImAvK6C+Os9CX2NZWyk=;
        b=kYGtcph2tAIIo5P6KxamaMNDTu6eqUd9FGEbqYlX0MTL/ka2H849M2fXWqImhR9sSa
         QCxOB3SdbAP5UyTZ5iMW2VRQU7ttxQcL4vZRQi2VsHsu2h+BT/wNDdk4tPQ3X0tusFMf
         81HOJS35EYTh7I+EVVcz9LnuHFpUTCfARUH5SckmYoPO/6CAcD+LIy/aYHPXh8P9LmLa
         Qp/Obt38YIWzCPtl1hwtuqZVuZBbgQUxUjiEjm4bMEu2U4QjveZ2cl3MOh9zjh6T5EYg
         ZGiuUNe54Pk3YlC62Zu8+e3YqwDEl53BDyDnkvhHNp2cwKgUchZdou6JEVMMygg4hZ7o
         Um0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737544715; x=1738149515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHnhEphz7DnDm4X924MxgWq7ImAvK6C+Os9CX2NZWyk=;
        b=YapRiHPzn0R6x/oFuvX1HqJLNtASoeMSpKkeMZwnbRXjgbFKW74Ac/iyGEsk5EO5vF
         epwfLhA10vXRyp5te8Vwm6YIhwRh7n/okrTqQOMnYNoaUejNv47E+hwAegQusCFLeYPH
         8YIZYKNVQh/1acTJFOqxFRq5IlUB9mdhF4lvU4MNU1TU+qZjWOWAnga6D72FG/Rfaecp
         b92z0Tc7avNZbQUPg7zZL4388xaZZlLwdNDl+QfW/zG/relzKJgUvc59r2CvjmUW4uDY
         DLZxYN7KLrYqqaOmJS6l62bK7CfWdfXB0luiQ1cC+066xnHuS1XmvKOXvOI0GC3PUJWJ
         S3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1jM81k6adoDy9tPaTv5CHthvc3TuZhETxTlbxs58TqVMRiQqOqIdxZ3C1T77kQHLioMrRbq4x05eB@vger.kernel.org, AJvYcCVJXrFaN//TM0tl/emOtV5/OoC9/rklfnq3gIFfiV8QM2C5toU+GLec9yS7Z1AMysDBeCWUcONIzVA=@vger.kernel.org, AJvYcCVQ6DcE6FKDxnEdrzi4efhyPUhqVuOdX7wl63uFThSCLnBzxHtfIWzm5TSbl0k06jOcJW6a0tmF5orkgw3OcuTHXeia+HVX@vger.kernel.org, AJvYcCVeyiIRPC/shcCe1NfscNYeU61aWUF0iW0F4FUdtspTll0RbsxsJ7vKG7BZ1baYMICg1DQoSVx8R+6E@vger.kernel.org
X-Gm-Message-State: AOJu0YwNx13W0YEo+bKSv/PA2spl3tYjpJ73+bHUWIKNxFYxTenjt5Ui
	jZFMtX7EvvyRzatQ+C/5nZqM4bAijGNWJWX/Xr+wLgOQ4fQponXY
X-Gm-Gg: ASbGncvaAVFHovNtJ8UGMwWEa7w93NvMaBIeGJnK0xkh04CH01drfhXEm5l/6zfYlF/
	SNR94VSFDnZfPv1pIUKHsfkzMdYfdoFYhTAEFNjAP74KkHZxk+TKJ7CtKwy9ykm+WbMS4DD/NjQ
	1YCXgNIs/Du3IIt/SvWVzKm/Mn27BhKMoKxEOZVTO5Iwp/7Fcyc+hPUbkuSC/LcDVV4YxgfqEAa
	8CNsS6YvKXexxuH0TCjA8OfLpp/G7wNIg0U+t7kygxZAWumvOXKt8z8+7DjvQ12roRJuQTuuCvO
	wxCRgxo=
X-Google-Smtp-Source: AGHT+IFhihhIAFdpOqRUkM/GOfhDJsLCkBNl8oVs51jpSRx6+pmdoU/RFlOu7IKHaOw9TUD6UWkJVQ==
X-Received: by 2002:a2e:b8ce:0:b0:300:34b2:f89e with SMTP id 38308e7fff4ca-3072ca97ef0mr77473731fa.17.1737544715028;
        Wed, 22 Jan 2025 03:18:35 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a35a057sm26180611fa.48.2025.01.22.03.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 03:18:33 -0800 (PST)
Message-ID: <eb123791-a63d-4a59-a8c2-e7716201d976@gmail.com>
Date: Wed, 22 Jan 2025 13:18:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] regulator: allow user configuration of hardware
 protection action
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Fabio Estevam
 <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
 kernel@pengutronix.de
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-8-161d3fc734f0@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250113-hw_protection-reboot-v2-8-161d3fc734f0@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/01/2025 18:25, Ahmad Fatoum wrote:
> When the core detects permanent regulator hardware failure or imminent
> power failure of a critical supply, it will call hw_protection_shutdown
> in an attempt to do a limited orderly shutdown followed by powering off
> the system.
> 
> This doesn't work out well for many unattended embedded systems that don't
> have support for shutdown and that power on automatically when power is
> supplied:
> 
>    - A brief power cycle gets detected by the driver
>    - The kernel powers down the system and SoC goes into shutdown mode
>    - Power is restored
>    - The system remains oblivious to the restored power
>    - System needs to be manually power cycled for a duration long enough
>      to drain the capacitors
> 
> Allow users to fix this by calling the newly introduced
> hw_protection_trigger() instead: This way the hw_protection commandline
> or sysfs parameter is used to dictate the policy of dealing with the
> regulator fault.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


