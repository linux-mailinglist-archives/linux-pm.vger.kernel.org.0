Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52626E754C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjDSId4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 04:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjDSIdz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 04:33:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55116448A
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 01:33:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so1010228wmq.5
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 01:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893228; x=1684485228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C41B6yV2DJm6e0BljcJPziM6mJfMowYxUum5pceV41s=;
        b=uUjaFebkViAcB5GlgI0TxnmKtBjlyHFn/R6izh0Gg+8XmTOW3wCws0gJS6syvgTReO
         1Za8uNuElZNYpk6Rz+PG0VE+lsVTmRQ/uSCIm6aP06da6p9hWElRYATrvDPejdDM4nwm
         sOQmMbIj8491eDvxH44mDH6a4Dg9o5X1cjUf4Lu9SQBvNzU4wp3y9jtAG7MpdCBwZ3O6
         /TtvcXiGR0trp+DS6vhvIojBWAzpvLR+S0Gmg8F4pHcE12STOK4FHPpzOLBXFxN+ml6s
         UyCqlMLqoBP5CZepRpDMWTMcsO2mlrDlNkFSNlKmKtZVQCl+ecC7pFB/IzaHy2y8JwX7
         2NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893228; x=1684485228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C41B6yV2DJm6e0BljcJPziM6mJfMowYxUum5pceV41s=;
        b=DJVuVowJiGI5b26+6/BwYriyudZKLVhJfnDBoXuJ3iZxkzcGAXRiXJ9LPm4gHx/GsM
         P1VbZKJSTQF9eCX7Qc5qJZvZ/hPA5ZRJSCwT3Vo6VpWmwT1hhlFFSsVJ51HpzXoSPrNg
         VQkQ+IA8/w8I+ydIFJ1RRu+FoP6N7W94YZ2tn/7QMQu5aKOqisNdF9DNr4KDhjgk2tYX
         my4Jfb6c1LYCb7LMC+E1Pi8PC9YizfU34adKy7LoK3DUsZjqUwQgxG+NJidPYZR9KSBh
         Ov1HJG/eWuD81e7+FlaLW+3IT2yhZB2P865lbcX0SdgTTTJeflHtjDkW5rSepNRiA5KX
         C5vg==
X-Gm-Message-State: AAQBX9coguKVAnKFBWD3bFRbP+KlTi0bYost1xNiKQYBOYY/M3798g56
        3+Ibz/0XKWyQl65j7vWTCdZ1EQ==
X-Google-Smtp-Source: AKy350ZALBs5FVUlKysuCSOzozRkBp5mf5W7ytrLdB4Oj6YB4nBUU3r4ksnFVSFjUFX7w2g1lNBD3A==
X-Received: by 2002:a05:600c:2184:b0:3f1:82a0:1993 with SMTP id e4-20020a05600c218400b003f182a01993mr21210wme.21.1681893227757;
        Wed, 19 Apr 2023 01:33:47 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a794:9fb2:29fb:606d])
        by smtp.gmail.com with ESMTPSA id s5-20020a1cf205000000b003ed1ff06faasm1442033wmc.19.2023.04.19.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:33:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 0/6] Thermal zone device structure encapsulation
Date:   Wed, 19 Apr 2023 10:33:37 +0200
Message-Id: <20230419083343.505780-1-daniel.lezcano@linaro.org>
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

The thermal zone device structure is defined in the exported thermal
header include/linux/thermal.h

Given the definition being public, the structure is exposed to the
external components other than the thermal framework core code. It
results the drivers are tampering the structure internals like taking
the lock or changing the field values.

Obviously that is bad for several reasons as the drivers can hook the
thermal framework behavior and makes very difficult the changes in the
core code as external components depend on it directly.

Moreover, the thermal trip points being reworked, we don't want the
drivers to access the trips array directly in the thermal zone
structure and doing assumptions on how they are organized.

This series provides a second set of changes moving to the thermal
zone device structure self-encapsulation.

The ACPI and the Menlon drivers are using the thermal zone's device
fields to create symlinks and new attributes in the sysfs thermal zone
directory. These changes provide a hopefully temporary wrapper to
access it in order to allow moving forward in the thermal zone device
self-encapsulation and a Kconfig option to disable by default such a
extra sysfs information.

Changelog:
	v4:
	- Encapsulate extra sysfs information inside a function for
          ACPI but remove the Kconfig option
	- Encapsulate extra sysfs information inside a function,
          create the stubs and put that conditionnal to a Kconfig
          option for Menlow
	v3:
	- Split the Kconfig option to be driver related when disabling
          the specific attributes
	- Use the thermal zone's device wrapper to write a trace in
          the pch intel driver
	v2:
	- Add the Kconfig option to remove specific attributes
	- Add a thermal_zone_device() wrapper to access tz->device

Daniel Lezcano (6):
  thermal/core: Encapsulate tz->device field
  thermal/drivers/intel_pch_thermal: Use thermal driver device to write
    a trace
  thermal/drivers/acpi: Use thermal_zone_device()
  thermal/drivers/menlow: Use thermal_zone_device()
  thermal/drivers/acpi: Move to dedicated function sysfs extra attr
    creation
  thermal/drivers/intel_menlow: Make additionnal sysfs information
    optional

 drivers/acpi/thermal.c                    | 47 +++++++++++++++--------
 drivers/thermal/intel/Kconfig             | 11 ++++++
 drivers/thermal/intel/intel_menlow.c      | 18 +++++++--
 drivers/thermal/intel/intel_pch_thermal.c |  3 +-
 drivers/thermal/thermal_core.c            |  6 +++
 include/linux/thermal.h                   |  1 +
 6 files changed, 67 insertions(+), 19 deletions(-)

-- 
2.34.1

