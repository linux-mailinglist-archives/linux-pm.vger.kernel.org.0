Return-Path: <linux-pm+bounces-24138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E92A6460C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 09:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A1F1885C28
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 08:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47AD21ABC5;
	Mon, 17 Mar 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu8I+h5L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32285270;
	Mon, 17 Mar 2025 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201166; cv=none; b=ZJiIrxIS931AmN7dM82803SxY65ZyvJSS6ZMcB6yk2lFNKP79pS+JB9kV/hCfx8sVwMrLjM/fd/Q4ICztYWHLx31t5lyGIqiMme9F+Ik1J8HRKmRQXOJSsqxTYJUOLP0ApImKTwhEcltcYbwOsoawLEHZbb5BfvowNdHyINFujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201166; c=relaxed/simple;
	bh=HXbTEk6n3QynE7gKkPGXFKjRIRjrNpjqXDTnnipaiRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAPjJ0Akd0svKdOHH1Io6LrtfttFKfpDlFWpqyYor8snITeVIBxQJnQ4NF+rkyOceqe8CzfKCdTS09BtQ+H75glfqMtYOXzQFJi4JqFVQqJVVRLQ2fQ4laI4WXM3irmtCiPHCMSHLYsKuFiwVSMfVS2K+2a5ufeLv1PNQMakIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu8I+h5L; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bee278c2aso54732801fa.0;
        Mon, 17 Mar 2025 01:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742201163; x=1742805963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxbiKv6elGIs5Nn4LiqGeMrFmApt2xh9/qpgGFawsLg=;
        b=Hu8I+h5LnJymE2H7YdP8UoATNn8PYtkFCt4iTaE+fcgZfz30fmAsR9wc10Bg2jFXyP
         l1ixg6jYsQlgtmmtPeNg31duUpTtLNYcYFMJ2hI92Uhm0W9BddGEFSKbkd/KRAPREF9w
         TMt5Dz3Q5ey7rG0LQjIK7A1xPo1oRCcouIzus5EwREuZxE7JP9IFMZbB7oqHN4A6h/D1
         nqysU8roLHOf2QGAvJpPXcakJUIIAoYtWT5k2jQqwAmU11lrvS1JBQu2OUC0TliZ5B5a
         Hj4t2qpTExnubkz8uBP/1jh6IGxwxDsQCmKgxocPUF6Z4JGF0EBh2mpEQPilvMb+Cy3/
         3/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742201163; x=1742805963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxbiKv6elGIs5Nn4LiqGeMrFmApt2xh9/qpgGFawsLg=;
        b=WDIXtf73dyxtg4WI4q94kIgjPQWkpnpz+eu0eHsU9rlgdJdagifJ6/agV41/+H6DD5
         XQlUbo7enIla2RMfOrBR2FpscwVGVzbG9Y4ji4x8zMQwkePAIjM6EqZRud99CSNzhOTQ
         20ffwgo5FmQbk9v81nzvvMVi8uQzyNGj92RDVJhnF3RvdpVthYDB7LngoSdBD8s17zj7
         phPN68hKkIDiAYsvTBppF9fT9KNY3aZhj3iDPqLELTegdpXTyd1AfUp/rZ5675/eALG0
         tfK2rfouPxucYRR7r3XVNtBqWAy5As5Pdyr9Y3zxMUBLyFOaNBCgbIQ4AqCECTEcMde2
         SoEg==
X-Forwarded-Encrypted: i=1; AJvYcCU4G8004zMh313G2g0vPnKhPB6JURrW9cOGCC5EeiOUODxnuEO8Ayzq7MpzCr2SM5BdsZREwLQnIqMSQbE=@vger.kernel.org, AJvYcCUKi4tR53acydRdNzRDKjXHsIEz/dxp1i89xiSZbX6BZ9/bZe6WOUTwqoM6msQyXosAC/S5yArFuFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtlVPT9c553izfsNJkUSw8DvLgoUrF3PxhwPaLwmxQtqPVUUkI
	EsfjDJkpvoQfiX2+nYGSw/2fcGv5FP2+pjuWn5/OjYXRggfz3MTv
