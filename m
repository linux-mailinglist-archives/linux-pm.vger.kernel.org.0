Return-Path: <linux-pm+bounces-30687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DFCB01D00
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 15:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F483188C31E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F18E28B507;
	Fri, 11 Jul 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R31KGjmv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D22C17A8
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239319; cv=none; b=rM/WjhZeLOWxuOK7Fy3m7xRPwgfYJeeCTFOyfJNZo1x62ANJxmXMIuDrTdKsHElIoTwS3wDf0Wdd6t9fQ92qIevwxt+VPIOoOjA6S9OSlw4vdFGedn9X6zjIyVTKAcgK9Sf4/HHameizyOH7Z8P0iG3MxXoCEdvz+dGVaH+jWgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239319; c=relaxed/simple;
	bh=Xjdm9ExlH7oB5XPsjPDpF9eGiFNSYYLAZb1dvWPuols=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOHMp25N3TNFHmj4yCNiAMtNQpjzoGI+YSExw2cSq00ouN2ydO+ldr7117uV66gfSXUCbPly4G9VpDyAix2ZUgwYi52udq/7oxEfM09nnMDfkh/qzrPy2uTl1VEQ47HrJ/MRgKcAJHbA8B7GoUxoH1hrtgZJFvlE22UpbCIMWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R31KGjmv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0de1c378fso327478366b.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752239307; x=1752844107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MgnbktmCg+/tvdlTNvBlX1iNGkgMyyqPOUfD3qirROg=;
        b=R31KGjmvkV4Hru5UtWHfa0IyfJ1+wnLLzFBg7lHNNyrYuIR4gUvbO0kZ3xOcHI5PX3
         tprOy7Na0QUj+MBSg2GDfFcd2wE3H4YS5CePVaDxyLnXMt8sJQl5/PP/NRmtU8XF69rq
         q05PC8f6jSQi3D7Md3u1gp8Mp7pZeOumsaS9WJ9kdiKfZk3PQ8tFvq7tkt6lp4y65dYV
         b8zd4by3K0ibKK0qpwC9hy2Kt1fXsWJyWRxcFbCrCk4RMQcO8QqQcZMS/E4upiGKd3Q5
         z8AROsgG627dk70qGBNUg3IHHnt1MHQa1LrxqDj/jZQLrcZvi3cEJavCm2kUaGf8k3mE
         TDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752239307; x=1752844107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgnbktmCg+/tvdlTNvBlX1iNGkgMyyqPOUfD3qirROg=;
        b=IXMOTaJ3QVsPHjmItqtIXjIEbGn+fydzZ/ZQmt7ooYFKaFLcRbxDoPVXw/qJI9FFVP
         hMI2JWLoBm7wQMkRqzamzyHfffsdFe0U60RJYhTTBrYyaKl8QZOAYiFON4N3okgYLJnT
         xbD3asqiXfGQIn06hh+issFtby8h7gEBzCe4iwq3N8ATfvmAQ1ZuL9weW5nF65RA0bJW
         HrTNTx/kRWK8GYRFsaaTzJ61vxihAD4E4R0mJ0OjdBXUFeO5wu9LWzIqcqD05/sbcLuu
         h9Yy7dVJG/Rvj/3eI78a0gsYgBHGrd+8dVfFKZdi4lmwZivLbNwIgLyl4coSgr07EONF
         uhdg==
X-Forwarded-Encrypted: i=1; AJvYcCXKWnNy1xsjEP0GxyGd/65TnCR83+h51IyR7MuwRhjVrepPDXdUIbmfZ0YMtRQWC+ESqVzD8kGMFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsV0pQH2caBj5WF1pSxeQjvBUWcKpStfOmC1c3yO1WKAX+2/9
	vQ2dFYjB5cGKYslhYvQ6ZIMWMWc8h90i47jl3jIk8ERQzjjsMM1eaHOkeWW19VE8d4D7OcpAydY
	qPdCE
X-Gm-Gg: ASbGncsbuHdxVR1m4ThAAtWcxd5jHa/0TPOjP3OmVhsP3ggwC1xM+kW35A5R5gy8fv6
	S0yrzsV5r43/6IYKlbexd9Tmzd6V9Qah4wQrq7tmTUupseMs2k0k797w4PXRccD8MGMgRR9lnRD
	WtA3sLDbw7Y6vKzVJsMNDuuJQD4lU3M+mzsZdYCE+mBRXgjXAUMLduAWpw3cn8n1ttnPP7yFgaG
	gG/Sa6Gs6tiJYXMGjDzArCXD+gbIRUTYNYxfo0y8kBunyYMisS3V6XLYvi+iAA7nmYptjCJKqJZ
	fpAIR+dmtL+Toa2kcqGhwztbkT+7UE90wm/EPKRTq7nmaxA+S3CoRAErd40JFT11b+4kGdN0j5F
	JVDmsRVV2giEnvl0T4eNDQLSs77CMf8AF
X-Google-Smtp-Source: AGHT+IGnu3bbCw9YBuTF1XkSlExjKpg0j6ijZMBLW4qAlxHwlHEEvbxAF0ElTtuyW/C58RfAoK5z3Q==
X-Received: by 2002:a17:907:1b0b:b0:ae3:5e70:330d with SMTP id a640c23a62f3a-ae6fbc109bamr332098866b.12.1752239304476;
        Fri, 11 Jul 2025 06:08:24 -0700 (PDT)
Received: from [192.168.0.251] ([188.27.143.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e9235esm300242066b.12.2025.07.11.06.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:08:23 -0700 (PDT)
Message-ID: <e13740a0-88f3-4a6f-920f-15805071a7d6@linaro.org>
Date: Fri, 11 Jul 2025 14:08:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>,
 William McVicker <willmcvicker@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <22630663.EfDdHjke4D@rjwysocki.net>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <22630663.EfDdHjke4D@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi, Rafael,

On 3/14/25 12:50 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> According to [1], the handling of device suspend and resume, and
> particularly the latter, involves unnecessary overhead related to
> starting new async work items for devices that cannot make progress
> right away because they have to wait for other devices.
> 
> To reduce this problem in the resume path, use the observation that
> starting the async resume of the children of a device after resuming
> the parent is likely to produce less scheduling and memory management
> noise than starting it upfront while at the same time it should not
> increase the resume duration substantially.
> 
> Accordingly, modify the code to start the async resume of the device's
> children when the processing of the parent has been completed in each
> stage of device resume and only start async resume upfront for devices
> without parents.
> 
> Also make it check if a given device can be resumed asynchronously
> before starting the synchronous resume of it in case it will have to
> wait for another that is already resuming asynchronously.
> 
> In addition to making the async resume of devices more friendly to
> systems with relatively less computing resources, this change is also
> preliminary for analogous changes in the suspend path.
> 
> On the systems where it has been tested, this change by itself does
> not affect the overall system resume duration in a measurable way.
> 
> Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@google.com/ [1]
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'd like to let you know of a suspend crash that I'm dealing with
when using the OOT pixel6 drivers on top of v6.16-rc4.

Similar to what Jon reported, everything gets back to normal if
I disable pm_async or if I revert the following patches:
443046d1ad66 PM: sleep: Make suspend of devices more asynchronous
aa7a9275ab81 PM: sleep: Suspend async parents after suspending children
0cbef962ce1f PM: sleep: Resume children after resuming the parent

I also reverted their fixes when testing:
8887abccf8aa PM: sleep: Add locking to dpm_async_resume_children()
d46c4c839c20 PM: sleep: Fix power.is_suspended cleanup for direct-complete devices
079e8889ad13 PM: sleep: Fix list splicing in device suspend error paths

It seems that the hang happens in dpm_suspend() at
async_synchronize_full() time after a driver fails to suspend.
The phone then naturally resets with an APC watchdog.

[  519.142279][ T7917] lwis lwis-eeprom-m24c64x: Can't suspend because eeprom-m24c64x is in use!
[  519.143556][ T7917] lwis-i2c eeprom@2: PM: dpm_run_callback(): platform_pm_suspend returns -16
[  519.143872][ T7917] lwis-i2c eeprom@2: PM: platform_pm_suspend returned -16 after 1596 usecs
[  519.144197][ T7917] lwis-i2c eeprom@2: PM: failed to suspend: error -16
[  519.144448][ T7917] PM: tudor: dpm_suspend: after while loop, list_empty(&dpm_prepared_list)? 1
[  519.144779][ T7917] PM: tudor: dpm_suspend: before async_synchronize_full

The extra prints are because of:
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d9d4fc58bc5a..3efe538c2ec2 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1967,10 +1967,15 @@ int dpm_suspend(pm_message_t state)
                        break;
                }
        }
+       pr_err("tudor: %s: after while loop, list_empty(&dpm_prepared_list)? %d\n",
+              __func__, list_empty(&dpm_prepared_list));
 
        mutex_unlock(&dpm_list_mtx);
 
+       pr_err("tudor: %s: before async_synchronize_full\n", __func__);
        async_synchronize_full();
+       pr_err("tudor: %s: after async_synchronize_full();\n", __func__);
+
        if (!error)
                error = async_error;

The synchronous suspend works because its strict, one-by-one ordering
ensures that device dependencies are met and that no device is suspended
while another is still using it. The asynchronous suspend fails because
it creates a race condition where the lwis-eeprom-m24c64x is called for
suspension before the process using it has been suspended, leading to a
fatal "device busy" error. Should the failure of a device suspend be
fatal?

Below are the async/sync suspend-resume dumps. Thanks!
ta

1/ ASYNC suspend
tudor: Suspending to RAM for 1 second...
[ 1505.264089][T10723] lwis lwis-dpm: Opening instance 20
[ 1505.280037][T10723] lwis lwis-slc: Opening instance 19
[ 1505.280189][T10723] lwis lwis-scsc: Opening instance 9
[ 1505.280280][T10723] lwis lwis-scsc: No LWIS bus manager associated with this device.
[ 1505.282691][T10723] lwis lwis-mcsc: Opening instance 8
[ 1505.282790][T10723] lwis lwis-mcsc: No LWIS bus manager associated with this device.
[ 1505.283072][T10723] lwis lwis-gdc1: Opening instance 11
[ 1505.283164][T10723] lwis lwis-gdc1: No LWIS bus manager associated with this device.
[ 1505.283425][T10723] lwis lwis-gdc0: Opening instance 10
[ 1505.283516][T10723] lwis lwis-gdc0: No LWIS bus manager associated with this device.
[ 1505.283753][T10723] lwis lwis-gtnr-merge: Opening instance 5
[ 1505.283850][T10723] lwis lwis-gtnr-merge: No LWIS bus manager associated with this device.
[ 1505.284134][T10723] lwis lwis-itp: Opening instance 7
[ 1505.284222][T10723] lwis lwis-itp: No LWIS bus manager associated with this device.
[ 1505.284358][T10732] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 01:19:52(0x10)AM
[ 1505.284533][T10723] lwis lwis-gtnr-align: Opening instance 4
[ 1505.284890][T10723] lwis lwis-gtnr-align: No LWIS bus manager associated with this device.
[ 1505.285314][T10723] lwis lwis-g3aa: Opening instance 6
[ 1505.285403][T10723] lwis lwis-g3aa: No LWIS bus manager associated with this device.
[ 1505.286053][T10723] lwis lwis-ipp: Opening instance 3
[ 1505.286141][T10723] lwis lwis-ipp: No LWIS bus manager associated with this device.
[ 1505.286252][T10732] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 01:19:52(0x10)AM
[ 1505.286394][T10723] lwis lwis-pdp: Opening instance 2
[ 1505.286701][T10723] lwis lwis-pdp: No LWIS bus manager associated with this device.
[ 1505.287040][T10723] lwis lwis-csi: Opening instance 1
[ 1505.287181][T10723] lwis lwis-csi: No LWIS bus manager associated with this device.
[ 1505.287644][T10723] lwis lwis-votf: Opening instance 12
[ 1505.287733][T10723] lwis lwis-votf: No LWIS bus manager associated with this device.
[ 1505.287790][T10732] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 01:19:52(0x10)AM
[ 1505.288014][T10723] lwis lwis-flash-lm3644: Opening instance 18
[ 1505.288284][T10732] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_set_alarm: 2025-07-10 01:19:54(0x10)AM
[ 1505.288515][T10723] lwis lwis-flash-lm3644: Connecting client flash-lm3644(00000000609d9f1e) to bus I2C_Bus_7
[ 1505.289297][T10723] lwis lwis-flash-lm3644: Failed to obtain enable gpio list (-16)
[ 1505.289510][T10723] lwis lwis-flash-lm3644: Error power_up_by_default (-16)
[ 1505.289778][T10723] lwis lwis-flash-lm3644: Failed to power up device
[ 1505.291533][T10723] lwis lwis-flash-lm3644: Closing instance 18
[ 1505.291699][T10723] lwis lwis-flash-lm3644: Disconnecting LWIS client flash-lm3644(00000000609d9f1e) from bus I2C_Bus_7
[ 1505.291896][T10723] lwis lwis-ois-lc898128: Opening instance 17
[ 1505.291994][T10723] lwis lwis-ois-lc898128: Connecting client ois-lc898128(00000000609d9f1e) to bus I2C_Bus_1
[ 1505.292162][T10723] lwis lwis-act-ak7377: Opening instance 16
[ 1505.292259][T10723] lwis lwis-act-ak7377: Connecting client act-ak7377(00000000282be506) to bus I2C_Bus_1
[ 1505.292527][T10723] lwis lwis-eeprom-lc898128: Opening instance 13
[ 1505.292758][T10723] lwis lwis-eeprom-lc898128: Connecting client eeprom-lc898128(00000000f5f087a5) to bus I2C_Bus_1
[ 1505.293212][T10723] lwis lwis-eeprom-m24c64x: Opening instance 15
[ 1505.293393][T10723] lwis lwis-eeprom-m24c64x: Connecting client eeprom-m24c64x(00000000126469a8) to bus I2C_Bus_3
[ 1505.293831][T10723] lwis lwis-eeprom-m24c64s: Opening instance 14
[ 1505.294016][T10723] lwis lwis-eeprom-m24c64s: Connecting client eeprom-m24c64s(00000000e2534997) to bus I2C_Bus_2
[ 1505.311663][ T1088] probe of gadget.0 returned 0 after 63729 usecs
[ 1505.314441][T10732] PM: suspend entry (deep)
[ 1505.316067][T10723] i2c 1-0024: Shared i2c pinctrl state on_i2c
[ 1505.319800][T10732] Filesystems sync: 0.005 seconds
[ 1505.319993][T10732] [01:19:52.481332][dhd][wlan]dhd_pm_callback action: 3
[ 1505.326294][T10732] PM: suspend entry 2025-07-10 01:19:52.487634359 UTC
[ 1505.326871][T10732] cpif: s5100_pm_notifier: Suspend prepare
[ 1505.326993][T10732] s3c2410-wdt 10070000.watchdog_cl1: Watchdog cluster 1 keepalive!, old_wtcnt = fcb1, wtcnt = ffaf
[ 1505.327285][T10732] Freezing user space processes
[ 1505.344339][T10732] Freezing user space processes completed (elapsed 0.016 seconds)
[ 1505.344492][T10732] OOM killer disabled.
[ 1505.344567][T10732] Freezing remaining freezable tasks
[ 1505.352756][T10732] Freezing remaining freezable tasks completed (elapsed 0.008 seconds)
[ 1505.356795][T10732] exynos-pcie-rc 11920000.pcie: remove enable cnt to fake enable = 0
[ 1505.360127][T10711] s51xx 0000:01:00.0: PM: calling pci_pm_suspend @ 10711, parent: 0000:00:00.0
[ 1505.360302][T10711] s51xx 0000:01:00.0: PM: pci_pm_suspend returned 0 after 4 usecs
[ 1505.361060][  T436] stmvl53l1 1-0029: PM: calling stmvl53l1_suspend [stmvl53l1] @ 436, parent: i2c-1
[ 1505.361376][  T436] stmvl53l1 1-0029: PM: stmvl53l1_suspend [stmvl53l1] returned 0 after 14 usecs
[ 1505.361748][T10732] platform dbgdev-pd-bus2: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.361929][T10732] platform dbgdev-pd-bus2: PM: platform_pm_suspend returned 0 after 3 usecs
[ 1505.362089][T10732] platform dbgdev-pd-bus1: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.362261][T10732] platform dbgdev-pd-bus1: PM: platform_pm_suspend returned 0 after 2 usecs
[ 1505.362421][T10732] platform dbgdev-pd-aoc: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.362727][T10732] platform dbgdev-pd-aoc: PM: platform_pm_suspend returned 0 after 2 usecs
[ 1505.363051][T10732] platform dbgdev-pd-hsi2: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.363430][T10732] platform dbgdev-pd-hsi2: PM: platform_pm_suspend returned 0 after 2 usecs
[ 1505.363795][T10732] sound pcmC0D32c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.364061][T10732] sound pcmC0D32c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.364344][T10732] sound pcmC0D31p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.364646][T10732] sound pcmC0D31p: PM: do_pcm_suspend returned 0 after 4 usecs
[ 1505.364930][T10732] sound pcmC0D30p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.365231][T10732] sound pcmC0D30p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.365504][T10732] sound pcmC0D29p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.365788][T10732] sound pcmC0D29p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.366102][T10732] sound pcmC0D28p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.366401][T10732] sound pcmC0D28p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.366686][T10732] sound pcmC0D27c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.366986][T10732] sound pcmC0D27c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.367272][T10732] sound pcmC0D26c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.367547][T10732] sound pcmC0D26c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.367857][T10732] sound pcmC0D25p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.368158][T10732] sound pcmC0D25p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.368441][T10732] sound pcmC0D24p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.368743][T10732] sound pcmC0D24p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.369028][T10732] sound pcmC0D23p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.369328][T10732] sound pcmC0D23p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.369605][T10732] sound pcmC0D22c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.369886][T10732] sound pcmC0D22c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.370199][T10732] sound pcmC0D21c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.370499][T10732] sound pcmC0D21c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.370784][T10732] sound pcmC0D20c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.371084][T10732] sound pcmC0D20c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.371369][T10732] sound pcmC0D19p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.371645][T10732] sound pcmC0D19p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.371954][T10732] sound pcmC0D18p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.372254][T10732] sound pcmC0D18p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 1505.372541][T10732] sound pcmC0D17c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.372840][T10732] sound pcmC0D17c: PM: do_pcm_suspend returned 0 after 2 usecs
[ 1505.373125][T10732] sound pcmC0D16p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.373425][T10732] sound pcmC0D16p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 1505.373682][T10732] sound pcmC0D15c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.373984][T10732] sound pcmC0D15c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.374295][T10732] sound pcmC0D14p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.374595][T10732] sound pcmC0D14p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.374882][T10732] sound pcmC0D13c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.375181][T10732] sound pcmC0D13c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.375466][T10732] sound pcmC0D12c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.375767][T10732] sound pcmC0D12c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.376052][T10732] sound pcmC0D11c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.376353][T10732] sound pcmC0D11c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.376637][T10732] sound pcmC0D10c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.376938][T10732] sound pcmC0D10c: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.377223][T10732] sound pcmC0D9c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.377507][T10732] sound pcmC0D9c: PM: do_pcm_suspend returned 0 after 2 usecs
[ 1505.377773][T10732] sound pcmC0D8c: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.378070][T10732] sound pcmC0D8c: PM: do_pcm_suspend returned 0 after 2 usecs
[ 1505.378352][T10732] sound pcmC0D7p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.378652][T10732] sound pcmC0D7p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.378959][T10732] sound pcmC0D5p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.379256][T10732] sound pcmC0D5p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 1505.379509][T10732] sound pcmC0D4p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.379835][T10732] sound pcmC0D4p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.380118][T10732] sound pcmC0D3p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.380413][T10732] sound pcmC0D3p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.380695][T10732] sound pcmC0D2p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.380991][T10732] sound pcmC0D2p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 1505.381275][T10732] sound pcmC0D1p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.381553][T10732] sound pcmC0D1p: PM: do_pcm_suspend returned 0 after 3 usecs
[ 1505.382028][T10732] sound pcmC0D0p: PM: calling do_pcm_suspend @ 10732, parent: card0
[ 1505.382195][T10732] sound pcmC0D0p: PM: do_pcm_suspend returned 0 after 6 usecs
[ 1505.382712][T10732] google-aoc-snd-card sound-aoc: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.382893][T10732] google-aoc-snd-card sound-aoc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 1505.383343][T10732] aoc_uwb_pdrv aoc_gpiochip: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.383516][T10732] aoc_uwb_pdrv aoc_gpiochip: PM: platform_pm_suspend returned 0 after 1 usecs
[ 1505.383931][T10732] input input3: PM: calling input_dev_suspend @ 10732, parent: spi11.0
[ 1505.384129][T10732] input input3: PM: input_dev_suspend returned 0 after 3 usecs
[ 1505.384438][T10732] fts spi11.0: PM: calling fts_pm_suspend [ftm5] @ 10732, parent: spi11
[ 1505.384749][T10732] fts spi11.0: PM: fts_pm_suspend [ftm5] returned 0 after 2 usecs
[ 1505.385055][T10732] rfkill rfkill2: PM: calling rfkill_suspend [rfkill] @ 10732, parent: none
[ 1505.385369][T10732] rfkill rfkill2: PM: rfkill_suspend [rfkill] returned 0 after 4 usecs
[ 1505.385660][T10732] rfkill rfkill1: PM: calling rfkill_suspend [rfkill] @ 10732, parent: phy0
[ 1505.386003][T10732] rfkill rfkill1: PM: rfkill_suspend [rfkill] returned 0 after 3 usecs
[ 1505.386331][T10732] sscoredump wlan: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.386613][T10732] sscoredump wlan: PM: platform_pm_suspend returned 0 after 2 usecs
[ 1505.386532][T10697] ieee80211 phy0: PM: calling wiphy_suspend [cfg80211] @ 10697, parent: none
[ 1505.386733][T10704] pcieh 0001:01:00.0: PM: calling pci_pm_suspend @ 10704, parent: 0001:00:00.0
[ 1505.386921][T10732] leds vibrator: PM: calling led_suspend @ 10732, parent: i2c-c240l2x
[ 1505.386847][T10697] ieee80211 phy0: PM: wiphy_suspend [cfg80211] returned 0 after 21 usecs
[ 1505.388206][T10732] leds vibrator: PM: led_suspend returned 0 after 2 usecs
[ 1505.388501][T10732] backlight panel0-backlight: PM: calling backlight_suspend @ 10732, parent: 1c2c0000.drmdsim.0
[ 1505.388886][T10732] backlight panel0-backlight: PM: backlight_suspend returned 0 after 2 usecs
[ 1505.389190][T10732] panel-samsung-s6e3fc3 1c2c0000.drmdsim.0: PM: calling pm_generic_suspend @ 10732, parent: 1c2c0000.drmdsim
[ 1505.389630][T10732] panel-samsung-s6e3fc3 1c2c0000.drmdsim.0: PM: pm_generic_suspend returned 0 after 1 usecs
[ 1505.390009][T10732] exynos-dsim 1c2c0000.drmdsim: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.390374][T10732] exynos-dsim 1c2c0000.drmdsim: PM: platform_pm_suspend returned 0 after 1 usecs
[ 1505.390742][T10732] rfkill rfkill0: PM: calling rfkill_suspend [rfkill] @ 10732, parent: odm:btbcm
[ 1505.390811][T10700] st21nfc i2c-st21nfc: PM: calling st21nfc_suspend [st21nfc] @ 10700, parent: i2c-7
[ 1505.391085][T10732] rfkill rfkill0: PM: rfkill_suspend [rfkill] returned 0 after 30 usecs
[ 1505.391453][T10700] st21nfc i2c-st21nfc: PM: st21nfc_suspend [st21nfc] returned 0 after 40 usecs
[ 1505.391752][T10732] cs40l2x-codec cs40l2x-codec.4.auto: PM: calling platform_pm_suspend @ 10732, parent: i2c-c240l2x
[ 1505.392498][T10732] cs40l2x-codec cs40l2x-codec.4.auto: PM: platform_pm_suspend returned 0 after 1 usecs
[ 1505.392875][T10732] lwis-i2c ois@0: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.393038][T10697] cs40l2x i2c-c240l2x: PM: calling cs40l2x_sys_suspend [haptics_cs40l2x] @ 10697, parent: i2c-8
[ 1505.393153][T10732] lwis-i2c ois@0: PM: platform_pm_suspend returned 0 after 6 usecs
[ 1505.393644][T10697] cs40l2x i2c-c240l2x: PM: cs40l2x_sys_suspend [haptics_cs40l2x] returned 0 after 21 usecs
[ 1505.393847][T10732] lwis-i2c actuator@0: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.394570][T10732] lwis-i2c actuator@0: PM: platform_pm_suspend returned 0 after 2 usecs
[ 1505.394905][T10732] lwis-i2c eeprom@2: PM: calling platform_pm_suspend @ 10732, parent: platform
[ 1505.395235][T10732] lwis lwis-eeprom-m24c64x: Can't suspend because eeprom-m24c64x is in use!
[ 1505.395559][T10732] lwis-i2c eeprom@2: PM: dpm_run_callback(): platform_pm_suspend returns -16
[ 1505.395888][T10732] lwis-i2c eeprom@2: PM: platform_pm_suspend returned -16 after 655 usecs
[ 1505.396209][T10732] lwis-i2c eeprom@2: PM: failed to suspend: error -16
[ 1505.396460][T10732] PM: tudor: dpm_suspend: after while loop, list_empty(&dpm_prepared_list)? 1
[ 1505.396792][T10732] PM: tudor: dpm_suspend: before async_synchronize_full
[ 1505.399818][T10704] [01:19:52.561155][dhd][wlan]dhd_plat_l1ss_ctrl: Control L1ss RC side 0 ret:0
[ 1505.413173][T10704] pcieh 0001:01:00.0: PM: pci_pm_suspend returned 0 after 25929 usecs
[ 1505.610119][T10182] google,charger google,charger: chg_psy_changed name=usb evt=0
[ 1505.613566][ T9310] google_charger: usbchg=USB typec=C usbv=5100 usbc=0 usbMv=5000 usbMc=100
[ 1505.619073][ T9310] google_battery: MSC_DIN chg_state=1f4113101030001 f=0x1 chg_s=Not Charging chg_t=N/A vchg=4401 icl=500
[ 1505.620778][ T9310] google_battery: MSC_VOTE msc_state=2 cv_cnt=3 ov_cnt=0 rl_sts=-1 temp_idx:2, vbatt_idx:2  fv_uv=4450000 cc_max=0 update_interval=-1
[ 1505.710750][ T9310] google,charger google,charger: chg_psy_changed name=usb evt=0
[ 1505.713907][ T9310] google_charger: usbchg=USB typec=C usbv=5100 usbc=0 usbMv=5000 usbMc=100
[ 1505.717975][ T9310] google_battery: MSC_DIN chg_state=1f4113101030001 f=0x1 chg_s=Not Charging chg_t=N/A vchg=4401 icl=500
[ 1505.719584][ T9310] google_battery: MSC_VOTE msc_state=2 cv_cnt=3 ov_cnt=0 rl_sts=-1 temp_idx:2, vbatt_idx:2  fv_uv=4450000 cc_max=0 update_interval=-1
[ 1505.808452][ T9310] google,charger google,charger: chg_psy_changed name=usb evt=0
[ 1505.811086][  T469] max77759-charger i2c-max77759chrg: max77759_mode_callback:PSP_ENABLED full=1 raw=0 stby_on=0, dc_on=0, chgr_on=1, buck_on=1, boost_on=0, otg_on=0, uno_on=0 wlc_tx=0 wlc_rx=0 usb_wlc=0 chgin_off=0 wlcin_off=0 frs_on=0 pogo_vout=0 pogo_vin=0
[ 1505.814828][  T469] max77759-charger i2c-max77759chrg: max77759_mode_callback:TCPCI use_case=1->1 CHG_CNFG_00=4->4
[ 1505.816445][  T469] max77759-charger i2c-max77759chrg: max77759_mode_callback:PSP_ENABLED full=1 raw=0 stby_on=0, dc_on=0, chgr_on=1, buck_on=1, boost_on=0, otg_on=0, uno_on=0 wlc_tx=0 wlc_rx=0 usb_wlc=0 chgin_off=0 wlcin_off=0 frs_on=0 pogo_vout=0 pogo_vin=0
[ 1505.820064][  T469] max77759-charger i2c-max77759chrg: max77759_mode_callback:TCPCI use_case=1->1 CHG_CNFG_00=4->4
[ 1505.820347][  T469] logbuffer_usbpd: [  158] set input max current 500000 to gcpm, ret=0
[ 1505.820970][ T9310] google,charger google,charger: chg_psy_changed name=usb evt=0
[ 1505.821026][T10182] google_charger: usbchg=USB typec=C usbv=5100 usbc=0 usbMv=5000 usbMc=500
[ 1505.825104][T10182] google_battery: MSC_DIN chg_state=1f4113101030001 f=0x1 chg_s=Not Charging chg_t=N/A vchg=4401 icl=500
[ 1505.827881][T10182] google_battery: MSC_VOTE msc_state=2 cv_cnt=3 ov_cnt=0 rl_sts=-1 temp_idx:2, vbatt_idx:2  fv_uv=4450000 cc_max=0 update_interval=-1
[ 1505.830334][T10182] google_charger: usbchg=USB typec=C usbv=5100 usbc=0 usbMv=5000 usbMc=500
[ 1505.833571][T10182] google_battery: MSC_DIN chg_state=1f4113101030001 f=0x1 chg_s=Not Charging chg_t=N/A vchg=4401 icl=500
[ 1505.834691][T10182] google_battery: MSC_VOTE msc_state=2 cv_cnt=3 ov_cnt=0 rl_sts=-1 temp_idx:2, vbatt_idx:2  fv_uv=4450000 cc_max=0 update_interval=-1
[ 1506.848800][  T247] s2mpg10_irq_thread: interrupt source(0x01)
[ 1506.849097][  T247] s2mpg10_irq_thread: pmic interrupt(0x00, 0x0c, 0x00, 0x00, 0x00, 0x00)
[ 1506.849301][  T247] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_alarm_irq:irq(217)
[ 1506.851365][ T7380] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 01:19:54(0x10)AM
-> APC watchdog happens at this point, resetting the board




