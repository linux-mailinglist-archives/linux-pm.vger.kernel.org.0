Return-Path: <linux-pm+bounces-6902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C880F8ADF8E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 10:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F682849D4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 08:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18714CDF9;
	Tue, 23 Apr 2024 08:17:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837293F9E8
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860260; cv=none; b=Zpfa4Xa0ZFcAisZ4so6lRqz1rYOi+7SOBUT/Fye+XQB6syL3C/kefUW7HRXtcs9+BmaB5/i1HeR7wDlwP5atrdPiiysMAyoL6waqc7UbWb3ZJnSE7BXMw416a15VCxSNU559JUpM1uV9F/XaBjjoSC2POpkyeH3pXlj1soVdC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860260; c=relaxed/simple;
	bh=4wwNOgiceRwMpLgqMzgC+fHN1YogUEuRd/gFugGnOC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpzHjjNdZKNaaN2Bd+CM05jrNM9oWa94bx/u7H6DHJV8OB2vtHs/EFnPhNvclejobpbK4VZkgsEg/iqbMv0olAHRdwgO+vzfE2UrBWanbooVOnRmhBv2eruXrA10dkoSZgh7GH1qSElNIeTcRV5KNOENG2MnAU+wKmRBbkIGmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ab48c1156dso909611a91.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 01:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860257; x=1714465057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kb9FXgEDAB68H75aCsXFWYpeBHJc/ttXTv+quz+QRrI=;
        b=qdC0kINvyV5Olqv/5K9w+HdT2rIRr60tGngdikQtSvrtuNICNAvZTYnH9Cp8t7cF11
         D+fxPrWnh2LtJjaV+i25A+PHyGl3nuRYg4OtYQZseE0ojWFdurXrKcW7LSWQSGr6isCc
         OkfIQa/GW9Q8dFwX0pnpqpW4voJq1L0xkrScVeBQVBuFikdzWH/srZDfan2baQsSj9o+
         VaHGPe/lZJqUHUoGaramzjN2EnWDtFz14pdKaMMnZy7GAZngX7yfc0yIH8DV9dVbkTJs
         ZHW2wOd3bhnr8HJfme/ZswSJZdcYaNj6v6OFl7lhNCN/JnVL9KKwYQSeS+RxqSjHK5QU
         j6tQ==
X-Gm-Message-State: AOJu0YzUPVn5/ECTQOA5KB331fjQd4OmvU1CqbNuqkgVxWmmf6ImRLBS
	+JWwePTEg20B4XC31xYRDWfJm9xxh8FrFT1N/JG10ulgGu1K3PKRAzfXZQ==
X-Google-Smtp-Source: AGHT+IHuA1A1ueOeKXMbLXjrAPGawnQytPIX+UADs75T+/GttA1ZE/v6DxGQ6M/4/5wS3oiMOAvdZg==
X-Received: by 2002:a17:902:8498:b0:1dd:da28:e5ca with SMTP id c24-20020a170902849800b001ddda28e5camr14010425plo.0.1713860256603;
        Tue, 23 Apr 2024 01:17:36 -0700 (PDT)
Received: from tgsp-ThinkPad-X280.. ([111.48.58.12])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d30100b001e451abffebsm9414989plc.86.2024.04.23.01.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:17:36 -0700 (PDT)
From: xiongxin <xiongxin@kylinos.cn>
To: rafael@kernel.org,
	mario.limonciello@amd.com
Cc: linux-pm@vger.kernel.org,
	xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH] PM: sleep: Optimize the pm_debug_messages_should_print() function
Date: Tue, 23 Apr 2024 16:17:23 +0800
Message-Id: <20240423081723.412237-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422093619.118278-1-xiongxin@kylinos.cn>
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg
messages at suspend/resume"), pm_debug_messages_should_print() is
implemented to determine the output of pm_pr_dbg(), using
pm_suspend_target_state to identify the suspend process. However, this
limits the output range of pm_pr_dbg().

In the suspend process, pm_pr_dbg() is called before setting
pm_suspend_target_state. As a result, this part of the log cannot be
output.

pm_pr_dbg() also outputs debug logs for hibernate, but
pm_suspend_target_state is not set, resulting in hibernate debug logs
can only be output through dynamic debug, which is very inconvenient.

Currently, remove pm_suspend_target_state from
pm_debug_messages_should_print() to ensure that sleep and hibernate main
logic can output debug normally.

Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume").
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
---
v2:
	* Resolve the compilation error and re-submit with the fix
	  patch.
v1:
	* Revert the commit cdb8c100d8a4 ("include/linux/suspend.h: Only
	  show pm_pr_dbg messages at suspend/resume").
---

diff --git a/kernel/power/main.c b/kernel/power/main.c
index a9e0693aaf69..24693599c0bc 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -613,7 +613,7 @@ bool pm_debug_messages_on __read_mostly;
 
 bool pm_debug_messages_should_print(void)
 {
-	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
+	return pm_debug_messages_on;
 }
 EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
 
-- 
2.34.1


