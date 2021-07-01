Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA43B990E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhGAXbR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhGAXbI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA9C061762;
        Thu,  1 Jul 2021 16:28:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p24so10842762ljj.1;
        Thu, 01 Jul 2021 16:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siP4gSWyG5pwngs77eaG9u5rXqAR0sxlIWowQKNY7qI=;
        b=YJ77qQ/Jsrba+akC61s5SzoPtP/wZfbkiGlrz09dqzYVcBGl8t1Njs5BEu7KFjfRIj
         Mnl5RZpnucZWyE0j0c1YrxG+FoiafR4ginKs/Te0OSk/V1bb6Kl5UYIN4q4FGZqibcTF
         99Uctas9z3VkEgE9J3m7ekGgFsVX8PzIyHpFOySJ5kw7nwS6mynuAHEjq2n4fgdRIl3e
         2brrJx2eJzNODEUEO67/tzlVsql6OeHU0QJMZ0Qlkiq6//5Pb7o7mkgcxlhIaTjEQlJ5
         TTsmpreFi3yXG1I+jchlgn2B9As3sHzRd7Yfrx78xWi3Es+oTi9s30q1QvOrdwdSd73D
         xeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siP4gSWyG5pwngs77eaG9u5rXqAR0sxlIWowQKNY7qI=;
        b=Xv1q++8BlCHORFUiW8ddzAeUe3gqKg0fwTQYCUqBPut/ggwDuCn/gsaBFuOHTqkf3o
         T2DWaM2guEqTXGsgJln/ds4GQpyAKdgws3kwBovb5u7L0C0oqG17GNf51BlRf+qkKPvN
         z1ng1ypf5iDEgo6nJoBA2Be7lhaGvTkyg99BeHUZ00J0i0iHs0HZT4pkYR4SsjF7LWEy
         nj8Sv/LDl+63FjjtC1raFo3IH26zG9dmhnzRBmHb0bkpvQJWzaZ6O5OsBEU/MogF3EIH
         9NWCeCqcGrXoTTWlcmfYZEGPv2YvxCiAmk6x/EWmhRnDl+DRcnu1j5Zg9DddGunUsGzs
         l0Mg==
X-Gm-Message-State: AOAM532PollboXNucuAj9zloW3q2TWAIeEObh5ywFvYQiQOvhAd/X+jQ
        3kUjzJlAYxs+nU/1DbeO5Dw=
X-Google-Smtp-Source: ABdhPJydkwDmszKhecbbynICYkP+98jUxwqcWcVc3TYUdOAeFBjQmutJzhvdVAwNaUF8PU/ZpxSrqw==
X-Received: by 2002:a2e:7617:: with SMTP id r23mr1513704ljc.376.1625182114914;
        Thu, 01 Jul 2021 16:28:34 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 09/37] gpu: host1x: Add host1x_channel_stop()
Date:   Fri,  2 Jul 2021 02:27:00 +0300
Message-Id: <20210701232728.23591-10-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add host1x_channel_stop() which waits till channel becomes idle and then
stops the channel hardware. This is needed for supporting suspend/resume
by host1x drivers since the hardware state is lost after power-gating,
thus the channel needs to be stopped before client enters into suspend.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/channel.c | 8 ++++++++
 include/linux/host1x.h       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/host1x/channel.c b/drivers/gpu/host1x/channel.c
index 4cd212bb570d..2a9a3a8d5931 100644
--- a/drivers/gpu/host1x/channel.c
+++ b/drivers/gpu/host1x/channel.c
@@ -75,6 +75,14 @@ struct host1x_channel *host1x_channel_get_index(struct host1x *host,
 	return ch;
 }
 
+void host1x_channel_stop(struct host1x_channel *channel)
+{
+	struct host1x *host = dev_get_drvdata(channel->dev->parent);
+
+	host1x_hw_cdma_stop(host, &channel->cdma);
+}
+EXPORT_SYMBOL(host1x_channel_stop);
+
 static void release_channel(struct kref *kref)
 {
 	struct host1x_channel *channel =
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index 9b0487c88571..789aee540700 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -179,6 +179,7 @@ struct host1x_job;
 
 struct host1x_channel *host1x_channel_request(struct host1x_client *client);
 struct host1x_channel *host1x_channel_get(struct host1x_channel *channel);
+void host1x_channel_stop(struct host1x_channel *channel);
 void host1x_channel_put(struct host1x_channel *channel);
 int host1x_job_submit(struct host1x_job *job);
 
-- 
2.30.2

