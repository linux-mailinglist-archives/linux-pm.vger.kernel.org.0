Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E42A2A0
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2019 05:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfEYDkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 May 2019 23:40:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50786 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfEYDkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 May 2019 23:40:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so11144293wme.0
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2019 20:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=Kzug+k4tEmO5qCMnG7izi+kuNCEKn4AMrAYdTZq5wbA=;
        b=M3tCswIi19Ky2WxBxNv3ls+b4wA+FQHPK1dariiCzrXwU0bXWNvO8qztzuzqVU/b4s
         3nmVsF3ASuIKqFRrbZMA3S7MkL99p3A22eUcccHK78s2ex8pnTJiLMcnDw6sav4UHC02
         iLsc/PaamRKtMuPwf8y9TYfEujxd7LaaE2IOxG6+oarIp4MUxJ0J0ZzlaiY5BzUnp0nz
         1wyM7mm8mMVEQ/WGPWvGLmvyoPrAfYqQ3gPDFoYCMiBEt/C7pmTejIWS9EP23e6SQwoz
         ixxas0zvojlf+YHB9hUXM6Ij9Y6R3jwaJVq0j9cd0HNyzHCfFKRmXIz7ufqwJQC87BV5
         TNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=Kzug+k4tEmO5qCMnG7izi+kuNCEKn4AMrAYdTZq5wbA=;
        b=h3xb/ICE6Mn8/hjJgE01uoxJEK4JcQ+BC2se9kjxP8t79YYkXU7/PqVo8bZZGuife9
         P0zGuQZEDJacfUz3mf/Gz5Ho3q8xpFSjfVjuxZfjeSVep2LiviGkPPdQsE2xJrJVIceu
         KoqWDU6JgnaNVMyYKlavc6HuyrjYkozZJcm9YuGcCbGuj28bp2IRlSbJxxx131ZacLKZ
         RF90GbQidv+8nR6AbfRlBNW3jN+BY0hhKV1xwI8fbBZO5BPSvI/bvJVeQvx44/gcQMeJ
         nVbVTtfhLk+Wr+5VIQYb1++dGhfkPYsmpol1zXaGIqeVLu0/DsKPXlzP2B0aqHxOtFwk
         Imog==
X-Gm-Message-State: APjAAAWaVL7J2KkQAyf49zy4pu2DZ8n1HiIL+RavOizmhqZh9FiLHZl5
        hHppxRloSLPExsQndMpCd1YdZw==
X-Google-Smtp-Source: APXvYqwFgY3oJJxa6vDIZjkAtvXePhiYXPmuXUt4XJEpFLjFTfPHU7t7sG1+fM0eQ6hxZWFpCBmu7w==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr2026446wmi.15.1558755597826;
        Fri, 24 May 2019 20:39:57 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f65sm5640544wmg.45.2019.05.24.20.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 20:39:57 -0700 (PDT)
Message-ID: <5ce8b90d.1c69fb81.a6b86.0471@mx.google.com>
Date:   Fri, 24 May 2019 20:39:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: linusw
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: v5.2-rc1-1-ge9646f0f5bb6
Subject: linusw/fixes boot bisection: v5.2-rc1-1-ge9646f0f5bb6 on
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

linusw/fixes boot bisection: v5.2-rc1-1-ge9646f0f5bb6 on rk3288-veyron-jaq

Summary:
  Start:      e9646f0f5bb6 gpio: fix gpio-adp5588 build errors
  Details:    https://kernelci.org/boot/id/5ce82d9f59b514bb857a3642
  Plain log:  https://storage.kernelci.org//linusw/fixes/v5.2-rc1-1-ge9646f=
0f5bb6/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-=
collabora/boot-rk3288-veyron-jaq.txt
  HTML log:   https://storage.kernelci.org//linusw/fixes/v5.2-rc1-1-ge9646f=
0f5bb6/arm/multi_v7_defconfig+CONFIG_EFI=3Dy+CONFIG_ARM_LPAE=3Dy/gcc-8/lab-=
collabora/boot-rk3288-veyron-jaq.html
  Result:     28694e009e51 thermal: rockchip: fix up the tsadc pinctrl sett=
ing error

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       linusw
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-=
gpio.git/
  Branch:     fixes
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
# good: [37624b58542fb9f2d9a70e6ea006ef8a5f66c30b] Linux 5.1-rc7
git bisect good 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b
# bad: [e9646f0f5bb62b7d43f0968f39d536cfe7123b53] gpio: fix gpio-adp5588 bu=
ild errors
git bisect bad e9646f0f5bb62b7d43f0968f39d536cfe7123b53
# good: [e7a1414f9dc3498c4c35b9ca266d539e8bccab53] Merge tag 'media/v5.1-2'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good e7a1414f9dc3498c4c35b9ca266d539e8bccab53
# good: [b970afcfcabd63cd3832e95db096439c177c3592] Merge tag 'powerpc-5.2-1=
' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good b970afcfcabd63cd3832e95db096439c177c3592
# bad: [a455eda33faafcaac1effb31d682765b14ef868c] Merge branch 'linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
git bisect bad a455eda33faafcaac1effb31d682765b14ef868c
# good: [7e9890a3500d95c01511a4c45b7e7192dfa47ae2] Merge tag 'ovl-update-5.=
2' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs
git bisect good 7e9890a3500d95c01511a4c45b7e7192dfa47ae2
# good: [cdc90a1871d6e64080f4506e900c6ef88e6fb39f] lib/bitmap.c: guard exot=
ic bitmap functions by CONFIG_NUMA
git bisect good cdc90a1871d6e64080f4506e900c6ef88e6fb39f
# good: [d2d8b146043ae7e250aef1fb312971f6f479d487] Merge tag 'trace-v5.2' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect good d2d8b146043ae7e250aef1fb312971f6f479d487
# good: [83f3ef3de625a5766de2382f9e077d4daafd5bac] Merge tag 'libnvdimm-fix=
es-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect good 83f3ef3de625a5766de2382f9e077d4daafd5bac
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
