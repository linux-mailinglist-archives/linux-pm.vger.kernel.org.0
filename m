Return-Path: <linux-pm+bounces-24135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C35A64466
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 08:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E69916F2A1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1384521B918;
	Mon, 17 Mar 2025 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3/c6cL9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101221ADC6;
	Mon, 17 Mar 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198107; cv=none; b=aZ4WElXFcmspeIsnka4TF7JnK1DFuC3P8/FbNzF4WNdPuiFgfo2s1W4hGTTUe95c9TENssJO9/W0KEUw1DSIc4+X7n99/Fe5kZrHqxyKWBY23BHfaj99MHDFlwla6VXXYxFxjbz+DmvwratxMm+tCwZPRLTBRmczJGnl/CpW/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198107; c=relaxed/simple;
	bh=kCkc4N+7QhSoIFulEWpB4EZ2H9QujvTV7t+ztLrDXes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tR7cV4c+sf9OI+UNmo1OaVO43R4UbAgBOm54tD7/4V/PJMQnKrYxjSwBr3cv4OVmeAFEyLWGZUCDQ//L7JwHoOovZNC8DBRHUSUC9b5+oMTbYrwEtnXcmgPaCq7C8FXR7vSoF8eJZJxPJNqUyNFzrxryWlhaoOkbI6cJJZqYMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3/c6cL9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5497590ffbbso4578456e87.1;
        Mon, 17 Mar 2025 00:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742198103; x=1742802903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PGlkNj5JuQM/oiAzbkxBTyJefdHugxU09PeAiuQE7o=;
        b=P3/c6cL937kUd0rSqqPwVxFsJhuU9gl2AqhcN25Fy45SKH6E9yuUKQiNkm9S9uZ9rU
         Q96Iy7TsAd/CROfZhVCc/Gy3CUBRMauNkVj2oHPni/lyYAPOD52b6N0DJsjQm0nj78lg
         ZRr5HIve2tEJ1cdrp0MlqmNXcXUYeXLTpyubgDCA/nSQo6Ey70qlRNSxl2M3kmRzDrsS
         CWZBFKeJi+p+4gaBKxbGlsQkfFxfwQf3PBZVaYEOqgSpWtXaEmyBEW2mxDg1cF5+axq0
         cYBBMH+rZf9yMzdCoIehd0TQEwV1d67r59PVjL4pci89jIhQ5Xq2pdfjA52ZJ9FOJH7I
         iAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742198103; x=1742802903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PGlkNj5JuQM/oiAzbkxBTyJefdHugxU09PeAiuQE7o=;
        b=vyG7i0byHaAR/99qPwzjXCKpQ0BIqkET46HG7LHr/90uQY/vQsGJPMqdYCDBLzugIF
         Z6aBgztQcrOXvUj9v5Smsn/KJ4bufKP3KnruCTm3mX7BXngwJ6rF202ZnyEZkeBqYU2E
         Pd9TsltUhVHXZH8hATTK5VIi5aQceqEEF+lmjXcLgJGtBty/Btt9LnEUR6tJ1UdHqBx3
         b48gr1XpzpQlfaucMtcMy5NJNvGBmmD53r1Uo3poPdEOD01ocJIT/7uWqkIgaweqpPgp
         Kr515w36KBTSqOaEAamGbRNcMhioVWdpfqoplcOOeUGYKbfj6hE3TygmMXdhtTNB1NX/
         Ee+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTOVVIduaFj1XmPPXy2ndXOILlJLhscsOaE47TL/kdJU0jTO6m8Kw6GcDCjoITiZeRWzaPpXcTvyl5a+k=@vger.kernel.org, AJvYcCWNkxp0+m8YTMHTZyLuOSkYMlsxklmPzRkExNXttn1i+Kwfd2vQrEbGT84qwB5Wls1EYnm2tpIF9N4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3jYbfQjI0jfoWsNs2Pm9cSgHqbQHMNI1eKw8cJIIkQsnYLGD
	4PHTkZoYgdB3eOg2dH3l8gE+DnkFLLNeaLW8Ljo5lyn1sWNNWdOu
X-Gm-Gg: ASbGncuqnoz26DUYHUYUjtPxEyJfhuCWE3nBzlhny9qRwTxpB347dZ+i/ymIaforNFX
	eS8aBKTJX9z/klx3FIjVSZ4LbTQutc00T8XUFLlSfB9X+rHPH0kQ8JLbJ2We43Z1TlwrO0eSutl
	hdS/Nw/TpcSqERvoI4x5Bo4siErUde+8JzSUkGRX2JUN93QRop/YS6K08oBNEH9oB1/bT6+Hqki
	tiOp0wX8z/oRchkBBBzUmjjgXDjYULxlhMSCkhFwEhajw5+a2P24BTwOSrvibbdQh+cK6OTlHvx
	zgXkLeQvLnhr7x7SuxYf1XM/VxbUgY8UEvewPyTW+//4xq5wV1f5CWA4HaKMGv1r/d004G0VJxt
	TdxMYrtRQ/bS6dG/hGNpyCikL0g==
X-Google-Smtp-Source: AGHT+IHpSYFJH34gIO7tBqgPtELK+iiAIDW1hiL3+I6Fh1bFLkfP7bnMzxpGii0X1yem28TLEK8LGg==
X-Received: by 2002:a05:6512:6cc:b0:549:7145:5d25 with SMTP id 2adb3069b0e04-549c396e1f1mr5578803e87.34.1742198102726;
        Mon, 17 Mar 2025 00:55:02 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a702asm1234607e87.212.2025.03.17.00.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 00:55:02 -0700 (PDT)
