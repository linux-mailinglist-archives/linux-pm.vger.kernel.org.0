Return-Path: <linux-pm+bounces-26129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B892BA9B3B6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBC14A5101
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0D42820AB;
	Thu, 24 Apr 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UF7ArqIY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79165BAF0
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511628; cv=none; b=kORiNgmuLyJgycEBtCpRDkKLmgZTL5n5vI/pU96M7cRlZ6sAD184X0nw1BgII09Xc134fvOUo20KOkyMihsIcAu6pY3hbIQTPjHkPG9i37qlbDRGISqOuI1g3njRJrJkwGChvzj21bhyqli2B9YkKS+YxQhWxHjGR+d+1ZU8CMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511628; c=relaxed/simple;
	bh=3qPXP5abEoIx66HUunPoFY8QVhFVv3wWgnMK2ckSKL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MCq22L4sZhSyfmofF2EYF0pHVVlMLlNLmiKN0i0CosPN2xDJktniZE7IT/CUYSEEXvv8V1/8jTUQh56k1bPzMZGR1WJDmJCcXxRMlpm/Sl0yRdtRWxnWdASJ+cAmsXbKpcPP+ej4QK9BB7o5GNqCY3udTxUGSjVUhMMrH0uYdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UF7ArqIY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2295d78b433so14773395ad.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745511626; x=1746116426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZK3U1zqX+QbRkc5CUf+8j98MPDC5LORQqlarEVgjRww=;
        b=UF7ArqIYVIESzY0DmZDLUgrw+qilHJO3LabR8vFf9ECv1kGGkyC3BHWpPMzRm9HRMt
         9nGqA7ODB3+1u5wNo/hMN6r/aYeSLJ3ckBEHY1Rta4hwghJF1Y3JrYKJsZPVp1c7zhlT
         ryrppQjzzVG6RLxuY1jAznTL4qxZVMajmKRpo8PEjB2F3wyAA5vcGbdwVLqgF4dToAId
         TiijfOlEpMx8D7j6kPjVkHmwaSSLdBOzhHiGVzFf4FgNsaiE6T1G90yb1+Pc3VBX4pxV
         fChc0BIUiSVp47d8SGtuZegmh0DYFyvI1l2sQCGVn9tz8AMZUfWw7DFioH36U9LFgVpQ
         w3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511626; x=1746116426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZK3U1zqX+QbRkc5CUf+8j98MPDC5LORQqlarEVgjRww=;
        b=Cj1mYJH/22u5upy85eDRzXqoGkrEVV1oXJAWGx/vkQ79iBff1tC3BQE2o6DC93GUYp
         h8Kbj0BF6hqHmWM2iB6PuT6vsMzkXSUg6FhM0iFmJn9T1SfFTuKZ9WiLfS+w/8YoLjAb
         jlZ+Vhr3eiSHDhpN+x4o7QHm1X6DjCcccaeazb60zMlP1IgKb3+SVtaeK79NCoQ25JNh
         KRSm8QxsLm1B3tTRV9vtqOtabEvXurxBV27a9YFMDMPz6cNKHEsIL469HDVamMV9SqRO
         CDE49Fr1lGD4V+EorFtkRdHWHzuSFPhYtTZOYPlZUZ5qotcfmpciHj8xQ0Nj74W6aTdp
         dzOw==
X-Gm-Message-State: AOJu0YzST3/TZF6TdltzaroHNlt7MAUSutb0kGH7Zg/wgfV4WYDIeagZ
	vkpS+YmMMwKy8WskEbDETgoPOCIZ1zmro58orzn77sAM0Jzlrbtxda2p1NBe2CQ=
X-Gm-Gg: ASbGnctVB6MAe0OUZerlQc7Z0LaISrEA2cWJGnR2FNSX3Xkme5Oqdik8joJz4oMMoTv
	wTbZ3pmOXyBQzKr+KAw5OzjgFHTH3DY9Fn6Pxp4fxdxLZIec3eS6qxgLTzQiuiKZBeiZFgHbfD5
	F4q7mlZCSGS5A5c0rPv/cEuUqMcj4gKwieCBXxQu2Q4O/MeiRTw5s4JcGUr/rC/mPYy/XJAGxqU
	5HVzn3PbyZQ4CV/yoBo0cBSHdJ91IZEFMSipZFZQ9DOuGuxWSvLRCol+wzoZ/DoWxNQaBS3rWRn
	w2WA4cphWsTv45NcP6p8dynq277kJHBSW2Cts8DfpA==
X-Google-Smtp-Source: AGHT+IEDSR0/PqlNDM2o73GF73qCXfMIvf5kzIhE4JxAny5lKNQoi84TfP+O1loAWvOMlNHIFWnnOQ==
X-Received: by 2002:a17:903:1b0e:b0:21f:45d:21fb with SMTP id d9443c01a7336-22dbd3e86efmr1434585ad.3.1745511626183;
        Thu, 24 Apr 2025 09:20:26 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216770sm15387365ad.218.2025.04.24.09.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:20:25 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 0/5] cpufreq: Boost related cleanups / fixes
Date: Thu, 24 Apr 2025 21:50:13 +0530
Message-Id: <cover.1745511526.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series tries to fix boost related issues found recently.

The first patch fixes the boost related breakage introduced recently. It should
be applied for v6.15-rc4.

The other four patches are general optimizations and fixes for boost handling in
general. These can be applied to -rc or next merge window.

--
Viresh

V1->V2:
- Drop one patch.
- Fix the commit log of 1/5.
- Add Reviewed-by and Tested-by tags.

Viresh Kumar (5):
  cpufreq: acpi: Re-sync CPU boost state on system resume
  cpufreq: Don't unnecessarily call set_boost()
  cpufreq: Introduce policy_set_boost()
  cpufreq: Preserve policy's boost state after resume
  cpufreq: Force sync policy boost with global boost on sysfs update

 drivers/cpufreq/acpi-cpufreq.c | 15 +++++++--
 drivers/cpufreq/cpufreq.c      | 58 ++++++++++++++++++++--------------
 2 files changed, 47 insertions(+), 26 deletions(-)

-- 
2.31.1.272.g89b43f80a514


