Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6316FEC3E3
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKANn3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:43:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:38803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfKANn3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 09:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572615792;
        bh=fOvzyTqdzRPJH9OPOKinIdqeCZlBTTjHLrFlxGo7twE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=X9MZO549TJZ3vLpsTN53oZPmrRiVr6QEhE+a8tJ0Vozj/4p8GngNCsMNBWi/HHAQF
         d0u4qpBcTg6lLFDQuuzcz3tdFsHTD1R8t2vxGKcKvBRsDYlZ+m7v6+yHlqt8F60ZMk
         SdZduKccraRWC8etr/ne1T5gzHczUiJDg70n+HXM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.112]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MtfNf-1i6fdQ4C7D-00v7fj; Fri, 01 Nov 2019 14:43:12 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 4/4] ARM: configs: Build BCM2711 thermal as module
Date:   Fri,  1 Nov 2019 14:42:29 +0100
Message-Id: <1572615749-9524-5-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572615749-9524-1-git-send-email-wahrenst@gmx.net>
References: <1572615749-9524-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:TbKDFSyoLz5kGUMLh2sdMchsMi8B7ywabIQ029/PvKMAKErCJPq
 LaV4eY+9A6wMG6XJAq+AzVhHdeDbWKCIQ2SdpxaHQVJDnPz05KWwr/zYmz4qRItRUAmMueQ
 52bZwE1KDdhZw19Aa3Vn6hRMebJFvpX727zxqEUbD6e5Il680xV+/xuwUvFKrOLUtnTXGr9
 eM4jtb+KLzwTZf5GlyVCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MkaZ/3lmt58=:nz5UCjGMivPj91VNzCwyFe
 6eTbZupEK6tkHD/UlTaZguPibR6Acl9YFic3AY75LQk2NoG51Ex7boMYU+seMx6ZfqRW6CoKr
 82zvdUtskysVkSwIFg01uXDzcuS75oaF7e2SOArQNIU6sMCgbB1T7UI3M21LqHQw/XikjB5bg
 Q7FLOawvCLmPPc0vGqhtvxOtC/HWrmfORZqcmpVNyU94muqiEX7XutEIIq8LlxBSXUs2Ith+5
 q5YzU1OWw7G/gzg/iSw4hlhWoLvkmkjNAXbTf7GuB8u3EaPtjKTaQWacZ0FoqMVJpQuCy83bR
 tHeOzjRMGwYaGjJ/7NlW6yLsxr+GPypkXEivylBTPBJDKdl9Sl+mDIDYjvt0cG2yBqFJqG44s
 2CbRHr6clzj7fYcOSZgS7AlymGiKuFKVNlFYteTaksqTMoZ+ikGoBared5E/tGt06dxRzHmcG
 J6yAg53kzjL7gwq5087VkC95YdYT1ukWME6yqugRfaOOtZUANg6uIeWGq57ufCRCciYjncoF5
 HR3Ah4IBy/h5HZSx55vtBkX5m6kKrJAzUgcE/UOmMNQZ6qwXZETpwB1G3ghmauLKVsLsMz+OS
 vigD293HSdqK0UJ/QpbAUoVlKTETu616J4lWurFMBaUcrRED3YQCniCMIsPI61yvICXrHP188
 2LnqqwvqvJ+mTxARSP3h7/YAPes5o13PDlG+gUA+2U6AgQfBhoxALznXemfcWAuRxcD0YHMoB
 Z/4cce5K/gaKIBXapRxP41P10j9ZX3TmUhrs93PMlDGGFv60tBJpb3TCnL3/Kfo+0fjnboGkJ
 o9NQ3J6gVe2/05QpLi3BQEvuhyQbE8KHXTrJnKqH7OG8XnePT8LbHza1HkX1ZRRA5XsMo9BiF
 S2eeWhpw35peMp9UiyI7N5jFDyeBOgYtqoO3+uv64HPL9I8qKqTlLlsk3ReNsQGP85331SXAZ
 87IojnVd41AxiBEGU5Qjz4rGCqnJqbQo8S9ox50/0VDxDl2TwF5kaNERTIcL5kRod62nvTSSm
 nP0j/C3mLORpdWUnWkE53uyjSXcpFP7q5gKDPBn3GlIu7409OCcBi4mqPWwGuGqejVGegoR/0
 /aUTIpuslWS/e0MRk2Ilba/FqKbra8O6GpLnyw3V1LaNy54d5X04ge+lWrFGRCt//R9QOCnWt
 fBwFYpy2gNB+0M41/3elbVdwJ6u6roVi12SysrxoTFP+P4PFWPZSGN2ZVaGAJq2k3Pl6eeMQr
 G4ozsyV4gPkFnB+7uOCXTVn7bktCAG7C+pHQRlA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This builds the BCM2711 thermal driver as module for the Raspberry Pi 4.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm64/configs/defconfig        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_=
v7_defconfig
index 13ba532..441b795 100644
=2D-- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -487,6 +487,7 @@ CONFIG_IMX_THERMAL=3Dy
 CONFIG_ROCKCHIP_THERMAL=3Dy
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_ARMADA_THERMAL=3Dy
+CONFIG_BCM2711_THERMAL=3Dm
 CONFIG_BCM2835_THERMAL=3Dm
 CONFIG_BRCMSTB_THERMAL=3Dm
 CONFIG_ST_THERMAL_MEMMAP=3Dy
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8e05c39..0a52987 100644
=2D-- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -444,6 +444,7 @@ CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_RCAR_GEN3_THERMAL=3Dy
 CONFIG_ARMADA_THERMAL=3Dy
+CONFIG_BCM2711_THERMAL=3Dm
 CONFIG_BCM2835_THERMAL=3Dm
 CONFIG_BRCMSTB_THERMAL=3Dm
 CONFIG_EXYNOS_THERMAL=3Dy
=2D-
2.7.4

