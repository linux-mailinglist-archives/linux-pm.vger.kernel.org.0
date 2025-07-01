Return-Path: <linux-pm+bounces-29892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16471AEF70B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE36A1C01C48
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07183273D83;
	Tue,  1 Jul 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlUW3bPt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C0273808
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370471; cv=none; b=Q72IieBt4tf53oOby0PN02pZ5EyZPueYCJ8hGv/RZ4XzEKePNHMD9H9WpRJdu3qknsMR8Lig65nO9AzwYeJuzzsqFACkXqU7TV6a1ToiZL+Vpa0ozUQ6tcS7/AuoXbni6glAP9qijeCDiNydFcINYpxxvzkYOd2WIuBEfn0Gwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370471; c=relaxed/simple;
	bh=X+r0zTkUGtRJCJfRcd/bnGrRbNrkBLcRlu6vBZJ73Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIPSDA8q0jv7AbeQnBh0XfqkuEjMyy2QkYBDUT4ChQ1UI9feFijUrGVMVhdPdW5qqBIZ+6kkJjSQU3IcwSqJApsf6wbFu3vUYr5MYZD5NHZ1S9s9ZVtM+VGRCT6Fn1KriTazyQ3O5WYuhFvmBwNhv4DZVXRZ/lk6IkTFYOKEe0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlUW3bPt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b16a0e38so6080101e87.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370468; x=1751975268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAJ6J4GjiYlQlRHxgiIta0TvQOYhp5UxqNHtxTsiWvY=;
        b=SlUW3bPtqMEi9LrnL8dnMaZvtT/OFTsxVYeAYRjt38GOpH1KWUvkb6Sz+e6QHbQQou
         kh0UAUcKM74p61RbE+jtWGDsLr8POOtC2XXU9XJGu/rJPHbzsmzwM6sLXEF8yiKmPeqO
         h535b+PrNI423GadTVD8ag9oLzlMRoXY5h9+aZtEh/WujeYIVM1us4Rmr5395mSnIqOr
         CmaNtf0V4LuQTWWG/Sqm4bCKtwjcYfB+JUMW36msVlhptUw2wcnBmCHMdRD2ReoNxgXK
         +ExPMdDPJpDyhTWuISmquSuxDL/ZOpZY04Sl6fLBJhPeuFFsoXzDBl7pOAlDETzwb5ZA
         wWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370468; x=1751975268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAJ6J4GjiYlQlRHxgiIta0TvQOYhp5UxqNHtxTsiWvY=;
        b=tjViilBNLZjo9LnMBjhJ9viNU/sxdegeIi+tBsfyVJAtcV+7KaHq6v/F0Ouc2ugRm4
         H8iW+qzbZkxdYyeg9lJbrtSmsWlF2xTKWDZ2S1Z7iIul58bBjKRmlT5TM+SzWalMfoEd
         vv5/TsbNgDryF6o/UmGOHGUG92XnV9GTBVOdJN4tfJNSdZ+JVBOsk4svHcwbGcuTC5Yw
         WPKdF5p3L5HC93Ko6rGX7lEFEHEpPsrMiTdD7Ni2kE1VmQSMaWIy6hgnruphuHFsxUNt
         Bk0s9QpiZ9dnPfglDBU9OEOFqm0bUUT1LlWPYuDnleNaTCiWe2tVisDnAEvOsUUecra2
         H82A==
X-Forwarded-Encrypted: i=1; AJvYcCUja/lXAycnp6J+vwFkyKihBnHJBhXLin5WVIgaiSJ6kWzr5AOzYeUtoyQ8v4joXSh5KTNqHDdO8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6KdHdU2RT3sEhA7jKmW1fZVNHnDU7JoJYDlKcEv/KlyuB8ghk
	FkDN1MT2VWLn1bC8sedwE1lqolYZiB4e1yNiyTGn8fF8oGf1r1DDZnPPtPTxfu0td3U=
X-Gm-Gg: ASbGncus775fHOWHnwe11zArzMB17JinWQyPpZJxZ+MIWKncMwQd81aUCbfqXKewPIF
	2MiOYHb3HIby/K+lwh+CGrOs8yAcb0OPZVh58SBPs/G3qT48OHjQCOO9d5SeUb/iO7gKPVKrYpL
	0E7o3YXPjHxL41nM9jRBUnvBTub07nv8JVEwGLXjKT0hPEkgjd4Ns28jrgwnCiw3MVCDiuAnHxK
	R7zZMR9wl0a2X+hKq9FUCnPuQLlU38GT5MmYyuObisxfieNCjgC+KJmEzdgT3oYs+AVwoONdSVv
	D1cCpHO9PVc1kRykTcER+stSIcNtBYkuCOFIw//B3N1wokZLF1ZH2FFAYej6FM2kwx+t6mfXWSF
	NCutTrl5/IXfEP5M2XFwk/BubJ+vJklT9GeXb
X-Google-Smtp-Source: AGHT+IHA2zFo5pnzsu0lhBpGnceUmjdKPW3bEz4nAMuwGE5OIZ/FIvjbr6dJfXztba7RBDcN4Dq+2Q==
X-Received: by 2002:a05:6512:138c:b0:553:2e37:6945 with SMTP id 2adb3069b0e04-5550b89f419mr6638377e87.32.1751370468065;
        Tue, 01 Jul 2025 04:47:48 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:47 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/24] pmdomain: renesas: rcar-gen4-sysc: Move init to postcore_initcall
Date: Tue,  1 Jul 2025 13:47:05 +0200
Message-ID: <20250701114733.636510-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subsequent changes to genpd adds a limitation that registering a genpd OF
providers must be done after its bus registration, which is at
core_initcall. To adopt to this, let's move to a postcore_initcall.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- New patch.

---
 drivers/pmdomain/renesas/rcar-gen4-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
index e001b5c25bed..5aa7fa1df8fe 100644
--- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
@@ -374,4 +374,4 @@ static int __init rcar_gen4_sysc_pd_init(void)
 	of_node_put(np);
 	return error;
 }
-early_initcall(rcar_gen4_sysc_pd_init);
+postcore_initcall(rcar_gen4_sysc_pd_init);
-- 
2.43.0


