Return-Path: <linux-pm+bounces-29893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502EAEF70D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13CE17D607
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E840273D8C;
	Tue,  1 Jul 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqPc2VBE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6070127380F
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370472; cv=none; b=tWsh29aXRCxqFPxcyo2QwDK8rkbG+/Av+vqhao/PVKEv0lxMfXHWVlYuZuEWJGTwVUFS0fI4lsOKei1qj/g/Go8eOjzVCSTt0l0kprEzbTF1vPAz/KMpJXrp3JX7bgaEMcGOP2oKsyX6k4rl+7FP86UHfRRYQgkaF83h8FYTNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370472; c=relaxed/simple;
	bh=OJ7vM9iaMyWGCEbwZfryMptI4hIou2/uDCYlamFnw3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAvf+I3b3s/2eX84FL72PkeNktXLNiHK5bKArW4cGpKHvNIV0gQJPhXT0B3m+vGPXll+gA4nb+k5punFeqjBONXmPDDfthCq9ri3w6NOaDzrhSSTBjx4/ZUEaz83vmTUhPdqcQIM2ssD+PL7gZa5tubJrBQzZYPwpOqz/S5ljz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqPc2VBE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso1991724e87.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370468; x=1751975268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xR/zckWVNzKKFa7LSQ++02YjQJSEEQWqz9MIi6yuZiU=;
        b=LqPc2VBE9aT5rrPWOCCLizVSwVx6o3yNpiIoDWSEAlr+QzykBQVbc4TiRBj3Bfi4Tr
         2xm98cclKutHtOvYZW5xKsjP/XnU2RVKqI++KQNxZMHWvfSI+E/8aQtJGN7nOomv1k2w
         aGCFBO/5TiNBH8x9qqEsyFMeO8Sgub8uZ8KcLS7rZEKr/COZ5ozORJeZ7I7mrnSTw+rK
         fEjlHaQ9PtkKr2OJGNRz12yZUl2iPX3CyzKD0E3gm5CM9Qk5CTuQQ1DjOVx22bUi1JTU
         upD91mCeCaPychQodlT9YtyrwfyoO5oRJJO+vbZyJRUpFm89JguuYwPkREuOnu7MkjUc
         HOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370468; x=1751975268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xR/zckWVNzKKFa7LSQ++02YjQJSEEQWqz9MIi6yuZiU=;
        b=ju/PS7H4IbM0SevEtFrINyBjf4fk/38naoaOLR4o8Wyrrw+fITpaAzOO3i2mTdbHoL
         UTW3T1uyOlF502/A9WVqIPMFUl0GPnRWrFE6gp8wmeuZaIIlrkC5JAf1Yzloa0RaS+mR
         mVkt1WZUhZu9B0SIIFQ+nkbZ6OtP8RYiK5V/5C0P4Bk5MEce+PhZhxSb7aOKTaBzCVeG
         TW0Kr++3iRp1s5SOLmPXr8WFTd/QEHll3uv8sq6NDhOadmijQTeeK9EmC+ufYQzmqZ1e
         JeohFDEdP2ndU9KFtqYn77C+aHgVguTQgMRpAtsRj38d3Yfrlg+5YxlFzQazuFF+cH71
         Nf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeG0ABFuz4TaBfAZnoLZ0ZZ0Ju7vCh/KhBWq3KM1aaEJteb+aKCqrfZAe6noJpANhUfshmCYynkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPp/6TeN2cfN5EsNbl9tLg6Ch/NcHAnRU3nsP+IqE0YZo6f6ub
	fkiQ8dV8kc6ocLyFz+eaGaGiTz4MD/obdmwDCe5I57LS5khMl4xLUnrNPMd8ramLq5g=
X-Gm-Gg: ASbGnct4xQRU56g+LjTbY1O0CZQsECnRmf4OiohUa4YDo3IyiXW3tuVlOvBo1dT3G/D
	bAiIU9NN4pNPjq7/lKGeuY94P+RRIasOn5Yk3VCGPSU9qiSN3a5aEjSFj5FnTIqFBo6xhyRsqcD
	/jJGqgVvxF+Vli08qjLEBFCDLF5+1+VR18gS9Gs5g6TASQYXX0Nrkc8CbQhlsxJ1Ntl9ZqT2LXG
	+797qCH127vRV+fDwm/dCTbckgzBvYEJWoTl0fg7W6d3DRf4zlMQfsmCDTST6W04sVi+Kq59Yf5
	SUQtKz3XHg87YKNAHfExbt3wC6oGOWDhx/NWZ7cLap0NpotftofbulKQ+ifoddIuc35Pk2dTUFO
	c5RjdkAbib5gfDA5V5NLfnWA3Ng3eQpLpP9pH
X-Google-Smtp-Source: AGHT+IGO5gKzZu+VtDDlyhN1DOFOUCU8t35eiES1E+DxBtLsVS3EGtlEnPMXH9LKCJiKW0MjI+Jmzw==
X-Received: by 2002:a05:6512:159a:b0:553:ac4c:2177 with SMTP id 2adb3069b0e04-5550b83772amr4796245e87.20.1751370466845;
        Tue, 01 Jul 2025 04:47:46 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:46 -0700 (PDT)
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
Subject: [PATCH v3 02/24] pmdomain: renesas: rmobile-sysc: Move init to postcore_initcall
Date: Tue,  1 Jul 2025 13:47:04 +0200
Message-ID: <20250701114733.636510-3-ulf.hansson@linaro.org>
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
 drivers/pmdomain/renesas/rmobile-sysc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/rmobile-sysc.c b/drivers/pmdomain/renesas/rmobile-sysc.c
index 5848e79aa438..8eedc9a1d825 100644
--- a/drivers/pmdomain/renesas/rmobile-sysc.c
+++ b/drivers/pmdomain/renesas/rmobile-sysc.c
@@ -335,5 +335,4 @@ static int __init rmobile_init_pm_domains(void)
 
 	return ret;
 }
-
-core_initcall(rmobile_init_pm_domains);
+postcore_initcall(rmobile_init_pm_domains);
-- 
2.43.0


