Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E163297E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 09:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfFCH1b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 03:27:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37221 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFCH1b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 03:27:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id m15so12735046lfh.4;
        Mon, 03 Jun 2019 00:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nSu1azrQAf4/ue6uKP0pX9GgPp8MgyoBs3eoUYj3AFU=;
        b=n4lPvfvrAr8cPktUHW6ItREvwHSPHAIH5r65ZHdYzTo/fRMI7w/VOHx7Df2ZfhpL2N
         qu0zy169Vh5ar3f3JD+/Ita1a09RYqqotNEiH/Svw15wXQ+GCeomkMaF0bReMAlORKH1
         /rBhqGME1XZz5Zcpyzg3UMvpQQ7smhUOYPMtN1PVFJKoXMVF3D3mV7276mBo0+sES2H5
         ipLAJvyebpdcqlOVYpQAXIJAGrPMD8QNaLJp1zy6YWq0jdp1umBmhXsdEKB3qfMuqsCp
         zvYzM/Z8xZcTi/Y54WyGb1HfYINZKpfEQIN2u7ejIlEKov6J9oYwtdBmhE514wyke4rF
         eZMQ==
X-Gm-Message-State: APjAAAXeWrQuog17SrDSd/uf7oewOZ/ZR0yfUg3wsg3djmfkzvdvz18J
        yFIA/vKDfhcCQurei/T6CFg=
X-Google-Smtp-Source: APXvYqzL/Fg3VMyRK5z34OyqXi2MFYGnwKbALbU3Hk89LnFOjlsx+u9US6LuMsu7BqbJrk/0jBPYJg==
X-Received: by 2002:a19:7110:: with SMTP id m16mr12930440lfc.4.1559546846745;
        Mon, 03 Jun 2019 00:27:26 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c8sm3020679ljk.77.2019.06.03.00.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 00:27:26 -0700 (PDT)
Date:   Mon, 3 Jun 2019 10:27:14 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v15 6/7] rtc: bd70528: Initial support for ROHM bd70528 RTC
Message-ID: <03ea1b66512f589f60ad75f0291c6a4183ce6491.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support RTC block in ROHM bd70528 power management IC. Support
getting and setting the time and date as well as arming an alarm
which can also be used to wake the PMIC from standby state.

HW supports wake interrupt only for the next 24 hours (sec, minute
and hour information only) so we limit also the alarm interrupt to
this 24 hours for the sake of consistency.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Unchanged from v14

 drivers/rtc/Kconfig       |   8 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-bd70528.c | 500 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 509 insertions(+)
 create mode 100644 drivers/rtc/rtc-bd70528.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5c0790eed656..5528c478cf4e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -498,6 +498,14 @@ config RTC_DRV_M41T80_WDT
 	help
 	  If you say Y here you will get support for the
 	  watchdog timer in the ST M41T60 and M41T80 RTC chips series.
+config RTC_DRV_BD70528
+	tristate "ROHM BD70528 PMIC RTC"
+	help
+	  If you say Y here you will get support for the RTC
+	  on ROHM BD70528 Power Management IC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-bd70528.
 
 config RTC_DRV_BQ32K
 	tristate "TI BQ32000"
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 9d997faa2c26..6b09c21dc1b6 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_RTC_DRV_ASPEED)	+= rtc-aspeed.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
+obj-$(CONFIG_RTC_DRV_BD70528)	+= rtc-bd70528.o
 obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
 obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
