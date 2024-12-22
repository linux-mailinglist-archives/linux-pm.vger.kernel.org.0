Return-Path: <linux-pm+bounces-19650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA79FA501
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2024 10:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012841888973
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2024 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1E188591;
	Sun, 22 Dec 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh8+xO1D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0F176AB5;
	Sun, 22 Dec 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734860294; cv=none; b=OEruLQcNo0EftdhaVTCNTBB1OEqEqgiiDyVWhy7Z1icOFB1V48a3H+fAwrfQS3B/vYWX0+ohljZRb+Gyle9jrWTWT29hyti/uu5nis/0kYsulpJXSe+Cq6zTMLqSSXomhmCGWqk/ypISe1Xnj1hK8jTEQgmSo5BMbO7tAQT0r30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734860294; c=relaxed/simple;
	bh=7/Z4feutFCC0vyPIRuRx3lInp2wI6p1e9mt6TdsadGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3/UIp59duzG0u5D/d+3wbcgxPZY4FSbtJDvALkqdEp5Y384xWrTk27IEjE8pwGfAVzNh+3ff0/TOm4tVYsYxzoxq3Ji5hD1u7W98jnUWGeIRwWiQiceSj0H/fSyIi4yIxdPvc/YpPW4bXousPllSHG8hN5sU2bDAE3ZQSPVwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh8+xO1D; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e3c47434eso3559421e87.3;
        Sun, 22 Dec 2024 01:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734860291; x=1735465091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1VR6WrBGJiq8FcvrsTE/IPll45Ma2lRFsR787hkaUg=;
        b=Rh8+xO1D18dluMTobDqEyFqTZU3lg/iN/z6dVYlzImM3e5Yw3538HANXbrAE9CmWtV
         TrOBC29V8sNU5Vc2D7lkkckttvMA0Hj7wXrXdKjbU64A9GDiQCvwlzMkYIWjuHj1mAtT
         R796KjlSJYdTlsS+q3p1vjD0j2xssTeV05FbP+AQrgeQIeLblQ1xTzFmZTCv4GYfwzp5
         OpKQ4nI7dhnYByf8/6Xcm+g7LzWAvBpd8R6FDVsL7XReGlmqfg2PR4xXcBC/u3Xn/1mo
         IvC6O6PEPDkdfiGZeDAV5Ua1jvE3+3gG0sfvQdx1PSmIPfcEL+kOmzdXlsV1WDWy7nAU
         dmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734860291; x=1735465091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1VR6WrBGJiq8FcvrsTE/IPll45Ma2lRFsR787hkaUg=;
        b=Xh1dCzlqaF6cOFvDO/u+4P9cEt1rUXX64CcuFC939nVBdRW2Sx0ihez8F4crJ+9vgO
         j/PIw9lEOMDJo5rd5EZPqXW//DSh7Q+PXH2ybTRXldZZOof15A13zxYqol1ky3m51l7k
         AEt+6epU9p572dkxn9JL0ysGxKXHN/zgb7sh8G/F0kSV3vFLOSz1+eoSswXA+aV3DJPH
         pDO9dFpBeLBzn9ihkmsxcPYgeyCE4LAyC4IMrvsZJbIcv5wxS1+UnhTAYJkJk11JyHKy
         9pyB4QHdWTDDh508QpHko6THEFFB8X71aaqcohos1Ywr1csSpnN8amEsUAoLXNd/8OJV
         113Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW8wK2cIVnlv8BKY25shvKkAbiOubcqf99xzrJ5hhA7eXYvYYVd9Xv2ogtCSmCPIkc4/oA3YGxxWMDhjTAPn6xRp0M9FUg@vger.kernel.org, AJvYcCUv+eOeQbZLkJQGtT9i+iWmXeRb0ODlgJK+Gfkpu4ObUEgyL1nhEH5vDNmWsXTvqEx8rF5IEfws7+A=@vger.kernel.org, AJvYcCVs9wteDVVDnnuwROr7Stk1NvY12lIZcdvD3kh/fvndqZvE756J7bdBZpfuLQDrO63WnXoUpr1dMJDj@vger.kernel.org, AJvYcCWJODxB0ljhSMjd+xEccAnQhMlobi5G7XHzL0DUuANWPniTXiWBUGlkIMRb/ny/EE3xvTts4vcM08Ny@vger.kernel.org
X-Gm-Message-State: AOJu0YwD67vZYE31yoq2dF62CaT+RI0mdA+3h3/7zWVpjhfCCp9hxzZC
	r4342f/BkcxZxCf19nVdWS5721VJ2kyUtxzZpw3jdocLxFYmaRjj
X-Gm-Gg: ASbGncsw/M/RfzBI6g5/HNUrDJNf5l0H/n1uuLDJ0prYE9B4lWk9CzugjHW0CisOjOf
	9VL3yrypPymvbfcVQYWGNgPp7mRtd16Dxn7SO0QVsIaYB8Z/ZP5KXidCOKRZprr15rssUqNxHwY
	cBNDBQkLHY/IvzttS+PGf9gDdBCX2UO97v6E83+ev2Aw6pyR8GGqyNbkMhJw3ZKo/WOCX7dfON/
	2jscRFIUbobwDzV5RKnU0viV0+vo7wNaI2RQ8wk5npbgwjWwa3OW4WH3u2Z8KuEN2mxiRvkYKv1
	hhRr95JqtV9JqvdykbEuzo6INYo7y7+kbKg=
