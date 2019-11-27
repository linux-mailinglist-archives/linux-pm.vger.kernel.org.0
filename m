Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3310B6FA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 20:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfK0Tou (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 14:44:50 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38886 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0Tou (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 14:44:50 -0500
Received: by mail-io1-f65.google.com with SMTP id u24so24478919iob.5;
        Wed, 27 Nov 2019 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkBh9nZ4d1Mjj7D298qnbqHDDohOhtH9Rt6HWk+4d2k=;
        b=enZ5Rj6U22Yrwy6nCsHHAVUtmWP2EhQStJL8ungoozR2CsEPcLMiwvAkfoBNbg//M0
         mbG/S0zeNVmsWfQBJLz99X5LvVLrkY+ao4Klf/Y3mQn5Ik/Aj/IFoyXAamSxYR+FIKe/
         0Zl9VCDuoRSEqdGTV9A67DgYR7ltQ9rRPkQ11lg0+UDodVuRi8vH4NxNxnpTxIN0fm2B
         sok/dkOsRHBtamcEf9oYXqeTvz227dkonyTexdOGBjulPKjp0uq1kGcwukcUa0mgtxTZ
         GrOLRiKb39w0dqjUdO/0jPcwSYn1Gy0XAYdKgjVNl/zeVaVhvwBIk6llsOC9pVpw9SiD
         77qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkBh9nZ4d1Mjj7D298qnbqHDDohOhtH9Rt6HWk+4d2k=;
        b=L1qubfGCNXFv7SDTtREXCskzENip/ZUu0M7NHeZIJxsJwF8cCYhKXFLjVaWpTfUdSW
         y6N1U5nINZVyxQc619yIqCgu2ARqZQ2molIIYFb//6yDJGcEG7bZUlKXopdGyV4SiFeP
         OGptoLOY2gXYFxiks6prbDg6vaOx294oEfn70OmQbMd/rPa+YoFlHCtZg8Ljz9FaM8V2
         QP9g433ER1cFG+dFkahK1OU6+raa5vLwYutIF5JZn6Cmu3KdAdazLJ7c/69XpVNM2Wvq
         y9WTTL40GH3FfCdaawDI1NNbbxn2ZjceVUpjgCG1BVitBdUXpb0P13bus9DDuhuH+LX2
         QRfQ==
X-Gm-Message-State: APjAAAX67gXcc9kDp3MqIcCOH9tn87BTKXhYF8ATEdqelgDy5kHr1YaL
        OOuPjFywHgubLG2fr9rv3h8wnT2Fj91Y12JoqlY=
X-Google-Smtp-Source: APXvYqyyxziPAelILyTg664cHIWmPn+fz/UNPf2PsuJoQe1urUaJkiSTDxDeRsNDpEcQnqWvRh0cBA4L6uJWoDd2Ywo=
X-Received: by 2002:a02:3f60:: with SMTP id c32mr6155122jaf.30.1574883889954;
 Wed, 27 Nov 2019 11:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20191127052935.1719897-1-anarsoul@gmail.com> <20191127052935.1719897-2-anarsoul@gmail.com>
 <20191127111419.z5hfu5soxceiivg6@core.my.home> <20191127173547.ch3pcv3lxgdcrfnu@gilmour.lan>
In-Reply-To: <20191127173547.ch3pcv3lxgdcrfnu@gilmour.lan>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 28 Nov 2019 03:44:38 +0800
Message-ID: <CAEExFWvG-Af4qtUrxQV4ssNQCVQAmpXfxB+92wX+6ZxUNfX-Jw@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Vasily,

Thank you very much for your work on this.
This looks good to me.

By the way, I would like to ask comments about adding the following code.


diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index c0ed60782b11..579dde5e0701 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -629,11 +629,63 @@ static const struct of_device_id of_ths_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);

+static int __maybe_unused sun8i_thermal_suspend(struct device *dev)
+{
+ struct ths_device *tmdev; = dev_get_drvdata(dev);
+
+ clk_disable(tmdev->mod_clk);
+ clk_disable(tmdev->bus_clk);
+
+ reset_control_assert(tmdev->reset);
+
+ return 0;
+}
+
+static int __maybe_unused sun8i_thermal_resume(struct device *dev)
+{
+ struct ths_device *tmdev; = dev_get_drvdata(dev);
+ int error;
+
+ error = reset_control_deassert(tmdev->reset);
+ if (error)
+ return error;
+
+ error = clk_enable(tmdev->bus_clk);
+ if (error)
+ goto assert_reset;
+
+ clk_set_rate(tmdev->mod_clk, 24000000);
+ error = clk_enable(tmdev->mod_clk);
+ if (error)
+ goto bus_disable;
+
+ sun8i_ths_calibrate(tmdev);
+
+ ret = tmdev->chip->init(tmdev);
+ if (ret)
+ goto mod_disable;
+
+ return 0;
+
+mod_disable:
+ clk_disable(tmdev->mod_clk);
+bus_disable:
+ clk_disable(tmdev->bus_clk);
+assert_reset:
+ reset_control_assert(tmdev->reset);
+
+ return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(sun8i_thermal_pm_ops,
+ sun8i_thermal_suspend, sun8i_thermal_resume);
+
 static struct platform_driver ths_driver = {
  .probe = sun8i_ths_probe,
  .remove = sun8i_ths_remove,
  .driver = {
  .name = "sun8i-thermal",
+ .pm = &sun8i_thermal_pm_ops,
  .of_match_table = of_ths_match,
  },
 };

Yangtao
