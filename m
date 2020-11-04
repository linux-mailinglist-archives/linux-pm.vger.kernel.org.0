Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182AB2A6A9A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgKDQuS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgKDQuQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:16 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FB3C0613D3;
        Wed,  4 Nov 2020 08:50:16 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 126so27999063lfi.8;
        Wed, 04 Nov 2020 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygGFEixuoZ4watwj5KaB3ZZnbm2DyZvxWKijeTY8Pq8=;
        b=FdG4fKKNqML8eJhkAB7c4DI1NNF3XiowauUAPWRzSoq49ugMkpYTOiy6B0+H1OoCyB
         PTWfFnOqx2p6k1iYhHJmhru4hPzsED9AelCYoFxQJ1wzcuiqBVXxGQ+eArBojv2PTYuk
         7n1M07z3pmlhSXctZAS56bePOS7JOfLDzjtVvl9F1NQh5p6GR2qojdKvWIB+zautJs4n
         Qu8yanlMhfIegSIwD6EbwixGypphjP/2AYSEKEMkPr9R71RrrQoDJMA/zliEfszUo2eM
         EOySSq/LRAw5WhcbojYmwKIiIkVloKOKMrABrwTeP/2OWLl87RALattpPXfiGtvloL3S
         hWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygGFEixuoZ4watwj5KaB3ZZnbm2DyZvxWKijeTY8Pq8=;
        b=iwMfGBzTc91qzuiGoU9bOozFWABUYDQWwjpJqeY4a9OTUMq5CaQ4DYaAGX7nZLxHqV
         SAvHuz5fBGhoLRM1xA+xdmISbfW1NRG5DIdJFFFn9YfTu6XawgE0D4EY04p6EIMTTsW4
         oys3Mdrg14mtB9ZdL/A4QudKgQbWTueMfY5LrfTU1ect2aWhfudHGRVcLdl9gL1vsPPf
         GvdxRgmVvG2PmwARWimIr5voT6bbcEivh7KuYViBkHhkg1nePBMqnrFB2h6i0wUyLx0e
         5HT4oBlnjKslbfoFwxsLHNRA/SZGCbjlY5xcRgQA2Z0n9Y0QFmo/MJFpMfziAkmpzAKO
         j4jQ==
X-Gm-Message-State: AOAM530PjGtLWRpRVBEpS2sYlMJd8WjHtlAtyv9x2EA/OfxClD8ZtPoe
        2ZJH+tfJdEi5fyRtciiUKVc=
X-Google-Smtp-Source: ABdhPJxHR622/VhfuA+lQrrhbDmFYYe2tnjkL8o/GJNrVPWzaVMgNQ9/ye30jidxAXieLAa/ftQpaw==
X-Received: by 2002:a19:8c52:: with SMTP id i18mr9920164lfj.115.1604508614539;
        Wed, 04 Nov 2020 08:50:14 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:14 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 37/47] memory: tegra30: Add FIFO sizes to memory clients
Date:   Wed,  4 Nov 2020 19:49:13 +0300
Message-Id: <20201104164923.21238-38-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The latency allowness is calculated based on buffering capabilities of
memory clients. Add FIFO sizes to the Tegra30 memory clients.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30.c | 66 ++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index b1990b4133d8..d0314f29608d 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -42,6 +42,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0,
 		},
+		.fifo_size = 16 * 2,
 	}, {
 		.id = 0x01,
 		.name = "display0a",
@@ -56,6 +57,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.fifo_size = 16 * 128,
 	}, {
 		.id = 0x02,
 		.name = "display0ab",
@@ -70,6 +72,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.fifo_size = 16 * 128,
 	}, {
 		.id = 0x03,
 		.name = "display0b",
@@ -84,6 +87,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x04,
 		.name = "display0bb",
@@ -98,6 +102,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x05,
 		.name = "display0c",
@@ -112,6 +117,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.fifo_size = 16 * 128,
 	}, {
 		.id = 0x06,
 		.name = "display0cb",
@@ -126,6 +132,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.fifo_size = 16 * 128,
 	}, {
 		.id = 0x07,
 		.name = "display1b",
@@ -140,6 +147,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x08,
 		.name = "display1bb",
@@ -154,6 +162,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x09,
 		.name = "eppup",
@@ -168,6 +177,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x17,
 		},