new file mode 100644
index 000000000000..f9bdd555e1a2
--- /dev/null
+++ b/drivers/rtc/rtc-bd70528.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (C) 2018 ROHM Semiconductors
+//
+// RTC driver for ROHM BD70528 PMIC
+
+#include <linux/bcd.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+/*
+ * We read regs RTC_SEC => RTC_YEAR
+ * this struct is ordered according to chip registers.
+ * Keep it u8 only to avoid padding issues.
+ */
+struct bd70528_rtc_day {
+	u8 sec;
+	u8 min;
+	u8 hour;
+} __packed;
+
+struct bd70528_rtc_data {
+	struct bd70528_rtc_day time;
+	u8 week;
+	u8 day;
+	u8 month;
+	u8 year;
+} __packed;
+
+struct bd70528_rtc_wake {
+	struct bd70528_rtc_day time;
+	u8 ctrl;
+} __packed;
+
+struct bd70528_rtc_alm {
+	struct bd70528_rtc_data data;
+	u8 alm_mask;
+	u8 alm_repeat;
+} __packed;
+
+struct bd70528_rtc {
+	struct rohm_regmap_dev *mfd;
+	struct device *dev;
+};
+
+static int bd70528_set_wake(struct rohm_regmap_dev *bd70528,
+			    int enable, int *old_state)
+{
+	int ret;
+	unsigned int ctrl_reg;
+
+	ret = regmap_read(bd70528->regmap, BD70528_REG_WAKE_EN, &ctrl_reg);
+	if (ret)
+		return ret;
+
+	if (old_state) {
+		if (ctrl_reg & BD70528_MASK_WAKE_EN)
+			*old_state |= BD70528_WAKE_STATE_BIT;
+		else
+			*old_state &= ~BD70528_WAKE_STATE_BIT;
+
+		if (!enable == !(*old_state & BD70528_WAKE_STATE_BIT))
+			return 0;
+	}
+
+	if (enable)
+		ctrl_reg |= BD70528_MASK_WAKE_EN;
+	else
+		ctrl_reg &= ~BD70528_MASK_WAKE_EN;
+
+	return regmap_write(bd70528->regmap, BD70528_REG_WAKE_EN,
+			    ctrl_reg);
+}
+
+static int bd70528_set_elapsed_tmr(struct rohm_regmap_dev *bd70528,
+				   int enable, int *old_state)
+{
+	int ret;
+	unsigned int ctrl_reg;
+
+	/*
+	 * TBD
+	 * What is the purpose of elapsed timer ?
+	 * Is the timeout registers counting down, or is the disable - re-enable
+	 * going to restart the elapsed-time counting? If counting is restarted
+	 * the timeout should be decreased by the amount of time that has
+	 * elapsed since starting the timer. Maybe we should store the monotonic
+	 * clock value when timer is started so that if RTC is set while timer
+	 * is armed we could do the compensation. This is a hack if RTC/system
+	 * clk are drifting. OTOH, RTC controlled via I2C is in any case
+	 * inaccurate...
+	 */
+	ret = regmap_read(bd70528->regmap, BD70528_REG_ELAPSED_TIMER_EN,
+			  &ctrl_reg);
+	if (ret)
+		return ret;
+
+	if (old_state) {
+		if (ctrl_reg & BD70528_MASK_ELAPSED_TIMER_EN)
+			*old_state |= BD70528_ELAPSED_STATE_BIT;
+		else
+			*old_state &= ~BD70528_ELAPSED_STATE_BIT;
+
+		if ((!enable) == (!(*old_state & BD70528_ELAPSED_STATE_BIT)))
+			return 0;
+	}
+
+	if (enable)
+		ctrl_reg |= BD70528_MASK_ELAPSED_TIMER_EN;
+	else
+		ctrl_reg &= ~BD70528_MASK_ELAPSED_TIMER_EN;
+
+	return regmap_write(bd70528->regmap, BD70528_REG_ELAPSED_TIMER_EN,
+			    ctrl_reg);
+}
+
+static int bd70528_set_rtc_based_timers(struct bd70528_rtc *r, int new_state,
+					int *old_state)
+{
+	int ret;
+
+	ret = bd70528_wdt_set(r->mfd, new_state & BD70528_WDT_STATE_BIT,
+			      old_state);
+	if (ret) {
+		dev_err(r->dev,
+			"Failed to disable WDG for RTC setting (%d)\n", ret);
+		return ret;
+	}
+	ret = bd70528_set_elapsed_tmr(r->mfd,
+				      new_state & BD70528_ELAPSED_STATE_BIT,
+				      old_state);
+	if (ret) {
+		dev_err(r->dev,
+			"Failed to disable 'elapsed timer' for RTC setting\n");
+		return ret;
+	}
+	ret = bd70528_set_wake(r->mfd, new_state & BD70528_WAKE_STATE_BIT,
+			       old_state);
+	if (ret) {
+		dev_err(r->dev,
+			"Failed to disable 'wake timer' for RTC setting\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int bd70528_re_enable_rtc_based_timers(struct bd70528_rtc *r,
+					      int old_state)
+{
+	return bd70528_set_rtc_based_timers(r, old_state, NULL);
+}
+
+static int bd70528_disable_rtc_based_timers(struct bd70528_rtc *r,
+					    int *old_state)
+{
+	return bd70528_set_rtc_based_timers(r, 0, old_state);
+}
+
+static inline void tmday2rtc(struct rtc_time *t, struct bd70528_rtc_day *d)
+{
+	d->sec &= ~BD70528_MASK_RTC_SEC;
+	d->min &= ~BD70528_MASK_RTC_MINUTE;
+	d->hour &= ~BD70528_MASK_RTC_HOUR;
+	d->sec |= bin2bcd(t->tm_sec);
+	d->min |= bin2bcd(t->tm_min);
+	d->hour |= bin2bcd(t->tm_hour);
+}
+
+static inline void tm2rtc(struct rtc_time *t, struct bd70528_rtc_data *r)
+{
+	r->day &= ~BD70528_MASK_RTC_DAY;
+	r->week &= ~BD70528_MASK_RTC_WEEK;
+	r->month &= ~BD70528_MASK_RTC_MONTH;
+	/*
+	 * PM and 24H bits are not used by Wake - thus we clear them
+	 * here and not in tmday2rtc() which is also used by wake.
+	 */
+	r->time.hour &= ~(BD70528_MASK_RTC_HOUR_PM | BD70528_MASK_RTC_HOUR_24H);
+
+	tmday2rtc(t, &r->time);
+	/*
+	 * We do always set time in 24H mode.
+	 */
+	r->time.hour |= BD70528_MASK_RTC_HOUR_24H;
+	r->day |= bin2bcd(t->tm_mday);
+	r->week |= bin2bcd(t->tm_wday);
+	r->month |= bin2bcd(t->tm_mon + 1);
+	r->year = bin2bcd(t->tm_year - 100);
+}
+
+static inline void rtc2tm(struct bd70528_rtc_data *r, struct rtc_time *t)
+{
+	t->tm_sec = bcd2bin(r->time.sec & BD70528_MASK_RTC_SEC);
+	t->tm_min = bcd2bin(r->time.min & BD70528_MASK_RTC_MINUTE);
+	t->tm_hour = bcd2bin(r->time.hour & BD70528_MASK_RTC_HOUR);
+	/*
+	 * If RTC is in 12H mode, then bit BD70528_MASK_RTC_HOUR_PM
+	 * is not BCD value but tells whether it is AM or PM
+	 */
+	if (!(r->time.hour & BD70528_MASK_RTC_HOUR_24H)) {
+		t->tm_hour %= 12;
+		if (r->time.hour & BD70528_MASK_RTC_HOUR_PM)
+			t->tm_hour += 12;
+	}
+	t->tm_mday = bcd2bin(r->day & BD70528_MASK_RTC_DAY);
+	t->tm_mon = bcd2bin(r->month & BD70528_MASK_RTC_MONTH) - 1;
+	t->tm_year = 100 + bcd2bin(r->year & BD70528_MASK_RTC_YEAR);
+	t->tm_wday = bcd2bin(r->week & BD70528_MASK_RTC_WEEK);
+}
+
+static int bd70528_set_alarm(struct device *dev, struct rtc_wkalrm *a)
+{
+	struct bd70528_rtc_wake wake;
+	struct bd70528_rtc_alm alm;
+	int ret;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+	struct rohm_regmap_dev *bd70528 = r->mfd;
+
+	ret = regmap_bulk_read(bd70528->regmap, BD70528_REG_RTC_WAKE_START,
+			       &wake, sizeof(wake));
+	if (ret) {
+		dev_err(dev, "Failed to read wake regs\n");
+		return ret;
+	}
+
+	ret = regmap_bulk_read(bd70528->regmap, BD70528_REG_RTC_ALM_START,
+			       &alm, sizeof(alm));
+	if (ret) {
+		dev_err(dev, "Failed to read alarm regs\n");
+		return ret;
+	}
+
+	tm2rtc(&a->time, &alm.data);
+	tmday2rtc(&a->time, &wake.time);
+
+	if (a->enabled) {
+		alm.alm_mask &= ~BD70528_MASK_ALM_EN;
+		wake.ctrl |= BD70528_MASK_WAKE_EN;
+	} else {
+		alm.alm_mask |= BD70528_MASK_ALM_EN;
+		wake.ctrl &= ~BD70528_MASK_WAKE_EN;
+	}
+
+	ret = regmap_bulk_write(bd70528->regmap,
+				BD70528_REG_RTC_WAKE_START, &wake,
+				sizeof(wake));
+	if (ret) {
+		dev_err(dev, "Failed to set wake time\n");
+		return ret;
+	}
+	ret = regmap_bulk_write(bd70528->regmap, BD70528_REG_RTC_ALM_START,
+				&alm, sizeof(alm));
+	if (ret)
+		dev_err(dev, "Failed to set alarm time\n");
+
+	return ret;
+}
+
+static int bd70528_read_alarm(struct device *dev, struct rtc_wkalrm *a)
+{
+	struct bd70528_rtc_alm alm;
+	int ret;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+	struct rohm_regmap_dev *bd70528 = r->mfd;
+
+	ret = regmap_bulk_read(bd70528->regmap, BD70528_REG_RTC_ALM_START,
+			       &alm, sizeof(alm));
+	if (ret) {
+		dev_err(dev, "Failed to read alarm regs\n");
+		return ret;
+	}
+
+	rtc2tm(&alm.data, &a->time);
+	a->time.tm_mday = -1;
+	a->time.tm_mon = -1;
+	a->time.tm_year = -1;
+	a->enabled = !(alm.alm_mask & BD70528_MASK_ALM_EN);
+	a->pending = 0;
+
+	return 0;
+}
+
+static int bd70528_set_time_locked(struct device *dev, struct rtc_time *t)
+{
+	int ret, tmpret, old_states;
+	struct bd70528_rtc_data rtc_data;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+	struct rohm_regmap_dev *bd70528 = r->mfd;
+
+	ret = bd70528_disable_rtc_based_timers(r, &old_states);
+	if (ret)
+		return ret;
+
+	tmpret = regmap_bulk_read(bd70528->regmap,
+				  BD70528_REG_RTC_START, &rtc_data,
+				  sizeof(rtc_data));
+	if (tmpret) {
+		dev_err(dev, "Failed to read RTC time registers\n");
+		goto renable_out;
+	}
+	tm2rtc(t, &rtc_data);
+
+	tmpret = regmap_bulk_write(bd70528->regmap,
+				   BD70528_REG_RTC_START, &rtc_data,
+				   sizeof(rtc_data));
+	if (tmpret) {
+		dev_err(dev, "Failed to set RTC time\n");
+		goto renable_out;
+	}
+
+renable_out:
+	ret = bd70528_re_enable_rtc_based_timers(r, old_states);
+	if (tmpret)
+		ret = tmpret;
+
+	return ret;
+}
+
+static int bd70528_set_time(struct device *dev, struct rtc_time *t)
+{
+	int ret;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+
+	bd70528_wdt_lock(r->mfd);
+	ret = bd70528_set_time_locked(dev, t);
+	bd70528_wdt_unlock(r->mfd);
+	return ret;
+}
+
+static int bd70528_get_time(struct device *dev, struct rtc_time *t)
+{
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+	struct rohm_regmap_dev *bd70528 = r->mfd;
+	struct bd70528_rtc_data rtc_data;
+	int ret;
+
+	/* read the RTC date and time registers all at once */
+	ret = regmap_bulk_read(bd70528->regmap,
+			       BD70528_REG_RTC_START, &rtc_data,
+			       sizeof(rtc_data));
+	if (ret) {
+		dev_err(dev, "Failed to read RTC time (err %d)\n", ret);
+		return ret;
+	}
+
+	rtc2tm(&rtc_data, t);
+
+	return 0;
+}
+
+static int bd70528_alm_enable(struct device *dev, unsigned int enabled)
+{
+	int ret;
+	unsigned int enableval = BD70528_MASK_ALM_EN;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+
+	if (enabled)
+		enableval = 0;
+
+	bd70528_wdt_lock(r->mfd);
+	ret = bd70528_set_wake(r->mfd, enabled, NULL);
+	if (ret) {
+		dev_err(dev, "Failed to change wake state\n");
+		goto out_unlock;
+	}
+	ret = regmap_update_bits(r->mfd->regmap, BD70528_REG_RTC_ALM_MASK,
+				 BD70528_MASK_ALM_EN, enableval);
+	if (ret)
+		dev_err(dev, "Failed to change alarm state\n");
+
+out_unlock:
+	bd70528_wdt_unlock(r->mfd);
+	return ret;
+}
+
+static const struct rtc_class_ops bd70528_rtc_ops = {
+	.read_time		= bd70528_get_time,
+	.set_time		= bd70528_set_time,
+	.read_alarm		= bd70528_read_alarm,
+	.set_alarm		= bd70528_set_alarm,
+	.alarm_irq_enable	= bd70528_alm_enable,
+};
+
+static irqreturn_t alm_hndlr(int irq, void *data)
+{
+	struct rtc_device *rtc = data;
+
+	rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF | RTC_PF);
+	return IRQ_HANDLED;
+}
+
+static int bd70528_probe(struct platform_device *pdev)
+{
+	struct bd70528_rtc *bd_rtc;
+	struct rohm_regmap_dev *mfd;
+	int ret;
+	struct rtc_device *rtc;
+	int irq;
+	unsigned int hr;
+
+	mfd = dev_get_drvdata(pdev->dev.parent);
+	if (!mfd) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+	bd_rtc = devm_kzalloc(&pdev->dev, sizeof(*bd_rtc), GFP_KERNEL);
+	if (!bd_rtc)
+		return -ENOMEM;
+
+	bd_rtc->mfd = mfd;
+	bd_rtc->dev = &pdev->dev;
+
+	irq = platform_get_irq_byname(pdev, "bd70528-rtc-alm");
+
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq\n");
+		return irq;
+	}
+
+	platform_set_drvdata(pdev, bd_rtc);
+
+	ret = regmap_read(mfd->regmap, BD70528_REG_RTC_HOUR, &hr);
+
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to reag RTC clock\n");
+		return ret;
+	}
+
+	if (!(hr & BD70528_MASK_RTC_HOUR_24H)) {
+		struct rtc_time t;
+
+		ret = bd70528_get_time(&pdev->dev, &t);
+
+		if (!ret)
+			ret = bd70528_set_time(&pdev->dev, &t);
+
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Setting 24H clock for RTC failed\n");
+			return ret;
+		}
+	}
+
+	device_set_wakeup_capable(&pdev->dev, true);
+	device_wakeup_enable(&pdev->dev);
+
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc)) {
+		dev_err(&pdev->dev, "RTC device creation failed\n");
+		return PTR_ERR(rtc);
+	}
+
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->ops = &bd70528_rtc_ops;
+
+	/* Request alarm IRQ prior to registerig the RTC */
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, &alm_hndlr,
+					IRQF_ONESHOT, "bd70528-rtc", rtc);
+	if (ret)
+		return ret;
+
+	/*
+	 *  BD70528 irq controller is not touching the main mask register.
+	 *  So enable the RTC block interrupts at main level. We can just
+	 *  leave them enabled as irq-controller should disable irqs
+	 *  from sub-registers when IRQ is disabled or freed.
+	 */
+	ret = regmap_update_bits(mfd->regmap,
+				 BD70528_REG_INT_MAIN_MASK,
+				 BD70528_INT_RTC_MASK, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable RTC interrupts\n");
+		return ret;
+	}
+
+	ret = rtc_register_device(rtc);
+	if (ret)
+		dev_err(&pdev->dev, "Registering RTC failed\n");
+
+	return ret;
+}
+
+static struct platform_driver bd70528_rtc = {
+	.driver = {
+		.name = "bd70528-rtc"
+	},
+	.probe = bd70528_probe,
+};
+
+module_platform_driver(bd70528_rtc);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.2


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
