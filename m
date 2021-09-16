Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC040DA61
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 14:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhIPMyt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 08:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhIPMys (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 08:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631796808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lig6EFyucetTMfbz5HD/R2E6ey20yUhnnjPQ8F+k4YM=;
        b=dg4tCDudXoirsZyL2WPPCimdZ/pt0Ls/TmZg6HOTK4rve9e12nx08YsGtzx1FByR9I0kwd
        3zpeVMmDjega31XSV8K1o9f1D8iHiHwhKy5a05p6nExdCx8qWGKSwNkEobmtp+bug9XIqV
        ndapOr4XLMgKz++6FLOfttuN5TFILLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-iVEL8mggOsGNvxT0_eWwqQ-1; Thu, 16 Sep 2021 08:53:24 -0400
X-MC-Unique: iVEL8mggOsGNvxT0_eWwqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCDEA100D680;
        Thu, 16 Sep 2021 12:53:23 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.195.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB531669F3;
        Thu, 16 Sep 2021 12:53:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v4] docs: ABI: sysfs-class-power: Documented cycle_count property
Date:   Thu, 16 Sep 2021 14:53:21 +0200
Message-Id: <20210916125321.10823-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit c955fe8e0bdd ("POWER: Add support for cycle_count") added a
POWER_SUPPLY_PROP_CYCLE_COUNT "cycle_count" property to the set of
standard power-supply properties, but this was never documented,
document it now.

Link: https://gitlab.freedesktop.org/upower/upower/-/issues/152
Reported-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
- Document that some drivers, such as e.g. the often used
  drivers/acpi/battery.c driver may return 0 when cycle_count information
  is not available

Changes in v3 (aka the really really typo free version)
- Fix typo in "cycle_count" in Subject

Changes in v2:
- s/Possitive/Positive/
---
 Documentation/ABI/testing/sysfs-class-power | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index ca830c6cd809..f7904efc4cfa 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -480,6 +480,19 @@ Description:
 
 		Valid values: Represented in microvolts
 
+What:		/sys/class/power_supply/<supply_name>/cycle_count
+Date:		January 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the number of full charge + discharge cycles the
+		battery has undergone.
+
+		Access: Read
+
+		Valid values:
+			Integer > 0: representing full cycles
+			Integer = 0: cycle_count info is not available
+
 **USB Properties**
 
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
-- 
2.31.1

