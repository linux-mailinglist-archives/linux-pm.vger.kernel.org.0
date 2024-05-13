Return-Path: <linux-pm+bounces-7772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B68C47B5
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CB3B20976
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E760E762EB;
	Mon, 13 May 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpJd85iu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30C762E8
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629272; cv=none; b=OqyZRXUu4CVndh5NwyjIHhmVPyTecnpnBsR9oWJpH2y/XbpyEDTzyt09E5R7iIhG1DIL+XbGr8tFCcz31BidRtKGB2A2rTxc5wKgCH1lnZrJ6MgLAKqpNwIiVa/gPsTC8u306/0hBtpfdlouEqMwrkGktrj9zcttkeJU+NUDzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629272; c=relaxed/simple;
	bh=RzJJ72Z73c5II9yIoQkVW24R3WJdlCALTX2QGxDrmps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CbG8GXBJvHt+65ru/9+hREAcd2DzWqTl3SiOVwMJxNXPfedOuj/mvaB93gk/f9B3kQusqhIBX987bXaG7Td/i9VSf6ZyUYb7uSXYf2nuHcXaoL5/reCaAEe9Wl0ET+QhuVByZysS1mRamHCE5h/VsFCbwUaNCzuAOjsL8znMpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpJd85iu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62027fcf9b1so40846947b3.0
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629270; x=1716234070; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=td0RMe9yykO+QfKHMbzp1OoNGlUOyox6ZhQjKH/vD+Q=;
        b=XpJd85iuc+Uhu4FTKgxsM+Xuc0NIOj4iFhMCNin7RVh82ozxWBuw6lrvLIJcruUY1L
         PShkvOlTpKmj30T+1calfq1lXhUtRJIc4gMdX1r4POKZZsRvkuMFsSsLfWw4fJ40urQJ
         pSqQEJc4Uk8ixRoY87l22iiTgvdU88R+FzgkAHk6U7OM3uIrO6O/swtnU1ILdA6sh4Wq
         UvxEEKK3FRK8xLZUdR39oG8hDYb4g7E2X7dM/EQrs/ce1hIiCwN5daWyTljySvcBsvgm
         VHOIMWpQqhVUOgPg42hs3+Knh14HE0WDflFRDPCoICuaIc7OM+HiP97gb6wMvATb1JJk
         vNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629270; x=1716234070;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=td0RMe9yykO+QfKHMbzp1OoNGlUOyox6ZhQjKH/vD+Q=;
        b=OcBsZAbY0zeTQjPtag21BY3ZOAU8hkBcsGMN+pQo0dyoIms91vM2C5jthzMoylKRtY
         N7KIaYqoDClZBocZGI12Ubw8OX4t/N8kiNvIhQ0IPykxFXhYM6EFo3WYWw8R/gJhgDvn
         FBsn99AhQPswYr5g/4fyoiNcsSjNyIXKTZwF0kFWsNdTdPaM77lJcHdiHU5ENVvT4EEn
         WZfZdcPzeo1HHT5MwUbUKW8SoPNHJDrDDg7IdbyxwyT1HUYdA6d02Dlu5wWEg6MzAQH0
         c90G47AyvkkoJmtIncZTKGaZCXDjIhVd5EuNms3tCvRIqXj1eXxslDQisClzW7jKPbkF
         aUgw==
X-Gm-Message-State: AOJu0Yxy4+f+Th/pwhxsuslhckldq23ylqh1kWg9Nm7FSlo6bLBbDt5k
	PtDOQMeqTFfG/fcFCEQeVx+7iMSsmBAQB6H2t0GLeO4Jl47QKY/26Cbfqw==
X-Google-Smtp-Source: AGHT+IEICDoS868+S8o7t3X6D0lQgZi4hff9UhQ0YQM1OfGI/7x3Xj27fgRtK96wJM0JxHNu+oSA5A==
X-Received: by 2002:a0d:df4a:0:b0:61b:e506:b0f with SMTP id 00721157ae682-6209932921bmr103317107b3.4.1715629270317;
        Mon, 13 May 2024 12:41:10 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:09 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 03/15] tools/power turbostat: Remember global max_die_id
Date: Mon, 13 May 2024 15:40:39 -0400
Message-Id: <cda203388687aa075db6f8996c3c4549fa518ea8.1715628187.git.len.brown@intel.com>
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

This is necessary to gracefully handle sparse die_id's.

no functional change

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ca33fb057d1f..e6d643a58cd8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1415,6 +1415,7 @@ struct topo_params {
 	int allowed_cpus;
 	int allowed_cores;
 	int max_cpu_num;
+	int max_die_id;
 	int max_node_num;
 	int nodes_per_pkg;
 	int cores_per_node;
@@ -6980,7 +6981,6 @@ void topology_probe(bool startup)
 	int i;
 	int max_core_id = 0;
 	int max_package_id = 0;
-	int max_die_id = 0;
 	int max_siblings = 0;
 
 	/* Initialize num_cpus, max_cpu_num */
@@ -7097,8 +7097,8 @@ void topology_probe(bool startup)
 
 		/* get die information */
 		cpus[i].die_id = get_die_id(i);
-		if (cpus[i].die_id > max_die_id)
-			max_die_id = cpus[i].die_id;
+		if (cpus[i].die_id > topo.max_die_id)
+			topo.max_die_id = cpus[i].die_id;
 
 		/* get numa node information */
 		cpus[i].physical_node_id = get_physical_node_id(&cpus[i]);
@@ -7124,9 +7124,9 @@ void topology_probe(bool startup)
 	if (!summary_only && topo.cores_per_node > 1)
 		BIC_PRESENT(BIC_Core);
 
-	topo.num_die = max_die_id + 1;
+	topo.num_die = topo.max_die_id + 1;
 	if (debug > 1)
-		fprintf(outf, "max_die_id %d, sizing for %d die\n", max_die_id, topo.num_die);
+		fprintf(outf, "max_die_id %d, sizing for %d die\n", topo.max_die_id, topo.num_die);
 	if (!summary_only && topo.num_die > 1)
 		BIC_PRESENT(BIC_Die);
 
-- 
2.40.1


