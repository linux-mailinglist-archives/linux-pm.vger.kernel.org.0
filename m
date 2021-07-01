Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41C03B992B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhGAXb3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbhGAXbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5741C061762;
        Thu,  1 Jul 2021 16:28:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h6so10779441ljl.8;
        Thu, 01 Jul 2021 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gm3ofSamUdmxAaD1zjMkIrbw5F8DM2MvEznhnJlT0ls=;
        b=s4x5xOmmj6K4cZR2Q2lEgnBz14QJvZ5gjyzCwVM1RdJdHz93qN5YgTbCLxK8wAwnws
         WekUfbTI3mbXn9zOK05BuQbbKKBQwj1qOaI0jyS8QrV7hEIIxpJeKcAR/bkLf8MQONS/
         0X/EkwFk/3I8w+4ML5WjDWFfAJDBTlbMNZltZWtyIeEjbo8jUcL9VSlloe67Ustdbggu
         VLXFT/BY+A5djLPB2jTUvtMRVuwwkiA4NOWvNGjdqP+YHOwB9+0twkFWzzFCwVmM2ZLK
         nNZmbDVideLXWfckVuH2071g6xJY1LLTtSe3vc29w0YxArLrE8r/caYjin8BRI+kS+30
         6ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gm3ofSamUdmxAaD1zjMkIrbw5F8DM2MvEznhnJlT0ls=;
        b=H3lHV/W59rkJTF6NnWR40iEyNgxvxM7tJKvEE8Kct3ZDgWFXtyg0J+EjcN9A7CQk90
         RAMW1fuNpaZK2hfj0US0FpeFsZBNN78vrjD8iETAEgkHgGQVlx/gccnLtxDPyqOlvP9P
         yafoBvYdqGnpEfkYVZiwKdYyriV6sptiz9q74j2DYi+qtOktsxQLIXNTgfNqoBWHCtpk
         yAHbb1fOTFOnHyDe9cOP5solTU0Rfjfd8SEpo1pmf5T9rdCLGz71/VJeQghPGMl42f1Z
         lcBx9ku9KilRYwLXcUm3CI45hwXVAjS1PtSEG+/IyVXms3VSuYeGi3bIAlEi0LHk0Nwi
         ip0g==
X-Gm-Message-State: AOAM531izDwm9wYft9qyfxOLtSY7RYeJVXVX7cMEhRhTaxRxPG7BAsNW
        oeg9ZtX3CgsWBBFA1ma6FwY=
X-Google-Smtp-Source: ABdhPJzDBurrPkiOEx2PgHSdoQoLrTATOJ2A9eRLLIrxJOaN7wRWidS8gB/GQDSYeGXO8HbJ2tbDcA==
X-Received: by 2002:a2e:bf10:: with SMTP id c16mr1544018ljr.289.1625182123204;
        Thu, 01 Jul 2021 16:28:43 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 22/37] soc/tegra: fuse: Clear fuse->clk on driver probe failure
Date:   Fri,  2 Jul 2021 02:27:13 +0300
Message-Id: <20210701232728.23591-23-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The fuse->clk must be cleared if FUSE driver fails to probe, otherwise
tegra_fuse_readl() will crash.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 3d9da3d359da..2434c570b53c 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -246,6 +246,7 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	return 0;
 
 restore:
+	fuse->clk = NULL;
 	fuse->base = base;
 	return err;
 }
-- 
2.30.2

