Return-Path: <linux-pm+bounces-41113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E27AD3AC83
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 15:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712643051EB5
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54150236437;
	Mon, 19 Jan 2026 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hf0I+wS/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F41DA628
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833090; cv=none; b=Ue6NrZ2CmrxVI2TguJ4pXdxEBMvEpCU7FyfeoxDOYNB2EUdn9NH14jOwBdoGT5743sbyYbG9DkbaCJWNpszcc/+xJyuTl/XpPA0Qn3V1hnTvoU2Nv2L9pMd0zCtcXffh1DjS8WfDTsGEKhelS+hNSYIzElFecX8WSPqPD5gU3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833090; c=relaxed/simple;
	bh=iFEGaKa5hxECNj+61m8SOoof5oG8E2RiIiM1omiGbKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XALnh8T/pN/WQiD1AO3jU0JHb3fQ/0GGcD+HaSzs7I0DtPA5jmWp0Fk00x5HxoozqSESylvFZzQjPvAAVVLXHCVFRlWIzCsREy9vSdD9EcbfAhpMhibJuaAcVtVD71VmxWYo/fd/8hVnsGPHJI3tiB944ti5870YzA0K//N1nwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hf0I+wS/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b67388c9cso5391910e87.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 06:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768833087; x=1769437887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9wy6pWTQHz0Jofienvs4z9SFdR5Uupu87H1XvII/8A=;
        b=Hf0I+wS/bHHJaZqenZPUgT3SAktJzbrrpmjort9kWyCJ0AuxJmgmsB0DxeAYLYy2H3
         G86dsSmmvtnujcYa9f+8NJXYaEXz0pEO/L0Fw9U3htoQbQXMgxfWaAhPz4Dt+YkuNBej
         EMdKU164lLX54aCX5WzVROI3j3ThteWDjOKyIczQ+Eh607vYiGMWM3gT9tWKUSrIxSBW
         YSJsPP+7Oim48yil9Z4YKscE/yujA1i4gQ1dxCVEoA5wCS/mm8pZDFjlf1u9GSpVdpGe
         Nf15Jiqy2fHwEX70RglNInGNftTQCMp/lQSR7ByV7Mv7lqGx/p4xG6stjEmZE09DhKnD
         JxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768833087; x=1769437887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9wy6pWTQHz0Jofienvs4z9SFdR5Uupu87H1XvII/8A=;
        b=h/HbT1FhBlQBVpHZxMbXKnmzCz/oJ5HJnk1v5DRSpl+95I52lXiGhLfo4dAFr21ZjB
         fdg2Whs4+hotEsWNcgO9HAW0jpZv5YOTTDjZ0BVLj5D5v/MvPCZoYaSN+YQvi9gUCX/6
         EO1E8NB5W1WvET5dhH7oYLbiF6R7M9wOPVonK+oauPCxP3Dg5h6jyPzUJWXcXa00h1dK
         2aBoBK4BUk5L1c4dN69VMPSIILiUfxbhky8CoeN03zZ7UrQyseggBqtJUD/xmSTpKNzR
         ZrMnr69qF7BgYXhipV3gt2H55iGYQ1xZAji5ytDyAhXc1PBhaTf0JEnRRTq7XMFkc+c/
         cqXg==
X-Forwarded-Encrypted: i=1; AJvYcCXQcBDj7WhIua6RVM6bjlqcpo9r0UF/JAgNml/dyGFpCrXm6X8Z1NeJmwfNrDEnwgx3+gaJRqhN3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jjtIFQdqqeyJasdWJ412ZyNTwicDfAU51yfz2umQfTax2rSx
	HKFc2orGNrbpCU3zgVqmksrQSCGbRz+btHM7raN2qWYVsVv96ISYv7G5WblFrZy+Aqs=
X-Gm-Gg: AY/fxX5R/UHZM5UTfiji0/hbVca5BgGd7p2lVj99oG7lQU7yzuYop5hAeVLutasfL3c
	X+/3nQkChGqkasnNmYxqmHeBWkTSLLPk07E5U8gFNEo5SzM2zSlXWwzzTvk9yYv2hAlrFbeLfSi
	KTxClQ93jMK1pmRv8JVd5+q6i1WolSrrhoagpvtAXxzlYqXm90vXU/7GB1vDqRQwAYyiw6cpfVr
	R4C8pgDxkfw+zmbrlk+slRcNtHXsSxxdrnPWNjNKw0KxKM3gzdzuPuwS3P+RpGP0nK3aOEtunlK
	QCWofwHoot7ByJSVukK++wv/cMJPaoha1A5u0ltU6MUicm1qJlB4G6+NTg7Yc05sqFrBUINrk2v
	2n34ffgMeOO5rlGKYrFRYQMdsksvD2Xx3dZbTx/biKhfwLudhroFtTFcELUgluxuLD5ebD3o7np
	Qh5x9Wd40fiIIXLC0KGyFfJYSXXcTt28+ZW1SY4grhYk6LZL72iVUyjPcJ3EoY
X-Received: by 2002:a05:6512:60f:20b0:59b:b2ee:d40c with SMTP id 2adb3069b0e04-59bb2eedac8mr2351534e87.9.1768833086912;
        Mon, 19 Jan 2026 06:31:26 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33e7fcsm3407211e87.20.2026.01.19.06.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:31:26 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] pmdomain: core: Extend domain idle states debugfs support
Date: Mon, 19 Jan 2026 15:31:12 +0100
Message-ID: <20260119143121.161583-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series moves around and extends the information that genpd shows for
the domain idle states in debugs.

Please help review and test!

Kind regards
Ulf Hansson

Ulf Hansson (3):
  pmdomain: core: Restructure domain idle states data for genpd in
    debugfs
  pmdomain: core: Show latency/residency for domain idle states in
    debugfs
  pmdomain: core: Extend statistics for domain idle states with s2idle
    data

 drivers/pmdomain/core.c   | 59 +++++++++++++++++++++++++++++++++------
 include/linux/pm_domain.h |  1 +
 2 files changed, 51 insertions(+), 9 deletions(-)

-- 
2.43.0


