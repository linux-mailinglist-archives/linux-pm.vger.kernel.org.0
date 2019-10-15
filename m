Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45312D81C2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbfJOVRN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45341 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389488AbfJOVRM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so21730191ljb.12;
        Tue, 15 Oct 2019 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbmgm7OZfiZxyZLfjm0hUKkhnp/cuwLR/94MZqB3XDg=;
        b=PEmBmzivr4vdO1ukmj7/9imiP/go62le6oa2wkWDLPNe8Sm4maosdmMPGb60KJP6jn
         hShlZ+7Wf3cs8YTDJGAR3J2wt40o9e4co/rF+rqI/GfcsaSf6T2gAyQZw/9yIpXo8NG9
         Dz7FgzoqM48w32jM2i7KXjB3+qEpBC68RMBb+QuJNgy3PNLimV5XmG3JsHf7TDF3tgPd
         Y3IqbypFypW8wGXL+JuV3Z3dslpUGtcpGZuRsuA772cZ7wtnD+zkXvRy7XnAEJwIDR/E
         BE3hXBEWbwzCSi5Y7eMXbYG6m1OyBzRkv+HbAk+T/+7j4kv0Vax1f3Ogjvqxu+O6WuB3
         7C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbmgm7OZfiZxyZLfjm0hUKkhnp/cuwLR/94MZqB3XDg=;
        b=kXtqNSb+CHLLyqYjsrmRBPzT77qnkWtXsDvVRb936z50Ag7IjZn4HwmFf3qD2u9RWS
         Y55fWtssojvijPVJhESLs2ffFFTOzTysuIUHR6nnnUGn+e5mMQInssqn4iNBdSK72iXY
         HpeSFGJJw5KXB1GEjDBfbyHvdnUm3C5vDiQbkvRMAvYx6clz4ENpPCALj+x05BgQ5Y/6
         JvfEpwTVlZc8knvhrR/y5/tp73YaoB2EhM618w/YSmqeh/Q7Zulthtqpqis5tvQr3oyY
         mk31CRGVYsVZ5nXIlDri6n1nUJZNCYTnenqbtE4Jc5wX2CKznW3FLY1zZ3kWJ8t5hrET
         HhnA==
X-Gm-Message-State: APjAAAUms4b5hN0UxUzAa4zPF4w+3KWMXgAaoqP3D8qYA6e3nNTo8eP+
        hCAIJrK1yq1VXyq5o78TwXU=
X-Google-Smtp-Source: APXvYqw8584qilRFbOi6yNHhZld6QF0W4drtX9MgIzFCJqKwcA+HbwfdRVd/rYdMN/APQZawf0StWg==
X-Received: by 2002:a05:651c:113b:: with SMTP id e27mr22947516ljo.125.1571174229197;
        Tue, 15 Oct 2019 14:17:09 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:08 -0700 (PDT)
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
Subject: [PATCH v1 09/17] ARM: dts: tegra20: Add CPU clock
Date:   Wed, 16 Oct 2019 00:16:10 +0300
Message-Id: <20191015211618.20758-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
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

