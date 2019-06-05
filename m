Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41963596F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 11:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFEJNW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 05:13:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59908 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfFEJNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 05:13:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190605091305euoutp02d2c00ffc1d346fbfdc67a560924d4eda~lQoUvW2xK2397423974euoutp02U
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 09:13:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190605091305euoutp02d2c00ffc1d346fbfdc67a560924d4eda~lQoUvW2xK2397423974euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559725985;
        bh=DXkL35oPpZTBAsvyPuQnVqH97l4/MrL284NHjf3JLg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/4kZjinKqF3szhyG69aMezJtZc4wEyHKfiTpa4SG18rZTeS/j3VuwVjzZAWhFjqk
         mU9S5k5oFl8C9OW+IX0Isq/0LZwZMFCm905t7v43FVJb0UNMaFSTRcgwWrjGrkXrLC
         JhC38hrvsB7pnKlHiQm/HMJ1sJQ5R39AGQ/SQiyI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190605091305eucas1p11c5df669ae85ad39901e04cb3af67ed2~lQoUNrhj51225212252eucas1p1R;
        Wed,  5 Jun 2019 09:13:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 01.06.04298.0A787FC5; Wed,  5
        Jun 2019 10:13:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5~lQoTah7RW2947129471eucas1p2s;
        Wed,  5 Jun 2019 09:13:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190605091304eusmtrp1c3fc0c93399aca88e6bcec9a21808064~lQoTK3Flm0947509475eusmtrp1e;
        Wed,  5 Jun 2019 09:13:04 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-4e-5cf787a0fea5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.8A.04140.F9787FC5; Wed,  5
        Jun 2019 10:13:03 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605091303eusmtip1e7903acc18d274a5b35ae6fb6f0b0889~lQoSaqpXT2955629556eusmtip1i;
        Wed,  5 Jun 2019 09:13:03 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v4 4/5] Documentation: devicetree: add PPMU events
 description
Date:   Wed,  5 Jun 2019 11:12:35 +0200
Message-Id: <20190605091236.24263-5-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605091236.24263-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHfXd2ds5G0+OUfDPRGApapCkVLyQ5M2JlhJ9VrFMeVNJpO94T
        m4mad1OxoXmrvDAVbYq3SlLnJU2XRVmZkvph5KXM2UQKyXUWfvs9z////J+Xh5fEJFrckYxS
        xDNKBR0tFYj43aM708frcrZDT3yrOIWeqttxNLtlwFGtbhpHxcurGNLrOwg0dXeNQJ9VTki7
        /AFH7/ofCpCxUAeQWj/AQ226eQI1zM7w0FxGswBlvdARaHgtB0em8SUgs5W31rQCeV/lPCHX
        anIF8s4nd+SD35/z5EVdGiA3ap2DiGCRbzgTHZXIKL3OXhNFNnbU4nEGSXJuVoFABV7b5AEh
        CamT0DSRy88DIlJCNQNY2r2GccUWgCXlnyyKEcDeHC3v/0jnfQ3BCU0A5utH90cGV1/uFSQp
        oDxhr+aWecCeegygaTjY7MGoRh4cyNz8l2RHBcGGL8/4Zj+fcoO6BWdzW0z5weKe9xi3zAW2
        dHCRQkoGO9V+5hhITRCwbGMG5zznoaFt1cJ2cGWsi+DYCU6WFfA5ZqGqsB5wnAaXi6stnjNw
        eMycQ+69zQO293uZEVL+8NUjGw6t4cd1W7MZ28PS7gcY1xbDe9kSLsMddhW8sRznIGxqrbBk
        y2HmzwzLocoAXM8ZByXApXJ/Vx0AGuDAJLAxEQzrrWCSPFk6hk1QRHjeiI3Rgr2fNLk7ttkL
        fr29PgQoEkgPiDdoU6gEpxPZlJghAElMai+m57ZCJeJwOiWVUcZeVSZEM+wQOEzypQ7i21Zf
        QyRUBB3P3GSYOEb5X+WRQkcVaK9PDSiXRY5cqTYm101f4l8QXq4MWXcdX6+yyR6pafJKjXf+
        49qQn5zem672GayVkWGLKxFbvj1q/+2hltN9soWdc06RCpH7ZJPBI7ZKuH3kd9SiPnAjtW+q
        wn83OHC7+Id1Wr2P+6GCyhkXoc9Fh4CwpJUwq5GdoiUnt8GkY35SPhtJex/FlCz9F07JJUtF
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7rz27/HGMxfY22xccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6Gcs2zGcteC5U0dnaw9bAeIa/i5GTQ0LARGLzxFXsXYxcHEICSxklWt/dZoNIiElM
        2redHcIWlvhzrYsNougTo8TaH6tYuhg5ONgE9CR2rCoEiYsILGeUOLbqLTOIwyywjUliz5Xd
        jCDdwgJ+EuevPmUCaWARUJU4ck8OJMwrYC/Rv/0qM8QCeYnVGw4wg5RwCjhIbJ5hDxIWAio5
        fnYr8wRGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC42TbsZ9bdjB2vQs+xCjAwajE
        w/sh8VuMEGtiWXFl7iFGCQ5mJRHexNtfYoR4UxIrq1KL8uOLSnNSiw8xmgKdNJFZSjQ5HxjD
        eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGHkZP72fumNm6z7t
        3yq//U8Euhs1JU6vr2CxWebVff9KYXEcf95lQ3utNYtsFsgWu6wM+Kaiz6/pKPBx3wkLLVPR
        /397vgks/lefMqsxWe74hZ+PvzJdy1i+UPabbH6w/tzJkmbaL5OzbZ/ovpngu776hedT3ysn
        GkQYSzNlZ+dNPXXp8xGjY0osxRmJhlrMRcWJAHgcNRepAgAA
