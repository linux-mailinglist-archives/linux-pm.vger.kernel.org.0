Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E4DD9480
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404348AbfJPO6N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 10:58:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60048 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404209AbfJPO6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 10:58:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191016145812euoutp0115f230451b9a42f27c33fcc4249450a8~OKInDJ2K52498824988euoutp01M
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 14:58:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191016145812euoutp0115f230451b9a42f27c33fcc4249450a8~OKInDJ2K52498824988euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571237892;
        bh=npsMRlPCvAjERndPi6aVTpcLHbunxqY2gqRJlA+ftlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDPLlO7vp6oUUw1Vfpf6+7AXlCBKpeoJ/MGBj2jNbss0/7P063LNGGhcEN2MLwg6s
         jv+Q2rPmjP6V0rjS0VYbjg+KpzQr12eZyHzzefKNtTF2LBMc9ZrVRd22VJHM1NKEHu
         OURChDkXFe9Z5VAgFmD7xa4dnt334OyXbiCDr7to=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191016145811eucas1p238df4f0177bc485d1e37255808fec8b1~OKImi9KPD1049210492eucas1p2I;
        Wed, 16 Oct 2019 14:58:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.FF.04309.30037AD5; Wed, 16
        Oct 2019 15:58:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191016145810eucas1p1b31400c9b2e7f30cdf6deeb4ccee2788~OKIl8wPlF1564915649eucas1p1o;
        Wed, 16 Oct 2019 14:58:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191016145810eusmtrp2f2fd6aacdac955291da74dbe3015679b~OKIl8GArI2395523955eusmtrp2d;
        Wed, 16 Oct 2019 14:58:10 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-2c-5da730034f60
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.0E.04166.20037AD5; Wed, 16
        Oct 2019 15:58:10 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191016145810eusmtip27343922b19437c291376d950a423fc92~OKIlUZoki0643406434eusmtip2X;
        Wed, 16 Oct 2019 14:58:10 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, vireshk@kernel.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, roger.lu@mediatek.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v5 1/4] PM / OPP: Support adjusting OPP voltages at runtime
Date:   Wed, 16 Oct 2019 16:57:53 +0200
Message-Id: <20191016145756.16004-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016145756.16004-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHe3cuO1utjlPyzUJhKV4gL2V0QJEioVkIfSsU0aknlbYpm3c/
        KGp5N3XQhkkamtpK1GnmrYw5XeJl5GIIXjIssTErmpKX0jwerW+/53l/f57nfXkJRFiHuRBJ
        8lRaIZdIRTgf7RndnDqH+LdE+U+OnKU6Ne0YVW+YwiiTqYNL6ZYsGGWvMABKY3rDodoM81zq
        3msDlzIvdeLUsK0IozYmylBqx9KJUl2Lo/hlgdhcWcER67QluLirKVdcODaEiiu7tUBs17ne
        xCP4wfG0NCmdVviFxPATf41soSnL7pkL8814HihxLQUEAclAuGqVlAI+ISRbARwvNGFssQbg
        9xULpxTw9go7gLOqsMOA4QlgnRYAH0+1cv4FnpoNXCaAkwGwYqQSMAEnMgj+HDvJOAjZy4F5
        fTM44ziSN2BbQTFgGCU9YEGdep8Fe35vQz7GMCTd4POOtwjDPDIYaupe7A+DZDMXPrT1cFkp
        FJo3Bw7YEVqN3Qd8Bu721R8ECgAsH5jlskUVgB+NDYC1guCw8T3GrIqQ3rC9349tX4FfBnU4
        e+XjcGbVgWkje1jTo0bYtgAW3xeytjvc1qo5LLvAss+7KMtiuF07iLAP9ABAy/AfrAq41f4f
        1gCAFjjTaUpZAq08L6czfJUSmTJNnuAblyzTgb0/M75jXOsF/b9j9YAkgOiYYAVpiRJiknRl
        lkwPIIGInAT1hU1RQkG8JCubViRHK9KktFIPThOoyFmQc2QxUkgmSFLpuzSdQisOTzkEzyUP
        +HBs10zhpQM2qZcio+i66tYnL22cdbpm3RazslV99WX+lrPf1+WI6Ey4zQ23G98lXxh9Nbfx
        YzL0aOO4InuQ5xpqqb6tyjGbrKmaqomh3KTMR3MB6k3vsDuB6yE67xz9pQ+VJy4aar85ejXG
        nvKP8+3wDHZ4tqCa9vAsj/Qhs0WoMlES4IMolJK/+zyj1y8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t/xe7pMBstjDe59MLbYOGM9q8X8I+dY
        Lc6f38BusenxNVaLz71HGC1mnN/HZLH2yF12i9a9R9gtLj/eyGZx+E07q8WPM90sFv+ubWSx
        2PzgGJsDr8flvl4mj02rOtk8Ni+p92g5uZ/Fo2/LKkaPz5vkAtii9GyK8ktLUhUy8otLbJWi
        DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DK+H/3FUvBMpeLe3WVsDYydcl2M
        HBwSAiYSRxYydjFycQgJLGWU+P25gRkiLiUxv0Wpi5ETyBSW+HOtiw2i5hOjRN+m1UwgCTYB
        Q4neo32MIPUiAvYS27+JgNQwCxxikrhz9R0jSI2wgLfE2uYOMJtFQFWiec50MJtXwFpix4Im
        VogF8hKrNxxgBrE5BWwkZsxZAzZfCKjm9KUVrBMY+RYwMqxiFEktLc5Nzy021CtOzC0uzUvX
        S87P3cQIDPptx35u3sF4aWPwIUYBDkYlHt4JjMtjhVgTy4orcw8xSnAwK4nwzm9ZEivEm5JY
        WZValB9fVJqTWnyI0RToqInMUqLJ+cCIzCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKa
        nZpakFoE08fEwSnVwBh074dZAdtK+1UrndPnMRn3fNzMmH1jjmF1NK+t3vTK1T8XHr2yNNtx
        wuwfv29vz7tyZnvYBMa5N697hDy/J6w81+GW7gPZiJjtYdxzvH+eOSXQaih6J/KNf/EWJedJ
        bI+KIi2FN+w9UfNLbFVSUoDyR6s53Kz5Fr4XvkYfbc7NzVdoliltL1diKc5INNRiLipOBACA
        obXEkAIAAA==
