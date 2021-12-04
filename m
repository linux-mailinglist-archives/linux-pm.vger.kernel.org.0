Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA94E468692
	for <lists+linux-pm@lfdr.de>; Sat,  4 Dec 2021 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378567AbhLDRjO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Dec 2021 12:39:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:39741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345154AbhLDRjO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Dec 2021 12:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638639340;
        bh=P0AbYIvlWjgTWu5yegoAvLM4dCjHvowJhyTy6bkoJG8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:In-Reply-To:References:Subject;
        b=XESGG8iQ1GviKFkPv8qA9YE2GZhoIO3aJmihWObTZSL3NhZcUih+O4naya70553SM
         jBPk09dwUdHJbhq33HDxlw+feo9E8/iKtANeibvuNIOYifOskyZrpro7ACZZ2Xt9rP
         wqW2Co0CQ5auFay/9ULabI+Z/56pHg1SIPT11mc8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from flodo-tb13 ([37.5.248.227]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsEn-1mcADk2731-00ssTO; Sat, 04
 Dec 2021 18:35:39 +0100
Date:   Sat, 4 Dec 2021 18:35:38 +0100
From:   Florian Dollinger <dollinger.florian@gmx.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm <linux-pm@vger.kernel.org>
Message-ID: <69AD17DD-0490-425F-B74E-8E4D9C18915F@getmailspring.com>
In-Reply-To: <3B1F93FF-F9B3-4BCB-AA31-AD8C692BA53D@getmailspring.com>
References: <3B1F93FF-F9B3-4BCB-AA31-AD8C692BA53D@getmailspring.com>
Subject: Re: Thinkbook 13s-IWL issues
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Provags-ID: V03:K1:W/OJ9UcpIyTGPl5y4m+MndgImMhTAxKijXd0kfm2rdo//YR3qAx
 7+PZouF6uQFxXMb5uXC3VTSk8/+pHPoZijEDCyBJfDy1lakfSe6/bA+4VFoOQeX4PewjOn8
 o6BLAiRTvXWh1bwv74YG9xnqHHL/gIAqPcY9jvNp26tKPEjewIgADtZyXKvaRspMu8aimtl
 Ez0XN7g4CjjasWAXMNiOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:odyhUVc3LIM=:IK1sox+I3xzMpah3gDfGIt
 Df23toLQkT5XCPuAJkHPq3C4Apjb8RBORC9/6hkRvZ3Dp876EfHRPyqRD46bBNpVZRFS5LHHd
 ywhtXoW9Rl3bLtaKh9mJxoQAjJBQgJXkuYBb0sNDUpPIcso+7xTqDciP8O80slLGiS8zY85JI
 7cfcfP6UYM3678C/F+khM5TL2a0NGWyXaQz44EAP6KKHovFZXRIPSKy5zgxroDzJOQEmAYi0m
 jy3AcJtoPxq5pQpq7JFr6OWAJxLDEP3ZnVPx9IpgiE0NMqCUpKgPgicXiNQenPifVAqoUjo2S
 +UDtRoEZfdAEiljIAvt1ClIHdUdZRiK1ztvjWIRmH+4pu2orDJXiRmaMVxVO97eZC4LyTFaJz
 PRz31qagThSFNTF9XRs/TgeyFBpSyzDjLrAhB2Hzl0pG85CHUGGZGV1ExH6WSS2p46hsmHkfA
 eYyazT1IzF0sWbFnyrRJdbE4vBXMlXOnEDTAa/EuPfSjR9H3mEGUurBSOsAjOK5vfsgK0kOAF
 cIllYzjF424v2BhblwvMCgv7Zpg8mM0yns3TltORN9uTvMPrB9/+zqJZqHn/gvtHh8mWE9cMU
 SKofCfz9LO8dbgi6wMLcYdawPZ5GaeOWYDxqf9Te4dFimFthJVb+eJYjzzvnvyltS/L22NdvA
 8CdSlTgLMHh4EoaD/XKv6x4EVtMWkrt56yNT8z38PzPW6T8X19wPiO+9PIuWDfXvdOEZktV5b
 CvktAkKCbYxD1/RqIcEXPykcc27INrW3w+KR4xVdyO2a5QMZZ/mrHVw2grdNszy53cJUS7GBw
 0LZes/dZ2DTnNkjgAxDfoxdjvW2OwHHy2ch0fAr26aLZjd8FofaWTR86JcuTYRNL8/kmcrC4f
 e4mX+djKoHHExJEOwSKuU13A+diy36vICZnGewWwbxLrCbhlnpJa/IlS1HN/cANeTClHgTMKv
 zPjPDktNnN/QUWyC8CbNhNq9ggD8YRE0UBSQJDnBmqWuntRIY/EAF8Bvwsxqink5DAthf4ruX
 UsLmYMUwiuUGncTYZOPhuw893R1BW3fXHhPn8makUgiWmZpOOGfUZFk9c5yp14CJdP2vlDUc7
 ZS8PEOC1jDL4e4=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I digged a bit deeper I guess and narrowed it down. It happens from time
to time with s2idle too, but it ALWAYS happens the second time using the
deep mode. This is the dmesg after the first sleep, is there something wrong?

[  374.237846] PM: suspend entry (deep)
[  374.240141] Filesystems sync: 0.001 seconds
[  374.240544] PM: Preparing system for sleep (deep)
[  374.248625] Freezing user space processes ... (elapsed 0.002 seconds) done.
[  374.251394] OOM killer disabled.
[  374.251706] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[  374.253560] PM: Suspending system (deep)
[  374.305297] input input19: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: card0
[  374.306076] input input19: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.307862] input input18: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: card0
[  374.308621] input input18: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.310383] input input17: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: card0
[  374.311142] input input17: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.312922] input input16: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: card0
[  374.313679] input input16: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.315443] input input15: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: card0
[  374.316201] input input15: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.317964] input input14: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: card0
[  374.318725] input input14: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.320497] input input13: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: card0
[  374.321254] input input13: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.323540] sound pcmC0D10p: PM: calling do_pcm_suspend+0x0/0x30
[snd_pcm] @ 2952, parent: card0
[  374.324380] sound pcmC0D10p: PM: do_pcm_suspend+0x0/0x30 [snd_pcm]
returned 0 after 1 usecs
[  374.325705] sound pcmC0D9p: PM: calling do_pcm_suspend+0x0/0x30
[snd_pcm] @ 2952, parent: card0
[  374.326531] sound pcmC0D9p: PM: do_pcm_suspend+0x0/0x30 [snd_pcm]
returned 0 after 0 usecs
[  374.327835] sound pcmC0D8p: PM: calling do_pcm_suspend+0x0/0x30
[snd_pcm] @ 2952, parent: card0
[  374.328657] sound pcmC0D8p: PM: do_pcm_suspend+0x0/0x30 [snd_pcm]
returned 0 after 0 usecs
[  374.329962] sound pcmC0D7p: PM: calling do_pcm_suspend+0x0/0x30
[snd_pcm] @ 2952, parent: card0
[  374.330803] sound pcmC0D7p: PM: do_pcm_suspend+0x0/0x30 [snd_pcm]
returned 0 after 1 usecs
[  374.332102] sound pcmC0D3p: PM: calling do_pcm_suspend+0x0/0x30
[snd_pcm] @ 2952, parent: card0
[  374.332923] sound pcmC0D3p: PM: do_pcm_suspend+0x0/0x30 [snd_pcm]
returned 0 after 0 usecs
[  374.334223] sound pcmC0D0c: PM: calling do_pcm_suspend+0x0/0x30
[snd_pcm] @ 2952, parent: card0
[  374.335045] sound pcmC0D0c: PM: do_pcm_suspend+0x0/0x30 [snd_pcm]
returned 0 after 0 usecs
[  374.336352] sound pcmC0D0p: PM: calling do_pcm_suspend+0x0/0x30
[snd_pcm] @ 2952, parent: card0
[  374.337172] sound pcmC0D0p: PM: do_pcm_suspend+0x0/0x30 [snd_pcm]
returned 0 after 0 usecs
[  374.340564] snd-soc-dummy snd-soc-dummy: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  374.341486] snd-soc-dummy snd-soc-dummy: PM:
platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  374.343379] rfkill rfkill3: PM: calling rfkill_suspend+0x0/0x20 @
2952, parent: phy0
[  374.344110] rfkill rfkill3: PM: rfkill_suspend+0x0/0x20 returned 0
after 0 usecs
[  374.345325] ieee80211 phy0: PM: calling wiphy_suspend+0x0/0x240
[cfg80211] @ 2952, parent: 0000:00:14.3
[  374.346259] ieee80211 phy0: PM: wiphy_suspend+0x0/0x240 [cfg80211]
returned 0 after 2 usecs
[  374.347578] leds phy0-led: PM: calling led_suspend+0x0/0x50 @ 2952,
parent: 0000:00:14.3
[  374.348340] leds phy0-led: PM: led_suspend+0x0/0x50 returned 0 after
0 usecs
[  374.351100] snd_hda_intel 0000:00:1f.3: PM: calling
pci_pm_suspend+0x0/0x170 @ 2952, parent: pci0000:00
[  374.386807] snd_hda_intel 0000:00:1f.3: PM: pci_pm_suspend+0x0/0x170
returned 0 after 34008 usecs
[  374.389213] rfkill rfkill2: PM: calling rfkill_suspend+0x0/0x20 @
2952, parent: hci0
[  374.389945] rfkill rfkill2: PM: rfkill_suspend+0x0/0x20 returned 0
after 0 usecs
[  374.392720] coretemp coretemp.0: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  374.393561] coretemp coretemp.0: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  374.397455] input input12: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: LNXVIDEO:00
[  374.398253] input input12: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.403652] backlight intel_backlight: PM: calling
backlight_suspend+0x0/0x80 @ 2952, parent: card0-eDP-1
[  374.404547] backlight intel_backlight: PM: backlight_suspend+0x0/0x80
returned 0 after 0 usecs
[  374.412658] input input11: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: 1-7:1.0
[  374.413424] input input11: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.424659] input input10: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: 0018:04F3:30C9.0001
[  374.425519] input input10: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.427814] input input8: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: 0018:04F3:30C9.0001
[  374.428670] input input8: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.429878] leds input3::scrolllock: PM: calling led_suspend+0x0/0x50
@ 2952, parent: input3
[  374.430727] leds input3::scrolllock: PM: led_suspend+0x0/0x50
returned 0 after 0 usecs
[  374.431978] leds input3::capslock: PM: calling led_suspend+0x0/0x50 @
2952, parent: input3
[  374.432750] leds input3::capslock: PM: led_suspend+0x0/0x50 returned
0 after 0 usecs
[  374.434040] leds input3::numlock: PM: calling led_suspend+0x0/0x50 @
2952, parent: input3
[  374.434809] leds input3::numlock: PM: led_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.445963] rfkill rfkill1: PM: calling rfkill_suspend+0x0/0x20 @
2952, parent: VPC2004:00
[  374.446762] rfkill rfkill1: PM: rfkill_suspend+0x0/0x20 returned 0
after 0 usecs
[  374.447973] rfkill rfkill0: PM: calling rfkill_suspend+0x0/0x20 @
2952, parent: VPC2004:00
[  374.448745] rfkill rfkill0: PM: rfkill_suspend+0x0/0x20 returned 0
after 0 usecs
[  374.452062] platform regulatory.0: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  374.452919] platform regulatory.0: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  374.454274] leds platform::kbd_backlight: PM: calling
led_suspend+0x0/0x50 @ 2952, parent: VPC2004:00
[  374.455135] leds platform::kbd_backlight: PM: led_suspend+0x0/0x50
returned 0 after 0 usecs
[  374.456416] intel_rapl_msr intel_rapl_msr.0: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  374.457351] intel_rapl_msr intel_rapl_msr.0: PM:
platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  374.460314] input input7: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: VPC2004:00
[  374.461099] input input7: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.469631] usb 1-10: PM: calling usb_dev_suspend+0x0/0x20 @ 2952,
parent: usb1
[  374.470374] usb 1-10: PM: usb_dev_suspend+0x0/0x20 returned 0 after 0 usecs
[  374.485586] usb 1-8: PM: calling usb_dev_suspend+0x0/0x20 @ 2952,
parent: usb1
[  374.486322] usb 1-8: PM: usb_dev_suspend+0x0/0x20 returned 0 after 0 usecs
[  374.490100] usb 1-7: PM: calling usb_dev_suspend+0x0/0x20 @ 2952,
parent: usb1
[  374.490782] usb 1-7: PM: usb_dev_suspend+0x0/0x20 returned 0 after 0 usecs
[  374.498211] i2c_hid_acpi i2c-CUST0001:00: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: i2c-1
[  374.505549] i2c_hid_acpi i2c-CUST0001:00: PM:
acpi_subsys_suspend+0x0/0x60 returned 0 after 6295 usecs
[  374.508059] i2c_designware i2c_designware.0: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: 0000:00:15.0
[  374.509030] i2c_designware i2c_designware.0: PM:
platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  374.511515] idma64 idma64.0: PM: calling platform_pm_suspend+0x0/0x50
@ 2952, parent: 0000:00:15.0
[  374.512357] idma64 idma64.0: PM: platform_pm_suspend+0x0/0x50
returned 0 after 2 usecs
[  374.515222] platform iTCO_wdt: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: 0000:00:1f.4
[  374.516079] platform iTCO_wdt: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  374.523569] usb usb2: PM: calling usb_dev_suspend+0x0/0x20 @ 2952,
parent: 0000:00:14.0
[  374.850561] usb usb2: PM: usb_dev_suspend+0x0/0x20 returned 0 after
318585 usecs
[  374.859586] usb usb1: PM: calling usb_dev_suspend+0x0/0x20 @ 2952,
parent: 0000:00:14.0
[  374.860406] usb usb1: PM: usb_dev_suspend+0x0/0x20 returned 0 after
63 usecs
[  374.874449] platform microcode: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  374.875284] platform microcode: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  374.881679] platform eisa.0: PM: calling platform_pm_suspend+0x0/0x50
@ 2952, parent: platform
[  374.882489] platform eisa.0: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  374.884758] input input3: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: serio0
[  374.885510] input input3: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.887237] alarmtimer alarmtimer.0.auto: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: rtc0
[  374.888118] alarmtimer alarmtimer.0.auto: PM:
platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  374.889480] rtc rtc0: PM: calling rtc_suspend+0x0/0x190 @ 2952,
parent: 00:04
[  374.890156] rtc rtc0: PM: rtc_suspend+0x0/0x190 returned 0 after 0 usecs
[  374.894402] atkbd serio0: PM: calling serio_suspend+0x0/0x50 @ 2952,
parent: i8042
[  374.897473] atkbd serio0: PM: serio_suspend+0x0/0x50 returned 0 after
2302 usecs
[  374.898705] i8042 i8042: PM: calling platform_pm_suspend+0x0/0x50 @
2952, parent: platform
[  374.930446] i8042 i8042: PM: platform_pm_suspend+0x0/0x50 returned 0
after 30238 usecs
[  374.933765] platform Fixed MDIO bus.0: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  374.934654] platform Fixed MDIO bus.0: PM:
platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  374.949816] kgdboc kgdboc: PM: calling platform_pm_suspend+0x0/0x50 @
2952, parent: platform
[  374.950610] kgdboc kgdboc: PM: platform_pm_suspend+0x0/0x50 returned
0 after 0 usecs
[  374.968315] serial8250 serial8250: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  374.969175] serial8250 serial8250: PM: platform_pm_suspend+0x0/0x50
returned 0 after 1 usecs
[  374.979210] input input2: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: LNXPWRBN:00
[  374.980004] input input2: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.981230] input input1: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: PNP0C0C:00
[  374.982016] input input1: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  374.983217] input input0: PM: calling input_dev_suspend+0x0/0x50 @
2952, parent: PNP0C0D:00
[  374.984000] input input0: PM: input_dev_suspend+0x0/0x50 returned 0
after 0 usecs
[  375.003636] efi-framebuffer efi-framebuffer.0: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.004589] efi-framebuffer efi-framebuffer.0: PM:
platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  375.005984] platform pcspkr: PM: calling platform_pm_suspend+0x0/0x50
@ 2952, parent: platform
[  375.006791] platform pcspkr: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.050146] system 00:08: PM: calling pnp_bus_suspend+0x0/0x20 @
2952, parent: pnp0
[  375.050870] system 00:08: PM: pnp_bus_suspend+0x0/0x20 returned 0
after 0 usecs
[  375.052050] system 00:07: PM: calling pnp_bus_suspend+0x0/0x20 @
2952, parent: pnp0
[  375.052770] system 00:07: PM: pnp_bus_suspend+0x0/0x20 returned 0
after 0 usecs
[  375.053971] i8042 kbd 00:06: PM: calling pnp_bus_suspend+0x0/0x20 @
2952, parent: pnp0
[  375.054715] i8042 kbd 00:06: PM: pnp_bus_suspend+0x0/0x20 returned 0
after 0 usecs
[  375.055920] system 00:05: PM: calling pnp_bus_suspend+0x0/0x20 @
2952, parent: pnp0
[  375.056640] system 00:05: PM: pnp_bus_suspend+0x0/0x20 returned 0
after 0 usecs
[  375.057840] rtc_cmos 00:04: PM: calling pnp_bus_suspend+0x0/0x20 @
2952, parent: pnp0
[  375.058686] rtc_cmos 00:04: PM: pnp_bus_suspend+0x0/0x20 returned 0
after 106 usecs
[  375.059919] system 00:03: PM: calling pnp_bus_suspend+0x0/0x20 @
2952, parent: pnp0
[  375.060637] system 00:03: PM: pnp_bus_suspend+0x0/0x20 returned 0
after 0 usecs
[  375.061842] system 00:02: PM: calling pnp_bus_suspend+0x0/0x20 @
2952, parent: pnp0
[  375.062561] system 00:02: PM: pnp_bus_suspend+0x0/0x20 returned 0
after 0 usecs
[  375.063766] system 00:01: PM: calling pnp_bus_suspend+0x0/0x20 @
2952, parent: pnp0
[  375.064485] system 00:01: PM: pnp_bus_suspend+0x0/0x20 returned 0
after 0 usecs
[  375.065678] system 00:00: PM: calling pnp_bus_suspend+0x0/0x20 @
2952, parent: pnp0
[  375.066396] system 00:00: PM: pnp_bus_suspend+0x0/0x20 returned 0
after 0 usecs
[  375.069122] platform efivars.0: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.069953] platform efivars.0: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.071237] platform rtc-efi.0: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.072068] platform rtc-efi.0: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.074891] button LNXPWRBN:00: PM: calling
acpi_button_suspend+0x0/0x20 @ 2952, parent: LNXSYSTM:00
[  375.075745] button LNXPWRBN:00: PM: acpi_button_suspend+0x0/0x20
returned 0 after 0 usecs
[  375.082170] acpi-wmi PNP0C14:04: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: platform
[  375.083012] acpi-wmi PNP0C14:04: PM: acpi_subsys_suspend+0x0/0x60
returned 0 after 0 usecs
[  375.084300] acpi-fan PNP0C0B:04: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.085139] acpi-fan PNP0C0B:04: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.086429] acpi-fan PNP0C0B:03: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.087270] acpi-fan PNP0C0B:03: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.088556] acpi-fan PNP0C0B:02: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.089397] acpi-fan PNP0C0B:02: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.090686] acpi-fan PNP0C0B:01: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.091524] acpi-fan PNP0C0B:01: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.092804] acpi-fan PNP0C0B:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.093644] acpi-fan PNP0C0B:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.094938] ucsi_acpi USBC000:00: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: platform
[  375.095788] ucsi_acpi USBC000:00: PM: acpi_subsys_suspend+0x0/0x60
returned 0 after 0 usecs
[  375.097087] tpm_tis STM7308:00: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: platform
[  375.194026] tpm_tis STM7308:00: PM: acpi_subsys_suspend+0x0/0x60
returned 0 after 93848 usecs
[  375.195376] int3400 thermal INT3400:00: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: platform
[  375.196289] int3400 thermal INT3400:00: PM:
acpi_subsys_suspend+0x0/0x60 returned 0 after 0 usecs
[  375.197647] acpi-wmi PNP0C14:03: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: platform
[  375.198500] acpi-wmi PNP0C14:03: PM: acpi_subsys_suspend+0x0/0x60
returned 0 after 0 usecs
[  375.199809] intel_pmc_core INT33A1:00: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: platform
[  375.200704] intel_pmc_core INT33A1:00: PM:
acpi_subsys_suspend+0x0/0x60 returned 0 after 0 usecs
[  375.202056] acpi-wmi PNP0C14:02: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: platform
[  375.202910] acpi-wmi PNP0C14:02: PM: acpi_subsys_suspend+0x0/0x60
returned 0 after 0 usecs
[  375.204211] acpi-wmi PNP0C14:01: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: platform
[  375.205057] acpi-wmi PNP0C14:01: PM: acpi_subsys_suspend+0x0/0x60
returned 0 after 0 usecs
[  375.206360] platform ACPI000C:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.207225] platform ACPI000C:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.208534] platform PNP0C0C:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.209381] platform PNP0C0C:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.210686] platform INT0E0C:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.211533] platform INT0E0C:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.212835] acpi-wmi PNP0C14:00: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: platform
[  375.213681] acpi-wmi PNP0C14:00: PM: acpi_subsys_suspend+0x0/0x60
returned 0 after 0 usecs
[  375.214988] cannonlake-pinctrl INT34BB:00: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: pci0000:00
[  375.215931] cannonlake-pinctrl INT34BB:00: PM:
acpi_subsys_suspend+0x0/0x60 returned 0 after 0 usecs
[  375.217834] int3403 thermal INT3403:04: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: PNP0C09:00
[  375.218755] int3403 thermal INT3403:04: PM:
acpi_subsys_suspend+0x0/0x60 returned 0 after 0 usecs
[  375.220121] int3403 thermal INT3403:03: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: PNP0C09:00
[  375.221039] int3403 thermal INT3403:03: PM:
acpi_subsys_suspend+0x0/0x60 returned 0 after 0 usecs
[  375.222397] int3403 thermal INT3403:02: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: PNP0C09:00
[  375.223316] int3403 thermal INT3403:02: PM:
acpi_subsys_suspend+0x0/0x60 returned 0 after 0 usecs
[  375.224672] int3403 thermal INT3403:01: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: PNP0C09:00
[  375.225614] int3403 thermal INT3403:01: PM:
acpi_subsys_suspend+0x0/0x60 returned 0 after 0 usecs
[  375.226974] platform LIC0001:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: PNP0C09:00
[  375.227836] platform LIC0001:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.229138] ideapad_acpi VPC2004:00: PM: calling
acpi_subsys_suspend+0x0/0x60 @ 2952, parent: PNP0C09:00
[  375.230033] ideapad_acpi VPC2004:00: PM: acpi_subsys_suspend+0x0/0x60
returned 0 after 0 usecs
[  375.231389] platform PNP0C0D:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: PNP0C09:00
[  375.232250] platform PNP0C0D:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.233549] platform PNP0C0A:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: PNP0C09:00
[  375.234414] platform PNP0C0A:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.235748] platform ACPI0003:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: PNP0C09:00
[  375.236616] platform ACPI0003:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.237925] platform PNP0C09:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: 0000:00:1f.0
[  375.238801] platform PNP0C09:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.240100] platform PNP0103:00: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: 0000:00:1f.0
[  375.240998] platform PNP0103:00: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  375.242285] nvme 0000:01:00.0: PM: calling pci_pm_suspend+0x0/0x170 @
2952, parent: 0000:00:1d.0
[  375.502796] nvme 0000:01:00.0: PM: pci_pm_suspend+0x0/0x170 returned
0 after 253590 usecs
[  375.504632] pci 0000:00:1f.5: PM: calling pci_pm_suspend+0x0/0x170 @
2952, parent: pci0000:00
[  375.505439] pci 0000:00:1f.5: PM: pci_pm_suspend+0x0/0x170 returned 0
after 0 usecs
[  375.506707] i801_smbus 0000:00:1f.4: PM: calling
pci_pm_suspend+0x0/0x170 @ 2952, parent: pci0000:00
[  375.507623] i801_smbus 0000:00:1f.4: PM: pci_pm_suspend+0x0/0x170
returned 0 after 52 usecs
[  375.508955] pci 0000:00:1f.0: PM: calling pci_pm_suspend+0x0/0x170 @
2952, parent: pci0000:00
[  375.509760] pci 0000:00:1f.0: PM: pci_pm_suspend+0x0/0x170 returned 0
after 0 usecs
[  375.511013] pcieport 0000:00:1d.0: PM: calling
pci_pm_suspend+0x0/0x170 @ 2952, parent: pci0000:00
[  375.511870] pcieport 0000:00:1d.0: PM: pci_pm_suspend+0x0/0x170
returned 0 after 10 usecs
[  375.513166] mei_me 0000:00:16.0: PM: calling pci_pm_suspend+0x0/0x170
@ 2952, parent: pci0000:00
[  375.535773] mei_me 0000:00:16.0: PM: pci_pm_suspend+0x0/0x170
returned 0 after 21258 usecs
[  375.537093] intel-lpss 0000:00:15.0: PM: calling
pci_pm_suspend+0x0/0x170 @ 2952, parent: pci0000:00
[  375.537974] intel-lpss 0000:00:15.0: PM: pci_pm_suspend+0x0/0x170
returned 0 after 0 usecs
[  375.539285] iwlwifi 0000:00:14.3: PM: calling
pci_pm_suspend+0x0/0x170 @ 2952, parent: pci0000:00
[  375.540123] iwlwifi 0000:00:14.3: PM: pci_pm_suspend+0x0/0x170
returned 0 after 0 usecs
[  375.541399] pci 0000:00:14.2: PM: calling pci_pm_suspend+0x0/0x170 @
2952, parent: pci0000:00
[  375.542208] pci 0000:00:14.2: PM: pci_pm_suspend+0x0/0x170 returned 0
after 0 usecs
[  375.543462] xhci_hcd 0000:00:14.0: PM: calling
pci_pm_suspend+0x0/0x170 @ 2952, parent: pci0000:00
[  375.544616] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend+0x0/0x170
returned 0 after 301 usecs
[  375.545920] intel_pch_thermal 0000:00:12.0: PM: calling
pci_pm_suspend+0x0/0x170 @ 2952, parent: pci0000:00
[  375.546844] intel_pch_thermal 0000:00:12.0: PM:
pci_pm_suspend+0x0/0x170 returned 0 after 0 usecs
[  375.548200] proc_thermal 0000:00:04.0: PM: calling
pci_pm_suspend+0x0/0x170 @ 2952, parent: pci0000:00
[  375.549078] proc_thermal 0000:00:04.0: PM: pci_pm_suspend+0x0/0x170
returned 0 after 0 usecs
[  375.550397] i915 0000:00:02.0: PM: calling pci_pm_suspend+0x0/0x170 @
2952, parent: pci0000:00
[  375.825902] i915 0000:00:02.0: PM: pci_pm_suspend+0x0/0x170 returned
0 after 268246 usecs
[  375.827237] skl_uncore 0000:00:00.0: PM: calling
pci_pm_suspend+0x0/0x170 @ 2952, parent: pci0000:00
[  375.828110] skl_uncore 0000:00:00.0: PM: pci_pm_suspend+0x0/0x170
returned 0 after 0 usecs
[  375.832609] thermal LNXTHERM:01: PM: calling
acpi_thermal_suspend+0x0/0x20 @ 2952, parent: LNXSYBUS:01
[  375.833482] thermal LNXTHERM:01: PM: acpi_thermal_suspend+0x0/0x20
returned 0 after 0 usecs
[  375.839873] thermal LNXTHERM:00: PM: calling
acpi_thermal_suspend+0x0/0x20 @ 2952, parent: LNXSYBUS:01
[  375.840744] thermal LNXTHERM:00: PM: acpi_thermal_suspend+0x0/0x20
returned 0 after 0 usecs
[  375.857426] button PNP0C0C:00: PM: calling
acpi_button_suspend+0x0/0x20 @ 2952, parent: LNXSYBUS:00
[  375.858275] button PNP0C0C:00: PM: acpi_button_suspend+0x0/0x20
returned 0 after 0 usecs
[  375.939621] button PNP0C0D:00: PM: calling
acpi_button_suspend+0x0/0x20 @ 2952, parent: PNP0C09:00
[  375.940461] button PNP0C0D:00: PM: acpi_button_suspend+0x0/0x20
returned 0 after 0 usecs
[  375.943786] ec PNP0C09:00: PM: calling acpi_ec_suspend+0x0/0x80 @
2952, parent: device:19
[  375.944556] ec PNP0C09:00: PM: acpi_ec_suspend+0x0/0x80 returned 0
after 0 usecs
[  375.974468] regulator regulator.0: PM: calling
regulator_suspend+0x0/0xd0 @ 2952, parent: reg-dummy
[  375.975320] regulator regulator.0: PM: regulator_suspend+0x0/0xd0
returned 0 after 0 usecs
[  375.976598] reg-dummy reg-dummy: PM: calling
platform_pm_suspend+0x0/0x50 @ 2952, parent: platform
[  375.977443] reg-dummy reg-dummy: PM: platform_pm_suspend+0x0/0x50
returned 0 after 0 usecs
[  376.046298] PM: suspend of devices complete after 1751.757 msecs
[  376.046866] PM: start suspend of devices complete after 1792.852 msecs
[  376.075476] snd_hda_intel 0000:00:1f.3: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.076389] snd_hda_intel 0000:00:1f.3: PM:
pci_pm_suspend_late+0x0/0x40 returned 0 after 0 usecs
[  376.151283] i2c_hid_acpi i2c-CUST0001:00: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: i2c-1
[  376.152214] i2c_hid_acpi i2c-CUST0001:00: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.154619] i2c_designware i2c_designware.0: PM: calling
dw_i2c_plat_suspend+0x0/0x50 @ 2952, parent: 0000:00:15.0
[  376.155591] i2c_designware i2c_designware.0: PM:
dw_i2c_plat_suspend+0x0/0x50 returned 0 after 4 usecs
[  376.321883] acpi-wmi PNP0C14:04: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: platform
[  376.322766] acpi-wmi PNP0C14:04: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.326679] ucsi_acpi USBC000:00: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: platform
[  376.327569] ucsi_acpi USBC000:00: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.328903] tpm_tis STM7308:00: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: platform
[  376.329775] tpm_tis STM7308:00: PM: acpi_subsys_suspend_late+0x0/0x60
returned 0 after 0 usecs
[  376.331093] int3400 thermal INT3400:00: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: platform
[  376.332032] int3400 thermal INT3400:00: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.333418] acpi-wmi PNP0C14:03: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: platform
[  376.334300] acpi-wmi PNP0C14:03: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.335626] intel_pmc_core INT33A1:00: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: platform
[  376.336554] intel_pmc_core INT33A1:00: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.337929] acpi-wmi PNP0C14:02: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: platform
[  376.338811] acpi-wmi PNP0C14:02: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.340129] acpi-wmi PNP0C14:01: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: platform
[  376.341010] acpi-wmi PNP0C14:01: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.343894] acpi-wmi PNP0C14:00: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: platform
[  376.344775] acpi-wmi PNP0C14:00: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.346098] cannonlake-pinctrl INT34BB:00: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: pci0000:00
[  376.347076] cannonlake-pinctrl INT34BB:00: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.348997] int3403 thermal INT3403:04: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: PNP0C09:00
[  376.349948] int3403 thermal INT3403:04: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.351332] int3403 thermal INT3403:03: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: PNP0C09:00
[  376.352285] int3403 thermal INT3403:03: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.353672] int3403 thermal INT3403:02: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: PNP0C09:00
[  376.354624] int3403 thermal INT3403:02: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.356009] int3403 thermal INT3403:01: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: PNP0C09:00
[  376.356961] int3403 thermal INT3403:01: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.358855] ideapad_acpi VPC2004:00: PM: calling
acpi_subsys_suspend_late+0x0/0x60 @ 2952, parent: PNP0C09:00
[  376.359785] ideapad_acpi VPC2004:00: PM:
acpi_subsys_suspend_late+0x0/0x60 returned 0 after 0 usecs
[  376.363696] nvme 0000:01:00.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: 0000:00:1d.0
[  376.364552] nvme 0000:01:00.0: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.366380] pci 0000:00:1f.5: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.367211] pci 0000:00:1f.5: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.368474] i801_smbus 0000:00:1f.4: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.369363] i801_smbus 0000:00:1f.4: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.370684] pci 0000:00:1f.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.371514] pci 0000:00:1f.0: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.372766] pcieport 0000:00:1d.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.373637] pcieport 0000:00:1d.0: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.374940] mei_me 0000:00:16.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.375796] mei_me 0000:00:16.0: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.377084] intel-lpss 0000:00:15.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.378026] intel-lpss 0000:00:15.0: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 56 usecs
[  376.379347] iwlwifi 0000:00:14.3: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.380211] iwlwifi 0000:00:14.3: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.381513] pci 0000:00:14.2: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.382344] pci 0000:00:14.2: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.383612] xhci_hcd 0000:00:14.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.384486] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.385789] intel_pch_thermal 0000:00:12.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.386731] intel_pch_thermal 0000:00:12.0: PM:
pci_pm_suspend_late+0x0/0x40 returned 0 after 0 usecs
[  376.388099] proc_thermal 0000:00:04.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.388999] proc_thermal 0000:00:04.0: PM:
pci_pm_suspend_late+0x0/0x40 returned 0 after 0 usecs
[  376.390336] i915 0000:00:02.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.410110] i915 0000:00:02.0: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 18488 usecs
[  376.411363] skl_uncore 0000:00:00.0: PM: calling
pci_pm_suspend_late+0x0/0x40 @ 2952, parent: pci0000:00
[  376.412253] skl_uncore 0000:00:00.0: PM: pci_pm_suspend_late+0x0/0x40
returned 0 after 0 usecs
[  376.616137] PM: late suspend of devices complete after 568.644 msecs
[  376.644866] snd_hda_intel 0000:00:1f.3: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  376.662002] snd_hda_intel 0000:00:1f.3: PM:
pci_pm_suspend_noirq+0x0/0x2d0 returned 0 after 15825 usecs
[  376.736830] i2c_hid_acpi i2c-CUST0001:00: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: i2c-1
[  376.737768] i2c_hid_acpi i2c-CUST0001:00: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.905639] acpi-wmi PNP0C14:04: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: platform
[  376.906529] acpi-wmi PNP0C14:04: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.910452] ucsi_acpi USBC000:00: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: platform
[  376.911351] ucsi_acpi USBC000:00: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.912697] tpm_tis STM7308:00: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: platform
[  376.913578] tpm_tis STM7308:00: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.914897] int3400 thermal INT3400:00: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: platform
[  376.915843] int3400 thermal INT3400:00: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.917230] acpi-wmi PNP0C14:03: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: platform
[  376.918120] acpi-wmi PNP0C14:03: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.919444] intel_pmc_core INT33A1:00: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: platform
[  376.920379] intel_pmc_core INT33A1:00: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.921759] acpi-wmi PNP0C14:02: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: platform
[  376.922648] acpi-wmi PNP0C14:02: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.923974] acpi-wmi PNP0C14:01: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: platform
[  376.924861] acpi-wmi PNP0C14:01: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.927755] acpi-wmi PNP0C14:00: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: platform
[  376.928642] acpi-wmi PNP0C14:00: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.929975] cannonlake-pinctrl INT34BB:00: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: pci0000:00
[  376.936903] cannonlake-pinctrl INT34BB:00: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 5804 usecs
[  376.938849] int3403 thermal INT3403:04: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: PNP0C09:00
[  376.939810] int3403 thermal INT3403:04: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.941194] int3403 thermal INT3403:03: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: PNP0C09:00
[  376.942155] int3403 thermal INT3403:03: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.943542] int3403 thermal INT3403:02: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: PNP0C09:00
[  376.944500] int3403 thermal INT3403:02: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.945895] int3403 thermal INT3403:01: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: PNP0C09:00
[  376.946857] int3403 thermal INT3403:01: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.948766] ideapad_acpi VPC2004:00: PM: calling
acpi_subsys_suspend_noirq+0x0/0x50 @ 2952, parent: PNP0C09:00
[  376.949700] ideapad_acpi VPC2004:00: PM:
acpi_subsys_suspend_noirq+0x0/0x50 returned 0 after 0 usecs
[  376.953628] nvme 0000:01:00.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: 0000:00:1d.0
[  376.973998] nvme 0000:01:00.0: PM: pci_pm_suspend_noirq+0x0/0x2d0
returned 0 after 19039 usecs
[  376.975834] pci 0000:00:1f.5: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  376.976703] pci 0000:00:1f.5: PM: pci_pm_suspend_noirq+0x0/0x2d0
returned 0 after 21 usecs
[  376.977995] i801_smbus 0000:00:1f.4: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  376.978920] i801_smbus 0000:00:1f.4: PM:
pci_pm_suspend_noirq+0x0/0x2d0 returned 0 after 21 usecs
[  376.980261] pci 0000:00:1f.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  376.981153] pci 0000:00:1f.0: PM: pci_pm_suspend_noirq+0x0/0x2d0
returned 0 after 46 usecs
[  376.982438] pcieport 0000:00:1d.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.001949] pcieport 0000:00:1d.0: PM: pci_pm_suspend_noirq+0x0/0x2d0
returned 0 after 18185 usecs
[  377.003302] mei_me 0000:00:16.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.021953] mei_me 0000:00:16.0: PM: pci_pm_suspend_noirq+0x0/0x2d0
returned 0 after 17365 usecs
[  377.023255] intel-lpss 0000:00:15.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.042312] intel-lpss 0000:00:15.0: PM:
pci_pm_suspend_noirq+0x0/0x2d0 returned 0 after 17723 usecs
[  377.043695] iwlwifi 0000:00:14.3: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.066005] iwlwifi 0000:00:14.3: PM: pci_pm_suspend_noirq+0x0/0x2d0
returned 0 after 20921 usecs
[  377.067362] pci 0000:00:14.2: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.068240] pci 0000:00:14.2: PM: pci_pm_suspend_noirq+0x0/0x2d0
returned 0 after 23 usecs
[  377.069540] xhci_hcd 0000:00:14.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.270036] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend_noirq+0x0/0x2d0
returned 0 after 194917 usecs
[  377.271419] intel_pch_thermal 0000:00:12.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.289959] intel_pch_thermal 0000:00:12.0: PM:
pci_pm_suspend_noirq+0x0/0x2d0 returned 0 after 17161 usecs
[  377.291395] proc_thermal 0000:00:04.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.309950] proc_thermal 0000:00:04.0: PM:
pci_pm_suspend_noirq+0x0/0x2d0 returned 0 after 17216 usecs
[  377.311357] i915 0000:00:02.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.312218] i915 0000:00:02.0: PM: pci_pm_suspend_noirq+0x0/0x2d0
returned 0 after 0 usecs
[  377.313518] skl_uncore 0000:00:00.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2d0 @ 2952, parent: pci0000:00
[  377.314444] skl_uncore 0000:00:00.0: PM:
pci_pm_suspend_noirq+0x0/0x2d0 returned 0 after 12 usecs
[  377.424640] ec PNP0C09:00: PM: calling acpi_ec_suspend_noirq+0x0/0x90
@ 2952, parent: device:19
[  377.425456] ACPI: EC: interrupt blocked
[  377.425822] ec PNP0C09:00: PM: acpi_ec_suspend_noirq+0x0/0x90
returned 0 after 357 usecs
[  377.524575] PM: noirq suspend of devices complete after 907.633 msecs
[  377.525401] ACPI: Preparing to enter system sleep state S3
[  377.526519] ACPI: EC: event blocked
[  377.526857] ACPI: EC: EC stopped
[  377.527167] PM: Saving platform NVS memory
[  377.527564] Disabling non-boot CPUs ...
[  377.528382] IRQ 136: no longer affine to CPU1
[  377.529814] smpboot: CPU 1 is now offline
[  377.531091] IRQ 140: no longer affine to CPU2
[  377.532524] smpboot: CPU 2 is now offline
[  377.533722] IRQ 134: no longer affine to CPU3
[  377.535167] smpboot: CPU 3 is now offline
[  377.536356] IRQ 139: no longer affine to CPU4
[  377.537788] smpboot: CPU 4 is now offline
[  377.539141] IRQ 122: no longer affine to CPU5
[  377.539573] IRQ 135: no longer affine to CPU5
[  377.540998] smpboot: CPU 5 is now offline
[  377.542103] IRQ 137: no longer affine to CPU6
[  377.543538] smpboot: CPU 6 is now offline
[  377.544613] IRQ 123: no longer affine to CPU7
[  377.545044] IRQ 138: no longer affine to CPU7
[  377.546711] smpboot: CPU 7 is now offline
[  377.547552] PM: Checking wakeup interrupts
[  377.547955] PM: Calling kvm_suspend+0x0/0x30 [kvm]
[  377.548456] PM: Calling mce_syscore_suspend+0x0/0x20
[  377.548929] PM: Calling ledtrig_cpu_syscore_suspend+0x0/0x20
[  377.549465] PM: Calling timekeeping_suspend+0x0/0x2c0
[  377.549948] PM: Calling irq_gc_suspend+0x0/0x70
[  377.550382] PM: Calling save_ioapic_entries+0x0/0xd0
[  377.552587] PM: Calling i8259A_suspend+0x0/0x30
[  377.553036] PM: Calling fw_suspend+0x0/0x20
[  377.553437] PM: Calling acpi_save_bm_rld+0x0/0x20
[  377.553888] PM: Calling intel_epb_save+0x0/0x30
[  377.554322] PM: Calling lapic_suspend+0x0/0x20
[18446744066.766940] [Firmware Bug]: TSC ADJUST differs: CPU0 0 -->
-352355135. Restoring
[  377.555169] ACPI: Low-level resume complete
[  377.555621] ACPI: EC: EC started
[  377.555881] PM: Restoring platform NVS memory
[  377.556240] PM: Calling init_counter_refs+0x0/0x40
[  377.556655] PM: Calling lapic_resume+0x0/0x20
[  377.557036] PM: Calling intel_epb_restore+0x0/0x70
[  377.557451] PM: Calling acpi_restore_bm_rld+0x0/0x60
[  377.557909] PM: Calling irqrouter_resume+0x0/0x50
[  377.558341] PM: Calling i8259A_resume+0x0/0x30
[  377.558982] PM: Calling ioapic_resume+0x0/0xc0
[  377.559650] PM: Calling irq_gc_resume+0x0/0x70
[  377.560071] PM: Calling irq_pm_syscore_resume+0x0/0x20
[  377.560558] PM: Calling timekeeping_resume+0x0/0x160
[  377.561059] PM: Calling ledtrig_cpu_syscore_resume+0x0/0x20
[  377.561569] PM: Calling mce_syscore_resume+0x0/0x30
[  377.562030] PM: Calling mc_bp_resume+0x0/0x50
[  377.565269] PM: Calling kvm_resume+0x0/0x20 [kvm]
[  377.565855] Enabling non-boot CPUs ...
[  377.566253] x86: Booting SMP configuration:
[  377.566652] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  377.567907] CPU1 is up
[  377.568161] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  377.571543] CPU2 is up
[  377.571801] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  377.572958] CPU3 is up
[  377.573218] smpboot: Booting Node 0 Processor 4 APIC 0x1
[  377.574522] CPU4 is up
[  377.574778] smpboot: Booting Node 0 Processor 5 APIC 0x3
[  377.576003] CPU5 is up
[  377.576254] smpboot: Booting Node 0 Processor 6 APIC 0x5
[  377.577513] CPU6 is up
[  377.577765] smpboot: Booting Node 0 Processor 7 APIC 0x7
[  377.579015] CPU7 is up
[  377.582192] ACPI: Waking up from system sleep state S3
[  377.586395] ACPI: button: The lid device is not compliant to SW_LID.
[  377.684267] ec PNP0C09:00: PM: calling acpi_ec_resume_noirq+0x0/0x90
@ 2952, parent: device:19
[  377.685076] ACPI: EC: interrupt unblocked
[  377.685460] ec PNP0C09:00: PM: acpi_ec_resume_noirq+0x0/0x90 returned
0 after 374 usecs
[  377.794944] skl_uncore 0000:00:00.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.795853] skl_uncore 0000:00:00.0: PM:
pci_pm_resume_noirq+0x0/0x130 returned 0 after 11 usecs
[  377.797193] i915 0000:00:02.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.817140] i915 0000:00:02.0: PM: pci_pm_resume_noirq+0x0/0x130
returned 0 after 18654 usecs
[  377.818465] proc_thermal 0000:00:04.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.837125] proc_thermal 0000:00:04.0: PM:
pci_pm_resume_noirq+0x0/0x130 returned 0 after 17329 usecs
[  377.838514] intel_pch_thermal 0000:00:12.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.857138] intel_pch_thermal 0000:00:12.0: PM:
pci_pm_resume_noirq+0x0/0x130 returned 0 after 17254 usecs
[  377.858564] xhci_hcd 0000:00:14.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.859527] xhci_hcd 0000:00:14.0: PM: pci_pm_resume_noirq+0x0/0x130
returned 0 after 78 usecs
[  377.860858] pci 0000:00:14.2: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.861744] pci 0000:00:14.2: PM: pci_pm_resume_noirq+0x0/0x130
returned 0 after 36 usecs
[  377.863034] iwlwifi 0000:00:14.3: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.883678] iwlwifi 0000:00:14.3: PM: pci_pm_resume_noirq+0x0/0x130
returned 0 after 19305 usecs
[  377.885024] intel-lpss 0000:00:15.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.886193] intel-lpss 0000:00:15.0: PM:
pci_pm_resume_noirq+0x0/0x130 returned 0 after 259 usecs
[  377.887549] mei_me 0000:00:16.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.905148] mei_me 0000:00:16.0: PM: pci_pm_resume_noirq+0x0/0x130
returned 0 after 16339 usecs
[  377.906486] pcieport 0000:00:1d.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.925179] pcieport 0000:00:1d.0: PM: pci_pm_resume_noirq+0x0/0x130
returned 0 after 17391 usecs
[  377.926533] pci 0000:00:1f.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.927441] pci 0000:00:1f.0: PM: pci_pm_resume_noirq+0x0/0x130
returned 0 after 64 usecs
[  377.928730] i801_smbus 0000:00:1f.4: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.929666] i801_smbus 0000:00:1f.4: PM:
pci_pm_resume_noirq+0x0/0x130 returned 0 after 31 usecs
[  377.931011] pci 0000:00:1f.5: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  377.931882] pci 0000:00:1f.5: PM: pci_pm_resume_noirq+0x0/0x130
returned 0 after 27 usecs
[  377.933694] nvme 0000:01:00.0: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: 0000:00:1d.0
[  377.953175] nvme 0000:01:00.0: PM: pci_pm_resume_noirq+0x0/0x130
returned 0 after 18177 usecs
[  377.957109] ideapad_acpi VPC2004:00: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: PNP0C09:00
[  377.958054] ideapad_acpi VPC2004:00: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.959950] int3403 thermal INT3403:01: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: PNP0C09:00
[  377.960908] int3403 thermal INT3403:01: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.962310] int3403 thermal INT3403:02: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: PNP0C09:00
[  377.963269] int3403 thermal INT3403:02: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.964666] int3403 thermal INT3403:03: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: PNP0C09:00
[  377.965627] int3403 thermal INT3403:03: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.967032] int3403 thermal INT3403:04: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: PNP0C09:00
[  377.967990] int3403 thermal INT3403:04: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.969912] cannonlake-pinctrl INT34BB:00: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: pci0000:00
[  377.976832] cannonlake-pinctrl INT34BB:00: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 5798 usecs
[  377.978283] acpi-wmi PNP0C14:00: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: platform
[  377.979193] acpi-wmi PNP0C14:00: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.982103] acpi-wmi PNP0C14:01: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: platform
[  377.982989] acpi-wmi PNP0C14:01: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.984352] acpi-wmi PNP0C14:02: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: platform
[  377.985239] acpi-wmi PNP0C14:02: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.986578] intel_pmc_core INT33A1:00: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: platform
[  377.987510] intel_pmc_core INT33A1:00: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.988924] acpi-wmi PNP0C14:03: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: platform
[  377.989810] acpi-wmi PNP0C14:03: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.991149] int3400 thermal INT3400:00: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: platform
[  377.992089] int3400 thermal INT3400:00: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  377.993484] tpm_tis STM7308:00: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: platform
[  377.994384] tpm_tis STM7308:00: PM: acpi_subsys_resume_noirq+0x0/0x30
returned 0 after 0 usecs
[  377.995715] ucsi_acpi USBC000:00: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: platform
[  377.996606] ucsi_acpi USBC000:00: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  378.000588] acpi-wmi PNP0C14:04: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: platform
[  378.001470] acpi-wmi PNP0C14:04: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  378.123403] i8042 i8042: PM: calling i8042_pm_resume_noirq+0x0/0x30 @
2952, parent: platform
[  378.124198] i8042 i8042: PM: i8042_pm_resume_noirq+0x0/0x30 returned
0 after 0 usecs
[  378.167758] i2c_hid_acpi i2c-CUST0001:00: PM: calling
acpi_subsys_resume_noirq+0x0/0x30 @ 2952, parent: i2c-1
[  378.168686] i2c_hid_acpi i2c-CUST0001:00: PM:
acpi_subsys_resume_noirq+0x0/0x30 returned 0 after 0 usecs
[  378.240046] snd_hda_intel 0000:00:1f.3: PM: calling
pci_pm_resume_noirq+0x0/0x130 @ 2952, parent: pci0000:00
[  378.241068] snd_hda_intel 0000:00:1f.3: PM:
pci_pm_resume_noirq+0x0/0x130 returned 0 after 101 usecs
[  378.270031] PM: noirq resume of devices complete after 683.380 msecs
[  378.478075] skl_uncore 0000:00:00.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.478965] skl_uncore 0000:00:00.0: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.480281] i915 0000:00:02.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.482308] i915 0000:00:02.0: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 1157 usecs
[  378.483614] proc_thermal 0000:00:04.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.484513] proc_thermal 0000:00:04.0: PM:
pci_pm_resume_early+0x0/0x30 returned 0 after 0 usecs
[  378.485855] intel_pch_thermal 0000:00:12.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.486796] intel_pch_thermal 0000:00:12.0: PM:
pci_pm_resume_early+0x0/0x30 returned 0 after 0 usecs
[  378.488175] xhci_hcd 0000:00:14.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.489046] xhci_hcd 0000:00:14.0: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.490344] pci 0000:00:14.2: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.491174] pci 0000:00:14.2: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.492436] iwlwifi 0000:00:14.3: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.493299] iwlwifi 0000:00:14.3: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.494603] intel-lpss 0000:00:15.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.495494] intel-lpss 0000:00:15.0: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 1 usecs
[  378.496801] mei_me 0000:00:16.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.497657] mei_me 0000:00:16.0: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.498941] pcieport 0000:00:1d.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.499808] pcieport 0000:00:1d.0: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.501119] pci 0000:00:1f.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.501951] pci 0000:00:1f.0: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.503214] i801_smbus 0000:00:1f.4: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.504098] i801_smbus 0000:00:1f.4: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.505410] pci 0000:00:1f.5: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.506240] pci 0000:00:1f.5: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.508020] nvme 0000:01:00.0: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: 0000:00:1d.0
[  378.508874] nvme 0000:01:00.0: PM: pci_pm_resume_early+0x0/0x30
returned 0 after 0 usecs
[  378.512733] ideapad_acpi VPC2004:00: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: PNP0C09:00
[  378.513661] ideapad_acpi VPC2004:00: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.515529] int3403 thermal INT3403:01: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: PNP0C09:00
[  378.516479] int3403 thermal INT3403:01: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.517870] int3403 thermal INT3403:02: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: PNP0C09:00
[  378.518825] int3403 thermal INT3403:02: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.520216] int3403 thermal INT3403:03: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: PNP0C09:00
[  378.521170] int3403 thermal INT3403:03: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.522560] int3403 thermal INT3403:04: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: PNP0C09:00
[  378.523513] int3403 thermal INT3403:04: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.525421] cannonlake-pinctrl INT34BB:00: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: pci0000:00
[  378.526396] cannonlake-pinctrl INT34BB:00: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.527813] acpi-wmi PNP0C14:00: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: platform
[  378.528694] acpi-wmi PNP0C14:00: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.531562] acpi-wmi PNP0C14:01: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: platform
[  378.532443] acpi-wmi PNP0C14:01: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.533781] acpi-wmi PNP0C14:02: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: platform
[  378.534660] acpi-wmi PNP0C14:02: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.535997] intel_pmc_core INT33A1:00: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: platform
[  378.536926] intel_pmc_core INT33A1:00: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.538303] acpi-wmi PNP0C14:03: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: platform
[  378.539181] acpi-wmi PNP0C14:03: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.540512] int3400 thermal INT3400:00: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: platform
[  378.541448] int3400 thermal INT3400:00: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.542834] tpm_tis STM7308:00: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: platform
[  378.543707] tpm_tis STM7308:00: PM: acpi_subsys_resume_early+0x0/0x40
returned 0 after 0 usecs
[  378.545030] ucsi_acpi USBC000:00: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: platform
[  378.545920] ucsi_acpi USBC000:00: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.549820] acpi-wmi PNP0C14:04: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: platform
[  378.550704] acpi-wmi PNP0C14:04: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.713892] i2c_designware i2c_designware.0: PM: calling
dw_i2c_plat_resume+0x0/0x50 @ 2952, parent: 0000:00:15.0
[  378.714860] i2c_designware i2c_designware.0: PM:
dw_i2c_plat_resume+0x0/0x50 returned 0 after 7 usecs
[  378.717259] i2c_hid_acpi i2c-CUST0001:00: PM: calling
acpi_subsys_resume_early+0x0/0x40 @ 2952, parent: i2c-1
[  378.718187] i2c_hid_acpi i2c-CUST0001:00: PM:
acpi_subsys_resume_early+0x0/0x40 returned 0 after 0 usecs
[  378.789536] snd_hda_intel 0000:00:1f.3: PM: calling
pci_pm_resume_early+0x0/0x30 @ 2952, parent: pci0000:00
[  378.790450] snd_hda_intel 0000:00:1f.3: PM:
pci_pm_resume_early+0x0/0x30 returned 0 after 0 usecs
[  378.819322] PM: early resume of devices complete after 548.660 msecs
[  378.886782] reg-dummy reg-dummy: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  378.887614] reg-dummy reg-dummy: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  378.888886] regulator regulator.0: PM: calling
regulator_resume+0x0/0x160 @ 2952, parent: reg-dummy
[  378.889736] regulator regulator.0: PM: regulator_resume+0x0/0x160
returned 0 after 0 usecs
[  378.920020] ec PNP0C09:00: PM: calling acpi_ec_resume+0x0/0x20 @
2952, parent: device:19
[  378.920782] ACPI: EC: event unblocked
[  378.921150] ec PNP0C09:00: PM: acpi_ec_resume+0x0/0x20 returned 0
after 359 usecs
[  378.922370] ac ACPI0003:00: PM: calling acpi_ac_resume+0x0/0x80 @
2952, parent: PNP0C09:00
[  378.923595] ac ACPI0003:00: PM: acpi_ac_resume+0x0/0x80 returned 0
after 439 usecs
[  378.924821] battery PNP0C0A:00: PM: calling
acpi_battery_resume+0x0/0x40 @ 2952, parent: PNP0C09:00
[  378.926112] battery PNP0C0A:00: PM: acpi_battery_resume+0x0/0x40
returned 0 after 428 usecs
[  378.928472] button PNP0C0D:00: PM: calling
acpi_button_resume+0x0/0x110 @ 2952, parent: PNP0C09:00
[  378.930149] button PNP0C0D:00: PM: acpi_button_resume+0x0/0x110
returned 0 after 814 usecs
[  379.011779] button PNP0C0C:00: PM: calling
acpi_button_resume+0x0/0x110 @ 2952, parent: LNXSYBUS:00
[  379.012625] button PNP0C0C:00: PM: acpi_button_resume+0x0/0x110
returned 0 after 0 usecs
[  379.029331] thermal LNXTHERM:00: PM: calling
acpi_thermal_resume+0x0/0x170 @ 2952, parent: LNXSYBUS:01
[  379.030207] thermal LNXTHERM:00: PM: acpi_thermal_resume+0x0/0x170
returned 0 after 1 usecs
[  379.036652] thermal LNXTHERM:01: PM: calling
acpi_thermal_resume+0x0/0x170 @ 2952, parent: LNXSYBUS:01
[  379.037600] thermal LNXTHERM:01: PM: acpi_thermal_resume+0x0/0x170
returned 0 after 74 usecs
[  379.042014] skl_uncore 0000:00:00.0: PM: calling
pci_pm_resume+0x0/0xf0 @ 2952, parent: pci0000:00
[  379.042855] skl_uncore 0000:00:00.0: PM: pci_pm_resume+0x0/0xf0
returned 0 after 0 usecs
[  379.044113] i915 0000:00:02.0: PM: calling pci_pm_resume+0x0/0xf0 @
2952, parent: pci0000:00
[  379.048474] i915 0000:00:02.0: [drm] [ENCODER:94:DDI A/PHY A] is
disabled/in DSI mode with an ungated DDI clock, gate it
[  379.049827] i915 0000:00:02.0: [drm] [ENCODER:102:DDI B/PHY B] is
disabled/in DSI mode with an ungated DDI clock, gate it
[  379.051157] i915 0000:00:02.0: [drm] [ENCODER:111:DDI C/PHY C] is
disabled/in DSI mode with an ungated DDI clock, gate it
[  379.242428] i915 0000:00:02.0: PM: pci_pm_resume+0x0/0xf0 returned 0
after 192888 usecs
[  379.248482] proc_thermal 0000:00:04.0: PM: calling
pci_pm_resume+0x0/0xf0 @ 2952, parent: pci0000:00
[  379.252538] proc_thermal 0000:00:04.0: PM: pci_pm_resume+0x0/0xf0
returned 0 after 30 usecs
[  379.253864] intel_pch_thermal 0000:00:12.0: PM: calling
pci_pm_resume+0x0/0xf0 @ 2952, parent: pci0000:00
[  379.254768] intel_pch_thermal 0000:00:12.0: PM:
pci_pm_resume+0x0/0xf0 returned 0 after 1 usecs
[  379.256108] xhci_hcd 0000:00:14.0: PM: calling pci_pm_resume+0x0/0xf0
@ 2952, parent: pci0000:00
[  379.434060] xhci_hcd 0000:00:14.0: PM: pci_pm_resume+0x0/0xf0
returned 0 after 172966 usecs
[  379.435404] pci 0000:00:14.2: PM: calling pci_pm_resume+0x0/0xf0 @
2952, parent: pci0000:00
[  379.436202] pci 0000:00:14.2: PM: pci_pm_resume+0x0/0xf0 returned 0
after 0 usecs
[  379.437446] iwlwifi 0000:00:14.3: PM: calling pci_pm_resume+0x0/0xf0
@ 2952, parent: pci0000:00
[  379.438410] iwlwifi 0000:00:14.3: PM: pci_pm_resume+0x0/0xf0 returned
0 after 138 usecs
[  379.439686] intel-lpss 0000:00:15.0: PM: calling
pci_pm_resume+0x0/0xf0 @ 2952, parent: pci0000:00
[  379.440533] intel-lpss 0000:00:15.0: PM: pci_pm_resume+0x0/0xf0
returned 0 after 0 usecs
[  379.441822] mei_me 0000:00:16.0: PM: calling pci_pm_resume+0x0/0xf0 @
2952, parent: pci0000:00
[  379.445542] mei_me 0000:00:16.0: PM: pci_pm_resume+0x0/0xf0 returned
0 after 2836 usecs
[  379.446816] pcieport 0000:00:1d.0: PM: calling pci_pm_resume+0x0/0xf0
@ 2952, parent: pci0000:00
[  379.447695] pcieport 0000:00:1d.0: PM: pci_pm_resume+0x0/0xf0
returned 0 after 49 usecs
[  379.449123] pci 0000:00:1f.0: PM: calling pci_pm_resume+0x0/0xf0 @
2952, parent: pci0000:00
[  379.449909] pci 0000:00:1f.0: PM: pci_pm_resume+0x0/0xf0 returned 0
after 1 usecs
[  379.451120] i801_smbus 0000:00:1f.4: PM: calling
pci_pm_resume+0x0/0xf0 @ 2952, parent: pci0000:00
[  379.451989] i801_smbus 0000:00:1f.4: PM: pci_pm_resume+0x0/0xf0
returned 0 after 28 usecs
[  379.453288] pci 0000:00:1f.5: PM: calling pci_pm_resume+0x0/0xf0 @
2952, parent: pci0000:00
[  379.454091] pci 0000:00:1f.5: PM: pci_pm_resume+0x0/0xf0 returned 0
after 0 usecs
[  379.455983] nvme 0000:01:00.0: PM: calling pci_pm_resume+0x0/0xf0 @
2952, parent: 0000:00:1d.0
[  379.456806] nvme 0000:01:00.0: PM: pci_pm_resume+0x0/0xf0 returned 0
after 6 usecs
[  379.458179] platform PNP0103:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: 0000:00:1f.0
[  379.459052] platform PNP0103:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.460344] platform PNP0C09:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: 0000:00:1f.0
[  379.461225] platform PNP0C09:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.462521] platform ACPI0003:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: PNP0C09:00
[  379.463390] platform ACPI0003:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.464722] platform PNP0C0A:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: PNP0C09:00
[  379.465574] platform PNP0C0A:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.466917] platform PNP0C0D:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: PNP0C09:00
[  379.467771] platform PNP0C0D:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.469067] ideapad_acpi VPC2004:00: PM: calling
ideapad_acpi_resume+0x0/0x50 [ideapad_laptop] @ 2952, parent: PNP0C09:00
[  379.472472] ideapad_acpi VPC2004:00: PM: ideapad_acpi_resume+0x0/0x50
[ideapad_laptop] returned 0 after 2314 usecs
[  379.473991] platform LIC0001:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: PNP0C09:00
[  379.474845] platform LIC0001:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.479797] platform INT0E0C:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.480631] platform INT0E0C:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.481935] platform PNP0C0C:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.482768] platform PNP0C0C:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.484070] platform ACPI000C:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.484911] platform ACPI000C:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.488826] tpm_tis STM7308:00: PM: calling tpm_tis_resume+0x0/0x170
@ 2952, parent: platform
[  379.489629] tpm_tis STM7308:00: PM: tpm_tis_resume+0x0/0x170 returned
0 after 0 usecs
[  379.491418] acpi-fan PNP0C0B:00: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.492275] acpi-fan PNP0C0B:00: PM: platform_pm_resume+0x0/0x50
returned 0 after 25 usecs
[  379.493557] acpi-fan PNP0C0B:01: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.494406] acpi-fan PNP0C0B:01: PM: platform_pm_resume+0x0/0x50
returned 0 after 18 usecs
[  379.495699] acpi-fan PNP0C0B:02: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.496558] acpi-fan PNP0C0B:02: PM: platform_pm_resume+0x0/0x50
returned 0 after 14 usecs
[  379.497551] nvme nvme0: 8/0/0 default/read/poll queues
[  379.497957] acpi-fan PNP0C0B:03: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.499197] acpi-fan PNP0C0B:03: PM: platform_pm_resume+0x0/0x50
returned 0 after 15 usecs
[  379.500485] acpi-fan PNP0C0B:04: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.501377] acpi-fan PNP0C0B:04: PM: platform_pm_resume+0x0/0x50
returned 0 after 13 usecs
[  379.508393] button LNXPWRBN:00: PM: calling
acpi_button_resume+0x0/0x110 @ 2952, parent: LNXSYSTM:00
[  379.509283] button LNXPWRBN:00: PM: acpi_button_resume+0x0/0x110
returned 0 after 0 usecs
[  379.512116] platform rtc-efi.0: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.512937] platform rtc-efi.0: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.514251] platform efivars.0: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.515072] platform efivars.0: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.517938] system 00:00: PM: calling pnp_bus_resume+0x0/0xa0 @ 2952,
parent: pnp0
[  379.518651] system 00:00: PM: pnp_bus_resume+0x0/0xa0 returned 0
after 0 usecs
[  379.519840] system 00:01: PM: calling pnp_bus_resume+0x0/0xa0 @ 2952,
parent: pnp0
[  379.520549] system 00:01: PM: pnp_bus_resume+0x0/0xa0 returned 0
after 0 usecs
[  379.521783] system 00:02: PM: calling pnp_bus_resume+0x0/0xa0 @ 2952,
parent: pnp0
[  379.522490] system 00:02: PM: pnp_bus_resume+0x0/0xa0 returned 0
after 0 usecs
[  379.523673] system 00:03: PM: calling pnp_bus_resume+0x0/0xa0 @ 2952,
parent: pnp0
[  379.524382] system 00:03: PM: pnp_bus_resume+0x0/0xa0 returned 0
after 0 usecs
[  379.525623] rtc_cmos 00:04: PM: calling pnp_bus_resume+0x0/0xa0 @
2952, parent: pnp0
[  379.526349] rtc_cmos 00:04: PM: pnp_bus_resume+0x0/0xa0 returned 0
after 0 usecs
[  379.527562] system 00:05: PM: calling pnp_bus_resume+0x0/0xa0 @ 2952,
parent: pnp0
[  379.528271] system 00:05: PM: pnp_bus_resume+0x0/0xa0 returned 0
after 0 usecs
[  379.529503] i8042 kbd 00:06: PM: calling pnp_bus_resume+0x0/0xa0 @
2952, parent: pnp0
[  379.530236] i8042 kbd 00:06: PM: pnp_bus_resume+0x0/0xa0 returned 0
after 0 usecs
[  379.531458] system 00:07: PM: calling pnp_bus_resume+0x0/0xa0 @ 2952,
parent: pnp0
[  379.532166] system 00:07: PM: pnp_bus_resume+0x0/0xa0 returned 0
after 0 usecs
[  379.533383] system 00:08: PM: calling pnp_bus_resume+0x0/0xa0 @ 2952,
parent: pnp0
[  379.534094] system 00:08: PM: pnp_bus_resume+0x0/0xa0 returned 0
after 0 usecs
[  379.578330] platform pcspkr: PM: calling platform_pm_resume+0x0/0x50
@ 2952, parent: platform
[  379.579128] platform pcspkr: PM: platform_pm_resume+0x0/0x50 returned
0 after 0 usecs
[  379.580379] efi-framebuffer efi-framebuffer.0: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.581357] efi-framebuffer efi-framebuffer.0: PM:
platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
[  379.601605] input input0: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: PNP0C0D:00
[  379.602379] input input0: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  379.603593] input input1: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: PNP0C0C:00
[  379.604367] input input1: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  379.605582] input input2: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: LNXPWRBN:00
[  379.606364] input input2: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  379.616461] serial8250 serial8250: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.617343] serial8250 serial8250: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.635356] kgdboc kgdboc: PM: calling platform_pm_resume+0x0/0x50 @
2952, parent: platform
[  379.636137] kgdboc kgdboc: PM: platform_pm_resume+0x0/0x50 returned 0
after 0 usecs
[  379.651468] platform Fixed MDIO bus.0: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.652344] platform Fixed MDIO bus.0: PM:
platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
[  379.655736] i8042 i8042: PM: calling platform_pm_resume+0x0/0x50 @
2952, parent: platform
[  379.687396] i8042 i8042: PM: platform_pm_resume+0x0/0x50 returned 0
after 30170 usecs
[  379.688637] atkbd serio0: PM: calling serio_resume+0x0/0xa0 @ 2952,
parent: i8042
[  379.689400] atkbd serio0: PM: serio_resume+0x0/0xa0 returned 0 after
1 usecs
[  379.693710] rtc rtc0: PM: calling rtc_resume+0x0/0x70 @ 2952, parent: 00:04
[  379.694368] rtc rtc0: PM: rtc_resume+0x0/0x70 returned 0 after 0 usecs
[  379.695500] alarmtimer alarmtimer.0.auto: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: rtc0
[  379.696408] alarmtimer alarmtimer.0.auto: PM:
platform_pm_resume+0x0/0x50 returned 0 after 18 usecs
[  379.698396] input input3: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: serio0
[  379.699159] input input3: PM: input_dev_resume+0x0/0x50 returned 0
after 1 usecs
[  379.701598] platform eisa.0: PM: calling platform_pm_resume+0x0/0x50
@ 2952, parent: platform
[  379.702416] platform eisa.0: PM: platform_pm_resume+0x0/0x50 returned
0 after 0 usecs
[  379.705352] platform microcode: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  379.706176] platform microcode: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.720361] usb usb1: PM: calling usb_dev_resume+0x0/0x20 @ 2952,
parent: 0000:00:14.0
[  379.829665] usb usb1: PM: usb_dev_resume+0x0/0x20 returned 0 after
106009 usecs
[  379.838788] usb usb2: PM: calling usb_dev_resume+0x0/0x20 @ 2952,
parent: 0000:00:14.0
[  379.839603] usb usb2: PM: usb_dev_resume+0x0/0x20 returned 0 after 64 usecs
[  379.847068] platform iTCO_wdt: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: 0000:00:1f.4
[  379.847921] platform iTCO_wdt: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  379.850751] idma64 idma64.0: PM: calling platform_pm_resume+0x0/0x50
@ 2952, parent: 0000:00:15.0
[  379.851587] idma64 idma64.0: PM: platform_pm_resume+0x0/0x50 returned
0 after 0 usecs
[  379.853889] i2c_designware i2c_designware.0: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: 0000:00:15.0
[  379.854852] i2c_designware i2c_designware.0: PM:
platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
[  379.857285] i2c_hid_acpi i2c-CUST0001:00: PM: calling
i2c_hid_core_resume+0x0/0xd0 [i2c_hid] @ 2952, parent: i2c-1
[  379.928088] i2c_hid_acpi i2c-CUST0001:00: PM:
i2c_hid_core_resume+0x0/0xd0 [i2c_hid] returned 0 after 68179 usecs
[  379.935897] usb 1-7: PM: calling usb_dev_resume+0x0/0x20 @ 2952,
parent: usb1
[  380.082194] usb 1-7: reset high-speed USB device number 2 using xhci_hcd
[  380.240443] usb 1-7: PM: usb_dev_resume+0x0/0x20 returned 0 after
296727 usecs
[  380.244304] usb 1-8: PM: calling usb_dev_resume+0x0/0x20 @ 2952,
parent: usb1
[  380.390247] usb 1-8: reset high-speed USB device number 3 using xhci_hcd
[  380.543746] usb 1-8: PM: usb_dev_resume+0x0/0x20 returned 0 after
291752 usecs
[  380.555374] usb 1-10: PM: calling usb_dev_resume+0x0/0x20 @ 2952,
parent: usb1
[  380.670337] usb 1-10: PM: usb_dev_resume+0x0/0x20 returned 0 after
111600 usecs
[  380.678893] input input7: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: VPC2004:00
[  380.679675] input input7: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.682488] intel_rapl_msr intel_rapl_msr.0: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  380.683421] intel_rapl_msr intel_rapl_msr.0: PM:
platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
[  380.684808] leds platform::kbd_backlight: PM: calling
led_resume+0x0/0x50 @ 2952, parent: VPC2004:00
[  380.685670] leds platform::kbd_backlight: PM: led_resume+0x0/0x50
returned 0 after 0 usecs
[  380.686969] platform regulatory.0: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  380.687820] platform regulatory.0: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  380.691206] rfkill rfkill0: PM: calling rfkill_resume+0x0/0x80 @
2952, parent: VPC2004:00
[  380.691978] rfkill rfkill0: PM: rfkill_resume+0x0/0x80 returned 0
after 0 usecs
[  380.693192] rfkill rfkill1: PM: calling rfkill_resume+0x0/0x80 @
2952, parent: VPC2004:00
[  380.693963] rfkill rfkill1: PM: rfkill_resume+0x0/0x80 returned 0
after 0 usecs
[  380.698827] leds input3::numlock: PM: calling led_resume+0x0/0x50 @
2952, parent: input3
[  380.699591] leds input3::numlock: PM: led_resume+0x0/0x50 returned 0
after 0 usecs
[  380.700825] leds input3::capslock: PM: calling led_resume+0x0/0x50 @
2952, parent: input3
[  380.701598] leds input3::capslock: PM: led_resume+0x0/0x50 returned 0
after 0 usecs
[  380.702840] leds input3::scrolllock: PM: calling led_resume+0x0/0x50
@ 2952, parent: input3
[  380.703628] leds input3::scrolllock: PM: led_resume+0x0/0x50 returned
0 after 0 usecs
[  380.704906] input input8: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: 0018:04F3:30C9.0001
[  380.705759] input input8: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.708023] input input10: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: 0018:04F3:30C9.0001
[  380.708883] input input10: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.720006] input input11: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: 1-7:1.0
[  380.720764] input input11: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.728706] backlight intel_backlight: PM: calling
backlight_resume+0x0/0x80 @ 2952, parent: card0-eDP-1
[  380.729596] backlight intel_backlight: PM: backlight_resume+0x0/0x80
returned 0 after 0 usecs
[  380.734989] input input12: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: LNXVIDEO:00
[  380.735782] input input12: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.739591] coretemp coretemp.0: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  380.740420] coretemp coretemp.0: PM: platform_pm_resume+0x0/0x50
returned 0 after 0 usecs
[  380.743234] rfkill rfkill2: PM: calling rfkill_resume+0x0/0x80 @
2952, parent: hci0
[  380.743957] rfkill rfkill2: PM: rfkill_resume+0x0/0x80 returned 0
after 4 usecs
[  380.746194] snd_hda_intel 0000:00:1f.3: PM: calling
pci_pm_resume+0x0/0xf0 @ 2952, parent: pci0000:00
[  380.763872] snd_hda_intel 0000:00:1f.3: PM: pci_pm_resume+0x0/0xf0
returned 0 after 16417 usecs
[  380.766756] leds phy0-led: PM: calling led_resume+0x0/0x50 @ 2952,
parent: 0000:00:14.3
[  380.767509] leds phy0-led: PM: led_resume+0x0/0x50 returned 0 after 0 usecs
[  380.768671] ieee80211 phy0: PM: calling wiphy_resume+0x0/0x140
[cfg80211] @ 2952, parent: 0000:00:14.3
[  380.769588] ieee80211 phy0: PM: wiphy_resume+0x0/0x140 [cfg80211]
returned 0 after 4 usecs
[  380.770905] rfkill rfkill3: PM: calling rfkill_resume+0x0/0x80 @
2952, parent: phy0
[  380.771630] rfkill rfkill3: PM: rfkill_resume+0x0/0x80 returned 0
after 2 usecs
[  380.773358] snd-soc-dummy snd-soc-dummy: PM: calling
platform_pm_resume+0x0/0x50 @ 2952, parent: platform
[  380.774255] snd-soc-dummy snd-soc-dummy: PM:
platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
[  380.782320] input input13: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: card0
[  380.783065] input input13: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.784795] input input14: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: card0
[  380.785538] input input14: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.787264] input input15: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: card0
[  380.788006] input input15: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.789732] input input16: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: card0
[  380.790475] input input16: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.792216] input input17: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: card0
[  380.792961] input input17: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.794697] input input18: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: card0
[  380.795443] input input18: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.797170] input input19: PM: calling input_dev_resume+0x0/0x50 @
2952, parent: card0
[  380.797914] input input19: PM: input_dev_resume+0x0/0x50 returned 0
after 0 usecs
[  380.809209] PM: resume of devices complete after 1989.251 msecs
[  380.810140] acpi LNXPOWER:04: Turning OFF
[  380.810493] mei_hdcp
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0
(ops i915_hdcp_component_ops [i915])
[  380.810541] acpi LNXPOWER:00: Turning OFF
[  380.810617] PM: Finishing wakeup.
[  380.812499] OOM killer enabled.
[  380.812801] Restarting tasks ... done.
[  380.814783] PM: Possible incorrect RTC due to pm_trace, please use
'ntpdate' or 'rdate' to reset it.
[  380.816377] thermal thermal_zone9: failed to read out thermal zone (-61)
[  380.820570] rfkill: input handler enabled
[  380.843855] PM: suspend exit
[  381.048241] rfkill: input handler disabled
[  384.611699] wlp0s20f3: authenticate with e0:28:6d:83:ff:92
[  384.614525] wlp0s20f3: send auth to e0:28:6d:83:ff:92 (try 1/3)
[  384.769586] wlp0s20f3: authenticated
[  384.773349] wlp0s20f3: associate with e0:28:6d:83:ff:92 (try 1/3)
[  384.776747] wlp0s20f3: RX AssocResp from e0:28:6d:83:ff:92
(capab=0x1511 status=0 aid=3)
[  384.779705] wlp0s20f3: associated
[  384.825654] wlp0s20f3: Limiting TX power to 23 (23 - 0) dBm as
advertised by e0:28:6d:83:ff:92
[  384.857814] IPv6: ADDRCONF(NETDEV_CHANGE): wlp0s20f3: link becomes ready

