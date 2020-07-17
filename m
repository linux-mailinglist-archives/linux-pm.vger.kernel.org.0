Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9841F223300
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 07:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgGQFgG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 01:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGQFgG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 01:36:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FE0C061755;
        Thu, 16 Jul 2020 22:36:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so6159257pgf.0;
        Thu, 16 Jul 2020 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eA3Lf6COMI1mRdEISSrMmP+BQVZuKaEAQpawnMHSLTY=;
        b=s9HshUZktEiSYfzjp3zRVa2ZtVXIhp9xE3GxfylP5oCAwROIvMR+erownZINvvH/of
         UPrFetK44e7NdjDw2rOMqCx8UV4LsypMjdIfAs3sUlWUqglGs33lbuqg72MhaZnjGNJW
         9KbzLnjv5G9+fn+xFsKezsXh0nrb5REJrNvEvHUsSjGX04wC+IvevZsmBdcGyixNw+ka
         ob8I4cyPom95ydUoO2eNyKqyUGIbUManMgN3fFTZuqM+fHIcJV68qSWgpABkHW/vdc0Y
         qFbrPLw0ymet2ZbYoNIu5LsBZykJ0j12CYwIwJRHUVUPBhJCdMNYPEcj0hXPRyHmKk1k
         hKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eA3Lf6COMI1mRdEISSrMmP+BQVZuKaEAQpawnMHSLTY=;
        b=C5KyAz4bkIIFVZgsyYt86LWEuJpRWTOTPrONeCheE48lsOjdOue9LApykV2fs43bVz
         il9dpY6MwkgfT23QjDz6VnMDe6JRUsug1nW2prBltIPI5apWYBAGld8yOKYza90ZOo0d
         H1ZQlSNnIOQgN82ykCw2P25A1NyykenNpwyP6/Bfu2KMS9rZUHc7YxUNwyIE5HPpenXZ
         rfk4jnpIlRMhzH3rc15JJ+ulQ/67R5Tjzu4MDEGw/0fsqzJC6B4kWj4nVHTRcw0GnFa6
         BLe8cE4GfzBRK6fPPWdJKFVrI7FOBweDEJHiOsZLkB90sXSvwtOHsdGsMh4Hjc/QJd5Y
         fXKQ==
X-Gm-Message-State: AOAM532U1ukgmnYKiuiXgDwO9MizonZjBKBhPRjogSp/sQXlvB0cDbAy
        A9HP5OFPpUy4Fu6fnuajeuo=
X-Google-Smtp-Source: ABdhPJz53Mm4B4QiZVs52GLL3rM/VzxKRz4dJGgO0eNfa/WdyxSl2yx/iWryf9N+jHARm7CezJ6Y4g==
X-Received: by 2002:a65:5c43:: with SMTP id v3mr7127271pgr.214.1594964165758;
        Thu, 16 Jul 2020 22:36:05 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s14sm483511pjl.14.2020.07.16.22.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 22:36:04 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen Yongzhi <yongzhi.chen@unisoc.com>
Subject: [PATCH] power: supply: sc27xx: prevent adc * 1000 from overflow
Date:   Fri, 17 Jul 2020 13:35:46 +0800
Message-Id: <20200717053546.7981-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The input parameter is int type, cause adc * 1000 could overflow.
Change to use s64 to avoid this issue.

Fixes: 195ca1703784 ("power: supply: Add Spreadtrum SC27XX fuel gauge unit driver")
Signed-off-by: Chen Yongzhi <yongzhi.chen@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index be42e814ea34..a9838a2a673d 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -133,12 +133,12 @@ static const char * const sc27xx_charger_supply_name[] = {
 	"sc2723_charger",
 };
 
-static int sc27xx_fgu_adc_to_current(struct sc27xx_fgu_data *data, int adc)
+static int sc27xx_fgu_adc_to_current(struct sc27xx_fgu_data *data, s64 adc)
 {
 	return DIV_ROUND_CLOSEST(adc * 1000, data->cur_1000ma_adc);
 }
 
-static int sc27xx_fgu_adc_to_voltage(struct sc27xx_fgu_data *data, int adc)
+static int sc27xx_fgu_adc_to_voltage(struct sc27xx_fgu_data *data, s64 adc)
 {
 	return DIV_ROUND_CLOSEST(adc * 1000, data->vol_1000mv_adc);
 }
-- 
2.20.1

