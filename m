Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8588784DA5
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbfHGNjH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 09:39:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58184 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388498AbfHGNjC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 09:39:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190807133900euoutp019e8ae4269c3ae7d4b5e65ae3e0d1c001~4p5fDmFoZ2498324983euoutp01B
        for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2019 13:39:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190807133900euoutp019e8ae4269c3ae7d4b5e65ae3e0d1c001~4p5fDmFoZ2498324983euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565185140;
        bh=uK2H2CY5YVkbPXh3EKmhTQmAPpi5mTFt1H3u7NFbf9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfdolvnILpUPv2Fi0G89DNTeN8tw3xVqt6N3rCxjpkZAqbaiCxSWLzxbH8Vgj6FCn
         XFnEvDkSXCBT13qVvSF2rWbXESlKuB47C96eGoQIgXJPj23VieHHQbwi95u2MhF9Yq
         oXwKyZ/gGhbLY9FeUSMCdXu3T9ucUwYAWidg/jdQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190807133900eucas1p1f1b267ca2046eb60ea4d967a98883c12~4p5eaW0lO1980719807eucas1p1O;
        Wed,  7 Aug 2019 13:39:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3F.F6.04374.374DA4D5; Wed,  7
        Aug 2019 14:38:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190807133859eucas1p22355fae5d369c0c608c410049d82c1be~4p5dkRsq31798017980eucas1p2a;
        Wed,  7 Aug 2019 13:38:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190807133858eusmtrp185e7a448805acd8fc6cc069669fee4f6~4p5dV5I_L3034030340eusmtrp13;
        Wed,  7 Aug 2019 13:38:58 +0000 (GMT)
X-AuditID: cbfec7f5-92d689c000001116-11-5d4ad4736c0c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.AE.04166.274DA4D5; Wed,  7
        Aug 2019 14:38:58 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190807133858eusmtip2ee06bef28cdc756550dba938498956a1~4p5ciJdt02016620166eusmtip2v;
        Wed,  7 Aug 2019 13:38:58 +0000 (GMT)
From:   k.konieczny@partner.samsung.com
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v5 4/4] dt-bindings: devfreq: exynos-bus: remove unused
 property
Date:   Wed,  7 Aug 2019 15:38:38 +0200
Message-Id: <20190807133838.14678-5-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807133838.14678-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUURj1vmXmaY09R6uLRdKERNJom3hpkaSF1/JDwl+K1VNfKq7Nc60g
        Lc2UNMlKU3MJSzMdd1NLSR3UcM+VykGwrGyUxoWyRJuZN6L/zne+c+45H1wKl6pJa8o/OIxT
        BLOBMpEZUdu22CvnB8967kvUHEAVGWUkGpn/RqJcVQ+JUppWALo/8RNHvb3lYtR9SyNGlRPD
        JBpoyBahuWQVQBm9TRgqVY2J0fORfgx9ii0SIc2fbgzFN6rEaHm4gkBV422i41KmJKcEMJXF
        iSKmquAm0zzzFmNSqosB0z76GmPmKne4it3Njvpwgf4RnMLB+bKZn7L+fOgYFfW4MZeMAa3i
        JGBKQfoQnBnIAknAjJLSRQDOlnbjwjAP4NJsHCEMcwD+fvoPX7W8+DyICYtCAAsfp61Z1FMz
        Ir1KRNvC6owfhhArehdMU6cbRDi9SMDygQrDwpK+ANM0hZgeEzqDVqk0YAl9Eo4mzJJCnA1M
        rHtD6LEpfQouNKYCQWMB3z/5YuBxneZ2TZax3rQYDmgPC/gkzM6bMb5jCafaq41Xb4edafcI
        AUfCr/kpYn05SMcBOJ6gNS6OwNb2fp2Z0gXsgWUNDgLtAjNzszA9DWlzODptIVQwhw9q9Tfq
        aQm8e0cqqOUwZ6XL2GAbTFpRGjEDlVPTRCrYmbnumMx1x2Su5eYBvBhs5cL5IF+OPxjMRdrz
        bBAfHuxr7x0SVAl0v65zuX2hDjQtebUAmgKyjRKTvrOeUpKN4KODWgCkcJmVRB1xxlMq8WGj
        r3GKkEuK8ECObwHbKEK2VXLdZNxDSvuyYVwAx4VyitUtRplaxwBXb4+re9VuG/x+RXIXi2/k
        OJ4rUuWmF8Sn7xzCPzY1D5I2EXI3C/lk/Nwxtnl44/2av1Nu1k67I7F3HSNM/oZHHj19Qy/N
        6+uXrzS+Sv4wuaUqS7vo4tQx1hzaddoxOYX9HlB3otPVNnFIKZ923/xQlWAzhDbF2kX5Woi8
        nDvCnskI3o/db4crePY/twLA0nEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7pFV7xiDW78N7LYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7Fup0/BXY6KaXvnszYwHmbvYuTkkBAwkVh25wpTFyMXh5DAUkaJ31uu
        sEIkpCUaT69mgrCFJf5c62KDKPrEKHHq0HKwIjYBVYktM16CTRIRUJaYfG86M0gRs0Anq8SK
        J0fYQBLCAgES926vYAaxWYAaPq5bBzaVV8BF4kb7J6ht8hKdO3azgNicAq4SX/dOYASxhYBq
        Fh3cCFUvKHFy5hOwGmag+uats5knMArMQpKahSS1gJFpFaNIamlxbnpusaFecWJucWleul5y
        fu4mRmBUbjv2c/MOxksbgw8xCnAwKvHwMlzwihViTSwrrsw9xCjBwawkwnuvzDNWiDclsbIq
        tSg/vqg0J7X4EKMp0BMTmaVEk/OBCSOvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZq
        akFqEUwfEwenVANjhl1iy6rdwos/qir07yiWmrRXsko1w8j4Yt4sfVu1ibO2GZ58lb6tIfFp
        2zHbd16v90xvne0x5/aarD+yV5+veDazf8ZJVrkrvxKXvdjCJTVns5d/t2gDj8PEG57P19c4
        rny8bMlcw7fquYx3P6TsyFx2TD6WmfdNwLyQ4NZpG9YkGAga/k1rVmIpzkg01GIuKk4EAOyN
        ap/gAgAA
X-CMS-MailID: 20190807133859eucas1p22355fae5d369c0c608c410049d82c1be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807133859eucas1p22355fae5d369c0c608c410049d82c1be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807133859eucas1p22355fae5d369c0c608c410049d82c1be
References: <20190807133838.14678-1-k.konieczny@partner.samsung.com>
        <CGME20190807133859eucas1p22355fae5d369c0c608c410049d82c1be@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove unused DT property "exynos,voltage-tolerance".

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index f8e946471a58..e71f752cc18f 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -50,8 +50,6 @@ Required properties only for passive bus device:
 Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
 			the performance count against total cycle count.
-- exynos,voltage-tolerance: the percentage value for bus voltage tolerance
-			which is used to calculate the max voltage.
 
 Detailed correlation between sub-blocks and power line according to Exynos SoC:
 - In case of Exynos3250, there are two power line as following:
-- 
2.22.0

