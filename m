Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4A617ED
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfGGWf4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34238 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbfGGWf4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so8629540qtq.1;
        Sun, 07 Jul 2019 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psggdP0XHbRkRY1WzuWDz0G+8Im8+M/iXzjUJQKn4ms=;
        b=GeKeMHgn+BN+bjLHk6Em6ljyQs3xE1y8peI+qMnKGh+35HCX4lnwWzRgxaStRGdwI7
         FU8X9k3tTny8ZVTf7CzkU1t2zGdxOumgLB0kXFD1H/kv1yQ5jI1m1S4Oi1Nk/sWH7U6B
         PamCwZrWoVIzGUetOu3Q02lMhEFxxbROkESOY2SotktNXKRLATm8JCkAiUZtSXTUBVRo
         T7TWi/sGxMANQKh5TOz7GVnxMWwkG+fzUZ2ESVR3bv6YDJm3jgavw9KDfU4brj8dvEKX
         oO3fPIdiv4oAZ0cGEyIKXJGcn6rh+TZvsSdJCAAHqeLPaj+kEMcADs58RhERjfJwS3dx
         N5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psggdP0XHbRkRY1WzuWDz0G+8Im8+M/iXzjUJQKn4ms=;
        b=s1eLI60f1onSQQsbarBRpapVTf3LrWMbbLi/AGY6LFzy8GvShwxdk5C+RGVf5nIvuk
         1bFqNEw25n7ZddJ4p2+SvQ9reerXRC19zWnpUg/kyd1WCl+xBbU3W5OhfrvM/Iso2bPK
         3Z9HU5z7W6ExAKxo89QupGpFIzwzfDCgxoQ+eNzLjtvZM5120Fb4B9FSSNj83Ev0iPNd
         wSsWY/6W19JXY8PwFucWi31BhMaSKtpXa0SDwxGqGaN49xfDjtz9lfAurfnrNAtl/TxD
         ELz2lQzfaGZX//m+z7kyABaP8cYZfOuyOIxd2EOCgwTdAle4CW8wsLSNBkGM76LcokEv
         kAdg==
X-Gm-Message-State: APjAAAX5DEFADmOh5Obz/VTY0GlIKn1+/8LLzT3b7619R//Hj9S5MKyD
        zLyJsofTOCLh4Vou4tNOr913wXQz
X-Google-Smtp-Source: APXvYqyia+mvy5wvluUBNfe0yc8nF2BZ6ACxB9rReiPkOqetTFiB3mb1yT58Ym+LlGmD3zNORGQdrQ==
X-Received: by 2002:ac8:2e5d:: with SMTP id s29mr11599618qta.70.1562538955400;
        Sun, 07 Jul 2019 15:35:55 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/24] PM / devfreq: tegra20/30: Add Dmitry as a maintainer
Date:   Mon,  8 Jul 2019 01:33:03 +0300
Message-Id: <20190707223303.6755-25-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
want to help keep them working and evolving in the future.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95d4bd85df44..4e47ce737376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10356,6 +10356,15 @@ F:	include/linux/memblock.h
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
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
-- 
2.22.0

