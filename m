Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224D074B80B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 22:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGGUhx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjGGUhw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 16:37:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266E1986
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 13:37:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3141c8a6f30so2409619f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688762270; x=1691354270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g4HspQwLyN/0KAF6AN2JANGXDGJX10XlJGv3FkdFNB0=;
        b=Ba1f/ZqrWpPeZua5hrhiX1yu+18Aq/SUp2ZUZdpBJ9lbeMsUD1LejL8c4xqHz6oJhA
         Sl3MPw3LaQ/r4Uit3N7tIILLyCcUQ+5bnpQHEhHYKnm01O4xNYg88/8QuqfKcFm8K18R
         lBVLbMceymzB8wFF4PFMP0gJCiOfJz7PVNFg/VJExJuv1ZAjEW6w7ciu7TNMddiWk8Tv
         nRkCaSHa8eKcHmtvjuk1vONVTJrWPITKZzlEnoHtbBUYFNvtKmjvhjaOn4lN32ErSU5W
         9ivpVJHLkaDUtJSBn+xqNdDYEGxGjNJ7lSaRl9v0R46kxU4UNbvFP8W7Q37Pjg/T9h1B
         wqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762270; x=1691354270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4HspQwLyN/0KAF6AN2JANGXDGJX10XlJGv3FkdFNB0=;
        b=bvNT0Qx+woj3Xba8bHz1s9GPAE6cPa2fAfgLEMRig/cQF4FwlrzcdXJRQaw380J9X7
         8lQ7AF6TOh7TYdGf2Qe++Ingfu+ybpdCe2IEwsIRg66MMP40XL29j12DWsTf5K4Pjp1W
         WaFAn3blWr4AsjMILW37gQCfHt2qZtXl2cv3ea8APteZzHTdDMROs4JxffJuC7KQ9sHC
         n5C5iLaBeQ3MJXAJVTjJ66CQDp+ZDhpBWwg0+y7f3jPeGm//+gAFxzZUHdf2/LEkmGC5
         tBYO1FrZqM7tYcBQ+POfb/lK3ab6cW9xPLtB3Tim9IUEcByXOnVvVbKWfW0LhOSH2sW5
         6BJw==
X-Gm-Message-State: ABy/qLbEBzsAbYrdg1eFryzDgT+b97PlZcZYSkUXjuOt8+S927Z7SkAX
        bX+V7r1aTY9KAp/ZPpvGHICxiV5kU2QG2E0ixiY=
X-Google-Smtp-Source: APBJJlF47znCRWOhugTz/uinATCfMNp8DhqRHIDR/KHzbL3FP/enIaX40ctSi4pY9QKXNw62dK9fEg==
X-Received: by 2002:adf:ee51:0:b0:314:25d:c8f4 with SMTP id w17-20020adfee51000000b00314025dc8f4mr4949402wro.2.1688762269939;
        Fri, 07 Jul 2023 13:37:49 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b003143be36d99sm5260674wrp.58.2023.07.07.13.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 13:37:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: [PATCH v2 0/4] One more step to the thermal zone structure encapsulation
Date:   Fri,  7 Jul 2023 22:37:27 +0200
Message-Id: <20230707203731.848188-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The series provides more changes to self-encapsulate the thermal zone device
structure in order to protect wild accesses to the thermal zone device
internals, especially the trip points and the locks.

The first patch adds a macro to warn at compilation time if the
thermal_core.h is included in a file not belonging to the thermal core
code. One warning will happen with the nvidia drivers but this is in
the way to be solved.

The second patch reorders the headers inclusion in the core code.

The next patches makes the int340x drivers to use the thermal trip
update above and the different accessors for thermal zone structure.

Daniel Lezcano (4):
  thermal/core: Hardening the self-encapsulation
  thermal/core: Reorder the headers inclusion
  thermal/drivers/int3400: Use thermal zone device wrappers
  thermal/drivers/int340x: Do not check the thermal zone state

 drivers/thermal/gov_bang_bang.c               |  1 +
 drivers/thermal/gov_fair_share.c              |  1 +
 drivers/thermal/gov_power_allocator.c         |  7 +--
 drivers/thermal/gov_step_wise.c               |  1 +
 drivers/thermal/gov_user_space.c              |  1 +
 .../intel/int340x_thermal/int3400_thermal.c   | 44 +++++++++----------
 drivers/thermal/thermal_acpi.c                |  1 +
 drivers/thermal/thermal_core.c                |  7 +--
 drivers/thermal/thermal_core.h                |  4 ++
 drivers/thermal/thermal_helpers.c             |  1 +
 drivers/thermal/thermal_hwmon.c               |  1 +
 drivers/thermal/thermal_netlink.c             |  1 +
 drivers/thermal/thermal_of.c                  |  1 +
 drivers/thermal/thermal_sysfs.c               |  1 +
 drivers/thermal/thermal_trip.c                |  1 +
 15 files changed, 45 insertions(+), 28 deletions(-)

-- 
2.34.1

