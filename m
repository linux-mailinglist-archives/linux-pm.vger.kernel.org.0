Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A874E5B037
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2019 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfF3PCw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jun 2019 11:02:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33000 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3PCw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2019 11:02:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id h24so8869876qto.0;
        Sun, 30 Jun 2019 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyVCRwDG/FzMILKy+0D6jsU2j8VALwyqKuHip6bg8Vc=;
        b=vKHUswvI6acNk5JHHOslBw5H1xZCtlqz7wxsVgnwV8/xPkF38zAHVioXhSkIxmqf5l
         3/zdZZkZhuWugtkYlNiUG3Au/C9JDLDtJ8jdod8Btp9V1fzI7hCmZH+JZ7XmHaKkUSNf
         gEzzQ9uzkp8bxXdWb7ZwVbK961QW0T7bLjX8flaFCBsxzfVFmIHTuN3AiMLpVHlp/1uP
         VGOhEEwHEjC26dn4y+JpfYkpmPQcpcoC24oe8Qeaf0ldO6+fqT3Y0PIARHlm2DJjLdZl
         iR81+tF5oAknkkjxVGcrUMij4KsH+fosAGbQDSnhP+Q+5QVkz7VrtzG0pEO0A+VP/Nzv
         QKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyVCRwDG/FzMILKy+0D6jsU2j8VALwyqKuHip6bg8Vc=;
        b=D0A/QFQY2XwVqIP4Kamck4OS7s6+YjlX90xXCqInkXyFzTs7GeuUxZnrB3m8p4Tx2H
         IjbXsVzp0haumu8xW+TV8onZQJqr8f2UCqc5zM/tY28nQ9QB6f/O7C40MFdUG6lFt2Eh
         jC0mGI82/sGC483YTkPkMXrckI2C6LmdrP/gQLO0fvU9/+JG8M68P9/jlNngByFTI3jG
         r91AM2yLgsXJbhHwA/bda1AHVng5dBwMoiUHd4ud1hDot2UHyr6sgJk7xclH3NnOV4iy
         8nauMiuY8n7BUu96HXmd6ER6SfiRO3C0ASnhiQojzU7B5W+SE1M4GRTrXtGs1/CsT4ET
         2Jxg==
X-Gm-Message-State: APjAAAVqoVXIS72YMYbI/SqfQ90/ftr+S/beKhLKQX2EGi/XxnO3PgLO
        0LErIyjx3L9B7z4/2bbKHEc=
X-Google-Smtp-Source: APXvYqxJiD29r7kDOv7GdXwuwUbbUFFMJl7hp70rUwmafDTTAolfz3i7ezUr8GVYHQgKtZ9R6qpXlw==
X-Received: by 2002:ac8:3811:: with SMTP id q17mr15849886qtb.315.1561906970879;
        Sun, 30 Jun 2019 08:02:50 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id q36sm4115062qtc.12.2019.06.30.08.02.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 08:02:50 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] genpd/gdsc: inherit display powerdomain from bootloader
Date:   Sun, 30 Jun 2019 08:01:40 -0700
Message-Id: <20190630150230.7878-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630150230.7878-1-robdclark@gmail.com>
References: <20190630150230.7878-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Mark power domains that may be enabled by bootloader, and which should
not be disabled until a driver takes them over.

This keeps efifb alive until the real driver can be probed.  In a distro
kernel, the driver will most likely built as a module, and not probed
until we get to userspace (after late_initcall)

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/base/power/domain.c      | 10 ++++++++++
 drivers/clk/qcom/dispcc-sdm845.c |  2 +-
 drivers/clk/qcom/gdsc.c          |  5 +++++
 drivers/clk/qcom/gdsc.h          |  1 +
 include/linux/pm_domain.h        |  4 ++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 33c30c1e6a30..513a8655fbd7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -537,6 +537,16 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			not_suspended++;
 	}
 
+	/*
+	 * If the power domain is enabled by the bootloader (for example
+	 * display enabled by bootloader), but no devices attached yet
+	 * (perhaps because driver built as kernel module), then do not
+	 * suspend.
+	 */
+	if ((genpd->flags & GENPD_FLAG_INHERIT_BL) &&
+		list_empty(&genpd->dev_list))
+		not_suspended++;
+
 	if (not_suspended > 1 || (not_suspended == 1 && !one_dev_on))
 		return -EBUSY;
 
diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 40d7e0ab4340..1d9365ac2315 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -575,7 +575,7 @@ static struct gdsc mdss_gdsc = {
 		.name = "mdss_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | POLL_CFG_GDSCR,
+	.flags = HW_CTRL | POLL_CFG_GDSCR | INHERIT_BL,
 };
 
 static struct clk_regmap *disp_cc_sdm845_clocks[] = {
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index a250f59708d8..4639fbeb9a7f 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -331,6 +331,11 @@ static int gdsc_init(struct gdsc *sc)
 	if ((sc->flags & VOTABLE) && on)
 		gdsc_enable(&sc->pd);
 
+	if ((sc->flags & INHERIT_BL) && on) {
+		pr_debug("gdsc: %s is enabled from bootloader!\n", sc->pd.name);
+		sc->pd.flags |= GENPD_FLAG_INHERIT_BL;
+	}
+
 	/* If ALWAYS_ON GDSCs are not ON, turn them ON */
 	if (sc->flags & ALWAYS_ON) {
 		if (!on)
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 64cdc8cf0d4d..c6fe56247399 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -49,6 +49,7 @@ struct gdsc {
 #define AON_RESET	BIT(4)
 #define POLL_CFG_GDSCR	BIT(5)
 #define ALWAYS_ON	BIT(6)
+#define INHERIT_BL	BIT(7)
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 91d9bf497071..5e421afcf6f3 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -55,6 +55,9 @@
  *
  * GENPD_FLAG_RPM_ALWAYS_ON:	Instructs genpd to always keep the PM domain
  *				powered on except for system suspend.
+ *
+ * GENPD_FLAG_INHERIT_BL:	The bootloader has already enabled this power
+ * 				domain.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -62,6 +65,7 @@
 #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
+#define GENPD_FLAG_INHERIT_BL	 (1U << 6)
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-- 
2.20.1

