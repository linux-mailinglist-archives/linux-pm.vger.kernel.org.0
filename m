Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2343C3CC485
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 18:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhGQQr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 12:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhGQQr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 12:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626540268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T/StxDhbvYjQt/NObXcIte38ToEmHqJDGT4iofQyXjE=;
        b=iBQTw7r5ScNt9POEnbqfxJGLVcOjFoLWqWv6zY+AOZkJyWQOORAEZI0AIFtyaZcr1B8B/1
        pFaYSYQExqmN717ttP4XRb/40Qjyh+3Aj0x98ddtgyIeiLOZp7QH+U8OmaBikLtFFI81sc
        beNbYOxE6nhg+Y5fjmLNRKMPOvHxYwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-csDaPCNXNU-R3Kk_XmUNQg-1; Sat, 17 Jul 2021 12:44:27 -0400
X-MC-Unique: csDaPCNXNU-R3Kk_XmUNQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 591541800D41;
        Sat, 17 Jul 2021 16:44:26 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-42.ams2.redhat.com [10.36.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E0D75DEFA;
        Sat, 17 Jul 2021 16:44:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH 00/10] power: supply: axp288_fuel_gauge: Reduce number of register accesses + cleanups
Date:   Sat, 17 Jul 2021 18:44:14 +0200
Message-Id: <20210717164424.274283-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
before it may use the bus and while the kernel holds the semaphore the CPU
and GPU power-states must not be changed otherwise the system will freeze.
This is a complex process, which is quite expensive.

To ensure that no unguarded I2C-bus accesses happen, the semaphore is
taken by the I2C-bus-driver for every I2C transfer. When upower refreshes
its battery stats it reads all the power-supply properties at once,
leading to the semaphore getting hammered which sometimes causes the
system to hang.

Andrejus maintains a large "fleet" of affected Cherry Trail tablets
and was seeing these hangs semi regularly. After discussing this with
me Andrejus wrote the caching patch in this series which greatly reduces
the number of semaphore accesses and since then there have been no
reports of hangs in the fleet of devices which he maintains.

I've cleaned up Andrejus work a bit before submitting it upstream and
while working on this I found a slew of other issues in this driver
which bugged me enough to write a bunch of cleanup patches. I've also
added some extra patches to also reduce the semaphore use during driver
probe.

Regards,

Hans


Andrejus Basovas (1):
  power: supply: axp288_fuel_gauge: Refresh all registers in one go

Hans de Goede (9):
  power: supply: axp288_fuel_gauge: Fix define alignment
  power: supply: axp288_fuel_gauge: Remove debugfs support
  power: supply: axp288_fuel_gauge: Silence the chatty IRQ mapping code
  power: supply: axp288_fuel_gauge: Report register-address on readb /
    writeb errors
  power: supply: axp288_fuel_gauge: Drop retry logic from
    fuel_gauge_reg_readb()
  power: supply: axp288_fuel_gauge: Store struct device pointer in
    axp288_fg_info
  power: supply: axp288_fuel_gauge: Only read PWR_OP_MODE,
    FG_LOW_CAP_REG regs once
  power: supply: axp288_fuel_gauge: Move the AXP20X_CC_CTRL check
    together with the other checks
  power: supply: axp288_fuel_gauge: Take the P-Unit semaphore only once
    during probe()

 drivers/power/supply/axp288_fuel_gauge.c | 489 +++++++++--------------
 1 file changed, 186 insertions(+), 303 deletions(-)

-- 
2.31.1

