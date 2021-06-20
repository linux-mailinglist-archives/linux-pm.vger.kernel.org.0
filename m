Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887A73AE09F
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jun 2021 23:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFTVRD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 17:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhFTVRC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 17:17:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920ABC061574;
        Sun, 20 Jun 2021 14:14:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j2so26706502lfg.9;
        Sun, 20 Jun 2021 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ur9GqO1cUKw8boYxBgD2FyJZ8eocwwLPxkyZhkcRVb4=;
        b=hAIupeLPEY7vPOCm+cMvVQKYBJbZLxsI41GFmTpVba987Du1fZGLkcDLKieVDUTyX6
         cUWh7TCdGjY1aEFQSwkGs1YCSccpnflVTv09TdOJoOyQGLVdKsxVaw1rR02t5UQRMQZH
         91XSCe3FAN4Hp/xcK7mZo+seAu4jJEVi89v+0PpHlErVvJPl9PHMMJhdnNlTdXh39oxE
         gNPUklC7MqNkuYoQsQg6kkeuD5z+efwsttBltT6juoWoaD3dGvCNqtMoYrAOYFCGcDnu
         M6jIKRSk+aXQJdDcKbjqjWx+v3lROoeU/0FFEZzk/rzSxMGbePlHrf2ZdTE5yiqQKhCv
         Eg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ur9GqO1cUKw8boYxBgD2FyJZ8eocwwLPxkyZhkcRVb4=;
        b=q+Fgccb1Si60/KIRamBtc9Fv5u8VpX34Do/fru+/31aYlsDQLKq+HL7P4HAvs6Mdd/
         ONq5uBdOMUap+Xz8OuWJdHEszNhU/dDTwDuJuVYln6BRH4+7wXhWyVxkld6qpzFtbqJS
         RFyLJgOoci9qjZkCu70JacRIPp2dLFt3uqiG211aepBSKuDW+lIvYPDCDEh6gDvBp0G9
         kfcgsxivGSQ/e5n4gwXCg3UO2oRabkAd/wC0k3Fm/lYbihPcGj2XgfMvfWymSF9YX5d3
         XlQ9ZPVDEn5Y7/IGoXYI/+MraWiaehOWYzJPMQj21cQuCxhNAbU6sGbaNhE0EafVYszD
         Xh+Q==
X-Gm-Message-State: AOAM530z7jSe52mTeselSL6mHg5cCoX9TICrlKmhUWAZFfsAfneCAG4I
        U1Zri6aLPypRom9dggD8pBo=
X-Google-Smtp-Source: ABdhPJzgCmGisyc9SVAQ+LS3uyXYUZi0NpkoozMtYXlQs8+PYmwRX38IafHWsz7nOvT4fvsoKZgpJA==
X-Received: by 2002:a05:6512:3f8d:: with SMTP id x13mr11810946lfa.278.1624223686895;
        Sun, 20 Jun 2021 14:14:46 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id o142sm62875lfa.299.2021.06.20.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 14:14:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 0/2] Support temperature trips by HWMON core and LM90 driver
Date:   Mon, 21 Jun 2021 00:14:06 +0300
Message-Id: <20210620211408.3893-1-digetx@gmail.com>
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

v2: - Reworked set_trips() by making it generic. Now callback invokes
      the min/max temperature write method directly, instead of using
      additional new hwmon callback. This was suggested by Guenter Roeck.

    - Added new patch that fixes integer overflows in the LM90 driver.
      The fixes are necessary for supporting set_trips().

Dmitry Osipenko (2):
  hwmon: (lm90) Prevent integer overflow of temperature calculations
  hwmon: Support set_trips() of thermal device ops

 drivers/hwmon/hwmon.c | 32 ++++++++++++++++++++++++++++++++
 drivers/hwmon/lm90.c  |  6 ++++++
 2 files changed, 38 insertions(+)

-- 
2.30.2

