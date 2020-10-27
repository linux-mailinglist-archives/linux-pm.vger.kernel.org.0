Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA029A57A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 08:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507590AbgJ0HZd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 03:25:33 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:40263 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731322AbgJ0HZc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 03:25:32 -0400
Received: by mail-qk1-f201.google.com with SMTP id j20so231575qkl.7
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 00:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AKI7ibcZP5xCZTEhfHJrDlNXuB2qzdKBd1dimS2sjDc=;
        b=Se83opTpzVXGBV1/XFoSfX3J6oK3vbbaUAiYYyoJnhe8l2KURQMhH9fBzzWC9eNeZF
         DywTuUBobQ9zfecLdMsyKsNN1T80DsTr11y8trZdIpKbLYl8kya9qFbjXT7/6nAfWLR7
         PDvi4jIl7TnjwCsVBdH4qXeWki1vFHaRjxCZjYNcGbXM9HmVpPYFSD7wJXzDegAKfAZj
         VHtge5FQ8lM3mTOrVh/M8hcrjuQQePgiL4EyzBNP9k+ICXS3OcAs3oNuAshNdsNY6t7j
         gwfaM2kCg00RwCuamwQBim6blf1SOR++shPZfm1jKat8xw/C8F9KLPotBMwLGxOheyG5
         sn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AKI7ibcZP5xCZTEhfHJrDlNXuB2qzdKBd1dimS2sjDc=;
        b=Jz8zprjnxG9nec8R/Gqd05yKRz0ZJx07yO+KU0MEf/NlB8vYtaxju0M4Ssqm0U48Po
         2hPkge5I6Yj9w1McePRg5MSbLRtkQ4+NmCnZmQpUQQMKLI5JkhQVZ3E3Mo/WEcrM01I4
         GNxeqs9WPmgWEI8wpLWgYzlzDxPYAxfcA+Zcuer/vQY5K0g+5Zg38lFa7D6v/Ihixq6t
         LFh80h9dxkbwLGkcCTzokFfCYXa+he6sSwpC2Ls/H63HyAPJr5hXXVIRQwEW3Gn2Sx4B
         qcHyu8TKd8pLSorcVrK4VKU/aTWUqrd7rqEogRdkneZV7fIjQ8jVhjWyvmUcS2nPZWwI
         c9Xg==
X-Gm-Message-State: AOAM533zv9tT5jQcjLNZuT8M4aH1Ln2TF640KGDYzSYIpU+s2JkinAkH
        IyUGUYS7WrWZtWauo0Q2Kb8yfCAP9DroRCdj
X-Google-Smtp-Source: ABdhPJzDwaMIiidKcK1V16PaYpOyNvVYjrZcx2mW5jTbbX6vYZWVOh15zaI+yzsWyAAEYv7s88HlBGioASjogGyg
Sender: "victording via sendgmr" <victording@victording.syd.corp.google.com>
X-Received: from victording.syd.corp.google.com ([2401:fa00:9:14:f693:9fff:fef4:fa73])
 (user=victording job=sendgmr) by 2002:a05:6214:b84:: with SMTP id
 fe4mr1092778qvb.3.1603783531949; Tue, 27 Oct 2020 00:25:31 -0700 (PDT)
Date:   Tue, 27 Oct 2020 07:23:57 +0000
In-Reply-To: <20201027072358.13725-1-victording@google.com>
Message-Id: <20201027072358.13725-5-victording@google.com>
Mime-Version: 1.0
References: <20201027072358.13725-1-victording@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v3 4/4] powercap: Add AMD Fam19h RAPL support
From:   Victor Ding <victording@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Victor Ding <victording@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

AMD Family 19h's RAPL MSRs are identical to Family 17h's.  Extend
Family 17h's support to Family 19h.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Victor Ding <victording@google.com>


---

Changes in v3:
By Victor Ding <victording@google.com>
 - Rebased to the latest code.
 - Created a new rapl_defaults for AMD CPUs.
 - Removed redundant setting to zeros.
 - Stopped using the fake power limit domain 1.
By Victor Ding <victording@google.com>
 - Changed it to use rapl_defaults_amd.

Changes in v2:
By Kim Phillips <kim.phillips@amd.com>
- Added the Fam19h patch to the end of the series
- Added my Acked-by
- Added Daniel Lezcano to Cc
- (linux-pm was already on Cc)
- (No code changes)
By Kim Phillips <kim.phillips@amd.com>:
 - Added Daniel Lezcano to Cc.
 - (No code changes).

 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index bedd780bed12..264872f7f46d 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1067,6 +1067,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-- 
2.29.0.rc2.309.g374f81d7ae-goog

