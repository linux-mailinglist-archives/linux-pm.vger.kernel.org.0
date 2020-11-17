Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C282B56C7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 03:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgKQCiN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 21:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgKQCiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 21:38:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FB1C0613CF;
        Mon, 16 Nov 2020 18:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6eb2pIfy6Xdnw/Krhg5PKBjpnWNrsxoSBJPm0fWPw/w=; b=D5LP9SOnbLesrH01i4G2Sv3ueo
        vzDyrl2xpM11BHXLLzooys63KsxJWzmJz7TTFy7t0HrWe/OC44npexsSWrVJtxrv/rLFOIoHmQ6z5
        HlZiCgZuLxyS5b47+XCu/M9Grsp9C24v0K7ixE2Q0lJUbZO3RrhlbJCigk1NgNa4SiVjyeyATrO5E
        uV0KYLr+WvAczfxuO7zYDWyNFC+xNuL2x9i/DfBHvEmYIf76DplnfEzQxtjfgwp1S97d6YzOVMByT
        feI6eNvh6z1twEfPmtonVpbRzFWxz0o0Gv0alJdx+8xoc2wBDXCzoxen9WR+6VC0UU0RLdwnHfdHO
        U2EmEJIQ==;
Received: from [2601:1c0:6280:3f0::f32] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keqsk-0006sO-Ef; Tue, 17 Nov 2020 02:38:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH -next] thermal: intel_pch_thermal: fix build for ACPI not enabled
Date:   Mon, 16 Nov 2020 18:38:07 -0800
Message-Id: <20201117023807.8266-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The reference to acpi_gbl_FADT causes a build error when ACPI is not
enabled. Fix by making that conditional on CONFIG_ACPI.

../drivers/thermal/intel/intel_pch_thermal.c: In function 'pch_wpt_suspend':
../drivers/thermal/intel/intel_pch_thermal.c:217:8: error: 'acpi_gbl_FADT' undeclared (first use in this function); did you mean 'acpi_get_type'?
  if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
        ^~~~~~~~~~~~~

Fixes: ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH temperature above threshold")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/intel/intel_pch_thermal.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20201116.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-next-20201116/drivers/thermal/intel/intel_pch_thermal.c
@@ -214,8 +214,12 @@ static int pch_wpt_suspend(struct pch_th
 	}
 
 	/* Do not check temperature if it is not a S0ix capable platform */
+#ifdef CONFIG_ACPI
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
 		return 0;
+#else
+	return 0;
+#endif
 
 	/* Do not check temperature if it is not s2idle */
 	if (pm_suspend_via_firmware())
