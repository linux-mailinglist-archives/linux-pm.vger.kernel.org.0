Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E06357A2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 09:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFEHXq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 03:23:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36275 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfFEHXq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 03:23:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so9375646plr.3;
        Wed, 05 Jun 2019 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OVAkmuBuntq/JiCcUISbfs7QbsWbr2uo4v+Qfkmx2xY=;
        b=V2EcUY+pPN+AsSWDcKbzLCzcQ3jVbMc+L3l3HjJ1+Ij1smFlWcBW5+23Y3ZXxDkJS+
         +WZ/nvfUeR1Ij4Kau9W3zazWnCjOnqCOzecKVlk4sMF1O8abzM1OJn+agRlDg7yO0/oL
         JQtXkKFwbkii3+S/gkyiPF9W6AMZiLkfLEDIEINFuekdKTnUbejSMVoPsMLQ1mO/VWQv
         z6miceTSx2WNKDD/jdIg6lvE8iBqlAMiaE/GgGH7EbhBEZ7lgg2bMvX7BbnLZg2vh5sZ
         7LZtHe3qzuHPFjxdPDRZNkscf9K/J9pYd9QKFDqNlxfivbd8fLCW9wHIoxorftRxf7bD
         LZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVAkmuBuntq/JiCcUISbfs7QbsWbr2uo4v+Qfkmx2xY=;
        b=jlXDoa0h62Rfz4l2KxRxUKVRDV2l3n5xc67473BpwipAUG2L0Q2/zvK9GgPtQ+Q/Ye
         Xxs8sA9rVV48xypNMDIYdGnhmGZgvZU9gccsGD4vyxkPYWmhQa41eN0A/lp9Qc/Tljgq
         a/i9nextQVCeUVNsmYj3B886Ucjg6kyUIUA2jxBaC3usae7m1t3D8gvY4uiKsXdk9ZrE
         Mx6WnF5EIuhm2bCutPt2iRmZzwXvazSzUBpO7hbgtwcC52ZKDCu2bcH68/VjnpS9QTdZ
         Vz+9Por5UYzHbxZIiyayJi09VnZQ9K4sxqdVMDiaH5mgb8+GugfQNRtZAyk9Gc9SuQl8
         VyGA==
X-Gm-Message-State: APjAAAWXukmKtJNfqgjcJOmwaAXb/mqCT4IcSxs/lRmbp8YedA8OP7+M
        GAO+Z/NHuJPExGB1wUnI2fZDfN8RVls=
X-Google-Smtp-Source: APXvYqy49aupErR7JqOZtS4PHu0Ci+0cTNR5ihIy6ieF5peFedl0FjVlpzXkXfZiOGOJVPAf+LuEgA==
X-Received: by 2002:a17:902:29c8:: with SMTP id h66mr41798233plb.269.1559719424733;
        Wed, 05 Jun 2019 00:23:44 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i4sm1027404pjd.31.2019.06.05.00.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:23:44 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] power: supply: ucs1002: Add HWMON interface
Date:   Wed,  5 Jun 2019 00:23:23 -0700
Message-Id: <20190605072323.21990-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605072323.21990-1-andrew.smirnov@gmail.com>
References: <20190605072323.21990-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose current sensors found on UCS1002 via HWMON.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/ucs1002_power.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 677f20a4d76f..a4b6b37549cf 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -571,6 +571,12 @@ static int ucs1002_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ret = devm_power_supply_add_hwmon_sysfs(info->charger);
+	if (ret) {
+		dev_err(dev, "Failed to add hmwon attributes: %d\n", ret);
+		return ret;
+	}
+
 	ret = regmap_read(info->regmap, UCS1002_REG_PIN_STATUS, &regval);
 	if (ret) {
 		dev_err(dev, "Failed to read pin status: %d\n", ret);
-- 
2.21.0

