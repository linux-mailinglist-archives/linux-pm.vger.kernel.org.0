Return-Path: <linux-pm+bounces-11233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2304935257
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB6228253D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 20:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18580145B0B;
	Thu, 18 Jul 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuvgCAy0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398BF1448C9
	for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721333323; cv=none; b=nDf3X4N5h6gSoVhj3Pc7vGZmH03sEYPozlikvGWQxGJJ2/SmUCr5bwmmAR7t0xi+6ar4CW65TQkxXUxyms5ocSOIICeYHXfHnJsLwGDtsEEF7IsTKWI2nXdqYCaWPOspTnFPZG0Q3rUuKktX0NVqDWSrssaWlNZLXBj+X3/rFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721333323; c=relaxed/simple;
	bh=roVaJVLQ8Of78HQnsJm4kUqib5zBKHi0p3Ier02zSy8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mrLu6AUGn7oj1OFrw1o/gpyGzoILnIKy6lBWUZWidITM6ZXZKMxQrRBIuShX/L1cOupH7RvyJ8RMdBZ8jrgFXcGc1R7i/8caHF47raehi2Ouhq9Z2wCtjz6hIwlWSTwZw08OsseyhbiYiFHI+unE1F47eilKK4UGQkatK/bkVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uuvgCAy0; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-708e75d8d7cso724346a34.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721333319; x=1721938119; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jp0oyTo7suZ1p/VJFPY2j+EgXru6EPJQFDcV3HqH2M4=;
        b=uuvgCAy0AtttPne0AEemcnbMuyuiKdn2xkn1jq86RhmgI+TXK+ao1WaOPMVkfWK/2M
         tmcwlJxFbE6gY0cLbbYSDb+rlPnqtHm23KBpPtudQKSzs+s9jFIICsGrl4ZEmccPuyuq
         M5dGRYqf19WtjR3jyrXtwXeJFplY1k2Zk8nN2G+yUXyMgbhUg1MkFNu0ZLdr6dzuAbXn
         tC+KOKmFP0PC+ASkvWY0ha4ai2wW7fSp+DdmxILpBUxuuhMt1G71TdiHYKbq2J1jJTaX
         cZ5VvRyJjDJIvFtCXXMhmIdoVRZrbBsiMePgzU55LrfABZdonzao/CB0nqiqLw2zm5s8
         G9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721333319; x=1721938119;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp0oyTo7suZ1p/VJFPY2j+EgXru6EPJQFDcV3HqH2M4=;
        b=ST5qfZofLOCegRqCBsiStWraCXBtvOoQFoCxdZaoYOl1tipPIZyxkkcqSLH+Rhhdb4
         SXXHhgXSAKWM8MckLfLvdxMR3y/rzpdDNnABRrXx4lpNJQSuSq8elQk+0mznTriZc8Zv
         ZuQ66ZiI6ncxgm/lVH5NwQM8ylL8xOfe1Y30vCRSRo876AEAfe81R+cxUzQ1WidhQy4S
         vvV9uaV3uIv2CMb6tBuooIxRAGCIVTycxHgpy2DOpOGG6TC4zAyiGl/hV5/8OqE2bZtd
         ZRg89sQgROluZO9crCXpfB1SN79k+6gmZ6s7bc94NT/WRkgMuaBsRg4E257l7SfOSeIw
         LHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4Am42e6mMgFnvnXI31flUVMVJSKVbNcsqFzhq7Yf9cuU+lEUh/6+bsQlhstg2aOlray1SDNG/x3SR36ewbSUN94+cj+wk4Mg=
X-Gm-Message-State: AOJu0Yxri1JscYEcurqkdKeUpC/yXF55hepfF/ZXYyQa275HWLvb7Owg
	JYLkUxi0q7GJF6Lb1hpLq+42DZTo12Y7xJnuDbZCqe2jYJkomhfTTdnxJ9e8GCk=
X-Google-Smtp-Source: AGHT+IFQkhBljK1MS0GoVn+FbZK4gkfbyBP+j6byThpGUBkHb6s72SWk871XFe5thqyDhAAjoaa/CQ==
X-Received: by 2002:a05:6830:369a:b0:703:6d27:63e0 with SMTP id 46e09a7af769-708e37f0e3amr8445206a34.26.1721333319343;
        Thu, 18 Jul 2024 13:08:39 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8d5a:14eb:55d7:f0ba])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f6174ee5sm2621a34.55.2024.07.18.13.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:08:38 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:08:36 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Perry Yuan <Perry.Yuan@amd.com>
Cc: Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cpufreq: amd-pstate: Fix uninitialized variable in
 amd_pstate_cpu_boost_update()
Message-ID: <7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that "ret" could be uninitialized:

  drivers/cpufreq/amd-pstate.c:734 amd_pstate_cpu_boost_update()
  error: uninitialized symbol 'ret'.

This seems like it probably is a real issue.  Initialize "ret" to zero to
be safe.

Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 68c616b572f2..358bd88cd0c5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -692,7 +692,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
 	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
-	int ret;
+	int ret = 0;
 
 	highest_perf = READ_ONCE(cpudata->highest_perf);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-- 
2.43.0