X-Gm-Gg: ASbGncuvNnWYdG5x9WmYUFTBC1YJgWLHGShC0GOqz4xUl96J9pU10Ji+ceoDze6Fu4S
	ZOtK78/bnfevym7Oq+PVst/MAVMtiKacROArqAfXbNFwP5YxuwYKjxBZOQaPQc27DESlqaBxr2w
	l6n9Q7LtHcMyI2btAdidcUi1MBoHv9R9MhDeEI66NgV7DTUonQBzj1RwxRVD/mISkGQCHE4UcRX
	tP3OzfrghNAQUAdzQlZKzJ+CL3/yXZBAjpog00dCsgEnvu0BuIapIvV/bozyd5sXM4jcwrPxLjl
	FZrFZ3JABhdihcSBn0YHkOj0cn/ocMm01+LIIl0RIfAHRgF8x935AwIsZ3S3N64FxGCAe5wyISq
	AbW/dheaH6NjB5NqPkyvvkIcrbQ==
X-Google-Smtp-Source: AGHT+IFeAg/G8whxA4gtxiYZbH0SjBZ7xoClvaA1Vcblwhy4bW0jCjldjrGw6uW7vsQd59L9ZAQ4WA==
X-Received: by 2002:a05:6512:3990:b0:549:68a7:177c with SMTP id 2adb3069b0e04-549ba3d563fmr7023614e87.7.1742201162859;
        Mon, 17 Mar 2025 01:46:02 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a86c1sm1281669e87.21.2025.03.17.01.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:46:02 -0700 (PDT)
Message-ID: <a34c14c1-875d-40a4-8019-67f7b9aa4133@gmail.com>
Date: Mon, 17 Mar 2025 10:46:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] Documentation: Add sysfs documentation for PSCRR
 reboot reason tracking
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Guenter Roeck <groeck@chromium.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, chrome-platform@lists.linux.dev
References: <20250314113604.1776201-1-o.rempel@pengutronix.de>
 <20250314113604.1776201-8-o.rempel@pengutronix.de>
 <a8f76dd0-56be-46a5-9cc1-2d17d013127d@gmail.com>
 <Z9Q4z2dPdpqVcu6u@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9Q4z2dPdpqVcu6u@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 16:10, Oleksij Rempel wrote:
> On Fri, Mar 14, 2025 at 03:38:55PM +0200, Matti Vaittinen wrote:
>> On 14/03/2025 13:36, Oleksij Rempel wrote:
>>> Add documentation for the Power State Change Reason Recorder (PSCRR)
>>> sysfs interface, which allows tracking of system shutdown and reboot
>>> reasons. The documentation provides details on available sysfs entries
>>> under `/sys/kernel/pscrr/`, explaining their functionality, example usage,
>>> and how they interact with different backend storage options (e.g., NVMEM).
>>>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>> ---
>>>    .../ABI/testing/sysfs-kernel-reboot-pscrr     | 46 +++++++++++++++++++
>>>    1 file changed, 46 insertions(+)
>>>    create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
>>> new file mode 100644
>>> index 000000000000..7cc643f89675
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
>>> @@ -0,0 +1,46 @@
>>> +What:		/sys/kernel/pscrr/reason
>>> +Date:		April 2025
>>> +KernelVersion:  6.15
>>> +Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
>>> +Description:
>>> +		This file provides access to the last recorded power state
>>> +		change reason. The storage backend is configurable and, if
>>> +		supported, the reason may be stored persistently in an
>>> +		NVMEM cell or another backend.
>>> +
>>> +		Reading this file returns an integer representing the last
>>> +		recorded shutdown or reboot cause.
>>> +
>>> +		Writing an integer value to this file sets the reason to be
>>> +		stored and recorded for system analysis.
>>> +
>>> +		Example usage (values are for illustration and may not reflect
>>> +		actual reasons used in a given system):
>>> +		  Read:
>>> +			$ cat /sys/kernel/pscrr/reason
>>> +			3   # (Example: Power loss event, may differ per system)
>>> +
>>> +		  Write:
>>> +			$ echo 5 > /sys/kernel/pscrr/reason
>>> +			# Sets the reason to 5 (Example: User-triggered reboot,
>>> +			# this may not be a real value in your system)
>>> +
>>> +		Values are defined in:
>>> +		  - `include/linux/reboot.h` (enum psc_reason)
>>
>> Is it possible to provide the reason (also) as string?
>>
>> I believe we should fix the meaning of the numbers so the ABI is not
>> changing for the users. Hence we could as well document the meaning of the
>> values(?) If I read the suggestion right, we will in any case have
>> predefined set of reasons in the kernel side.
>>
>> Or, am I missing something?
> 
> Yes, it is correct, the values should be fixed for user space. Should
> they be documented in this documentation too?

I believe it could be helpful for both the user-space users and 
potential pscrr provider driver writers. It could also set things to stone.

But, I don't have much experience on the documentation like this so 
please treat this as a suggestion - but do as you see fits best.

Yours,
	-- Matti


