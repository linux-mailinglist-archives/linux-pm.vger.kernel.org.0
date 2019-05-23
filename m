Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439F227452
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 04:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfEWCXM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 22:23:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43733 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfEWCXM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 22:23:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so4095235wrr.10
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 19:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=Hnjt/K9t57LlxXJzyl6rEPuBPixyxFUWutrkuh4rjao=;
        b=NrSed+fzL4RpCD8iPSFxux0YoMWBD5xiClJpTElPXsPOMJV0wLIzY1OKWA0+QVKYgN
         EQnwBtfcLzE6ggFS2KRh+QWtZYrfDOx7I/edfC1rfz2my86qCXV8rZU+OGKMrKa0+J24
         FijrlJNzoz6dIYKb9O5YgWusWhx/3xcGx3MA4Nr/Ct8zwi3vOI6q6vJRSTBvdKg3/c8W
         0xCbyC9YsJUiayUGYaxt/iK6hQPda3xZA8n5bb/Ja+sxPqQ6+iPG58Ypcy3sIXN6KV6S
         +0pHMt6321DPa/1c4ilxlhUCE+9SZFV0kuThs9ex1/Gv2M1uhrKJL0EqKaWZsRG4YxEc
         b6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=Hnjt/K9t57LlxXJzyl6rEPuBPixyxFUWutrkuh4rjao=;
        b=O636VfTMzVIc3E8bYgNwoKxnzAUrM0pehoj7KmFBAtxefvqwAqn/5gAjmzUVarkOYy
         G1oPabYqHuFm8hVNnAIELyQjiQkEqcW9R5ePfLl0iYtmprJRQYlhcf8bugPQTHvamsQC
         i5eCAy6fIdrR0SfB9m2N4HYVth7IXONOpXaW6cY3isj/6cRAa7Bv4NphBXRBUx0wWWlL
         YhtpFF4SECbgOsEAlPB2gpQYCSDpxeYtA8+moQwv9ynDmzPlzl99XLf10d4YJnHauDB/
         V/crl1IBYWgWoJEq8QO0a+a6q/gNmW2p9Omu9Uj8fx713jhC3sO+ZQqku5Omu369DaP7
         RKlQ==
X-Gm-Message-State: APjAAAX9hBYj4nNLYlceQmxbBs/O6tdFdN1cp1zaoswhMLef4NntbHGW
        LlMBx08jnp/86beQPnOXgiPckg==
X-Google-Smtp-Source: APXvYqz/QxREnLfKEm8J2aD73wASeFN0MHotPjc9HnDx/Tdd4uk9S2oBIQ4E+6qRfQN3d6BY6eD6Ng==
X-Received: by 2002:a5d:6a8c:: with SMTP id s12mr24929353wru.326.1558578190207;
        Wed, 22 May 2019 19:23:10 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id l16sm42303704wrb.40.2019.05.22.19.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:23:09 -0700 (PDT)
Message-ID: <5ce6040d.1c69fb81.60b3b.29fb@mx.google.com>
Date:   Wed, 22 May 2019 19:23:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: mainline
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: master
X-Kernelci-Kernel: v5.2-rc1-165-g54dee406374c
Subject: mainline/master boot bisection: v5.2-rc1-165-g54dee406374c on
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

mainline/master boot bisection: v5.2-rc1-165-g54dee406374c on rk3288-veyron=
-jaq

Summary:
  Start:      54dee406374c Merge tag 'arm64-fixes' of git://git.kernel.org/=
pub/scm/linux/kernel/git/arm64/linux
  Details:    https://kernelci.org/boot/id/5ce5984c59b514e6a47a364c
  Plain log:  https://storage.kernelci.org//mainline/master/v5.2-rc1-165-g5=
4dee406374c/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8=
/lab-collabora/boot-rk3288-veyron-jaq.txt
  HTML log:   https://storage.kernelci.org//mainline/master/v5.2-rc1-165-g5=
4dee406374c/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8=
/lab-collabora/boot-rk3288-veyron-jaq.html
  Result:     28694e009e51 thermal: rockchip: fix up the tsadc pinctrl sett=
ing error

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       mainline
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git
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
# good: [83f3ef3de625a5766de2382f9e077d4daafd5bac] Merge tag 'libnvdimm-fix=
es-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect good 83f3ef3de625a5766de2382f9e077d4daafd5bac
# bad: [54dee406374ce8adb352c48e175176247cb8db7c] Merge tag 'arm64-fixes' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 54dee406374ce8adb352c48e175176247cb8db7c
# bad: [dc413a90edbe715bebebe859dc072ef73d490d70] Merge tag 'armsoc-drivers=
' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad dc413a90edbe715bebebe859dc072ef73d490d70
# good: [b45da609a02460c6a34c395f03f891f1fb2a021a] Merge tag 'imx-bindings-=
5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into a=
rm/dt
git bisect good b45da609a02460c6a34c395f03f891f1fb2a021a
# good: [6cbc4d88ad208d6f5b9567bac2fff038e1bbfa77] Merge tag 'bitmain-soc-5=
.2' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/linux-bitmain int=
o arm/dt
git bisect good 6cbc4d88ad208d6f5b9567bac2fff038e1bbfa77
# bad: [a455eda33faafcaac1effb31d682765b14ef868c] Merge branch 'linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
git bisect bad a455eda33faafcaac1effb31d682765b14ef868c
# bad: [ffd1b122d3a17783b68cfd03b0479dffedf0d960] thermal: rockchip: Suppor=
t the PX30 SoC in thermal driver
git bisect bad ffd1b122d3a17783b68cfd03b0479dffedf0d960
# good: [3e6a8fb3308419129c7a52de6eb42feef5a919a0] drivers: thermal: tsens:=
 Add new operation to check if a sensor is enabled
git bisect good 3e6a8fb3308419129c7a52de6eb42feef5a919a0
# good: [d36e2fa025387567710df740fd4dce1d5001b226] thermal: generic-adc: ma=
ke lookup table optional
git bisect good d36e2fa025387567710df740fd4dce1d5001b226
# good: [42cd9b049829d7facbd45ab503d763a86251e81b] thermal/drivers/cpu_cool=
ing: Fixup the header and copyright
git bisect good 42cd9b049829d7facbd45ab503d763a86251e81b
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