X-CMS-MailID: 20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5
References: <20190605091236.24263-1-l.luba@partner.samsung.com>
        <CGME20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend the documenation by events description with new 'event-data-type'
field. Add example how the event might be defined in DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../bindings/devfreq/event/exynos-ppmu.txt    | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
index 3e36c1d11386..fb46b491791c 100644
--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -10,14 +10,23 @@ The Exynos PPMU driver uses the devfreq-event class to provide event data
 to various devfreq devices. The devfreq devices would use the event data when
 derterming the current state of each IP.
 
-Required properties:
+Required properties for PPMU device:
 - compatible: Should be "samsung,exynos-ppmu" or "samsung,exynos-ppmu-v2.
 - reg: physical base address of each PPMU and length of memory mapped region.
 
-Optional properties:
+Optional properties for PPMU device:
 - clock-names : the name of clock used by the PPMU, "ppmu"
 - clocks : phandles for clock specified in "clock-names" property
 
+Required properties for 'events' child node of PPMU device:
+- event-name : the unique event name among PPMU device
+Optional properties for 'events' child node of PPMU device:
+- event-data-type : Define the type of data which shell be counted
+by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
+all possible type, i.e. count read requests, count write data in bytes,
+etc. This field is optional and when it is missing, the driver code
+will use default data type.
+
 Example1 : PPMUv1 nodes in exynos3250.dtsi are listed below.
 
 		ppmu_dmc0: ppmu_dmc0@106a0000 {
@@ -145,3 +154,16 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
 			reg = <0x104d0000 0x2000>;
 			status = "disabled";
 		};
+
+Example4 : 'event-data-type' in exynos4412-ppmu-common.dtsi are listed below.
+
+	&ppmu_dmc0 {
+		status = "okay";
+		events {
+			ppmu_dmc0_3: ppmu-event3-dmc0 {
+			event-name = "ppmu-event3-dmc0";
+			event-data-type = <(PPMU_RO_DATA_CNT |
+					PPMU_WO_DATA_CNT)>;
+			};
+		};
+	};
-- 
2.17.1

