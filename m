Return-Path: <linux-pm+bounces-4818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE92E877A8E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 06:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD05281784
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 05:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D57489;
	Mon, 11 Mar 2024 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/RgJSd2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E28BFD
	for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 05:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134732; cv=none; b=d7fecUVHWrgBQTn5axpGYGEWevM+ddaqnIjAoMnS7xAH+WO8ccsjRzRiRI+VGXPoIpqWVU76XqQUkqfmJbFlBqV+J05ODXHgNGGL6c+yLxUzIVccURDNVSCtJLKnl9wwE2ROQfYGX97KlSYg//ZRUDFWfChccpQ+eN+oaZd80s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134732; c=relaxed/simple;
	bh=oWvKKB48HSv8bIHM5usdlGltNl8GujtxLiRAYYZmcm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lWhd1mWa4gm6E8Xn7OKSieyLgRfUCcorFMbol2akHipPZCSzXXzWUHTyCyO+dRxbtlb9N7G8h31mfhXgEOj2qcKuaLMpH4yRi6zg6jZpWcRHYvtYDbvX0CCZoh2O8NA8/AZJhHKV0MrbPcBxePnp+5id0oCcbF1gfqoNrldS1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y/RgJSd2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c2313de2ceso1441825b6e.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Mar 2024 22:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710134729; x=1710739529; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNFuT0sJM+B9kbfVNo+KAuAEh9qFiMLegcXGaC2IXP0=;
        b=Y/RgJSd2lUp3ksGWUHpCeiI7+6T7Fktju6e37VfptZTza1Ro/KGPsTK2UYW0LxqiOY
         1yB3XhjLdzgdCJ8IV+6wgBJIAzvKeM16egs1KvZ5GKCnXf1tAXq6nuaZmU85tq+pgBrO
         InT787oWoL9dCr1TZUgHWybLGL77KTfb84GOZ7cjcnysni5H2SXrgNXPngGxWMsb77hw
         PBkCtNc63DVO4+nccvcD8mNcN5Vd1LCmFxbNGMo3c5XcmA5hcYndSxpdSYxxBepdbMZr
         TdnzW4i/k8YGrWGGzndEYGYsTauUWbtIWPdDewqDInjxn2UR9NZQDWY3xW+PkTZoK8C7
         SE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710134729; x=1710739529;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNFuT0sJM+B9kbfVNo+KAuAEh9qFiMLegcXGaC2IXP0=;
        b=Bvm20QVdA6dWsrEKwrYkBo4CuIwPeMoHvCPNFzr0CaZTfg2Lk3AX8YS4kXQRYNNubJ
         bgatfFvSrLnGgMAXODms48GMndZ8SYEWjymClB2Daf5ZsbvhiUNbVs3XeySw5E7uQ+pa
         v6UtLRm82THApP0Ic25il7YPjvsmidxZSItKN+/WmYtAImRqMd9wyjAwbJTmoe8vlNkv
         6m0ujEsteYHNOS1278Wj3DE1QRO9KXxzR8ZvqOrKssECainTSiHNhvXUU4sJJ+VDtz0d
         sZyYKYacrfDtUCg4EyGLDG1CSpTWiNOBcFM27vdgeSTOdKBI1zqtRqrYxJsGo7RZeZeC
         t39w==
X-Gm-Message-State: AOJu0YxMU/XbPYUEt8fa+351831F6YYnQKsJACcY5ztyhUTtY3HgxVao
	Wu0Jtb3kBJ8pjg7Ojt+3BbESXeo4h+VwqFHpeFMO98h5Pe6Fd5Qe1hbr5uu8mgk0Pu0Tp6YRMi+
	1
X-Google-Smtp-Source: AGHT+IFzY+mjW2Vu8N+w5bBfwoxehbHQXSNt8E263/BSPWzrsAb8ob8itlnJZMNspabD0j+Vx+3zsQ==
X-Received: by 2002:a05:6808:209f:b0:3c2:500b:5562 with SMTP id s31-20020a056808209f00b003c2500b5562mr511424oiw.29.1710134729296;
        Sun, 10 Mar 2024 22:25:29 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id gx10-20020a056a001e0a00b006e46047fe04sm3409101pfb.204.2024.03.10.22.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 22:25:28 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:55:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.9
Message-ID: <20240311052525.x232vfpvqlmm6x2e@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.9

for you to fetch changes up to 13c8cf339e1a7a3d3e48fdebbb882b3a5a90f708:

  dt-bindings: opp: drop maxItems from inner items (2024-03-11 10:39:24 +0530)

----------------------------------------------------------------
OPP updates for 6.9

- Fix couple of warnings related to W=1 builds. (Viresh Kumar).
- Move Move dev_pm_opp_{init|free}_cpufreq_table() to pm_opp.h (Viresh Kumar).
- Extend dev_pm_opp_data with turbo support (Sibi Sankar).
- dt-bindings: drop maxItems from inner items (David Heidelberg).

----------------------------------------------------------------
David Heidelberg (1):
      dt-bindings: opp: drop maxItems from inner items

Sibi Sankar (1):
      OPP: Extend dev_pm_opp_data with turbo support

Viresh Kumar (3):
      cpufreq: Move dev_pm_opp_{init|free}_cpufreq_table() to pm_opp.h
      OPP: debugfs: Fix warning with W=1 builds
      OPP: debugfs: Fix warning around icc_get_name()

 Documentation/devicetree/bindings/opp/opp-v2-base.yaml |  2 --
 drivers/opp/core.c                                     |  1 +
 drivers/opp/debugfs.c                                  | 14 ++++++++------
 include/linux/cpufreq.h                                | 20 --------------------
 include/linux/pm_opp.h                                 | 18 ++++++++++++++++++
 5 files changed, 27 insertions(+), 28 deletions(-)


-- 
viresh

