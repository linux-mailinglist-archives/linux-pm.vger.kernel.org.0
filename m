Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AB3263A1
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfEVMTB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 08:19:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55574 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfEVMTA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 08:19:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so1996039wmb.5
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=4lhpOXU5flLHaPgCnlKi/zbwwdvQGy7aO9emZ/m2IY8=;
        b=yIdCRbURcrDlI9SLR+Bvl5oxhZwOZqYKuBTNLSXNcHCWe0u9pHDx+OhZH6o3LcY+b+
         EkKg1GZKdYpfmLOLGaeFR9Gnl2TNLApOUF8mF7DAtnAkOaZSVmBPLCJdPbmwc5U38f6p
         IaylMs4wNHPvKSRP3wKlbWLeL1hed6rRspEw7Rrjp+Uo6Oi5YgM1hN+BZCdhP2M3nY9l
         LA9qmKEdmYxmu0YsJ9dOR44DgHcpltIyweDimJilw8Dahb70Boms5wtof80Lc1R6HTiZ
         0yDNVrGQM4w21BUwbkLZCV6oQb0ir+qEaAXrRCO2vQoOCLX8aVuCNoStXE6aWiHuWNVP
         +CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=4lhpOXU5flLHaPgCnlKi/zbwwdvQGy7aO9emZ/m2IY8=;
        b=NsloHYQjvcNuntPhkFT+HmvY2jFgglYmeC88myPIX/584FFincpcKyhtsJd4iC3M0/
         OZ55qzAjxQcGfDewsCbSWiaxB100+vHbmk8cNBSYWkSHF4PR/GsxC/N3CMzvxQkdbZmD
         VWbe6HN7CqoPIDEJ2BpZ4hKkOnN+DkxATwX6cAVHzPAGCrNbyKaMYitOZF4cnnYPaTvo
         bunVm8tAVSh60DNo//hxkp1yUdf47HlMIKF3mBwL/5lipHLhw0oAn5+PwpxVm1RRZ3a3
         ZNLsKk5QHzAvIkWYcvBYLfDnx/qj5JHgU8FuK3XTQecL/rQzs/iTSYf8iR0cEmUVGM6G
         vAQQ==
X-Gm-Message-State: APjAAAULkxTywipmJVrzzRpoAjbP7Znrp7DGJl0TwhZxpIJY1TZP7iXu
        F1vWVMbEcqZhe4RSv+qtYDN/wQ==
X-Google-Smtp-Source: APXvYqxhJBFQ6wD68xNh+ViCZQrptwFAKjQZvDM+tx4eVH7gccBPHLQDlUfDo0wxb0laDALKdQGVVQ==
X-Received: by 2002:a1c:9c42:: with SMTP id f63mr7712636wme.23.1558527537756;
        Wed, 22 May 2019 05:18:57 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 88sm58288086wrc.33.2019.05.22.05.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:18:56 -0700 (PDT)
Message-ID: <5ce53e30.1c69fb81.887a7.b77c@mx.google.com>
Date:   Wed, 22 May 2019 05:18:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: mainline
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: master
X-Kernelci-Kernel: v5.2-rc1-129-g9c7db5004280
Subject: mainline/master boot bisection: v5.2-rc1-129-g9c7db5004280 on
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

mainline/master boot bisection: v5.2-rc1-129-g9c7db5004280 on rk3288-veyron=
-jaq

Summary:
  Start:      9c7db5004280 Merge tag 'selinux-pr-20190521' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/pcmoore/selinux
  Details:    https://kernelci.org/boot/id/5ce4966759b5141df07a362c
  Plain log:  https://storage.kernelci.org//mainline/master/v5.2-rc1-129-g9=
c7db5004280/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-rk3288-veyron-j=
aq.txt
  HTML log:   https://storage.kernelci.org//mainline/master/v5.2-rc1-129-g9=
c7db5004280/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-rk3288-veyron-j=
aq.html
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
# good: [83f3ef3de625a5766de2382f9e077d4daafd5bac] Merge tag 'libnvdimm-fix=
es-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect good 83f3ef3de625a5766de2382f9e077d4daafd5bac
# bad: [9c7db5004280767566e91a33445bf93aa479ef02] Merge tag 'selinux-pr-201=
90521' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
git bisect bad 9c7db5004280767566e91a33445bf93aa479ef02
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
