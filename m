Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7582F2BC5C
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 01:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfE0XiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 19:38:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52859 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfE0XiU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 19:38:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so860183wmm.2
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2019 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=QG/8Rnb0DyTmqkfQVdHwtJUKymSeLn22v1j/v+Zfv10=;
        b=twU3B5G6hUNmvsA+GJSfLQGrc0Wmk8+6hcJHPXC2/O6LR5N6/ST8iHXYC2XCmg16Mh
         4Mahg3OcWbPTu7UROb9BNBXvjG6g24vTI/Qoa8CK75JNGilUKn1Pe7/SCuXi8JoIzarz
         b7rR6I0WKrUhhyPV5cKAwXHG02RySS0OHy0u4L5XCPRqiy9uYwjs3M8/cImJnnFdTRU7
         hxQt2vZKLrz9PuqI0mJ2A/u7Bz4Iy2AL+AWATpCQLbulvVxEmC3CJY1iEdPHpiqbUQJS
         VUItAzWCbZZXR+LVZZPZhjsammviuvqYyvPzVa9TMRxZepmQi1hEuK6wCbFLKDLl1ck7
         UqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=QG/8Rnb0DyTmqkfQVdHwtJUKymSeLn22v1j/v+Zfv10=;
        b=Cxi0iG8PH7dgzBfoFPLm6cmjFo5/N9hyeAwyw96PYcOQF4yFfG0uRJgX4nKZy9tqJT
         I7FJRdPtRO9yyCJFIdPPLHaiCl+fpuVWJxNKPUUW9YkiIHpploY3jO2uePXBM0qlfC02
         lbziwdU0MGm9zDKeqq1iI2HCHaKxulEArbMrN0uhUQCBehiLCDOAr0wUBT3xAJG/Yq+Z
         iDhYF/xnSiTd8U35qw+w/R/rgc+9so69bdVTXsk6NGLiwKSA9WLmf1sYFn0qEK56RSxQ
         Fj/66pctbqgKXVNKbhaWBNC78+q0wvfupOuXhewzCNPKfdVe3PtVCUYBsuX3PzUChG7r
         B80g==
X-Gm-Message-State: APjAAAXHk0aaFNa5WzC8c0fkGcmInlAyDhsQlh7w3tQQjXpPnzlKG+IM
        cJaGxphoN1v6jBtT10Ppm9iiuw==
X-Google-Smtp-Source: APXvYqycY7TK5ewYXCq0S0cSf/toi0bB8hH+l5xVHEOHdBN5VAaHmUqLJn/igiVGSV9taE8fpH7wUA==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr881424wma.120.1559000297169;
        Mon, 27 May 2019 16:38:17 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h6sm10604083wrm.47.2019.05.27.16.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 16:38:16 -0700 (PDT)
Message-ID: <5cec74e8.1c69fb81.37335.9d7b@mx.google.com>
Date:   Mon, 27 May 2019 16:38:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: linusw
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: for-next
X-Kernelci-Kernel: v5.2-rc1-8-g73a790c68d7e
Subject: linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on
 rk3288-veyron-jaq
To:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, broonie@kernel.org, matthew.hart@linaro.org,
        khilman@baylibre.com, enric.balletbo@collabora.com,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on rk3288-veyron-j=
aq

Summary:
  Start:      73a790c68d7e Merge branch 'devel' into for-next
  Details:    https://kernelci.org/boot/id/5cebf03d59b514dd627a3629
  Plain log:  https://storage.kernelci.org//linusw/for-next/v5.2-rc1-8-g73a=
790c68d7e/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-rk3288-veyron-jaq=
.txt
  HTML log:   https://storage.kernelci.org//linusw/for-next/v5.2-rc1-8-g73a=
790c68d7e/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-rk3288-veyron-jaq=
.html
  Result:     28694e009e51 thermal: rockchip: fix up the tsadc pinctrl sett=
ing error

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       linusw
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-=
gpio.git/
  Branch:     for-next
  Target:     rk3288-veyron-jaq
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     multi_v7_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 28694e009e512451ead5519dd801f9869acb1f60
Author: Elaine Zhang <zhangqing@rock-chips.com>
Date:   Tue Apr 30 18:09:44 2019 +0800

    thermal: rockchip: fix up the tsadc pinctrl setting error
    =

    Explicitly use the pinctrl to set/unset the right mode
    instead of relying on the pinctrl init mode.
    And it requires setting the tshut polarity before select pinctrl.
    =

    When the temperature sensor mode is set to 0, it will automatically
    reset the board via the Clock-Reset-Unit (CRU) if the over temperature
    threshold is reached. However, when the pinctrl initializes, it does a
    transition to "otp_out" which may lead the SoC restart all the time.
    =

    "otp_out" IO may be connected to the RESET circuit on the hardware.
    If the IO is in the wrong state, it will trigger RESET.
    (similar to the effect of pressing the RESET button)
    which will cause the soc to restart all the time.
    =

    Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
    Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
    Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_=
