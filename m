Return-Path: <linux-pm+bounces-34233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31CB4AB79
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7D13ACC2A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB7A320CC3;
	Tue,  9 Sep 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cr22/y6I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D23203B0
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416298; cv=none; b=m0qrxlXnSDt/S80gQqINRPOj7s6kQzXaSBwmSGOTN5NSXgP6amS8bHEohDRXXSA59V/qJ16sC+4OGGMm6R86Tk8BDtfmzl7Z/tTK3qQaYZM6F2yFrT1Cp68M33zzUrIN8tcLTvdHYucMHcVdUYNkP6KzThaiQ1KVkvVd//Ee66A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416298; c=relaxed/simple;
	bh=094lJaSsPxlwfHEFYPofeNdd6qzO/y3n2JSMoDq+y4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNu/Zugrs2Ir7krzcBI99dn4Pf2zFq6Ngio87zBRkmMNKTE1zsJZB5F7d1/dftLimgbPxfOmVY/Q6NLHrgXxmwZ34VtpUbvksySYQhYZvSC3hqjv5F+ELTB1xOuV6NMzJpp6OobAwFLFAjzP6MCzlVG3EWchxU8NFSClDyPk3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cr22/y6I; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so5204324e87.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757416294; x=1758021094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pEpSIVpCMDDxDEaXx+VtwPotB+bnapsn796RrVe/EA=;
        b=cr22/y6IHo6xwTBMAMKPgPb1oNqoRwacm5ElaQo6TprlFI+gH+qLjMhTrlYqhs948t
         4jWbBVpmdRYHEf04RJyQAD0od4La8VH6HLhOv78LzW+je7haaA3TX9UqsjpcbLqZn6oG
         BdHyb7uV6wIiGEbGJT6PuOWgP43k4gFlYZyICcR+bBTF2+IZtxIwBZk/b/6E2+VUvzCQ
         cuFfibAXSpVOp9QmJybGmPH9yRzP+6BhQ0KtyUdC+ivN8eyCMxuBGydOVhUotOjd5+zh
         10mg6p91R4NuEAtaTvT/BY+JhBEb6n0wDBeyS1zVDrVSLDKNCqWGrK9Gq9J24M43L6+u
         3m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416294; x=1758021094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pEpSIVpCMDDxDEaXx+VtwPotB+bnapsn796RrVe/EA=;
        b=FuF3KRTsDj7PfH4JNuofsrCL34p+0wGwPYWziYHzJInCe0E8pDIVK1Yhb8CxOMhvJw
         XMads362SiaJUQS4YUoj+U0muTHFXy9/rFNKFy3fZ+XUmx5PtlZmkatt0rBVL2NbWf68
         an2+2oZ6ccnceIvjlCnLMQ2sG+ZnNvza73KrkJ9i9X9w8cz9CiieDM6bo9bNXA1Xr2Jd
         Lrg+9daPQYKBojjCI/atUek1df5fq50fzrIksIdPy4jUu32uBWB9tjHCSshSJI+QTWcW
         m2GPkQ7T0v9472XFP+Z4a+G/6R8yVlTMKJX1bG67u8x6iju0CnHGoTcyMBbY8m+jZNRo
         RCbA==
X-Forwarded-Encrypted: i=1; AJvYcCVbKT+xX8FOgfC9H5kOSwM5fuo1U42YNJkL4kWEftC3BqHboDENYtGjlkNqW0tWv1qh/f7agrQ8BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/36YU2V38FIlK288L73ETE8+FOYpU/4wQ5aAxMGS32CAo9jSl
	zgCI6htiLKsDq/G3klP3oBYke8cpCCw0UNgwGGEStkRJUzKOtZxJrERE5bPeZ0qxaKU=
X-Gm-Gg: ASbGnct6OtxuvlIsfMb4GxZnUS6kZCW/C6JkxydHqKAfw4KfQ0D9Bhr+JSgMfC1zTRJ
	oKkmwIX4OXFrKB0Neg6ByZ+jIcjXFy/3rLwtqCKYzVzAQtqlll6l+IhAr0r6q3E5+0Jcmb0IV2O
	8Fa8cGoikdBq4rYoj7b6vQix5mSwyaGLvARpRxYzkcDZkPK2qeqaDImH9YUDNoHs+5tDaQiVyGE
	bR1qOuuofOFID76HNWdTeaRU0RlPB2Zczwv7tnTH5XdAH8EOhXQrhkxz4vJGU0Gny0aWynsBfNw
	RYIdCfnqJ0stiVmRWBuAgrohw1RdB2UQ7NaKYR9cwMQkvaHv9d53wG/HhR2ScDj9ozZeh8Cn/KD
	cIygQpZpjSaOwpaPzWpPFl6OBLUtpe1kkTA0G1Oq5p/B7RJeMRSfskmVP0mDtj32ZT5ImV8dvpO
	kGOjTGlRjxleQZdQ5gog==
X-Google-Smtp-Source: AGHT+IF6KQ4FmESzpiiWrP7Wky+yhjadfUfHZDM0+zInTn3WZZmjB/qogaMmNeaRru1voHTpZXRtng==
X-Received: by 2002:a05:6512:140c:b0:569:766:9451 with SMTP id 2adb3069b0e04-5690766978amr603941e87.17.1757416293652;
        Tue, 09 Sep 2025 04:11:33 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568190f8040sm445440e87.148.2025.09.09.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:11:33 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-pm@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] pmdomain: Restore behaviour for disabling unused PM domains
Date: Tue,  9 Sep 2025 13:11:19 +0200
Message-ID: <20250909111130.132976-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes to genpd prevents those PM domains being powered-on during
initialization from being powered-off during the boot sequence. Based upon
whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relies
on the sync_state mechanism or the genpd_power_off_unused() (which is a
late_initcall_sync), to understand when it's okay to allow these PM domains
to be powered-off.

This new behaviour in genpd has lead to problems on different platforms [1].

In this series, I am therefore suggesting to restore the behavior of
genpd_power_off_unused() along with introducing a new genpd config flag,
GENPD_FLAG_NO_STAY_ON, to allow genpd OF providers to opt-out from the new
behaviour.

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com/

Ulf Hansson (5):
  pmdomain: core: Restore behaviour for disabling unused PM domains
  pmdomain: rockchip: Fix regulator dependency with
    GENPD_FLAG_NO_STAY_ON
  pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
  pmdomain: renesas: rcar-gen4-sysc: Don't keep unused PM domains
    powered-on
  pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains
    powered-on

 drivers/pmdomain/core.c                   | 20 ++++++++++++++------
 drivers/pmdomain/renesas/rcar-gen4-sysc.c |  1 +
 drivers/pmdomain/renesas/rcar-sysc.c      |  1 +
 drivers/pmdomain/renesas/rmobile-sysc.c   |  3 ++-
 drivers/pmdomain/rockchip/pm-domains.c    |  2 +-
 include/linux/pm_domain.h                 |  7 +++++++
 6 files changed, 26 insertions(+), 8 deletions(-)

-- 
2.43.0


