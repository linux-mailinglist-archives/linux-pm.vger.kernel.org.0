Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C611389FA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 04:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgAMDxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 22:53:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39317 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387573AbgAMDxQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 22:53:16 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E534B21C1B;
        Sun, 12 Jan 2020 22:53:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 22:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=q6eO4lewzUTif
        9a/MG8leDfdHzrNguqpktR6OOxUJMU=; b=Kv7wO/vLYeGT56nfGEqESD2jaaS3C
        MuSRF+h/jxLKO3TslIObmxAj8i/GK6wlZPpsIYtVpFbcYAhpg16Tmf4lsciPVnNU
        0oMguwaiDczOU+DfAEuV0Vgj0N+pyv/pF998QWWt2JIiPpaf3xD/xAV4evNCCr1L
        L4FcntkrbgOti+mEK4Y6VT/0ma2nvHbh5tSqWHBp2Nz5CnAf/V9A7DGO+ZAB5Di1
        PpTZ4UiYHvsvlcEUE2E7nQ0fmCEnUYjfXLN+znh4hwVgqwuI+UEpDluEEi512EKO
        ghUacUGCsN4G27ZvSPL6AGv8YzqCWL9biZfhG2qsBf9XdQ575pnURmH6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=q6eO4lewzUTif9a/MG8leDfdHzrNguqpktR6OOxUJMU=; b=IMyl7FqM
        9ZJqh8b0QsQ6UwCNF8zEU9/BkucOdgZnF1B6rGDZlp5wOnzkW4SU5If0Aw31rv3A
        5xGbQtycWtcd87WI/+i25hGosGXfu4cuNa2TJ+QYWElOanQsjXOS6WPcPfhz/iAa
        f43NIsCetFp2XHWwLh1g8WOGOnueE/fpcGRVlco/FJ39aZYOXGtpMMgFsm+erpho
        Sy45uhMjxqRQN7Hs/WW1v1Lx5MlCTTp71FCsQhxqqTEXmdhhRd4wy92gvnpmAunL
        ga2T+2YKMVQa94hXfHNZg8kOXIrjjFi2NxIJMQ05Z84RYadXINrS0pwUoYHHBr/r
        fIyXQh0fK4uH+A==
X-ME-Sender: <xms:qukbXmUFAJaJnv3j5eVASnuAiJWE5W-d49rxF4CzfuqH9F6M7FdIMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qukbXpZvFxY884Xf-Pc_SmQtofYki9cGu1gAMzlg7izo4xRPHbGWJA>
    <xmx:qukbXjXdEEZzmccMDvod29QrF-0YZZ--xevpzYJZ6CX7hYwq0bVatA>
    <xmx:qukbXgKZyfYV8nwGecDpPOWbpEqaIWNEwXWFlZv7hKP8f-syem54-Q>
    <xmx:qukbXv8SQ47FyJk0cFP4N-GG8evdUqKBNN04EQxqS-DERbqmexOo6A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D2448005B;
        Sun, 12 Jan 2020 22:53:14 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 8/8] power: supply: axp20x_usb_power: Only poll while offline
Date:   Sun, 12 Jan 2020 21:53:10 -0600
Message-Id: <20200113035310.18950-9-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113035310.18950-1-samuel@sholland.org>
References: <20200113035310.18950-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Investigation on the AXP803 shows that VBUS_PLUGIN/VBUS_REMOVAL IRQs are
triggered on the rising/falling edge of AXP20X_PWR_STATUS_VBUS_USED. The
reason IRQs do not arrive while N_VBUSEN/DRIVEVBUS is high is because
AXP20X_PWR_STATUS_VBUS_USED also never goes high.

This also means that if VBUS is online, a VBUS_REMOVAL IRQ is received
immediately on setting N_VBUSEN/DRIVEVBUS high (and VBUS_PLUGIN shortly
after it is set back low). This was also verified to be the case when
manually offlining VBUS through AXP20X_VBUS_PATH_SELECT.

As long as VBUS is online, a present->absent transition necessarily
implies an online->offline transition. Since will cause an IRQ, there is
no need to poll while VBUS is online.

To ensure the driver's view of VBUS online status remains accurate,
unconditionally poll once when receiving an IRQ and when resuming. If
VBUS is still online at that time, polling will cease until the next
VBUS_REMOVAL IRQ.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 30 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 4292b86d0429..fbb66e97787d 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -66,16 +66,32 @@ struct axp20x_usb_power {
 	struct iio_channel *vbus_i;
 	struct delayed_work vbus_detect;
 	unsigned int old_status;
+	unsigned int online;
 	unsigned int num_irqs;
 	unsigned int irqs[];
 };
 
+static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
+{
+	/*
+	 * Polling is only necessary while VBUS is offline. While online, a
+	 * present->absent transition implies an online->offline transition
+	 * and will triger the VBUS_REMOVAL IRQ.
+	 */
+	if (power->axp20x_id >= AXP221_ID && !power->online)
+		return true;
+
+	return false;
+}
+
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
 {
 	struct axp20x_usb_power *power = devid;
 
 	power_supply_changed(power->supply);
 
+	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+
 	return IRQ_HANDLED;
 }
 
@@ -95,17 +111,11 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		power_supply_changed(power->supply);
 
 	power->old_status = val;
+	power->online = val & AXP20X_PWR_STATUS_VBUS_USED;
 
 out:
-	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
-}
-
-static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
-{
-	if (power->axp20x_id >= AXP221_ID)
-		return true;
-
-	return false;
+	if (axp20x_usb_vbus_needs_polling(power))
+		mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
 static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
@@ -513,6 +523,8 @@ static int axp20x_usb_power_resume(struct device *dev)
 	while (i < power->num_irqs)
 		enable_irq(power->irqs[i++]);
 
+	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+
 	return 0;
 }
 #endif
-- 
2.23.0