thermal.c
index 9c7643d62ed7..6dc7fc516abf 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -172,6 +172,9 @@ struct rockchip_thermal_data {
 	int tshut_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *gpio_state;
+	struct pinctrl_state *otp_state;
 };
 =

 /**
@@ -1242,6 +1245,8 @@ static int rockchip_thermal_probe(struct platform_dev=
ice *pdev)
 		return error;
 	}
 =

+	thermal->chip->control(thermal->regs, false);
+
 	error =3D clk_prepare_enable(thermal->clk);
 	if (error) {
 		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
@@ -1267,6 +1272,30 @@ static int rockchip_thermal_probe(struct platform_de=
vice *pdev)
 	thermal->chip->initialize(thermal->grf, thermal->regs,
 				  thermal->tshut_polarity);
 =

+	if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO) {
+		thermal->pinctrl =3D devm_pinctrl_get(&pdev->dev);
+		if (IS_ERR(thermal->pinctrl)) {
+			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
+			return PTR_ERR(thermal->pinctrl);
+		}
+
+		thermal->gpio_state =3D pinctrl_lookup_state(thermal->pinctrl,
+							   "gpio");
+		if (IS_ERR_OR_NULL(thermal->gpio_state)) {
+			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
+			return -EINVAL;
+		}
+
+		thermal->otp_state =3D pinctrl_lookup_state(thermal->pinctrl,
+							  "otpout");
+		if (IS_ERR_OR_NULL(thermal->otp_state)) {
+			dev_err(&pdev->dev, "failed to find thermal otpout state\n");
+			return -EINVAL;
+		}
+
+		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
+	}
+
 	for (i =3D 0; i < thermal->chip->chn_num; i++) {
 		error =3D rockchip_thermal_register_sensor(pdev, thermal,
 						&thermal->sensors[i],
@@ -1337,8 +1366,8 @@ static int __maybe_unused rockchip_thermal_suspend(st=
ruct device *dev)
 =

 	clk_disable(thermal->pclk);
 	clk_disable(thermal->clk);
-
-	pinctrl_pm_select_sleep_state(dev);
+	if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
+		pinctrl_select_state(thermal->pinctrl, thermal->gpio_state);
 =

 	return 0;
 }
@@ -1383,7 +1412,8 @@ static int __maybe_unused rockchip_thermal_resume(str=
uct device *dev)
 	for (i =3D 0; i < thermal->chip->chn_num; i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 =

-	pinctrl_pm_select_default_state(dev);
+	if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
+		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
 =

 	return 0;
 }
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [0fbee1df2078fa1f61e2da14f51ceb357c79ae69] gpio: Update documentati=
on
git bisect good 0fbee1df2078fa1f61e2da14f51ceb357c79ae69
# bad: [73a790c68d7e35d1f7092d2b7fbc758f49833bf4] Merge branch 'devel' into=
 for-next
git bisect bad 73a790c68d7e35d1f7092d2b7fbc758f49833bf4
# good: [b3a5e648f5917ea508ecab9a629028b186d38eae] Merge tag 'tty-5.2-rc1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good b3a5e648f5917ea508ecab9a629028b186d38eae
# good: [8e4ff713ce313dcabbb60e6ede1ffc193e67631f] Merge tag 'rtc-5.2' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect good 8e4ff713ce313dcabbb60e6ede1ffc193e67631f
# good: [5fd09ba68297c967f5ba6bea9c3b444d34f80ee5] Merge tag 'for-linus-5.2=
b-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect good 5fd09ba68297c967f5ba6bea9c3b444d34f80ee5
# bad: [e8a1d70117116c8d96c266f0b99e931717670eaf] Merge tag 'armsoc-dt' of =
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad e8a1d70117116c8d96c266f0b99e931717670eaf
# good: [b45da609a02460c6a34c395f03f891f1fb2a021a] Merge tag 'imx-bindings-=
5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into a=
rm/dt
git bisect good b45da609a02460c6a34c395f03f891f1fb2a021a
# bad: [22c58fd70ca48a29505922b1563826593b08cc00] Merge tag 'armsoc-soc' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad 22c58fd70ca48a29505922b1563826593b08cc00
# good: [cc7ce90153e74f8266eefee9fba466faa1a2d5df] Merge tag 'drm-next-2019=
-05-16' of git://anongit.freedesktop.org/drm/drm
git bisect good cc7ce90153e74f8266eefee9fba466faa1a2d5df
# good: [1895ef4ef229ec1873a78ce31fe50b38cfd2b58a] Merge tag 'ixp4xx-for-ar=
msoc' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik=
 into arm/soc
git bisect good 1895ef4ef229ec1873a78ce31fe50b38cfd2b58a
# good: [b4ab114cc6a1bbf8ca1d9a2339f2b5b43374029b] thermal: Introduce devm_=
thermal_of_cooling_device_register
git bisect good b4ab114cc6a1bbf8ca1d9a2339f2b5b43374029b
# good: [7a0c4c17089a8aff52f516f0f52002be52950aae] Merge branch 'fixes' int=
o arm/soc
git bisect good 7a0c4c17089a8aff52f516f0f52002be52950aae
# bad: [4b984e7bfb6d8e4209838a55af4ae5fbba878867] dt-bindings: rockchip-the=
rmal: Support the PX30 SoC compatible
git bisect bad 4b984e7bfb6d8e4209838a55af4ae5fbba878867
# good: [0fac9e2f1452ffb6f43926609a569372204262eb] thermal/drivers/cpu_cool=
ing: Add Software Package Data Exchange (SPDX)
git bisect good 0fac9e2f1452ffb6f43926609a569372204262eb
# good: [6ec8070b9d48294fbe865535c167a79527eaf357] thermal: Fix build error=
 of missing devm_ioremap_resource on UM
git bisect good 6ec8070b9d48294fbe865535c167a79527eaf357
# bad: [28694e009e512451ead5519dd801f9869acb1f60] thermal: rockchip: fix up=
 the tsadc pinctrl setting error
git bisect bad 28694e009e512451ead5519dd801f9869acb1f60
# good: [fcc6d4cadadcc977911c6bfcdd95d379f4082c74] thermal: broadcom: Remov=
e ACPI support
git bisect good fcc6d4cadadcc977911c6bfcdd95d379f4082c74
# first bad commit: [28694e009e512451ead5519dd801f9869acb1f60] thermal: roc=
kchip: fix up the tsadc pinctrl setting error
---------------------------------------------------------------------------=
----