Message-ID: <1a9252ba-d793-4b7e-8fb3-6a35a171c688@gmail.com>
Date: Mon, 17 Mar 2025 09:55:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
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
 <20250314113604.1776201-4-o.rempel@pengutronix.de>
 <58e19481-530c-4465-aec5-1f44462eaf5f@gmail.com>
 <Z9Q18k_wu1JQxrtJ@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9Q18k_wu1JQxrtJ@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/03/2025 15:58, Oleksij Rempel wrote:
> Hi Matti,
> 
> Thanks for your feedback and for taking the time to review this patch series!
> 
> On Fri, Mar 14, 2025 at 02:22:40PM +0200, Matti Vaittinen wrote:
>> Hi deee Ho Oleksij,
>>
>> On 14/03/2025 13:36, Oleksij Rempel wrote:
>>> This commit introduces the Power State Change Reasons Recording (PSCRR)
>>> framework into the kernel. The framework is vital for systems where
>>> PMICs or watchdogs cannot provide information on power state changes. It
>>> stores reasons for system shutdowns and reboots, like under-voltage or
>>> software-triggered events, in non-volatile hardware storage. This
>>> approach is essential for postmortem analysis in scenarios where
>>> traditional storage methods (block devices, RAM) are not feasible. The
>>> framework aids bootloaders and early-stage system components in recovery
>>> decision-making, although it does not cover resets caused by hardware
>>> issues like system freezes or watchdog timeouts.
>>>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>
>> I see you're already at v6, so I am probably slightly late... I think I
>> hadn't noticed this before. Thus, feel free to treat my comments as mere
>> suggestions.
>>
>> All in all, I do like this series. Looks mostly very good to me :) Just
>> wondering if we could utilize this same for standardizing reading the reset
>> reason registers which are included in many PMICs?
>>
>>> ---
>>
>> ...
>>
>>> +int pscrr_core_init(const struct pscrr_backend_ops *ops)
>>> +{
>>> +	enum psc_reason stored_val = PSCR_UNKNOWN;
>>> +	int ret;
>>> +
>>> +	mutex_lock(&pscrr_lock);
>>> +
>>> +	if (g_pscrr) {
>>> +		pr_err("PSCRR: Core is already initialized!\n");
>>> +		ret = -EBUSY;
>>> +		goto err_unlock;
>>> +	}
>>> +
>>> +	if (!ops->read_reason || !ops->write_reason) {
>>> +		pr_err("PSCRR: Backend must provide read and write callbacks\n");
>>
>> Why both are required?
>>
>> I can easily envision integrating the some PMIC's 'boot reason' register
>> reading to the PSCRR. Benefit would be that user-space could use this same
>> interface when reading the reset reason on a system where reason is stored
>> using mechanisms provided by this series - and when reset reason is
>> automatically stored by the HW (for example to a PMIC).
>>
>> In a PMIC case the write_reason might not be needed, right?
>   
> I agree that PMICs could be valuable sources of reset reasons, and integrating
> them into PSCRR makes sense. However, this introduces new challenges when
> multiple providers exist on the same system, each reporting different power
> state change reasons.

I see that now. I didn't think of having multiple sources of this 
information at the same time, but I agree it is a valid setup. For 
example an under voltage warning triggering software reset could leave a 
reason in PSCRR non volatile memory, while it wouldn't leave a trace in 
a PMIC. More severe under voltage on same system might trigger the 
hardware shutdown by the PMIC, which would leave the reason in PMIC but 
not necessarily to the non volatile memory (depending on the amount 
backup-energy). So yes, we might need multiple sources to get a good 
picture. Thanks for pointing this out to me.

> Handling Multiple Read-Only Providers (PMIC, Firmware, etc.):
> - If we have multiple sources (e.g., PMIC, firmware logs, NVMEM-based storage),
>    we need to define how to handle conflicting or differing reset reasons.
> - Using priorities may work in simple cases but is unlikely to scale well
>    across different platforms.
> - A more flexible solution would be to expose all read-only providers
>    separately, rather than forcing one to override others.
> 
> Potential UAPI and Sysfs Structure
> - The current sysfs API exposes:
>    - `/sys/kernel/pscrr/reason` → Default recorder
>    - `/sys/kernel/pscrr/reason_boot` → Last stored reason on default recorder
>       from before boot
> - If we introduce read-only providers (like PMICs), we may need a dedicated
>    subdirectory to keep them separate.
> - A possible structure:
>    ```
>    /sys/kernel/pscrr/
>    ├── reason         # Default recorder
>    ├── reason_boot    # Default recorder (before boot)
>    ├── providers/
>    │   ├── pmic0      # Read-only reset reason from PMIC
>    │   ├── firmware   # Reset reason from firmware logs
>    │   ├── another_provider
>    ```
> - This would allow user-space tools to query all available sources while keeping
>    the default recorder behavior intact.
> 
> Next Steps
> - I propose keeping this patch series focused on the default PSCRR recorder.
> - Support for multiple read-only providers should be designed as a future
>    extension, possibly with an expanded sysfs API.

Makes sense. Better to get something ready than keep everything on the 
table. :) Still wonder if we should allow registering read-only 
providers, even if we supported only a single source? But, I am not 
insisting this, just doing a suggestion. Don't want to make "the 
perfect" to be the enemy of good. (Actually, when I think of it, in many 
cases I wouldn't want to even make the "good" to be enemy of "much 
better than nothing").

> Would you agree that this approach keeps things maintainable while allowing
> for future extensibility?

Sure.

> Also, do you have a preference for naming the
> subdirectory (`providers/`, `sources/`, etc.)?

I am bad with naming but both of those would work for me :)

Yours,
	-- Matti


