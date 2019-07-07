Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565B2617E0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfGGWfc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39420 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfGGWfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so7999965qtu.6;
        Sun, 07 Jul 2019 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12B/bt6SVgc5lffZlTQjWurlY0GI/nKmVUIlM0Zspto=;
        b=nv5M5gN5WenSCeUsr4wlhXkUnYMrFcybWFVtxdBxx1xdIUU+TdmhKrgc0By4lwH/g0
         DkjKsh5J0IchjYMG96JBD5pBsEE4VELim5G1qkLTl0P74ze4cr6zjf5MoZW/32X0JnzW
         ci2Ng3jTuzyznnafE70gDgZMpGdPmgMCEq/fqxJvSObuSD1oxW3bWH6iCcYNT82NtfqS
         Z1zJkfZ5WtdHcrzDChAkT5IAqPkutAfsi+HRqs7xHyksEEpoy9X/58BMP6S1K+xj3vyR
         YW63Kt4e3quMev3r8fjMrBr4fQdM485nmb6QK2LykvHjcmhy2jlul6159aw3JrhJ30dR
         heeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12B/bt6SVgc5lffZlTQjWurlY0GI/nKmVUIlM0Zspto=;
        b=SBlivrfXyF7kCgR8d1l9PhEkApRvQiirdfAv3SNCW6EYoM1c9pPiTUshHPqbIic5rn
         kDqHFV109Ql2c/j1cv3Tnrtaa9Ne4Eq4bur+7mMkqEI4vcpKHQEKBAswZhmYC4Oxsxwy
         JPbuvJ4GiQuTZTT8+aSBb0zYDiLCalcUs5t0+GKwyiD2s3ihtjKmJ4lI1HLkoANok1cs
         tUmxoT6bZgEj0/fZG9DEx7H3AzTNb36+p5UeHvPW6z99b6fC7MYIBxN8DiwMlvyWFfrZ
         uw0iMtAuOxU3LSO4f410trWxUH2YDcm/f8j25v0sOFZIQJ7CxE8iVtT8MzJMK/36bMP3
         sjxA==
X-Gm-Message-State: APjAAAXd9yIiPIHTnuDKuqQGvH3UWXpJ+LP80sM90AAFecNbz/h9B/Ur
        bMO0aTEWqrCc3H+YjwiB/+0=
X-Google-Smtp-Source: APXvYqwa2HyxP3kBjbyqrwpBs4ocftkBWbbxoaqsTk+w9KUcnbFVRdGSslt66cOd5ENj8kxkHDohCA==
X-Received: by 2002:ac8:3637:: with SMTP id m52mr11485782qtb.238.1562538931176;
        Sun, 07 Jul 2019 15:35:31 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/24] PM / devfreq: tegra30: Constify structs
Date:   Mon,  8 Jul 2019 01:32:52 +0300
Message-Id: <20190707223303.6755-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Constify unmodifiable structs for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 1a10df5dbbed..2f59c78930bd 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -106,7 +106,7 @@ enum tegra_actmon_device {
 	MCCPU,
 };
 
-static struct tegra_devfreq_device_config actmon_device_configs[] = {
+static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 	{
 		/* MCALL: All memory accesses (including from the CPUs) */
 		.offset = 0x1c0,
@@ -171,7 +171,7 @@ struct tegra_actmon_emc_ratio {
 	unsigned long emc_freq;
 };
 
-static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
+static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{ 1400000, ULONG_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
@@ -210,7 +210,7 @@ static inline unsigned long do_percent(unsigned long val, unsigned int pct)
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
 {
-	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
+	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 	unsigned int cpu_freq = cpufreq_get(0);
 	unsigned int i;
 
-- 
2.22.0