+		.fifo_size = 16 * 8,
 	}, {
 		.id = 0x0a,
 		.name = "g2pr",
@@ -182,6 +192,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x09,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x0b,
 		.name = "g2sr",
@@ -196,6 +207,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x09,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x0c,
 		.name = "mpeunifbr",
@@ -210,6 +222,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.fifo_size = 16 * 8,
 	}, {
 		.id = 0x0d,
 		.name = "viruv",
@@ -224,6 +237,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x2c,
 		},
+		.fifo_size = 16 * 8,
 	}, {
 		.id = 0x0e,
 		.name = "afir",
@@ -238,6 +252,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.fifo_size = 16 * 32,
 	}, {
 		.id = 0x0f,
 		.name = "avpcarm7r",
@@ -252,6 +267,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.fifo_size = 16 * 2,
 	}, {
 		.id = 0x10,
 		.name = "displayhc",
@@ -266,6 +282,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 2,
 	}, {
 		.id = 0x11,
 		.name = "displayhcb",
@@ -280,6 +297,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 2,
 	}, {
 		.id = 0x12,
 		.name = "fdcdrd",
@@ -294,6 +312,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.fifo_size = 16 * 48,
 	}, {
 		.id = 0x13,
 		.name = "fdcdrd2",
@@ -308,6 +327,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.fifo_size = 16 * 48,
 	}, {
 		.id = 0x14,
 		.name = "g2dr",
@@ -322,6 +342,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.fifo_size = 16 * 48,
 	}, {
 		.id = 0x15,
 		.name = "hdar",
@@ -336,6 +357,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 16,
 	}, {
 		.id = 0x16,
 		.name = "host1xdmar",
@@ -350,6 +372,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x05,
 		},
+		.fifo_size = 16 * 16,
 	}, {
 		.id = 0x17,
 		.name = "host1xr",
@@ -364,6 +387,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.fifo_size = 16 * 8,
 	}, {
 		.id = 0x18,
 		.name = "idxsrd",
@@ -378,6 +402,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x19,
 		.name = "idxsrd2",
@@ -392,6 +417,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x1a,
 		.name = "mpe_ipred",
@@ -406,6 +432,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.fifo_size = 16 * 2,
 	}, {
 		.id = 0x1b,
 		.name = "mpeamemrd",
@@ -420,6 +447,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x42,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x1c,
 		.name = "mpecsrd",
@@ -434,6 +462,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 8,
 	}, {
 		.id = 0x1d,
 		.name = "ppcsahbdmar",
@@ -448,6 +477,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.fifo_size = 16 * 2,
 	}, {
 		.id = 0x1e,
 		.name = "ppcsahbslvr",
@@ -462,6 +492,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x12,
 		},
+		.fifo_size = 16 * 8,
 	}, {
 		.id = 0x1f,
 		.name = "satar",
@@ -476,6 +507,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x33,
 		},
+		.fifo_size = 16 * 32,
 	}, {
 		.id = 0x20,
 		.name = "texsrd",
@@ -490,6 +522,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x21,
 		.name = "texsrd2",
@@ -504,6 +537,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x22,
 		.name = "vdebsevr",
@@ -518,6 +552,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 8,
 	}, {
 		.id = 0x23,
 		.name = "vdember",
@@ -532,6 +567,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xd0,
 		},
+		.fifo_size = 16 * 4,
 	}, {
 		.id = 0x24,
 		.name = "vdemcer",
@@ -546,6 +582,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x2a,
 		},
+		.fifo_size = 16 * 16,
 	}, {
 		.id = 0x25,
 		.name = "vdetper",
@@ -560,6 +597,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x74,
 		},
