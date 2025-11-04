Return-Path: <linux-pm+bounces-37367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538EAC316D9
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3DA4634DE
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DCE32C955;
	Tue,  4 Nov 2025 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFdYFdVg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113AB32BF54
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265208; cv=none; b=PhEYuJhr3NsfSTvHrxP85zHFWlONgZAtmGpzzV7PQjiGetg/Dhh9J3W2J1wEqMX0r0MwRjQVo3lbLpC8Y0nUwBXpsmlQfAzZ0fBacIyAlvv5KfE18Cl/2cK4cfXaW6ed6nHV7m/RkfVERkHCmkhs2QHHBDkW9+6ePwd9pjqHYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265208; c=relaxed/simple;
	bh=r8ZaJI6BkiaamKZiw/nt98SY/yLk2GfAiTnSKou1nxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LP8P0IpsY5KXziOhKAxxp5wFQPfIPQ7v1+I/pHbgwPNt10Rze+rY/zYzg1FPQ2SQsdnonZX5EM2ZqiVl/thoxfjw4xLc7sDT2cR8xFFtQUyk2G4zoq/ewVQqZPTuTHURRzJhMgCHlGiE59Uc2R+YZv1xBpKxicBQN4uBmYagosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFdYFdVg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47754b9b050so7007855e9.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265205; x=1762870005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jggE3W0Hv8sJtJDyKDC+MYoM1lxEF9SIqkGx01U6ZJk=;
        b=XFdYFdVgcB7XY9NLBlhgIy3ojEda/jQ4vpbTHIalN1jkUp2QmFGKJYauRFSEU+Q080
         07E8fuB6Vu7tLlkMoniMil6LOD8o2hmXA38S3rfS1S0YA7Qn4TgVy+Npge06bYSY+T4t
         g8HXtQ2K8zzJB2gTKFitWahfKvew90zDzxueeo2ay50vAt0A4oUnRPbTLrYLiqYYVLiK
         Fs42Z5TC1GVkP1PAifImElmNbs20YsFmdvo3/TlehFLmQDyDmfUX/AUi7G5Dk1/13Qox
         sNWBfy6wdxsoo454Qqj1gyEAm+frBjXcvhT6m2T40oawJO+qZ8IArnzS3Ol/0h0hm+2+
         E4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265205; x=1762870005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jggE3W0Hv8sJtJDyKDC+MYoM1lxEF9SIqkGx01U6ZJk=;
        b=e58SlwE+hsw//4/Pdu6CqHCtZqdlCDLMHUhQ0Drb+UiMYze/uhC+lAPgICjH6pFa3C
         jpmL+IlsiG+FdFqav8Mw8qSaHboMks1IvqeMUlvUn/YfIGtA9axkNa0ACuDuZqf1SxBw
         zFo5UaB/GZqgA1NXSK9480sen3ZDPQVbuh7/UzlDnhoRW0mN2FidCpHjpkAVi5DuZrQQ
         eTY5YUroE1WrD6rCffGyAR5AxXwFZfg6WTPbK7Mouy+gXnybDf3Gu0jph+1RzwzEQlCg
         9LyY2yf3JhfMJ1iqYRn0aapBfGc32JbV0OwNEehthFCMBwKKP1KyJ3GmZ7RqYZtlSb2D
         TwTA==
X-Forwarded-Encrypted: i=1; AJvYcCWmr0Wpcj6x7P+WFCF/M9qN9zGbMgyie11y7XVS9tHB9PzgJ5kqeuRmzHMtlVKiM08WPKZSu0ASzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YycMiJBNE85YPyW48AlEMCDpIhG4zMDp8mj9k6YI2PwiH0zQlo3
	/F7KjT6c5NTrgYu6n+iGJ63ZGGG+R3n4+ZuK49qu+P2HJPCp8vEkeHvzzcKLYg==
X-Gm-Gg: ASbGncsF4xmTAYWmuqGVDXUICcjT9L7d0dft5OIFDzOQm3n6c9CmCgSvFSB3EoOputw
	ZNZcZPW4KivoX+CKf8icRVBspiR8S/i8z9U0s+OIJzUIWmZgQtc76C/N9VMReSqejLryjMAk8c7
	CJB8RwGQ6E060lPd0zUe1SA+Mmh7CHFWUw7CW9bZ1EfD4L/WHyNksYeoUg8XMQ9ypwaAUq2cQMH
	MwTUuFJ8NKyqk56HOUGAUJAoFSsyC5Wm7bYpxFruMnS7DJLI2Zg+bxXvMXKA7fhmnj+L1NGrXNY
	lnMGyiIhGAc1VLfiOqvJADK8m/rIFkRVkB9b1rtq5Q5QZKYXCgO8sdFXfa/FCHzJ+YBp9zQJIqC
	zUo7R/pNfhRI1fK3hnFx1HXtiLTBxdGCEPNMIozJ0BUEVUvppmoEG7AC0mkdPP955NNww342mZN
	u2aUUgZk2c5nqI6AuqLhVVEOsb1o28fQ==
X-Google-Smtp-Source: AGHT+IHsNLmv0MXPqVJXEKP05hHhFlO/+G8am2HvW7myoY1c6ojUSIh+/0N7JlnwOU/BddGjYdbzcw==
X-Received: by 2002:a05:600c:8b8c:b0:471:b5d:2db9 with SMTP id 5b1f17b1804b1-477308ab095mr153289115e9.21.1762265204067;
        Tue, 04 Nov 2025 06:06:44 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47754adcd08sm52511205e9.5.2025.11.04.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:06:43 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 0/1] cpufreq: qcom: handle ipq806x with no SMEM
Date: Tue,  4 Nov 2025 15:06:29 +0100
Message-ID: <20251104140635.25965-1-ansuelsmth@gmail.com>
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

(I didn't add the review tag as the patch changed
 with the new implementation)

Changes v3:
- Drop first 2 patch as they got merged
- Use of_match_node
Changes v2:
- Rename error macro to INIT_ERR_PTR
- Return -ENODEV from smem probe
- Restructure if condition in cpufreq driver

Christian Marangi (1):
  cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.51.0


