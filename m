Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48675EBE
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 08:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGZGIa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 02:08:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38039 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZGIa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 02:08:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so24318863plb.5
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7ws1qKYpjHUbJBcDEjX+O45O4PeS/F7CJBjcK+b80DI=;
        b=eFD2SvfC4aW7c9EH62OZkBc5TVdsTFmugcm+I4moIuOACjKYGEFe0Kk43P2gHQ+9l5
         3XwjOce81bW5EusPu1TWOmRAywaELFY/2xEHnmfXV/GnFKJllG12Oe9WaWqiijswAci0
         1mAn0sSyoLb1L4MYhcBEp60cHOJ1fjV2u1TiDgkkpknP9n40mozFEeeOY+Vrc0is60kh
         37p/3hj7dhJI9NdCmQh64uInc8KRvABr5OqmHwfzY/ECcAoVjqzVuPh8/jPvfmyFFWdT
         XCFAdicET4E2/NXtnyQbds6DYEcR7GB7Cth+wgtrzBmzA4KNeVyq/y06xTJUrgURgKi3
         KR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ws1qKYpjHUbJBcDEjX+O45O4PeS/F7CJBjcK+b80DI=;
        b=bukSyfJ+5PoBSIq51sBx4mi9JTzdnRJRgnn9O93cwA215EVbppJmbEOVhkqLBFeMhG
         nKg0pMnM1/Xhp4fG5zvrtncfgD1vh1okSin7kB0t6E1I6PgnZEqobslPabqebYKLK0jC
         EMOppyZJPrnPq6ulfWAy8vCTK1Rup4GsI8E1RqanHEH+F+udyPrSRFDz4/B3JAxEUAE9
         TqdpWMlMTt/WJV8ijDoVXFnLAW5C5V9luV2VurgMhE3ru9NNBFy6HRCj3nJFLJD33Vy8
         JLPGVxvmlP7sHgB9xeqX+hZ4p/vZI+zqauEOAQrN0h+JqIb5EmPc/7QGG6rGRbTy0XAt
         upVQ==
X-Gm-Message-State: APjAAAUrHMCVjY3x4eNk+Uw6JkV2mbT1uFtTidufxtoEbxro5fXLJ2km
        iLXnqtCtrvFN/myDhYeEHoM=
X-Google-Smtp-Source: APXvYqz42D1hSQPDA/GlNfy+K3GJggOIIpXxWbBz2HWh1QSh7ev6aI469EeqUu1yzVlm2+LCTseiJw==
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr95366309plr.285.1564121309632;
        Thu, 25 Jul 2019 23:08:29 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id g4sm65843430pfo.93.2019.07.25.23.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 23:08:28 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] PM / OPP: Correct Documentation about library location
Date:   Fri, 26 Jul 2019 14:07:47 +0800
Message-Id: <20190726060747.8700-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

OPP library is now located in drivers/opp/ directory.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 Documentation/power/opp.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
index b3cf1de..209c761 100644
--- a/Documentation/power/opp.rst
+++ b/Documentation/power/opp.rst
@@ -46,7 +46,7 @@ We can represent these as three OPPs as the following {Hz, uV} tuples:
 ----------------------------------------
 
 OPP library provides a set of helper functions to organize and query the OPP
-information. The library is located in drivers/base/power/opp.c and the header
+information. The library is located in drivers/opp/ directory and the header
 is located in include/linux/pm_opp.h. OPP library can be enabled by enabling
 CONFIG_PM_OPP from power management menuconfig menu. OPP library depends on
 CONFIG_PM as certain SoCs such as Texas Instrument's OMAP framework allows to
-- 
1.9.1

