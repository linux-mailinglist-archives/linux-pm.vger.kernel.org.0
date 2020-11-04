Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00C2A6AC2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgKDQwm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731558AbgKDQuA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:00 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4CC0613D3;
        Wed,  4 Nov 2020 08:50:00 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id k25so23706211lji.9;
        Wed, 04 Nov 2020 08:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eN3ruYqKrfAyq4fQITxNWZN/YF+MM8QbZauHCJzUFj8=;
        b=TVwZDsUpQtOop2WOQclHYZgdwB7KxiVA6R6b6Ka6vX6hiO11aEcyyoBglrOZaHUTV0
         FBlAlfcq+LI3Lw8ROniDVBNNCexeo6GJZPw2yPf3ZmoTk/w08Nqj1PKSZO6RSFwz/vuG
         ZutKiRKbxKlOBUWZtceiMYEVekzmXhMZNgNKhbYpYws5gJY2CyEpjFvwMQe1mnXKLz0u
         qJuT1Dta0VmZqpT/9sZh4DHE++xDLJWMe5MTqUfl0RkJfGV4j+chzYmRqt5hAcAt9Pja
         jx097eDN8hxh3YgkAQ6KTzHe0sawnGRD9q8InlTq6NfD74dox4c1vCBimo6BzFUM940S
         MDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eN3ruYqKrfAyq4fQITxNWZN/YF+MM8QbZauHCJzUFj8=;
        b=uBEGSGS2omkRnazv5oymrch7GM9U9UzJ+GrQqQB+qFROmYsKSQvetkbOOjxtvHbTiE
         TDAogMy9u/skGXKMgrjz3jhXG+jWtdI/4jcU+4f+eb8lkVQxSw3EFjCZT63WNYElxxmd
         +cDnJUHY2NDUs47ChtwsIXvJ7nnGkkcfstbefLM/CohlreG66xorn7pizeKftKSERrYi
         YhCBlkNtgfhKNF+gD/zZm4N77SFM0IBzsGIJQz8PE4jDB7IjAqsbxBj7CxnDs69el/h6
         7xaXPKIs4prbwn4oCw9zP6hp1i8HKOzCLtJYL2i5D0vfxaG+0cKaQofNEQZ25mroFHMy
         mwkg==
X-Gm-Message-State: AOAM530LjWH70n5G7+FWeoz4ejU3uW3yJVG+xKaOSj+HqLgxONXmoPJy
        eOn2v4zqNZWiNj+5ny2vaso=
X-Google-Smtp-Source: ABdhPJz8F2nqtehxzpqUUCA/aUcL85BZ1uvq8mFaFu09xmcHZWeIbOxWl/DYJLu5VQOKGJT5Wkuh6Q==
X-Received: by 2002:a05:651c:112a:: with SMTP id e10mr11726956ljo.411.1604508599056;
        Wed, 04 Nov 2020 08:49:59 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:58 -0800 (PST)
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
Subject: [PATCH v7 24/47] ARM: tegra: Add nvidia,memory-controller phandle to Tegra20 EMC device-tree
Date:   Wed,  4 Nov 2020 19:49:00 +0300
Message-Id: <20201104164923.21238-25-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
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
2.27.0

