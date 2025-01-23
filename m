Return-Path: <linux-pm+bounces-20839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AFFA1A320
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5D83AA87E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B053020F09E;
	Thu, 23 Jan 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgU21g0r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22920F08F
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632292; cv=none; b=OhNe3wJX9Zde0tY2tNBLu5r+EpYhTY/ZBN3B2WRrElKXEqRK462uCUt1U0dU3VzCLs3ztyttkrm0CHCLSHOD8rNVE7k0xK4W7k6B5tTjs/xCJuSz53mk8qgW3ZEuY+1amN3IyT4Idg++YHta2sf+V5RAwcM/f+5ZPwUaNBHvx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632292; c=relaxed/simple;
	bh=3EqTMyJtqtFHPVycbC3qEEeT/l6iBIOW6lgp64PBNuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XsXvU1d3iSHuwMv4aUa1NhqfPHBeS1lfNSwpQR62tcLb6ylc9gOhpf2x2KxI6+ANPRFVLaJoXWDqAAIMGnVgvfQzot3DQfe2++j21/KQrx4xdEc/kLQZqLBA4efeNWELdLCK4Dz6Xm+KC6hVZkdfBGPs4BmWuc6oODqNykE/kRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kgU21g0r; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so1142433a91.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632290; x=1738237090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idxb9Cgj6A0IQcTpE1yY/ZRCz8Sif6aWzEjBOTW3qPc=;
        b=kgU21g0reVnJosswbAEEdRQF74w/VlBhIUfM4KGa4GL+lqw19/8DBCqKXpNJdhUljd
         buGu+K/oqlWnT3uhHJTvo7+CFOJvut3/dtsHAkfjv/0HxCmAxZUWoPPFDCBWiL8rhDzp
         77UTwrVuAWbEvNxHwVSB3aMGOQslGy6rpDpKvLJNrhqlOuT8NkJxZOpMttbU1+1Nw1qS
         2XRNiGMxp4oAwuUsiVXISdJ+IwQc9lnYBkX9LRmn9CizzRMsHdXL2qskc3sVNGkDord9
         VTcYMi0rv6kd202ONDxUsgqAq8lGn2sMSpHL2BpNrQ/HWkRG5oQsCnBL9C3LksZck/QE
         WfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632290; x=1738237090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idxb9Cgj6A0IQcTpE1yY/ZRCz8Sif6aWzEjBOTW3qPc=;
        b=k7vUofVfKVIi+PkTD9tQBzeG2S6vFh+V0JnYcg+/tzBDIM2bSnOL8NeXPBAgPGYQo8
         uDD31VnHy3Rf4CFqK8m1cKx+htmwjvJrH6PZyB+xbnfeqWRKTs5tBOzelKPqT5TPsuVH
         MnxR3ahUCosvKbN7lRSJuRnT/8YDsAfnE851pJxyV77VIQbCn0D8VJfQRweJ5TZFe6pD
         BPHoMY4YCctvBtZDuY0BK0De4sIeSySbSGkzQfhakAxIouklDeHu/Wfr0D7SFkRw/iBm
         x5pIl9lT43tuXAipxIGjpc554OdlCFkfdyuO2Pt5vQ+eWNiomuuO6F2uHuqyjUUjRiIC
         AAOw==
X-Gm-Message-State: AOJu0YwNKDXpIIgqzQANyH1+DRgbKDbc0L5iv/cai/1dXCjyPJv6ELz8
	rhuFh+j9UIjJ3+ibmvsA+qTahD5zQek5/RsXUDezuaSdjvGJzdls6HHfrISZSCU=
X-Gm-Gg: ASbGnctjL7hsRG6k+MWmcTxEwO1rGRxyV629kYVb44Wx2FAJpRZ3AXAb60A1ai25LVh
	GEU619OpmecEBspMtnewr8Y2GUItFJWmv+yBDU6oWarbFIkFldosAivaUGv/fzeh5AeY1pZBLbR
	GmEbL4+04X5ZWBBgMME6OPEElBStEn7osp/AD0uSiGw5v+WsZxa0QvH16tiGccWrOKrCtIsn8LH
	o1JutPwuDcv4j3ll9CUsQip3ymS8AEtml0fmwVxf8p4JWqn/WJ4Ae1cX46MPHqhrC+DrsnZmHIG
	58bmgS8=
X-Google-Smtp-Source: AGHT+IE9L9+OPWt3mEh1svIod37EsVQ7Yc2Xn42XCSXFy+PzNQ8SIdzcyKM0TGYQVNSLzMk6808RdA==
X-Received: by 2002:a05:6a00:1c84:b0:72a:9e3c:920d with SMTP id d2e1a72fcca58-72dafbe6a98mr31890478b3a.22.1737632290558;
        Thu, 23 Jan 2025 03:38:10 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8e95sm13152379b3a.106.2025.01.23.03.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:10 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/33] cpufreq: acpi: Stop setting common freq attributes
Date: Thu, 23 Jan 2025 17:05:39 +0530
Message-Id: <d95022fce9e0ad2e5224fce1fa0f6bb10aadafea.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core handles this now, the driver can skip setting it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index c9ebacf5c88e..dcffddba5af5 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -936,7 +936,6 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
 }
 
 static struct freq_attr *acpi_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
 	&freqdomain_cpus,
 #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
 	&cpb,
-- 
2.31.1.272.g89b43f80a514


