Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AF83FC90E
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 15:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhHaN6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhHaN6A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 09:58:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA1C061764;
        Tue, 31 Aug 2021 06:57:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q21so31912231ljj.6;
        Tue, 31 Aug 2021 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDP03amDwCEY6IiivIbDG+60+C+xV/Pv6sR1LEywSYo=;
        b=joFzU8WPJH8DP0+WGdlyT4Tgw7vhOJ+mTQaTb1LSEO1z/dKqhZO6LNqV3eIsxqrNqh
         jTvvIgRsSURHHRi6MwKtud6Ry7//fDmPl+/gmwgA4Fm1/oqYMWECk13igVwEFbXCOATM
         F6qQc0iqXyR1Wn9B90gaZg6xHFDBkLXhZEgharG0yWgA3OUh3l8JkhnaRzFg2mvKQiok
         j3jQecttboUU0IlWM/uDxP4owTEAo7CvjXRM22byBE0ERMvJpCFeipwbK511NI0l6TVr
         tO2TCvS+XlSfWqdKdLLuB5DTjNYeof1Yco55xnCisM1bPc9BOEeuhpU1oISJrnRBPCxH
         Fy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDP03amDwCEY6IiivIbDG+60+C+xV/Pv6sR1LEywSYo=;
        b=Q2moyPsO1sGu1FjXHKB/Nb6mPvlMXD/eMuCKVJPtA38aoWXuY++fbe2eTRvbdXD4bX
         7pvgpj9DsucO8Z9wnKkl6AALOE+zna9QJLRvd77mVkYwib1r774C2mRDBc1kdrgqdmpa
         b2fm06EMZCiGjY6TyWOSZIU8cmu/tqzMPZ9aU5n6MqEguBGwtuPD1w3+V76MKUthapPk
         2qBanUthZvemkRt3N/1Hsd6eXSbSvqPbOcwhlZWQoTHUGbZ4xaDaQgRpI7fJkT8XYAgt
         cmIAjx3QIGC+KtwVvBvW/NCPSC3F2WmKt+p87EARYWZB1zks4T4lk6uLYrO0BP6+dox5
         VRgw==
X-Gm-Message-State: AOAM533pinGYoUMGVQdW6rWHWTwWt82a+06sBHZNfs8fdGUCaOfHbWiq
        61VcWCMNZMIdteh0esULL9c=
X-Google-Smtp-Source: ABdhPJzoJ/gElLf6N9bO/NPqrNrysTQIFQEktX7rML2l2ShYORbg+kuDiamYRjl7HTQxP53SL3aKbg==
X-Received: by 2002:a2e:a363:: with SMTP id i3mr24868111ljn.56.1630418223330;
        Tue, 31 Aug 2021 06:57:03 -0700 (PDT)
Received: from localhost.localdomain (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.gmail.com with ESMTPSA id x4sm2203622ljm.98.2021.08.31.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:57:02 -0700 (PDT)
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
Subject: [PATCH v10 7/8] gpu: host1x: Add host1x_channel_stop()
Date:   Tue, 31 Aug 2021 16:54:49 +0300
Message-Id: <20210831135450.26070-8-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210831135450.26070-1-digetx@gmail.com>
References: <20210831135450.26070-1-digetx@gmail.com>
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

