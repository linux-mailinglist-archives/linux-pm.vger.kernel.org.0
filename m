Return-Path: <linux-pm+bounces-20916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FC0A1B210
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0041916D706
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DCE219A80;
	Fri, 24 Jan 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiupq5x5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA0218ADD
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709113; cv=none; b=Jn8ksdhVDs626zUXcyj5BgCZkGS3mQdBxN3/oO3+xUEtGfOTisrLu2yHNuBtl/r4tOKs1+EqnMzMq0mf8EcUVZniRiL8f8CfIxRp6Hz6LG+dmyA4iFCJISE+uXV36VyKHungg6xv45j1X+E5aO0LQ/SemoGv9dHo/KsSUF1m/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709113; c=relaxed/simple;
	bh=fNI4UdDtZI4AVcTD8TnjHEnynSXd6Y+lcwnBOlUgb0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MBtUMqtinb+iRCWHVz5lN2e+pwINayv1AmPl6Uu7o7EojAviD3wX4wGwqKX1ybcntb3WyJMgib4lcXnCa3Q0IHdV9rpVBLtx9j3C7zaaye9H9mSulBienzHjclkvubbUC8sSVctchegiLxM6YCadtAdy3Zm1SG8tJtj/tulRBh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qiupq5x5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2164b1f05caso31538475ad.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709110; x=1738313910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4AqRX4jgpQUQupuoQFqpmYTbRVzBhfX6O9GAy7aKKQ=;
        b=qiupq5x5QB9lQevzihRGuBXv0IfAAG2rlaNizZukib61T7eXb9WMGdVg8sHx3prPyF
         pyALGugpO90wpX+VaZdylLtGFOvcgTro9iWGcc0WHV6/lrgkQZW0N2/o1YVYtaudmZxT
         ftm0jDg57UibfG6PZfifqu7fLPSSGy7P83EOarbhJwSpqCEn5DC5qU13poN99eJINn0e
         idbknwz4Dn8uwZ+tuCKNgGPwaiD8hEh8ikaLCFO+kPyaDMxMtgjLsm7vIx0FI/XGXGx1
         CjNeU1oUtS06Rc8zc4t9RYL+Xf9unljTMXzuL8AqMOSU311AbW1urLdye61TVSungj2H
         GTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709110; x=1738313910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4AqRX4jgpQUQupuoQFqpmYTbRVzBhfX6O9GAy7aKKQ=;
        b=ljZGgwQwcaExtIBrGCg0+2iMxKq8RkSHgJjX1MUf9b/hiGYCvfeIkpEyCM0zcKJTzw
         Eq2A7SFMvj4rycQUpEVFiZjD5NaPd2bPx0RmCfdvUOit5pF5bHJkztvBl1ufcqroPeW1
         GXCTyWh8fsi10Ff/xtL0cq7mojIs6Lbrwi4Y/HJX9w306kqdd0HkxlNbynAY4/TYth97
         CGDyIZVZ3Qe5F0mVYOnHTbDNou53Dwc+quKtPvY5kU4biVUaB9rI3p865p5IiSJUIJTi
         qaT1R0LSTMBoyi5h4kfheLCbTjAzt8QC3vdjxBbRH7jU99zKV0xam2AwJ65Pg1iD+4uQ
         YFfg==
X-Gm-Message-State: AOJu0Yy/+l/0OYIPYGXuxXsPP2J4MUhJgF3V1n7v8MsaJjwR/Sdlcnwb
	/xMggO/M0yw4VKaX4Ay54Jy1G8ZNJdXZIQAgeUNOOFWxSGFZpQRqQzriKE8OX5U=
