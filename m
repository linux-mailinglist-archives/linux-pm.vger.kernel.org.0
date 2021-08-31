Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB233FC592
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbhHaKWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbhHaKWm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 06:22:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD023C061760
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 03:21:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h1so30820221ljl.9
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQ8kS/+bTV4avdS2tU6jC3f6zz+Ryry/9cKDRK1gufo=;
        b=jiP1wMEEvsgc3n7vYx1ledvZpCZkUX5FcfCU/d4NmQ10imEb+nTwuV7AvPQyuAhzpe
         YsP/UU3DHPPh2i10yLbc78f5nCMLrerGJ6O5w2qQxXo1os1R5iEn/nQbRPHBGoAOHkXS
         1aGLp5y3Z3p+M9xTR3mVec6Ve/Wj+o+zBAE2jyiAeEhGtBnmOfK3J7BHgoO9AKlkFMG8
         XHtHiuMg1cbBY5AtMl5rgl7rqbMvAu7ThdDV0Pq3/ED5GoRF4shP/c5KQGW9yKirDnmq
         d2LCC2MTmPF6h0Symi6YMYf/1TDJKL/EaXJSAYRhHwpoTPEraIaRvdsHZ1cUt089Z39h
         /jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQ8kS/+bTV4avdS2tU6jC3f6zz+Ryry/9cKDRK1gufo=;
        b=iTiIg6tEPkJ5FXynSz2exjW7wagbEAWSs7U0Unig1ZobTEIWPF5EiK849l8bVLTVv6
         bc98mxf1ph5fBPZiJ1YtuYmwvDK8xLX+YBiLAQLPVrD64rHjj0xFg1spqJKaf/hKn203
         sJ7e4mn/TI3Fpk4PVwnTwJqFlhIgRC4Iha+RuqW3ymkrBJKU7QvbgpCcizKDK++XPhlo
         up8i4wbQl29fZAdnwOisbW6t+eDXRjUMtqJQWiKe9T0OiNkWqa7IvysiMoo3HQhK/l9Y
         0bp0uizH6CHVlc2BUDoi04CWk3uYCPwr7ZUQ2MFsO7AKHp+hfSKegGwrv85nsBdYRuho
         jsFw==
X-Gm-Message-State: AOAM532XTmEekexDQyNAt8tmzuHDuz6/EUZoJYzvkFyzyyELYS3QlZ8Y
        +vNp4qmZqg12DX6h9/tvdyZarQ==
X-Google-Smtp-Source: ABdhPJyfAO80CqzIGBt9m8D2PiuI5w5PJosyAgh/JmPeY8WX1k4mcSvpAtqPgpVYTTOGtXaXZQRtog==
X-Received: by 2002:a05:651c:2ca:: with SMTP id f10mr24621298ljo.211.1630405305074;
        Tue, 31 Aug 2021 03:21:45 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id d13sm1687864lfk.232.2021.08.31.03.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:21:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] of: property: fw_devlink: Set 'optional_con_dev' for parse_power_domains
Date:   Tue, 31 Aug 2021 12:21:41 +0200
Message-Id: <20210831102141.624725-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The power-domain DT bindings [1] doesn't enforce a compatible string for a
provider node, even if this is common to use. In particular, when
describing a hierarchy with parent/child power-domains, as the psci DT
bindings [2] for example, it's sometimes not applicable to use a compatible
string.

Therefore, let's set the 'optional_con_dev' to true to avoid creating
incorrect fw_devlinks for power-domains.

[1] Documentation/devicetree/bindings/power/power-domain.yaml
[2] Documentation/devicetree/bindings/arm/psci.yaml

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Some more details of what goes on here. I have added a debug print in
of_link_to_phandle() to see the fw_devlinks that gets created.

This is what happens on Dragonboard 410c when 'optional_con_dev' isn't set:
...
[    0.041274] device: 'psci': device_add
[    0.041366] OF: Linking power-domain-cpu0 (consumer) to psci (supplier)
[    0.041395] OF: Linking power-domain-cpu1 (consumer) to psci (supplier)
[    0.041423] OF: Linking power-domain-cpu2 (consumer) to psci (supplier)
[    0.041451] OF: Linking power-domain-cpu3 (consumer) to psci (supplier)
[    0.041494] device: 'platform:psci--platform:psci': device_add
[    0.041556] platform psci: Linked as a sync state only consumer to psci
...

This is what happens on Dragonboard 410c when 'optional_con_dev' is set:
...
[    0.041179] device: 'psci': device_add
[    0.041265] OF: Not linking psci to psci - is descendant
[    0.041293] OF: Not linking psci to psci - is descendant
[    0.041319] OF: Not linking psci to psci - is descendant
[    0.041346] OF: Not linking psci to psci - is descendant
...

The relevant dtsi file:
arch/arm64/boot/dts/qcom/msm8916.dtsi

Kind regards
Ulf Hansson

---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 2babb1807228..4d607fdbea24 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1356,7 +1356,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_interrupt_parent, },
 	{ .parse_prop = parse_dmas, .optional = true, },
-	{ .parse_prop = parse_power_domains, },
+	{ .parse_prop = parse_power_domains, .optional_con_dev = true, },
 	{ .parse_prop = parse_hwlocks, },
 	{ .parse_prop = parse_extcon, },
 	{ .parse_prop = parse_nvmem_cells, },
-- 
2.25.1

