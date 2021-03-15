Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3233AD57
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 09:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCOI0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 04:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhCOIZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Mar 2021 04:25:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBDC061574;
        Mon, 15 Mar 2021 01:25:43 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d21so43752pfn.1;
        Mon, 15 Mar 2021 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dRlZk3ytm/S+WmOL16Dr65U1HZgXL+WYJoDthUJhHBo=;
        b=YIbN2o0CkR76K/h9pF1Ny+Slfx5lgCVjlesch5gY4YDZC0PUdWP5GJQ5XjZ2z267sB
         nyXOXjahFH2L0YClDnmMvc0n1Ll2FHA/cvlBiJQmVEK1HR+xCssIZ0sW1f9PHUGMYpPp
         PWejd+V7YTsiPOSyYO2i+uG1YXjdkN/TZBKdxbl2EkOgFxLCzaWL+V2RHZLBVLSbJlt0
         783rcoeLR7WBOxyZ/X3XD3iX6MNPqvQqRmGXGbSfW6rZOECHxlh5GKqBbkVWmyqhPEP+
         dX4Dj2Q6zQ6ywMhs3Fd5SNYxc26e7akHJdTD4JN7v6Jz5lg9heZlXNUs1B0zsqxeVnqR
         1yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dRlZk3ytm/S+WmOL16Dr65U1HZgXL+WYJoDthUJhHBo=;
        b=oGNwfFtx9nZlYIp642NKL4ysDctLS2nSD9jN1dOg7cg0aQ+T8R+ly2gh1Tni4ptHJP
         sz/n/W1DyDb6Mgc6LKjX4Jeu7gfDuYarX+iJYNXOYxeXG+tK2cKdDkxxV2G9uF9fKEtn
         3LIQNwRwgDYJKUO0dA4bfJCsaJvGF2+T9aL/VkS9eNhTrn80ftYkLroHMeNVYZaWcs6v
         O8KiHwl2A85lrO6nstGZPBiSA6mmM6V4I/oHcyQzV9IE6HMNR5zyz+1LQ33496SjyPx4
         WchbsM4Ed2l8Gi7aYmGsNWEDxBi5a1HXIv6OWVDCmexNDx8wSOlLTQeDIcsv8/elb7H/
         euow==
X-Gm-Message-State: AOAM531wz/cL+xrlGCHUcPTk7lzzvtNt/Ni9WBXeUHus3LDIPA21do+j
        fXMrjpNiGGsYQdGcN3Qz+Sw=
X-Google-Smtp-Source: ABdhPJyYdxOZPAIxudMIm7Vqi7IjnsQBSst4Rz6Odef0gFSsYnNhKJItUjAfygiqC8KtfQQ4SDyO/w==
X-Received: by 2002:a63:54:: with SMTP id 81mr22802983pga.410.1615796743535;
        Mon, 15 Mar 2021 01:25:43 -0700 (PDT)
Received: from bj04432pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v18sm13292837pfn.117.2021.03.15.01.25.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 01:25:43 -0700 (PDT)
From:   gao.yunxiao6@gmail.com
To:     lukasz.luba@arm.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        "jeson.gao" <jeson.gao@unisoc.com>
Subject: [PATCH] thermal: power_allocator: using round the division when re-divvying up power
Date:   Mon, 15 Mar 2021 16:25:37 +0800
Message-Id: <1615796737-4688-1-git-send-email-gao.yunxiao6@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "jeson.gao" <jeson.gao@unisoc.com>

The division is used directly in re-divvying up power, the decimal part will
be discarded, devices will get less than the extra_actor_power - 1.
if using round the division to make the calculation more accurate.

For example:
actor0 received more than it's max_power, it has the extra_power 759
actor1 received less than it's max_power, it require extra_actor_power 395
actor2 received less than it's max_power, it require extra_actor_power 365
actor1 and actor2 require the total capped_extra_power 760

using division in re-divvying up power
actor1 would actually get the extra_actor_power 394
actor2 would actually get the extra_actor_power 364

if using round the division in re-divvying up power
actor1 would actually get the extra_actor_power 394
actor2 would actually get the extra_actor_power 365

Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
---
 drivers/thermal/gov_power_allocator.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 92acae53df49..2802a0e13c88 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -374,9 +374,11 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	 */
 	extra_power = min(extra_power, capped_extra_power);
 	if (capped_extra_power > 0)
-		for (i = 0; i < num_actors; i++)
-			granted_power[i] += (extra_actor_power[i] *
-					extra_power) / capped_extra_power;
+		for (i = 0; i < num_actors; i++) {
+			u64 extra_range = (u64)extra_actor_power[i] * extra_power;
+			granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
+							 capped_extra_power);
+		}
 }
 
 static int allocate_power(struct thermal_zone_device *tz,
-- 
2.28.0

