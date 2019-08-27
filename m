Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 101709EB54
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH0Omf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 10:42:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34355 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfH0Ome (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 10:42:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so19110999wrn.1;
        Tue, 27 Aug 2019 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ca2+YahgUJ7d9DaNm5wUyN4mWXrxesbHToiPd/b8GMg=;
        b=C2qheXhAmjKS0CqUVWH8ElAcQta++ZhTzCK3fuMBVVMqOKIvfuAgqBDNobOOFJTDJ7
         5qMmdVXhOndsKAy1vGHNdAT06Rq74c3cpT+naCVGcWB0/c+/1L1YA6/TNrox0egMMmyD
         H6me2J6xiSWEV32noukVqvry6bX7cEmkZaubXoNM8LGnNYrnL1Vb/zmi83EnBiAAr2+P
         nXe35atVZWeeqZlIHICGj/MkW/hrbGjHgD2U/4WfNw5aLSaPXGbUwhH2dYMPt/qo28eQ
         Vj1tbiSW3jOEXFviowj8nRxUzfz543cCiVW4WyoRngkRVWWIp5pqYLoqdEUX4Z3RRYAB
         lwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ca2+YahgUJ7d9DaNm5wUyN4mWXrxesbHToiPd/b8GMg=;
        b=aKQGeXgAv0zS1Pdtc1Ufenu/lUAuEqcB1IiQoZLVP6y56vOlFEN9TdT75ulpGIGS0i
         +fktjBKvqXHdKAMyp8q2MZ5nLTcegmzJZrYcqZwToQruXUk6KluSfngrGqIXHXuE6nQS
         bAF8x92zNFTMwM+++7KmP8vWoym78mcPfnNL+cH2ltM1WmYgn86lZYRozgYHUDwqsJJF
         2sC8RXwCa2dTeTfR61RqCVONj7EOroZt9P0tfdaJYkKuHBYD0lrsdA/Pv/zx/suTdWrw
         FY8gAm3z3N9Sle7HffmEoFi4rocQKdjvs8NZDFT4RNGQfQuIeYWtm+Pa1sEt7U9BoGHK
         Vi0w==
X-Gm-Message-State: APjAAAUg/N01lExAO/nKLmaDkcLhwzfIFdsGAZKgSKbFJQjPEq2LIwTY
        qqQcHRgXUZM2jt7korKVzcZBvc0g5hc=
X-Google-Smtp-Source: APXvYqyLy6WA/c8mkgNmIc0Q+m6JLYADsiirtzRg20Ten7Hc+d8Lg1jBonOAtvjmv5BGzxvhcQo2Kg==
X-Received: by 2002:adf:f507:: with SMTP id q7mr29777786wro.210.1566916952672;
        Tue, 27 Aug 2019 07:42:32 -0700 (PDT)
Received: from bfk-3-vm8-e4.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by smtp.gmail.com with ESMTPSA id e9sm2799413wmd.25.2019.08.27.07.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 07:42:32 -0700 (PDT)
From:   Peter Mamonov <pmamonov@gmail.com>
To:     rui.zhang@intel.com
Cc:     Peter Mamonov <pmamonov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: make thermal_zone_of_sensor_register return -ENODEV if a sensor OF node is missing
Date:   Tue, 27 Aug 2019 17:39:52 +0300
Message-Id: <20190827143952.19591-1-pmamonov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When devm_thermal_zone_of_sensor_register() is called from
hwmon_thermal_add_sensor() it is possible that the relevant sensor is
missing an OF node. In this case thermal_zone_of_sensor_register() returns
-EINVAL which causes hwmon_thermal_add_sensor() to fail as well. This patch
changes relevant return code of thermal_zone_of_sensor_register() to
-ENODEV, which is tolerated by hwmon_thermal_add_sensor().

Here is a particular case of such behaviour: the Marvell ethernet PHYs
driver registers hwmon device for the built-in temperature sensor (see
drivers/net/phy/marvell.c). Since the sensor doesn't have associated OF
node devm_hwmon_device_register() returns error which ultimately causes
failure of the PHY driver's probe function.

Signed-off-by: Peter Mamonov <pmamonov@gmail.com>
---
 drivers/thermal/of-thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index dc5093be553e..34b0cc173f4a 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -493,7 +493,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 
 	if (!dev || !dev->of_node) {
 		of_node_put(np);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-ENODEV);
 	}
 
 	sensor_np = of_node_get(dev->of_node);
-- 
2.20.1

