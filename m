Return-Path: <linux-pm+bounces-24243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A22A67268
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 12:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50517A36FE
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25DB1F416E;
	Tue, 18 Mar 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE9sb8UL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D551AA1E0;
	Tue, 18 Mar 2025 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296664; cv=none; b=KUXYGfJEVUkeSqNSQgnFz+QiQlVx0zs4iyvIJzMQhFv/ItYTRU6CAFMikEXUPHqAvn0sgdRj8E80/2OqZHjFIFCXMzk+WFDJXClVR9xYZIuoQikTBblQhnU2vW2dsNdIvdxF/cHoCbSdyGtkqRsE4R8/5S1ch9Tgwtxwf5palJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296664; c=relaxed/simple;
	bh=2Ec7Z1ZyLJXW2zP9y6qMMcTSwNBqwQ7NVjLvy+7iE8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCvtXH/fmaX0puSO1p0VQyKQF4q5kX2B8cQvDwix58KY0hH0WlFKsDmsBoUmGisb+gqZwB3Gib0AWmj0zBu2/vqy+nC21NgCC/kfGPJTjYk//HGFfxHnIP9lzAGTN022nsNHoJcoMdIXGqoQ0wsTTBSTv/I4fqyd9uczbTd3UMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE9sb8UL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so6302327e87.3;
        Tue, 18 Mar 2025 04:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742296660; x=1742901460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOlZvPQ7plTaQIDmVp+CNwq3xUPH59xTsSW9rNTGInQ=;
        b=TE9sb8ULiGxVjvgZeuPas3bYAye5lP6DLvBL9gHQmWmc+D+tVu4f4rRpSUb9BmrS/V
         cl5HxH4miK8KAOW+5nMkgAhZxaKDbB/F2GR7HRt+23nPjKYpao2uQa95dV0ecSfL/0kD
         ba5mVeAwJAjyT6Z5E8SBCz8V1CAGb5+5teMNRDRcbHldgyPo0mIhZp9ghgGCYyQWTqRO
         7NYYnstV/wlzmLTTyVdMHTB/e2zoiDUQJweHcGDsYTp7qeIiDnhR9/cx+FOZd0/0p7+K
         B4J6VhK3/A0AqQCI/qgK4iTeYtPPsZ3zLFGSEOa5DLosqUZMf4zIU8HQ8dB0a0+rIUFM
         e7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742296660; x=1742901460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOlZvPQ7plTaQIDmVp+CNwq3xUPH59xTsSW9rNTGInQ=;
        b=LqEmD9eXwJOVx/qvpfmfq+L1o6gtMrgISJv8XJcpJYqLiuvAPWYE68lSEQ9pVS3mWJ
         8BQlbCYibhfbtEUo0jmqreJLpfeBz8QrUYsuwgsFVAus8P9MW3PZFWe1U2yxSm9F/diJ
         c0Iy4ClDytK3EwTVrZO7/eq+/hHE6JMKt49UD24xwXrndrZySPXZI7oQ+oHoIxtmXNdY
         +72ARUCoZMvdCRiv3JNEop34QfcnWcrciuzu86jjHltw2Q4Fqoj7nJzXIq+3D0naZbFY
         5iaL1NbOS3gP4jcvmndoo7JpwLO3MLZ96McY1VQcf8HyKnWPxItuws0jVDUgPwv3bcv6
         JlKg==
X-Forwarded-Encrypted: i=1; AJvYcCUXrI0sTOiE7bV6+q3ePohU8BXmYChtR4j5X/JW4oBW7923EgDFyu7hQmoldcbUfDv0HiSdY4vfohE=@vger.kernel.org, AJvYcCXIpKMUxCoGSvwzjYfxT+Re8G6JHknCMqCAWzeDf4nE07v/lKMBUQuxVD6VJD1UDhiGgWgy0ewjVhQ5hRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8a/9PMkCV0Rf9K4e+urKc+YWHBuwTy09ZQglnZwYQg/heJ0eH
	5llk+Lqm9Rg+1ltW/dWjCh3XpkL3kpqfkCOup/mW5WxNmAXOwUOG
X-Gm-Gg: ASbGncsGPOYLKy7acU1POCFIl4xFHbu6mU8TrRdyo2j+ngRtbgJ2GRZgnG9GqTGLKWS
	RxFG6K5PD+wMlWXBgsCAWCJM1WYQHvFpOQ3Lp70NarpFQ5rzZzOIctO9oCYP6eaXCnU7q+RqT3s
	E2+Tzx+gouoXg0UuERp7LHdUUquEgagECmNpZqhZwALYJ6ppOKUkmme3NV8pMaSLQg6vFG4nzw6
	xDarTX5WiNScXcBo5ntvOKElV5b5gWSmwu0u104LN/WiWxjvdfNBA67YsboTqFVg5mhHGyigG8T
	76jJu209XTsawUSNF9kRsftyImF5NY7pUoUO9FG9yJKB9etVib+fzB1NkPjs0NP0m0Gc
X-Google-Smtp-Source: AGHT+IHp+pjQHewdxhxdhXjAb7AHr19mAfFloImy7dF2DkvFzyLcoPPgreehc44oS0N8uADZE3CHGQ==
X-Received: by 2002:a05:6512:308f:b0:549:86c8:113a with SMTP id 2adb3069b0e04-54a03b8d777mr2826078e87.15.1742296659689;
        Tue, 18 Mar 2025 04:17:39 -0700 (PDT)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864de4sm1621258e87.139.2025.03.18.04.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 04:17:39 -0700 (PDT)
