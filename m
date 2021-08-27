Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB43C3F920B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 03:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbhH0Bix (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 21:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243999AbhH0Bit (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 21:38:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BD2C0613CF;
        Thu, 26 Aug 2021 18:38:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m28so10939033lfj.6;
        Thu, 26 Aug 2021 18:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDP03amDwCEY6IiivIbDG+60+C+xV/Pv6sR1LEywSYo=;
        b=KD9YiLyI59N6auovPD9EdqECBN8+LG+i4emXwai8UV2vfa71wjQcqWMU1LGGppM4TA
         kOQTl7LG3rjCi5fAIo6Z/T/qDkoofGwxkYVQzCdEbmEwF8ObgqZkXTosKH6UDE1ocF83
         XtGDL0yCVVXZm8yz2vXjfaNeD7321FEVaaF7MmtVj1V5i55/rKQ4x+OamlSHXyLfd/aA
         /EMV44ML829jByGmcbdy6sDd/Ql7sd7hFcXl3Yvn2umHRx50eU1QMKHiqrrk+be1hk4T
         huC8yZfrO6uk5HCSTv82M6nhc75IqQrex9AEaP7PeVFl6Bd3FNsVZ36EnwUg7Eer4ODS
         5I3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDP03amDwCEY6IiivIbDG+60+C+xV/Pv6sR1LEywSYo=;
        b=qwqTakq27D4FerUFg16ZEaKgDCLCiO59vJqjYQyiQ2bsfP3SJ5bGVAci7XWNGlNRRa
         q6d+uCVhig5O9cI6E9F2phd6E0O5eHamGPGRhVQ3WvqxQWSLJsLMkuVjbjcJhVfBnHis
         C0BVKsv471rezKIp3l67fgkt7XNeOBuQJBak4w0HpJ+jaIqPkOcD+IwTSGeMNio3GpOj
         cZmZsMMIQMCcSarKdKAMvzHErv3abzA9GRQbYzPrfi534AvDLjV4zlImgXlqp+oQhQBl
         IyCDb8hqTWqW/MvVztbsdh7ld816RARLbKo3cOA72o2XAZN198+bG5qqxta6BgUfq+8V
         aoDg==
X-Gm-Message-State: AOAM533I/0Ez1TA1Wyo6awfCyIWRc+/qmyugLg1OiY0mOrXS9AR+AnvU
        UmA2IZnudMEZ4uhH8x2nqOA=
X-Google-Smtp-Source: ABdhPJwIbBLsghNnVtkXQivhW6qOj3L046ZS0fPLnhAv7OSgju+ZxjHhCHr6g0fVcsrjKbelLKvkwQ==
X-Received: by 2002:a05:6512:ac9:: with SMTP id n9mr4703705lfu.635.1630028279416;
        Thu, 26 Aug 2021 18:37:59 -0700 (PDT)
Received: from localhost.localdomain (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.gmail.com with ESMTPSA id y3sm494289lfa.240.2021.08.26.18.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:37:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v9 7/8] gpu: host1x: Add host1x_channel_stop()
Date:   Fri, 27 Aug 2021 04:34:14 +0300
Message-Id: <20210827013415.24027-8-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827013415.24027-1-digetx@gmail.com>
References: <20210827013415.24027-1-digetx@gmail.com>
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
index 7bccf589aba7..66473b5be0af 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -181,6 +181,7 @@ struct host1x_job;
 
 struct host1x_channel *host1x_channel_request(struct host1x_client *client);
 struct host1x_channel *host1x_channel_get(struct host1x_channel *channel);
+void host1x_channel_stop(struct host1x_channel *channel);
 void host1x_channel_put(struct host1x_channel *channel);
 int host1x_job_submit(struct host1x_job *job);
 
-- 
2.32.0

