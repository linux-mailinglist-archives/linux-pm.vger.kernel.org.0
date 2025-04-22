Return-Path: <linux-pm+bounces-25887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF2AA96524
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 11:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DB43B8287
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A976215181;
	Tue, 22 Apr 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGlbdwNG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9BD215046
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315656; cv=none; b=jQFzgvBdJzoIGx3zAfm0Z0MQanDWiqgpujIAuDRTFVPv5sur1DfmDWIzZoPYZpTfQeoPZojte0o7Cwrhg8GQoicncfg77lrsavSx0D49Sa1QMB79zHrgaI8V39mK6mJHuh/w1FvWOJeIR7+J95f3wf3fNfzMmXKpZEr9C9JUkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315656; c=relaxed/simple;
	bh=Hwb5Wg8id68V2WnDvFD72dDP1oue3BffEk4N4k7Vew0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7pZzlIRZpRpwXZrpzxdII/Me/rF33b5LPIvh07tclqbzF9KZmOmOsAGcVQB9jFwLG4TMbCUdp3iMtEgGPzaOt6nAhqPz9GRO/XmXYbqLrWTm5pf1LuS1i8uewNILJPg3rbxKlQA8DXbwL0Q9wyTddRSefhPMlyNP5TEDEWwRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YGlbdwNG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so3334142a12.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745315654; x=1745920454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5Kzn75CoyUpVkgbkAVHgMpizfueeVqLotFm0lBfgI4=;
        b=YGlbdwNGAPeOUUFTNkdOnb2i8AmfrcPvKDGsegtFj0tKWo1+jyL8iQQuqcqbjJ46Td
         lW2Q89V+VxQfYOqxMakbQx22n438HMtL34Dkat/9mH9oDuI6A8/qgUn7Sk2B9NMTLFaT
         Bv1Brw4dOX42c9hXunQhrHxK7FnDFTX1Ikkgo8nzT6pwsjTw6ahQTJTdQDPyDtWrbr+u
         P4vpQZ/lWoAPKvtHZa6fcZA02u9z0BEA/buvFjT37C+egHqDnLC4gSq8mFw7tGQQA/6S
         E6GKbicO/13MLlU9E02vJJSjjoGh/OQyqaI3bNqfts0EOYhDbXr0kfOcsgy2L+zs/YR1
         pe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315654; x=1745920454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5Kzn75CoyUpVkgbkAVHgMpizfueeVqLotFm0lBfgI4=;
        b=CJnSxRnMmPF+CzbToiAtqIb+rQdXa8NMkqKXiviZC8t7UFEtDs403ClTUm/1FZeih3
         KH3DN/kJ9FuAvD3n76EA7DZLjGZ2W/wJhTFQycRVbeYARM1Vvwo+9aj2DFB8QuANk9Nz
         QA4rjM6WpEJqc9Bw72Ym2ij9phKUsz+Fh3sAqnkmY4DKL2AU0Od77lpa+etvFNF+ak6T
         L9qP3NFZRAjots7QXCSGbQmwxX21yoca90mjYYucS9TS+iKmapjnhkwVfO+fqXi847ue
         yEynrRQXTctF0WbN4g29YSeRT9KHGylqUXLfEm41x12tEQkV8iQJCzTRvMOBgEgUK3SK
         AaVA==
X-Gm-Message-State: AOJu0YyEjGJpzuWZfWmy2UY1WwsK78UXIvMpWtJPKBB5nAmahFWfNL60
	mbKCslBeNIGB2HxiY8YRCjdHLk+nnN+00nzaa79/6nyBfvReHlqbdELyaqMQ2dA=
X-Gm-Gg: ASbGncs+kPw2qXCj7Y30Uou584P9NFlm+CW8JUeHAkHLjf8eSNQm7fgGgZva/ibublv
	eMrAENvNEb5io6HK2Lrofi8BOTAun/NobfesiRVv4KnK5kN5lISV1eJFz2E2N+00Vd+/lN7FJ4m
	GQ5sFQ/FOvVPh7wMlfwIrjnkmGHIL8M9Af2qZPxOD71kpSqRCE7ihLUvsNmvjwM656hi16S/Pk1
	eJK1P+etm4dn64Lazn92R30lewNeKEFJBeLCIV4NGEOdEAmS7alOC5fudapfXlMNIFkIfZrTXPx
	Z5agNT/4oXI8Wz555zRFBKuN75I2KnVadehOoBESxQ==
X-Google-Smtp-Source: AGHT+IErqjm03tFu5yST3yF0F1z9Zzqt2vjP0tGj95/hMaoPb1Uko0h1jfw4cKpAm3i77EYr44591g==
X-Received: by 2002:a17:90a:d64f:b0:2fe:d766:ad95 with SMTP id 98e67ed59e1d1-3087bb47646mr23455072a91.9.1745315654223;
        Tue, 22 Apr 2025 02:54:14 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e12a154sm8221994a91.48.2025.04.22.02.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:54:13 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] cpufreq: Don't unnecessarily call set_boost()
Date: Tue, 22 Apr 2025 15:23:53 +0530
Message-Id: <1ec6ec55f8413b0387a19a531dff0c3194847f24.1745315548.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745315548.git.viresh.kumar@linaro.org>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The policy specific boost value may already be set correctly in
cpufreq_boost_trigger_state(), don't update it again unnecessarily.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3841c9da6cac..e31891c7b500 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2861,7 +2861,7 @@ static int cpufreq_boost_trigger_state(int state)
 
 	cpus_read_lock();
 	for_each_active_policy(policy) {
-		if (!policy->boost_supported)
+		if (!policy->boost_supported || policy->boost_enabled == state)
 			continue;
 
 		policy->boost_enabled = state;
-- 
2.31.1.272.g89b43f80a514


