Return-Path: <linux-pm+bounces-5912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E131289853D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 12:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E2D289957
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818C07FBB6;
	Thu,  4 Apr 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtP9R+E8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CF8F7D
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227330; cv=none; b=VzTHZu+PChWwm8XaRRMHfttz88cld2E0+tDE6YawvzbX9j/29Nri2ASEm6/pBv0HhQLLKjt88a0o00+opLTy7wi9jyHSjWy/p+/Gj3h5PI1LBbLfmjLDQToONLjUq5Fts0yG4BV/pIhMmidlhhxFlQXdXnGNIH/YdIoArrWcgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227330; c=relaxed/simple;
	bh=F+ImSYJLyugWmmAj9uepc0So3V1g9t4KB1p1y7LgtK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I0wpbDlyeNgL4OlU+qJ/l/fYEkDKqEjh2ryI3YkhMxnz8VuyeFtFXkaC9WdJnOZg3EeY0sHqZ1/ye0xdFE0MVpCiOXg8zv14Dnwo0srw6+2asYuAwpWVj+MOWdINUWUcrdnqU50NRQHkEDIA5r+D4ILSFhz1nDdRTXvPkpZ+RWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QtP9R+E8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516cdb21b34so613899e87.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712227327; x=1712832127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pMlr4ISB96FS0s1ezgMhw1dQVyqmmEV48Kuj+0pAf/8=;
        b=QtP9R+E8ezCozggvQyDR1mJke6OsMUOyu6vQ3E298gdKVrcvIvxiRKNeucmiQSp7Aq
         6poRsIp7xyyBboZfHbVNQn+hG17nGhoYHs5ZUhgJKO7YUtl/kIXV2i8aw1NdnzEVvShC
         1ZwYZHzPVVAXLsI7Q4DM+/d/LW9yoBYu4AeFjVfR4qKEeWUmQA4fqOwojPXSSo93CAw5
         GYA8SPRTnkRWuC2c14Nt6UrML/4JmLcwS6LV/HVMd0VDZgfnIODGLQBbH1SmsIdTztl3
         ylMx2/oAOgJ6FSR6FpEeUuMSbHwEdcyiijJqYWPqPJSutR6MQknbQbMSwFn6RXTLicyV
         N49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712227327; x=1712832127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMlr4ISB96FS0s1ezgMhw1dQVyqmmEV48Kuj+0pAf/8=;
        b=MJuDqstyXI18kltRe4fzP8vk/KVREyO5inIpUpfIUX27RhSrEiD0MW9aJ9S+u16532
         cagCMbC6tFHNrQ6pf+oW/QYZHViuGFJuUbw1nfgaark7nv1i74jQOvRTSKyew+RL4gQl
         zLcB8FNoDc6dNhiWJf6iYQ6ZJ8XVQNm+Swkg6fPz+mdipKyFtgUC5papMVUfmtUmf6Ay
         18pE4OPA3NQBoE+/VTGwDHG3AwOi+mIaLZUhtSwLlUrJoxP2mAukwKD9dpePQcfv9Qtn
         oBYwxw+Ytrd3YyzabYgXgmi7WTyCQbJq+L4YupTbYi+Lm67XCa6VpwoB+KVvnt1zwFQe
         4EPA==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZYGxaPJk1qVKp8RUrYBIGxB3apiOa4QHENd21XxpIB/PY5zOcXN9OxVnb1+X3BF1V8y1qhEYlExD1bU2/o5wuk7UXUWXrcI=
X-Gm-Message-State: AOJu0Yy5104C9hRBbu/Yc5koFSphwVPDek+nz0++EvW78g3bwWCHvFCy
	TsoQX3JQj4SeyqNZ8xX3T4/pj3ftooeDcytCElvkDCqHP3uiXczwIC3anSGzEueV6Ux0/stNq3Y
	s
X-Google-Smtp-Source: AGHT+IHHTnr5FGWLUjbBYPIWS8xHHJjMEZgZYgVBrSYPzGMWLUeJY4muZvKJ4gA3iycESCyrF4JSFA==
X-Received: by 2002:a05:6512:282:b0:513:dda5:a379 with SMTP id j2-20020a056512028200b00513dda5a379mr1513517lfp.57.1712227326729;
        Thu, 04 Apr 2024 03:42:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:fdfa:a65d:5f57:ba15])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c1c8600b00416244a53b8sm2309923wms.4.2024.04.04.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:42:06 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	dietmar.eggemann@arm.com
Cc: rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com,
	xuewen.yan94@gmail.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] PM:EM: fix wrong utilization estimation in em_cpu_energy()
Date: Thu,  4 Apr 2024 12:42:00 +0200
Message-Id: <20240404104200.1672208-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove division")
has added back map_util_perf() in em_cpu_energy() computation which has
been removed with the rework of scheduler/cpufreq interface.
This is wrong because sugov_effective_cpu_perf() already takes care of
mapping the utilization to a performance level.

Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove division")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 770755df852f..70cd7258cd29 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -245,7 +245,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * max utilization to the allowed CPU capacity before calculating
 	 * effective performance.
 	 */
-	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
 
 	/*
-- 
2.34.1


