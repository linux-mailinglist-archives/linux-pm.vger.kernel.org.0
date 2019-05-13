Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C2F1BD00
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfEMSKs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 14:10:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42445 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfEMSKs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 14:10:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so16328259wrb.9
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=LT5io5p8n1/c/LCwvTPkjtb4+X35+Q1HlvC4Y/qob20=;
        b=1NkacZszdx7ZwkSEa92RAnOAhALFbWsnF8mGgjeRpGOGnd39E3wE0Uxrr7C7pFmGfO
         qy3BKP5DqvHjy3c0zgYEci1RLKe+joxoNV7OnGQLeym8xfIegVO0rmjXKgw4ipqn6d48
         nnxOSI2IUwRPKYcJF5hBm6ANGBw3rTT+qG3jSR77+DAcg9et7O1scFUWIyCN2FCroe1d
         tdCEwt9K1DQ9eY+Pgl9zccGbGGsVryRhhMP3Y3S/3R2StWP9RrpsxeXdpOz6HQ9rw9XO
         XMUvU/ALsresEEJimUNQchRpxoWaik2f3FoiL0PRQpWSHxoJ64boSNDHXIpqnpj8rDU7
         Sslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=LT5io5p8n1/c/LCwvTPkjtb4+X35+Q1HlvC4Y/qob20=;
        b=csASV6BJykh3nWefx9h/Ic98WlSPkqOMqOj2mSNSxKwm+9sQGIX4YnzsqLMsBiZnCn
         o9SKp4J4Y61Xmw1pku+JmYY+JRMDuEG5zHyyArkaR2XyXhLTAE5+FnVv1K4ApRaco59N
         2zg6HrUHkyayd3dZnAHaLatsv9UiburxwDg+lTMYaxx4mjkG1p50QDobKVivMB81V8ou
         BaYMKh7r+PYgXg5Vw9gPmUDHUu27cY5xL8nBypMe0ytWkA+rkGfLfpFd8eRIT83gsDxR
         PQsTBw1D2V3HsfdGRah7/KxjmUnYy78wZldbeJWVK/yA+tJPyv9PgQsO6C+iUp9jnKYv
         TwBw==
X-Gm-Message-State: APjAAAXxHRVGROYgpG5NCXDaMre9ejFJGhqji2QzlEr+UmgvS41MHwiq
        /LiQuQ/kG0XcS9roEgZrZm+a6Q==
X-Google-Smtp-Source: APXvYqxxm7UUUHmTN1WVVjjYddXPsjbsEeWpAKSwqu+sK0m85FdbEzeZYJoyE3a5PgZSyXdMxqyKrg==
X-Received: by 2002:adf:e311:: with SMTP id b17mr9530689wrj.11.1557771045698;
        Mon, 13 May 2019 11:10:45 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s2sm205534wmc.7.2019.05.13.11.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:10:44 -0700 (PDT)
Message-ID: <5cd9b324.1c69fb81.b5d3f.1434@mx.google.com>
Date:   Mon, 13 May 2019 11:10:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: next
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: master
X-Kernelci-Kernel: next-20190513
Subject: next/master boot bisection: next-20190513 on rk3288-veyron-jaq
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

next/master boot bisection: next-20190513 on rk3288-veyron-jaq

Summary:
  Start:      04c4b6775d34 Add linux-next specific files for 20190513
  Details:    https://kernelci.org/boot/id/5cd91b7859b514af767a3628
  Plain log:  https://storage.kernelci.org//next/master/next-20190513/arm/m=
ulti_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-collabora/bo=
ot-rk3288-veyron-jaq.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20190513/arm/m=
ulti_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-collabora/bo=
ot-rk3288-veyron-jaq.html
  Result:     691d4947face thermal: rockchip: fix up the tsadc pinctrl sett=
ing error

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  Branch:     master
  Target:     rk3288-veyron-jaq
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 691d4947faceb8bd841900049e07c81c95ca4b0d
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
# good: [d7a02fa0a8f9ec1b81d57628ca9834563208ef33] Merge tag 'upstream-5.2-=
rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
git bisect good d7a02fa0a8f9ec1b81d57628ca9834563208ef33
# bad: [04c4b6775d34f12f196e056debed9e8718585342] Add linux-next specific f=
iles for 20190513
git bisect bad 04c4b6775d34f12f196e056debed9e8718585342
# good: [c5d6b0b49382b9a81ac76e680af9d0d8943640e7] Merge remote-tracking br=
anch 'pci/next'
git bisect good c5d6b0b49382b9a81ac76e680af9d0d8943640e7
# bad: [a8f3999da21582f933c597a5489e415b51195322] Merge remote-tracking bra=
nch 'watchdog/master'
git bisect bad a8f3999da21582f933c597a5489e415b51195322
# bad: [8018a14af78918f9cc3ec419b87c8e3fa3f3a9ca] Merge remote-tracking bra=
nch 'input/next'
git bisect bad 8018a14af78918f9cc3ec419b87c8e3fa3f3a9ca
# good: [f1bc5d2316d1b88675dcf799d88cb973f6508bee] Merge remote-tracking br=
anch 'cpupower/cpupower'
git bisect good f1bc5d2316d1b88675dcf799d88cb973f6508bee
# bad: [a7257dd808e08b65ac8c3bee267c8a9d2e26e2b9] Merge remote-tracking bra=
nch 'drm/drm-next'
git bisect bad a7257dd808e08b65ac8c3bee267c8a9d2e26e2b9
# bad: [be827ffd38ea1de8f61b1fce0b25801321a20b2e] thermal: rcar_gen3_therma=
l: Fix to show correct trip points number
git bisect bad be827ffd38ea1de8f61b1fce0b25801321a20b2e
# good: [901c7225ca1170e5bcaca48cbbc580b18f754c0c] drivers: thermal: tsens:=
 Introduce IP-specific max_sensor count
git bisect good 901c7225ca1170e5bcaca48cbbc580b18f754c0c
# good: [4e211e068ae955811ecfd1584275c704251637fe] thermal: Introduce devm_=
thermal_of_cooling_device_register
git bisect good 4e211e068ae955811ecfd1584275c704251637fe
# good: [01dfda3fcc01c8f9989915742fc43ff137c58970] thermal: Fix build error=
 of missing devm_ioremap_resource on UM
git bisect good 01dfda3fcc01c8f9989915742fc43ff137c58970
# bad: [fb27a6c55da7475509589a5fc4799c058679c5a7] dt-bindings: rockchip-the=
rmal: Support the PX30 SoC compatible
git bisect bad fb27a6c55da7475509589a5fc4799c058679c5a7
# bad: [691d4947faceb8bd841900049e07c81c95ca4b0d] thermal: rockchip: fix up=
 the tsadc pinctrl setting error
git bisect bad 691d4947faceb8bd841900049e07c81c95ca4b0d
# good: [f88f39be23c6cd65674e6d39ae268c7341960d96] thermal: broadcom: Remov=
e ACPI support
git bisect good f88f39be23c6cd65674e6d39ae268c7341960d96
# first bad commit: [691d4947faceb8bd841900049e07c81c95ca4b0d] thermal: roc=
kchip: fix up the tsadc pinctrl setting error
---------------------------------------------------------------------------=
----
