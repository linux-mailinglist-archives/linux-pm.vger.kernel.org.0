Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0114A4B16
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jan 2022 16:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379943AbiAaP6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jan 2022 10:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbiAaP56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jan 2022 10:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643644677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NJW3BDXpjZxtDhCAQi4pMm+5TQP0sydAdH0hiybs94w=;
        b=WjmeqM2uv+2BCYk7jv6xqQwxGdz5YjOHad7Te0J95W2FwgihalJ1t5iHWrWuGamajWkCuN
        z9otzePCPxk8pBkgLYqAFpO2MsGiHHFhukS9GssfYgzMSaspJKlTJROgI/e/EeTI0lhIKv
        mjeVARYzXvrTiyPBtgmfKnlhvSTTKpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-c_UxvsO6PoSon4aVe3D4cg-1; Mon, 31 Jan 2022 10:57:55 -0500
X-MC-Unique: c_UxvsO6PoSon4aVe3D4cg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF0B184DA41;
        Mon, 31 Jan 2022 15:57:53 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C090798C6;
        Mon, 31 Jan 2022 15:57:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH 0/8] power: supply: bq24190 updates + new ug3105 driver
Date:   Mon, 31 Jan 2022 16:57:22 +0100
Message-Id: <20220131155730.309513-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

Here is a series of patches which:

1. Modifies power_supply_get_battery_info() to also work with non
   of/dt device-properties

2. Modifies bq24190_charger to use and apply more settings returned
   by power_supply_get_battery_info()

3. Adds a new driver for the ug3105 battery monitoring chip, note
   this chip is not really a full/standalone fuel-gauge so
   the functionality of the is limited

Regards,

Hans


Hans de Goede (8):
  power: supply: core: Use fwnode_property_*() in
    power_supply_get_battery_info()
  power: supply: core: Add support for generic fwnodes to
    power_supply_get_battery_info()
  power: supply: bq24190_charger: Turn off 5V boost regulator on
    shutdown
  power: supply: bq24190_charger: Always call
    power_supply_get_battery_info()
  power: supply: bq24190_charger: Store ichg-max and vreg-max in
    bq24190_dev_info
  power: supply: bq24190_charger: Program charger with fwnode supplied
    ccc_ireg and cvc_vreg
  power: supply: bq24190_charger: Disallow ccc_ireg and cvc_vreg to be
    higher then the fwnode values
  power: supply: ug3105_battery: Add driver for uPI uG3105 battery
    monitor

 drivers/power/supply/Kconfig             |  14 +
 drivers/power/supply/Makefile            |   1 +
 drivers/power/supply/bq24190_charger.c   | 114 ++++--
 drivers/power/supply/power_supply_core.c |  93 +++--
 drivers/power/supply/ug3105_battery.c    | 486 +++++++++++++++++++++++
 5 files changed, 642 insertions(+), 66 deletions(-)
 create mode 100644 drivers/power/supply/ug3105_battery.c

-- 
2.33.1

