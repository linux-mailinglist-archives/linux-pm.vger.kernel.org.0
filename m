Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F8534E92
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiEZLva (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiEZLv3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:51:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD7D0280
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:51:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z11so1535692pjc.3
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hnC4nBDrRSbLBaoHGIBxIYxbbmkrO8yd3eHf9/alzw=;
        b=jE39E1RvJEURSRbSoMz9m9Q/koczVR5fxk2AGYg0bRmx48WihlmBl+p0z7wS2CRGhZ
         0AV+09aq+A8b+jURrxTe+WU9EmgkCdg0rGo2a68PXpfE9/C6b+m5vHi1is1jtNAPUIZx
         5ITI8c8LzM9x0RK/Pya9yeaLsrqbgL34mLGF5YDDTQAxfXAcu2OnfGZnDSZ9okY5pq5M
         w8oRAp0nnpIL09IJANVHEhBak6sIVZ6Qf+VYsIdRxFh/D/MBMpQIC3AdQL4+p99ldjXY
         ECH4+i6Yqt6NGixTx2tQJqC9V36se/oEx0Uly2KpiOM07x/IBM0U8rBBepAlzZj9cS0E
         FtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hnC4nBDrRSbLBaoHGIBxIYxbbmkrO8yd3eHf9/alzw=;
        b=Ncs9I0UTMUzKbGjLDd4MewFhYn6mJWqFrwBxtxXYddytYpjYsUGsLfWeRjQa+9WVkq
         aghHqsqO7EADtjDTcjKQUUGDpyMSsgGsQM93eZSt+2hoDZkdCQujqHmplXt6Jn8jZXLv
         OMYrSwL/3K7HyALWqSdsCjpXLtMlrcgKwlrHjhNY0nCfrjbj6xIBgwOMOGAe/LpE63av
         lG6w04hGc4Ghec6542kY+qXg2cAeJPWfzCPfwVwCk4IlMdgCLEQfqOECWI3wR1oTtj1H
         hnmbMOS++9Sp9XGo9PrnUVifkfGCZM9GzuyugBk8F61PDoDrY+acbRj3kLqkLNgm0ZE7
         hMeA==
X-Gm-Message-State: AOAM530zh4cNc8/Cosx/f7LJgi+BaVgROQypsK1t9EVT7JM1ZwTWddTC
        IgbW5yJzvzJcexKYmTKyXkCDFA==
X-Google-Smtp-Source: ABdhPJwuw66YNSXgMv+2kHOdywbyyiw7VZG0FDdLe9Ihqj/Z5cGtF85QfiLYrrFX2s/UjqdRhdNDnQ==
X-Received: by 2002:a17:903:1108:b0:15f:bce:19f8 with SMTP id n8-20020a170903110800b0015f0bce19f8mr37653897plh.7.1653565887697;
        Thu, 26 May 2022 04:51:27 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id bj11-20020a170902850b00b0015e8d4eb242sm1330470plb.140.2022.05.26.04.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:51:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] cpufreq: Minor cleanups
Date:   Thu, 26 May 2022 17:21:18 +0530
Message-Id: <cover.1653565641.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This series contains few cleanups, with no dependency between the patches.

--
Viresh

Viresh Kumar (3):
  cpufreq: Optimize cpufreq_show_cpus()
  cpufreq: Panic if policy is active in cpufreq_policy_free()
  cpufreq: Drop unnecessary cpus locking from store()

 drivers/cpufreq/cpufreq.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
2.31.1.272.g89b43f80a514

