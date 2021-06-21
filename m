Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD03AF76F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 23:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhFUVfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 17:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUVf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 17:35:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD71C061574;
        Mon, 21 Jun 2021 14:33:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x24so32490758lfr.10;
        Mon, 21 Jun 2021 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=579gLtrKmj9LeHVTUb5CxdaKhIK6jXKOT58NWZYvBoQ=;
        b=Uo5Xt/Y/awxh0fplVC4cZ9jtNRkmDEEya5SASjoOKICTZCafHM6c+iqKcL+D87QRmT
         J4g6XbCO+pLZOcKU/BV7Yuhc+JNeSZvB68KPXdiyZXieKCnrY4WjjFrYUnnb8PwL6t7Z
         pudoSDLJK6J8AATEHIUFcxL4fDINM5N0jBWtS131Rn0u+RWCEOJKd5sVgMMGxIrMz/a2
         jLK6LqBiTAP7FZJyhbguH08qOdokn/FR4voDBCuFE3yE+5qycWHpchFwcoWIXeFwVGNT
         Be4dFFUCJ7maZ+C/1RNlYsCenaDO7LKHOUHQPr1u6Ba4yxfTXcRRbhc9TYhRtJwCqTW0
         sqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=579gLtrKmj9LeHVTUb5CxdaKhIK6jXKOT58NWZYvBoQ=;
        b=sUigXSN/4DxopnJfd69z8+kSA6PsHbf5rCuYdzEVx421sSX3TfS6Cz4avj4QYN9djv
         e5g4yvwVIF7i0mNRuJyCOumJWW5TAME7Tqz1921NSgOZHh0yqbsELQcQqrBf2baiiRG3
         qYY+06D4l3BqhU8eYaWgsD7bywgDj67/q7KI7RJ+wljEcpDuemAX65r5mMnhEVONxlCI
         jyo4Tp7jvsB17qrC1brcVBBpwCMza+jv/318/7HgbqhMl0dfibaIpbGt0oFbZjRAU1GJ
         YuHRbmdNnsJaivTvbazqQBgrIkRbGTgvvWJSFLNfJDD59AQhWNHSfRoDpI7w0ImeDACB
         eHIg==
X-Gm-Message-State: AOAM533DwhGRhxyJD9Y2X/84xE+EPuWKIg8de7k3z5380qNeI128e3kB
        df4uNQsdpUL160mhnrs396A=
X-Google-Smtp-Source: ABdhPJwR3j/Y4cDfcsMfqkIiQuh1LJxYxDkY0r9F8r6Rj/MRpyhGvROEAmqQeVMK2HS71xkAmKmLew==
X-Received: by 2002:ac2:428d:: with SMTP id m13mr248778lfh.236.1624311192392;
        Mon, 21 Jun 2021 14:33:12 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id u10sm1074722lfg.240.2021.06.21.14.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:33:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 0/2] Support temperature trips by HWMON core and LM90 driver
Date:   Tue, 22 Jun 2021 00:31:51 +0300
Message-Id: <20210621213153.28247-1-digetx@gmail.com>
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

v4: - Extended commit message of the set_trips() patch, saying that
      it has no effect on sensors that can't set trips. This was
      suggested by Guenter Roeck.

    - The channels are now iterated starting from 0 instead of 1 in the
      set_trips() callback. This was suggested by Guenter Roeck.

    - Moved out declaration of the err variable into the upper scope of
      set_trips(), like it was suggested by Guenter Roeck. The checkpatch
      normally warns about missing empty line after a declaration, but it
      couldn't detect this case here.

    - Replaced the err < 0 comparisons with err != 0, since write callback
      of the chip ops isn't supposed to return positive values. This was
      suggested by Guenter Roeck.

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

 drivers/hwmon/hwmon.c | 33 +++++++++++++++++++++++++++++++++
 drivers/hwmon/lm90.c  |  9 +++++++++
 2 files changed, 42 insertions(+)

-- 
2.30.2

