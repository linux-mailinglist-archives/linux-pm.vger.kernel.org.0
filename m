Return-Path: <linux-pm+bounces-37184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2621C2536A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 159434F8069
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594EE34B430;
	Fri, 31 Oct 2025 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMahgjMA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7B28A701
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916130; cv=none; b=Vx4E7feamLKWKH4CzeUThl+wHFm0/sRZ4K7NSmiMBD4QaVMjdBVj/do1+qiDIK1r+UaUQ16li7hEKUcbsNTnpga4yIZR3YdCOUjJLEjJ87t666D5kAn5pbOf0vsaE48S7GUM4QR4OB7LDgMOeIeBAR7JCH1hoyJQDeVOMxaFQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916130; c=relaxed/simple;
	bh=VKF4CjxT3D21EN3VSlqJfkySRW64w1cVy7ISImqnQBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fSYkeDUrKxPkh9f/K8hZmebIeuw/khHnTk7FkIUSnLf3gj1SR69YwLxH2nf7tILCCVzl1A8pYwt0HLEBjnGqLU8d43Dwdd0mSZXsJQ+FWr+PUXiNM4HfYLGycciDrEeBkiyz68xjppy5EzHSsHB8mFofNxTvR5OzlEBcbn+nyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMahgjMA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429b7ba208eso1254865f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761916124; x=1762520924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPUu5NpdCJ07IrysgoLFXtCrzD3ygpbZMzDguuvidnA=;
        b=BMahgjMAuroEMeLCcHA5eXhCB26spjmGosG9khKhQiOElaSD4eNT8qeC8Wb0XzHSfs
         E/14p3NKM4F2vL64dPh2QLFCFVztqrPGV+uXKIlP1IugBl4Dkoj0DyKXRcaL/1NXOdBa
         4h+YJNj85BnzrrZ+mb0uw7PaqSRb0qusqWuvYgtaZvmjqkawjPTDlZex417sSXww5gxf
         CKKfJFHPP3UyekqqOH1fMz2XdHIqCPFIeFLUdQAvolYwvlu4tPebmnl9KcwvDj6cv96E
         DVEl2m6z7qYiRBq0ZAXVUb8+rJ3Omu+ik17lIDU4LQvJQpgiTt/b5cIe4JZG6/DpND+d
         Kpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761916124; x=1762520924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPUu5NpdCJ07IrysgoLFXtCrzD3ygpbZMzDguuvidnA=;
        b=D9sjeb7mmaJfx6jO6Zb1GE9soXNZnCsVOUHCPDVst+MHfI43AzN+fP3CQjqgK5xgVa
         6/aVI0wrjHYm2znXg3zyR00ECSfssMvrpuG26UnEDcPTAAyJMSB84n1kN1e9vWoDiCWB
         6Y9OMeyrJ6B52c+6mgLXEQXV4jBZKBOEksXqSXuvjIy0aKUrlBiggHT3vn6jvd+h2VEc
         5TuNJlF33fvPOaGPG/+j4xLnMG252kpkrND2Iqy0jps1Z2l6T3OU3zlz8BTPufzSjKrl
         gQFjm6L70fkUgEO3zwUC06LMJ4HJBn4Wai6qwA3mucpi1fjZw6XgTn9gjIlm5oyoTDX6
         AqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9dd7J3PoDh+raXK+i5UQMv6Xlp0mjN7RRn0wO1qR7EJdu9sUyukWMvNq0nW5qAj7Pqm7zV0nNtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtarUb666u5N06MROgjYevSi6PDR9CuUANHgX4NRfoVZV7ELA9
	OPamPSKj1Xetc2EobEKf4oVa5i/da6ZU6pTOG3SCOJCtfQOZ1TUPLq5P
X-Gm-Gg: ASbGncvQ0I09ESwgDm2xu6P8+Pz/m71yxjsJ4KqHrRWOTpnuI7uqZm8QRhFVcqGLePp
	mH6pUpSrh4Rfzyfv4y0d9g+VrKp1JhYF1aHKC7mLlC+IUOqPOy7lKu8I8Mq6DI0PvjShIIKYJ5c
	qmv2ubM6J6xI3fu29XlTeaR28d5CiVX6GBh2v9X8MiDMd6sHJHP+M3qGTNYpSGzv42dGt/Jsdfv
	wxcXUb7TNAr2GqnJJDRTQ98SuJjx+jTZVJD/xWop4St7b2S+tK2md021xsmB7d1Kf89qMA1S20r
	/9pzlDnpa0ucxK8AguvyEiyGDmoWHGAPOlArSSYIEdCBuPxMdnMZwHYhdiUXyFayTOgWX2B+nmF
	qMgum7+awxJMXrvzCiLHTWF9G+8RLjwC+cfWrdCQuiNnG2BySEngfPKKDfw7aFRKKoRqzi+/jYe
	BlXPi3WajdCOIVPCwtnkXR+8j9JcqXcQ==
X-Google-Smtp-Source: AGHT+IGkGev1IicHjK1ZUoYz2sTIloWKiWF3+MyirZCbZtLOurgaln1xWR/FBmE2aNtFKjbB1J9+jA==
X-Received: by 2002:a5d:5d0d:0:b0:3f2:1cd:3d00 with SMTP id ffacd0b85a97d-429bd5f50f4mr2736107f8f.0.1761916124018;
        Fri, 31 Oct 2025 06:08:44 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm98339815e9.6.2025.10.31.06.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:08:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] cpufreq: qcom: handle ipq806x with no SMEM
Date: Fri, 31 Oct 2025 14:08:31 +0100
Message-ID: <20251031130835.7953-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series handle a small device family of ipq806x
devices (Google OnHub) that doesn't have SMEM init.

We improve the SMEM driver and apply a workaround in
the cpufreq driver.

Changes v2:
- Rename error macro to INIT_ERR_PTR
- Return -ENODEV from smem probe
- Restructure if condition in cpufreq driver

Christian Marangi (3):
  err.h: add INIT_ERR_PTR macro
  soc: qcom: smem: better track SMEM uninitialized state
  cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 17 +++++++++++++++--
 drivers/soc/qcom/smem.c              | 26 +++++++++++++++-----------
 include/linux/err.h                  |  8 ++++++++
 3 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.51.0


