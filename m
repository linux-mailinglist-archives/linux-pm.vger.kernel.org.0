Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CF723DFAC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgHFRvk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgHFQcI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:32:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0258C0F26C7
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 09:31:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so8385114wrs.11
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UeSaeFBmaX2UOS8vhf5MdyTixeaMCetcbpgjFTLJmfg=;
        b=c/AghX40N+5md1YLT5QwCUuxicFBpduiPvQLgeJIBCTUe/0RUdBrQNPaaahVmlPoBW
         Eb1LQr9nje/4ow0B21v8Y0G10Ef4553v81DuNXrdFAEGBMyIaXrrkkwqfdFZVovnI5kG
         SOHYw2KE0OCW+OvE6SlVyV5jjdEiUXPiOKB1fCCkuALyca1Urr66LIth/I7g7iwK5Em6
         eQDiyXY+3KIFlzHJp7yvzEj4+93pp+DXGd4i/qhRsjabpNdhkFQhL7k7ior5uQm9sFIe
         iD9uR4m9xNgEtajOZ260W45eOKiBoL/r6VBV7vLdFGc2/TwTrMy5LE+bDoonA0BdUfMf
         /PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeSaeFBmaX2UOS8vhf5MdyTixeaMCetcbpgjFTLJmfg=;
        b=qnYFNZmTSJNYWhsHlb/VGeNaq1umqD6LS+IQfyPxinqvdqvP5ri7qKTNzl8saEba5J
         i7aNS9Wj5gI8NZjgKh8IcYSTt6507i66qdNu8+fONZCKU3KYKfywaBZOr0qjCnn/e3bP
         JsiZFEDcEdxuBieZ1f4nlL/J3Mr5Pj45u4opE7mEUx3h9neCIRDyVZp9FthP0U6ck5Ra
         d96n5XOdi4WRIc4rFngG2WDQC4mr/zdSXMMzmHRFQDpeWMoOGqQgX+T4yfrHC2L4fqm6
         +j6KP5/9T5k5JnR02otjQBbuCo3m8io6AX4NMKAxVjzuAqEqe+jnoIKhgWHSDf6xPvw8
         aBAg==
X-Gm-Message-State: AOAM531ZEGNFAiC9B9HBilzXKyA9QM85w1wD0xLLZ6czJtPuED3mlmNc
        3VqKSdrAf8mglpAR8xDN82OY7u6LkeU=
X-Google-Smtp-Source: ABdhPJzF+qEtbxy0Prt75MMumjbxAWyjUEH4K5XMd0aIV/cqwRkDKfESNT3Wwyv5UWulYZyvkpM8/Q==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr8016753wrx.310.1596731492173;
        Thu, 06 Aug 2020 09:31:32 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:31 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: interconnect: Document the support of optional path tag
Date:   Thu,  6 Aug 2020 19:31:21 +0300
Message-Id: <20200806163126.22667-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's document that we now support specifying path tag information in the
arg cells of the 'interconnects' DT property. This information would be
populated when the xlate_extended() callback is used.

Specifying the tag in DT will allow the interconnect framework to do the
aggregation based on the tag automatically. The users can still use the
icc_set_tag() API if/when needed.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 6f5d23a605b7..138c544c8c8c 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -19,7 +19,8 @@ directly.
 Required properties:
 - compatible : contains the interconnect provider compatible string
 - #interconnect-cells : number of cells in a interconnect specifier needed to
-			encode the interconnect node id
+			encode the interconnect node id and optionally add a
+			path tag
 
 Example:
 
@@ -44,6 +45,10 @@ components it has to interact with.
 Required properties:
 interconnects : Pairs of phandles and interconnect provider specifier to denote
 	        the edge source and destination ports of the interconnect path.
+		An optional path tag value could specified as additional argument
+		to both endpoints and in such cases, this information will be passed
+		to the interconnect framework to do aggregation based on the attached
+		tag.
 
 Optional properties:
 interconnect-names : List of interconnect path name strings sorted in the same
@@ -62,3 +67,20 @@ Example:
 		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
 		interconnect-names = "sdhc-mem";
 	};
+
+Example with path tags:
+
+	gnoc: interconnect@17900000 {
+		...
+		interconnect-cells = <2>;
+	};
+
+	mnoc: interconnect@1380000 {
+		...
+		interconnect-cells = <2>;
+	};
+
+	cpu@0 {
+		...
+		interconnects = <&gnoc MASTER_APPSS_PROC 3 &mnoc SLAVE_EBI1 3>;
+	}