Message-ID: <cda899c6-4330-465c-80b2-63c9da73505b@gmail.com>
Date: Tue, 18 Mar 2025 13:17:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] Documentation: Add sysfs documentation for PSCRR
 reboot reason tracking
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Guenter Roeck <groeck@chromium.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, chrome-platform@lists.linux.dev
References: <20250318094716.3053546-1-o.rempel@pengutronix.de>
 <20250318094716.3053546-8-o.rempel@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250318094716.3053546-8-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 11:47, Oleksij Rempel wrote:
> Add documentation for the Power State Change Reason Recorder (PSCRR)
> sysfs interface, which allows tracking of system shutdown and reboot
> reasons. The documentation provides details on available sysfs entries
> under `/sys/kernel/pscrr/`, explaining their functionality, example usage,
> and how they interact with different backend storage options (e.g., NVMEM).
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v7:
> - document expected values
> ---
>   .../ABI/testing/sysfs-kernel-reboot-pscrr     | 79 +++++++++++++++++++
>   1 file changed, 79 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> new file mode 100644
> index 000000000000..9aa3df8f2fc7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> @@ -0,0 +1,79 @@
> +What:		/sys/kernel/pscrr/reason
> +Date:		April 2025
> +KernelVersion:  6.15
> +Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
> +Description:
> +		This file provides access to the last recorded power state
> +		change reason. The storage backend is configurable and, if
> +		supported, the reason may be stored persistently in an
> +		NVMEM cell or another backend.
> +
> +		Reading this file returns an integer representing the last
> +		recorded shutdown or reboot cause.
> +
> +		Writing an integer value to this file sets the reason to be
> +		stored and recorded for system analysis.
> +
> +		Example usage (values are for illustration and may not reflect
> +		actual reasons used in a given system):
> +		  Read:
> +			$ cat /sys/kernel/pscrr/reason
> +			3   # (Example: Power loss event, may differ per system)
> +
> +		  Write:
> +			$ echo 5 > /sys/kernel/pscrr/reason
> +			# Sets the reason to 5 (Example: User-triggered reboot,
> +			# this may not be a real value in your system)

nit:
Now that the 'number' <=> 'reason' relation is fixed, we might drop the 
"may differ" etc. Perhaps just:

		Example usage:
		  Read:
			$ cat /sys/kernel/pscrr/reason
			3   # (Example: Power loss event)

		  Write:
			$ echo 5 > /sys/kernel/pscrr/reason
			# Sets the reason to 5 (Example: User-triggered reboot)

Maybe adding a note that not all values are supported on all systems.


> +
> +		Values are defined in:
> +		  - `include/linux/reboot.h` (enum psc_reason)
> +
> +		Supported Values:
> +		Defined in `include/linux/reboot.h` (enum psc_reason):
> +
> +		+-------+---------------------------+--------------------------+
> +		| Value | Symbol                    | Description              |
> +		+-------+---------------------------+--------------------------+
> +		| 0     | PSCR_UNKNOWN              | Unknown or unspecified   |
> +		|       |                           | power state change reason|
> +		+-------+---------------------------+--------------------------+
> +		| 1     | PSCR_UNDER_VOLTAGE        | Supply voltage drop below|
> +		|       |                           | safe threshold.          |
> +		+-------+---------------------------+--------------------------+
> +		| 2     | PSCR_OVER_CURRENT         | Excessive current draw,  |
> +		|       |                           | potential short circuit. |
> +		+-------+---------------------------+--------------------------+
> +		| 3     | PSCR_REGULATOR_FAILURE    | Failure in voltage       |
> +		|       |                           | regulator, preventing    |
> +		|       |                           | stable power delivery.   |
> +		+-------+---------------------------+--------------------------+
> +		| 4     | PSCR_OVER_TEMPERATURE     | Unsafe system temperature|
> +		|       |                           | detected by sensors.     |
> +		+-------+---------------------------+--------------------------+
> +		| 5     | PSCR_EC_PANIC             | Shutdown/reboot triggered|
> +		|       |                           | by Embedded Controller   |
> +		|       |                           | (EC) panic.              |
> +		+-------+---------------------------+--------------------------+
> +
> +		(Note: The actual reason codes used on a specific system depend
> +		on hardware capabilities and configuration.)

I like this. Nice and clean.

A side note which you can consider if you feel like:
This, as far as I understand, will also make the ABI out of this. So, 
perhaps there should be comments in enum psc_reason and the defines in 
Defined in 'include/linux/reboot.h' that they are part of an ABI, and 
must not be changed? I suppose user-space tools may get unhappy if these 
values change between the kernel versions.

> +
> +What:		/sys/kernel/pscrr/reason_boot
> +Date:		April 2025
> +KernelVersion:  6.15
> +Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
> +Description:
> +		This file provides the last recorded power state change reason
> +		from before the current system boot. If a supported backend
> +		(e.g., NVMEM) is configured, this value is retained across
> +		reboots.
> +
> +		Example usage (values are for illustration and may not reflect
> +		actual reasons used in a given system):
> +		  Read:
> +			$ cat /sys/kernel/pscrr/reason_boot
> +			2   # (Example: Over-temperature shutdown, may differ per system)
> +
> +		Supported Values:
> +		Same as `/sys/kernel/pscrr/reason` (see above).
> +

All in all, this looks very good to me.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

