Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28A5B7C41
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403782AbfISOYR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:24:17 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46486 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403777AbfISOXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142332euoutp01657da35b2d26cbf0022e5da3e3e3e1b6~F3PpCbDGW2200122001euoutp01A
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919142332euoutp01657da35b2d26cbf0022e5da3e3e3e1b6~F3PpCbDGW2200122001euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903012;
        bh=TV1z+igvsoIbVfWWAwJfb3ELED5sMO01fLplbggkMEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=so7tlrb4EJFRN5H0a/t2QfQeloVQlmEZoQkL2PIFwtajjdETyoyIvX10shYA99QcD
         i72G6wt0+jBLEYNNuft8u//kic+PgUz6wkB0vxoLlqlRKhk68ddGNMNsW5Y8LbiRF3
         OtG9JdF5k6UI748aAebbl7rD7kbL7aZaCeSnZJJ4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919142331eucas1p2796f51835a980ab05279a92068aed907~F3PoOErBV3077830778eucas1p28;
        Thu, 19 Sep 2019 14:23:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CD.1B.04309.36F838D5; Thu, 19
        Sep 2019 15:23:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142330eucas1p1eceae78b148a03f2af71657b7cdd6694~F3PnWgSvX1761817618eucas1p1F;
        Thu, 19 Sep 2019 14:23:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142330eusmtrp17672e43b993bed51c1c88b1c4d09ee9d~F3PnIF1Do0555105551eusmtrp1j;
        Thu, 19 Sep 2019 14:23:30 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-66-5d838f63b8af
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.65.04117.26F838D5; Thu, 19
        Sep 2019 15:23:30 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142329eusmtip1135a0ffecb68779a53fbb8d79a1c0bd0~F3PmUlWIN3163331633eusmtip1L;
        Thu, 19 Sep 2019 14:23:29 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 10/11] arm: dts: exynos: Add interconnects to
 Exynos4412 mixer
Date:   Thu, 19 Sep 2019 16:22:35 +0200
Message-Id: <20190919142236.4071-11-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3bv7u6sq9dZdDBLHYhUpGZFTyRREnELP/hNSsSmXtR8yXa1
        Nz/kC5bam7gsU0nTkeYKdanoMtE1GmY0ylqlzllWVpAV07LobdtdL99+53/O//yfAw9NKOxS
        fzo9O5dXZ6sylZQX2X3nq2VN8tnihAjdqD823umSYfulEoQ7qtuk+MnstBTXm+5L8aO5DxS+
        cEtP4Up7BYktlnYZbrF9kmL9lFWKRwx1FHacNiFcbemX4OsmmwyPFbZQuFrzltrqy+lbyyhu
        3NpHcfaTZgl3Q3uM65jpkXCDM30S7kxnK+Ic+hWx9B6vqBQ+M/0grw7fstcr7WbhnCxnRHa4
        3TiNClA3VY7kNLDrwaEzoXLkRSvYFgQVjQ9lYjGL4KVpwtNxIDAPlEn+WIxFDwkXK9hmBM2/
        dv91THS1u/dS7DaorJp0r1rMmhBoGj6QroJgtRI4U2tx2/3YOOi69pR0McmGwJT1jVtn2E3w
        +GojEuMCQdc+4NblTn22v54UZ3xh6OJLNxPOmeKuWsIVAGwJDSfuFnnM2+H81DlCZD94Z+6U
        iRwAw5pTpMgCvOq1S0VzAQL9FZPHsBlumx84G7QzYSW0GcJFeRs0vLglc8nAesPT977iG7yh
        svsCIcoMlB5XiKgEw0Vv0QhQpLN6dnPQ1FsqqUDBNf8dU/PfMTX/YhsQ0YqW8nlCViovRGbz
        h8IEVZaQl50alrw/S4+c3274p3m2Bxm+JxkRSyPlIiboUHGCQqo6KBzJMiKgCeVipm5DUYKC
        SVEdOcqr9yeq8zJ5wYiW0aRyKZO/YDJewaaqcvkMns/h1X+6ElruX4Bi5rWl2q0KpuMef9nx
        PGxHhbFqyKQBec9UzHvbeNMQ77ORKXsdmEgsn7GOjs3HrjJM+KxgHQR8ZKbzj5Wsiz/w7sew
        3/Odga3joQm3o54FB5zQ5AqBQsTJncMh36M3ZHxLks+H7gtKj9y1JLeUyi+M61unW/ZlsMe2
        emFH9OcqJSmkqdauItSC6jdFz9/8cgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7pJ/c2xBkt6FS0OHdvKbnF/Xiuj
        xcYZ61ktrn95zmox/8g5VosrX9+zWUzfu4nNYtL9CSwW589vYLdYcfcjq8Wmx9dYLS7vmsNm
        8bn3CKPFjPP7mCzWHrnLbnG7cQWbxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe2x8t4PJ
        4+C7PUwefVtWMXp83iQXwBGlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7G78St7wWX2ig2HnjM2MG5j62Lk5JAQMJE41HSJuYuRi0NIYCmjxN1D
        51khEhISH9ffgLKFJf5c62KDKPrEKLFvyXMmkASbgKPEpKkP2EESIgKnGCW2Lj8HVsUssIFJ
        YvnTl0DtHBzCAqESKy7ogzSwCKhKPL72ghnE5hWwlLi6chEjxAZ5idUbDoDFOYHiX/bNZwGx
        hQQsJOY+nssIUS8ocXLmExaQkcwC6hLr5wmBhJmBWpu3zmaewCg4C0nVLISqWUiqFjAyr2IU
        SS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM4W3Hfm7Zwdj1LvgQowAHoxIPr0J5c6wQa2JZcWXu
        IUYJDmYlEd45pk2xQrwpiZVVqUX58UWlOanFhxhNgV6byCwlmpwPTC95JfGGpobmFpaG5sbm
        xmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYez7s57rkwSMV/P9sGPf8kn8PzoVppfk5
        pTD/LA/9nch6ndHsFPcbQVWGI1Ivne5x9/BMydwf8yWht0V8Nf+WRV17/L1+fbaoWnEjcvO0
        9615in1iNWFqxSsS9i0NS9yhYmfPE1LE2fz+93K/BpO/q5Pes+1Yqn57dQx30OP7ySyyQr1h
        Pi5KLMUZiYZazEXFiQA6iPJh9wIAAA==
X-CMS-MailID: 20190919142330eucas1p1eceae78b148a03f2af71657b7cdd6694
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142330eucas1p1eceae78b148a03f2af71657b7cdd6694
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142330eucas1p1eceae78b148a03f2af71657b7cdd6694
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142330eucas1p1eceae78b148a03f2af71657b7cdd6694@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

This patch adds an 'interconnects' property to Exynos4412 DTS in order to
declare the interconnect path used by the mixer. Please note that the
'interconnect-names' property is not needed when there is only one path in
'interconnects', in which case calling of_icc_get() with a NULL name simply
returns the right path.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4412.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index a70a671acacd..faaec6c40412 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -789,6 +789,7 @@
 	clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
 	clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 		 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
+	interconnects = <&bus_display &bus_dmc>;
 };
 
 &pmu {
-- 
2.17.1

