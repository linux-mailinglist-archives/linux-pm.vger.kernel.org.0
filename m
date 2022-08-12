Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE57E591139
	for <lists+linux-pm@lfdr.de>; Fri, 12 Aug 2022 15:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiHLNMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Aug 2022 09:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiHLNMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2022 09:12:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB0B74E0A
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 06:12:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv3so1175667wrb.5
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wVwOBZA0zq/Lz3Xu/BShwTW/TQe4u53rxqANn2qeajk=;
        b=KJfS8mejNCIL9EiGI6BGw8hT6IFR0d6MSBhFcCA08SvJREI2xiV8j/kNonVQXNTIo8
         LNWH5sbuWoVus02TDV4ONmn07hnkjBaeNYl3EyRqNjnIh/Rf/VBS/Z/z7NcEzP+QHn5y
         MxXfC5Wc0THQSnbBbATRz20mmZUmcIH9O1ZoS0CoSZCb3NHZk3umNCP8stSVEjd2rzf8
         KJ7DM5JFquhq88iiCs/05OOCzfToFehqwIKw7JVfXwmYWcSjQlxMLoMU2BngxZf+tPQN
         uFSnaxAt64E7czU8YC1Mc6GrPCNgm0WC6uqd3kghwhuRxxVbWFD3DrtCk2DUshKnto09
         oIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wVwOBZA0zq/Lz3Xu/BShwTW/TQe4u53rxqANn2qeajk=;
        b=Gtp1bZtJGqpQJyCNH/Qwk/71ah7vunbrluUE0NGm79hRGO4mahEgp/r4jVPleYIohR
         pzY1p3enREp89dpCrIfiAeIpKmImBtmg2oCFN7Vo6tZZtCxnvl63sLHFA17gz/noWbum
         0RAlX1l48GqlOPA5x7brvrjkFfjIIBmKmn0f+VgKjLzXLdcaaAoNEsrd3PBMAHSEJoaA
         zMs09wJXA5901BmuM4DyZKblJUCPgqCmOzS+bziIeiKpvb5IngIWHtBgu133xo4cEnUW
         jpbz35DoWaNNEAzYi2/6MIyU/MgmfCrugHmTPN0/mU8GpaELHC6W/WTMc6Xtlbzy+mgn
         Hjyw==
X-Gm-Message-State: ACgBeo3l+dU25Wgx6cAGhv9fQZdA2riQDFrhUFaSBpIQET4v/AQtIu48
        b5ONIMG0EMfrZ3C6ObuzkghbsQ==
X-Google-Smtp-Source: AA6agR4LQL9fSbM39ZGrili9KfncXZK8Cn1NLAlopW7/Y1EYnyUw5yvh9QpgoX6RFiabSoPbPd+emA==
X-Received: by 2002:a5d:47a5:0:b0:220:5985:6710 with SMTP id 5-20020a5d47a5000000b0022059856710mr2193212wrb.633.1660309932862;
        Fri, 12 Aug 2022 06:12:12 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id o36-20020a05600c512400b003a5317f07b4sm10698952wms.37.2022.08.12.06.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 06:12:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     m.szyprowski@samsung.com
Cc:     rafael@kernel.org, krzk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitk@kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] thermal/core: Fix lockdep_assert() warning
Date:   Fri, 12 Aug 2022 15:12:02 +0200
Message-Id: <20220812131202.1331238-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f1fb1d84-85de-f3c5-0212-fcf0e9c0ccd2@samsung.com>
References: <f1fb1d84-85de-f3c5-0212-fcf0e9c0ccd2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function thermal_zone_device_is_enabled() must be called with the
thermal zone lock held. In the resume path, it is called without.

As the thermal_zone_device_is_enabled() is also checked in
thermal_zone_device_update(), do the check in resume() function is
pointless, except for saving an extra initialization which does not
hurt if it is done in all the cases.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 50814009339d..dc8ff6a84df1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1438,9 +1438,6 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_POST_SUSPEND:
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
-			if (!thermal_zone_device_is_enabled(tz))
-				continue;
-
 			thermal_zone_device_init(tz);
 			thermal_zone_device_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
-- 
2.34.1

