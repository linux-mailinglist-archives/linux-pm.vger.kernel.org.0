Return-Path: <linux-pm+bounces-24840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5726CA7C7D6
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 08:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52A1189AEF8
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 06:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9EA1C3F30;
	Sat,  5 Apr 2025 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWfoeCHn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139314F125;
	Sat,  5 Apr 2025 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743833992; cv=none; b=a/YsvEX2nQo3dpkAcCnThxwD+IN9Iw7gsYb0MO4XR+MoYJWll6diHu3hd2lxopAh5TQPZNjyJrkR51vrgFm/yaY7sW0iCWuGqCBqHtkvYj2CK/sDdoHaoazykS2B2hjba3xjDKAbnivZyYErN2DlUqcH2mDniBWuc5U8sokW+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743833992; c=relaxed/simple;
	bh=kOe2Z+PD8qy5TNtkdQdGx6znyJnRdjYOSo+/Z9ZAFW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A4MvjzwY9jHJOvhp3wMgO3DvKe7VEAGEoAVmjSUL4MS9SwGskhJHmhzAgXHkbdAX/0rDNiTn6UT9PP4MQyY2XhlTWPYYP3n/uJUcVcHhH0hSwsE4TqBGwUy25NsorzkpKaHQFGzQtstW/31fy3QrTgZvX/aYfX5PH8zHwCtKzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWfoeCHn; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-736ee709c11so2366471b3a.1;
        Fri, 04 Apr 2025 23:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743833990; x=1744438790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvlWzim6YndqWu3ZQu0rSQefXK13/0JaECZ5f7JnfO4=;
        b=kWfoeCHnTCtbEepUjc7oLnW9UMSs468lKBnrcc9/UHgHGtJHjHh56SWkaIYWNyrqGL
         pYM8BU0BCLGpRkX5wZ23JrBfRRtyJjOpjGCuGm+V8XNfZwTsF0oWFZgJQ1B1P8BNRG7e
         JwDVHWZm5+c1xI9T0GRRuGycLioOYTyWeA39CsZzIjixanwSMQlEL0+WxUQPs6qRjdR8
         5pBMnETpNxOH8XjgbfpZdZF94JZUrpowvFXDEjouJLkChWeZq6K6boK/8HwkwdGEQ4en
         Bp7O/pHUbjSXRp1xK4Ju8Qf9jCJn8DQx3sdP7AbOTqtgiM+HrmZlSSKhJfF/X0/Md0j8
         fhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743833990; x=1744438790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvlWzim6YndqWu3ZQu0rSQefXK13/0JaECZ5f7JnfO4=;
        b=a+1WvWQY+KsfJH5I2TI7h221Y6mG9SG7i9FIUrIDOzScAmcJk57fk2F4HHE1lzanSp
         fMlkEfENk08XZVg3ZFRbOGe1j422IElVKadsv1rC84dMI03CFQCqmUPIK3AgzRSkJS+v
         olmrErqSc0E2Xy1TEWuttWMMPzURK9PhV30E4HvQODO3JK8PZFVJWxLSHa8ERJomhP+t
         q16xChabNI6qRAf5oHDEFNGcTWkPcTuq/61eJUhNKYBG2p+x56kL9N7s5ICWLKGnlsHW
         bQxb8DOnN70ihiKBb3A5RzJn2jUBU0NbZmcn+Qlo4C9YDgm7b0bvel8Og8qBkSUJKcTa
         iCyg==
X-Forwarded-Encrypted: i=1; AJvYcCUw/xBjUKhFYTsDUFb8lfM9vzHsoSvVD9+xjuR0sZWjAPALCmUgk2FXCeYf+cAzC+HcUeSz3CodL3g=@vger.kernel.org, AJvYcCVk4RuuqRi0xW3G+WR6k9xoEAf0B+PhnwMdCJLy8IJqDbU0uqZGbjVyn8mNPdavheUUt+e2Gl5D5sG7wXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQ/9WyjvRin/UG7PQn4NOvysCG34VNKP+bQhaUrcRFmCeSugc
	cEUrhxRZWhkGCw3mUW1cieKrnZJnb3eRyY0JqLHYMGK0Yr1cX5WofurtvkX1906eww==
X-Gm-Gg: ASbGncvLS5wH/S3/jN4NDSkLJk1Zq30/4xe/PJHM4zyPNmvhuBXKeBtfHF8kDLmP9PC
	cFSeNDxF2cUMeJ2wU09quKrnYr3ed/Hcoqy9l1YCLgdc9rhE5tMuNN9+eo7xe+KtyB2iC3mlCZu
	K3iw7qzUsS/1PUaIpVvqiVmZGjAKRB2+KO9KF8MYvOWQRTCxK/YcHvDDDzdgpeSVI/BpNX2WL1g
	DgjVXjhyyYFYz31biUROzmH6rJ9WYa/9rbflWI5Uj7Sw6vVsnpBYEhhjFxwc3Bcx5roS4pOgTna
	W96rAfAvGyyuy8+rvWO7ZfDxW13IWSD2cAVnQ9U6O/qxRuU4MCZSBNzu8WEY76nX7h57sGJk3mp
	3empl
X-Google-Smtp-Source: AGHT+IFAtgmoL2nMv36spwTBvOI1Zop6q8ft1LpTEtdlGsfFq6JVDVDdNNkOWYXi+baTWF6/wwaPdQ==
X-Received: by 2002:a05:6a21:900f:b0:1f5:75a9:526c with SMTP id adf61e73a8af0-20107efef3emr7651006637.13.1743833990025;
        Fri, 04 Apr 2025 23:19:50 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41a65asm3830209a12.69.2025.04.04.23.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 23:19:49 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: sven@svenpeter.dev,
	j@jannau.net,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: alyssa@rosenzweig.io,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] cpufreq: apple-soc: Fix null-ptr-deref in apple_soc_cpufreq_get_rate()
Date: Sat,  5 Apr 2025 14:19:27 +0800
Message-Id: <20250405061927.75485-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
in the policy->cpus mask. apple_soc_cpufreq_get_rate() does not check
for this case, which results in a NULL pointer dereference.

Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 4994c86feb57..9156becfa367 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -134,11 +134,17 @@ static const struct of_device_id apple_soc_cpufreq_of_match[] __maybe_unused = {
 
 static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct apple_cpu_priv *priv = policy->driver_data;
+	struct cpufreq_policy *policy;
+	struct apple_cpu_priv *priv;
 	struct cpufreq_frequency_table *p;
 	unsigned int pstate;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy)
+		return 0;
+
+	priv = policy->driver_data;
+
 	if (priv->info->cur_pstate_mask) {
 		u32 reg = readl_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
 
-- 
2.34.1


