Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158A96CFD1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbfGRObt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 10:31:49 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35083 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390812AbfGRObk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 10:31:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190718143139euoutp016bf4e290c363ea2317c9f87f1028da54~yhtvmPLHo1277612776euoutp01U
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 14:31:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190718143139euoutp016bf4e290c363ea2317c9f87f1028da54~yhtvmPLHo1277612776euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563460299;
        bh=Bi2GA2UVqT1Tvo91yYqOKkUfUxxCOns6Sb2hHqEpoC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BIQr/+0+//b4olqSIyt/ZGPh6JBd98TwINLygvwniF0WN6v/FExfQaIAwBfKiE1fr
         Tksp6oasmdBwxqtZP/9cBhfCFP84zCzJXIH5ZnYIHDUvPqx5tNNNcZ6T2H99cT0ufl
         97g3GgbjC+FK0O7LQATvtGnWIoHUbkdkcwepO2zk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190718143139eucas1p2de24e702ff1b2fe63134d4d1e372da41~yhtvHUZaN3227832278eucas1p2y;
        Thu, 18 Jul 2019 14:31:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C2.30.04325.AC2803D5; Thu, 18
        Jul 2019 15:31:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143138eucas1p127542c4cb8416cee9af6a95f4bc98366~yhtuM56N50448804488eucas1p1q;
        Thu, 18 Jul 2019 14:31:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718143137eusmtrp17d8058aea5c4fb7fec06942e8d574220~yhtt_zfpc1949819498eusmtrp1E;
        Thu, 18 Jul 2019 14:31:37 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-e9-5d3082cac3a5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.3E.04146.9C2803D5; Thu, 18
        Jul 2019 15:31:37 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143137eusmtip170b431c23792f5ca9887094eb9d7c910~yhttZNAUx1530115301eusmtip15;
        Thu, 18 Jul 2019 14:31:37 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 9/9] ARM: dts: Add samsung,asv-bin property for
 odroidxu3-lite
Date:   Thu, 18 Jul 2019 16:30:44 +0200
Message-Id: <20190718143044.25066-10-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718143044.25066-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUhTURz1bu/L5YvnHHmzUBkaJOYHZjzIpMI/Bv0jKEbFqJUPtbYpe87S
        qCRd5tJpGmoqJZFMXvk1za9Iw00Hii6LQjKnYaKmC0lDRam2vVn/nd85v3PPuZdLCMVVaACR
        oc5mNGqFUoqJkK7hrfEjI3ej5FELXDTdXtOK0k8t4yhdNrcspG22Npw2zX1C6Q999Ri9VmoB
        dI2tX0A3W6Zx+tmrdZzWvbHgtHmlCKU7Zoexk6TMxBVjso7nd2SGTg7I1kyBich5UVwqo8zI
        YTSR8ZdE6Zt6A541id2o7ypC8oEF1QNvAlJHYbHdCPRARIipJgDfP3II+GEdwPrtTYwf1gA0
        9FqEu5adja8ILxgBNLZ34/8spkrXYd4ERkXD0iGDG0soP2hvNLqXhJRdAEfnxwQuwY9Kgp91
        i4gLI1QorJqtdLciqTi40NML+Lgg+KLtrTva28mbp+fdbSFViUND4YiAX0qAuoFxz5X84Hdr
        J87jg3C0sgThDQUAlryewvmhHMAZa4Mn4jg0WyecbsLZ7zBs7Yvk6VPQatsQuGhI7YWTDl8X
        LXTCiq5qIU+T8P49Mb8dAre5ak+dAPjg2x+ExzLYolv3vGMZgAUt1Wg5CKr9H9YAAAf8GS2r
        SmPYGDVzPYJVqFitOi3iSqbKBJy/ZfS39VcP6N+5PAgoAkh9yERVlFyMKnLYXNUggIRQKiGn
        liLlYjJVkZvHaDIvarRKhh0EBwhE6k/e9Jq9IKbSFNnMNYbJYjS7qoDwDsgHEUMvlfMVXkXa
        IKy0u8phPgOyf5yOrS9dvcqZs7ZCP/qq0RnybPKJPDY2NEVSux/eCpQ3nvvZNqDfV3jskHb5
        Nhe6N2V6dS1j0xFib2pdNK6G1w1RYUu9ze/04bKu3ong4oROju3P0gcnPdzz+AnqU7GSPKf6
        opfUlccTYzFShE1XRIcJNaziL+mCPwYpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xu7onmwxiDV4vNLfYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexo+uPvaCG2wVc7a1szQwHmHtYuTkkBAwkfjz/SFL
        FyMXh5DAUkaJV+8WAiU4gBJSEvNblCBqhCX+XOtiA7GFBD4xSpw+4gxiswkYSvQe7WMEsUWA
        au4tXc4OModZ4BWTxO15/5lAEsICgRLzmx6AFbEIqEpMezAZbDGvgI3E8x07GSEWyEus3nCA
        GcTmBIofvvuUEWKZtcTsl9cYJzDyLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREY4tuO
        /dy8g/HSxuBDjAIcjEo8vAG5BrFCrIllxZW5hxglOJiVRHhvv9SPFeJNSaysSi3Kjy8qzUkt
        PsRoCnTURGYp0eR8YPzllcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+Lg
        lGpgLKnpP9dy7XSktRtziuLJmjksurEFYntvMrA6zE7WlNl8YNYJJyWtRReOVP+MMXop58uy
        weH7H621rdcDVn92P6tV/spaY87xHK5FMWGBWy/xbHKuztjg2nTOX2C1vHjOo4w3G9syJjxN
        KYjpqhYQ3/c+uIrBqfbPMQ2JyZI296/kv7FPmMWpxFKckWioxVxUnAgAWIGyPocCAAA=
X-CMS-MailID: 20190718143138eucas1p127542c4cb8416cee9af6a95f4bc98366
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143138eucas1p127542c4cb8416cee9af6a95f4bc98366
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143138eucas1p127542c4cb8416cee9af6a95f4bc98366
References: <20190718143044.25066-1-s.nawrocki@samsung.com>
        <CGME20190718143138eucas1p127542c4cb8416cee9af6a95f4bc98366@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Exynos5422 SoC used on Odroid XU3 Lite boards belongs to
a special ASV bin but this information cannot be read from the
CHIPID block registers. Add samsung,asv-bin property for XU3
Lite to ensure the ASV bin is properly determined.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1 (RFC):
 - new patch
---
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index c19b5a51ca44..a31ca2ef750f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -26,6 +26,10 @@
 	status = "disabled";
 };
 
+&chipid {
+	samsung,asv-bin = <2>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
-- 
2.17.1

