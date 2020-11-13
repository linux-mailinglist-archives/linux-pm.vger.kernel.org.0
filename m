Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4932B25D1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Nov 2020 21:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgKMUt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 15:49:29 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42309 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbgKMUt2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2020 15:49:28 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 87F8BC3C;
        Fri, 13 Nov 2020 15:49:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 15:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=kqEAbuX6RFEOm
        aBUZA4rnZqet7oQcQH598nORrV3rOE=; b=Lut6A8xIvD2R9Pp/ze3zg9ohRqRBV
        N0jDcUyvieYDpyVsrGzfrEJnZusl/g20xTaMPxHhHp44aqtsLj2NPAu6ktHCskte
        8SoQoDAVzDzd02kCkFpISFNvPjIbU84If5eyU7W1XKd6z3PtwzPqKqWrfLIgM8lZ
        TDsUC4QtA9fu+Ns6e9ZWDE/FAB7YoRniqKJA8a7lL/tukGv8atNJAlJz7bL1hIpi
        9yKuvm7EuwBoPaYD5Urx2lrnEqxaY1d2oI3oXhA9lhhYoAmhAUeNi/X3g8UIX07i
        JwE0kpn91vWvo0GofiGsz0DRXqWCnqzMRzPFYDfUiZWP/OrYS5Br3xK1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=kqEAbuX6RFEOmaBUZA4rnZqet7oQcQH598nORrV3rOE=; b=QnVLINfJ
        wEEKv1i64HHIztKGfiYXpW6qH5B2gQ3+LwomQS12q59F2cJbmeD9jzOIbauaRdsZ
        kYVLi+epnV218aChRMGINRsZhiVHk2TbDhM4l2j7/J7c3B36KUhY14sbeSIIcA/o
        4gsM6vO/nOr4HKIwc4RmIaFEHZf8fRmrm0mQ0/WqAm0neSG7SZfMUPkDkjRHyzfv
        dSKjJYfr4JL/2YDdqvgBgoy6ChtjvB2lDxkl1Dkp8scUbIksVwmq51FqQUVJRyhn
        xKrBJNmKqfq8CajNovP72y6FvLqdWdbYQZFrU/b55MYPmH1xIAfS90ZjJx+kD5u8
        fas+S4vuuLDleg==
X-ME-Sender: <xms:VvGuX9wVkkCWve4XN8H1bHgoId7y_WihmJzdT8m9hJy8EuznWBeCKw>
    <xme:VvGuX9QSnfToiO1u-J3e_KEHktqXGlCzCx0i9hf59UT-3Uj19PjeB31dl6G-9KfgA
    GZVTrGXnQ-ZKy_6oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvhedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepkedvleetffdviefgffekhedvgfdtgefhledtffeukeefkeetffevvdej
    hfethfffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepieejrdduiedtrd
    dvudejrddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:VvGuX3XUm3AWrwMVF12Vu8sO2tMZU4dt52Vv_BVLklTrCk9NJSnSrQ>
    <xmx:VvGuX_j_-YmbhIKJPrMwQg6oc--Z2StzvqaVJWXlZ2zFPOBSZeS5HA>
    <xmx:VvGuX_CQTqDgpJ1CRLEETVc9x9l_t696djBJVnPoBx-_VNc1-qYZqQ>
    <xmx:V_GuX68pDRSpIqulq2aOXPpVkN76JtWBdtOBIL7oB576tCFVVupVvQ>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 92B993280060;
        Fri, 13 Nov 2020 15:49:26 -0500 (EST)
From:   Andres Freund <andres@anarazel.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andres Freund <andres@anarazel.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg PCH.
Date:   Fri, 13 Nov 2020 12:49:16 -0800
Message-Id: <20201113204916.1144907-1-andres@anarazel.de>
X-Mailer: git-send-email 2.28.0.651.g306ee63a70
In-Reply-To: <2fd3733b-ed67-80e0-7b27-8e3c421eeb9c@linaro.org>
References: <2fd3733b-ed67-80e0-7b27-8e3c421eeb9c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I noticed that I couldn't read the PCH temperature on my workstation
(C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but had to go
through IPMI. Looking at the data sheet, it looks to me like the
existing intel PCH thermal driver should work without changes for
Lewisburg.

I suspect there's some other PCI IDs missing. But I hope somebody at
Intel would have an easier time figuring that out than I...

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Tushar Dave <tushar.n.dave@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20200115184415.1726953-1-andres@anarazel.de/
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 drivers/thermal/intel/intel_pch_thermal.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 3b813ebb6ca1..7785e05f46f0 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -26,6 +26,7 @@
 #define PCH_THERMAL_DID_CNL_H	0xA379 /* CNL-H PCH */
 #define PCH_THERMAL_DID_CNL_LP	0x02F9 /* CNL-LP PCH */
 #define PCH_THERMAL_DID_CML_H	0X06F9 /* CML-H PCH */
+#define PCH_THERMAL_DID_LWB	0xA1B1 /* Lewisburg PCH */
 
 /* Wildcat Point-LP  PCH Thermal registers */
 #define WPT_TEMP	0x0000	/* Temperature */
@@ -276,6 +277,7 @@ enum board_ids {
 	board_skl,
 	board_cnl,
 	board_cml,
+	board_lwb,
 };
 
 static const struct board_info {
@@ -301,7 +303,11 @@ static const struct board_info {
 	[board_cml] = {
 		.name = "pch_cometlake",
 		.ops = &pch_dev_ops_wpt,
-	}
+	},
+	[board_lwb] = {
+		.name = "pch_lewisburg",
+		.ops = &pch_dev_ops_wpt,
+	},
 };
 
 static int intel_pch_thermal_probe(struct pci_dev *pdev,
@@ -415,6 +421,8 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
 		.driver_data = board_cnl, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CML_H),
 		.driver_data = board_cml, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_LWB),
+		.driver_data = board_lwb, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
-- 
2.28.0.651.g306ee63a70

