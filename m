Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9AC2C17D5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 22:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgKWVmX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 16:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbgKWVmW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 16:42:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127CC061A4D
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 13:42:22 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so20333684wrw.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AN+diq6krUutxY4s1BjD5o/2cLxtj1QMMKMF7O1rYVo=;
        b=TMunjAZvezqNRjxxbJ02gu00nqa+UL1Sr0P24qsBWwWQit+/eyOfS4Uk25FGQsV5O7
         RI6hgMN7bRBIDD8bb38R0R8jj61Se6x6QmJSJnpCFMlhY04T9vwpNS+z8mp5noXKYdOh
         br1EMUUeTwBaR9UM1yiG59VyraUTIp5CHtXPa0k4LjZYoqtNG4wNm/bC1PJmQ+PXU/43
         2EvGCjpSWkmr+v6sTAvnAUS2xE1ece7nCW6mW6v7o7oK+vggLzyf9qk9eh233vn41Jl+
         QDZoT+hs4PcW8iqXR2qip0LQpWjQpVBFw1TY8nI0E7Z0r6rqU5jwazy+HQ7EX9DmSF+G
         +W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AN+diq6krUutxY4s1BjD5o/2cLxtj1QMMKMF7O1rYVo=;
        b=DJU/xcTX8GIuLUqgYzU3nxuu2xBNyZmkMtpjQW4Qn03nPEoBWhsjqbZgNmHpFnBjX5
         p9tgjcIAz5JbN8qGGIG0Iqs9qTViN+ryDCjgz39tdWUnBk1lFcbeiPDsaD2s3qrH92p0
         oaEQDwP9YvukGXAh1n8TxcciSjU3l0tVIYJg7RoOqCB43Ry5DfGiLUqWsHb21xgMA2AD
         z2WSQYUYyvZjdkVkCkaQmOuwpMxcFfpKAItBGdNK041ml+qMR0t0ViC4cPDZo9pUlykY
         UXabT3maVU2/xorlUTAm6zokybm9INEMNpuZdjiTAsgE3XYLoIfnYezONTMeM+sOvs1t
         fjGw==
X-Gm-Message-State: AOAM530VMMk6QOBjz87SMMY0mH7DJTfqh9yi5KAwAPJhcNc2Rr2JZCDj
        iOmVuPLHNqLhZPXd7gKN50FOFQ==
X-Google-Smtp-Source: ABdhPJxFePJV1k6mJ2KkXvQLWfPPsXf+ur+18a9B2mdsuCvtKNiYgvyQ0VNAivJO4RHYAC3AI5I0fg==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr1776131wru.404.1606167740649;
        Mon, 23 Nov 2020 13:42:20 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-164.adsl.proxad.net. [82.252.157.164])
        by smtp.gmail.com with ESMTPSA id 35sm22400598wro.71.2020.11.23.13.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 13:42:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, corbet@lwn.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilina@codeaurora.org, lukasz.luba@arm.com, rkumbako@codeaurora.org,
        rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] units: Add Watt units
Date:   Mon, 23 Nov 2020 22:42:05 +0100
Message-Id: <20201123214208.11007-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123214208.11007-1-daniel.lezcano@linaro.org>
References: <20201123214208.11007-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As there are the temperature units, let's add the Watt macros definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/units.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index aaf716364ec3..92c234e71cab 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,10 @@
 
 #include <linux/kernel.h>
 
+#define MILLIWATT_PER_WATT	1000L
+#define MICROWATT_PER_MILLIWATT	1000L
+#define MICROWATT_PER_WATT	1000000L
+
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
 static inline long milli_kelvin_to_millicelsius(long t)
-- 
2.17.1

