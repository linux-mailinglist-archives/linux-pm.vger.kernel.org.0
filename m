Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5018E3F09
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfJXWRt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42653 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730619AbfJXWRs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id z12so20399640lfj.9;
        Thu, 24 Oct 2019 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbmgm7OZfiZxyZLfjm0hUKkhnp/cuwLR/94MZqB3XDg=;
        b=ZX3EDQ43NdUTVE1tNK2y3ebaWotwJnWbopHcCIFVD/ODkoQstIaIicjjXB5IYWlHMS
         U4+S7Laaw4fx/P+EjcLhPE9+8Y04Ku3kssNRJRa3STxqlAYPvFB4Jh0PT68O8Sz1QzBe
         RDBZTzCDPI/Bn02MrdnVXgGekDbJGr0re4DFMEeFWDcYxyqF9dZ2KnaVpxMY8LfSSL7n
         WqSc7Pi3/vgkYh9U6LYjxRjxuxmQlDNhe4UmmWyFgidH4DJVtHFpaTsB9OFLlgy26uka
         vqbNHLRublEXQZtRfnxEtVlzjy8K8T8KOPYyiM3ecGvkjPvZ0n8XvnANsSsBWtIrCGff
         ed2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbmgm7OZfiZxyZLfjm0hUKkhnp/cuwLR/94MZqB3XDg=;
        b=DhCV6HxK/iNTTAVNq5sSyHAmD5aB5uX0tr+P1TAkiSrjrCQlSM/EH/bg4USO1oZM3k
         7enyWPeHSgFDZOshcwuTjfuQzuMqCnDfAK+kE05SL0srLL803UWWqcONrx8KdBY6iKLg
         Lbp96Qs0/0s6ncNHFE7B3Vl5mfgciolGF0726DFrObZb5iiaSPETXrNLYSLXKJKzJlgu
         7m3yNzxXaKDlPhiYiMi3DjobFpOS3Tfyl7t0cNKE8DWwXTy/acV9Pm9oTmz+xp6dI8uJ
         ekqLkuXvGFSyA6fFWTjJWJqA5B5lHevae7/VjMCzBpXLuHFkd6mvYyNQjq/anoAe0kEF
         ReUw==
X-Gm-Message-State: APjAAAWFTpzqu3WJkm+ePXWnlFrzrwWQA3lx7NiNXhEOe2pOm7Z/ZZTF
        J9hn5N8qYJTtP6hZpsJpivo=
X-Google-Smtp-Source: APXvYqzJKPdBZJcOVWa98+Zhk/pQ9KxUWUH8Fzyupz8ciu9eqmO1DU1xYNPfB+ofyxp6068gq6QbdQ==
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr310746lfi.24.1571955465856;
        Thu, 24 Oct 2019 15:17:45 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:45 -0700 (PDT)
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
Subject: [PATCH v2 09/17] ARM: dts: tegra20: Add CPU clock
Date:   Fri, 25 Oct 2019 01:14:08 +0300
Message-Id: <20191024221416.14197-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All CPU cores share the same CPU clock.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 8c942e60703e..9c58e7fcf5c0 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -851,12 +851,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA20_CLK_CCLK>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&tegra_car TEGRA20_CLK_CCLK>;
 		};
 	};
 
-- 
2.23.0

