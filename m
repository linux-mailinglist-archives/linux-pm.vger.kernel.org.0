Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E051F0C1C
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 16:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgFGOpz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgFGOpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 10:45:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED0C08C5C3;
        Sun,  7 Jun 2020 07:45:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so17312093ljh.7;
        Sun, 07 Jun 2020 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V8hjnl7J75TBgREseCnpTfKZ6/8vTSO0YfrzAMW8j+Y=;
        b=V7kp/p+xPOSk54FW5XDENYYJc+8Qx20gXPfkMSmzghYsBUUTrlxXCLadiUbkhxNc9e
         LDLQjbXmppoBzZ2FwG+4Li9IqK2P7D37NT5x1oDpS09YPtatqEnoR/85Z40PIo8ge1gz
         rUJivIKQ7jVqketlbWKnjTxTpBqfwpXeJQUgiqTVee45sh+uWUQL82GcIj49/ytTrurk
         BbzNnRn5rAvEOT1KhknMhyarJNtFRrS8rvyYew2KpOT+Ql/H3Z8WC6z2Ni0+Fnm/dmoI
         nz0M8DjKwY8Hnkgwge857HAXEpX8hvWfC4Byx+u+B2M0qM41FZgvbfzEMWQmugJBcQFJ
         GEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V8hjnl7J75TBgREseCnpTfKZ6/8vTSO0YfrzAMW8j+Y=;
        b=tBtzCcFc7zZ4ScHkdpnO617uGWHh9dOyoDJ5cQmqfxCxC9v+dRVlEzgtEgHEQDTTEr
         pmql7Hu0ybNfB7ZnkRZzH9WrPTjgdjcQisXvf9WWGfMgoY9r4CuQE9VGjNlaBeyndTaI
         WAPLqAPLYeZSdCZDk3NiOE+MWORg5cXzTeYSD5paZ101Sm9TBMCVd8gigQ1kwIUzXA9x
         FFjmqeFcEU3NAAThBZvkvrwZPUmtQV3UwvNgSXUEC0d1a0qSx6uPmjdusTCllxRuyfeL
         PY5GBL1T/60t6AgBRcEsFzcfS1D7JSso1AigYnFEYOZx8mAnlEFnNiBEwrlRhN0a7vLt
         AfrQ==
X-Gm-Message-State: AOAM532KP3W4HVeP9Jgf9Qy2iRvTdhI80dRDUfwBUbLAdyqE02fLVOox
        P489y13JCpYrQGEcp2a5vNISScoJ
X-Google-Smtp-Source: ABdhPJxXZTroNVbRUnMl3S1YzL5uiXiCRxFtKp+WYoSbeN19JRapbT8ug/UFO3P+Jl+6r6PJ8DMb1A==
X-Received: by 2002:a2e:7011:: with SMTP id l17mr9769977ljc.424.1591541118774;
        Sun, 07 Jun 2020 07:45:18 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id g24sm4059724lfh.90.2020.06.07.07.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:45:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH v2 2/9] dt-bindings: battery: Add temperature properties
Date:   Sun,  7 Jun 2020 17:41:06 +0300
Message-Id: <20200607144113.10202-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607144113.10202-1-digetx@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document generic battery temperature properties.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/power/supply/battery.txt       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 5e29595edd74..e0c35eff9d3f 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -45,6 +45,16 @@ Optional Properties:
    and corresponding battery internal resistance percent, which is used to look
    up the resistance percent according to current temperature to get a accurate
    batterty internal resistance in different temperatures.
+ - temperature-ambient-min-alert-celsius: Alert when ambient temperature of a
+   battery is lower than threshold value.
+ - temperature-ambient-max-alert-celsius: Alert when ambient temperature of a
+   battery is higher than threshold value.
+ - temperature-min-alert-celsius: Alert when battery temperature is lower
+   than threshold value.
+ - temperature-max-alert-celsius: Alert when battery temperature is higher
+   than threshold value.
+ - temperature-min-celsius: minimum temperature at which battery can operate
+ - temperature-max-celsius: maximum temperature at which battery can operate
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
-- 
2.26.0

