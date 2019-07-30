Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2D7AD9E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbfG3Qck (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42358 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732888AbfG3Qck (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so16578485wrr.9;
        Tue, 30 Jul 2019 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nd7tLxBm8dQITEK9axtPpPqVYzUfP392hOYHsa0EW0k=;
        b=Cg+uN4uizrV/T7W83ZxEUyWJbb+hhILW3fglpZrwRH/OnI6ozXiflVOBTAzcxPWu3a
         9Tgjq3jObdpsOpgKdmwAsH/6tEOYWF4dBDRLUMFZx2QoXvNrm447rCkr0ilB1cCWRcbM
         caj39NrqYW/pt6WJTWlNhV+2FCkw/jEucIQRFCGln2Y9wL3rxMIhUk9nafw4OnYMbFZw
         LBmhv8f33qBQeIl2TgkjHVJ8uvmHuF8CTvbqocYPBRnYO6k7fMrgaB81B8ho8RsI/sXw
         0+OkjtoDJEV4VKJADRnGExhQIyPxmZtQmvyC4cGg29fzWFaFTxhtCdv2bEUZgeqablBl
         Ldow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nd7tLxBm8dQITEK9axtPpPqVYzUfP392hOYHsa0EW0k=;
        b=HxcqtAbZ6mtp9noAobzCbd0oA11ydYqkPbgr9Qh5XH1aV2mvkTa8fUNWmNOC6Heg6q
         Gv1lLBR+FxftZGAuvMtGM7DqJZwcIJB6ZcWps1BOWbFpymGNic7WPEbNps7hbOdTqZCO
         QfAyLjqmOEuP0df/p7v7xr7wWpA5EDBSg7lLmw7irt7nmlkZ3CC6aTWw7GpNozJW7cCP
         /g4vyA5Ebs7TfkNXIGb/LBQoIAibSNXNvqApuIYuiNb2+AwjG0DMuPtgFvTy/+njMmQP
         wBTIT+diXM10SbLiwHMMH8f/NtVrfPl7SDHg2J3+2RGD+tk9i3jPkLtj8VYIwKiFAPhO
         tHZA==
X-Gm-Message-State: APjAAAUvFRRiL/bms1keGnU7k4x0r3WuG8tfmzqjwCFwkKYexjjO/5JQ
        JGOnN/bGheJj4NEZSof6MEA=
X-Google-Smtp-Source: APXvYqwo7ZjhmT9rt89OVJ7JgdxmHw/3CqZKj7CV36y2FuC3Bwbts5t6Ni6GBwfHoGtz4zHu8PfxYA==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr126916096wrq.53.1564504358196;
        Tue, 30 Jul 2019 09:32:38 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/20] PM / devfreq: tegra30: Constify structs
Date:   Tue, 30 Jul 2019 19:22:31 +0300
Message-Id: <20190730162236.6063-16-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Constify unmodifiable structs, for consistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index d0e971e51faf..81efc3ddb486 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -107,7 +107,7 @@ enum tegra_actmon_device {
 	MCCPU,
 };
 
-static struct tegra_devfreq_device_config actmon_device_configs[] = {
+static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 	{
 		/* MCALL: All memory accesses (including from the CPUs) */
 		.offset = 0x1c0,
@@ -175,7 +175,7 @@ struct tegra_actmon_emc_ratio {
 	unsigned long emc_freq;
 };
 
-static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
+static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
@@ -214,7 +214,7 @@ static unsigned long do_percent(unsigned long val, unsigned int pct)
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
 					    unsigned int cpu_freq)
 {
-	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
+	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
-- 
2.22.0