+		.fifo_size = 16 * 16,
 	}, {
 		.id = 0x26,
 		.name = "mpcorelpr",
@@ -570,6 +608,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.fifo_size = 16 * 14,
 	}, {
 		.id = 0x27,
 		.name = "mpcorer",
@@ -580,6 +619,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.fifo_size = 16 * 14,
 	}, {
 		.id = 0x28,
 		.name = "eppu",
@@ -594,6 +634,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x6c,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x29,
 		.name = "eppv",
@@ -608,6 +649,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x6c,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x2a,
 		.name = "eppy",
@@ -622,6 +664,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x6c,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x2b,
 		.name = "mpeunifbw",
@@ -636,6 +679,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.fifo_size = 16 * 8,
 	}, {
 		.id = 0x2c,
 		.name = "viwsb",
@@ -650,6 +694,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x12,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x2d,
 		.name = "viwu",
@@ -664,6 +709,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xb2,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x2e,
 		.name = "viwv",
@@ -678,6 +724,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xb2,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x2f,
 		.name = "viwy",
@@ -692,6 +739,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x12,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x30,
 		.name = "g2dw",
@@ -706,6 +754,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x9,
 		},
+		.fifo_size = 16 * 128,
 	}, {
 		.id = 0x31,
 		.name = "afiw",
@@ -720,6 +769,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0c,
 		},
+		.fifo_size = 16 * 32,
 	}, {
 		.id = 0x32,
 		.name = "avpcarm7w",
@@ -734,6 +784,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0e,
 		},
+		.fifo_size = 16 * 2,
 	}, {
 		.id = 0x33,
 		.name = "fdcdwr",
@@ -748,6 +799,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.fifo_size = 16 * 48,
 	}, {
 		.id = 0x34,
 		.name = "fdcdwr2",
@@ -762,6 +814,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.fifo_size = 16 * 48,
 	}, {
 		.id = 0x35,
 		.name = "hdaw",
@@ -776,6 +829,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 16,
 	}, {
 		.id = 0x36,
 		.name = "host1xw",
@@ -790,6 +844,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.fifo_size = 16 * 32,
 	}, {
 		.id = 0x37,
 		.name = "ispw",
@@ -804,6 +859,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 64,
 	}, {
 		.id = 0x38,
 		.name = "mpcorelpw",
@@ -814,6 +870,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0e,
 		},
+		.fifo_size = 16 * 24,
 	}, {
 		.id = 0x39,
 		.name = "mpcorew",
@@ -824,6 +881,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0e,
 		},
+		.fifo_size = 16 * 24,
 	}, {
 		.id = 0x3a,
 		.name = "mpecswr",
@@ -838,6 +896,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 8,
 	}, {
 		.id = 0x3b,
 		.name = "ppcsahbdmaw",
@@ -852,6 +911,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.fifo_size = 16 * 2,
 	}, {
 		.id = 0x3c,
 		.name = "ppcsahbslvw",
@@ -866,6 +926,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x06,
 		},
+		.fifo_size = 16 * 4,
 	}, {
 		.id = 0x3d,
 		.name = "sataw",
@@ -880,6 +941,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x33,
 		},
+		.fifo_size = 16 * 32,
 	}, {
 		.id = 0x3e,
 		.name = "vdebsevw",
@@ -894,6 +956,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 4,
 	}, {
 		.id = 0x3f,
 		.name = "vdedbgw",
@@ -908,6 +971,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.fifo_size = 16 * 16,
 	}, {
 		.id = 0x40,
 		.name = "vdembew",
@@ -922,6 +986,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x42,
 		},
+		.fifo_size = 16 * 2,
 	}, {
 		.id = 0x41,
 		.name = "vdetpmw",
@@ -936,6 +1001,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x2a,
 		},
+		.fifo_size = 16 * 16,
 	},
 };
 
-- 
2.27.0