X-CMS-MailID: 20191016145810eucas1p1b31400c9b2e7f30cdf6deeb4ccee2788
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191016145810eucas1p1b31400c9b2e7f30cdf6deeb4ccee2788
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191016145810eucas1p1b31400c9b2e7f30cdf6deeb4ccee2788
References: <20191016145756.16004-1-s.nawrocki@samsung.com>
        <CGME20191016145810eucas1p1b31400c9b2e7f30cdf6deeb4ccee2788@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

On some SoCs the Adaptive Voltage Scaling (AVS) technique is
employed to optimize the operating voltage of a device. At a
given frequency, the hardware monitors dynamic factors and either
makes a suggestion for how much to adjust a voltage for the
current frequency, or it automatically adjusts the voltage
without software intervention. Add an API to the OPP library for
the former case, so that AVS type devices can update the voltages
for an OPP when the hardware determines the voltage should
change. The assumption is that drivers like CPUfreq or devfreq
will register for the OPP notifiers and adjust the voltage
according to suggestions that AVS makes.

This patch is derived from [1] submitted by Stephen.
[1] https://lore.kernel.org/patchwork/patch/599279/

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
[s.nawrocki@samsung.com: added handling of OPP min/max voltage]
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/opp/core.c     | 69 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 13 ++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3b7ffd0234e9..f38b3be85072 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2112,6 +2112,75 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	return r;
 }

+/**
+ * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
+ * @dev:		device for which we do this operation
+ * @freq:		OPP frequency to adjust voltage of
+ * @u_volt:		new OPP target voltage
+ * @u_volt_min:		new OPP min voltage
+ * @u_volt_max:		new OPP max voltage
+ *
+ * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
+ * copy operation, returns 0 if no modifcation was done OR modification was
+ * successful.
+ */
+int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt, unsigned long u_volt_min,
+			      unsigned long u_volt_max)
+
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *tmp_opp, *opp = ERR_PTR(-ENODEV);
+	int r = 0;
+
+	/* Find the opp_table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		r = PTR_ERR(opp_table);
+		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
+		return r;
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	/* Do we have the frequency? */
+	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
+		if (tmp_opp->rate == freq) {
+			opp = tmp_opp;
+			break;
+		}
+	}
+
+	if (IS_ERR(opp)) {
+		r = PTR_ERR(opp);
+		goto adjust_unlock;
+	}
+
+	/* Is update really needed? */
+	if (opp->supplies->u_volt == u_volt)
+		goto adjust_unlock;
+
+	opp->supplies->u_volt = u_volt;
+	opp->supplies->u_volt_min = u_volt_min;
+	opp->supplies->u_volt_max = u_volt_max;
+
+	dev_pm_opp_get(opp);
+	mutex_unlock(&opp_table->lock);
+
+	/* Notify the voltage change of the OPP */
+	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADJUST_VOLTAGE,
+				     opp);
+
+	dev_pm_opp_put(opp);
+	goto adjust_put_table;
+
+adjust_unlock:
+	mutex_unlock(&opp_table->lock);
+adjust_put_table:
+	dev_pm_opp_put_opp_table(opp_table);
+	return r;
+}
+
 /**
  * dev_pm_opp_enable() - Enable a specific OPP
  * @dev:	device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b8197ab014f2..747861816f4f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -22,6 +22,7 @@ struct opp_table;

 enum dev_pm_opp_event {
 	OPP_EVENT_ADD, OPP_EVENT_REMOVE, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE,
+	OPP_EVENT_ADJUST_VOLTAGE,
 };

 /**
@@ -113,6 +114,10 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq,
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
 void dev_pm_opp_remove_all_dynamic(struct device *dev);

+int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt, unsigned long u_volt_min,
+			      unsigned long u_volt_max);
+
 int dev_pm_opp_enable(struct device *dev, unsigned long freq);

 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
@@ -242,6 +247,14 @@ static inline void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
 }

+static inline int
+dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
+			  unsigned long u_volt, unsigned long u_volt_min,
+			  unsigned long u_volt_max)
+{
+	return 0;
+}
+
 static inline int dev_pm_opp_enable(struct device *dev, unsigned long freq)
 {
 	return 0;
--
2.17.1

