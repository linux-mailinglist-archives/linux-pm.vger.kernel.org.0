Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96822A6B16
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbgKDQyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbgKDQte (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:34 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA13C0613D3;
        Wed,  4 Nov 2020 08:49:34 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l2so28077946lfk.0;
        Wed, 04 Nov 2020 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHtzrrepL8FLGGKPOwuB3OE0fpn5LFvoU4c2khdwzPk=;
        b=XM0pGDcMd53mhhwvHwq2NuOHBudK621+lRSRX6ORhsBYU/+mmOkgtziFDbI04bAlDd
         qAHJdK6azj3WR5sywwArvU0OlgtQxXMsZ/utcCcNBveXgtwsiGD2W9kGZ/2rMxlqmeov
         hNZpXL8P/4NIyQOKW5BKS8TrBGIUx9gzgvr8O/vEQ7lq+OzNEdVLnOyqD45K61A7kFfN
         6nNUAuvmw708ErfFqgWuzzvzU1kHkKh2ZedrRdqb1HWauu/GK4l9DsB/1OPJTvQGA8Ae
         fMZfB/IK4UC+rXzjtX0iieh+/OAPCprZ6FR98khPEjEtxcBVnNvV+OVfSI0Lztvyf8Yx
         Nq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHtzrrepL8FLGGKPOwuB3OE0fpn5LFvoU4c2khdwzPk=;
        b=kEDl/G6fiBerktxrxtntM8Kgg6XzhgJlsoWnAsUfZ+QCH1h5o2tC4JPpKLcY13cxs2
         vrSJUMtAjZa6J3Wk7haQTlnQIS/TUKZrqUHwvC0K3dTpxfm5vnYn5JZGk2a4SrnhY6lR
         k9HJVYRlFNcZPT2hW3UjnuHP2JJqqffSh9oyxdo51tjyA6cO2L6Y/bFSbrR9rB6U2hSG
         ADNWdNJKqNPcy2izaNLneE2kHyKJspBaNhoQEr9QY3SsC6AFShPcJ4I22lT3P2709W+B
         pUGhoRClNWJ3FRs8IHI3kJDAmOX/5lGRD44x0fntnKz9hIEbFsgz/ITDSHFnV1jazWD7
         HP9A==
X-Gm-Message-State: AOAM532ly6Fx7ci+ZEpnOVx2IIqszCGapJXFtwuRzh5c11MNbxZiToqN
        no9g/ft4JenWl7x9W+YtHTE=
X-Google-Smtp-Source: ABdhPJzb2kabU1emK04P7CDpE6ygpI0Ouh+Sky5hlfE9yzMJYFBqyj9cy/H74kx+Re6BsAu8ih58Cw==
X-Received: by 2002:a19:c8c2:: with SMTP id y185mr1328884lff.29.1604508572781;
        Wed, 04 Nov 2020 08:49:32 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:32 -0800 (PST)
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
Subject: [PATCH v7 02/47] soc/tegra: fuse: Export tegra_read_ram_code()
Date:   Wed,  4 Nov 2020 19:48:38 +0300
Message-Id: <20201104164923.21238-3-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra_read_ram_code() is used by EMC drivers and we're going to make
these driver modular, hence this function needs to be exported.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index cee207d10024..590c862538d0 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -90,6 +91,7 @@ u32 tegra_read_ram_code(void)
 
 	return straps >> PMC_STRAPPING_OPT_A_RAM_CODE_SHIFT;
 }
+EXPORT_SYMBOL_GPL(tegra_read_ram_code);
 
 static const struct of_device_id apbmisc_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-apbmisc", },
-- 
2.27.0

