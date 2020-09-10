Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16A2264404
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 12:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgIJK2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 06:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbgIJK1v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 06:27:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6ACC061573
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 03:27:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so4375448pfd.5
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZQZwXwRu53YKSXrfkUA0WjeNn/V21ZhpJY2/Y12QvI=;
        b=TzPt0pmdNspzQOTFKvx730AMrhJJADm6SbOatLVVciImg0+7g406SmECpp/TEcMqRk
         286/u47cu3OOeQjZ7+aCD7K2ITZwnS4UZBphCBBO8VqHPC+2sdgt2jbpL5G3Gub1kWuI
         9+oDszZ9EoGdzvisVMzMJPCPtuDYCqH3/GCiM62RQeEJ10KS1+Y+xCjkFR6M/WadeY9K
         C/QDyORxqjQN5FX5TLy4T7XMzAZTj9AGV6avnS+GY+ksFyO9AY3OmtdXb2BTGGQrCjkG
         ll3Cykr20wvPpmBg50/kGoK1zTizaFIWM2Q1FTnjyqpDm98rncC6qZIkvMW9w+D8hRPJ
         f+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZQZwXwRu53YKSXrfkUA0WjeNn/V21ZhpJY2/Y12QvI=;
        b=sxANyeQWgmdDfo3zWFKsrofqYPWEWV8a8av60QoQIBnOcPNDwnr98BVK9yeYv1uKda
         2L7Yu+T67ADpDnULiXwmLHM9oij3eChJJtkC/QvnqqGltzQ1/ZEv9w069T0RznGG8gcE
         UfuQoXF1EZ1JtDMDw8CVEtB0IMn8rCTsH+qwKzsKTLwLYIC+sqvx2jsJ+AkI+tMGJyfW
         vJ+GRqjtHt7zxMQ4E/Rqgs4X0Bkp+gt67e6TokldnorTB10AS7mK42YL1QxgIrjMGHwi
         0fb1L9ZQS0Q5m68Q2I0ksUXWds3puUXj9Iq6MflX1olH+Nq4wF8BkATw2FTlKOygc8lN
         wplg==
X-Gm-Message-State: AOAM533KwOEACPlQeqjUoMkHCyUAfJaTKpeRYyalV1AoJKeXHC4KH008
        ypewu2FnH1CNTgV0kb1aAiUuZg==
X-Google-Smtp-Source: ABdhPJwo5Opm062PHIrhNSfRQH8EwatTMoUC2rcPFPzEY+vMvxlwb0kB1iL/Zh9vB25/UPh/cJpcBQ==
X-Received: by 2002:a62:52c8:0:b029:13e:d13d:a10b with SMTP id g191-20020a6252c80000b029013ed13da10bmr4696466pfb.39.1599733669949;
        Thu, 10 Sep 2020 03:27:49 -0700 (PDT)
Received: from localhost ([103.208.69.30])
        by smtp.gmail.com with ESMTPSA id m14sm5392656pfo.202.2020.09.10.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:27:48 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
X-Google-Original-From: Amit Kucheria <amitk@kernel.org>
To:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] powercap: make documentation reflect code
Date:   Thu, 10 Sep 2020 15:57:46 +0530
Message-Id: <e40a76dbc4d17d0bc80daf95e259fcd6cc6d48e2.1599733531.git.amitk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up documentation of the struct members to reflect reality. Also
fixup a stray whitespace.

Signed-off-by: Amit Kucheria <amitk@kernel.org>
---
 include/linux/powercap.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/powercap.h b/include/linux/powercap.h
index 4537f57f9e42f..3d557bbcd2c71 100644
--- a/include/linux/powercap.h
+++ b/include/linux/powercap.h
@@ -44,19 +44,18 @@ struct powercap_control_type_ops {
 };
 
 /**
- * struct powercap_control_type- Defines a powercap control_type
- * @name:		name of control_type
+ * struct powercap_control_type - Defines a powercap control_type
  * @dev:		device for this control_type
  * @idr:		idr to have unique id for its child
- * @root_node:		Root holding power zones for this control_type
+ * @nr_zones:		counter for number of zones of this type
  * @ops:		Pointer to callback struct
- * @node_lock:		mutex for control type
+ * @lock:		mutex for control type
  * @allocated:		This is possible that client owns the memory
  *			used by this structure. In this case
  *			this flag is set to false by framework to
  *			prevent deallocation during release process.
  *			Otherwise this flag is set to true.
- * @ctrl_inst:		link to the control_type list
+ * @node:		linked-list node
  *
  * Defines powercap control_type. This acts as a container for power
  * zones, which use same method to control power. E.g. RAPL, RAPL-PCI etc.
@@ -129,7 +128,7 @@ struct powercap_zone_ops {
  *			this flag is set to false by framework to
  *			prevent deallocation during release process.
  *			Otherwise this flag is set to true.
- * @constraint_ptr:	List of constraints for this zone.
+ * @constraints:	List of constraints for this zone.
  *
  * This defines a power zone instance. The fields of this structure are
  * private, and should not be used by client drivers.
-- 
2.25.1

