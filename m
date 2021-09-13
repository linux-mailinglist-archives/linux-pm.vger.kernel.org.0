Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C982B408E56
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhIMNdK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 09:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242842AbhIMNaP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 09:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631539738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EH1NecB1TKw1kjh66jwRAJHvDqc2I9dVOEXKTtWVeus=;
        b=aRO7pFXBZ6H725H+TBXX8OJ0V852Z/Dpomb7h7sCIDozMhDCS4H98KKE1mgBS6YqpzmCQm
        pEM+lCQo5g16uPY7LBcuNRhv8cZJ9fhogLuO7g2Ijj9wyNmfd4e7rFjmNrO0SKGI7hvnmh
        u8Fk8Fl8bq5TOH8v+UHorE4CdxKwlDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-qSTfMbPtMGWkj51YuorBoA-1; Mon, 13 Sep 2021 09:28:57 -0400
X-MC-Unique: qSTfMbPtMGWkj51YuorBoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CCD819200C0;
        Mon, 13 Sep 2021 13:28:56 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.193.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAD3F19724;
        Mon, 13 Sep 2021 13:28:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v3] docs: ABI: sysfs-class-power: Documented cycle_count property
Date:   Mon, 13 Sep 2021 15:28:53 +0200
Message-Id: <20210913132853.606265-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Changes in v3 (aka the really really typo free version)
- Fix typo in "cycle_count" in Subject

Changes in v2:
- s/Possitive/Positive/
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

