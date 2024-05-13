Return-Path: <linux-pm+bounces-7784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C658C47C1
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA3EB21517
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B157078283;
	Mon, 13 May 2024 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIMQqOx6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF278285
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629284; cv=none; b=KhX+XymL55H/sz6ygo9+zEhxvQBrdVZcVN0NFdNKGkvfUy9hYc9FW1icI5eMhw5dZqZvgMP4/FfBpHLDPUa4AGFscizRy4rm05xfAd7P4Bb68LXMT8qmy0NuMX23ODhFuzuQ8524soPOS3l6QRoawpwvut3kWC5co3mq7jkxLWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629284; c=relaxed/simple;
	bh=fXjEdLkpxmgd9H3LuOLN//E8Ubumtd8WRhsErwMqZ+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LOQkl4jEmqqPVnhHoOiYJmTEspqMjNbor42IEbxgiNCgLnIllRSmNE1saxxq3jwi8xnOmoUAKKkTWc0MvWvSM5F6BnGwmHB+Dd9aDZHJQ4AZqTZpVJVa5tg7tikDC06hYGZybapisJXXmH/9Uv2vkOj6zsjfpwqISBuBTf0UmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIMQqOx6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62027fcf9b1so40848497b3.0
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629282; x=1716234082; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTZA72f1RvWz4KddpDChM5+RpJeSqBzkT0eAkx9PQZ0=;
        b=RIMQqOx6DzG4RuWP9q63IW9B16PcYBVJA5gB8qv7YITPZ6yrHzFG9i62yWImobm2Dn
         UN5GHREt8wC/cBrJ+fjPDHlwDYgVegwJOsQ71KL45i8ZVKw8x6s33+RrsKkD/t97KzSH
         PvGjchMtx7dTJuog4BZpCjwNWW2n/pxBXpDDhqIORKKpJ1KuqeC26ApR1POAAB6RrZjF
         t9OeNtqgaCTzi48oga8WcjEe6aS71jANaFhCcan+yGGzLuymH1LGb5JGjf9gvprJ/lb4
         ABUeE/PBJ+9aKFl3M1FF7Q5x7e1IlLDyIPleX9VMIRgua1YumFVbAkPUlxhnmkjEtI2/
         b6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629282; x=1716234082;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTZA72f1RvWz4KddpDChM5+RpJeSqBzkT0eAkx9PQZ0=;
        b=f8o25JuIJBMGujaSv9e003wjRjHejgL4QBo+LH0loiOznYevRpCefltgZPCKqkaTbf
         2JPaMqPuTDUECp5VEJf0bhw+atQGywMbOhWFbuywEwTTIbYEgw5v5x4sXpLUZh1pm4nC
         zInZEVGK/8QZNkcdmeiN2SjMYvuUeKLEI6oUJcAAl/e5u7tY81gpX6DwyE7v5yduchVB
         4MGJqVtb7RbMjOAICJxisWupVuBwLldkxV0mFtas0Wstt2mvVoh2/En4nMGis99FZTpS
         oUBF6YHx33hJuy+KREcJdUGP+RAQY4i8IND7DOKLul3ou5+Xet+MRkHgRRLs7k/GG52U
         KSFw==
X-Gm-Message-State: AOJu0YwIW8hH3AZ6TobtSSV7IfQje4wATsNMWSVGh/UP16dPOBb4zqmD
	h3MAmLxcRq0Fsgyr2yEFr3of17jkVfnVdOPwGyWizVRLDsAg+aWDA6OjJg==
X-Google-Smtp-Source: AGHT+IFZRcdXasM0idNFYufjxocpP5OonwLIxj9mPTGoAWQscJRGaQyFU48ZJ9rNBX30s/io1Xwf5w==
X-Received: by 2002:a81:6255:0:b0:61b:e61e:8988 with SMTP id 00721157ae682-6209943c8a2mr103709127b3.18.1715629281361;
        Mon, 13 May 2024 12:41:21 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:21 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 15/15] tools/power turbostat: version 2024.05.10
Date: Mon, 13 May 2024 15:40:51 -0400
Message-Id: <dedcf3a8e704acc60804c62838acfcc36f507527.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
References: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

New since 2024.04.08:

Len Brown (6):
      tools/power turbostat: Add "snapshot:" Makefile target
      tools/power turbostat: Harden probe_intel_uncore_frequency()
      tools/power turbostat: Remember global max_die_id
      tools/power turbostat: Survive sparse die_id
      tools/power turbostat: Add columns for clustered uncore frequency
      tools/power turbostat: version 2024.05.10

Patryk Wlazlyn (7):
      tools/power turbostat: Replace _Static_assert with BUILD_BUG_ON
      tools/power turbostat: Enable non-privileged users to read sysfs counters
      tools/power turbostat: Avoid possible memory corruption due to sparse topology IDs
      tools/power turbostat: Read Core-cstates via perf
      tools/power turbostat: Read Package-cstates via perf
      tools/power turbostat: Fix order of strings in pkg_cstate_limit_strings
      tools/power turbostat: Ignore pkg_cstate_limit when it is not available

Zhang Rui (2):
      tools/power turbostat: Enhance ARL/LNL support
      tools/power turbostat: Add ARL-H support

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b3a5a373ba02..3756e65c2cb5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8008,7 +8008,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2024.04.08 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2024.05.10 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
-- 
2.40.1


