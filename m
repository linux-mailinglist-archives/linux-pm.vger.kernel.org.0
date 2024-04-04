Return-Path: <linux-pm+bounces-5915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F308898596
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAAD1C21AE6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065F7EF09;
	Thu,  4 Apr 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBaPvh0+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71C8062E
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228408; cv=none; b=iaXa3gw6mfQukFO4OBQBrya13Kc4wGsDgV6FCt5hOEFwmxGlw7BuFO/v2ZIssQn7folf4TG2pO5DW5fNar+PnVTvwKtMIQs4b7gbgEveH4F4EWFXOw6cQGF9bQzPXyzj7zRD8aZ79fuU9ktcJxIK7yvLY+ge/VPE2/surtZwgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228408; c=relaxed/simple;
	bh=QZUH1a52jMmfuHXnlXXu1W4aybSdzgNJ2CJHqixfuF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=llZfcalo3gTQ0du8jyN1uors9YaRW/xAnw0gIUT+bFCTCVeKtjExDDQAGUQA4OZ1dwSK2YA2WTrlMrCJk8l6nGFIXx+gXUwzh0zC7bhlGi2HV+mQBTByxtTP+Lhc+o0Lob4E7mtluJ6NHECgA3c/hAzLDczsW5xAbe/Mxc7/zC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UBaPvh0+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so18247931fa.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712228405; x=1712833205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/4VrhFwIx4miS0ZTEG4Oh3FbRsUqj9LhWZBkvCX24A=;
        b=UBaPvh0+jhPb7SCqBikJW7IWSp9qcbYkBFYzrI9TslS4mK6417e9pYrgZrHKNXtU5Q
         be0NjlP/y6EuruRyYWLDEEl9+amH4LbPN4bMUJw8pm7WqXdFxHdPwAcP9CYZovmF+hnD
         W41Sq9jksB5XAgc9HPBaE8tJnIJm+XzO9uNIB7r5jr5EoktdKjmuUWqGlpMU0I/sO5Au
         w8XwrdfgOqfQOJPYyegoZDU1gZPe6VUV2V3/5rT1KxQ5aKAnMEpWcoxuh9W1rDpy301w
         RKN2c84tPTRJGAuO4VTPb37P57wQmG7x3kVkROZpa70B2vDhsCT0f5ONT+fiRrcJyoLF
         sfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228405; x=1712833205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/4VrhFwIx4miS0ZTEG4Oh3FbRsUqj9LhWZBkvCX24A=;
        b=wj/oDKKghtTi86gbiA4ZSfp+9aybzQbL57Gg9jCuspaCiImzS0SkDnEEogdVaZCIv3
         jnP658ZOz2/vp1ruvIFBxZisL7hjYnrXlo3u/UdKfdkzbHcBLrtdOktQHdlTh2u6NvGY
         rH4g22y6hUBvfDo6k3RgSOMqg3JxpKAGrwyg4fodAZQ+YFEUqpXDm4xTWMzb7R9rqewo
         g5HM4oLlFiAJP52wJmGDJ65JKnWHYSDJbnE+BYw/i/eK7ZvQjPKRkAb2fd7xkgdOjYus
         PWpi5VnV00jdAATmz90EgY5R3D+ZQi8SuJsISqyshchLICngfYnknQICCuZhQEsf0URa
         SN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXamtI+QOXbOPJcmkTnAD735d3P58Xo0Cm/fipaRfBqDB4YMpIfqI9rmqHJEyQA/xCKL2JE+gJ+Xr2E3SpQh4hApn9zjJUXC0w=
X-Gm-Message-State: AOJu0YyzQi/SRFIyv584DHpV4/kDDyrNqH2u8FohPBPxODUv2j8r4tfP
	L5HBhFNe6pV6DyVx5/JKUbCH4c+8zxxn/4nmCC/pypNJIAbMAZbifqq9iiO66xk=
X-Google-Smtp-Source: AGHT+IFdsz1dPl+XP6/LnYzHYCfgyWAYaamiQYXNuyslyHX2CpEcMsg1VYQm52tn0PFfQ/QqgFpr9g==
X-Received: by 2002:a2e:9cd7:0:b0:2d7:1cd2:d382 with SMTP id g23-20020a2e9cd7000000b002d71cd2d382mr749307ljj.15.1712228403147;
        Thu, 04 Apr 2024 04:00:03 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id e20-20020a2ea554000000b002d3f3da0702sm2069719ljn.107.2024.04.04.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:00:02 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] MAINTAINERS: Add a git for the ARM PSCI PM DOMAIN
Date: Thu,  4 Apr 2024 12:59:52 +0200
Message-Id: <20240404105952.562885-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let' make it clear that we have git to manage the corresponding patches for
the ARM PSCI PM DOMAIN.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..7fb5b93dfbfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5578,6 +5578,7 @@ M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
 F:	drivers/cpuidle/cpuidle-psci-domain.c
 F:	drivers/cpuidle/cpuidle-psci.h
 
-- 
2.34.1


