Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABA926640E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgIKQad (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 12:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgIKQ1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Sep 2020 12:27:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63715221ED;
        Fri, 11 Sep 2020 16:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599841658;
        bh=PdARNYmSWwEuVmkx5vGlCCUPcCAIbjbSdbiCxqmb/yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRChD94VHG0MWSmsAO44Iy3TLiflAlrva4/J9DYhz2qGiK1IjJGqt5QDhORnuntRX
         AaLlPzpmPQkmusDhJfF+gPR6eZsl2M0amJuYeDuwQA4ImpVr9phP3AgaWwzNHHQfcx
         b1neAFM1fXjQwu43/saHl1KPkuNAAoy01vvMhDww=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/7] power: supply: bq25890: skip 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Fri, 11 Sep 2020 18:27:25 +0200
Message-Id: <20200911162729.3022-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911162729.3022-1-krzk@kernel.org>
References: <20200911162729.3022-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI, the
struct acpi_device_id becomes unused:

  drivers/power/supply/bq25890_charger.c:1076:36: warning:
    'bq25890_acpi_match' defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq25890_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 77150667e36b..74b129ddc298 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1073,11 +1073,13 @@ static const struct of_device_id bq25890_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, bq25890_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id bq25890_acpi_match[] = {
 	{"BQ258900", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bq25890_acpi_match);
+#endif
 
 static struct i2c_driver bq25890_driver = {
 	.driver = {
-- 
2.17.1

