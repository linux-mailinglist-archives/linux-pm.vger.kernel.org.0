Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85417D81C7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfJOVSD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:18:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44056 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbfJOVRN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so21709538ljj.11;
        Tue, 15 Oct 2019 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDIsiA4mT4jIr9jIBmSCjoO9EpRuLGxzJGyIPGQv5iA=;
        b=JwZHUjbGTZWb1Mk7xMkevptkAxqodSKqgdtIQfvgDiTHEeY2OmHyU2d5XUiQny7eLv
         vU0UpPLMciUlxRUGUgfnwcO7V9HiiRS7mhuf4OOLd2871UAwE5ISiH6+vMpJLPTlFQEE
         HSg6MU7+e1C9F+eYr1wZ4PeQZyrWnDud4dZF6loGQ0gPuhKWK196Xz+sbGLpGl20iQ9S
         tZ1lzOQ8ma4h/SU2GlYrvrikFLHuGr9lhnQSYJyRWpWrM1MOU7eKT+Ff0X3g+z+6ysr5
         mq3qpxmKbaEHKUmUAHqEPBsFp6c+p3wNzhMsx9TvzhEVYC2FQmJUepBIkwFsj9QpzlNh
         irGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDIsiA4mT4jIr9jIBmSCjoO9EpRuLGxzJGyIPGQv5iA=;
        b=beXbNK2D8GXVG7vQFw7mvlfP2O0Fa2dQoHLne5n/RRwmFQ/BECEkLSWyaV31zG/dCh
         0L4oy+9KNIXiXQdVh/iAm5Pg4jUYSbgWljtsrZhGaC0XHutFEVdbiZszQUSdslVCjSr2
         CpY3N2W+TdGzA+ayHyqgPA4J8ClSCzMZ9ScToVwUDxr3g0dptIXxRDAOJj+N6nMdBUf/
         zQBhWA38836nnzq3tNZXjlZbuqfgo4R+68KaI+bBsAfIBcvX3mSgul9ig7x8+gkZsouX
         FdIBdJfsupf7HyIcEKhwXFkjTyIfSk1hClZwfocs7+eOVl/gmSC6C+NQPEc6PFiuR8yk
         F8LA==
X-Gm-Message-State: APjAAAWKpWT7VONX8CPeW4t+T5tl2VUvh3H8l7/MrETCf5go7n+OU3MD
        ixJ5L82KODawASV/FOmBfG4=
X-Google-Smtp-Source: APXvYqzJfh0xbCtU5eEdeYcKvAgOEziEBraP5c0ErxVZ3z6b+RoxfdshN+YFeNNLpKUVVBzgaC8HWA==
X-Received: by 2002:a2e:b819:: with SMTP id u25mr15641542ljo.223.1571174230265;
        Tue, 15 Oct 2019 14:17:10 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/17] ARM: dts: tegra30: Add CPU clock
Date:   Wed, 16 Oct 2019 00:16:11 +0300
Message-Id: <20191015211618.20758-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
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

