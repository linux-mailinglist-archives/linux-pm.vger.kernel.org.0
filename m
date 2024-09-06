Return-Path: <linux-pm+bounces-13760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A23C296EE68
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 10:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3D71C23DB5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9796158866;
	Fri,  6 Sep 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbKpDR4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009C158A3D;
	Fri,  6 Sep 2024 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612068; cv=none; b=Zf2KIiV+qnrAR7fITiIeYvGzV53f1NXPLmIFBe5Bk4W/iaY3/I07E4Ptfxg8A52czbTBLyCWQSDcGSVqBoJf8BtDDw+opYzBMh35UKVfI9PGYu7Lo5AiizMklTKR2rd/EVZZ4BbiIROEDYbVY9FcJ6i6gxbzZbF+m1M7Ha+8iWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612068; c=relaxed/simple;
	bh=CHWPcZ7km7hwuS5Xs1FJz4jjh/9Ft+4rdu5VnX8r5GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPQ5/o/YVn9XTL4X31ombUQxtHyoNO+82XxlBCrJtKuvl++69Rv47SRH71/rXi7js/j/6d7/B2leqYXzuO+dx38uZtwO6iqEZxCn3lWF8klbu8ZPUQ2CXJReOM2Sbbb9tgd9AcBbVfwliVRuipJgpQay1jzSQXRCKxbHRvXLpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbKpDR4j; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso315069b3a.3;
        Fri, 06 Sep 2024 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725612067; x=1726216867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WKP+Hau/kw8wzZd9ohpzoDpywr8aafKO/MVcMbklZM=;
        b=mbKpDR4jJcCCdxgLSQ+1n3qT0yfrlapA2V4VTBekFb/MF5jjq9GVpbCYHZEiAv0IVd
         1zmgCoKc64S1/4kouhyDiCrvk5cPg02JtXRYwfTYtwGGq7vNjtEXmMRefC3gpifbCXeZ
         OIlWptoaYarI8/vP21mVtWa3YCqa6Du0nkfQlhOnNWVD1eObGzTf4uasf8VmoXhbD8A4
         RSB5sAjBQNHZq93IkXgi2PhMPlahphavb8wuHYMBxCZ5FDn/5rPtiOY1H2Zz9XvnuNF6
         ipb7NzkoRJ8aIflwaG++kKM01ZZtk44AFKPbO43HFo942SoJoswoet4Xvd6Yms1raidh
         2SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725612067; x=1726216867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WKP+Hau/kw8wzZd9ohpzoDpywr8aafKO/MVcMbklZM=;
        b=Cct4EXaEOZb2QaXkAZiVdPJGhwTXqejE4xNR4xOF50xW+aJjf9vl7s2zs/r8UIPLcs
         CtAd8ksCeUOr3Rjx1kZL4s/XvWdhWAcxiOKpgW8n8yPaF4BR4yXR8DyhejZ+E0QIJ/WL
         8N6gqMdi/+vpL8Fw3zFlb5o2rJAmzOrXZg038DoDxvd2eVAebpKaI3tQG1oqsIv0TsnP
         NCD5ZBpG4RFNbKUxcC/TLrk/s4TPcgnJUKUgxbsudjSIapljb0S2UCDPrw+CBM0WBEiU
         JuYSq8WXycqeKfkApEKegXXnQ2NJ69/FCDYFwyRP7jjM/j3Hvnl0iPutbcbBCS8SrX2V
         1JiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5d4pUwDKWYVWEDe7DYaOBC/azITBJYVnyfDXTyG4rA/TzxSE6dzHdJ6e1Y2Gfk34DpegHcRO7k0ad6aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6nUHmtpRbguP3GQCdSGrPmvF56q0uAI103BYXK3XnPNfsk5l
	N/WdnaUp8lMmvpBucaEVfW3EDyFG6NiN9whMu1oWa06iTuJMdI2Y
X-Google-Smtp-Source: AGHT+IH7IVZrX7yz6failNVW2u31F8Anuu0aSX74OSxoNKsQks0uJtN/IC1pH7EDHHphKI9sMdCJIg==
X-Received: by 2002:a05:6a00:a27:b0:717:9754:4ade with SMTP id d2e1a72fcca58-71797545195mr3845559b3a.22.1725612066569;
        Fri, 06 Sep 2024 01:41:06 -0700 (PDT)
Received: from fedora.. ([106.219.166.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718dad25ffcsm562378b3a.175.2024.09.06.01.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:41:06 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] cpufreq: mediatek-hw: Fix resource management and error handling in mtk_cpu_resources_init()
Date: Fri,  6 Sep 2024 14:10:57 +0530
Message-ID: <20240906084057.67680-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory region and IO memory were not released if mtk_cpu_create_freq_table() failed.
Added error handling to ensure that IO memory is unmapped and the memory region is
released properly to prevent resource leaks and ensure all resources are cleaned up on error.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 8925e096d5b9..3b1303f350ec 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -207,13 +207,15 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	ret = mtk_cpu_create_freq_table(pdev, data);
 	if (ret) {
 		dev_info(dev, "Domain-%d failed to create freq table\n", index);
-		return ret;
+		goto unmap_region;
 	}
 
 	policy->freq_table = data->table;
 	policy->driver_data = data;
 
 	return 0;
+unmap_region:
+	iounmap(base);
 release_region:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
-- 
2.46.0