X-Gm-Gg: ASbGncvIwi1oOn92urQmnw+3BElhfX6AFtqWOYNtSEBnzl7NC3ZgXY14PvxH2kr4Hxk
	fvZkqAvACZVkemP1d49poiIw85OVS9I8VlZMUAizJH0NG2w1719RggO+W1QRgrrK9E8JtQ8Wx/w
	FLRPjqhnDIY6eCWsV27DaAifEJuUFGwAJhyGe3ESHuAhFtj1headq22eKCNWr9FgR/+WY21QhWp
	295Fz++RSs3g/6wKnMZttBGtflM9fUfKmTM9iBQIkOEqJaOQd7CzV2xcWOaP7BlzZ8KYdZEG1FQ
	/9wr/a0=
X-Google-Smtp-Source: AGHT+IGaLv3P86dnfhfsz8clY+KvPxRH7m/1Pd0NzNkAaLxjGYIDOwn76y4qMRrSSuP3v13w1OIdqA==
X-Received: by 2002:a17:903:320e:b0:217:9172:2ce1 with SMTP id d9443c01a7336-21c35544407mr480084755ad.22.1737709110054;
        Fri, 24 Jan 2025 00:58:30 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9e1b2sm11621015ad.17.2025.01.24.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:58:29 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Hector Martin <marcan@marcan.st>,
	Huacai Chen <chenhuacai@kernel.org>,
	Huang Rui <ray.huang@amd.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sven Peter <sven@svenpeter.dev>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	arm-scmi@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev
Subject: [PATCH 00/15] cpufreq: simplify boost handling
Date: Fri, 24 Jan 2025 14:28:04 +0530
Message-Id: <cover.1737707712.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The boost feature can be controlled at two levels currently, driver
level (applies to all policies) and per-policy.

Currently most of the drivers enables driver level boost support from the
per-policy ->init() callback, which isn't really efficient as that gets called
for each policy and then there is online/offline path too where this gets done
unnecessarily.

Also it is possible to have a scenario where not all cpufreq policies support
boost frequencies. And letting sysfs (or other parts of the kernel) enable boost
feature for that policy isn't correct.

Simplify and cleanup handling of boost to solve these issues.

Pushed here:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/boost

Rebased over few dependencies from PM tree, will push to the arm-cpufreq tree
after merge window is closed.

Viresh Kumar (15):
  cpufreq: staticize cpufreq_boost_trigger_state()
  cpufreq: Export cpufreq_boost_set_sw()
  cpufreq: Introduce policy->boost_supported flag
  cpufreq: acpi: Set policy->boost_supported
  cpufreq: amd: Set policy->boost_supported
  cpufreq: cppc: Set policy->boost_supported
  cpufreq: Restrict enabling boost on policies with no boost frequencies
  cpufreq: apple: Set .set_boost directly
  cpufreq: loongson: Set .set_boost directly
  cpufreq: powernv: Set .set_boost directly
  cpufreq: scmi: Set .set_boost directly
  cpufreq: dt: Set .set_boost directly
  cpufreq: qcom: Set .set_boost directly
  cpufreq: staticize policy_has_boost_freq()
  cpufreq: Remove cpufreq_enable_boost_support()

 drivers/cpufreq/acpi-cpufreq.c      |  3 +++
 drivers/cpufreq/amd-pstate.c        |  4 ++--
 drivers/cpufreq/apple-soc-cpufreq.c | 10 +---------
 drivers/cpufreq/cppc_cpufreq.c      |  9 +--------
 drivers/cpufreq/cpufreq-dt.c        | 14 +-------------
 drivers/cpufreq/cpufreq.c           | 30 ++++++++++++-----------------
 drivers/cpufreq/freq_table.c        |  7 +++++--
 drivers/cpufreq/loongson3_cpufreq.c | 10 +---------
 drivers/cpufreq/powernv-cpufreq.c   |  5 +----
 drivers/cpufreq/qcom-cpufreq-hw.c   |  7 +------
 drivers/cpufreq/scmi-cpufreq.c      | 11 +----------
 include/linux/cpufreq.h             | 20 ++++++-------------
 12 files changed, 35 insertions(+), 95 deletions(-)

-- 
2.31.1.272.g89b43f80a514


