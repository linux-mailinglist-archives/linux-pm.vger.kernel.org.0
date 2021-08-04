Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847643E0219
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhHDNfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhHDNfF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 09:35:05 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F65C061798
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 06:34:53 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f12so1537620qkh.10
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSfNtUyU9x/YGEG2BT0B9uxjpaTMgrW+GMW+Gx0V97Q=;
        b=TpJYOKtrBFCaIgXuJrcHTL9EdQQt/csWAYYnG/TNqSXdjlttxf00i3FumuVwQpC/i0
         pyfQyywmeGDkG/1pH3aozxBecjgdjvF+ryY1UQ2NFBsNKqfCflLMbOzmDqL4qk/UYiJy
         js9SGtFIVZ+rhbM66/odc+gGx5HYgIko2j2ShmUO5qJgoiQig132zbESQ5bK//hFwj1c
         oyueGqgnhmdwYSYBk/5UjslheYVPlT9RMCqXz9RHPdBNwNKkkJMZvtt573O0tECXCWV/
         lkmiok0E7LQpt+rvED+wrD/Ln7HahrGdtgWIyvCItrhGEPAK1RFNudkEuAz3/xqjvXiX
         Qr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSfNtUyU9x/YGEG2BT0B9uxjpaTMgrW+GMW+Gx0V97Q=;
        b=SNnhezy8xQmP+wzv78ADOIiqOYClGgmcoH/4JeM5zPVj6v/01+F5FR8jT06jcedcwz
         IwZkOR48mSwo9gVlydETmTi6o0p6zFqzfAs9SGQAHPF7xr8GRe2ws3lpLU9pfKivnnAu
         n53IUl+8MJFwzRwZ5u4GsS1dA0kaW/Bd12x2YTMqMnuGde5Fz3M74PRc/iLHv3f8t705
         HZ4wv4YUcLRN4zIuVZmQtxAy0kD5hh16NKRzjX/+rcbiOk9FU7JP1FhSvlcBkMdn+EhR
         9b54exqHTckfaC2vtuFCsAIYVmaegoYNiv962WsK+d1kRxWl5aDPcEqa7KwDPmz7JcvA
         GHOQ==
X-Gm-Message-State: AOAM533/FCkcKijf/QvPWFiMnQ64arg2VNaTJl3T4XyTUHeCImw7KxbV
        KiBTR6doarxmFIyBb+mECqpdxw==
X-Google-Smtp-Source: ABdhPJyk5Ylha0tBS0IPdf6k19JH5IiOL/TMwax3CAbXwe5mPVxvRQa2P0A+g9mDDJAgyUrioDgaTQ==
X-Received: by 2002:a05:620a:448c:: with SMTP id x12mr26075570qkp.39.1628084092359;
        Wed, 04 Aug 2021 06:34:52 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id z23sm847908qts.96.2021.08.04.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 06:34:51 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] cpufreq: blacklist Qualcomm sm8150 in cpufreq-dt-platdev
Date:   Wed,  4 Aug 2021 09:34:51 -0400
Message-Id: <20210804133451.2503674-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm sm8150 platform uses the qcom-cpufreq-hw driver, so
add it to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 9d5a38a91f10..231e585f6ba2 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -141,6 +141,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sc7280", },
 	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sdm845", },
+	{ .compatible = "qcom,sm8150", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.25.1

