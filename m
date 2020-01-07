Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8E132E26
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 19:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgAGSQU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 13:16:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:53047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgAGSQU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 13:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578420966;
        bh=ywvSvkZtxIFgQK2uzodzJ55BZghcFbFAXSLbAwo36wY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Idmw230VWPBhZW2v+dAYw62P6JElxPEL/uqCuoHO0gDvDK3VOnfVdcv9d1ALNkZ2+
         Y+8kPpr9BiXxUfm8bw+Xmjv/SzBxlFpg2EK/a8Hg1b+OzEQC+AII1OlGsc5FjmhCdA
         PYd0h0yBiUAl3qCFDZaEL6GR5SqLeAQ2sKdGgVLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.154]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M1HZo-1irdDo1LiM-002s6V; Tue, 07 Jan 2020 19:16:06 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 4/4] ARM: configs: Build BCM2711 thermal as module
Date:   Tue,  7 Jan 2020 19:15:57 +0100
Message-Id: <1578420957-32229-5-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578420957-32229-1-git-send-email-wahrenst@gmx.net>
References: <1578420957-32229-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:KgT8/xCsDfTXBG/ZvIRxjN+W6EAwuQgL8jv7F25Vy4z+LXj8G1P
 FvRXVhgSwOlulZ964d6rnvX7HL7dcwoY5KFt4EhM20cYoQ7YJ90EDHTamYirCxIqbox1UqU
 ONycfR3lNn3uKEv5yBZAPy3RJBy/loio9XdwmoBs6tYkYaaVTtIztndrmforVufG7I03eQv
 W3OI55XFGJevmqp5FLjsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XO0bOe0Ep8o=:kSgMi1gYunuPgzCu/XiJe8
 55cXkb2VEpp+0ZB7lgktyFvshluW/8SnuuoMm0yhsBOUju5moUy3EZx62VduAycSWKQ78+NnI
 nuuYaeMimJEZFIkXd/bIo8qA7TQgY5Ai7wFwAtnufeOK6yhqeXld+O6drS9SE7OUPwiRaFLvX
 a4z3zZIJ/WSdgxfIjZJl+1A8tbqJu7QHtc7BvlrnNqu0L7T9RP/4wKZFs+iqJxgb56ONYX6aW
 eJEAdrGioHnjoWK1N2opYc6mYPThXU7WIGI67W1LEp4sdfzemZwQzCuEX4itQkAnL2DeCQ5Ga
 TB3twKe/JfrKyCgWbB1LzE4zIekmdDkNCLP1O1ry0t5+zdTGCZqjgF0aW1XQwp7nUNAKqvnkR
 oGFH00fcZrTjP7GTsAHM1SFbj/j8S4XbS2KGdNqEc+X3ozKoe941uA4inBhtY+DCHFbDc82RB
 saG1XiaXGsPKwjXuAqFoy+XoGrMHnHWh5g9mP7Zd8K8eY9UW2y2qLVLlIfRct6viL+vCIg5bq
 bBOs7WNQuQK66Q8JwSFVNkWe5cjQ4sjCurxBOCJu6414eyACNqp75abbUH3UXbZ1ZWeQB05gV
 pAQjr6XZtxFBUpzRIscP1mp92bxLC60clMvMwMY7L3J2tmJzvf+8KaEZ46/AXpMn/5UHILhV8
 RHgsmsQOZtPYbgegdxdoBc4kR22+31P9QayG4NNZpKN6TEFlqDfoNUbNez4dIJleG22IlSiAm
 HnfbzPvVXjeK2JiZBcfGTDhAuoGbB8Fj+2eQ26gxDe6zKM6e+8/ggitNae4Dbbw0frlGYT/H6
 Wawodx5tZYYdi+XZ6h7xR7gVz+qUtDxU3/g+269QUGswvjIS+a6z7lzkEuyK7V6ieV8u7Eh4X
 sN1khUObrdWcgax2sqRsD0RD05hMRw3yVlf9xuWpUo/SWo+mVR/rXK6YkXDiRCL5kmMzaJ/ZF
 b4PktMNM1fUynsV780QqPYKWWfAdvMlDCWnofVBqBUPHArgmZeAkiFzfCcecwEBz+jAxwUZmE
 ANzUWQENqeKB/qYYpxtBwoBTpfvKT9aAuk83/Xxf8kHjFo2JE0BLWXqe+/i6FQUtXR4VmNd2G
 UVWlOQJHCJCaXerv7dUwcdFH2tluzwimauf3xv9Suhg06gzqG2AzZefj6DSqfSFAESG+a1r9m
 u1k2ZLky+lFSekVHbbxsc5W/2rXnl7YvbHVJ1NqvR0HhNJjn7ISBZGvzeJz7kFQCKjXZiQA76
 XprBZmCVmQkyOoIyjE6h4g5xdzecqsXUyniZ7MA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This builds the BCM2711 thermal driver as module for the Raspberry Pi 4.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
=2D--
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm64/configs/defconfig        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_=
v7_defconfig
index 3f1b96d..f5d19cc 100644
=2D-- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -496,6 +496,7 @@ CONFIG_IMX_THERMAL=3Dy
 CONFIG_ROCKCHIP_THERMAL=3Dy
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_ARMADA_THERMAL=3Dy
+CONFIG_BCM2711_THERMAL=3Dm
 CONFIG_BCM2835_THERMAL=3Dm
 CONFIG_BRCMSTB_THERMAL=3Dm
 CONFIG_ST_THERMAL_MEMMAP=3Dy
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6a83ba2..b2f6673 100644
=2D-- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -442,6 +442,7 @@ CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_RCAR_GEN3_THERMAL=3Dy
 CONFIG_ARMADA_THERMAL=3Dy
+CONFIG_BCM2711_THERMAL=3Dm
 CONFIG_BCM2835_THERMAL=3Dm
 CONFIG_BRCMSTB_THERMAL=3Dm
 CONFIG_EXYNOS_THERMAL=3Dy
=2D-
2.7.4

