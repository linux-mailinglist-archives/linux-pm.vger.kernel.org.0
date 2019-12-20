Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0E012722A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfLTASX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:18:23 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63886 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfLTASJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 19:18:09 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191220001805epoutp02099ca58442f5cc2d97de198e9c51cd23~h7DuNtT2r0644106441epoutp02W
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 00:18:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191220001805epoutp02099ca58442f5cc2d97de198e9c51cd23~h7DuNtT2r0644106441epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576801085;
        bh=vj6qQCJO7kdR2uHu16+MKQ3F1A2qE4yUYtHgqen8kuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9zCzUezdyTqZuzo/vDfVNSyPrBheskG8CucTPB3Md9pOr4AXIhsfQYlOipdNHU75
         pXMuiqmMAyrvvNKSBSoiIaSmJ5FMDUh4nqWG6/UOkE+VbfjjryTpL1ED3tsSqg/XBg
         nMpHDtWgRsd5rJ57SFV1ANyulQ2KwNkOP2AWJH0A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191220001804epcas1p3da098f30abe5005bf454482ae3ecc05f~h7DtmT8uk1379413794epcas1p3Z;
        Fri, 20 Dec 2019 00:18:04 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47f8Th0pW6zMqYkV; Fri, 20 Dec
        2019 00:18:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.7D.52419.7331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epcas1p3051f7916542b7234aac5273e0baab83b~h7DpQGarH1359613596epcas1p3W;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191220001759epsmtrp22d890a5ed7cf495d28f3a5a28489e53d~h7DpPNHKa0512905129epsmtrp2V;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-10-5dfc13376788
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.7C.06569.7331CFD5; Fri, 20 Dec 2019 09:17:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epsmtip11e175b09379ebd11ce2bfff059993667~h7DpECM0w2109521095epsmtip1d;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 04/11] dt-bindings: devfreq: exynos-bus: Replace
 deprecated 'devfreq' and 'devfreq-events' property
Date:   Fri, 20 Dec 2019 09:24:23 +0900
Message-Id: <20191220002430.11995-5-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002430.11995-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmga6F8J9Ygx2vGS3uz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlAbygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL
        89L1kvNzrQwNDIxMgQoTsjNuTn/FWHBXpOL0+60sDYzXBboYOTkkBEwkGrY+Yuxi5OIQEtjB
        KLHn8xd2COcTo0Tjjf/MEM43Ron1z78zwbQ8b5vCApHYyyjx5nETVNUXRonjz66ygFSxCWhJ
        7H9xgw3EFhHIkJj5+jIrSBGzwEcmia5td8ESwgIVEsf6L7KD2CwCqhITdl9lBLF5Bawk7qzt
        YodYJy+xesMBZhCbU8BaYsuzh2AHSgg0s0scPLEF6iYXiVtXWxghbGGJV8e3QDVLSXx+t5cN
        wq6WWHnyCBtEcwejxJb9F1ghEsYS+5dOBhrEAXSepsT6XfoQYUWJnb/ngs1kFuCTePe1hxWk
        REKAV6KjTQiiRFni8oO7UCdISixu72SDKPGQOHBRGhIofYwSa78fYZvAKDcLYcECRsZVjGKp
        BcW56anFhgXGyHG2iRGcULXMdzBuOOdziFGAg1GJh9ch7XesEGtiWXFl7iFGCQ5mJRHe2x0/
        Y4V4UxIrq1KL8uOLSnNSiw8xmgJDciKzlGhyPjDZ55XEG5oaGRsbW5gYmpkaGiqJ83L8uBgr
        JJCeWJKanZpakFoE08fEwSnVwBji9Onbhao7zkavqi7OtJ16fIep8mZpvTkvLErWHttXlxQf
        pJJhNKVSx+vPxZeP+5gjuNVl9zkBc8Qes32n5ldGL3T/HjCzP0bJevI2D3bFhuL28j8rDAp9
        ekQ92X4dzAo6tefCjfS56qGbJzFV/Nz56dHTCzlTZrJubs640//8os8cBUaTq0osxRmJhlrM
        RcWJAN7dMwu+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK658J9Yg0/PtSzuz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FFcNimpOZllqUX6dglcGTenv2IsuCtScfr9VpYGxusCXYycHBIC
        JhLP26awdDFycQgJ7GaU+L30IxNEQlJi2sWjzF2MHEC2sMThw8UQNZ8YJTrWXWUBqWET0JLY
        /+IGG4gtIpAnsWnjV2aQImaB/0wS308+YARJCAuUScw/fZUVxGYRUJWYsPsqWJxXwEriztou
        dohl8hKrNxxgBrE5Bawltjx7CBYXAqp5ef4C6wRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNz
        i0vz0vWS83M3MYLDXktrB+OJE/GHGAU4GJV4eB3SfscKsSaWFVfmHmKU4GBWEuG93fEzVog3
        JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVANjSqFn9Jb/aj9Y
        8rMipSZNM1miulNt+xmTr/mWtSaXldJY1be87Kt7/FG2Uebn4t8W5bWl65kdzDdPd477NuOx
        8blr50sLF5106PwyReEu9+MZhULXDrcYn+Oq7WU9HSCjbhmVw7klLzdCKPGh5Swn241Gn24k
        GR85nTlX6yfnZ+53v5668LoqsRRnJBpqMRcVJwIA/klRfHcCAAA=
