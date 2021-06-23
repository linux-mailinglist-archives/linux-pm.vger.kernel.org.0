Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E53B12A7
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 06:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFWEZH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 00:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFWEZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 00:25:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE95C061574;
        Tue, 22 Jun 2021 21:22:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h15so1720153lfv.12;
        Tue, 22 Jun 2021 21:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T75ZiFQpoQ634G5OU7PgmJhvFeitTm6q8P6qqnQ5xXM=;
        b=Nxrg5H8/5SMeo73YmxK9Mq+d3r+kYdtPchv9mAlCPCMxnuNub8Vb1OEQtBHuCKQmPw
         VNz8NUfOlDvpFBH3Gx5d+VpcJODS2U9S7cOcBsOBtXGGUaSG7CcZuEhYHASDeAuY2l9s
         9mIYJjfi4MbTMASQJ2AuHkYQzPZ6L8fHCe+tI+AKSDM5onwutxp2wtCa3hXvPY4IB2nY
         eZXafSMqrTA5oiAa4Vzc1zdOQziqn4YXDMJfpsLNe9fN/sx1Lou7LRTwvROp0qbrtrRg
         aDclp/qsQlpPbsAt8b92L4zPvVUeTDUZlniFuFJjBkAwEIYMeT+hh+jR4PrgfFxS9jqp
         Sppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T75ZiFQpoQ634G5OU7PgmJhvFeitTm6q8P6qqnQ5xXM=;
        b=WXJWSyV/pJqJCIPt3nJi6rfKcqoyBwTemS539mZmOZtC3/Q+hwUzouGIO1X+iGjHDq
         gvQ5pgjQYGVvszuHWpBpEpKibduYTVvtcXO7I8cN+ASd/TqRLOW8jxQN/PbV5Wfiygud
         IW73aSLBU5VkoE8AGPW9H+DYOv62Pqd/RLE9feV8Syk2DTowF7ZToWuvC43e80BfvBHc
         arERoKJt1pHzQTB2seYItXstQUS6iURfdmX9ZH0fTPYwLy5AGjm1I/ow5LGWBxQef3uz
         b2Ml6/4bN58Kqgji9A/ymbl35uB4LGxNRtCJ103oOvb+rvHgDWfpsO0DzoSnUu7xKr/r
         TkyQ==
X-Gm-Message-State: AOAM531Ggfws3tH5mt2KAdgTMBc8fZAXHTJa/ursp5QN+He55Igo3Y8E
        EYPo7ah+5UA6ocVYjB2OK3U=
X-Google-Smtp-Source: ABdhPJwbmI+YvEVrS3BYpHPEd8GKZ/HXfTdebYBKwgqeeUycXQAmi1FI/+s5ZdYk0sN72DBFfQumOA==
X-Received: by 2002:a19:6a15:: with SMTP id u21mr562250lfu.309.1624422167172;
        Tue, 22 Jun 2021 21:22:47 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id c9sm174027ljb.22.2021.06.22.21.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:22:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 0/2] Support temperature trips by HWMON core and LM90 driver
Date:   Wed, 23 Jun 2021 07:22:29 +0300
Message-Id: <20210623042231.16008-1-digetx@gmail.com>
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

v5: - Factored out the !info[i] check in set_trips() and moved integer
      underflow preventions closer to the code that underflows. This was
      suggested by Guenter Roeck.

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

 drivers/hwmon/hwmon.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/hwmon/lm90.c  | 13 +++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.30.2

