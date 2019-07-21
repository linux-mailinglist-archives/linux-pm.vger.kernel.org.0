Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709C76F48A
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2019 20:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfGUSIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jul 2019 14:08:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46424 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfGUSIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jul 2019 14:08:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id i8so16514454pgm.13;
        Sun, 21 Jul 2019 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FTXdst5R/SQuzieJLsSNsjPa5PEZl3NiZMobkmxYQpo=;
        b=TTK9qK/8sWitI8E3pN3YavfH2FqVB/+VQYItc84o0fD/vpZ1OeI2c8c0AWWZhLBkfR
         bEXAb5KG8cL2vk1SsPpFStibPjEpYFWeIEzSlkL4PQCDm3mDXuaZuASgZDpRySce1/uj
         8j0v1I+MrFW7tZz0fDRiZDtQLtkKoBwTG2zZV6W2A50fIw7k6caFg64Ut8WzOhK587PD
         za4dfniHkJZdkWRUilpR+08mlWSsjoijWSqllat/ql6W9CfLJF/DW/9VwROFGk/jfzMf
         8LMV2FSt4zR5LXXJIZSE8/u1NbFUmRIXPLXteqUj7BC0iwhNG5mCfH2oXw6U8toPMo5b
         hRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FTXdst5R/SQuzieJLsSNsjPa5PEZl3NiZMobkmxYQpo=;
        b=rsUICB8mLcTdcL7lENBo6UWkujoUBhU+EeoZI/AvmJrbkKuQoBUWqWOGaSmlploHa+
         D66xP3NKW/ncjy0pbuklPxv7W2TS2CsfNn3rSq2OICWawo4qZX1E06NagfwA7eneH93m
         zGdGYCep1y8f5illLPTET2R2fDmtxTvomJZ3PecQBre0OtXe7zoLkw8eY+IdLrj4jVFp
         V8JxO4V3qX9wLs92PfUJz69tihzcQfZA7V1CIHoINhOlb1vIYJjKVY/3ANcCN14eeFaI
         uEQ49xzJ4Ff/yGQhd8SmQYEqMEq8n9mtTS4D092EttdZr48xHT+v2wfxcL1Tm22j6xZb
         AVdQ==
X-Gm-Message-State: APjAAAUg6ITS44Z4CsMltwEG8OS2bKntACXNgDTXBspXp12+68JkJmgC
        tTYupBKotpdlwggxYbzujEVXKHnE
X-Google-Smtp-Source: APXvYqxKToO74HULDPrAR27wvE/2XIeV/0Bn1VO4CaU+4sIBGxvw1p7b9ZQxXZUdfJFA3s0S9POK3g==
X-Received: by 2002:a17:90a:228b:: with SMTP id s11mr70837355pjc.23.1563732500738;
        Sun, 21 Jul 2019 11:08:20 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id m31sm44011625pjb.6.2019.07.21.11.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 11:08:20 -0700 (PDT)
Date:   Sun, 21 Jul 2019 23:38:15 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: ap806: Add NULL check after kcalloc
Message-ID: <20190721180815.GA12437@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add NULL check  after kcalloc.

Fix below issue reported by coccicheck
./drivers/cpufreq/armada-8k-cpufreq.c:138:1-12: alloc with no test,
possible model on line 151

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/cpufreq/armada-8k-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 988ebc3..39e34f50 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -136,6 +136,8 @@ static int __init armada_8k_cpufreq_init(void)
 
 	nb_cpus = num_possible_cpus();
 	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);
+	if (!freq_tables)
+		return -ENOMEM;
 	cpumask_copy(&cpus, cpu_possible_mask);
 
 	/*
-- 
2.7.4

