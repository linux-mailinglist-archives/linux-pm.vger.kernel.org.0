Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A167C1B0049
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 05:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgDTDmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 23:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTDmn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 23:42:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F2C061A0C;
        Sun, 19 Apr 2020 20:42:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so4396778pgi.5;
        Sun, 19 Apr 2020 20:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZmbaW0s8Lq0BUJ+PzKbYmuUcRhk4c92Bhfoij2xYNoI=;
        b=X1n6Hw6NGwunwRUFC8MS5sgsDvf+q1ReIeXVsUF9L8rYueYTn3fRNsWomjcoA+iycy
         UTDC+Eisl6twcaiAfokSULe3KhXCbznTjVwr9Tex8wBOizSbAUDY3SUaLJ4t/clnErF1
         LwLbSIDX8186Wa+MVr/Ik81Zku1VmzspRSSsGxegUPuEfFRaLlK9sf/Yp/zFmn8DPCg4
         BrnrqDt+neG1aiQ7JukwCO0eS1H81flPSXT15KZ7X69r2kTjjIyygAJ4xJWaZbiIvOMm
         3NtCoIG9D28BETa5128w8K+uV1oX0KQPSvnaNlcZ0Q+GHTVY2tXzuQT8Q3jBXqZhZw19
         ZHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZmbaW0s8Lq0BUJ+PzKbYmuUcRhk4c92Bhfoij2xYNoI=;
        b=sEk/GHJ6pMTuWTqIzJekyD8v9bSR7vM/rjs4e26fnTnMPskqsqkGgF9RgoO4rO2yBQ
         lFm232uLJF2mh1zFCWXMzdacdGYLNei3CLoU1XymiutpDN0TMpensTAGb0awaMs/IT2T
         BzvgrNctr2s3a5dJXUTdci+XwhKbwTojGDIXK5OmRNatuJ2ADK9YVjorIYBUIubt2hjU
         64nzkWwLewaT90o8PJzFrsrpwbPcp5I/l+TouvOb4muiDhQSj7Zckkyb/s/3Mdm8zIxF
         iqFN3qmcvNArls2WmKqeUg27steRR6jok8KFXfU3Yal92fCa7yVISILulpAPSD3CCqUT
         0/mQ==
X-Gm-Message-State: AGi0PuZ1kzEaadiw/fLLwlurv3oogo4IuNHQtNLcCTZbEUIDbzGgDuV6
        gGmcrxx4S7PyhATcMt1CLvk=
X-Google-Smtp-Source: APiQypIYBAbgEjbWQ2GmqE9f6ikPln1mzkS9bKK8nNsHkjcPnusoaFvQ3lbb206N41PS5j5zjR+vkA==
X-Received: by 2002:a63:4e1d:: with SMTP id c29mr14964791pgb.235.1587354162133;
        Sun, 19 Apr 2020 20:42:42 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id d21sm12467660pjs.3.2020.04.19.20.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 20:42:41 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        yuanjiang.yu@unisoc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] power: supply: sc27xx: Add boot voltage support
Date:   Mon, 20 Apr 2020 11:42:07 +0800
Message-Id: <098bc90ca87402ba08cec6df81fe3465eeb10e00.1587353854.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587353854.git.baolin.wang7@gmail.com>
References: <cover.1587353854.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587353854.git.baolin.wang7@gmail.com>
References: <cover.1587353854.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Add new property to allow to get the voltage measured during boot time.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 82d0c64ef269..be42e814ea34 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -84,6 +84,7 @@
  * @init_clbcnt: the initial coulomb counter
  * @max_volt: the maximum constant input voltage in millivolt
  * @min_volt: the minimum drained battery voltage in microvolt
+ * @boot_volt: the voltage measured during boot in microvolt
  * @table_len: the capacity table length
  * @resist_table_len: the resistance table length
  * @cur_1000ma_adc: ADC value corresponding to 1000 mA
@@ -109,6 +110,7 @@ struct sc27xx_fgu_data {
 	int init_clbcnt;
 	int max_volt;
 	int min_volt;
+	int boot_volt;
 	int table_len;
 	int resist_table_len;
 	int cur_1000ma_adc;
@@ -321,6 +323,7 @@ static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, int *cap)
 
 	volt = sc27xx_fgu_adc_to_voltage(data, volt);
 	ocv = volt * 1000 - oci * data->internal_resist;
+	data->boot_volt = ocv;
 
 	/*
 	 * Parse the capacity table to look up the correct capacity percent
@@ -680,6 +683,10 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 		val->intval = value * 1000;
 		break;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_BOOT:
+		val->intval = data->boot_volt;
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -750,6 +757,7 @@ static enum power_supply_property sc27xx_fgu_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_BOOT,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
-- 
2.17.1

