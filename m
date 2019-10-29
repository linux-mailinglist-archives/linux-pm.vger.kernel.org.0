Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B07E92B4
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfJ2WHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:07:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45991 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfJ2WGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so308124ljb.12;
        Tue, 29 Oct 2019 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QxuLfslnQVbhl7LuXHRiC4Oo60NDLS8lYD8jZwDVcg=;
        b=S6cl9sYA1SKb+LaK/ogF7GxQODFPMfEMmPUn6pJxxu6s1Vm5KmeDzw+ZVsfSg36su9
         wtnh3xApwk2PvgRF6kwj81Y9M/bEx33rnSk81CXFVe3MUtjVhYzGbQyEtDandaH0gVVF
         eNnsGXT2ocGDgLQAzX6G550j0YuORc5BeBGlhNXvhDXCOzIT6RwaOou7zLcIHGttjcCm
         PKhQDDm7RBTyeU8wGcBtpE/VyLyWq7OgBKjdwgr3jrmtaxNvVEM0vkjyE59CqF9q3jw1
         P2k8bl4IOFad3dgd5xe+W58VzOdo8D+sdEqMMK2IgjhdMniyRxH7nF76qu5rr3KimzMC
         DKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QxuLfslnQVbhl7LuXHRiC4Oo60NDLS8lYD8jZwDVcg=;
        b=t91iIGemRc932/OWfZUxEazjYwdtOlLmxu0mlZBqaEQh8FLpjei8mHSsTFy/+UY666
         Hub2/mfcR3W3f/3uIEmlTODGOeWfvLAfMLx9HQcB25jhW0Ki+j4+59EBXp5kMBZTbZlW
         2WwGwlZazCOxqksDb7HQ+Mkd7d2BeyedZGRBUiN8Uks0GIe7j03U5utDzyYfCAzqk66M
         Am5ykm3uJz5Q1rym7mSMirq1AzP2nkm9PI1TRQ1m3wV89LtpOyG20VgFwncdNuXPivuh
         ZYqRFF4byYpo4pR5HtCqL/gZEjKiCuG65KUKMGXdyrMahFr+Q4mGfjIGDD07KHt0hWsB
         4HDQ==
X-Gm-Message-State: APjAAAV1tFZgFrzb23DFIiYXd4fbOI87FC+Qn9ZzprwgHTFRZZdrV154
        4kJOT8/D8t/XfepAzmAjp2g=
X-Google-Smtp-Source: APXvYqx/R17UiSJhNZYKK9r6h/2iU1U8YVOjai5/Ad28izdN4gsI2oF+Gti86xLnhgL7haZkWvxSDA==
X-Received: by 2002:a05:651c:105:: with SMTP id a5mr4190210ljb.45.1572386780516;
        Tue, 29 Oct 2019 15:06:20 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/19] PM / devfreq: tegra30: Constify structs
Date:   Wed, 30 Oct 2019 01:00:11 +0300
Message-Id: <20191029220019.26773-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Constify unmodifiable structs, for consistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index e9cb0ea54ee7..f658b0b4a845 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -108,7 +108,7 @@ enum tegra_actmon_device {
 	MCCPU,
 };
 
-static struct tegra_devfreq_device_config actmon_device_configs[] = {
+static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 	{
 		/* MCALL: All memory accesses (including from the CPUs) */
 		.offset = 0x1c0,
@@ -177,7 +177,7 @@ struct tegra_actmon_emc_ratio {
 	unsigned long emc_freq;
 };
 
-static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
+static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
@@ -295,7 +295,7 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
 					    unsigned long cpu_freq)
 {
 	unsigned int i;
-	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
+	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
 		if (cpu_freq >= ratio->cpu_freq) {
-- 
2.23.0