X-Google-Smtp-Source: AGHT+IEBtKIpnX8TZ6UDUpxSD2fI++u22nBQeqIjoQjnAxtybi0jVENYejU8eL4eDzo/jSMChxACSg==
X-Received: by 2002:a05:6512:2815:b0:540:1a0c:9bac with SMTP id 2adb3069b0e04-5422954b420mr3045195e87.34.1734860290772;
        Sun, 22 Dec 2024 01:38:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:419:b800::7? (2001-14ba-419-b800--7.rev.dnainternet.fi. [2001:14ba:419:b800::7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f66c8sm913969e87.3.2024.12.22.01.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 01:38:09 -0800 (PST)
Message-ID: <dc8d1cdf-dff4-48fc-a03d-aeab9be22e44@gmail.com>
Date: Sun, 22 Dec 2024 11:38:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] reboot: support runtime configuration of emergency
 hw_protection action
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
 kernel@pengutronix.de, Matteo Croce <mcroce@microsoft.com>
References: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2024 09:31, Ahmad Fatoum wrote:
> We currently leave the decision of whether to shutdown or reboot to
> protect hardware in an emergency situation to the individual drivers.
> 
> This works out in some cases, where the driver detecting the critical
> failure has inside knowledge: It binds to the system management controller
> for example or is guided by hardware description that defines what to do.
> 
> This is inadequate in the general case though as a driver reporting e.g.
> an imminent power failure can't know whether a shutdown or a reboot would
> be more appropriate for a given hardware platform.

Sometimes it can. There are platforms where the hardware is such we know 
that poweroff or reboot are the way to go. In such case the driver 
should get the information from the hardware description (like device-tree).

> To address this, this series adds a hw_protection kernel parameter and
> sysfs toggle that can be used to change the action from the shutdown
> default to reboot. A new hw_protection_trigger API then makes use of
> this default action.
> 
> My particular use case is unattended embedded systems that don't
> have support for shutdown and that power on automatically when power is
> supplied:
> 
>    - A brief power cycle gets detected by the driver
>    - The kernel powers down the system and SoC goes into shutdown mode
>    - Power is restored
>    - The system remains oblivious to the restored power

This sounds like a consequence of a hardware design as restoring the 
power doesn't wake up the SoC(?)

>    - System needs to be manually power cycled for a duration long enough
>      to drain the capacitors
> 
> With this series, such systems can configure the kernel with
> hw_protection=reboot to have the boot firmware worry about critical
> conditions.

I am not against the change though. Just wondering if this is still a 
consequence of the hardware design, and if the device-tree would be 
proper place to indicate that poweroff shouldn't be used.

I'm about to leave my computer behind for holidays, so I am probably not 
able to do a proper review until the next year. Thus this quick comment 
:) Also, no strong opinion so I'm not expecting anyone to hold back 
waiting for me!

Good luck and happy holidays!
-- Matti

> ---
> Ahmad Fatoum (11):
>        reboot: replace __hw_protection_shutdown bool action parameter with an enum
>        reboot: reboot, not shutdown, on hw_protection_reboot timeout
>        docs: thermal: sync hardware protection doc with code
>        reboot: rename now misleading hw_protection symbols
>        reboot: indicate whether it is a HARDWARE PROTECTION reboot or shutdown
>        reboot: add support for configuring emergency hardware protection action
>        regulator: allow user configuration of hardware protection action
>        platform/chrome: cros_ec_lpc: prepare for hw_protection_shutdown removal
>        dt-bindings: thermal: give OS some leeway in absence of critical-action
>        thermal: core: allow user configuration of hardware protection action
>        reboot: retire hw_protection_reboot and hw_protection_shutdown helpers
> 
>   Documentation/ABI/testing/sysfs-kernel-reboot      |   8 ++
>   Documentation/admin-guide/kernel-parameters.txt    |   6 +
>   .../devicetree/bindings/thermal/thermal-zones.yaml |   5 +-
>   Documentation/driver-api/thermal/sysfs-api.rst     |  25 +++--
>   drivers/platform/chrome/cros_ec_lpc.c              |   2 +-
>   drivers/regulator/core.c                           |   4 +-
>   drivers/regulator/irq_helpers.c                    |  16 +--
>   drivers/thermal/thermal_core.c                     |  17 +--
>   drivers/thermal/thermal_core.h                     |   1 +
>   drivers/thermal/thermal_of.c                       |   7 +-
>   include/linux/reboot.h                             |  25 +++--
>   include/uapi/linux/capability.h                    |   1 +
>   kernel/reboot.c                                    | 122 ++++++++++++++++-----
>   13 files changed, 173 insertions(+), 66 deletions(-)
> ---
> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> change-id: 20241218-hw_protection-reboot-96953493726a
> 
> Best regards,


