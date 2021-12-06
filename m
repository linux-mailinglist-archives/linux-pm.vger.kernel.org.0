Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11D469F4E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Dec 2021 16:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385722AbhLFPrC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Dec 2021 10:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390598AbhLFPmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Dec 2021 10:42:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC933C0698DE;
        Mon,  6 Dec 2021 07:29:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l16so23206007wrp.11;
        Mon, 06 Dec 2021 07:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XOlZ179JzCv5LqPw9a9LqaU5xYygHMHLSV5H8mIWsM=;
        b=XF/lsECkt8ZlU+BMdwteQ91T+r0KGA6y4eB5X66O2RmHv5o5zNlcTQoirRjdbrga1u
         54hf062+plRMHBQLtsqpTBfeOPzFUGKlzK63GnJ9iasdbc7WVVfEyR2VwNyfNRMRsM+e
         psOHOdmHEWPVzyU4Y3r5f22npyDhvi1GYaCKe5fZj5PGWQJWKJTcCcbEO+mzmfmm5UP3
         hzHtWFUVnpAFITiBM4k2kw49Ay8wXXxxEU8ThLfwNhRgZcn3B7B053k9VunK8jejh6RE
         8beSqpsb3S0shljnV/2V8b4WCh4LaOFMmJ+aiWwKcAuPBQO9QwYHnQ3v500qHWTkVdva
         +2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XOlZ179JzCv5LqPw9a9LqaU5xYygHMHLSV5H8mIWsM=;
        b=aZD7Ov02+AXROi6eLnXUjcdf5UFR+kQM4k9Cfrk6ki7HEkNIVAR1B8wv6Fk5XJNUjU
         4gsQc9WTeNXBEckpEOYQmq32kUb+y96oz191bwzjb8Qzk7juwVxMhWPDeaBFhqeZLZlA
         6vjmHUNZn+XSE4Af3aNgDpFvnTHp1bCGbxqwumJJJqZEp4NeNopL5dcI0Xzcn56TzhSf
         fKzk/FKEUNgfvrEJZy0p15ayMGorUbDwSsgF+vGKwYkL8UhNlfDOj+Pqm9Eq6Ocvp1HQ
         eySj7agTS7opZaMD03fdEpX0BPh4fZrrdh8O2dQZ0VEpVFwENeu6hvkGsJGNwLaC39/0
         Y5mA==
X-Gm-Message-State: AOAM532B8xl7W1FKEHHuQTokG5Pu9IVT0aIIS7FQwIXp/QhXgk8M8xhp
        xT90VmqciDDFwdriZZ/oM4rlhxZz6IE=
X-Google-Smtp-Source: ABdhPJyXCJfhRK7Y/NgFYdI26UrB6giiAlJ4VaVfFlbR/XTgm9T4WvVULsd9Fa8A7OlfbOXD8IA4/g==
X-Received: by 2002:adf:c992:: with SMTP id f18mr43364729wrh.574.1638804547089;
        Mon, 06 Dec 2021 07:29:07 -0800 (PST)
Received: from localhost (pd9e51d39.dip0.t-ipconnect.de. [217.229.29.57])
        by smtp.gmail.com with ESMTPSA id r8sm14374337wrz.43.2021.12.06.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:29:06 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: bq25980: Fixup the example
Date:   Mon,  6 Dec 2021 16:29:05 +0100
Message-Id: <20211206152905.226239-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use the ti,watchdog-timeout-ms property instead of the unsupported
ti,watchdog-timer property to make the example validate correctly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/power/supply/bq25980.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25980.yaml b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
index 06eca6667f67..8367a1fd4057 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25980.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
@@ -105,7 +105,7 @@ examples:
           reg = <0x65>;
           interrupt-parent = <&gpio1>;
           interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
-          ti,watchdog-timer = <0>;
+          ti,watchdog-timeout-ms = <0>;
           ti,sc-ocp-limit-microamp = <2000000>;
           ti,sc-ovp-limit-microvolt = <17800000>;
           monitored-battery = <&bat>;
-- 
2.33.1

