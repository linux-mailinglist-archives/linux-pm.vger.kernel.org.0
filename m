Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394992B3992
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgKOVde (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 16:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgKOVdd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 16:33:33 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE117C0613D1;
        Sun, 15 Nov 2020 13:33:32 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so22329553lfd.9;
        Sun, 15 Nov 2020 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70AwH8cNmd6w58ds7pz1XboJoFvv7hESZcajbSOVJ0Y=;
        b=jf3ZImOwe577lJR439hGff+0i8ovX0KuZO7T4XuzzZejil3xAOChl0c8J/pJ9Mxi/n
         3itHvHWhjbbfhur0iH/pvxr0+PEdJc2KPuMbIucjve1Fal4jiselEMKvt+TntKEot8mV
         uFOzZR/5+4lzFZy6mUzGW/aZyuNWxWW8rjAOhgn1qu3RP4lg/1uFRL/fhg0CfPCi5Kjp
         adJxJHy3irbFxYw7wGN9t2ajRcrhlb77DFeT+qMHsDm7DCj79aIistXRHYVyz4GerZ9n
         2nnxCNnVik6t1jyfLpYEoLuGoIlY94zjzKbH5erFDuzW/7mqqvgxnTAkl3m2YGFKjzPD
         I8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70AwH8cNmd6w58ds7pz1XboJoFvv7hESZcajbSOVJ0Y=;
        b=pwswkq+ONw5+XtQZwo1RtuipiEsIFmd3Y4J1q1VVE4UPVwIU+aum7DWlDCjrJ+2FYM
         9lN5WTKG/K3/V8R1Ho+yAHjpbqL73Pn8qVniqTN+0bSPljypL7rmph8GPbjM4o3aO/NB
         JwlGLVqk/ll+NHQa8gPTDrB2NqkYw+z/vik8IMG90QSCJ31FcXMWGP7QbMkkAAerwDSh
         6/QWCeRPp6wMY/bXqfuJW/xhJ3jinwkoKTzm7fp2vKlGph3eq4lkRALgVX2x72OJgWi3
         Px93Wkxm234Dj+2iBBKTL5XCXjnBRyJaOBfiU0aVrXSBwdTnpg072NCGOm21j8kkZzDM
         ivMQ==
X-Gm-Message-State: AOAM532P54LJZeCSI4vSXd0GTmJ4DZ+BXnJjmCuFYfGL+Vtoj/an6mW1
        oykJWony4ORBHYXLiezs6Q0=
X-Google-Smtp-Source: ABdhPJxQzbs4RynpvwJqImrX86voEs1LcyYYV1C1oOIDFRdpy/jt6pFm0Hrg8fWndzhUhV8uEolMlw==
X-Received: by 2002:a19:8110:: with SMTP id c16mr4220627lfd.372.1605476011517;
        Sun, 15 Nov 2020 13:33:31 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id o3sm2462055lfo.217.2020.11.15.13.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:33:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v9 14/17] ARM: tegra: Add nvidia,memory-controller phandle to Tegra20 EMC device-tree
Date:   Mon, 16 Nov 2020 00:29:19 +0300
Message-Id: <20201115212922.4390-15-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115212922.4390-1-digetx@gmail.com>
References: <20201115212922.4390-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add nvidia,memory-controller to the Tegra20 External Memory Controller
node. This allows to perform a direct lookup of the Memory Controller
instead of walking up the whole tree. This puts Tegra20 device-tree on
par with Tegra30+.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 2e1304493f7d..8f8ad81916e7 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -663,6 +663,8 @@ emc: memory-controller@7000f400 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		#interconnect-cells = <0>;
+
+		nvidia,memory-controller = <&mc>;
 	};
 
 	fuse@7000f800 {
-- 
2.29.2