X-CMS-MailID: 20191220001759epcas1p3051f7916542b7234aac5273e0baab83b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001759epcas1p3051f7916542b7234aac5273e0baab83b
References: <20191220002430.11995-1-cw00.choi@samsung.com>
        <CGME20191220001759epcas1p3051f7916542b7234aac5273e0baab83b@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to remove the deprecated 'devfreq' and 'devfreq-events' property,
replace with new following properties
- Replace 'devfreq' with 'exynos,parent-bus' property
- Replace 'devfreq-events' with 'exynos,ppmu-device' property

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../bindings/devfreq/exynos-bus.txt           | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index e71f752cc18f..c6c2dd0e77c8 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -41,11 +41,11 @@ Required properties for all bus devices:
 
 Required properties only for parent bus device:
 - vdd-supply: the regulator to provide the buses with the voltage.
-- devfreq-events: the devfreq-event device to monitor the current utilization
+- exynos,ppmu-device: the devfreq-event device to monitor the current utilization
   of buses.
 
 Required properties only for passive bus device:
-- devfreq: the parent bus device.
+- exynos,parent-bus: the parent bus device.
 
 Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
@@ -374,48 +374,48 @@ Example2 :
 	in exynos3250-rinato.dts is listed below:
 
 	&bus_dmc {
-		devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+		exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
 		vdd-supply = <&buck1_reg>;	/* VDD_MIF */
 		status = "okay";
 	};
 
 	&bus_leftbus {
-		devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+		exynos,ppmu-device = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
 		vdd-supply = <&buck3_reg>;
 		status = "okay";
 	};
 
 	&bus_rightbus {
-		devfreq = <&bus_leftbus>;
+		exynos,parent-bus = <&bus_leftbus>;
 		status = "okay";
 	};
 
 	&bus_lcd0 {
-		devfreq = <&bus_leftbus>;
+		exynos,parent-bus = <&bus_leftbus>;
 		status = "okay";
 	};
 
 	&bus_fsys {
-		devfreq = <&bus_leftbus>;
+		exynos,parent-bus = <&bus_leftbus>;
 		status = "okay";
 	};
 
 	&bus_mcuisp {
-		devfreq = <&bus_leftbus>;
+		exynos,parent-bus = <&bus_leftbus>;
 		status = "okay";
 	};
 
 	&bus_isp {
-		devfreq = <&bus_leftbus>;
+		exynos,parent-bus = <&bus_leftbus>;
 		status = "okay";
 	};
 
 	&bus_peril {
-		devfreq = <&bus_leftbus>;
+		exynos,parent-bus = <&bus_leftbus>;
 		status = "okay";
 	};
 
 	&bus_mfc {
-		devfreq = <&bus_leftbus>;
+		exynos,parent-bus = <&bus_leftbus>;
 		status = "okay";
 	};
-- 
2.17.1

