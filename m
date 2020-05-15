Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953061D5A2C
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 21:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgEOTlY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 15:41:24 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59022 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgEOTlY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 15:41:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04FJfLXD056154;
        Fri, 15 May 2020 14:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589571681;
        bh=Vrkuh1qw/+LAqzEbWTPvI7ZY7UhYrsZSZ8panFOF68c=;
        h=From:To:CC:Subject:Date;
        b=REQ/t1H1H8Wz0XLgzTeD+l5GV8K+DPDy01LEGDP6K5ImLJT7PjPScATsTlkxhJ43E
         A5yWdQYCtqLmRiJrKoxnmx+SKOeQLQbQKsiW5VQuyJ9X/a8IdzzX1WXK9hMMb2uRNg
         28EooCOQTzONop0lODysu30rE/V0MLMBdHA2KvJw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04FJfL0O081567
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 14:41:21 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 May 2020 14:41:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 May 2020 14:41:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04FJfLCP015667;
        Fri, 15 May 2020 14:41:21 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <sspatil@android.com>, <linux-pm@vger.kernel.org>,
        <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 0/3] Add JEITA properties and introduce the bq2515x charger
Date:   Fri, 15 May 2020 14:31:45 -0500
Message-ID: <20200515193148.8502-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset adds additional health properties to the power_supply header.
These additional properties are taken from the JEITA specification. This 
patchset also introduces the bq2515x family of charging ICs.

Dan Murphy (1):
  power_supply: Add additional health properties to the header

Ricardo Rivera-Matos (2):
  Add the bindings for the bq25150 and bq25155 500mA charging ICs from
    Texas Instruments.
  power: supply: bq25150 introduce the bq25150

 Documentation/ABI/testing/sysfs-class-power   |    2 +-
 .../bindings/power/supply/bq2515x.yaml        |  106 ++
 drivers/power/supply/Kconfig                  |   13 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq2515x_charger.c        | 1176 +++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c     |    2 +-
 include/linux/power_supply.h                  |    3 +
 7 files changed, 1301 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
 create mode 100644 drivers/power/supply/bq2515x_charger.c

-- 
2.26.2

