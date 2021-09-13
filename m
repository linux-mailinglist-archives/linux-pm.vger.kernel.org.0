Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E69408B06
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 14:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbhIMM0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 08:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239994AbhIMM0v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 08:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631535930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e+jI1xJ+aXnUn8ai0ZxHTQZeehP9E7HLnyjgYn0Oxmw=;
        b=hXJAI94Pb+Qdjlrx37e4aFGQAQLIcxiDIDVqsHRrjqaoQ2cGMUS2JbZtGte6Bai/aAvTZq
        n2UpkUDCmWsdh2ou+T6/9uaMKclQ7dFdWu2PQ5wewYEm5xrMp9pULjyCgsGqWmGF0eotbz
        KZAp3img4UsC+GRJ1cU4+cVM+PqvdjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-DWKevSjpOwGuHOipjg1JkQ-1; Mon, 13 Sep 2021 08:25:25 -0400
X-MC-Unique: DWKevSjpOwGuHOipjg1JkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778501835ADF;
        Mon, 13 Sep 2021 12:25:19 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.193.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD2187883B;
        Mon, 13 Sep 2021 12:25:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2] docs: ABI: sysfs-class-power: Documented cycle_coint property
Date:   Mon, 13 Sep 2021 14:25:01 +0200
Message-Id: <20210913122501.592294-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Changes in v2:
-s/Possitive/Positive/
---
 Documentation/ABI/testing/sysfs-class-power | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index ca830c6cd809..687db552c374 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -480,6 +480,17 @@ Description:
 
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
+		Valid values: Positive integer representing full cycles
+
 **USB Properties**
 
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
-- 
2.31.1

