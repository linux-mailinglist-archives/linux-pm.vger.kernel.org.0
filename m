Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CE214F95
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEFPMk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:12:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50050 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfEFPMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151222euoutp0233ffeefb82f5589db604803a4fe9a36a~cILdCdnU13023330233euoutp02n
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506151222euoutp0233ffeefb82f5589db604803a4fe9a36a~cILdCdnU13023330233euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155542;
        bh=c4kx8rzUZuvENR4GPmajcyTbcTs192pPPPvnLrk0+/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1pcOo+dM8ruCClJ+H6SApAW3dcpJDkD/3ssMgD8F+BP0KEfX/W3Yy69xLQofQcWW
         SzFXdhvlCuMUc/vH6aDgsyJfpSM2yhCYHFDyQKb3xz6NG4Trnq1FzRwYytn4x0wCEu
         lT8V8cAxG/6+fhmu5sVc8UHz/nfA/vLB3mTZcCRc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506151221eucas1p25539054847d6ebab3dd435f40edbc1aa~cILcM019P1450814508eucas1p2J;
        Mon,  6 May 2019 15:12:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2C.A3.04377.5DE40DC5; Mon,  6
        May 2019 16:12:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151220eucas1p237812f2420594eb651d80cf91076510c~cILbaOR0w1041710417eucas1p28;
        Mon,  6 May 2019 15:12:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151220eusmtrp252f6bb72edeeb979e0d41df8943bc6a7~cILbMNsGG0466604666eusmtrp2G;
        Mon,  6 May 2019 15:12:20 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-8f-5cd04ed57c8d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.4B.04140.4DE40DC5; Mon,  6
        May 2019 16:12:20 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151219eusmtip159b84e00dfbff6cfab9b019c8653957e~cILaWzORs3138931389eusmtip13;
        Mon,  6 May 2019 15:12:19 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v7 13/13] ARM: exynos_defconfig: enable DMC driver
Date:   Mon,  6 May 2019 17:12:01 +0200
Message-Id: <1557155521-30949-14-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUwTQRiGnT3aBS1ZlypDNZBUMS2J4BknAS/UZNVEMcYYAcGqKyAUsMuh
        4o8qyI0QSARUDn8oWFSkIEc9aQnIUW6jgiQiUROsBMIRxZNlIf575p3n+95kMhTOmEkFFRoR
        zekiNOFKiT1R0/SjY+3rA10B6yxNTqgyv4JEbya/kKi4sYNE5ePDAOW2FmKoPV2Lsoa/4qiz
        85EUWa/YpKhfvxL1mm5J0ERmI0D5nc8x9KBxUIoGLpdJkMWWTKIXffvQwE8HNP3qI9jhyE5P
        5RDsTX03wdbfGJSyRkOqhM1MGJWwDaNPMfZatQGwVW3x7ITRxdfOz977NBceGsvpPLedsA9p
        zTgc9Yk8X/09hdCDdDIN2FGQ3gTNd2qJNGBPMXQZgCkvb2LiYRLAzME0qWAx9ASAOQUeCxMF
        d/PmpVIAkx6aCFGanShvCUsDFCWhPWCd4ZwQy+l4+P7NC1zwcdqGQevM9znfkfaBVXU/MIEJ
        2g3m37s+xzJ6P+x7NkWIZS7wXUcqLrDdbP47xQyERZDul8KRJ0OEUAbp3VCfKBd9RzjSXC0V
        eSX8W1+MicxDfeZtIPIlOJxVOO94QUtzNymswWk1rDB5ivFOaG23AnG7A3z7bakQ47OYU5OH
        i7EMpiQxoq2C1Rld80XLYen96/PLWfg6IUkivlQRgPWmEiIbuN74X1YCgAE4cTG8NpjjN0Rw
        cR68RsvHRAR7nIrUGsHsz2r70zxZB0y/TpoBTQHlElm2T1cAQ2pi+QtaM4AUrpTLNJ87AhjZ
        ac2Fi5wuMkgXE87xZrCCIpROsvhFH/wZOlgTzYVxXBSnW7jFKDuFHux1mXm86siI81FV8Jr6
        za7qKkODOsBz6Ng405ju7X/IEq+K7a+Z0m3F8tWvzi4+vkdx0G/7mdE1UYxfS1xPoG/ZyLjX
        /cChscTkNreCih1Vxl3ysXJVj3uRJNfBed8yxdWNBv+cwdogH1vpTHJbU4N3b3Zvf21lT+Lq
        gS2259O9CiXBh2jWu+M6XvMP6SBQLVUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7pX/C7EGOy7qWixccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexqme4IKnrBVbfnSwNDB2s3YxcnJICJhIzFw2namL
        kYtDSGApo8S1nhaohJjEpH3b2SFsYYk/17rYIIo+MUo8a/sF1MHBwSagJ7FjVSFIjYhAvUT/
        m0tgNcwCDcwSa7ZfBRskLOAksXnHTyYQm0VAVWLGymlgNq+At8SVvV9ZIBbISdw818kMYnMC
        xf92HGIEsYUEvCT2ffzNMoGRbwEjwypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzASNp27OeW
        HYxd74IPMQpwMCrx8D6wvRAjxJpYVlyZe4hRgoNZSYQ38dm5GCHelMTKqtSi/Pii0pzU4kOM
        pkBHTWSWEk3OB0Z5Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkG
        xgnXz8rfN7llarElcK0Ky7LIg0UXg5JZsiu5/Xy7Q02Ct2dNOP7hT4Ari5bGgYUVzj3ZwZU6
        bb1vv4Zk/9r7+3n8DIvJ63okP307Ixg+9b7ygknHlDnuaRWJnxbb87roTUBmj3n9lccL0pNC
        wrWzcydo7XpjcH+bsYTF+z+7j3j2ZshundOsoMRSnJFoqMVcVJwIAFAUA6a6AgAA
X-CMS-MailID: 20190506151220eucas1p237812f2420594eb651d80cf91076510c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151220eucas1p237812f2420594eb651d80cf91076510c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151220eucas1p237812f2420594eb651d80cf91076510c
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151220eucas1p237812f2420594eb651d80cf91076510c@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable driver for Exynos5422 Dynamic Memory Controller supporting
dynamic frequency and voltage scaling in Exynos5422 SoCs.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d635edf..04c076e 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS5422_DMC=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.7.4

