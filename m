Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08092AE58F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbgKKBQm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732861AbgKKBPv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:51 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4FDC0613D3;
        Tue, 10 Nov 2020 17:15:50 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so759153wrw.1;
        Tue, 10 Nov 2020 17:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70AwH8cNmd6w58ds7pz1XboJoFvv7hESZcajbSOVJ0Y=;
        b=c427F4P7nuBAI/UQwiYvu+O7DzW7XS2fssHniUEdNZb7OtBothsXZtTnvGeaODMdb0
         0OIexDzNgl8PBCaqXcZji9LtqBuX5ivbFrtiwGZ6e3PYOKZpjsDCbjj+PEU3pN1ff4IF
         HjwSc9gvvdryoJ4dp48TDgGEwNZkeM0e/2om2P+3UKDmSPYc3ea9msD4FFj1y+Ae9wlt
         Xf7r6hwmg1Mejy0Nl9bTAXzGmib9M0ynBVrWEqZLnuWh4rVze9yK6g8EOeSzqDRzUQsv
         AVLBnqk2VjJnz2iTwwXpFwxxiltSTVUS47fE1yNKWiCXYzrx7eKgXa2UbRjTFwbKweH9
         7CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70AwH8cNmd6w58ds7pz1XboJoFvv7hESZcajbSOVJ0Y=;
        b=I72qLN0wS36hxoskiW9dZQUtkuaJ199BvTW78a7eltXCTpF6aNGchQThduKu00T6B5
         EVEb7OF8QM1bwQsiCi9CtBo9nr7gBIcuaYNDETgTvRSsWPjJWp5bl8mBqv8JEFCdkCLc
         GKxst9hkneK3IEVpYlNIl4GVK0fnT/4QvfbHknfqi4JcxBbFcyA3yNdYmQtivkbyGcEe
         nHm01paIvyO7THgbu3ctVjYu0nr9fZ/yxVsix01nmnm23r2bEe6i78dzerDlIloKZ/wN
         8U5Q51R5t0jaUFWMxW+YC1DrlJetan7RTZ7HhfV6K4H9QtP+iXuTP45OvUTOPzib10p6
         dpsA==
X-Gm-Message-State: AOAM533TvV98I5D1/LaI2rA7MpoFXT0tl99Cdz9I6q5E5IODszzj/tIh
        cFsyYevk1lNNtLdFmNaJUkc=
X-Google-Smtp-Source: ABdhPJwz1Mh0V9SDzyrUU21ceD6qnKETJJkRJqebGKi9J5nanHyy0k9Qlal7/vO4D/QNpOdcfnvXUA==
X-Received: by 2002:adf:e287:: with SMTP id v7mr27464179wri.252.1605057349373;
        Tue, 10 Nov 2020 17:15:49 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:48 -0800 (PST)
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
Subject: [PATCH v8 23/26] ARM: tegra: Add nvidia,memory-controller phandle to Tegra20 EMC device-tree
Date:   Wed, 11 Nov 2020 04:14:53 +0300
Message-Id: <20201111011456.7875-24-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
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

