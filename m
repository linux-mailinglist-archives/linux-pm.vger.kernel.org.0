Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87701C9AD3
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEGTUw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 15:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgEGTUw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 May 2020 15:20:52 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0681208E4;
        Thu,  7 May 2020 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879251;
        bh=gdUcbJXVtT6YHaa/pRQ/6RwwYOCYa19E7kHEwdNGrpU=;
        h=Date:From:To:Cc:Subject:From;
        b=FsM5D+H1Q0D/Ggqx8+VPzcsDC6kmAQhmprvGzjUpT5FE+WeaS/lkzXHF1GmuW/m4v
         JNmAF9UU71unvR3hIiR6a9sqwttWFIebrBMOqQDxQWevbmRCIDw+hRXHbPqs9c0Igk
         HyQdDDdvJtkGVPtBS5rBsuFcbAyFLAhnowjqUfGk=
Date:   Thu, 7 May 2020 14:25:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: imx8mm: Replace zero-length array with
 flexible-array
Message-ID: <20200507192517.GA16557@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/thermal/imx8mm_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 0d60f8d7894f..e6061e26d4ac 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -54,7 +54,7 @@ struct imx8mm_tmu {
 	void __iomem *base;
 	struct clk *clk;
 	const struct thermal_soc_data *socdata;
-	struct tmu_sensor sensors[0];
+	struct tmu_sensor sensors[];
 };
 
 static int imx8mm_tmu_get_temp(void *data, int *temp)

