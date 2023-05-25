Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6665710DDA
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbjEYOCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 May 2023 10:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbjEYOC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 10:02:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551419C
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 07:02:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30a95ec7744so2114916f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685023319; x=1687615319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uj+6V8WW91QqsY0pMlDoAGkPT97dYdNbbS5RZJ59Y6I=;
        b=ZvmorFKt6WL/TA7rE4Ghpw2SPGWwMUIszaCeZ6h1o2iZEcGC5lgjeXlIG36SHVmeL+
         1j8PGE7UWHKCGtJZ1NlOyTnw1CDE7RZSz/4mCd3eEWmS5bDEEBzsI+GUOO4zP9gaI9wz
         BHvNtvXQ3N4JvQDf6LUrRxQ4IXrn7YukYCw3Ick9XZPL56CDX/XsyAiwXhf0CtFBX1D0
         zkhWKNnRaObFEguh/yJpDtax237nOTqjkIuPElJeNzvh7MCeb+KFAK0ceagmCZRzgjWm
         gYydKF6B037cdD2Q62omm+rRsnTiYNIsfOG/qXl1YGAxI14+b7e4FBeIxGqzkNCnN7WS
         BFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023319; x=1687615319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uj+6V8WW91QqsY0pMlDoAGkPT97dYdNbbS5RZJ59Y6I=;
        b=LU1ZrsnCV+/IYr+ZTdY84HS4yKamegyQYFdL58hPbLLV1JkRgdChGOstsVYqwdec5n
         2oamdGYw5K6sqW0GFmN+NQDFt5uO45R5kBE2NFFaykIiQModB4aSQBg9eN/CxUemdFXY
         cfkmOb9mBFvsjp5amqj3SI9N9agiuhYsgGjSn/qKtMhpkz4welfK60N/NZSX3RdXXXkx
         ES30ZPovpq0UFpG7cVl+EvPSi1/+0JS1Z92YYA37MfK8q+ajbyFUYgX+3TQRTr9L2pdz
         QE4UeFYBklIPGSmxr42BhDKWVDqUpohdLFxrzS0MCqMNj0QkLU8WZD0i/4MHQLUTbrSi
         zDFw==
X-Gm-Message-State: AC+VfDywXHolq4Qo/9l7IJ7DssEOqTJ3ceZ5vVGVQhxc8VxtEfn0AV//
        Q7V1tstwct6BP7kD0n5i6DrpKw==
X-Google-Smtp-Source: ACHHUZ6PIC4qrJOn8gtrGlEafL9LZI+9B8weySI11B47JNYd4x0mVAVyoScC6ofRuHP41Wg7VfibqA==
X-Received: by 2002:a5d:4d43:0:b0:307:8651:258e with SMTP id a3-20020a5d4d43000000b003078651258emr3008774wru.21.1685023319089;
        Thu, 25 May 2023 07:01:59 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdd44000000b003063176ef09sm1944866wrm.6.2023.05.25.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:01:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com
Subject: [PATCH 0/8] Finish thermal zone structure encapsulation
Date:   Thu, 25 May 2023 16:01:27 +0200
Message-Id: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
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

The series are the last changes to self-encapsulate the thermal zone device
structure in order to protect wild accesses to the thermal zone device
internals, especially the trip points and the locks.

Meanwhile the latest changes, a new driver has come via the network tree which
directly accesses the thermal zone device structure information and uses the
old thermal_zone_device_register function. The first patch does the change to
use the accessor and the new registering function. It is expected to have the
changes to go through the thermal tree along with the other patches.

The second patch adds a macro to warn at compilation time if the
thermal_core.h is included in a file not belonging to the thermal core
code. One warning will happen with the nvidia drivers but this is in
the way to be solved.

The third patch reorders the headers inclusion in the core code.

The fourth patch provides an API to update the thermal trips of a
thermal zone. This function takes care of the locking and the thermal
zone update.

The next patches makes the int340x drivers to use the thermal trip
update above and the different accessors for thermal zone structure.

Finally the last patch moves the thermal zone device structure from
the exported thermal.h header to the thermal core private header.

Daniel Lezcano (8):
  net/mlx5: Update the driver with the recent thermal changes
  thermal/core: Hardening the self-encapsulation
  thermal/core: Reorder the headers inclusion
  thermal/core: Update the generic trip points
  thermal/drivers/int3400: Use thermal zone device wrappers
  thermal/drivers/int340x: Do not check the thermal zone state
  thermal/drivers/int340x: Use thermal zone device trip update
  thermal/core: Move the thermal zone structure to the private core
    header

 .../net/ethernet/mellanox/mlx5/core/thermal.c | 15 ++--
 drivers/thermal/gov_bang_bang.c               |  1 +
 drivers/thermal/gov_fair_share.c              |  1 +
 drivers/thermal/gov_power_allocator.c         |  7 +-
 drivers/thermal/gov_step_wise.c               |  1 +
 drivers/thermal/gov_user_space.c              |  1 +
 .../intel/int340x_thermal/int3400_thermal.c   | 44 +++++-----
 .../int340x_thermal/int340x_thermal_zone.c    | 17 ++--
 drivers/thermal/thermal_acpi.c                |  1 +
 drivers/thermal/thermal_core.c                | 47 +++++------
 drivers/thermal/thermal_core.h                | 82 +++++++++++++++++++
 drivers/thermal/thermal_helpers.c             |  1 +
 drivers/thermal/thermal_hwmon.c               |  1 +
 drivers/thermal/thermal_netlink.c             |  1 +
 drivers/thermal/thermal_of.c                  |  1 +
 drivers/thermal/thermal_sysfs.c               |  1 +
 drivers/thermal/thermal_trip.c                | 79 ++++++++++++++++++
 include/linux/thermal.h                       | 79 +-----------------
 18 files changed, 241 insertions(+), 139 deletions(-)

-- 
2.34.1

