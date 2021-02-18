Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B377431F145
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBRUnG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:43:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54260 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhBRUkf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:35 -0500
Date:   Thu, 18 Feb 2021 20:39:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1+ZWAOfxOiBnQvWVeeMG6BMAKunmNmhMd9d4+ubPdo=;
        b=19lwhqcNtQTWRWFO4iXkpHjEyWsZKs+Aj1/KGmaRoERXCdfR76eu+I5SDKaR4o443AyqoO
        8ClCfqLNx1+XPfsXRNQzM+2502fCH7AgfkJXXx5cAFVSsV4HEep0WLkLSo94PaiLVbppwy
        Qksi0tiR0TVqF+IeqI+oDFP5WXavHPoTBbX8nR6GDg4caJ+gHxSqE0lEXR7KnMhqlTXN6G
        M9t+2qlVICX0fzpR+VjGrfA1K63DkE2PGPCj/N+eu+lLtIjTvqPcQKsALLdW+MYB6KROrf
        cWUDkSvJeP3enYOffWW/GqhVwSBjPeCZHpXKk+qtY3HT8LjykaakdNEv7N5uOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1+ZWAOfxOiBnQvWVeeMG6BMAKunmNmhMd9d4+ubPdo=;
        b=I/5volElgg4uSw/+B/YskFRoISX65HpQxmdrEx16+Jha4DKQbh9R4bFO4PDveAO9iTMn5s
        DgL7oeii6nTTa5AQ==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] iio: adc: qcom-vadc-common: use
 fixp_linear_interpolate
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20201204025509.1075506-5-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <161368078501.20312.9950089385562714464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e2621acd6d9af5b3d5584ddf0fd7994472d6199e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e2621acd6d9af5b3d5584ddf0fd7994472d6199e
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Fri, 04 Dec 2020 05:54:58 +03:00
Committer:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CommitterDate: Sat, 16 Jan 2021 18:19:00 

iio: adc: qcom-vadc-common: use fixp_linear_interpolate

Use new function fixp_linear_interpolate() instead of hand-coding the
linear interpolation.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20201204025509.1075506-5-dmitry.baryshkov@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-vadc-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index d11f334..40d77b3 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -2,6 +2,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/fixp-arith.h>
 #include <linux/math64.h>
 #include <linux/log2.h>
 #include <linux/err.h>
@@ -368,10 +369,9 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
 	} else {
 		/* result is between search_index and search_index-1 */
 		/* interpolate linearly */
-		*output = (((s32)((pts[i].y - pts[i - 1].y) *
-			(input - pts[i - 1].x)) /
-			(pts[i].x - pts[i - 1].x)) +
-			pts[i - 1].y);
+		*output = fixp_linear_interpolate(pts[i - 1].x, pts[i - 1].y,
+						  pts[i].x, pts[i].y,
+						  input);
 	}
 
 	return 0;
