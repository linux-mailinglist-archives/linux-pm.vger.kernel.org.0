Return-Path: <linux-pm+bounces-35336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A715B9F0DB
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F4A7ACD01
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0D926CE2E;
	Thu, 25 Sep 2025 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIty5TSR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4FD2FB977
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801597; cv=none; b=Dk3J4PZhKvp694oC/pf32XpSC0OPa6uUba3kybtSTYiFCS+zeslZ0UtaUc497FDk5TtZTO3rMJ1A3O5D58PNL/ygoPdeINAoIioNjWxPlWk/qOs0cBw/S8Nm8L0Y+XUyl6KbKYhVpUm6/865rjM8/bpVh/cSsr+nX2HeKLbvVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801597; c=relaxed/simple;
	bh=yRoUXc7iM5E0Q4HeKXKIYrccPXhjgW1c57VO6navqQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrdRih5NveZw5mQCZIYEeJ972yiDZng6Yk4qkThKmqnqsIKrAXWLdhYpUHFrcibMr0N3H66d4vShhZafaO9ieRJz98NjToaNEyWN/Vmf81AZ+BTDHdvcHtPT5RMVcJ4dVPB5wYNf9XP1ricw6e8g4Ec3OjkMAgYu+r9mchOwZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIty5TSR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57a59124323so893405e87.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758801593; x=1759406393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrqoW50S86GQruERN9yWcjsCpx5n9qTugCw8eRLUCCw=;
        b=WIty5TSRAghnp92PNmf/cfYbhC+hqsmgBhxeDJuAR/pm+72Rl+fRAQtSbOG7izUPSl
         +7N9pchgYwVzCFobdgrx5cluwW3sUemZ54KwTyYS35BIyRb2OlGtY/xG+pcstJP92gGb
         gw7++jTZUqCkWLlN/IJJ93HwR+Smlhtneh4FLkfbXDpE9YisSC9WCwJ+93xn64whF233
         9xsz+E4lHY+SahUM95YWtQLxor/PL0zGGLMN6LwRI8z5gi22kRk7R2OTh3wHIBU0jwpm
         80/lFEhU4NjwcNWqEKdxCSQtHqvKqkTcaoFtzOP5hKNY2ePxhDvcbguHZacwDl1nBdGE
         vpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801593; x=1759406393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrqoW50S86GQruERN9yWcjsCpx5n9qTugCw8eRLUCCw=;
        b=T5sgz6GLLHzzGTDNZUP8uA7ZLK72DpaumLFGGP11vDQHAQ6ow70i7xWey+fIRQELWL
         Aln+EI/4QhTkGQ+YaW2kj4y+aEBLlD6ykBAParZWWxtGV8TTEao3MdwB8GsIFaF+bfhi
         +9RNblVvFUxyYkU182GZCOo3J+Cy1ROmZkeVEXlmQM4AMWLkeVrRRpXbFl5c65xaqQnm
         JwGIjb7t/ECz9RsBlS1tmhsTtWX8bkU4zH+RNzBSwZ1Y0tTpTxlReTO8eAyzdXR+wGs/
         NITb46RvdN0VdqR1REomeG3hzsJAJpN5DQaI7Lr9NuNwR+vfqJvfi2T1ZNC9spUkSmNT
         KVPw==
X-Forwarded-Encrypted: i=1; AJvYcCXof0t++1YR5jpZxqbCEJbM2v5t1htmF700m4SyrGbfbaO9n3KiBULcWDLsL5VUDCwBYzLajko8DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMxy8U+VYMqxXz7fc42wogIFoyOJyay3/J0FNmF2ijI2oI+vq
	845AyYQlpiVny/eIO8OuZsZ5VD1KXx0o23QJuSei3ce08QY7edcyfH9MbYzUMbgrKxg=
X-Gm-Gg: ASbGnctnaa/d9UfnJZL5cYTcJcBnACHln7tEPUVfY8M+5MLaZJJu2pKJQkCn4RASkgJ
	ObwbpK6lLwRH3jKHlQYZ0VQvKrijhSrFPBpaRsmexTrB7Sbg9Ltky4Lrnxv7NQXLgrattFSrjcI
	dQlkW4oG5swgHSVWWIoxHZGi/JhOn5KReFv7ZdgXj8KFzzWCetpJGu2TYGlkSio4vhos8xetF5Q
	heQhKYHzaubS6cgba1Fdi/tpxP6NqhKdf334qm4VZxvNSXaV+3Fgk20phEdfJJtIm0Rup3Mbq5T
	beitD140dSgS1HELJDG017hwLSwNSqx8LdwM+zwsFP07XHR+cXBG7xJyYRbfBwR2rpYREo3IGXv
	fxu8nsYH0G946w/eqAuje3nLciEKTXj9nFXTV/hYucOuuJsUHputinYHkM8EBr+VT/7xjLp2m
X-Google-Smtp-Source: AGHT+IFPtHO+U+hfSDkSoOkmowZhRO7citbEHLMZx0tIaudapfQghvW6tgSpLLBuhT/gfWZEbOcBFA==
X-Received: by 2002:a05:6512:238d:b0:579:ec3a:ada2 with SMTP id 2adb3069b0e04-582d092e4b4mr1134751e87.4.1758801593122;
        Thu, 25 Sep 2025 04:59:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665697esm675382e87.78.2025.09.25.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:59:52 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: fw_devlink: Don't warn in fw_devlink_dev_sync_state()
Date: Thu, 25 Sep 2025 13:59:24 +0200
Message-ID: <20250925115924.188257-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the wider deployment of the ->sync_state() support, for PM domains
for example, we are receiving reports about the messages that are being
logged in fw_devlink_dev_sync_state(). In particular as they are at the
warning level, which doesn't seem correct.

Even if it certainly is useful to know that the ->sync_state() condition
could not be met, there may be nothing wrong with it. For example, a driver
may be built as module and are still waiting to be initialized/probed.

Ideally these messages should be at the debug level, but since the
->sync_state() feature is under an ongoing deployment and the prints
provides valuable information, let's move to the info level for now.

Cc: Saravana Kannan <saravanak@google.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Sebin Francis <sebin.francis@ti.com>
Reported-by: Diederik de Haas <didi.debian@cknow.org>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..97eab79c2f3b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
 		return 0;
 
 	if (fw_devlink_sync_state == FW_DEVLINK_SYNC_STATE_STRICT) {
-		dev_warn(sup, "sync_state() pending due to %s\n",
+		dev_info(sup, "sync_state() pending due to %s\n",
 			 dev_name(link->consumer));
 		return 0;
 	}
@@ -1792,7 +1792,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
 	if (!list_empty(&sup->links.defer_sync))
 		return 0;
 
-	dev_warn(sup, "Timed out. Forcing sync_state()\n");
+	dev_info(sup, "Timed out. Forcing sync_state()\n");
 	sup->state_synced = true;
 	get_device(sup);
 	list_add_tail(&sup->links.defer_sync, data);
-- 
2.43.0


