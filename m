Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C60F4608E0
	for <lists+linux-pm@lfdr.de>; Sun, 28 Nov 2021 19:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359194AbhK1SZL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Nov 2021 13:25:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359209AbhK1SXG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Nov 2021 13:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638123590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJ60w9l5x9z7ezkDeL8gMwQfAMNkzdnrdHE2RsyKQDs=;
        b=XUr3a5RL3DWnwMyox9nvip7BKuC4KyPCE39O0HBiQ98s966ljR1W2TScD7u0Gy0acquUR7
        0Ajkc0k1fgxdDBMjUJHcb6CkbdcBiViAliJGdUQiK8HWa3ZNx2RRIl/ZCKqc7eit85VDgq
        M6F7ae2TEKyDCUIt60sB9WO8jfqMO6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-SEcGvk1KM3OTTQ47wym0lw-1; Sun, 28 Nov 2021 13:19:44 -0500
X-MC-Unique: SEcGvk1KM3OTTQ47wym0lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A05E1006AA0;
        Sun, 28 Nov 2021 18:19:42 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F55710016F4;
        Sun, 28 Nov 2021 18:19:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v3 20/20] extcon: intel-cht-wc: Report RID_A for ACA adapters
Date:   Sun, 28 Nov 2021 19:18:09 +0100
Message-Id: <20211128181809.326736-21-hdegoede@redhat.com>
In-Reply-To: <20211128181809.326736-1-hdegoede@redhat.com>
References: <20211128181809.326736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make cht_wc_extcon_get_id() report RID_A for ACA adapters, instead of
reporting ID_FLOAT.

According to the spec. we should read the USB-ID pin ADC value
to determine the resistance of the used pull-down resister and
then return RID_A / RID_B / RID_C based on this. But all "Accessory
Charger Adapter"s (ACAs) which users can actually buy always use
a combination of a charging port with one or more USB-A ports, so
they should always use a resistor indicating RID_A. But the spec
is hard to read / badly-worded so some of them actually indicate
they are a RID_B ACA even though they clearly are a RID_A ACA.

To workaround this simply always return INTEL_USB_RID_A, which
matches all the ACAs which users can actually buy.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 144cb5d8cd47..2a8d41cbf41c 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -121,13 +121,21 @@ static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
 		return INTEL_USB_ID_GND;
 	case CHT_WC_PWRSRC_RID_FLOAT:
 		return INTEL_USB_ID_FLOAT;
+	/*
+	 * According to the spec. we should read the USB-ID pin ADC value here
+	 * to determine the resistance of the used pull-down resister and then
+	 * return RID_A / RID_B / RID_C based on this. But all "Accessory
+	 * Charger Adapter"s (ACAs) which users can actually buy always use
+	 * a combination of a charging port with one or more USB-A ports, so
+	 * they should always use a resistor indicating RID_A. But the spec
+	 * is hard to read / badly-worded so some of them actually indicate
+	 * they are a RID_B ACA evnen though they clearly are a RID_A ACA.
+	 * To workaround this simply always return INTEL_USB_RID_A, which
+	 * matches all the ACAs which users can actually buy.
+	 */
 	case CHT_WC_PWRSRC_RID_ACA:
+		return INTEL_USB_RID_A;
 	default:
-		/*
-		 * Once we have IIO support for the GPADC we should read
-		 * the USBID GPADC channel here and determine ACA role
-		 * based on that.
-		 */
 		return INTEL_USB_ID_FLOAT;
 	}
 }
-- 
2.33.1

