Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8E1C0A58
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 00:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgD3WWk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 18:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgD3WWk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 18:22:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9B1C035494;
        Thu, 30 Apr 2020 15:22:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q8so6047820eja.2;
        Thu, 30 Apr 2020 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvMPT6f6AC+jTWMexzBGTgQfnPn2sns2A3ZAPET4Rk8=;
        b=gDGrzE+f56lxrYhorlloXvrhRNyhkGHdlX/F0I02YuvpvDDNDla0KCtwFzw2kvJqqu
         0ieN5LpG9PRRyIU3+MUHISH7L/x+Y7MLJODAiDjdcfh1H2sHERqReCw0gO3oL493HeeI
         SRqp2ersLwGciOj6u6CU+Fj3A4KV2ox/+zgzFcXUJPsBeStuLzd3NSTb2eHz9AjL+fsw
         EPP6BYTb/pHU1TOyj4tbfcxC6KFhqIBurWOPHrelKexkgwqS/gqOsY61owwQRYNtaKWY
         KLu9IBQCyTIiTwKwZfDXM7OamErwhQ47oWapXF1ENpY/Ngza0aM2mbJV8PfjJZjlQVcw
         vtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvMPT6f6AC+jTWMexzBGTgQfnPn2sns2A3ZAPET4Rk8=;
        b=XWMKEEFMEMlkyBp/0jOVMePjNU+XFC2KjopShuT1W9j/KVvWzSay8onrnJclfqornZ
         sz6Kbw7sb10aaTCaDzKwXBqD15hbYD2K5Pmdni+BgVBphoB/cX/I0yt/VDozUaciXau8
         VHdOUpRQm1C+LTs8QhI/x9bAD0G1mLbCk6LTVmhiFm4CiaNqbTQvNLAJN/GxXaWnGgB7
         PLK/y3UjDZQep/NbNZ+bqFeIHDD1FfxJpMNfTj8PEhDU2ehV9iFzmTA9Va1cjkMjT0uE
         HmvCiaIdzxhcTsp+J4jrfR/ns0QXBLbl1NvmbHOgqqwl7jInnLqy/vadsQgKel1F1xSI
         unxw==
X-Gm-Message-State: AGi0PuYT4nHZfAj04gq8kP/BusV08GNVwwFJsQLh2VybXx/R3WLAXutj
        fXkGLZv5sXVAZKO93JgEzbc=
X-Google-Smtp-Source: APiQypLKsen+rCTMgTgVt6GGInCrJMGT5P71Rr98AZwQs0GMtid8gwZ2c9iPcOea3Brgf3zdQzctLg==
X-Received: by 2002:a17:906:4c46:: with SMTP id d6mr587849ejw.257.1588285358634;
        Thu, 30 Apr 2020 15:22:38 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id w4sm56863eds.92.2020.04.30.15.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:22:37 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom: fix wrong compatible binding
Date:   Fri,  1 May 2020 00:22:25 +0200
Message-Id: <20200430222225.3941-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Binding in Documentation is still "operating-points-v2-kryo-cpu".
Restore the old binding to fix the compatibility problem.

Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a1b8238872a2..d06b37822c3d 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -277,7 +277,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
+	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
 	if (!ret) {
 		of_node_put(np);
 		return -ENOENT;
-- 
2.25.1

