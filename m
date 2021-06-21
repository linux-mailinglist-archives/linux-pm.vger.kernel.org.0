Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BA3AF537
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFUSnc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 14:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhFUSna (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 14:43:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9989C061756;
        Mon, 21 Jun 2021 11:41:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u13so12508278lfk.2;
        Mon, 21 Jun 2021 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCjRGBTH8ADpERadaop92tDPR/QT7QNlg1YlaywmJB0=;
        b=arLaxeAmpb8C6Ar+P13BxH6GG1GYxUiibPri0MWT/fm4bbT4x/00xdAtWKQgpRIj8Y
         rw1/mMn//cZZQXMLx8Gs+k8czUom2uU3yJ0tGt0W8iLU+RGk72Ypm4jfDNjVxMTQBQhd
         rAOeeTx3HIEWxdm0rtys54AecEKAi6DbAI2gULX3RdenREh825oVeYUpkN20qJVHzDIy
         Ot2M3ZYm65G8+WjccAI89xD6lYm4V+rArO8nwQdMRpSQDXsN8DmomzkBBDXM36uO+zWJ
         cLtcT9+7Emzl9cjdu0jfrqFJw5K6JhhF9fTMMaMGpbspD0LgJuz6p/8x2fvget3sPk03
         zWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCjRGBTH8ADpERadaop92tDPR/QT7QNlg1YlaywmJB0=;
        b=oFrunvkLXws84G/HAfk4IYQKLkftUsHZwGXUYhoOY4kq1Pu2R3i/R+Ux3pNciwrGFn
         H24tHD+LdOBMu+NEi0FxWiiiVnvByjiHid/ErFVIS77hS/r338lMNTUBEu3uMFDxhIzP
         bsK5sg0yySNNMeNB81822+zi326wFLmIHJevpXJ+VwKblTdokrsmG2KGM3o1gKqHbpdA
         7WHX164pKWvjAQzONseH5jt6F1DfZ23EVRvh2z/j5Z/I21NkW8kNvaTn50wA6WWjgI3x
         bk7ciKR/cnP10TWxKu2Rxe+twLO3KEE8GP900rzx6RGzGYHk7UytHRCKG+1+KapvzJyw
         L6Wg==
X-Gm-Message-State: AOAM532o4aTQtykpGSZ/kzNggZDBtoR+E5hddfPBGiCwQzIm/F4vAKpk
        Zgqug9iQl+cPIh9Pls/VLYc=
X-Google-Smtp-Source: ABdhPJwNY1Em83gAncrjMb32cXw0579K8DBHoqShynYRhmbuf57atwgnXK8gXLV7TcmHL8lcre8NbA==
X-Received: by 2002:a05:6512:13a8:: with SMTP id p40mr15338234lfa.14.1624300873109;
        Mon, 21 Jun 2021 11:41:13 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id y22sm1950843lfa.145.2021.06.21.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 11:41:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 0/2] Support temperature trips by HWMON core and LM90 driver
Date:   Mon, 21 Jun 2021 21:40:56 +0300
Message-Id: <20210621184058.4110-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

It's typical for embedded devices to use LM90-compatible sensor for
monitoring of CPU core and skin temperatures. The sensor is often
used by thermal zone that performs passive cooling and emergency
shutdown on overheat, hence it's more optimal to use interrupt for
a faster notification about temperature changes. Thermal framework
provides set_trips() callback for programming of temperature trips,
let's support it by HWMON.

Changelog:

v3: - Improved patch that fixes integer overflows by fixing the hysteresis
      underflow and improving the commit message, telling that min/max/crit
      fixes are only related to the LM99 sensor. Thanks to Guenter Roeck
      for the suggestion.

v2: - Reworked set_trips() by making it generic. Now callback invokes
      the min/max temperature write method directly, instead of using
      additional new hwmon callback. This was suggested by Guenter Roeck.

    - Added new patch that fixes integer overflows in the LM90 driver.
      The fixes are necessary for supporting set_trips().

Dmitry Osipenko (2):
  hwmon: (lm90) Prevent integer underflows of temperature calculations
  hwmon: Support set_trips() of thermal device ops

 drivers/hwmon/hwmon.c | 32 ++++++++++++++++++++++++++++++++
 drivers/hwmon/lm90.c  |  9 +++++++++
 2 files changed, 41 insertions(+)

-- 
2.30.2

