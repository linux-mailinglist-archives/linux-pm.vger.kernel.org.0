Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989DB45987F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 00:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhKVXrD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 18:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhKVXrD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Nov 2021 18:47:03 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9EBC061714
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 15:43:55 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u3so86095367lfl.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmsnRXd7lyuF3Jf8sjqL8Pz8nqSLYJNluDzxclQrw3M=;
        b=ApJsIS1AD9DsujC4DiMxfHq0rqqLun4GGW8L+7+H+sMah+NV4cejlQ2gWbdqt6RST+
         KoSRv9g9Z2j8hb9and7Pcorab16kXkVSxRCZ7rH+xmkqEZ2AztsDL3VuukiCE5da9CsK
         rPhT2B5IIlEjQcM5RCOj+o5IaPtUhPKUSkkM8gh1voVbM3rJKpBn2g9JsIoPLIteC1Jk
         W4yxc8j4u2y7iAfd22bnG6AjHW1iyrfx1w7yhoBsLoTAvz5ugsF3mwlVMxRafElP3a+O
         w0Pb53vGzADJPQxr3mGnEkHhZNg4pVFcx2qqN6An4xX1Xy6YCGt1wk1awBpll+9XM10h
         f4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmsnRXd7lyuF3Jf8sjqL8Pz8nqSLYJNluDzxclQrw3M=;
        b=EDgOKmfD+4AmZjckgq79O2JgPMxIR9vY0RW6QXKeL/3cfGq3PiIhM4TnW3tVivnKJr
         SCiQYHjxuvcatI9tnth04QXt0Ksw6/bq/RSO+WKnfAaju9NlrqZgDoUOSJ3Ld850ZVAT
         vo4AFFUhPHOEqqXul+5oPD0yk+fkAMWP6REEhib5+vR0ivZE9C/7oflpGifiQYJ+UAMJ
         cXvgCOXAgzSNfpE2G1t3FHWggzy0wqubKAEXP226F6utCTMODPDW/X4owl4JyXYwg6AV
         dG96eCuXuYTHrM/+2bWIOTeY96/Y2SLBOBSh7rQckfTQLRr8Ts7u/k4NAWUb6WCuescS
         KMJA==
X-Gm-Message-State: AOAM531BmJivfPeoPJJLBNcoscAHRVR8MM9lBfSpz7w53pWgUIw+97p3
        PUz4STVFEqxRmAtIaWssTZPo8ti2oWh9ZQ==
X-Google-Smtp-Source: ABdhPJy65fjy6zIfTz5DqA3S5Kqy9y0KH4E46khaz5rrSLT1kzSeV5ckaySwtX75VjpJ3CtOteYiRA==
X-Received: by 2002:a05:6512:220b:: with SMTP id h11mr201231lfu.151.1637624633805;
        Mon, 22 Nov 2021 15:43:53 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b26sm1109311lff.148.2021.11.22.15.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:43:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] More AB8500 charging props
Date:   Tue, 23 Nov 2021 00:41:39 +0100
Message-Id: <20211122234141.3356340-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These two patches begin to put new stuff into the
drivers/power/supply/ab8500_bmdata.c for:

A) battery temperature look-up and interpolation, and
B) maintenance charging

Some design choices can be discussed, so I included some
HWMON etc maintainers.

NTC resistor:

For the battery NTC temperature we should note the existing NTC
driver in drivers/hwmon/ntc_thermistor.c with bindings
in Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
which is used for stand-alone NTC resistors.

It is probably possible to try to reuse the hwmon code but I
wanted to see if we have buy-in from the hwmon maintainer first.

If yes, I will try to come up with some way of representing the
NTC resistor in the device tree and use it in-tree from the
charging drivers.

Maintenance charging:

I included an infrastructure for maintenance "charging points"
which constitute of a current, a voltage and a safety timer:

struct power_supply_maintenance_charge_table {
       int charge_current_max_ua;
       int charge_voltage_max_uv;
       int charge_safety_timer_minutes;
};

This is all pretty straight-forward if just adding maintenance
charging.

For the bigger picture, however, a charging point can also
include the existing CC/CV current and voltage and the
precharging current and voltage as two charging points,
possibly without corresponding safety timer. If this is
desired I will rework the patch to refactor the existing
currents and voltages into charging points as well.

Linus Walleij (2):
  power: supply: ab8500: Standardize NTC battery temp
  power: supply: ab8500: Standardize maintenance charging

 drivers/power/supply/ab8500-bm.h         | 30 --------
 drivers/power/supply/ab8500_bmdata.c     | 68 +++++++++-------
 drivers/power/supply/ab8500_btemp.c      | 45 +----------
 drivers/power/supply/ab8500_chargalg.c   | 41 +++++++---
 drivers/power/supply/power_supply_core.c | 63 +++++++++++++++
 include/linux/power_supply.h             | 98 ++++++++++++++++++++++++
 6 files changed, 237 insertions(+), 108 deletions(-)

-- 
2.31.1