2/ SYNC suspend
tudor: Suspending to RAM for 1 second...
[ 7914.754147][T29332] libprocessgroup: Failed to apply CameraServicePerformance process profile
[ 7914.754308][T29332] init: failed to set task profiles
[ 7914.754439][    T1] init: ... started service 'vendor.camera-provider-2-7-google' has pid 29332
[ 7914.762844][T29333] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 03:32:41(0x10)AM
[ 7914.764582][T29333] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 03:32:41(0x10)AM
[ 7914.766011][T29333] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 03:32:41(0x10)AM
[ 7914.766147][T29333] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_set_alarm: 2025-07-10 03:32:43(0x10)AM
[ 7914.787093][T29333] PM: suspend entry (deep)
[ 7914.790500][T29333] Filesystems sync: 0.003 seconds
[ 7914.790672][T29333] [03:32:41.856777][dhd][wlan]dhd_pm_callback action: 3
[ 7914.795614][T29333] PM: suspend entry 2025-07-10 03:32:41.861721024 UTC
[ 7914.795871][T29333] cpif: s5100_pm_notifier: Suspend prepare
[ 7914.795979][T29333] s3c2410-wdt 10070000.watchdog_cl1: Watchdog cluster 1 keepalive!, old_wtcnt = fba0, wtcnt = ffaf
[ 7914.796230][T29333] Freezing user space processes
^C[ 7914.807063][T29333] Freezing user space processes completed (elapsed 0.010 seconds)
[ 7914.807209][T29333] OOM killer disabled.
[ 7914.807280][T29333] Freezing remaining freezable tasks
[ 7914.812317][T29333] Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
[ 7914.815074][T29333] exynos-pcie-rc 11920000.pcie: remove enable cnt to fake enable = 0
[ 7914.818162][T29333] platform dbgdev-pd-bus2: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.818325][T29333] platform dbgdev-pd-bus2: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7914.818473][T29333] platform dbgdev-pd-bus1: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.818630][T29333] platform dbgdev-pd-bus1: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.818777][T29333] platform dbgdev-pd-aoc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.819060][T29333] platform dbgdev-pd-aoc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.819368][T29333] platform dbgdev-pd-hsi2: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.819722][T29333] platform dbgdev-pd-hsi2: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.820084][T29333] s51xx 0000:01:00.0: PM: calling pci_pm_suspend @ 29333, parent: 0000:00:00.0
[ 7914.820404][T29333] s51xx 0000:01:00.0: PM: pci_pm_suspend returned 0 after 2 usecs
[ 7914.820691][T29333] sound pcmC0D32c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.820981][T29333] sound pcmC0D32c: PM: do_pcm_suspend returned 0 after 2 usecs
[ 7914.821263][T29333] sound pcmC0D31p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.821584][T29333] sound pcmC0D31p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 7914.821868][T29333] sound pcmC0D30p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.822169][T29333] sound pcmC0D30p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 7914.822453][T29333] sound pcmC0D29p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.822754][T29333] sound pcmC0D29p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 7914.823039][T29333] sound pcmC0D28p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.823339][T29333] sound pcmC0D28p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.823623][T29333] sound pcmC0D27c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.823926][T29333] sound pcmC0D27c: PM: do_pcm_suspend returned 0 after 2 usecs
[ 7914.824209][T29333] sound pcmC0D26c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.824510][T29333] sound pcmC0D26c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.824774][T29333] sound pcmC0D25p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.825097][T29333] sound pcmC0D25p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 7914.825380][T29333] sound pcmC0D24p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.825681][T29333] sound pcmC0D24p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.825966][T29333] sound pcmC0D23p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.826255][T29333] sound pcmC0D23p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 7914.826551][T29333] sound pcmC0D22c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.826852][T29333] sound pcmC0D22c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.827114][T29333] sound pcmC0D21c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.827437][T29333] sound pcmC0D21c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.827722][T29333] sound pcmC0D20c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.828022][T29333] sound pcmC0D20c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.828287][T29333] sound pcmC0D19p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.828591][T29333] sound pcmC0D19p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.828873][T29333] sound pcmC0D18p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.829172][T29333] sound pcmC0D18p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.829478][T29333] sound pcmC0D17c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.829779][T29333] sound pcmC0D17c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.830063][T29333] sound pcmC0D16p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.830364][T29333] sound pcmC0D16p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.830649][T29333] sound pcmC0D15c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.830949][T29333] sound pcmC0D15c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.831234][T29333] sound pcmC0D14p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.831535][T29333] sound pcmC0D14p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.831819][T29333] sound pcmC0D13c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.832120][T29333] sound pcmC0D13c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.832404][T29333] sound pcmC0D12c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.832690][T29333] sound pcmC0D12c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.832967][T29333] sound pcmC0D11c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.833269][T29333] sound pcmC0D11c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.833552][T29333] sound pcmC0D10c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.833854][T29333] sound pcmC0D10c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.834141][T29333] sound pcmC0D9c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.834459][T29333] sound pcmC0D9c: PM: do_pcm_suspend returned 0 after 2 usecs
[ 7914.834739][T29333] sound pcmC0D8c: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.835037][T29333] sound pcmC0D8c: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.835318][T29333] sound pcmC0D7p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.835616][T29333] sound pcmC0D7p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.835897][T29333] sound pcmC0D5p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.836195][T29333] sound pcmC0D5p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.836475][T29333] sound pcmC0D4p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.836751][T29333] sound pcmC0D4p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.837035][T29333] sound pcmC0D3p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.837352][T29333] sound pcmC0D3p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.837633][T29333] sound pcmC0D2p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.837930][T29333] sound pcmC0D2p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.838212][T29333] sound pcmC0D1p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.838510][T29333] sound pcmC0D1p: PM: do_pcm_suspend returned 0 after 2 usecs
[ 7914.838790][T29333] sound pcmC0D0p: PM: calling do_pcm_suspend @ 29333, parent: card0
[ 7914.839067][T29333] sound pcmC0D0p: PM: do_pcm_suspend returned 0 after 1 usecs
[ 7914.839558][T29333] google-aoc-snd-card sound-aoc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.839725][T29333] google-aoc-snd-card sound-aoc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.840262][T29333] aoc_uwb_pdrv aoc_gpiochip: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.840432][T29333] aoc_uwb_pdrv aoc_gpiochip: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.840863][T29333] input input3: PM: calling input_dev_suspend @ 29333, parent: spi11.0
[ 7914.841073][T29333] input input3: PM: input_dev_suspend returned 0 after 2 usecs
[ 7914.841360][T29333] fts spi11.0: PM: calling fts_pm_suspend [ftm5] @ 29333, parent: spi11
[ 7914.841690][T29333] fts spi11.0: PM: fts_pm_suspend [ftm5] returned 0 after 2 usecs
[ 7914.841996][T29333] rfkill rfkill2: PM: calling rfkill_suspend [rfkill] @ 29333, parent: none
[ 7914.842310][T29333] rfkill rfkill2: PM: rfkill_suspend [rfkill] returned 0 after 3 usecs
[ 7914.842617][T29333] rfkill rfkill1: PM: calling rfkill_suspend [rfkill] @ 29333, parent: phy0
[ 7914.842944][T29333] rfkill rfkill1: PM: rfkill_suspend [rfkill] returned 0 after 2 usecs
[ 7914.843254][T29333] ieee80211 phy0: PM: calling wiphy_suspend [cfg80211] @ 29333, parent: none
[ 7914.843585][T29333] ieee80211 phy0: PM: wiphy_suspend [cfg80211] returned 0 after 5 usecs
[ 7914.843901][T29333] pcieh 0001:01:00.0: PM: calling pci_pm_suspend @ 29333, parent: 0001:00:00.0
[ 7914.857296][T29333] [03:32:41.923402][dhd][wlan]dhd_plat_l1ss_ctrl: Control L1ss RC side 0 ret:0
[ 7914.868771][T29333] pcieh 0001:01:00.0: PM: pci_pm_suspend returned 0 after 24542 usecs
[ 7914.868913][T29333] sscoredump wlan: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.869059][T29333] sscoredump wlan: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.869205][T29333] leds vibrator: PM: calling led_suspend @ 29333, parent: i2c-c240l2x
[ 7914.869344][T29333] leds vibrator: PM: led_suspend returned 0 after 1 usecs
[ 7914.869471][T29333] backlight panel0-backlight: PM: calling backlight_suspend @ 29333, parent: 1c2c0000.drmdsim.0
[ 7914.869851][T29333] backlight panel0-backlight: PM: backlight_suspend returned 0 after 2 usecs
[ 7914.870181][T29333] panel-samsung-s6e3fc3 1c2c0000.drmdsim.0: PM: calling pm_generic_suspend @ 29333, parent: 1c2c0000.drmdsim
[ 7914.870614][T29333] panel-samsung-s6e3fc3 1c2c0000.drmdsim.0: PM: pm_generic_suspend returned 0 after 1 usecs
[ 7914.870998][T29333] exynos-dsim 1c2c0000.drmdsim: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.871366][T29333] exynos-dsim 1c2c0000.drmdsim: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.871716][T29333] rfkill rfkill0: PM: calling rfkill_suspend [rfkill] @ 29333, parent: odm:btbcm
[ 7914.872052][T29333] rfkill rfkill0: PM: rfkill_suspend [rfkill] returned 0 after 2 usecs
[ 7914.872365][T29333] cs40l2x-codec cs40l2x-codec.4.auto: PM: calling platform_pm_suspend @ 29333, parent: i2c-c240l2x
[ 7914.872772][T29333] cs40l2x-codec cs40l2x-codec.4.auto: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.873107][T29333] cs40l2x i2c-c240l2x: PM: calling cs40l2x_sys_suspend [haptics_cs40l2x] @ 29333, parent: i2c-8
[ 7914.873520][T29333] cs40l2x i2c-c240l2x: PM: cs40l2x_sys_suspend [haptics_cs40l2x] returned 0 after 4 usecs
[ 7914.873914][T29333] lwis-i2c ois@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.874217][T29333] lwis-i2c ois@0: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7914.874521][T29333] lwis-i2c actuator@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.874854][T29333] lwis-i2c actuator@0: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7914.875175][T29333] lwis-i2c eeprom@2: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.875503][T29333] lwis-i2c eeprom@2: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.875817][T29333] lwis-i2c eeprom@1: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.876145][T29333] lwis-i2c eeprom@1: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.876459][T29333] lwis-i2c eeprom@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.876776][T29333] lwis-i2c eeprom@0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.877105][T29333] lwis-ioreg 1a440000.lwis_csi: PM: calling lwis_ioreg_device_suspend [lwis] @ 29333, parent: platform
[ 7914.877487][T29333] lwis-ioreg 1a440000.lwis_csi: PM: lwis_ioreg_device_suspend [lwis] returned 0 after 1 usecs
[ 7914.877915][T29333] input input2: PM: calling input_dev_suspend @ 29333, parent: none
[ 7914.878195][T29333] input input2: PM: input_dev_suspend returned 0 after 2 usecs
[ 7914.878477][T29333] stmvl53l1 1-0029: PM: calling stmvl53l1_suspend [stmvl53l1] @ 29333, parent: i2c-1
[ 7914.878812][T29333] stmvl53l1 1-0029: PM: stmvl53l1_suspend [stmvl53l1] returned 0 after 2 usecs
[ 7914.879173][T29333] platform sensor@2: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.879504][T29333] platform sensor@2: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.879792][T29333] platform sensor@1: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.880146][T29333] platform sensor@1: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.880434][T29333] platform sensor@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.880778][T29333] platform sensor@0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.881098][T29333] platform slg51000_gpio: PM: calling platform_pm_suspend @ 29333, parent: 7-0075
[ 7914.881440][T29333] platform slg51000_gpio: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.881764][T29333] regulator regulator.79: PM: calling regulator_suspend @ 29333, parent: 7-0075
[ 7914.882103][T29333] regulator regulator.79: PM: regulator_suspend returned 0 after 3 usecs
[ 7914.882419][T29333] regulator regulator.78: PM: calling regulator_suspend @ 29333, parent: 7-0075
[ 7914.882758][T29333] regulator regulator.78: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.883075][T29333] regulator regulator.77: PM: calling regulator_suspend @ 29333, parent: 7-0075
[ 7914.883413][T29333] regulator regulator.77: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.883730][T29333] regulator regulator.76: PM: calling regulator_suspend @ 29333, parent: 7-0075
[ 7914.884068][T29333] regulator regulator.76: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.884384][T29333] regulator regulator.75: PM: calling regulator_suspend @ 29333, parent: 7-0075
[ 7914.884706][T29333] regulator regulator.75: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.885041][T29333] regulator regulator.74: PM: calling regulator_suspend @ 29333, parent: 7-0075
[ 7914.885378][T29333] regulator regulator.74: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.885696][T29333] regulator regulator.73: PM: calling regulator_suspend @ 29333, parent: 7-0075
[ 7914.886034][T29333] regulator regulator.73: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.886351][T29333] regulator regulator.72: PM: calling regulator_suspend @ 29333, parent: 7-0075
[ 7914.886689][T29333] regulator regulator.72: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.887006][T29333] slg51000-regulator slg51000-regulator: PM: calling platform_pm_suspend @ 29333, parent: 7-0075
[ 7914.887400][T29333] slg51000-regulator slg51000-regulator: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.887775][T29333] platform regulatory.0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.888122][T29333] platform regulatory.0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.888467][T29333] google,usbc_port_cooling_dev google,usbc_port_cooling_dev: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.888893][T29333] google,usbc_port_cooling_dev google,usbc_port_cooling_dev: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.889340][T29333] dwc3 11110000.dwc3: PM: calling platform_pm_suspend @ 29333, parent: 11110000.usb
[ 7914.891773][T29333] phy_exynos_usbdrd 11100000.phy: Request to power_off usbdrd_phy phy
[ 7914.891911][T29333] phy_exynos_usbdrd 11100000.phy: Request to power_off usbdrd_phy phy
[ 7914.892089][T29321] google,charger google,charger: chg_psy_changed name=usb evt=0
[ 7914.892307][T29333] dwc3 11110000.dwc3: PM: platform_pm_suspend returned 0 after 2607 usecs
[ 7914.892483][T29333] platform usb_phy_generic.3.auto: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.892698][T29333] platform usb_phy_generic.3.auto: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.892910][T29333] platform usb_phy_generic.2.auto: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.893335][T29333] platform usb_phy_generic.2.auto: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.893667][T29333] exynos-dwc3 11110000.usb: PM: calling dwc3_exynos_suspend [dwc3_exynos_usb] @ 29333, parent: platform
[ 7914.894110][T29333] exynos-dwc3 11110000.usb: PM: dwc3_exynos_suspend [dwc3_exynos_usb] returned 0 after 7 usecs
[ 7914.894492][T29333] google_cpm google,cpm: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.894885][T29333] google_cpm google,cpm: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7914.895121][T29333] google,charger google,charger: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.895492][T29333] google,charger google,charger: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7914.895894][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu7_memlat@17000010: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.896352][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu7_memlat@17000010: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.896876][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu6_memlat@17000010: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.897387][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu6_memlat@17000010: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.897870][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu5_memlat@17000010: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.898362][T29299] google_charger: failed to get POWER_SUPPLY_PROP_CURRENT_NOW from 'usb', ret=-11
[ 7914.898699][T29299] google_charger: usbchg=USB typec=C usbv=5175 usbc=0 usbMv=5000 usbMc=100
[ 7914.899024][T29299] failed to get psp=181 from 'gcpm', ret=-22
[ 7914.899244][T29299] failed to get GBMS_PROP_CHARGE_CHARGER_STATE from 'gcpm', ret=-22
[ 7914.899544][T29299] failed to get psp=13 from 'gcpm', ret=-22
[ 7914.899763][T29299] failed to get POWER_SUPPLY_PROP_VOLTAGE_NOW from 'gcpm', ret=-22
[ 7914.900060][T29299] failed to get psp=1 from 'gcpm', ret=-11
[ 7914.900275][T29299] failed to get POWER_SUPPLY_PROP_CHARGE_TYPE from 'gcpm', ret=-11
[ 7914.900577][T29299] failed to get psp=0 from 'gcpm', ret=-11
[ 7914.900787][T29299] failed to get POWER_SUPPLY_PROP_STATUS from 'gcpm', ret=-11
[ 7914.901067][T29299] MSC_CHG error vchrg=-22 chg_type=-11 chg_status=-11
[ 7914.901322][T29299] google_charger: MSC_CHG error rerun=1 in 1000 ms (-22)
[ 7914.901588][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu5_memlat@17000010: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.902074][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu4_memlat@17000010: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.902586][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu4_memlat@17000010: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.903075][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu3_memlat@17000010: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.903586][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu3_memlat@17000010: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.904076][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu2_memlat@17000010: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.904591][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu2_memlat@17000010: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.905059][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu1_memlat@17000010: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.905588][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu1_memlat@17000010: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.906078][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu0_memlat@17000010: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.906590][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu0_memlat@17000010: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.907059][T29333] pixel-em pixel-em: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.907411][T29333] pixel-em pixel-em: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.907715][T29333] pcieport 0001:00:00.0: PM: calling pci_pm_suspend @ 29333, parent: pci0001:00
[ 7914.908048][T29333] pcieport 0001:00:00.0: PM: pci_pm_suspend returned 0 after 11 usecs
[ 7914.908767][T29333] exynos-pcie-rc 14520000.pcie: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.908932][T29333] exynos-pcie-rc 14520000.pcie: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.909101][T29333] pcieport 0000:00:00.0: PM: calling pci_pm_suspend @ 29333, parent: pci0000:00
[ 7914.909437][T29333] pcieport 0000:00:00.0: PM: pci_pm_suspend returned 0 after 21 usecs
[ 7914.909774][T29333] sscoredump bigocean: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.910066][T29333] sscoredump bigocean: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.910399][T29333] sscoredump aoc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.910685][T29333] sscoredump aoc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.911013][T29333] aoc 19000000.aoc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.911353][T29333] aoc 19000000.aoc: PM: platform_pm_suspend returned 0 after 21 usecs
[ 7914.911656][T29333] audiometrics audiometrics: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.912001][T29333] audiometrics audiometrics: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.912384][T29333] mali 1c500000.mali: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.912680][T29333] mali 1c500000.mali: PM: platform_pm_suspend returned 0 after 15 usecs
[ 7914.913068][T29333] exynos-drm exynos-drm: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.913335][T29333] exynos-drm exynos-drm: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.913656][T29333] tui-driver tui-driver: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.914003][T29333] tui-driver tui-driver: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.914330][T29333] arm-memlat-mon cpu7-cpugrp:cpu7-cpu-mif-latmon: PM: calling platform_pm_suspend @ 29333, parent: cpu7-cpugrp
[ 7914.914765][T29333] arm-memlat-mon cpu7-cpugrp:cpu7-cpu-mif-latmon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.915169][T29333] arm-memlat-mon cpu6-cpugrp:cpu6-cpu-mif-latmon: PM: calling platform_pm_suspend @ 29333, parent: cpu6-cpugrp
[ 7914.915610][T29333] arm-memlat-mon cpu6-cpugrp:cpu6-cpu-mif-latmon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.916014][T29333] arm-memlat-mon cpu5-cpugrp:cpu5-cpu-mif-latmon: PM: calling platform_pm_suspend @ 29333, parent: cpu5-cpugrp
[ 7914.916454][T29333] arm-memlat-mon cpu5-cpugrp:cpu5-cpu-mif-latmon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.916842][T29333] arm-memlat-mon cpu4-cpugrp:cpu4-cpu-mif-latmon: PM: calling platform_pm_suspend @ 29333, parent: cpu4-cpugrp
[ 7914.917299][T29333] arm-memlat-mon cpu4-cpugrp:cpu4-cpu-mif-latmon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.917703][T29333] arm-memlat-mon cpu3-cpugrp:cpu3-cpu-mif-latmon: PM: calling platform_pm_suspend @ 29333, parent: cpu3-cpugrp
[ 7914.918144][T29333] arm-memlat-mon cpu3-cpugrp:cpu3-cpu-mif-latmon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.918548][T29333] arm-memlat-mon cpu2-cpugrp:cpu2-cpu-mif-latmon: PM: calling platform_pm_suspend @ 29333, parent: cpu2-cpugrp
[ 7914.918989][T29333] arm-memlat-mon cpu2-cpugrp:cpu2-cpu-mif-latmon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.919393][T29333] arm-memlat-mon cpu1-cpugrp:cpu1-cpu-mif-latmon: PM: calling platform_pm_suspend @ 29333, parent: cpu1-cpugrp
[ 7914.919833][T29333] arm-memlat-mon cpu1-cpugrp:cpu1-cpu-mif-latmon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.920238][T29333] arm-memlat-mon cpu0-cpugrp:cpu0-cpu-mif-latmon: PM: calling platform_pm_suspend @ 29333, parent: cpu0-cpugrp
[ 7914.920680][T29333] arm-memlat-mon cpu0-cpugrp:cpu0-cpu-mif-latmon: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7914.921114][T29333] sscoredump mfc-core: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.921423][T29333] sscoredump mfc-core: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.921737][T29333] mfc-core 1c8d0000.MFC-0: PM: calling platform_pm_suspend @ 29333, parent: mfc
[ 7914.922076][T29333] mfc-core 1c8d0000.MFC-0: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7914.922421][T29333] gs101-spmic-thermal gs101-spmic-thermal: PM: calling platform_pm_suspend @ 29333, parent: i2c-s2mpg11
[ 7914.922820][T29333] gs101-spmic-thermal gs101-spmic-thermal: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.923221][T29333] s2mpg1x_gpio s2mpg11_gpio: PM: calling platform_pm_suspend @ 29333, parent: i2c-s2mpg11
[ 7914.923572][T29333] s2mpg1x_gpio s2mpg11_gpio: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.923910][T29333] odpm s2mpg11-odpm: PM: calling platform_pm_suspend @ 29333, parent: s2mpg11-meter
[ 7914.925427][T29333] odpm s2mpg11-odpm: PM: platform_pm_suspend returned 0 after 1171 usecs
[ 7914.925570][T29333] s2mpg11-meter s2mpg11-meter: PM: calling platform_pm_suspend @ 29333, parent: i2c-s2mpg11
[ 7914.925737][T29333] s2mpg11-meter s2mpg11-meter: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.925891][T29333] regulator regulator.71: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.926057][T29333] regulator regulator.71: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.926333][T29333] regulator regulator.70: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.926709][T29333] regulator regulator.70: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.927025][T29333] regulator regulator.69: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.927400][T29333] regulator regulator.69: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.927717][T29333] regulator regulator.68: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.928092][T29333] regulator regulator.68: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.928408][T29333] regulator regulator.67: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.928784][T29333] regulator regulator.67: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.929101][T29333] regulator regulator.66: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.929475][T29333] regulator regulator.66: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.929793][T29333] regulator regulator.65: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.930167][T29333] regulator regulator.65: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.930484][T29333] regulator regulator.64: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.930859][T29333] regulator regulator.64: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.931177][T29333] regulator regulator.63: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.931551][T29333] regulator regulator.63: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.931868][T29333] regulator regulator.62: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.932224][T29333] regulator regulator.62: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.932560][T29333] regulator regulator.61: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.932915][T29333] regulator regulator.61: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.933253][T29333] regulator regulator.60: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.933626][T29333] regulator regulator.60: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.933943][T29333] regulator regulator.59: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.934318][T29333] regulator regulator.59: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.934635][T29333] regulator regulator.58: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.935009][T29333] regulator regulator.58: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.935327][T29333] regulator regulator.57: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.935702][T29333] regulator regulator.57: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.936019][T29333] regulator regulator.56: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.936393][T29333] regulator regulator.56: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.936715][T29333] regulator regulator.55: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.937066][T29333] regulator regulator.55: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.937402][T29333] regulator regulator.54: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.937777][T29333] regulator regulator.54: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.938094][T29333] regulator regulator.53: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.938469][T29333] regulator regulator.53: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.938786][T29333] regulator regulator.52: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.939160][T29333] regulator regulator.52: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.939477][T29333] regulator regulator.51: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.939852][T29333] regulator regulator.51: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.940169][T29333] regulator regulator.50: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.940547][T29333] regulator regulator.50: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.940840][T29333] regulator regulator.49: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.941236][T29333] regulator regulator.49: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.941553][T29333] regulator regulator.48: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.941927][T29333] regulator regulator.48: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.942245][T29333] regulator regulator.47: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.942619][T29333] regulator regulator.47: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.942918][T29333] regulator regulator.46: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.943312][T29333] regulator regulator.46: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.943628][T29333] regulator regulator.45: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.943984][T29333] regulator regulator.45: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.944299][T29333] regulator regulator.44: PM: calling regulator_suspend @ 29333, parent: s2mpg11-regulator
[ 7914.944675][T29333] regulator regulator.44: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.945008][T29333] s2mpg11-regulator s2mpg11-regulator: PM: calling platform_pm_suspend @ 29333, parent: i2c-s2mpg11
[ 7914.945473][T29333] s2mpg11-regulator s2mpg11-regulator: PM: platform_pm_suspend returned 0 after 58 usecs
[ 7914.945800][T29333] exynos-pcie-rc 11920000.pcie: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.946158][T29333] exynos-pcie-rc 11920000.pcie: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.946506][T29333] s2mpg11 i2c-s2mpg11: PM: calling s2mpg11_suspend [s2mpg11_mfd] @ 29333, parent: i2c-21
[ 7914.946872][T29333] s2mpg11 i2c-s2mpg11: PM: s2mpg11_suspend [s2mpg11_mfd] returned 0 after 5 usecs
[ 7914.947241][T29333] s2mpg1x_gpio s2mpg10_gpio: PM: calling platform_pm_suspend @ 29333, parent: i2c-s2mpg10
[ 7914.947588][T29333] s2mpg1x_gpio s2mpg10_gpio: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.947926][T29333] odpm s2mpg10-odpm: PM: calling platform_pm_suspend @ 29333, parent: s2mpg10-meter
[ 7914.949667][T29333] odpm s2mpg10-odpm: PM: platform_pm_suspend returned 0 after 1395 usecs
[ 7914.949809][T29333] s2mpg10-meter s2mpg10-meter: PM: calling platform_pm_suspend @ 29333, parent: i2c-s2mpg10
[ 7914.949975][T29333] s2mpg10-meter s2mpg10-meter: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.950128][T29333] alarmtimer alarmtimer.1.auto: PM: calling platform_pm_suspend @ 29333, parent: rtc0
[ 7914.951639][T29333] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 03:32:41(0x10)AM
[ 7914.953126][T29333] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 03:32:41(0x10)AM
[ 7914.953268][T29333] alarmtimer alarmtimer.1.auto: PM: platform_pm_suspend returned 0 after 2982 usecs
[ 7914.953427][T29333] rtc rtc0: PM: calling rtc_suspend @ 29333, parent: s2mpg10-rtc
[ 7914.955084][T29333] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 03:32:41(0x10)AM
[ 7914.955244][T29333] rtc rtc0: PM: rtc_suspend returned 0 after 1685 usecs
[ 7914.955374][T29333] s2mpg10-rtc s2mpg10-rtc: PM: calling platform_pm_suspend @ 29333, parent: i2c-s2mpg10
[ 7914.955540][T29333] s2mpg10-rtc s2mpg10-rtc: PM: platform_pm_suspend returned 0 after 4 usecs
[ 7914.955692][T29333] regulator regulator.43: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.955921][T29333] regulator regulator.43: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.956237][T29333] regulator regulator.42: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.956625][T29333] regulator regulator.42: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.956908][T29333] regulator regulator.41: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.957303][T29333] regulator regulator.41: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.957620][T29333] regulator regulator.40: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.957994][T29333] regulator regulator.40: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.958312][T29333] regulator regulator.39: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.958686][T29333] regulator regulator.39: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.959003][T29333] regulator regulator.38: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.959378][T29333] regulator regulator.38: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.959696][T29333] regulator regulator.37: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.960070][T29333] regulator regulator.37: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.960386][T29333] regulator regulator.36: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.960767][T29333] regulator regulator.36: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.961079][T29333] regulator regulator.35: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.961453][T29333] regulator regulator.35: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.961772][T29333] regulator regulator.34: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.962145][T29333] regulator regulator.34: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.962463][T29333] regulator regulator.33: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.962837][T29333] regulator regulator.33: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.963154][T29333] regulator regulator.32: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.963529][T29333] regulator regulator.32: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.963846][T29333] regulator regulator.31: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.964220][T29333] regulator regulator.31: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.964539][T29333] regulator regulator.30: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.964913][T29333] regulator regulator.30: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.965230][T29333] regulator regulator.29: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.965604][T29333] regulator regulator.29: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.965922][T29333] regulator regulator.28: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.966297][T29333] regulator regulator.28: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.966613][T29333] regulator regulator.27: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.966988][T29333] regulator regulator.27: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.967305][T29333] regulator regulator.26: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.967679][T29333] regulator regulator.26: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.967997][T29333] regulator regulator.25: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.968371][T29333] regulator regulator.25: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.968691][T29333] regulator regulator.24: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.969044][T29333] regulator regulator.24: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.969380][T29333] regulator regulator.23: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.969755][T29333] regulator regulator.23: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.970073][T29333] regulator regulator.22: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.970446][T29333] regulator regulator.22: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.970764][T29333] regulator regulator.21: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.971138][T29333] regulator regulator.21: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.971456][T29333] regulator regulator.20: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.971830][T29333] regulator regulator.20: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.972148][T29333] regulator regulator.19: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.972527][T29333] regulator regulator.19: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.972817][T29333] regulator regulator.18: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.973195][T29333] regulator regulator.18: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.973531][T29333] regulator regulator.17: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.973906][T29333] regulator regulator.17: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.974223][T29333] regulator regulator.16: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.974578][T29333] regulator regulator.16: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.974896][T29333] regulator regulator.15: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.975289][T29333] regulator regulator.15: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.975607][T29333] regulator regulator.14: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.975963][T29333] regulator regulator.14: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.976279][T29333] regulator regulator.13: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.976661][T29333] regulator regulator.13: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.976972][T29333] regulator regulator.12: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.977365][T29333] regulator regulator.12: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.977682][T29333] regulator regulator.11: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.978057][T29333] regulator regulator.11: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.978374][T29333] regulator regulator.10: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.978748][T29333] regulator regulator.10: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.979066][T29333] regulator regulator.9: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.979437][T29333] regulator regulator.9: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.979751][T29333] regulator regulator.8: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.980122][T29333] regulator regulator.8: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.980436][T29333] regulator regulator.7: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.980809][T29333] regulator regulator.7: PM: regulator_suspend returned 0 after 2 usecs
[ 7914.981102][T29333] regulator regulator.6: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.981492][T29333] regulator regulator.6: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.981806][T29333] regulator regulator.5: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.982177][T29333] regulator regulator.5: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.982491][T29333] regulator regulator.4: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.982862][T29333] regulator regulator.4: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.983176][T29333] regulator regulator.3: PM: calling regulator_suspend @ 29333, parent: s2mpg10-regulator
[ 7914.983548][T29333] regulator regulator.3: PM: regulator_suspend returned 0 after 1 usecs
[ 7914.983883][T29333] s2mpg10-regulator s2mpg10-regulator: PM: calling platform_pm_suspend @ 29333, parent: i2c-s2mpg10
[ 7914.984322][T29333] s2mpg10-regulator s2mpg10-regulator: PM: platform_pm_suspend returned 0 after 57 usecs
[ 7914.984655][T29333] s2mpg10 i2c-s2mpg10: PM: calling s2mpg10_suspend [s2mpg10_mfd] @ 29333, parent: i2c-20
[ 7914.984991][T29333] s2mpg10 i2c-s2mpg10: PM: s2mpg10_suspend [s2mpg10_mfd] returned 0 after 7 usecs
[ 7914.985364][T29333] pca9468 12-0057: PM: calling pca9468_suspend [pca9468] @ 29333, parent: i2c-12
[ 7914.985694][T29333] pca9468 12-0057: PM: pca9468_suspend [pca9468] returned 0 after 2 usecs
[ 7914.986015][T29333] google_mitigation google,mitigation: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7914.986408][T29333] google_mitigation google,mitigation: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7914.986808][T29333] at24 8-0050: PM: calling pm_runtime_force_suspend @ 29333, parent: i2c-8
[ 7914.987097][T29333] at24 8-0050: PM: pm_runtime_force_suspend returned 0 after 2 usecs
[ 7914.987411][T29333] st21nfc i2c-st21nfc: PM: calling st21nfc_suspend [st21nfc] @ 29333, parent: i2c-7
[ 7914.987753][T29333] st21nfc i2c-st21nfc: PM: st21nfc_suspend [st21nfc] returned 0 after 3 usecs
[ 7914.988122][T29333] input input1: PM: calling input_dev_suspend @ 29333, parent: none
[ 7914.988384][T29333] input input1: PM: input_dev_suspend returned 0 after 2 usecs
[ 7914.988853][T29333] sd 0:0:0:3: PM: calling scsi_bus_suspend @ 29333, parent: target0:0:0
[ 7914.998754][T29333] sd 0:0:0:3: PM: scsi_bus_suspend returned 0 after 9757 usecs
[ 7914.998920][T29333] sd 0:0:0:2: PM: calling scsi_bus_suspend @ 29333, parent: target0:0:0
[ 7915.027312][T29333] sd 0:0:0:2: PM: scsi_bus_suspend returned 0 after 28247 usecs
[ 7915.027481][T29333] sd 0:0:0:1: PM: calling scsi_bus_suspend @ 29333, parent: target0:0:0
[ 7915.042956][T29333] sd 0:0:0:1: PM: scsi_bus_suspend returned 0 after 15331 usecs
[ 7915.043119][T29333] sd 0:0:0:0: PM: calling scsi_bus_suspend @ 29333, parent: target0:0:0
[ 7915.054275][T29333] sd 0:0:0:0: PM: scsi_bus_suspend returned 0 after 11010 usecs
[ 7915.054442][T29333] scsi 0:0:0:49456: PM: calling scsi_bus_suspend @ 29333, parent: target0:0:0
[ 7915.054656][T29333] scsi 0:0:0:49456: PM: scsi_bus_suspend returned 0 after 64 usecs
[ 7915.054803][T29333] scsi 0:0:0:49476: PM: calling scsi_bus_suspend @ 29333, parent: target0:0:0
[ 7915.055013][T29333] scsi 0:0:0:49476: PM: scsi_bus_suspend returned 0 after 63 usecs
[ 7915.055162][T29333] ufs_device_wlun 0:0:0:49488: PM: calling scsi_bus_suspend @ 29333, parent: target0:0:0
[ 7915.096937][T29333] ufs_device_wlun 0:0:0:49488: PM: scsi_bus_suspend returned 0 after 41559 usecs
[ 7915.097115][T29333] scsi target0:0:0: PM: calling scsi_bus_suspend @ 29333, parent: host0
[ 7915.097264][T29333] scsi target0:0:0: PM: scsi_bus_suspend returned 0 after 4 usecs
[ 7915.097411][T29333] scsi host0: PM: calling scsi_bus_suspend @ 29333, parent: 14700000.ufs
[ 7915.097559][T29333] scsi host0: PM: scsi_bus_suspend returned 0 after 2 usecs
[ 7915.097691][T29333] exynos-ufs 14700000.ufs: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.100201][T29333] exynos-ufs 14700000.ufs: PM: platform_pm_suspend returned 0 after 2181 usecs
[ 7915.100444][T29333] edgetpu_platform 1ce00000.abrolhos: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.100636][T29333] edgetpu_platform 1ce00000.abrolhos: PM: platform_pm_suspend returned 0 after 4 usecs
[ 7915.100811][T29333] lwis-ioreg 1a4e0000.lwis_votf: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.100981][T29333] lwis-ioreg 1a4e0000.lwis_votf: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.101220][T29333] lwis-ioreg 1bc40000.lwis_gtnr_merge: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.101576][T29333] lwis-ioreg 1bc40000.lwis_gtnr_merge: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.101995][T29333] s5p-mfc mfc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.102276][T29333] s5p-mfc mfc: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.102573][T29333] lwis-ioreg 1b760000.lwis_mcsc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.102938][T29333] lwis-ioreg 1b760000.lwis_mcsc: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.103298][T29333] lwis-ioreg 1b450000.lwis_itp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.103656][T29333] lwis-ioreg 1b450000.lwis_itp: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.104008][T29333] lwis-ioreg 1ac80000.lwis_gtnr_align: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.104394][T29333] lwis-ioreg 1ac80000.lwis_gtnr_align: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.104766][T29333] lwis-ioreg 1ac40000.lwis_ipp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.105114][T29333] lwis-ioreg 1ac40000.lwis_ipp: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.105478][T29333] lwis-ioreg 1aa40000.lwis_pdp: PM: calling lwis_ioreg_device_suspend [lwis] @ 29333, parent: platform
[ 7915.105891][T29333] lwis-ioreg 1aa40000.lwis_pdp: PM: lwis_ioreg_device_suspend [lwis] returned 0 after 2 usecs
[ 7915.106287][T29333] lwis-ioreg 1ba80000.lwis_scsc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.106652][T29333] lwis-ioreg 1ba80000.lwis_scsc: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.107008][T29333] lwis-ioreg 1ba60000.lwis_gdc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.107371][T29333] lwis-ioreg 1ba60000.lwis_gdc: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.107723][T29333] lwis-ioreg 1ba40000.lwis_gdc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.108087][T29333] lwis-ioreg 1ba40000.lwis_gdc: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.108437][T29333] lwis-ioreg 1a840000.lwis_g3aa: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.108819][T29333] lwis-ioreg 1a840000.lwis_g3aa: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.109140][T29333] exynos-jpeg 1c700000.smfc: PM: calling smfc_suspend [smfc] @ 29333, parent: platform
[ 7915.109514][T29333] exynos-jpeg 1c700000.smfc: PM: smfc_suspend [smfc] returned 0 after 3 usecs
[ 7915.109855][T29333] exynos-g2d 1c640000.g2d: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.110201][T29333] exynos-g2d 1c640000.g2d: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.110542][T29333] exynos-decon 1c302000.drmdecon: PM: calling decon_suspend [exynos_drm] @ 29333, parent: platform
[ 7915.110941][T29333] exynos-decon 1c302000.drmdecon: PM: decon_suspend [exynos_drm] returned 0 after 13 usecs
[ 7915.111313][T29333] exynos-decon 1c300000.drmdecon: PM: calling decon_suspend [exynos_drm] @ 29333, parent: platform
[ 7915.112056][T29333] exynos-decon 1c300000.drmdecon: PM: decon_suspend [exynos_drm] returned 0 after 348 usecs
[ 7915.112328][T29333] exyswd_rng exyswd_rng: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.112507][T29333] exyswd_rng exyswd_rng: PM: platform_pm_suspend returned 0 after 4 usecs
[ 7915.112745][T29333] port 10a00000.uart:0.0: PM: calling pm_runtime_force_suspend @ 29333, parent: 10a00000.uart:0
[ 7915.113154][T29333] port 10a00000.uart:0.0: PM: pm_runtime_force_suspend returned 0 after 7 usecs
[ 7915.113508][T29333] port 175b0000.serial:0.0: PM: calling pm_runtime_force_suspend @ 29333, parent: 175b0000.serial:0
[ 7915.113894][T29333] port 175b0000.serial:0.0: PM: pm_runtime_force_suspend returned 0 after 3 usecs
[ 7915.114822][T29333] gs101-devfreq 17000080.devfreq_bo: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.114998][T29333] gs101-devfreq 17000080.devfreq_bo: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.115173][T29333] gs101-devfreq 17000070.devfreq_mfc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.115361][T29333] gs101-devfreq 17000070.devfreq_mfc: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.115732][T29333] gs101-devfreq 17000060.devfreq_tnr: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.116136][T29333] gs101-devfreq 17000060.devfreq_tnr: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.116597][T29333] gs101-devfreq 17000050.devfreq_cam: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.116869][T29333] gs101-devfreq 17000050.devfreq_cam: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.117267][T29333] gs101-devfreq 17000040.devfreq_disp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.117648][T29333] gs101-devfreq 17000040.devfreq_disp: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.118027][T29333] gs101-devfreq 17000030.devfreq_intcam: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.118416][T29333] gs101-devfreq 17000030.devfreq_intcam: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.118784][T29333] gs101-devfreq 17000020.devfreq_int: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.119181][T29333] gs101-devfreq 17000020.devfreq_int: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.119557][T29333] gs101-devfreq 17000010.devfreq_mif: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.119936][T29333] gs101-devfreq 17000010.devfreq_mif: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.120329][T29333] keycombo keycombo.0.auto: PM: calling platform_pm_suspend @ 29333, parent: keydebug
[ 7915.120647][T29333] keycombo keycombo.0.auto: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.120972][T29333] platform cs_trex3: PM: calling platform_pm_suspend @ 29333, parent: none
[ 7915.121310][T29333] platform cs_trex3: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.121617][T29333] platform cs_trex2: PM: calling platform_pm_suspend @ 29333, parent: none
[ 7915.121938][T29333] platform cs_trex2: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.122246][T29333] platform cs_trex1: PM: calling platform_pm_suspend @ 29333, parent: none
[ 7915.122545][T29333] platform cs_trex1: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.122855][T29333] platform cs_trex0: PM: calling platform_pm_suspend @ 29333, parent: none
[ 7915.123195][T29333] platform cs_trex0: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.123503][T29333] platform cs_funnel2: PM: calling platform_pm_suspend @ 29333, parent: none
[ 7915.123831][T29333] platform cs_funnel2: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.124145][T29333] platform cs_funnel1: PM: calling platform_pm_suspend @ 29333, parent: none
[ 7915.124473][T29333] platform cs_funnel1: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.124787][T29333] platform cs_funnel0: PM: calling platform_pm_suspend @ 29333, parent: none
[ 7915.125115][T29333] platform cs_funnel0: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.125429][T29333] sscoredump debugcore: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.125773][T29333] sscoredump debugcore: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.126093][T29333] gsa-gsc 17c90000.gsa-ns:gsa_gsc@0: PM: calling platform_pm_suspend @ 29333, parent: 17c90000.gsa-ns
[ 7915.126502][T29333] gsa-gsc 17c90000.gsa-ns:gsa_gsc@0: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.126864][T29333] debug-kinfo debug-kinfo: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.127216][T29333] debug-kinfo debug-kinfo: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.127545][T29333] samsung,dma-heap-carveout trusty:mfc_fw_dma_heap: PM: calling platform_pm_suspend @ 29333, parent: trusty
[ 7915.127975][T29333] samsung,dma-heap-carveout trusty:mfc_fw_dma_heap: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.128386][T29333] samsung,dma-heap-carveout trusty:tui_dma_heap: PM: calling platform_pm_suspend @ 29333, parent: trusty
[ 7915.128811][T29333] samsung,dma-heap-carveout trusty:tui_dma_heap: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.129208][T29333] samsung,dma-heap-chunk trusty:video_scaler_dma_heap: PM: calling platform_pm_suspend @ 29333, parent: trusty
[ 7915.129648][T29333] samsung,dma-heap-chunk trusty:video_scaler_dma_heap: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.130069][T29333] samsung,dma-heap-chunk trusty:video_frame_dma_heap: PM: calling platform_pm_suspend @ 29333, parent: trusty
[ 7915.130506][T29333] samsung,dma-heap-chunk trusty:video_frame_dma_heap: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.130923][T29333] samsung,dma-heap-chunk trusty:video_stream_dma_heap: PM: calling platform_pm_suspend @ 29333, parent: trusty
[ 7915.131364][T29333] samsung,dma-heap-chunk trusty:video_stream_dma_heap: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.131787][T29333] trusty-virtio trusty:virtio: PM: calling platform_pm_suspend @ 29333, parent: trusty
[ 7915.132146][T29333] trusty-virtio trusty:virtio: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.132495][T29333] trusty-log trusty:log: PM: calling platform_pm_suspend @ 29333, parent: trusty
[ 7915.132805][T29333] trusty-log trusty:log: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.133137][T29333] trusty-irq trusty:irq: PM: calling platform_pm_suspend @ 29333, parent: trusty
[ 7915.133471][T29333] trusty-irq trusty:irq: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.133812][T29333] s3c64xx-spi 10d60000.spi: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.134172][T29333] s3c64xx-spi 10d60000.spi: PM: platform_pm_suspend returned 0 after 6 usecs
[ 7915.134513][T29333] s3c64xx-spi 10d40000.spi: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.134840][T29333] s3c64xx-spi 10d40000.spi: PM: platform_pm_suspend returned 0 after 5 usecs
[ 7915.135203][T29333] s3c64xx-spi 10d20000.spi: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.135547][T29333] s3c64xx-spi 10d20000.spi: PM: platform_pm_suspend returned 0 after 4 usecs
[ 7915.135889][T29333] s3c64xx-spi 10a20000.spi: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.136236][T29333] s3c64xx-spi 10a20000.spi: PM: platform_pm_suspend returned 0 after 4 usecs
[ 7915.136566][T29333] s3c64xx-spi 10950000.spi: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.136924][T29333] s3c64xx-spi 10950000.spi: PM: platform_pm_suspend returned 0 after 4 usecs
[ 7915.137255][T29333] brcm gps spi spi5.0: PM: calling bcm_spi_suspend [bcm47765] @ 29333, parent: spi5
[ 7915.137611][T29333] brcm gps spi spi5.0: PM: bcm_spi_suspend [bcm47765] returned 0 after 9 usecs
[ 7915.137952][T29333] s3c64xx-spi 10940000.spi: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.138301][T29333] s3c64xx-spi 10940000.spi: PM: platform_pm_suspend returned 0 after 4 usecs
[ 7915.138802][T29333] exynos-mct 10050000.mct: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.138966][T29333] exynos-mct 10050000.mct: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.139326][T29333] exynos5-hsi2c 10d50000.hsi2c: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.139683][T29333] exynos5-hsi2c 10d50000.hsi2c: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.140031][T29333] exynos5-hsi2c 10960000.hsi2c: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.140397][T29333] exynos5-hsi2c 10960000.hsi2c: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.140732][T29333] lwis-i2c flash@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.141074][T29333] lwis-i2c flash@0: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.141422][T29333] exynos5-hsi2c 10970000.hsi2c: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.141748][T29333] exynos5-hsi2c 10970000.hsi2c: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.142095][T29333] exynos5-hsi2c 10920000.hsi2c: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.142462][T29333] exynos5-hsi2c 10920000.hsi2c: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.142813][T29333] exynos5-hsi2c 10910000.hsi2c: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.143178][T29333] exynos5-hsi2c 10910000.hsi2c: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.143526][T29333] exynos5-hsi2c 10900000.hsi2c: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.143893][T29333] exynos5-hsi2c 10900000.hsi2c: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.144243][T29333] nitrous_bluetooth odm:btbcm: PM: calling platform_pm_suspend @ 29333, parent: odm
[ 7915.144585][T29333] nitrous_bluetooth odm:btbcm: PM: platform_pm_suspend returned 0 after 14 usecs
[ 7915.144949][T29333] pps-gpio pps: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.145250][T29333] pps-gpio pps: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.145585][T29333] sbb-mux sbb-mux: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.145869][T29333] sbb-mux sbb-mux: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.146205][T29333] regulator regulator.2: PM: calling regulator_suspend @ 29333, parent: fixedregulator@0
[ 7915.146538][T29333] regulator regulator.2: PM: regulator_suspend returned 0 after 3 usecs
[ 7915.146858][T29333] reg-fixed-voltage fixedregulator@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.147242][T29333] reg-fixed-voltage fixedregulator@0: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.147671][T29333] cp_interface cpif: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.147941][T29333] cp_interface cpif: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.148270][T29333] input input0: PM: calling input_dev_suspend @ 29333, parent: gpio_keys
[ 7915.148564][T29333] input input0: PM: input_dev_suspend returned 0 after 3 usecs
[ 7915.148838][T29333] gpio-keys gpio_keys: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.149196][T29333] gpio-keys gpio_keys: PM: platform_pm_suspend returned 0 after 9 usecs
[ 7915.149531][T29333] exynos-uart 175b0000.serial: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.151334][T29333] exynos-uart 175b0000.serial: PM: platform_pm_suspend returned 0 after 1465 usecs
[ 7915.151644][T29333] platform icc-debugfs-client: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.151812][T29333] platform icc-debugfs-client: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.151980][T29333] smccc_trng smccc_trng: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.152138][T29333] smccc_trng smccc_trng: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.152581][T29333] regulator regulator.1: PM: calling regulator_suspend @ 29333, parent: cs35l41_dummy_regulator@0
[ 7915.152758][T29333] regulator regulator.1: PM: regulator_suspend returned 0 after 2 usecs
[ 7915.152944][T29333] touch_bus_negotiator tbn: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.153317][T29333] touch_bus_negotiator tbn: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.153649][T29333] cp_shmem cp_shmem: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.153983][T29333] cp_shmem cp_shmem: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.154291][T29333] google,battery google,battery: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.154667][T29333] google,battery google,battery: PM: platform_pm_suspend returned 0 after 3 usecs
[ 7915.155013][T29333] platform seclog: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.155340][T29333] platform seclog: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.155641][T29333] gs-tmu 100b0000.TPU: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.156031][T29333] gs-tmu 100b0000.TPU: PM: platform_pm_suspend returned 0 after 50 usecs
[ 7915.156300][T29333] gs-tmu 100b0000.ISP: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.157009][T29333] gs-tmu 100b0000.ISP: PM: platform_pm_suspend returned 0 after 358 usecs
[ 7915.157152][T29333] gs-tmu 100b0000.G3D: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.157351][T29333] gs-tmu 100b0000.G3D: PM: platform_pm_suspend returned 0 after 50 usecs
[ 7915.157619][T29333] gs-tmu 100a0000.LITTLE: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.158004][T29333] gs-tmu 100a0000.LITTLE: PM: platform_pm_suspend returned 0 after 35 usecs
[ 7915.158298][T29333] gs-tmu 100a0000.MID: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.158673][T29333] gs-tmu 100a0000.MID: PM: platform_pm_suspend returned 0 after 35 usecs
[ 7915.158956][T29333] gs-tmu 100a0000.BIG: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.160453][T29333] gs_tmu_suspend: TMU suspend
[ 7915.160560][T29333] gs-tmu 100a0000.BIG: PM: platform_pm_suspend returned 0 after 1263 usecs
[ 7915.160705][T29333] s3c2410-wdt 10070000.watchdog_cl1: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.160880][T29333] s3c2410-wdt 10070000.watchdog_cl1: PM: platform_pm_suspend returned 0 after 6 usecs
[ 7915.161040][T29333] s3c2410-wdt 10060000.watchdog_cl0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.161289][T29333] s3c2410-wdt 10060000.watchdog_cl0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.161652][T29333] arm-memlat-mon cpu7-cpugrp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.162015][T29333] arm-memlat-mon cpu7-cpugrp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.162353][T29333] arm-memlat-mon cpu6-cpugrp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.162717][T29333] arm-memlat-mon cpu6-cpugrp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.163054][T29333] arm-memlat-mon cpu5-cpugrp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.163419][T29333] arm-memlat-mon cpu5-cpugrp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.163756][T29333] arm-memlat-mon cpu4-cpugrp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.164119][T29333] arm-memlat-mon cpu4-cpugrp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.164458][T29333] arm-memlat-mon cpu3-cpugrp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.164824][T29333] arm-memlat-mon cpu3-cpugrp: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.165138][T29333] arm-memlat-mon cpu2-cpugrp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.165524][T29333] arm-memlat-mon cpu2-cpugrp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.165861][T29333] arm-memlat-mon cpu1-cpugrp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.166225][T29333] arm-memlat-mon cpu1-cpugrp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.166563][T29333] arm-memlat-mon cpu0-cpugrp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.166927][T29333] arm-memlat-mon cpu0-cpugrp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.167265][T29333] devfreq-memlat gs_memlat_devfreq: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.167650][T29333] devfreq-memlat gs_memlat_devfreq: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.168007][T29333] exynos-devfreq-root exynos_devfreq: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.168398][T29333] exynos-devfreq-root exynos_devfreq: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.168773][T29333] exynos-dm 17000000.exynos-dm: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.169115][T29333] exynos-dm 17000000.exynos-dm: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.169478][T29333] i2c-acpm acpm_mfd_bus@17510000: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.169854][T29333] i2c-acpm acpm_mfd_bus@17510000: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.170205][T29333] i2c-acpm acpm_mfd_bus@17500000: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.170582][T29333] i2c-acpm acpm_mfd_bus@17500000: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.170933][T29333] google,slc-acpm slc-acpm: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.171291][T29333] google,slc-acpm slc-acpm: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.171622][T29333] google,slc slc-dummy: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.171966][T29333] google,slc slc-dummy: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.172283][T29333] power_stats acpm_stats: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.172637][T29333] power_stats acpm_stats: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.172937][T29333] gs-acpm-ipc 17610000.acpm_ipc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.173314][T29333] gs-acpm-ipc 17610000.acpm_ipc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.173680][T29333] gs-acpm 17440000.acpm: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.174028][T29333] gs-acpm 17440000.acpm: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.174348][T29333] acpm-stress mbox: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.174681][T29333] acpm-stress mbox: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.174984][T29333] acpm_flexpmu_dbg acpm_flexpmu_dbg: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.175372][T29333] acpm_flexpmu_dbg acpm_flexpmu_dbg: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.175714][T29333] exynos-cpuhp exynos-cpuphp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.176097][T29333] exynos-cpuhp exynos-cpuphp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.176476][T29333] eh 17100000.eh: PM: calling eh_suspend [eh] @ 29333, parent: platform
[ 7915.176749][T29333] eh 17100000.eh: PM: eh_suspend [eh] returned 0 after 6 usecs
[ 7915.177009][T29333] exynos-uart 10a00000.uart: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.177686][T29333] exynos-uart 10a00000.uart: PM: platform_pm_suspend returned 0 after 318 usecs
[ 7915.177840][T29333] gs101_clock 1e080000.clock-controller: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.178133][T29333] gs101_clock 1e080000.clock-controller: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.178507][T29333] exynos-cal-if 1e080000.cal_if: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.178881][T29333] exynos-cal-if 1e080000.cal_if: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.179228][T29333] pixel-reboot pixel-reboot: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.179589][T29333] pixel-reboot pixel-reboot: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.179924][T29333] arm_dsu_pmu dsu-pmu-0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.180271][T29333] arm_dsu_pmu dsu-pmu-0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.180597][T29333] platform 17460000.system-controller: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.180967][T29333] platform 17460000.system-controller: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.181354][T29333] exynos-pmu-if 17460000.exynos-pmu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.181741][T29333] exynos-pmu-if 17460000.exynos-pmu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.182102][T29333] exynos-pm 174d0000.exynos-pm: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.182473][T29333] exynos-pm 174d0000.exynos-pm: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.182817][T29333] armv8-pmu arm-pmu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.183151][T29333] armv8-pmu arm-pmu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.183459][T29333] simple-pm-bus amba: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.183797][T29333] simple-pm-bus amba: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.184107][T29333] platform timer: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.184431][T29333] platform timer: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.184734][T29333] goodix_fp odm:goodixfp: PM: calling platform_pm_suspend @ 29333, parent: odm
[ 7915.185042][T29333] goodix_fp odm:goodixfp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.185369][T29333] simple-pm-bus odm: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.185722][T29333] simple-pm-bus odm: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.186030][T29333] gs-chipid 10000000.chipid: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.186372][T29333] gs-chipid 10000000.chipid: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.186725][T29333] exynos-ect exynos-ect: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.187073][T29333] exynos-ect exynos-ect: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.187393][T29333] platform 1cc60000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.187747][T29333] platform 1cc60000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.188075][T29333] platform 1bd50000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.188430][T29333] platform 1bd50000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.188760][T29333] platform 1bd20000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.189093][T29333] platform 1bd20000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.189439][T29333] platform 1bcf0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.189793][T29333] platform 1bcf0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.190121][T29333] platform 1bcc0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.190475][T29333] platform 1bcc0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.190802][T29333] platform 1bc90000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.191157][T29333] platform 1bc90000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.191484][T29333] platform 102b0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.191839][T29333] platform 102b0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.192166][T29333] platform 1c8c0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.192522][T29333] platform 1c8c0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.192825][T29333] platform 1c890000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.193183][T29333] platform 1c890000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.193530][T29333] platform 1b800000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.193884][T29333] platform 1b800000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.194211][T29333] platform 1b7d0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.194566][T29333] platform 1b7d0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.194872][T29333] platform 1b7a0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.195247][T29333] platform 1b7a0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.195575][T29333] platform 1ad20000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.195911][T29333] platform 1ad20000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.196234][T29333] platform 11070000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.196593][T29333] platform 11070000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.196919][T29333] platform 1bb20000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.197293][T29333] platform 1bb20000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.197621][T29333] platform 1baf0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.197975][T29333] platform 1baf0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.198303][T29333] platform 1bac0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.198656][T29333] platform 1bac0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.198985][T29333] platform 200b0000.s2mpu_g3d3: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.199355][T29333] platform 200b0000.s2mpu_g3d3: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.199699][T29333] platform 200a0000.s2mpu_g3d2: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.200070][T29333] platform 200a0000.s2mpu_g3d2: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.200414][T29333] platform 20090000.s2mpu_g3d1: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.200773][T29333] platform 20090000.s2mpu_g3d1: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.201107][T29333] platform 20080000.s2mpu_g3d0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.201500][T29333] platform 20080000.s2mpu_g3d0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.201845][T29333] platform 1a8a0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.202199][T29333] platform 1a8a0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.202520][T29333] platform 1c730000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.202881][T29333] platform 1c730000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.203208][T29333] platform 1c6b0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.203562][T29333] platform 1c6b0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.203890][T29333] platform 1c680000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.204244][T29333] platform 1c680000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.204555][T29333] platform 17040000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.204908][T29333] platform 17040000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.205254][T29333] platform 1c180000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.205608][T29333] platform 1c180000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.205935][T29333] platform 1c170000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.206290][T29333] platform 1c170000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.206617][T29333] platform 1c160000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.206971][T29333] platform 1c160000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.207300][T29333] platform 1b0a0000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.207653][T29333] platform 1b0a0000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.207981][T29333] platform 1a550000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.208335][T29333] platform 1a550000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.208651][T29333] platform 1a520000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.208995][T29333] platform 1a520000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.209344][T29333] platform 20c70000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.209698][T29333] platform 20c70000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.210027][T29333] platform 1ca60000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.210381][T29333] platform 1ca60000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.210708][T29333] platform 17590000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.211062][T29333] platform 17590000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.211390][T29333] s2mpu 14480000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.211734][T29333] s2mpu 14480000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.212051][T29333] s2mpu 11880000.s2mpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.212396][T29333] s2mpu 11880000.s2mpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.212721][T29333] sjtag sjtag_gsa: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.213019][T29333] sjtag sjtag_gsa: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.213342][T29333] sjtag sjtag_ap: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.213667][T29333] sjtag sjtag_ap: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.213964][T29333] platform exynos-ehld: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.214308][T29333] platform exynos-ehld: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.214627][T29333] exynos-adv-tracer-s2d exynos_adv_tracer_s2d: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.215047][T29333] exynos-adv-tracer-s2d exynos_adv_tracer_s2d: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.215441][T29333] exynos-adv-tracer 176c0000.exynos-adv_tracer: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.215865][T29333] exynos-adv-tracer 176c0000.exynos-adv_tracer: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.216263][T29333] platform 11090000.etr-miu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.216625][T29333] platform 11090000.etr-miu: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.216936][T29333] exynos-etm exynos-etm: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.217286][T29333] exynos-etm exynos-etm: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.217626][T29333] exynos-ecc-handler ecc-handler: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.218004][T29333] exynos-ecc-handler ecc-handler: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.218354][T29333] exynos-coresight coresight@25000000: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.218727][T29333] exynos-coresight coresight@25000000: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.219116][T29333] gs101-itmon gs101-itmon: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.219471][T29333] gs101-itmon gs101-itmon: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.219778][T29333] pixel-suspend-diag pixel-suspend-diag: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.220177][T29333] pixel-suspend-diag pixel-suspend-diag: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.220559][T29333] boot-metrics 2038000.boot-metrics: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.220939][T29333] boot-metrics 2038000.boot-metrics: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.221322][T29333] keydebug keydebug: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.221656][T29333] keydebug keydebug: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.221963][T29333] exynos-debug-test exynos-debug-test: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.222357][T29333] exynos-debug-test exynos-debug-test: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.222725][T29333] debug-snapshot-debug-kinfo dss-debug-kinfo: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.223142][T29333] debug-snapshot-debug-kinfo dss-debug-kinfo: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.223533][T29333] debug-snapshot-sfrdump dss-sfrdump: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.223924][T29333] debug-snapshot-sfrdump dss-sfrdump: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.224288][T29333] platform dss-qdump: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.224627][T29333] platform dss-qdump: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.224914][T29333] platform dss-built: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.225256][T29333] platform dss-built: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.225585][T29333] hardlockup-watchdog hardlockup-watchdog: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.226164][T26481] hardlockup_watchdog_disable: cpu0: disabled
[ 7915.226482][T29333] hardlockup-watchdog hardlockup-watchdog: PM: platform_pm_suspend returned 0 after 489 usecs
[ 7915.226668][T29333] hardlockup-debug-driver hardlockup-debugger: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.227021][T29333] hardlockup-debug-driver hardlockup-debugger: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.227422][T29333] debug-snapshot dss: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.227759][T29333] debug-snapshot dss: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.228071][T29333] exynos-bcm_dbg gs101-ppmu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.228454][T29333] exynos-bcm_dbg gs101-ppmu: PM: platform_pm_suspend returned 0 after 25 usecs
[ 7915.228767][T29333] lwis-slc lwis_slc@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.229087][T29333] lwis-slc lwis_slc@0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.229401][T29333] lwis-dpm lwis_dpm@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.229745][T29333] lwis-dpm lwis_dpm@0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.230078][T29333] lwis-top lwis_top@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.230419][T29333] lwis-top lwis_top@0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.230733][T29333] exynos-mipi-phy-csi 1a4f3600.dcphy_m0s4s4s4s4s4_csi0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.231185][T29333] exynos-mipi-phy-csi 1a4f3600.dcphy_m0s4s4s4s4s4_csi0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.231610][T29333] exynos-mipi-phy-csi 1a4f3300.dcphy_m0s4s4s4s4s4_csi0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.232040][T29333] exynos-mipi-phy-csi 1a4f3300.dcphy_m0s4s4s4s4s4_csi0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.232465][T29333] exynos-mipi-phy-csi 1a4f2e00.dcphy_m0s4s4s4s4s4_csi0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.232931][T29333] exynos-mipi-phy-csi 1a4f2e00.dcphy_m0s4s4s4s4s4_csi0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.233340][T29333] exynos-mipi-phy-csi 1a4f2b00.dcphy_m0s4s4s4s4s4_csi0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.233808][T29333] exynos-mipi-phy-csi 1a4f2b00.dcphy_m0s4s4s4s4s4_csi0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.234233][T29333] exynos-mipi-phy-csi 1a4f2600.dcphy_m0s4s4s4s4s4_csi0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.234683][T29333] exynos-mipi-phy-csi 1a4f2600.dcphy_m0s4s4s4s4s4_csi0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.235109][T29333] exynos-mipi-phy-csi 1a4f2300.dcphy_m0s4s4s4s4s4_csi0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.235558][T29333] exynos-mipi-phy-csi 1a4f2300.dcphy_m0s4s4s4s4s4_csi0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.235982][T29333] exynos-mipi-phy-csi 1a4f1b00.dcphy_m0s4s4s4s4s4_csi0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.236433][T29333] exynos-mipi-phy-csi 1a4f1b00.dcphy_m0s4s4s4s4s4_csi0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.236841][T29333] exynos-mipi-phy-csi 1a4f1300.dcphy_m0s4s4s4s4s4_csi0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.237289][T29333] exynos-mipi-phy-csi 1a4f1300.dcphy_m0s4s4s4s4s4_csi0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.237731][T29333] platform 1a420500.system-controller: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.238125][T29333] platform 1a420500.system-controller: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.238493][T29333] platform 174204e0.syscon: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.238851][T29333] platform 174204e0.syscon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.239181][T29333] platform 10c21000.syscon: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.239517][T29333] platform 10c21000.syscon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.239870][T29333] platform 10821000.syscon: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.240227][T29333] platform 10821000.syscon: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.240560][T29333] platform 14420000.system-controller: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.240934][T29333] platform 14420000.system-controller: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.241399][T29333] exynos-pd 17462900.pd-tpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.241681][T29333] exynos-pd 17462900.pd-tpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.242020][T29333] exynos-pd 17462880.pd-bo: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.242373][T29333] exynos-pd 17462880.pd-bo: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.242726][T29333] exynos-pd 17462800.pd-tnr: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.243064][T29333] exynos-pd 17462800.pd-tnr: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.243412][T29333] exynos-pd 17462780.pd-gdc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.243760][T29333] exynos-pd 17462780.pd-gdc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.244107][T29333] exynos-pd 17462700.pd-mcsc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.244436][T29333] exynos-pd 17462700.pd-mcsc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.244810][T29333] exynos-pd 17462580.pd-g3aa: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.245159][T29333] exynos-pd 17462580.pd-g3aa: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.245506][T29333] exynos-pd 17462680.pd-itp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.245858][T29333] exynos-pd 17462680.pd-itp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.246193][T29333] exynos-pd 17462480.pd-pdp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.246554][T29333] exynos-pd 17462480.pd-pdp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.246897][T29333] exynos-pd 17462400.pd-csis: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.247252][T29333] exynos-pd 17462400.pd-csis: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.247598][T29333] exynos-pd 17462380.pd-mfc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.247950][T29333] exynos-pd 17462380.pd-mfc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.248298][T29333] exynos-pd 17462300.pd-g2d: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.248649][T29333] exynos-pd 17462300.pd-g2d: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.248975][T29333] exynos-pd 17462280.pd-disp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.249344][T29333] exynos-pd 17462280.pd-disp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.249683][T29333] exynos-pd 17462080.pd-hsi0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.250046][T29333] exynos-pd 17462080.pd-hsi0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.250387][T29333] exynos-pd 17461e00.pd-g3d: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.250744][T29333] exynos-pd 17461e00.pd-g3d: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.251079][T29333] exynos-pd 17461c00.pd-eh: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.251436][T29333] exynos-pd 17461c00.pd-eh: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.251768][T29333] samsung,dma-heap-system video_system_dma_heap: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.252194][T29333] samsung,dma-heap-system video_system_dma_heap: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.252597][T29333] samsung,dma-heap-system system_dma_heap: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.252984][T29333] samsung,dma-heap-system system_dma_heap: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.253384][T29333] gsa 17c90000.gsa-ns: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.253724][T29333] gsa 17c90000.gsa-ns: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.254039][T29333] google-aoc-snd-incall aoc_incall_drv: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.254417][T29333] google-aoc-snd-incall aoc_incall_drv: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.254807][T29333] google-aoc-snd-voip aoc_voip_drv: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.255191][T29333] google-aoc-snd-voip aoc_voip_drv: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.255549][T29333] google-aoc-snd-nohost aoc_nohost: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.255933][T29333] google-aoc-snd-nohost aoc_nohost: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.256291][T29333] google-aoc-path aoc_path: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.256650][T29333] google-aoc-path aoc_path: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.256960][T29333] google-aoc-snd-compr aoc_compr_drv: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.257351][T29333] google-aoc-snd-compr aoc_compr_drv: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.257734][T29333] google-aoc-snd-voice aoc_voice_drv: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.258124][T29333] google-aoc-snd-voice aoc_voice_drv: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.258489][T29333] google-aoc-snd-pcm aoc_pcm_drv: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.258848][T29333] google-aoc-snd-pcm aoc_pcm_drv: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.259218][T29333] reg-fixed-voltage cs35l41_dummy_regulator@0: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.259637][T29333] reg-fixed-voltage cs35l41_dummy_regulator@0: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.260014][T29333] wc-mbox 176a0000.mbox: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.260364][T29333] wc-mbox 176a0000.mbox: PM: platform_pm_suspend returned 0 after 4 usecs
[ 7915.260682][T29333] mali-pcm priority-control-manager: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.261069][T29333] mali-pcm priority-control-manager: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.261449][T29333] mali-mgm physical-memory-group-manager: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.261854][T29333] mali-mgm physical-memory-group-manager: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.262231][T29333] exynos-mipi-phy dphy_m4s4_dsim0@1C2E0000: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.262641][T29333] exynos-mipi-phy dphy_m4s4_dsim0@1C2E0000: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.263025][T29333] platform 1c221000.disp_ss: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.263386][T29333] platform 1c221000.disp_ss: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.263721][T29333] exynos-writeback 1c0bc000.drmdpp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.264104][T29333] exynos-writeback 1c0bc000.drmdpp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.264462][T29333] exynos-dpp 1c0b5000.drmdpp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.264828][T29333] exynos-dpp 1c0b5000.drmdpp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.265164][T29333] exynos-dpp 1c0b4000.drmdpp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.265528][T29333] exynos-dpp 1c0b4000.drmdpp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.265866][T29333] exynos-dpp 1c0b3000.drmdpp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.266230][T29333] exynos-dpp 1c0b3000.drmdpp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.266568][T29333] exynos-dpp 1c0b2000.drmdpp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.266932][T29333] exynos-dpp 1c0b2000.drmdpp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.267269][T29333] exynos-dpp 1c0b1000.drmdpp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.267633][T29333] exynos-dpp 1c0b1000.drmdpp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.267971][T29333] exynos-dpp 1c0b0000.drmdpp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.268335][T29333] exynos-dpp 1c0b0000.drmdpp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.268656][T29333] samsung-sysmmu 1a090000.sysmmu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.269051][T29333] samsung-sysmmu 1a090000.sysmmu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.269401][T29333] sysmmu-group iommu_group_tpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.269772][T29333] sysmmu-group iommu_group_tpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.270117][T29333] sysmmu-group iommu_group_smfc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.270490][T29333] sysmmu-group iommu_group_smfc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.270838][T29333] sysmmu-group iommu_group_g2d: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.271209][T29333] sysmmu-group iommu_group_g2d: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.271553][T29333] sysmmu-group iommu_group_aoc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.271924][T29333] sysmmu-group iommu_group_aoc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.272268][T29333] sysmmu-group iommu_group_mfc: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.272623][T29333] sysmmu-group iommu_group_mfc: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.272965][T29333] sysmmu-group iommu_group_bo: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.273351][T29333] sysmmu-group iommu_group_bo: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.273692][T29333] sysmmu-group iommu_group_isp: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.274063][T29333] sysmmu-group iommu_group_isp: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.274407][T29333] sysmmu-group iommu_group_dpu: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.274777][T29333] sysmmu-group iommu_group_dpu: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.275126][T29333] samsung-pinctrl 10c40000.pinctrl: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.275506][T29333] samsung-pinctrl 10c40000.pinctrl: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.275873][T29333] samsung-pinctrl 10840000.pinctrl: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.276248][T29333] samsung-pinctrl 10840000.pinctrl: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.276610][T29333] samsung-pinctrl 14440000.pinctrl: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.276990][T29333] samsung-pinctrl 14440000.pinctrl: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.277349][T29333] samsung-pinctrl 11840000.pinctrl: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.277731][T29333] samsung-pinctrl 11840000.pinctrl: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.278089][T29333] samsung-pinctrl 17940000.pinctrl: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.278472][T29333] samsung-pinctrl 17940000.pinctrl: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.278832][T29333] samsung-pinctrl 17a80000.pinctrl: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.279215][T29333] samsung-pinctrl 17a80000.pinctrl: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.279574][T29333] samsung-pinctrl 174e0000.pinctrl: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.279956][T29333] samsung-pinctrl 174e0000.pinctrl: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.280317][T29333] samsung-pinctrl 174d0000.pinctrl: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.280699][T29333] samsung-pinctrl 174d0000.pinctrl: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.281037][T29333] dit 10190000.dit: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.281387][T29333] dit 10190000.dit: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.281672][T29333] exynos-acme exynos-acme: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.282045][T29333] exynos-acme exynos-acme: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.282373][T29333] exynos-cpupm cpupm: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.282711][T29333] exynos-cpupm cpupm: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.283021][T29333] psci-cpuidle-domain psci: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.283379][T29333] psci-cpuidle-domain psci: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.283709][T29333] gs101-cp-thermal-zone cp-tm1: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.284080][T29333] gs101-cp-thermal-zone cp-tm1: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.284424][T29333] exynos-bts exynos-bts: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.284774][T29333] exynos-bts exynos-bts: PM: platform_pm_suspend returned 0 after 2 usecs
[ 7915.285079][T29333] trusty trusty: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.285414][T29333] trusty trusty: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.285708][T29333] platform fd800000.bootloader_log: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.286092][T29333] platform fd800000.bootloader_log: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.286453][T29333] ramoops fd3ff000.ramoops_mem: PM: calling platform_pm_suspend @ 29333, parent: platform
[ 7915.286821][T29333] ramoops fd3ff000.ramoops_mem: PM: platform_pm_suspend returned 0 after 1 usecs
[ 7915.287166][T29333] regulator regulator.0: PM: calling regulator_suspend @ 29333, parent: reg-dummy
[ 7915.287510][T29333] regulator regulator.0: PM: regulator_suspend returned 0 after 2 usecs
[ 7915.288167][T29333] PM: tudor: dpm_suspend: after while loop, list_empty(&dpm_prepared_list)? 1
[ 7915.288311][T29333] PM: tudor: dpm_suspend: before async_synchronize_full
[ 7915.288427][T29333] PM: tudor: dpm_suspend: after async_synchronize_full();
[ 7915.288662][T29333] PM: suspend of devices complete after 471.873 msecs
[ 7915.288914][T29333] PM: start suspend of devices complete after 476.453 msecs
[ 7915.290187][T29333] s51xx 0000:01:00.0: PM: calling pci_pm_suspend_late @ 29333, parent: 0000:00:00.0
[ 7915.290345][T29333] s51xx 0000:01:00.0: PM: pci_pm_suspend_late returned 0 after 2 usecs
[ 7915.290988][T29333] pcieh 0001:01:00.0: PM: calling pci_pm_suspend_late @ 29333, parent: 0001:00:00.0
[ 7915.291144][T29333] pcieh 0001:01:00.0: PM: pci_pm_suspend_late returned 0 after 1 usecs
[ 7915.291309][T29333] exynos-dsim 1c2c0000.drmdsim: PM: calling dsim_suspend [exynos_drm] @ 29333, parent: platform
[ 7915.291504][T29333] exynos-dsim 1c2c0000.drmdsim: PM: dsim_suspend [exynos_drm] returned 0 after 2 usecs
[ 7915.291968][T29333] pcieport 0001:00:00.0: PM: calling pci_pm_suspend_late @ 29333, parent: pci0001:00
[ 7915.292125][T29333] pcieport 0001:00:00.0: PM: pci_pm_suspend_late returned 0 after 1 usecs
[ 7915.292520][T29333] pcieport 0000:00:00.0: PM: calling pci_pm_suspend_late @ 29333, parent: pci0000:00
[ 7915.292676][T29333] pcieport 0000:00:00.0: PM: pci_pm_suspend_late returned 0 after 1 usecs
[ 7915.294349][T29333] gs101-devfreq 17000080.devfreq_bo: PM: calling exynos_devfreq_suspend [exynos_devfreq] @ 29333, parent: platform
[ 7915.294573][T29333] gs101-devfreq 17000080.devfreq_bo: PM: exynos_devfreq_suspend [exynos_devfreq] returned 0 after 4 usecs
[ 7915.294765][T29333] gs101-devfreq 17000070.devfreq_mfc: PM: calling exynos_devfreq_suspend [exynos_devfreq] @ 29333, parent: platform
[ 7915.294985][T29333] gs101-devfreq 17000070.devfreq_mfc: PM: exynos_devfreq_suspend [exynos_devfreq] returned 0 after 2 usecs
[ 7915.295308][T29333] gs101-devfreq 17000060.devfreq_tnr: PM: calling exynos_devfreq_suspend [exynos_devfreq] @ 29333, parent: platform
[ 7915.295762][T29333] gs101-devfreq 17000060.devfreq_tnr: PM: exynos_devfreq_suspend [exynos_devfreq] returned 0 after 2 usecs
[ 7915.296196][T29333] gs101-devfreq 17000050.devfreq_cam: PM: calling exynos_devfreq_suspend [exynos_devfreq] @ 29333, parent: platform
[ 7915.296672][T29333] gs101-devfreq 17000050.devfreq_cam: PM: exynos_devfreq_suspend [exynos_devfreq] returned 0 after 3 usecs
[ 7915.297066][T29333] gs101-devfreq 17000040.devfreq_disp: PM: calling exynos_devfreq_suspend [exynos_devfreq] @ 29333, parent: platform
[ 7915.297542][T29333] gs101-devfreq 17000040.devfreq_disp: PM: exynos_devfreq_suspend [exynos_devfreq] returned 0 after 2 usecs
[ 7915.297978][T29333] gs101-devfreq 17000030.devfreq_intcam: PM: calling exynos_devfreq_suspend [exynos_devfreq] @ 29333, parent: platform
[ 7915.298443][T29333] gs101-devfreq 17000030.devfreq_intcam: PM: exynos_devfreq_suspend [exynos_devfreq] returned 0 after 2 usecs
[ 7915.298886][T29333] gs101-devfreq 17000020.devfreq_int: PM: calling exynos_devfreq_suspend [exynos_devfreq] @ 29333, parent: platform
[ 7915.299396][T29333] gs101-devfreq 17000020.devfreq_int: PM: exynos_devfreq_suspend [exynos_devfreq] returned 0 after 57 usecs
[ 7915.299778][T29333] gs101-devfreq 17000010.devfreq_mif: PM: calling exynos_devfreq_suspend [exynos_devfreq] @ 29333, parent: platform
[ 7915.300284][T29333] gs101-devfreq 17000010.devfreq_mif: PM: exynos_devfreq_suspend [exynos_devfreq] returned 0 after 54 usecs
[ 7915.300918][T29333] dma-pl330 10110000.pdma0: PM: calling pl330_suspend [pl330] @ 29333, parent: amba
[ 7915.301079][T29333] dma-pl330 10110000.pdma0: PM: pl330_suspend [pl330] returned 0 after 2 usecs
[ 7915.302294][T29333] samsung-sysmmu 1cc40000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.302490][T29333] samsung-sysmmu 1cc40000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 2 usecs
[ 7915.302671][T29333] exynos-pd 17462900.pd-tpu: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.302853][T29333] exynos-pd 17462900.pd-tpu: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.303127][T29333] samsung-sysmmu 1ca40000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.303568][T29333] samsung-sysmmu 1ca40000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.303981][T29333] exynos-pd 17462880.pd-bo: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.304390][T29333] exynos-pd 17462880.pd-bo: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.304771][T29333] samsung-sysmmu 1bc70000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.305193][T29333] samsung-sysmmu 1bc70000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.305625][T29333] samsung-sysmmu 1bca0000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.306065][T29333] samsung-sysmmu 1bca0000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.306480][T29333] samsung-sysmmu 1bcd0000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.306920][T29333] samsung-sysmmu 1bcd0000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.307335][T29333] samsung-sysmmu 1bd00000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.307775][T29333] samsung-sysmmu 1bd00000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.308189][T29333] samsung-sysmmu 1bd30000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.308631][T29333] samsung-sysmmu 1bd30000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.309043][T29333] exynos-pd 17462800.pd-tnr: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.309455][T29333] exynos-pd 17462800.pd-tnr: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.309839][T29333] samsung-sysmmu 1baa0000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.310279][T29333] samsung-sysmmu 1baa0000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.310694][T29333] samsung-sysmmu 1bad0000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.311135][T29333] samsung-sysmmu 1bad0000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.311548][T29333] samsung-sysmmu 1bb00000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.311989][T29333] samsung-sysmmu 1bb00000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.312403][T29333] exynos-pd 17462780.pd-gdc: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.312817][T29333] exynos-pd 17462780.pd-gdc: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.313198][T29333] samsung-sysmmu 1b780000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.313639][T29333] samsung-sysmmu 1b780000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.314053][T29333] samsung-sysmmu 1b7b0000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.314494][T29333] samsung-sysmmu 1b7b0000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.314907][T29333] samsung-sysmmu 1b7e0000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.315349][T29333] samsung-sysmmu 1b7e0000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.315762][T29333] exynos-pd 17462700.pd-mcsc: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.316177][T29333] exynos-pd 17462700.pd-mcsc: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.316575][T29333] samsung-sysmmu 1ad00000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.316986][T29333] samsung-sysmmu 1ad00000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.317418][T29333] exynos-pd 17462600.pd-ipp: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.317830][T29333] exynos-pd 17462600.pd-ipp: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.318214][T29333] samsung-sysmmu 1a880000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.318654][T29333] samsung-sysmmu 1a880000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.319068][T29333] exynos-pd 17462580.pd-g3aa: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.319483][T29333] exynos-pd 17462580.pd-g3aa: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.319852][T29333] samsung-sysmmu 1b080000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.320311][T29333] samsung-sysmmu 1b080000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.320726][T29333] exynos-pd 17462500.pd-dns: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.321117][T29333] exynos-pd 17462500.pd-dns: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.321519][T29333] exynos-pd 17462680.pd-itp: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.321930][T29333] exynos-pd 17462680.pd-itp: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.322314][T29333] exynos-pd 17462480.pd-pdp: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.322726][T29333] exynos-pd 17462480.pd-pdp: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.323090][T29333] samsung-sysmmu 1a510000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.323551][T29333] samsung-sysmmu 1a510000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.323945][T29333] samsung-sysmmu 1a540000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.324386][T29333] samsung-sysmmu 1a540000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.324804][T29333] exynos-pd 17462400.pd-csis: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.325234][T29333] exynos-pd 17462400.pd-csis: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 2 usecs
[ 7915.325620][T29333] samsung-sysmmu 1c870000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.326061][T29333] samsung-sysmmu 1c870000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.326475][T29333] samsung-sysmmu 1c8a0000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.326897][T29333] samsung-sysmmu 1c8a0000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.327330][T29333] exynos-pd 17462380.pd-mfc: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.327742][T29333] exynos-pd 17462380.pd-mfc: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.328125][T29333] samsung-sysmmu 1c660000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.328555][T29333] samsung-sysmmu 1c660000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.328980][T29333] samsung-sysmmu 1c690000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.329421][T29333] samsung-sysmmu 1c690000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.329834][T29333] samsung-sysmmu 1c710000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.330275][T29333] samsung-sysmmu 1c710000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.330670][T29333] exynos-pd 17462300.pd-g2d: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.331100][T29333] exynos-pd 17462300.pd-g2d: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.331484][T29333] samsung-sysmmu 1c100000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.331925][T29333] samsung-sysmmu 1c100000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.332339][T29333] samsung-sysmmu 1c110000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.332763][T29333] samsung-sysmmu 1c110000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.333194][T29333] samsung-sysmmu 1c120000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.333635][T29333] samsung-sysmmu 1c120000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.334048][T29333] exynos-pd 17462200.pd-dpu: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.334441][T29333] exynos-pd 17462200.pd-dpu: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.334843][T29333] exynos-pd 17462280.pd-disp: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.335258][T29333] exynos-pd 17462280.pd-disp: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.335645][T29333] exynos-pd 17462080.pd-hsi0: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.336060][T29333] exynos-pd 17462080.pd-hsi0: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.336446][T29333] exynos-pd 17462000.pd-embedded_g3d: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.336889][T29333] exynos-pd 17462000.pd-embedded_g3d: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.337301][T29333] exynos-pd 17461e00.pd-g3d: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.337712][T29333] exynos-pd 17461e00.pd-g3d: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.338095][T29333] exynos-pd 17461c00.pd-eh: PM: calling exynos_pd_suspend_late [exynos_pd] @ 29333, parent: platform
[ 7915.338504][T29333] exynos-pd 17461c00.pd-eh: PM: exynos_pd_suspend_late [exynos_pd] returned 0 after 1 usecs
[ 7915.338944][T29333] samsung-sysmmu 1a090000.sysmmu: PM: calling samsung_sysmmu_suspend [samsung_iommu] @ 29333, parent: platform
[ 7915.339325][T29333] samsung-sysmmu 1a090000.sysmmu: PM: samsung_sysmmu_suspend [samsung_iommu] returned 0 after 1 usecs
[ 7915.340137][T29333] PM: late suspend of devices complete after 50.932 msecs
[ 7915.341824][T29333] s51xx 0000:01:00.0: PM: calling pci_pm_suspend_noirq @ 29333, parent: 0000:00:00.0
[ 7915.342045][T29333] s51xx 0000:01:00.0: PM: pci_pm_suspend_noirq returned 0 after 50 usecs
[ 7915.342658][T29333] pcieh 0001:01:00.0: PM: calling pci_pm_suspend_noirq @ 29333, parent: 0001:00:00.0
[ 7915.342954][T29333] pcieh 0001:01:00.0: PM: pci_pm_suspend_noirq returned 0 after 21 usecs
[ 7915.343233][T29333] cs40l2x i2c-c240l2x: PM: calling cs40l2x_sys_suspend_noirq [haptics_cs40l2x] @ 29333, parent: i2c-8
[ 7915.343574][T29333] cs40l2x i2c-c240l2x: PM: cs40l2x_sys_suspend_noirq [haptics_cs40l2x] returned 0 after 5 usecs
[ 7915.343930][T29333] lwis-ioreg 1a440000.lwis_csi: PM: calling genpd_suspend_noirq @ 29333, parent: platform
[ 7915.344231][T29333] lwis-ioreg 1a440000.lwis_csi: PM: genpd_suspend_noirq returned 0 after 5 usecs
[ 7915.344561][T29333] exynos-dwc3 11110000.usb: PM: calling genpd_suspend_noirq @ 29333, parent: platform
[ 7915.344843][T29333] exynos-dwc3 11110000.usb: PM: genpd_suspend_noirq returned 0 after 3 usecs
[ 7915.345111][T29333] phy_exynos_usbdrd 11100000.phy: PM: calling genpd_suspend_noirq @ 29333, parent: platform
[ 7915.345407][T29333] phy_exynos_usbdrd 11100000.phy: PM: genpd_suspend_noirq returned 0 after 1 usecs
[ 7915.345717][T29333] max77759-charger i2c-max77759chrg: PM: calling max77759_charger_pm_suspend [max77759_charger] @ 29333, parent: i2c-12
[ 7915.346103][T29333] max77759-charger i2c-max77759chrg: PM: max77759_charger_pm_suspend [max77759_charger] returned 0 after 5 usecs
[ 7915.346480][T29333] exynos_pd_hsi0 sub-pd-hsi0: PM: calling genpd_suspend_noirq @ 29333, parent: platform
[ 7915.346769][T29333] exynos_pd_hsi0 sub-pd-hsi0: PM: genpd_suspend_noirq returned 0 after 1 usecs
[ 7915.347063][T29333] pcieport 0001:00:00.0: PM: calling pci_pm_suspend_noirq @ 29333, parent: pci0001:00
[ 7915.347431][T29333] pcieport 0001:00:00.0: PM: pci_pm_suspend_noirq returned 0 after 18 usecs
[ 7915.347895][T29333] exynos-pcie-rc 14520000.pcie: PM: calling exynos_pcie_rc_suspend_noirq [pcie_exynos_gs] @ 29333, parent: platform
[ 7915.348281][T29333] exynos-pcie-rc 14520000.pcie: PM: exynos_pcie_rc_suspend_noirq [pcie_exynos_gs] returned 0 after 16 usecs
[ 7915.348642][T29333] pcieport 0000:00:00.0: PM: calling pci_pm_suspend_noirq @ 29333, parent: pci0000:00
[ 7915.349118][T29333] pcieport 0000:00:00.0: PM: pci_pm_suspend_noirq returned 0 after 130 usecs
[ 7915.349487][T29333] genpd genpd:1:1c500000.mali: PM: calling genpd_suspend_noirq @ 29333, parent: none
[ 7915.349769][T29333] genpd genpd:1:1c500000.mali: PM: genpd_suspend_noirq returned 0 after 3 usecs
[ 7915.350036][T29333] genpd genpd:0:1c500000.mali: PM: calling genpd_suspend_noirq @ 29333, parent: none
[ 7915.350371][T29333] genpd genpd:0:1c500000.mali: PM: genpd_suspend_noirq returned 0 after 2 usecs
[ 7915.350892][T29333] exynos-pcie-rc 11920000.pcie: PM: calling exynos_pcie_rc_suspend_noirq [pcie_exynos_gs] @ 29333, parent: platform
[ 7915.351253][T29333] exynos-pcie-rc 11920000.pcie: PM: exynos_pcie_rc_suspend_noirq [pcie_exynos_gs] returned 0 after 8 usecs
[ 7915.351611][T29333] p9221 i2c-p9221: PM: calling p9221_pm_suspend [p9221] @ 29333, parent: i2c-8
[ 7915.351936][T29333] p9221 i2c-p9221: PM: p9221_pm_suspend [p9221] returned 0 after 4 usecs
[ 7915.352373][T29333] max1720x i2c-max1720x_fg: PM: calling max1720x_pm_suspend [max1720x_battery] @ 29333, parent: i2c-12
[ 7915.352715][T29333] max1720x i2c-max1720x_fg: PM: max1720x_pm_suspend [max1720x_battery] returned 0 after 3 usecs
[ 7915.353353][T29333] lwis-ioreg 1aa40000.lwis_pdp: PM: calling genpd_suspend_noirq @ 29333, parent: platform
[ 7915.353644][T29333] lwis-ioreg 1aa40000.lwis_pdp: PM: genpd_suspend_noirq returned 0 after 1 usecs
[ 7915.353929][T29333] exynos-jpeg 1c700000.smfc: PM: calling genpd_suspend_noirq @ 29333, parent: platform
[ 7915.354214][T29333] exynos-jpeg 1c700000.smfc: PM: genpd_suspend_noirq returned 0 after 2 usecs
[ 7915.354483][T29333] exynos-decon 1c302000.drmdecon: PM: calling genpd_suspend_noirq @ 29333, parent: platform
[ 7915.354849][T29333] exynos-decon 1c302000.drmdecon: PM: genpd_suspend_noirq returned 0 after 3 usecs
[ 7915.355197][T29333] exynos-decon 1c300000.drmdecon: PM: calling genpd_suspend_noirq @ 29333, parent: platform
[ 7915.355575][T29333] exynos-decon 1c300000.drmdecon: PM: genpd_suspend_noirq returned 0 after 1 usecs
[ 7915.355933][T29333] bigocean 1cb00000.bigocean: PM: calling genpd_suspend_noirq @ 29333, parent: platform
[ 7915.356291][T29333] bigocean 1cb00000.bigocean: PM: genpd_suspend_noirq returned 0 after 2 usecs
[ 7915.357016][T29333] exynos5-hsi2c 10d50000.hsi2c: PM: calling exynos5_i2c_suspend_noirq [i2c_exynos5] @ 29333, parent: platform
[ 7915.357358][T29333] exynos5-hsi2c 10d50000.hsi2c: tudor: exynos5_i2c_suspend_noirq enter
[ 7915.357603][T29333] exynos5-hsi2c 10d50000.hsi2c: tudor: exynos5_i2c_runtime_suspend enter
[ 7915.357870][T29333] exynos5-hsi2c 10d50000.hsi2c: tudor: exynos5_i2c_runtime_suspend exit
[ 7915.358114][T29333] exynos5-hsi2c 10d50000.hsi2c: tudor: exynos5_i2c_suspend_noirq exit
[ 7915.358353][T29333] exynos5-hsi2c 10d50000.hsi2c: PM: exynos5_i2c_suspend_noirq [i2c_exynos5] returned 0 after 995 usecs
[ 7915.358725][T29333] exynos5-hsi2c 10960000.hsi2c: PM: calling exynos5_i2c_suspend_noirq [i2c_exynos5] @ 29333, parent: platform
[ 7915.359164][T29333] exynos5-hsi2c 10960000.hsi2c: tudor: exynos5_i2c_suspend_noirq enter
[ 7915.359475][T29333] exynos5-hsi2c 10960000.hsi2c: tudor: exynos5_i2c_suspend_noirq exit
[ 7915.359778][T29333] exynos5-hsi2c 10960000.hsi2c: PM: exynos5_i2c_suspend_noirq [i2c_exynos5] returned 0 after 613 usecs
[ 7915.360211][T29333] exynos5-hsi2c 10970000.hsi2c: PM: calling exynos5_i2c_suspend_noirq [i2c_exynos5] @ 29333, parent: platform
[ 7915.360744][T29333] exynos5-hsi2c 10970000.hsi2c: tudor: exynos5_i2c_suspend_noirq enter
[ 7915.360991][T29333] exynos5-hsi2c 10970000.hsi2c: tudor: exynos5_i2c_suspend_noirq exit
[ 7915.361249][T29333] exynos5-hsi2c 10970000.hsi2c: PM: exynos5_i2c_suspend_noirq [i2c_exynos5] returned 0 after 505 usecs
[ 7915.361666][T29333] exynos5-hsi2c 10920000.hsi2c: PM: calling exynos5_i2c_suspend_noirq [i2c_exynos5] @ 29333, parent: platform
[ 7915.362104][T29333] exynos5-hsi2c 10920000.hsi2c: tudor: exynos5_i2c_suspend_noirq enter
[ 7915.362415][T29333] exynos5-hsi2c 10920000.hsi2c: tudor: exynos5_i2c_suspend_noirq exit
[ 7915.362719][T29333] exynos5-hsi2c 10920000.hsi2c: PM: exynos5_i2c_suspend_noirq [i2c_exynos5] returned 0 after 616 usecs
[ 7915.363135][T29333] exynos5-hsi2c 10910000.hsi2c: PM: calling exynos5_i2c_suspend_noirq [i2c_exynos5] @ 29333, parent: platform
[ 7915.363574][T29333] exynos5-hsi2c 10910000.hsi2c: tudor: exynos5_i2c_suspend_noirq enter
[ 7915.363886][T29333] exynos5-hsi2c 10910000.hsi2c: tudor: exynos5_i2c_suspend_noirq exit
[ 7915.364189][T29333] exynos5-hsi2c 10910000.hsi2c: PM: exynos5_i2c_suspend_noirq [i2c_exynos5] returned 0 after 615 usecs
[ 7915.364607][T29333] exynos5-hsi2c 10900000.hsi2c: PM: calling exynos5_i2c_suspend_noirq [i2c_exynos5] @ 29333, parent: platform
[ 7915.365044][T29333] exynos5-hsi2c 10900000.hsi2c: tudor: exynos5_i2c_suspend_noirq enter
[ 7915.365355][T29333] exynos5-hsi2c 10900000.hsi2c: tudor: exynos5_i2c_suspend_noirq exit
[ 7915.365659][T29333] exynos5-hsi2c 10900000.hsi2c: PM: exynos5_i2c_suspend_noirq [i2c_exynos5] returned 0 after 615 usecs
[ 7915.366144][T29333] cp_interface cpif: PM: calling modem_suspend [cpif] @ 29333, parent: platform
[ 7915.366470][T29333] cpif: modem_ctrl_set_kerneltime: time = 715.361993
[ 7915.366699][T29333] cp_interface cpif: PM: modem_suspend [cpif] returned 0 after 260 usecs
[ 7915.367002][T29333] exynos-uart 175b0000.serial: PM: calling exynos_serial_suspend_noirq [exynos_tty] @ 29333, parent: platform
[ 7915.367420][T29333] exynos-uart 175b0000.serial: PM: exynos_serial_suspend_noirq [exynos_tty] returned 0 after 2 usecs
[ 7915.368122][T29333] eh 17100000.eh: PM: calling genpd_suspend_noirq @ 29333, parent\FA\00[ 7915.551114][T29333] exynos-uart 10a00000.uart: PM: platform_pm_resume returned 0 after 37 usecs
[ 7915.551263][T29333] eh 17100000.eh: PM: calling eh_resume [eh] @ 29333, parent: platform
[ 7915.551418][T29333] eh 17100000.eh: PM: eh_resume [eh] returned 0 after 8 usecs
[ 7915.551583][T29333] exynos-cpuhp exynos-cpuphp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.551747][T29333] exynos-cpuhp exynos-cpuphp: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.551899][T29333] acpm_flexpmu_dbg acpm_flexpmu_dbg: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.552305][T29333] acpm_flexpmu_dbg acpm_flexpmu_dbg: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.552636][T29333] acpm-stress mbox: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.552983][T29333] acpm-stress mbox: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.553282][T29333] gs-acpm 17440000.acpm: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.553629][T29333] gs-acpm 17440000.acpm: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.553945][T29333] gs-acpm-ipc 17610000.acpm_ipc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.554306][T29333] gs-acpm-ipc 17610000.acpm_ipc: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.554659][T29333] power_stats acpm_stats: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.555009][T29333] power_stats acpm_stats: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.555328][T29333] google,slc slc-dummy: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.555671][T29333] google,slc slc-dummy: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.555983][T29333] google,slc-acpm slc-acpm: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.556328][T29333] google,slc-acpm slc-acpm: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.556665][T29333] i2c-acpm acpm_mfd_bus@17500000: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.557041][T29333] i2c-acpm acpm_mfd_bus@17500000: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.557388][T29333] i2c-acpm acpm_mfd_bus@17510000: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.557763][T29333] i2c-acpm acpm_mfd_bus@17510000: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.558109][T29333] exynos-dm 17000000.exynos-dm: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.558478][T29333] exynos-dm 17000000.exynos-dm: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.558817][T29333] exynos-devfreq-root exynos_devfreq: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.559206][T29333] exynos-devfreq-root exynos_devfreq: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.559565][T29333] devfreq-memlat gs_memlat_devfreq: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.559948][T29333] devfreq-memlat gs_memlat_devfreq: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.560285][T29333] arm-memlat-mon cpu0-cpugrp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.560663][T29333] arm-memlat-mon cpu0-cpugrp: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.560996][T29333] arm-memlat-mon cpu1-cpugrp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.561358][T29333] arm-memlat-mon cpu1-cpugrp: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.561673][T29333] arm-memlat-mon cpu2-cpugrp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.562053][T29333] arm-memlat-mon cpu2-cpugrp: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.562386][T29333] arm-memlat-mon cpu3-cpugrp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.562729][T29333] arm-memlat-mon cpu3-cpugrp: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.563082][T29333] arm-memlat-mon cpu4-cpugrp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.563444][T29333] arm-memlat-mon cpu4-cpugrp: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.563776][T29333] arm-memlat-mon cpu5-cpugrp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.564123][T29333] arm-memlat-mon cpu5-cpugrp: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.564453][T29333] arm-memlat-mon cpu6-cpugrp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.564834][T29333] arm-memlat-mon cpu6-cpugrp: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.565166][T29333] arm-memlat-mon cpu7-cpugrp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.565510][T29333] arm-memlat-mon cpu7-cpugrp: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.565862][T29333] s3c2410-wdt 10060000.watchdog_cl0: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.566248][T29333] s3c2410-wdt 10060000.watchdog_cl0: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.566604][T29333] s3c2410-wdt 10070000.watchdog_cl1: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.566990][T29333] s3c2410-wdt 10070000.watchdog_cl1: s3c2410wdt_multistage_wdt_stop: cluster 1 stop done, WTCON 00018001
[ 7915.567410][T29333] s3c2410-wdt 10070000.watchdog_cl1: Watchdog cluster 1 stop done, WTCON = 18000
[ 7915.567761][T29333] s3c2410-wdt 10070000.watchdog_cl1: NONCPU_OUT set true done, val = 88, en= 1
[ 7915.568095][T29333] s3c2410-wdt 10070000.watchdog_cl1: watchdog enabled, con: 0x0011573c, dat: 0x0000ffaf, cnt: 0x0000ffaf
[ 7915.568927][T29333] s3c2410-wdt 10070000.watchdog_cl1: windowed_wd enabled, wtmincnt: 0x0001ff5e
[ 7915.569096][T29333] s3c2410-wdt 10070000.watchdog_cl1: PM: platform_pm_resume returned 0 after 2107 usecs
[ 7915.569272][T29333] gs-tmu 100a0000.BIG: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.569598][T29333] exynos_acpm_tmu_set_resume: acpm irq 0 cold cnt 0 stat 1
[ 7915.570079][T29333] gs_tmu_resume: thermal zone 0 temp 10 stat 1
[ 7915.570189][T29333] gs-tmu 100a0000.BIG: PM: platform_pm_resume returned 0 after 635 usecs
[ 7915.570348][T29333] gs-tmu 100a0000.MID: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.570848][T29333] gs_tmu_resume: thermal zone 1 temp 10 stat 1
[ 7915.570956][T29333] gs-tmu 100a0000.MID: PM: platform_pm_resume returned 0 after 252 usecs
[ 7915.571250][T29333] gs-tmu 100a0000.LITTLE: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.571745][T29333] gs_tmu_resume: thermal zone 2 temp 10 stat 1
[ 7915.571853][T29333] gs-tmu 100a0000.LITTLE: PM: platform_pm_resume returned 0 after 253 usecs
[ 7915.572149][T29333] gs-tmu 100b0000.G3D: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.572789][T29333] gs_tmu_resume: thermal zone 3 temp 10 stat 1
[ 7915.572896][T29333] gs-tmu 100b0000.G3D: PM: platform_pm_resume returned 0 after 421 usecs
[ 7915.573034][T29333] gs-tmu 100b0000.ISP: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.574813][T29333] gs_tmu_resume: thermal zone 4 temp 10 stat 0
[ 7915.574918][T29333] gs-tmu 100b0000.ISP: PM: platform_pm_resume returned 0 after 1562 usecs
[ 7915.575063][T29333] gs-tmu 100b0000.TPU: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.575507][T29333] gs_tmu_resume: thermal zone 5 temp 10 stat 0
[ 7915.575612][T29333] gs_tmu_resume: TMU resume complete
[ 7915.575702][T29333] gs-tmu 100b0000.TPU: PM: platform_pm_resume returned 0 after 491 usecs
[ 7915.575897][T29333] platform seclog: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.576050][T29333] platform seclog: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.576225][T29333] google,battery google,battery: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.576647][T29333] google,battery google,battery: PM: platform_pm_resume returned 0 after 52 usecs
[ 7915.576969][T29333] cp_shmem cp_shmem: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.577307][T29333] cp_shmem cp_shmem: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.577666][T29333] touch_bus_negotiator tbn: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.578011][T29333] touch_bus_negotiator tbn: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.578281][T29333] regulator regulator.1: PM: calling regulator_resume @ 29333, parent: cs35l41_dummy_regulator@0
[ 7915.578736][T29333] regulator regulator.1: PM: regulator_resume returned 0 after 2 usecs
[ 7915.579353][T29333] smccc_trng smccc_trng: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.579538][T29333] smccc_trng smccc_trng: PM: platform_pm_resume returned 0 after 4 usecs
[ 7915.579712][T29333] platform icc-debugfs-client: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.580446][T29333] platform icc-debugfs-client: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.580678][T29333] exynos-uart 175b0000.serial: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.580896][T29333] exynos-uart 175b0000.serial: cannot get irq 141
[ 7915.581360][T29333] exynos-uart 175b0000.serial: PM: platform_pm_resume returned 0 after 494 usecs
[ 7915.581520][T29333] gpio-keys gpio_keys: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.581683][T29333] gpio-keys gpio_keys: PM: platform_pm_resume returned 0 after 14 usecs
[ 7915.581931][T29333] input input0: PM: calling input_dev_resume @ 29333, parent: gpio_keys
[ 7915.582239][T29333] input input0: PM: input_dev_resume returned 0 after 2 usecs
[ 7915.582525][T29333] cp_interface cpif: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.582853][T29333] cp_interface cpif: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.583191][T29333] reg-fixed-voltage fixedregulator@0: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.583564][T29333] reg-fixed-voltage fixedregulator@0: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.583907][T29333] regulator regulator.2: PM: calling regulator_resume @ 29333, parent: fixedregulator@0
[ 7915.584299][T29333] regulator regulator.2: PM: regulator_resume returned 0 after 2 usecs
[ 7915.584643][T29333] sbb-mux sbb-mux: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.584964][T29333] sbb-mux sbb-mux: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.585270][T29333] pps-gpio pps: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.585558][T29333] pps-gpio pps: PM: platform_pm_resume returned 0 after 4 usecs
[ 7915.585842][T28194] google_battery: failed to store FCNU (-13)
[ 7915.586024][T28194] google,battery google,battery: force full charged at cycle 43
[ 7915.586344][T29333] nitrous_bluetooth odm:btbcm: PM: calling platform_pm_resume @ 29333, parent: odm
[ 7915.586689][T29333] nitrous_bluetooth odm:btbcm: PM: platform_pm_resume returned 0 after 10 usecs
[ 7915.587021][T29333] exynos5-hsi2c 10900000.hsi2c: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.587390][T29333] exynos5-hsi2c 10900000.hsi2c: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.587729][T29333] exynos5-hsi2c 10910000.hsi2c: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.588088][T29333] exynos5-hsi2c 10910000.hsi2c: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.588419][T29333] exynos5-hsi2c 10920000.hsi2c: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.588806][T29333] exynos5-hsi2c 10920000.hsi2c: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.589146][T29333] exynos5-hsi2c 10970000.hsi2c: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.589514][T29333] exynos5-hsi2c 10970000.hsi2c: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.589867][T29333] lwis-i2c flash@0: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.590183][T29333] lwis-i2c flash@0: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.590482][T29333] exynos5-hsi2c 10960000.hsi2c: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.590852][T29333] exynos5-hsi2c 10960000.hsi2c: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.591191][T29333] exynos5-hsi2c 10d50000.hsi2c: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.591560][T29333] exynos5-hsi2c 10d50000.hsi2c: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.591904][T29333] exynos-mct 10050000.mct: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.592253][T29333] exynos-mct 10050000.mct: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.592643][T29333] s3c64xx-spi 10940000.spi: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.592952][T29333] s3c64xx-spi 10940000.spi: PM: platform_pm_resume returned 0 after 23 usecs
[ 7915.593242][T29333] brcm gps spi spi5.0: PM: calling bcm_spi_resume [bcm47765] @ 29333, parent: spi5
[ 7915.593611][T29333] brcm gps spi spi5.0: PM: bcm_spi_resume [bcm47765] returned 0 after 3 usecs
[ 7915.593941][T29333] s3c64xx-spi 10950000.spi: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.594316][T29333] s3c64xx-spi 10950000.spi: PM: platform_pm_resume returned 0 after 20 usecs
[ 7915.594609][T29333] s3c64xx-spi 10a20000.spi: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.595001][T29333] s3c64xx-spi 10a20000.spi: PM: platform_pm_resume returned 0 after 20 usecs
[ 7915.595297][T29333] s3c64xx-spi 10d20000.spi: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.595686][T29333] s3c64xx-spi 10d20000.spi: PM: platform_pm_resume returned 0 after 19 usecs
[ 7915.596001][T29333] s3c64xx-spi 10d40000.spi: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.596353][T29333] s3c64xx-spi 10d40000.spi: PM: platform_pm_resume returned 0 after 17 usecs
[ 7915.596664][T29333] s3c64xx-spi 10d60000.spi: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.597035][T29333] s3c64xx-spi 10d60000.spi: PM: platform_pm_resume returned 0 after 17 usecs
[ 7915.597346][T29333] trusty-irq trusty:irq: PM: calling platform_pm_resume @ 29333, parent: trusty
[ 7915.597687][T29333] trusty-irq trusty:irq: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.598025][T29333] trusty-log trusty:log: PM: calling platform_pm_resume @ 29333, parent: trusty
[ 7915.598361][T29333] trusty-log trusty:log: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.598678][T29333] trusty-virtio trusty:virtio: PM: calling platform_pm_resume @ 29333, parent: trusty
[ 7915.599036][T29333] trusty-virtio trusty:virtio: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.599373][T29333] samsung,dma-heap-chunk trusty:video_stream_dma_heap: PM: calling platform_pm_resume @ 29333, parent: trusty
[ 7915.599811][T29333] samsung,dma-heap-chunk trusty:video_stream_dma_heap: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.600212][T29333] samsung,dma-heap-chunk trusty:video_frame_dma_heap: PM: calling platform_pm_resume @ 29333, parent: trusty
[ 7915.600663][T29333] samsung,dma-heap-chunk trusty:video_frame_dma_heap: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.601075][T29333] samsung,dma-heap-chunk trusty:video_scaler_dma_heap: PM: calling platform_pm_resume @ 29333, parent: trusty
[ 7915.601514][T29333] samsung,dma-heap-chunk trusty:video_scaler_dma_heap: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.601930][T29333] samsung,dma-heap-carveout trusty:tui_dma_heap: PM: calling platform_pm_resume @ 29333, parent: trusty
[ 7915.602349][T29333] samsung,dma-heap-carveout trusty:tui_dma_heap: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.602745][T29333] samsung,dma-heap-carveout trusty:mfc_fw_dma_heap: PM: calling platform_pm_resume @ 29333, parent: trusty
[ 7915.603174][T29333] samsung,dma-heap-carveout trusty:mfc_fw_dma_heap: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.603579][T29333] debug-kinfo debug-kinfo: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.603932][T29333] debug-kinfo debug-kinfo: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.604263][T29333] gsa-gsc 17c90000.gsa-ns:gsa_gsc@0: PM: calling platform_pm_resume @ 29333, parent: 17c90000.gsa-ns
[ 7915.604645][T29333] gsa-gsc 17c90000.gsa-ns:gsa_gsc@0: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.605019][T29333] sscoredump debugcore: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.605362][T29333] sscoredump debugcore: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.605676][T29333] platform cs_funnel0: PM: calling platform_pm_resume @ 29333, parent: none
[ 7915.606001][T29333] platform cs_funnel0: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.606311][T29333] platform cs_funnel1: PM: calling platform_pm_resume @ 29333, parent: none
[ 7915.606636][T29333] platform cs_funnel1: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.606946][T29333] platform cs_funnel2: PM: calling platform_pm_resume @ 29333, parent: none
[ 7915.607271][T29333] platform cs_funnel2: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.607581][T29333] platform cs_trex0: PM: calling platform_pm_resume @ 29333, parent: none
[ 7915.607900][T29333] platform cs_trex0: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.608188][T29333] platform cs_trex1: PM: calling platform_pm_resume @ 29333, parent: none
[ 7915.608503][T29333] platform cs_trex1: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.608824][T29333] platform cs_trex2: PM: calling platform_pm_resume @ 29333, parent: none
[ 7915.609144][T29333] platform cs_trex2: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.609446][T29333] platform cs_trex3: PM: calling platform_pm_resume @ 29333, parent: none
[ 7915.609764][T29333] platform cs_trex3: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.610047][T29333] keycombo keycombo.0.auto: PM: calling platform_pm_resume @ 29333, parent: keydebug
[ 7915.610424][T29333] keycombo keycombo.0.auto: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.610761][T29333] gs101-devfreq 17000010.devfreq_mif: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.611140][T29333] gs101-devfreq 17000010.devfreq_mif: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.611502][T29333] gs101-devfreq 17000020.devfreq_int: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.611888][T29333] gs101-devfreq 17000020.devfreq_int: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.612239][T29333] gs101-devfreq 17000030.devfreq_intcam: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.612628][T29333] gs101-devfreq 17000030.devfreq_intcam: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.613018][T29333] gs101-devfreq 17000040.devfreq_disp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.613408][T29333] gs101-devfreq 17000040.devfreq_disp: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.613774][T29333] gs101-devfreq 17000050.devfreq_cam: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.614159][T29333] gs101-devfreq 17000050.devfreq_cam: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.614522][T29333] gs101-devfreq 17000060.devfreq_tnr: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.614908][T29333] gs101-devfreq 17000060.devfreq_tnr: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.615270][T29333] gs101-devfreq 17000070.devfreq_mfc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.615637][T29333] gs101-devfreq 17000070.devfreq_mfc: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.616019][T29333] gs101-devfreq 17000080.devfreq_bo: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.616409][T29333] gs101-devfreq 17000080.devfreq_bo: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.616967][T29333] port 175b0000.serial:0.0: PM: calling pm_runtime_force_resume @ 29333, parent: 175b0000.serial:0
[ 7915.617147][T29333] port 175b0000.serial:0.0: PM: pm_runtime_force_resume returned 0 after 1 usecs
[ 7915.617507][T29333] port 10a00000.uart:0.0: PM: calling pm_runtime_force_resume @ 29333, parent: 10a00000.uart:0
[ 7915.617892][T29333] port 10a00000.uart:0.0: PM: pm_runtime_force_resume returned 0 after 1 usecs
[ 7915.618210][T29333] exyswd_rng exyswd_rng: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.618588][T29333] exyswd_rng exyswd_rng: PM: platform_pm_resume returned 0 after 15 usecs
[ 7915.618907][T29333] exynos-decon 1c300000.drmdecon: PM: calling decon_resume [exynos_drm] @ 29333, parent: platform
[ 7915.619292][T29333] exynos-decon 1c300000.drmdecon: PM: decon_resume [exynos_drm] returned 0 after 2 usecs
[ 7915.619661][T29333] exynos-decon 1c302000.drmdecon: PM: calling decon_resume [exynos_drm] @ 29333, parent: platform
[ 7915.620053][T29333] exynos-decon 1c302000.drmdecon: PM: decon_resume [exynos_drm] returned 0 after 1 usecs
[ 7915.620413][T29333] exynos-g2d 1c640000.g2d: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.620782][T29333] exynos-g2d 1c640000.g2d: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.621106][T29333] exynos-jpeg 1c700000.smfc: PM: calling smfc_resume [smfc] @ 29333, parent: platform
[ 7915.621464][T29333] exynos-jpeg 1c700000.smfc: PM: smfc_resume [smfc] returned 0 after 2 usecs
[ 7915.621795][T29333] lwis-ioreg 1a840000.lwis_g3aa: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.622166][T29333] lwis-ioreg 1a840000.lwis_g3aa: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.622509][T29333] lwis-ioreg 1ba40000.lwis_gdc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.622876][T29333] lwis-ioreg 1ba40000.lwis_gdc: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.623217][T29333] lwis-ioreg 1ba60000.lwis_gdc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.623585][T29333] lwis-ioreg 1ba60000.lwis_gdc: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.623926][T29333] lwis-ioreg 1ba80000.lwis_scsc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.624298][T29333] lwis-ioreg 1ba80000.lwis_scsc: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.624641][T29333] lwis-ioreg 1aa40000.lwis_pdp: PM: calling lwis_ioreg_device_resume [lwis] @ 29333, parent: platform
[ 7915.625052][T29333] lwis-ioreg 1aa40000.lwis_pdp: PM: lwis_ioreg_device_resume [lwis] returned 0 after 1 usecs
[ 7915.625435][T29333] lwis-ioreg 1ac40000.lwis_ipp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.625803][T29333] lwis-ioreg 1ac40000.lwis_ipp: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.626143][T29333] lwis-ioreg 1ac80000.lwis_gtnr_align: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.626536][T29333] lwis-ioreg 1ac80000.lwis_gtnr_align: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.626899][T29333] lwis-ioreg 1b450000.lwis_itp: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.627267][T29333] lwis-ioreg 1b450000.lwis_itp: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.627610][T29333] lwis-ioreg 1b760000.lwis_mcsc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.627960][T29333] lwis-ioreg 1b760000.lwis_mcsc: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.628345][T29333] s5p-mfc mfc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.628617][T29333] s5p-mfc mfc: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.628929][T29333] lwis-ioreg 1bc40000.lwis_gtnr_merge: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.629309][T29333] lwis-ioreg 1bc40000.lwis_gtnr_merge: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.629673][T29333] lwis-ioreg 1a4e0000.lwis_votf: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.630044][T29333] lwis-ioreg 1a4e0000.lwis_votf: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.630388][T29333] edgetpu_platform 1ce00000.abrolhos: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.630777][T29333] edgetpu_platform 1ce00000.abrolhos: PM: platform_pm_resume returned 0 after 3 usecs
[ 7915.631164][T29333] exynos-ufs 14700000.ufs: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.631514][T29333] exynos-ufs 14700000.ufs: PM: platform_pm_resume returned 0 after 27 usecs
[ 7915.631796][T29333] scsi host0: PM: calling scsi_bus_resume @ 29333, parent: 14700000.ufs
[ 7915.632113][T29333] scsi host0: PM: scsi_bus_resume returned 0 after 1 usecs
[ 7915.632381][T29333] scsi target0:0:0: PM: calling scsi_bus_resume @ 29333, parent: host0
[ 7915.632705][T29333] scsi target0:0:0: PM: scsi_bus_resume returned 0 after 1 usecs
[ 7915.632998][T29333] ufs_device_wlun 0:0:0:49488: PM: calling scsi_bus_resume @ 29333, parent: target0:0:0
[ 7915.633374][T29333] exynos-ufs 14700000.ufs: kdn: restoring keys
[ 7915.641557][T29333] exynos-ufs 14700000.ufs: kdn: programming keyslot 0 with 80-byte wrapped key
[ 7915.652689][T29333] exynos-ufs 14700000.ufs: kdn: programming keyslot 1 with 80-byte wrapped key
[ 7915.656645][T29333] exynos-ufs 14700000.ufs: kdn: programming keyslot 2 with 80-byte wrapped key
[ 7915.657373][T29333] exynos-ufs 14700000.ufs: kdn: programming keyslot 3 with 80-byte wrapped key
^C[ 7915.678918][T29333] exynos-ufs 14700000.ufs: PA_ActiveTxDataLanes(2), PA_ActiveRxDataLanes(2)
[ 7915.689798][T29333] ufs_device_wlun 0:0:0:49488: PM: scsi_bus_resume returned 0 after 56439 usecs
[ 7915.689961][T29333] scsi 0:0:0:49476: PM: calling scsi_bus_resume @ 29333, parent: target0:0:0
[ 7915.690111][T29333] scsi 0:0:0:49476: PM: scsi_bus_resume returned 0 after 3 usecs
[ 7915.690249][T29333] scsi 0:0:0:49456: PM: calling scsi_bus_resume @ 29333, parent: target0:0:0
[ 7915.690397][T29333] scsi 0:0:0:49456: PM: scsi_bus_resume returned 0 after 2 usecs
[ 7915.690548][T29333] sd 0:0:0:0: PM: calling scsi_bus_resume @ 29333, parent: target0:0:0
[ 7915.690868][T29333] sd 0:0:0:0: PM: scsi_bus_resume returned 0 after 3 usecs
[ 7915.691143][T29333] sd 0:0:0:1: PM: calling scsi_bus_resume @ 29333, parent: target0:0:0
[ 7915.691446][T29333] sd 0:0:0:1: PM: scsi_bus_resume returned 0 after 2 usecs
[ 7915.691725][T29333] sd 0:0:0:2: PM: calling scsi_bus_resume @ 29333, parent: target0:0:0
[ 7915.692025][T29333] sd 0:0:0:2: PM: scsi_bus_resume returned 0 after 2 usecs
[ 7915.692302][T29333] sd 0:0:0:3: PM: calling scsi_bus_resume @ 29333, parent: target0:0:0
[ 7915.692603][T29333] sd 0:0:0:3: PM: scsi_bus_resume returned 0 after 3 usecs
[ 7915.692998][T29333] input input1: PM: calling input_dev_resume @ 29333, parent: none
[ 7915.693146][T29333] input input1: PM: input_dev_resume returned 0 after 2 usecs
[ 7915.693453][T29333] st21nfc i2c-st21nfc: PM: calling st21nfc_resume [st21nfc] @ 29333, parent: i2c-7
[ 7915.693802][T29333] st21nfc i2c-st21nfc: PM: st21nfc_resume [st21nfc] returned 0 after 6 usecs
[ 7915.694134][T29333] at24 8-0050: PM: calling pm_runtime_force_resume @ 29333, parent: i2c-8
[ 7915.694445][T29333] at24 8-0050: PM: pm_runtime_force_resume returned 0 after 1 usecs
[ 7915.694765][T29333] google_mitigation google,mitigation: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.695136][T29333] google_mitigation google,mitigation: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.695499][T29333] pca9468 12-0057: PM: calling pca9468_resume [pca9468] @ 29333, parent: i2c-12
^C[ 7915.697185][T29333] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 03:32:43(0x10)AM
[ 7915.697329][T29333] pca9468 12-0057: PM: pca9468_resume [pca9468] returned 0 after 1492 usecs
[ 7915.697485][T29333] s2mpg10 i2c-s2mpg10: PM: calling s2mpg10_resume [s2mpg10_mfd] @ 29333, parent: i2c-20
[ 7915.697649][T29333] s2mpg10:s2mpg10_resume
[ 7915.697727][T29333] s2mpg10 i2c-s2mpg10: PM: s2mpg10_resume [s2mpg10_mfd] returned 0 after 79 usecs
[ 7915.697827][  T244] s2mpg10_irq_thread: interrupt source(0x01)
[ 7915.697889][T29333] s2mpg10-regulator s2mpg10-regulator: PM: calling platform_pm_resume @ 29333, parent: i2c-s2mpg10
[ 7915.698215][  T244] s2mpg10_irq_thread: pmic interrupt(0x00, 0x0c, 0x00, 0x00, 0x00, 0x00)
[ 7915.698554][T29333] s2mpg10-regulator s2mpg10-regulator: PM: platform_pm_resume returned 0 after 76 usecs
[ 7915.698826][  T244] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_alarm_irq:irq(217)
[ 7915.699205][T29333] regulator regulator.3: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.699800][T29333] regulator regulator.3: PM: regulator_resume returned 0 after 2 usecs
[ 7915.700106][T29333] regulator regulator.4: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.700465][T29333] regulator regulator.4: PM: regulator_resume returned 0 after 2 usecs
[ 7915.700773][T29333] regulator regulator.5: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.700885][T28104] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 03:32:43(0x10)AM
[ 7915.701162][T29333] regulator regulator.5: PM: regulator_resume returned 0 after 23 usecs
[ 7915.701782][T29333] regulator regulator.6: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.702166][T29333] regulator regulator.6: PM: regulator_resume returned 0 after 1 usecs
[ 7915.702475][T29333] regulator regulator.7: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.702826][T29333] regulator regulator.7: PM: regulator_resume returned 0 after 2 usecs
[ 7915.702893][T28104] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_read_time: 2025-07-10 03:32:43(0x10)AM
[ 7915.703150][T29333] regulator regulator.8: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.703472][T28104] s2mpg10-rtc s2mpg10-rtc: s2m_rtc_set_alarm: 2025-07-10 03:32:50(0x10)AM
[ 7915.703839][T29333] regulator regulator.8: PM: regulator_resume returned 0 after 22 usecs
[ 7915.704459][T29333] regulator regulator.9: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.704843][T29333] regulator regulator.9: PM: regulator_resume returned 0 after 1 usecs
[ 7915.705152][T29333] regulator regulator.10: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.705524][T29333] regulator regulator.10: PM: regulator_resume returned 0 after 1 usecs
[ 7915.705819][T29333] regulator regulator.11: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.706210][T29333] regulator regulator.11: PM: regulator_resume returned 0 after 1 usecs
[ 7915.706522][T29333] regulator regulator.12: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.706895][T29333] regulator regulator.12: PM: regulator_resume returned 0 after 1 usecs
[ 7915.707189][T29333] regulator regulator.13: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.707580][T29333] regulator regulator.13: PM: regulator_resume returned 0 after 1 usecs
[ 7915.707893][T29333] regulator regulator.14: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.708267][T29333] regulator regulator.14: PM: regulator_resume returned 0 after 1 usecs
[ 7915.708578][T29333] regulator regulator.15: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.708950][T29333] regulator regulator.15: PM: regulator_resume returned 0 after 1 usecs
[ 7915.709263][T29333] regulator regulator.16: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.709635][T29333] regulator regulator.16: PM: regulator_resume returned 0 after 1 usecs
[ 7915.709948][T29333] regulator regulator.17: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.710321][T29333] regulator regulator.17: PM: regulator_resume returned 0 after 1 usecs
[ 7915.710633][T29333] regulator regulator.18: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.710987][T29333] regulator regulator.18: PM: regulator_resume returned 0 after 1 usecs
[ 7915.711318][T29333] regulator regulator.19: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.711691][T29333] regulator regulator.19: PM: regulator_resume returned 0 after 1 usecs
[ 7915.712004][T29333] regulator regulator.20: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.712378][T29333] regulator regulator.20: PM: regulator_resume returned 0 after 1 usecs
[ 7915.712689][T29333] regulator regulator.21: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.713062][T29333] regulator regulator.21: PM: regulator_resume returned 0 after 1 usecs
[ 7915.713374][T29333] regulator regulator.22: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.713746][T29333] regulator regulator.22: PM: regulator_resume returned 0 after 1 usecs
[ 7915.714059][T29333] regulator regulator.23: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.714431][T29333] regulator regulator.23: PM: regulator_resume returned 0 after 1 usecs
[ 7915.714744][T29333] regulator regulator.24: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.715117][T29333] regulator regulator.24: PM: regulator_resume returned 0 after 1 usecs
[ 7915.715429][T29333] regulator regulator.25: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.715802][T29333] regulator regulator.25: PM: regulator_resume returned 0 after 1 usecs
[ 7915.716098][T29333] regulator regulator.26: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.716469][T29333] regulator regulator.26: PM: regulator_resume returned 0 after 1 usecs
[ 7915.716799][T29333] regulator regulator.27: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.717172][T29333] regulator regulator.27: PM: regulator_resume returned 0 after 1 usecs
[ 7915.717485][T29333] regulator regulator.28: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.717857][T29333] regulator regulator.28: PM: regulator_resume returned 0 after 1 usecs
[ 7915.718170][T29333] regulator regulator.29: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.718542][T29333] regulator regulator.29: PM: regulator_resume returned 0 after 1 usecs
[ 7915.718855][T29333] regulator regulator.30: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.719227][T29333] regulator regulator.30: PM: regulator_resume returned 0 after 1 usecs
[ 7915.719540][T29333] regulator regulator.31: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.719913][T29333] regulator regulator.31: PM: regulator_resume returned 0 after 1 usecs
[ 7915.720208][T29333] regulator regulator.32: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.720598][T29333] regulator regulator.32: PM: regulator_resume returned 0 after 1 usecs
[ 7915.720911][T29333] regulator regulator.33: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.721283][T29333] regulator regulator.33: PM: regulator_resume returned 0 after 1 usecs
[ 7915.721577][T29333] regulator regulator.34: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.721969][T29333] regulator regulator.34: PM: regulator_resume returned 0 after 1 usecs
[ 7915.722281][T29333] regulator regulator.35: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.722654][T29333] regulator regulator.35: PM: regulator_resume returned 0 after 1 usecs
[ 7915.722966][T29333] regulator regulator.36: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.723339][T29333] regulator regulator.36: PM: regulator_resume returned 0 after 1 usecs
[ 7915.723651][T29333] regulator regulator.37: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.724022][T29333] regulator regulator.37: PM: regulator_resume returned 0 after 1 usecs
[ 7915.724318][T29333] regulator regulator.38: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.724709][T29333] regulator regulator.38: PM: regulator_resume returned 0 after 1 usecs
[ 7915.725021][T29333] regulator regulator.39: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.725394][T29333] regulator regulator.39: PM: regulator_resume returned 0 after 1 usecs
[ 7915.725707][T29333] regulator regulator.40: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.726079][T29333] regulator regulator.40: PM: regulator_resume returned 0 after 1 usecs
[ 7915.726392][T29333] regulator regulator.41: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.726764][T29333] regulator regulator.41: PM: regulator_resume returned 0 after 1 usecs
[ 7915.727077][T29333] regulator regulator.42: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.727450][T29333] regulator regulator.42: PM: regulator_resume returned 0 after 1 usecs
[ 7915.727762][T29333] regulator regulator.43: PM: calling regulator_resume @ 29333, parent: s2mpg10-regulator
[ 7915.728136][T29333] regulator regulator.43: PM: regulator_resume returned 0 after 0 usecs
[ 7915.728427][T29333] s2mpg10-rtc s2mpg10-rtc: PM: calling platform_pm_resume @ 29333, parent: i2c-s2mpg10
[ 7915.728810][T29333] s2mpg10-rtc s2mpg10-rtc: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.729134][T29333] rtc rtc0: PM: calling rtc_resume @ 29333, parent: s2mpg10-rtc
[ 7915.729419][T29333] rtc rtc0: PM: rtc_resume returned 0 after 2 usecs
[ 7915.729665][T29333] alarmtimer alarmtimer.1.auto: PM: calling platform_pm_resume @ 29333, parent: rtc0
[ 7915.730023][T29333] alarmtimer alarmtimer.1.auto: PM: platform_pm_resume returned 0 after 4 usecs
[ 7915.730360][T29333] s2mpg10-meter s2mpg10-meter: PM: calling platform_pm_resume @ 29333, parent: i2c-s2mpg10
[ 7915.730736][T29333] s2mpg10-meter s2mpg10-meter: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.731072][T29333] odpm s2mpg10-odpm: PM: calling platform_pm_resume @ 29333, parent: s2mpg10-meter
[ 7915.732963][T29333] odpm s2mpg10-odpm: PM: platform_pm_resume returned 0 after 1543 usecs
[ 7915.733105][T29333] s2mpg1x_gpio s2mpg10_gpio: PM: calling platform_pm_resume @ 29333, parent: i2c-s2mpg10
[ 7915.733267][T29333] s2mpg1x_gpio s2mpg10_gpio: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.733427][T29333] s2mpg11 i2c-s2mpg11: PM: calling s2mpg11_resume [s2mpg11_mfd] @ 29333, parent: i2c-21
[ 7915.733590][T29333] s2mpg11:s2mpg11_resume
[ 7915.733666][T29333] s2mpg11 i2c-s2mpg11: PM: s2mpg11_resume [s2mpg11_mfd] returned 0 after 77 usecs
[ 7915.734024][T29333] exynos-pcie-rc 11920000.pcie: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.734390][T29333] exynos-pcie-rc 11920000.pcie: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.734737][T29333] s2mpg11-regulator s2mpg11-regulator: PM: calling platform_pm_resume @ 29333, parent: i2c-s2mpg11
[ 7915.735189][T29333] s2mpg11-regulator s2mpg11-regulator: PM: platform_pm_resume returned 0 after 58 usecs
[ 7915.735512][T29333] regulator regulator.44: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.735870][T29333] regulator regulator.44: PM: regulator_resume returned 0 after 1 usecs
[ 7915.736184][T29333] regulator regulator.45: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.736555][T29333] regulator regulator.45: PM: regulator_resume returned 0 after 1 usecs
[ 7915.736867][T29333] regulator regulator.46: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.737240][T29333] regulator regulator.46: PM: regulator_resume returned 0 after 1 usecs
[ 7915.737552][T29333] regulator regulator.47: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.737925][T29333] regulator regulator.47: PM: regulator_resume returned 0 after 1 usecs
[ 7915.738238][T29333] regulator regulator.48: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.738611][T29333] regulator regulator.48: PM: regulator_resume returned 0 after 1 usecs
[ 7915.738922][T29333] regulator regulator.49: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.739295][T29333] regulator regulator.49: PM: regulator_resume returned 0 after 1 usecs
[ 7915.739608][T29333] regulator regulator.50: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.739980][T29333] regulator regulator.50: PM: regulator_resume returned 0 after 1 usecs
[ 7915.740365][T29333] regulator regulator.51: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.740643][T29333] regulator regulator.51: PM: regulator_resume returned 0 after 1 usecs
[ 7915.740978][T29333] regulator regulator.52: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.741350][T29333] regulator regulator.52: PM: regulator_resume returned 0 after 1 usecs
[ 7915.741663][T29333] regulator regulator.53: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.742035][T29333] regulator regulator.53: PM: regulator_resume returned 0 after 1 usecs
[ 7915.742348][T29333] regulator regulator.54: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.742702][T29333] regulator regulator.54: PM: regulator_resume returned 0 after 1 usecs
[ 7915.743033][T29333] regulator regulator.55: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.743384][T29333] regulator regulator.55: PM: regulator_resume returned 0 after 1 usecs
[ 7915.743699][T29333] regulator regulator.56: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.744093][T29333] regulator regulator.56: PM: regulator_resume returned 0 after 2 usecs
[ 7915.744381][T29333] regulator regulator.57: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.744776][T29333] regulator regulator.57: PM: regulator_resume returned 0 after 1 usecs
[ 7915.745089][T29333] regulator regulator.58: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.745461][T29333] regulator regulator.58: PM: regulator_resume returned 0 after 1 usecs
[ 7915.745774][T29333] regulator regulator.59: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.746147][T29333] regulator regulator.59: PM: regulator_resume returned 0 after 1 usecs
[ 7915.746459][T29333] regulator regulator.60: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.746831][T29333] regulator regulator.60: PM: regulator_resume returned 0 after 1 usecs
[ 7915.747144][T29333] regulator regulator.61: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.747517][T29333] regulator regulator.61: PM: regulator_resume returned 0 after 1 usecs
[ 7915.747829][T29333] regulator regulator.62: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.748204][T29333] regulator regulator.62: PM: regulator_resume returned 0 after 2 usecs
[ 7915.748495][T29333] regulator regulator.63: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.748887][T29333] regulator regulator.63: PM: regulator_resume returned 0 after 1 usecs
[ 7915.749200][T29333] regulator regulator.64: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.749572][T29333] regulator regulator.64: PM: regulator_resume returned 0 after 1 usecs
[ 7915.749884][T29333] regulator regulator.65: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.750257][T29333] regulator regulator.65: PM: regulator_resume returned 0 after 1 usecs
[ 7915.750570][T29333] regulator regulator.66: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.750943][T29333] regulator regulator.66: PM: regulator_resume returned 0 after 1 usecs
[ 7915.751255][T29333] regulator regulator.67: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.751627][T29333] regulator regulator.67: PM: regulator_resume returned 0 after 1 usecs
[ 7915.751941][T29333] regulator regulator.68: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.752315][T29333] regulator regulator.68: PM: regulator_resume returned 0 after 1 usecs
[ 7915.752625][T29333] regulator regulator.69: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.752979][T29333] regulator regulator.69: PM: regulator_resume returned 0 after 1 usecs
[ 7915.753302][T29333] regulator regulator.70: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.753683][T29333] regulator regulator.70: PM: regulator_resume returned 0 after 1 usecs
[ 7915.753995][T29333] regulator regulator.71: PM: calling regulator_resume @ 29333, parent: s2mpg11-regulator
[ 7915.754368][T29333] regulator regulator.71: PM: regulator_resume returned 0 after 1 usecs
[ 7915.754682][T29333] s2mpg11-meter s2mpg11-meter: PM: calling platform_pm_resume @ 29333, parent: i2c-s2mpg11
[ 7915.755056][T29333] s2mpg11-meter s2mpg11-meter: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.755393][T29333] odpm s2mpg11-odpm: PM: calling platform_pm_resume @ 29333, parent: s2mpg11-meter
^C[ 7915.757007][T29333] odpm s2mpg11-odpm: PM: platform_pm_resume returned 0 after 1285 usecs
[ 7915.757149][T29333] s2mpg1x_gpio s2mpg11_gpio: PM: calling platform_pm_resume @ 29333, parent: i2c-s2mpg11
[ 7915.757311][T29333] s2mpg1x_gpio s2mpg11_gpio: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.757467][T29333] gs101-spmic-thermal gs101-spmic-thermal: PM: calling platform_pm_resume @ 29333, parent: i2c-s2mpg11
[ 7915.757649][T29333] gs101-spmic-thermal gs101-spmic-thermal: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.757998][T29333] mfc-core 1c8d0000.MFC-0: PM: calling platform_pm_resume @ 29333, parent: mfc
[ 7915.758325][T29333] mfc-core 1c8d0000.MFC-0: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.758647][T29333] sscoredump mfc-core: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.758986][T29333] sscoredump mfc-core: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.759326][T29333] arm-memlat-mon cpu0-cpugrp:cpu0-cpu-mif-latmon: PM: calling platform_pm_resume @ 29333, parent: cpu0-cpugrp
[ 7915.759734][T29333] arm-memlat-mon cpu0-cpugrp:cpu0-cpu-mif-latmon: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.760135][T29333] arm-memlat-mon cpu1-cpugrp:cpu1-cpu-mif-latmon: PM: calling platform_pm_resume @ 29333, parent: cpu1-cpugrp
[ 7915.760553][T29333] arm-memlat-mon cpu1-cpugrp:cpu1-cpu-mif-latmon: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.760971][T29333] arm-memlat-mon cpu2-cpugrp:cpu2-cpu-mif-latmon: PM: calling platform_pm_resume @ 29333, parent: cpu2-cpugrp
[ 7915.761410][T29333] arm-memlat-mon cpu2-cpugrp:cpu2-cpu-mif-latmon: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.761810][T29333] arm-memlat-mon cpu3-cpugrp:cpu3-cpu-mif-latmon: PM: calling platform_pm_resume @ 29333, parent: cpu3-cpugrp
[ 7915.762249][T29333] arm-memlat-mon cpu3-cpugrp:cpu3-cpu-mif-latmon: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.762647][T29333] arm-memlat-mon cpu4-cpugrp:cpu4-cpu-mif-latmon: PM: calling platform_pm_resume @ 29333, parent: cpu4-cpugrp
[ 7915.763086][T29333] arm-memlat-mon cpu4-cpugrp:cpu4-cpu-mif-latmon: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.763486][T29333] arm-memlat-mon cpu5-cpugrp:cpu5-cpu-mif-latmon: PM: calling platform_pm_resume @ 29333, parent: cpu5-cpugrp
[ 7915.763905][T29333] arm-memlat-mon cpu5-cpugrp:cpu5-cpu-mif-latmon: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.764326][T29333] arm-memlat-mon cpu6-cpugrp:cpu6-cpu-mif-latmon: PM: calling platform_pm_resume @ 29333, parent: cpu6-cpugrp
[ 7915.764744][T29333] arm-memlat-mon cpu6-cpugrp:cpu6-cpu-mif-latmon: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.765161][T29333] arm-memlat-mon cpu7-cpugrp:cpu7-cpu-mif-latmon: PM: calling platform_pm_resume @ 29333, parent: cpu7-cpugrp
[ 7915.765601][T29333] arm-memlat-mon cpu7-cpugrp:cpu7-cpu-mif-latmon: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.766003][T29333] tui-driver tui-driver: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.766346][T29333] tui-driver tui-driver: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.766662][T29333] exynos-drm exynos-drm: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.767008][T29333] exynos-drm exynos-drm: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.767374][T29333] mali 1c500000.mali: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.768107][T29333] mali 1c500000.mali: PM: platform_pm_resume returned 0 after 446 usecs
[ 7915.768290][T29333] audiometrics audiometrics: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.768452][T29333] audiometrics audiometrics: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.768652][T29333] aoc 19000000.aoc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.769014][T29333] aoc 19000000.aoc: PM: platform_pm_resume returned 0 after 24 usecs
[ 7915.769332][T29333] sscoredump aoc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.769616][T29333] sscoredump aoc: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.769920][T29333] sscoredump bigocean: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.770247][T29333] sscoredump bigocean: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.770589][T29333] pcieport 0000:00:00.0: PM: calling pci_pm_resume @ 29333, parent: pci0000:00
[ 7915.770930][T29333] pcieport 0000:00:00.0: PM: pci_pm_resume returned 0 after 39 usecs
[ 7915.771204][T29333] exynos-pcie-rc 14520000.pcie: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.771564][T29333] exynos-pcie-rc 14520000.pcie: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.772094][T29333] pcieport 0001:00:00.0: PM: calling pci_pm_resume @ 29333, parent: pci0001:00
[ 7915.772280][T29333] pcieport 0001:00:00.0: PM: pci_pm_resume returned 0 after 38 usecs
[ 7915.772553][T29333] pixel-em pixel-em: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.772875][T29333] pixel-em pixel-em: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.773179][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu0_memlat@17000010: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.773689][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu0_memlat@17000010: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.774174][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu1_memlat@17000010: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.774684][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu1_memlat@17000010: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.775168][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu2_memlat@17000010: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.775679][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu2_memlat@17000010: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.776187][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu3_memlat@17000010: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.776655][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu3_memlat@17000010: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.777158][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu4_memlat@17000010: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.777668][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu4_memlat@17000010: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.778152][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu5_memlat@17000010: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.778662][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu5_memlat@17000010: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.779147][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu6_memlat@17000010: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.779656][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu6_memlat@17000010: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.780123][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu7_memlat@17000010: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.780651][T29333] gs101-memlat-devfreq gs_memlat_devfreq:devfreq_mif_cpu7_memlat@17000010: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.781171][T29333] google,charger google,charger: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.781511][T29333] google,charger google,charger: PM: platform_pm_resume returned 0 after 7 usecs
[ 7915.781848][T29333] google_cpm google,cpm: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.782196][T29333] google_cpm google,cpm: PM: platform_pm_resume returned 0 after 3 usecs
[ 7915.782512][T29333] phy_exynos_usbdrd 11100000.phy: PM: calling exynos_usbdrd_phy_resume [phy_exynos_usbdrd_super] @ 29333, parent: platform
[ 7915.782993][T29333] phy_exynos_usbdrd 11100000.phy: exynos_usbdrd_phy_resume, is_conn = 0
[ 7915.783304][T29333] phy_exynos_usbdrd 11100000.phy: PM: exynos_usbdrd_phy_resume [phy_exynos_usbdrd_super] returned 0 after 312 usecs
[ 7915.783775][T29333] exynos-dwc3 11110000.usb: PM: calling dwc3_exynos_resume [dwc3_exynos_usb] @ 29333, parent: platform
[ 7915.784212][T29333] exynos-dwc3 11110000.usb: PM: dwc3_exynos_resume [dwc3_exynos_usb] returned 0 after 13 usecs
[ 7915.784595][T29333] platform usb_phy_generic.2.auto: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.784993][T29333] platform usb_phy_generic.2.auto: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.785320][T29333] platform usb_phy_generic.3.auto: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.785708][T29333] platform usb_phy_generic.3.auto: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.786050][T29333] dwc3 11110000.dwc3: PM: calling platform_pm_resume @ 29333, parent: 11110000.usb
[ 7915.786423][T29333] exynos_usbdrd_utmi_init: +++
[ 7915.786799][T28194] google_charger: usbchg=USB typec=C usbv=5175 usbc=0 usbMv=5000 usbMc=100
^C[ 7915.788849][T29333] exynos_usbdrd_utmi_init: ---
[ 7915.789006][T28194] google_battery: MSC_DIN chg_state=64111e01030011 f=0x11 chg_s=Not Charging chg_t=N/A vchg=4382 icl=100
[ 7915.790118][T28194] google_battery: MSC_VOTE msc_state=2 cv_cnt=3 ov_cnt=0 rl_sts=-1 temp_idx:2, vbatt_idx:2  fv_uv=4450000 cc_max=0 update_interval=-1
[ 7915.799090][T29333] phy_exynos_usbdp_g2_v4_enable: reg000:00000000a3828fb9, reg0001:000000008f9c4596
^C^C^C[ 7915.910328][T29333] dwc3 11110000.dwc3: PM: platform_pm_resume returned 0 after 123913 usecs
[ 7915.910489][T29333] google,usbc_port_cooling_dev google,usbc_port_cooling_dev: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.910715][T29333] google,usbc_port_cooling_dev google,usbc_port_cooling_dev: PM: platform_pm_resume returned 0 after 3 usecs
[ 7915.910928][T29333] platform regulatory.0: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.911084][T29333] platform regulatory.0: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.911402][T29333] slg51000-regulator slg51000-regulator: PM: calling platform_pm_resume @ 29333, parent: 7-0075
[ 7915.911794][T29333] slg51000-regulator slg51000-regulator: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.912154][T29333] regulator regulator.72: PM: calling regulator_resume @ 29333, parent: 7-0075
[ 7915.912477][T29333] regulator regulator.72: PM: regulator_resume returned 0 after 2 usecs
[ 7915.912811][T29333] regulator regulator.73: PM: calling regulator_resume @ 29333, parent: 7-0075
[ 7915.913148][T29333] regulator regulator.73: PM: regulator_resume returned 0 after 2 usecs
[ 7915.913459][T29333] regulator regulator.74: PM: calling regulator_resume @ 29333, parent: 7-0075
[ 7915.913795][T29333] regulator regulator.74: PM: regulator_resume returned 0 after 1 usecs
[ 7915.914107][T29333] regulator regulator.75: PM: calling regulator_resume @ 29333, parent: 7-0075
[ 7915.914444][T29333] regulator regulator.75: PM: regulator_resume returned 0 after 1 usecs
[ 7915.914756][T29333] regulator regulator.76: PM: calling regulator_resume @ 29333, parent: 7-0075
[ 7915.915092][T29333] regulator regulator.76: PM: regulator_resume returned 0 after 1 usecs
[ 7915.915405][T29333] regulator regulator.77: PM: calling regulator_resume @ 29333, parent: 7-0075
[ 7915.915741][T29333] regulator regulator.77: PM: regulator_resume returned 0 after 1 usecs
[ 7915.916056][T29333] regulator regulator.78: PM: calling regulator_resume @ 29333, parent: 7-0075
[ 7915.916389][T29333] regulator regulator.78: PM: regulator_resume returned 0 after 1 usecs
[ 7915.916702][T29333] regulator regulator.79: PM: calling regulator_resume @ 29333, parent: 7-0075
[ 7915.917038][T29333] regulator regulator.79: PM: regulator_resume returned 0 after 1 usecs
[ 7915.917351][T29333] platform slg51000_gpio: PM: calling platform_pm_resume @ 29333, parent: 7-0075
[ 7915.917693][T29333] platform slg51000_gpio: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.918013][T29333] platform sensor@0: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.918345][T29333] platform sensor@0: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.918648][T29333] platform sensor@1: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.918980][T29333] platform sensor@1: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.919284][T29333] platform sensor@2: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.919615][T29333] platform sensor@2: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.919919][T29333] stmvl53l1 1-0029: PM: calling stmvl53l1_resume [stmvl53l1] @ 29333, parent: i2c-1
[ 7915.920273][T29333] stmvl53l1 1-0029: PM: stmvl53l1_resume [stmvl53l1] returned 0 after 1 usecs
[ 7915.920584][T29333] input input2: PM: calling input_dev_resume @ 29333, parent: none
[ 7915.920900][T29333] input input2: PM: input_dev_resume returned 0 after 1 usecs
[ 7915.921186][T29333] lwis-ioreg 1a440000.lwis_csi: PM: calling lwis_ioreg_device_resume [lwis] @ 29333, parent: platform
[ 7915.921592][T29333] lwis-ioreg 1a440000.lwis_csi: PM: lwis_ioreg_device_resume [lwis] returned 0 after 1 usecs
[ 7915.921993][T29333] lwis-i2c eeprom@0: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.922306][T29333] lwis-i2c eeprom@0: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.922612][T29333] lwis-i2c eeprom@1: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.922923][T29333] lwis-i2c eeprom@1: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.923247][T29333] lwis-i2c eeprom@2: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.923577][T29333] lwis-i2c eeprom@2: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.923883][T29333] lwis-i2c actuator@0: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.924220][T29333] lwis-i2c actuator@0: PM: platform_pm_resume returned 0 after 2 usecs
[ 7915.924512][T29333] lwis-i2c ois@0: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.924850][T29333] lwis-i2c ois@0: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.925157][T29333] cs40l2x i2c-c240l2x: PM: calling cs40l2x_sys_resume [haptics_cs40l2x] @ 29333, parent: i2c-8
[ 7915.925534][T29333] cs40l2x i2c-c240l2x: PM: cs40l2x_sys_resume [haptics_cs40l2x] returned 0 after 3 usecs
[ 7915.925904][T29333] cs40l2x-codec cs40l2x-codec.4.auto: PM: calling platform_pm_resume @ 29333, parent: i2c-c240l2x
[ 7915.926300][T29333] cs40l2x-codec cs40l2x-codec.4.auto: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.926662][T29333] rfkill rfkill0: PM: calling rfkill_resume [rfkill] @ 29333, parent: odm:btbcm
[ 7915.927000][T29333] rfkill rfkill0: PM: rfkill_resume [rfkill] returned 0 after 2 usecs
[ 7915.927307][T29333] exynos-dsim 1c2c0000.drmdsim: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.927674][T29333] exynos-dsim 1c2c0000.drmdsim: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.928015][T29333] panel-samsung-s6e3fc3 1c2c0000.drmdsim.0: PM: calling pm_generic_resume @ 29333, parent: 1c2c0000.drmdsim
[ 7915.928448][T29333] panel-samsung-s6e3fc3 1c2c0000.drmdsim.0: PM: pm_generic_resume returned 0 after 2 usecs
[ 7915.928805][T29333] backlight panel0-backlight: PM: calling backlight_resume @ 29333, parent: 1c2c0000.drmdsim.0
[ 7915.929212][T29333] backlight panel0-backlight: PM: backlight_resume returned 0 after 2 usecs
[ 7915.929539][T29333] leds vibrator: PM: calling led_resume @ 29333, parent: i2c-c240l2x
[ 7915.929841][T29333] leds vibrator: PM: led_resume returned 0 after 2 usecs
[ 7915.930110][T29333] sscoredump wlan: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.930428][T29333] sscoredump wlan: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.930729][T29333] pcieh 0001:01:00.0: PM: calling pci_pm_resume @ 29333, parent: 0001:00:00.0
[ 7915.932158][T29333] exynos-pcie-rc 14520000.pcie: AFC cal mode set to restart
[ 7915.941948][T29333] exynos-pcie-rc 14520000.pcie: exynos_pcie_rc_establish_link: Set PERST to logical 0, gpio(99) val=(0)
^C[ 7915.964590][T29333] logbuffer_pcie1: [  365] D state: 0, LTSSM: 0
[ 7915.964811][T29333] logbuffer_pcie1: [  366] L0(0x11)
[ 7915.968015][T29333] pcieh 0001:01:00.0: enabling device (0000 -> 0002)
[ 7915.968312][T29333] [03:32:43.788271][dhd][wlan]dhd_plat_l1ss_ctrl: Control L1ss RC side 1 ret:0
[ 7915.968601][T29333] pcieh 0001:01:00.0: PM: pci_pm_resume returned 0 after 37546 usecs
[ 7915.968751][T29333] ieee80211 phy0: PM: calling wiphy_resume [cfg80211] @ 29333, parent: none
[ 7915.968968][T29333] ieee80211 phy0: PM: wiphy_resume [cfg80211] returned 0 after 13 usecs
[ 7915.969150][T29333] rfkill rfkill1: PM: calling rfkill_resume [rfkill] @ 29333, parent: phy0
[ 7915.969304][T29333] rfkill rfkill1: PM: rfkill_resume [rfkill] returned 0 after 7 usecs
[ 7915.969443][T29333] rfkill rfkill2: PM: calling rfkill_resume [rfkill] @ 29333, parent: none
[ 7915.969726][T29333] rfkill rfkill2: PM: rfkill_resume [rfkill] returned 0 after 4 usecs
[ 7915.970036][T29333] fts spi11.0: PM: calling fts_pm_resume [ftm5] @ 29333, parent: spi11
[ 7915.970339][T29333] fts spi11.0: PM: fts_pm_resume [ftm5] returned 0 after 1 usecs
[ 7915.970629][T29333] input input3: PM: calling input_dev_resume @ 29333, parent: spi11.0
[ 7915.970934][T29333] input input3: PM: input_dev_resume returned 0 after 2 usecs
[ 7915.971276][T29333] aoc_uwb_pdrv aoc_gpiochip: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.971572][T29333] aoc_uwb_pdrv aoc_gpiochip: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.972007][T29333] google-aoc-snd-card sound-aoc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.972273][T29333] google-aoc-snd-card sound-aoc: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.972795][T29333] s51xx 0000:01:00.0: PM: calling pci_pm_resume @ 29333, parent: 0000:00:00.0
[ 7915.972944][T29333] s51xx 0000:01:00.0: PM: pci_pm_resume returned 0 after 1 usecs
[ 7915.973249][T29333] platform dbgdev-pd-hsi2: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.973591][T29333] platform dbgdev-pd-hsi2: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.973913][T29333] platform dbgdev-pd-aoc: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.974263][T29333] platform dbgdev-pd-aoc: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.974582][T29333] platform dbgdev-pd-bus1: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.974934][T29333] platform dbgdev-pd-bus1: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.975258][T29333] platform dbgdev-pd-bus2: PM: calling platform_pm_resume @ 29333, parent: platform
[ 7915.975610][T29333] platform dbgdev-pd-bus2: PM: platform_pm_resume returned 0 after 1 usecs
[ 7915.975914][T29333] PM: resume of devices complete after 430.625 msecs
^C[ 7915.977715][T29333] exynos-pcie-rc 11920000.pcie: Default must_resume value : 0
[ 7915.980813][T29333] OOM killer enabled.
[ 7915.980885][T29333] Restarting tasks: Starting
[ 7915.981098][T29299] exynos5-hsi2c 10d50000.hsi2c: tudor: exynos5_i2c_runtime_suspend enter
[ 7915.981246][T29299] exynos5-hsi2c 10d50000.hsi2c: tudor: exynos5_i2c_runtime_suspend exit
[ 7915.986707][ T1005] s3c2410-wdt 10070000.watchdog_cl1: Watchdog cluster 1 keepalive!, old_wtcnt = fc1d, wtcnt = ffaf
[ 7915.994666][ T1085] dwc3 11110000.dwc3: request 00000000c350878f was not queued to ep0out
[ 7915.995020][T28194] google,charger google,charger: chg_psy_changed name=usb evt=0
[ 7915.995208][T29333] Restarting tasks: Done
[ 7915.995815][T29333] [03:32:43.815772][dhd][wlan]dhd_pm_callback action: 4
[ 7915.998042][ T1085] read descriptors
[ 7915.998110][ T1085] bcdVersion must be 0x0100, stored in Little Endian order. Userspace driver should be fixed, accepting 0x0001 for compatibility.
[ 7915.998446][ T1085] bcdVersion must be 0x0100, stored in Little Endian order. Userspace driver should be fixed, accepting 0x0001 for compatibility.
[ 7915.998683][T27196] google_charger: usbchg=USB typec=C usbv=5175 usbc=0 usbMv=5000 usbMc=100
[ 7915.998965][ T1085] read strings
[ 7916.002015][  T912] healthd: battery l=100 v=4382 t=30.1 h=2 st=5 c=-298750 fc=4460000 cc=43 chg=u
[ 7916.002141][T29333] Resume caused by IRQ 217, rtc-alarm0
[ 7916.002257][T29333] PM: suspend exit 2025-07-10 03:32:43.822217078 UTC
[ 7916.002435][T29333] cpif: s5100_pm_notifier: Resume done
[ 7916.002924][T27196] google_battery: MSC_DIN chg_state=64111e01030011 f=0x11 chg_s=Not Charging chg_t=N/A vchg=4382 icl=100
[ 7916.003775][T27196] google_battery: MSC_VOTE msc_state=2 cv_cnt=3 ov_cnt=0 rl_sts=-1 temp_idx:2, vbatt_idx:2  fv_uv=4450000 cc_max=0 update_interval=-1
[ 7916.004413][T29333] PM: suspend exit


