Return-Path: <linux-pm+bounces-5916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822AA898598
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 13:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF012847A7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823380049;
	Thu,  4 Apr 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjPeZ8cT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C059157
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228424; cv=none; b=twNQPt8b+fWz6yrjox+WwkDkERaiPxJrxAUEFZsb0yWWrl+9GzoKajxt7vBd0XXZO7lM9XviV/4SYcXnGpka3+D9/FU6TEJOFhY5LR//UyqT2bY9DnZnC/+lbs4jRiMhUblGOOMsf2EPdeycbHqzf+LsMmoPJ1fRKiA2vJEtKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228424; c=relaxed/simple;
	bh=5vDpEzWOeRFVUxsC5ueIjdNgMUPXl4u7A2JrAbQ+ovg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFBbPV+gI8WBIYBwX+C++NK72xvwTOd6mAlXTh+UIKylLJyWmVd97BNrd8N72EBpM4dLfiT/zfapXcQvRDe55qepP7k7lTevADUWQrKpwED2Dabo1OdyhcJaJqEIJzRaVPDmjD24m1qthKQR4HDnFSLjgnQIh2RZOo3I3Mg4FHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FjPeZ8cT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d718ee7344so9738491fa.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712228421; x=1712833221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rChZ9UiC5LEOmFsB147qXIMI1R8mmS3WQNsfr48Zgms=;
        b=FjPeZ8cTh8x5haNXyBhXyteFYvVIZ8+o4+gc3yZk8YsSQcWz1ioWHjjDjg4vDZlj0c
         VjECW+6QRDY+pThIh+oE/evqgHlMwjsDjOeMlykXtdaum2FACNwEQqDJps7V3othtHle
         gDvW7Yccmcl2Pg5tdoNwV2aarz6XaSH5NwYzIHCySPN+ZoC1W2jimDFiegP8ijuGpD3L
         Asjwz1ZpQRGXX5+8JINrgmncrK/TjuiB90VGGjaTNHZUYnh7D8j9BSBc4b19nGDYH3YF
         1+4Yy5W5B6z78OIgWHZiYlRrtBKylMR7AHVdI4POvWoIWl/mIaveRBFkqwmkstLLHmJ9
         wQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228421; x=1712833221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rChZ9UiC5LEOmFsB147qXIMI1R8mmS3WQNsfr48Zgms=;
        b=R/VQTXvNVdgVT0AVyKnsdm6jTDTmaDuvQNnktuNSuNPTjjsvn2CSJBpjrdFxqnKLmG
         iVRDpLYL2pA/zqx4SqJt/JmlEEHvJeuZqZ92VAIZYom8sxcx8aHN1ovyfCGcTxFjLXGC
         EFhbt2VFUMfdrjfpCoQenzEYmgpe8g6bevHC7zalZfn6Gmq6yhqnzvLs7QC6rsh6ynu4
         EGRiNV01y8/7O3ZBJcBdkb0+MLLUC3IfVesCuK3Ve6dOD92Liwwg+aoA1raU8o3746kh
         NrgBNEJuHh3+Ovu7AZwriWeyNJArclayA4YaLxMruzkJ6n7EKsdtSs4vdq2NbcXTESwL
         O1dg==
X-Forwarded-Encrypted: i=1; AJvYcCUCbiY0CdQf5bvipWd97IzaVO6z7iS8dzucDyJIi+lUgDf1QFitiCcxSkNeXRreCF1KHbiGGqmoPBsLPyVuv99312nSDLxn+2g=
X-Gm-Message-State: AOJu0Yxvhn/oYSAjwy7mfqhxVgKcW+lrdg4FG/uiLhklvgiR7m7TbBD/
	4Vo7PAcMpaW0JL0lVjLKglUYa3bP385UTzlWKA2RVQFJ6Q/JUldYwgYVQ85c5MU=
X-Google-Smtp-Source: AGHT+IGLj9gMfinVp4kaCRhsThjciVQsHSyheIJUESN2bhJ9YJ7rs92deDBvfq0b7RjBO2kUgtvFqg==
X-Received: by 2002:a2e:908c:0:b0:2d8:2f68:d41c with SMTP id l12-20020a2e908c000000b002d82f68d41cmr1809509ljg.3.1712228421267;
        Thu, 04 Apr 2024 04:00:21 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id m19-20020a2ea593000000b002d816c0500asm1079899ljp.118.2024.04.04.04.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:00:20 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add a git for the DT IDLE PM DOMAIN
Date: Thu,  4 Apr 2024 13:00:18 +0200
Message-Id: <20240404110018.568143-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let' make it clear that we have git to manage the corresponding patches for
for the DT IDLE PM DOMAIN.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fb5b93dfbfe..c40c580f6df2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5586,6 +5586,7 @@ CPUIDLE DRIVER - DT IDLE PM DOMAIN
 M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
 F:	drivers/cpuidle/dt_idle_genpd.c
 F:	drivers/cpuidle/dt_idle_genpd.h
 
-- 
2.34.1


