Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C10EE3F1A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfJXWSf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:18:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43768 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbfJXWRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so341151ljj.10;
        Thu, 24 Oct 2019 15:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDIsiA4mT4jIr9jIBmSCjoO9EpRuLGxzJGyIPGQv5iA=;
        b=qCcoTjzyXnoIr2dndxCFa2+OgnLph9PoieBVs+P9Ut1dgH3t/35jKWkGiJndef9dNm
         V7iQapCXVwVMqJXVv1Q3q16eMGdnWY015EaeayyPkAOaJ++eKdeuv9kBVSVJQwhlZMBU
         rby8/cK8Ijp0OMgZhMo9QwqWNfFzQ5reIwrZgcyVW8NIb6QuiowfYaECBDlKtEuDnH/D
         FbBXDekFnBLOawqy7blL2KAh1Ke63sa2oEycCP6strFDVYevIYm6ALRf9m8JlMsoIWCo
         2UhEM6EqTIY0le6o3vOrRwiiB3TOVPIIPcikiduq0pRD/ew7I624yjqFObx8mldvmXDn
         yVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDIsiA4mT4jIr9jIBmSCjoO9EpRuLGxzJGyIPGQv5iA=;
        b=PvvhZltZ0kjw7LjONswooYOktAQ5TowFx2mrVpBgF7dWp0yEtsBwHLIuAN9oH8AmYg
         DHrPtMUqcXlub8hdZkjbmH7GnkmSjLoj8XHU8VvJU4MB/IZhFsfRlNmxW3h5uxc1e1xO
         QqGq94UlT+KYjbs3q/lY+IjXaMrsuoDJtKat1N0IPiuGT5EUbqTG9ZxX8GRbPXIO3L/f
         SOqxeK5zdL82wenjSyl/zfv1F1uDbuVX13Hxc4DsbonEZol0A1s2sEQEFb+PKujqI58X
         5qj7c8SA7m1i72lc6ptXgp3Nl9TEpWzwdIR+NGj58Af/3oqMyTTMUs8MQYZdR5O7Px1N
         S7GQ==
X-Gm-Message-State: APjAAAWQEjRjsjfNKSDR5tEd1dYsoX70nc9e5Fgrn//pLI/ivn8Rne/k
        thzwZZXIka63oVeMRT/Sn2iwv/Om
X-Google-Smtp-Source: APXvYqw+W+2mpzcgKa0lHmVmRDN6ZOgRpODmO0fdjhrdbCbezW5IJuMELtkJHkwU/XJlGGztgsSDDw==
X-Received: by 2002:a2e:8908:: with SMTP id d8mr28480lji.197.1571955467058;
        Thu, 24 Oct 2019 15:17:47 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/17] ARM: dts: tegra30: Add CPU clock
Date:   Fri, 25 Oct 2019 01:14:09 +0300
Message-Id: <20191024221416.14197-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All "geared" CPU cores share the same CPU clock.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 8355264e2265..a4aaf8f73d18 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1006,24 +1006,28 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA30_CLK_CCLK_G>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&tegra_car TEGRA30_CLK_CCLK_G>;
 		};
 
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
+			clocks = <&tegra_car TEGRA30_CLK_CCLK_G>;
 		};
 
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
+			clocks = <&tegra_car TEGRA30_CLK_CCLK_G>;
 		};
 	};
 
-- 
2.23.0

