Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF0D19880B
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 01:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgC3XUL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 19:20:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42880 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgC3XUL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 19:20:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id s13so4540043lfb.9;
        Mon, 30 Mar 2020 16:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hd+GxFPF+8hho6CBQXdH83p86n3Jd+YmZTEKLeLjMb8=;
        b=QORySsmgvTEO1feHYrPNFS4qWrx3whUQWc++vY1RTbj5i5xpxoPXs5xfOUqUFtA3dc
         jIcFNJ85XWi2X9ZoXg7hV9zLlbRJUkq41YQn2H5TvQDLzy1PWKhu+pz1WfMHLuFqz/It
         UHkfiIqB3k1NQqfB8mn0p4djxejTdtfVijw4rU0gSqZb/CK1WEy5Orj9iXehhH6V+Mv4
         IH8lnQ3xZqBV7ou6OGbmXIcPucD+vKmB0O62RAHtpAorJZplsvdA7uUjTMa1k3CxTNZg
         PdQ1q0kG7uwtJHcYSk6VuTbIpNRlWQLtXKWWZiCHG3P5M2VYqNdn91lwZpQxt+CH6Bc0
         VhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hd+GxFPF+8hho6CBQXdH83p86n3Jd+YmZTEKLeLjMb8=;
        b=hjpL9bHMkOUXZZRwY+oIHPRYTKqq7l86aCnISlpMGTF/92yUTZYSmcRcevYi2vGJt/
         PVt+ulfYivo5cy2Npw9yxdmZlXBeoTu9vbJNqPXQGy81fVazCqzfNZcZPULbNKV3YaVu
         3l0fCRHbaoVkUQ2OszQ+0L/OTR8r4V6Xc6Xl1vniybyMpSY8rK9x9Mg3RL+cMF0ZjlhH
         S/wbM+Yu50wvgjf5QX6q726qcNRsvkSMPw/U3TfhtYRlSF6VFbhy8Br6wsSlQX7U/Dxc
         6XgRgKtbzmRERJx+AAKTUmHX9NygvRq81hGwIM8mpKotLCNRO5k/517IGRV1+fpGsCpG
         fCMQ==
X-Gm-Message-State: AGi0Pubqco7HCy3JxT5TUlJ/3mFW4EAoVSRBu8c89D21oXNvdbnwUmSE
        tK7IGTIsQnvZtwEDUMlYY54=
X-Google-Smtp-Source: APiQypJ8GI4Ws4gjb0C95juBDkonn9dxIKlQX14nsbSgzON1oOygnU+xyOFnht8x6AbgBPZIYd8DWA==
X-Received: by 2002:ac2:5446:: with SMTP id d6mr9489356lfn.62.1585610407282;
        Mon, 30 Mar 2020 16:20:07 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id h3sm8773187lfk.30.2020.03.30.16.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:20:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] PM / devfreq: tegra: Add Dmitry as a maintainer
Date:   Tue, 31 Mar 2020 02:16:13 +0300
Message-Id: <20200330231617.17079-2-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330231617.17079-1-digetx@gmail.com>
References: <20200330231617.17079-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
want to help keep them working and evolving in the future.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b8abe756ae0..9e8b0779f6df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10931,6 +10931,15 @@ F:	include/linux/memblock.h
 F:	mm/memblock.c
 F:	Documentation/core-api/boot-time-mm.rst
 
+MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
+M:	Dmitry Osipenko <digetx@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Maintained
+F:	drivers/devfreq/tegra20-devfreq.c
+F:	drivers/devfreq/tegra30-devfreq.c
+
 MEMORY MANAGEMENT
 M:	Andrew Morton <akpm@linux-foundation.org>
 L:	linux-mm@kvack.org
-- 
2.25.1

