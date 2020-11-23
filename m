Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890FA2BFD90
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgKWAbt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgKWAbd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:33 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD0AC061A4A;
        Sun, 22 Nov 2020 16:31:33 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s9so16124097ljo.11;
        Sun, 22 Nov 2020 16:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70AwH8cNmd6w58ds7pz1XboJoFvv7hESZcajbSOVJ0Y=;
        b=kIBfjtzjMxKLFjJgXEEAKXcl3ov1jq/BrBvl77UGHUmdfPCufpfKXVrwIkHiSyGgyD
         LdMa24krxJaC1ueS2JTSv8k+EV1+Jhd4ykKys4b7fAMrVzkicgDH6LmUyKuQjRRbbN57
         a8dv/Xu0cgsjPzIAz4E9mQ7x4XFFln3nCA01Oh826AYLp65MhBspgDmelScAv8Z0WZym
         Tv7b8QkN3gGBchzLLymygOFNUd7zbKkHE58E0Zzm2t8n8KmvE0h/z51JrR4A6x3J+mu+
         d3CBgt00PQOK2BsN6JdIHkUfdhZZdNYZbaVQz91kVDmD2gkxT1nVkv1gjdoYcR/mK0Zi
         jfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70AwH8cNmd6w58ds7pz1XboJoFvv7hESZcajbSOVJ0Y=;
        b=CraFrB/ZPPYjsfOog6PZ8artYYdULN/aemCdbeFPPqh9UjxfinF8JVqityaJxvsWvm
         CvDMUeU3ZUAuHHTJNYLs9nivp89DFFzYVVB0VlSrN6pivlyblvi3AYSKdP72radGCSpx
         DH9KCvIwdswTRbUuVEJnoCcGxWshSCKVnlJKYrbyQAwoK+dT5Tz7qe9zI5YIt8Ae4viN
         +hjx4v7ucdKjBGJc0fvdE+K50SKhIb7xLlWEb6pw54Q3RJV3NV/2kHaBzy0BonIJSAks
         c9h+aobVm/BtxZGM6DWIYSrOAgx65MeoucvqUSxi9XzOnMNPSXp4XKvF8jB8WPMXCfEW
         wN3w==
X-Gm-Message-State: AOAM530UvDg1pP8soxljA+aYuT23qYMjhXPla4IiYJUGmZUzafNDOBzI
        7bXDlHYHCmn/wmhs0b2A5Xs=
X-Google-Smtp-Source: ABdhPJyiNH4h/8h8zz59oXRW/lFxfTeYv1BIFvhjeOfz93zo8pVAnnpIlPs6f5cPhCPRf1xlcEzaTw==
X-Received: by 2002:a2e:9205:: with SMTP id k5mr11255310ljg.38.1606091491729;
        Sun, 22 Nov 2020 16:31:31 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:31 -0800 (PST)
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
Subject: [PATCH v10 16/19] ARM: tegra: Add nvidia,memory-controller phandle to Tegra20 EMC device-tree
Date:   Mon, 23 Nov 2020 03:27:20 +0300
Message-Id: <20201123002723.28463-17-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123002723.28463-1-digetx@gmail.com>
References: <20201123002723.28463-1-digetx@gmail.com>
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

