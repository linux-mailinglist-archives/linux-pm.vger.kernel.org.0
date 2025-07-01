Return-Path: <linux-pm+bounces-29903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792E4AEF727
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0036447D01
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B4275AE5;
	Tue,  1 Jul 2025 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SV7sjp00"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA227584C
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370485; cv=none; b=uye4MnUO3YRhGQ4q05130pO0VSqmjWVrcvoygs0UV3ubTGepnb/bJ6UveZsElhFNRSuCPco6JGv7zricQ910F5r12rzXNeiKX3UWJYdW6r0/7EvIEduRYcHprZwcHdY5kd4hfWn/q7S3zeXA2wyT3nsLhM34v5GY34/5gCJww48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370485; c=relaxed/simple;
	bh=7XFOVVB/6P0E/TmGAipE5EVbPBj1K41pMO/cwOHZe6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3I8qyJ244I7u8uMwv8//avqZJmFSFzpIgdsvuMaCz3Ev+FwRpGHmwTYIkrrQB5lkZMxMw0iyxtnuSLS/q8oRBMwbP5NSvz1TfzmcYIf27DYqKqZxgZzzCFuTYmnGTsqJAqpKIIPyrsxyoiLl1r9FepQT6SkoZmOipg7qUB2y8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SV7sjp00; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso27152361fa.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370482; x=1751975282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhr1wJzX5x14/nTupeiMBqLBJv2X3ymsgvaInizlCPo=;
        b=SV7sjp00mKEpaXCBezxr5x0W5/gBh62DWT0wLqIjgjH4lBOBFHbvrj14lxDweDAdjM
         9ZAgHm2TCh5M7oFuLaEnLLQkj/qH1lBHtAnEXLC2r6IimLBFY23uIY/fM1oipUzVoSO3
         +/zYJp2zP8d1LRlBsSfeGIyG1YlVtycrOFXAeZZGHZx2Z/U7U++l608ZEBgaLi9Bw5n+
         fj7W99YkbqKv7Zt6nStK6JIDJHGOaUER1KhhcvRUNWxZBRLB7Fo93N4zrna8yHUuKcDt
         q8LL7hxoLLncQonCcwOmK6Vj4+uerZfIk2NdfkekWcVJsdf6N9Qd6M43yqp1D06ykz+n
         6Sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370482; x=1751975282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhr1wJzX5x14/nTupeiMBqLBJv2X3ymsgvaInizlCPo=;
        b=kSYi+HE8dR5KeADJLqaFTq47ITQ6X7C9hifRdesuValMfe8opD/Hh890y68gJ1UqWi
         qCAGkWirSakdBUfNE4mMXY68uC6jfR6v4sVb0f5yQQFxff8ykFUQedg43Na1VnFeQ4Ja
         UlCqlqKXm+roElaFHeFzyMNpMFWWjC432C75ntUFlMdzM7xWv22JKUWOVoFAlCvRvnZ9
         d7GORKebFyKbkPbpD//87aHsTloc6apztW+tLmtQXcSCsvpApFdCTWev4MLfsZvhe68j
         vMFtW5aim3CgMHxKeAyjq2e5mLToSZK6ViPKW227iljtK4fZAZnHxl4YXDw+q8B//X9T
         /Hpw==
X-Forwarded-Encrypted: i=1; AJvYcCWzZWAzTIsJmzR2X1bGs0Auzi46OGjiXk8ltX0yqS20B17PgxDaH50vjm0ndL4SAHLna1w5X9aDEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWyaEGJY5D+1H+PXJcM2Rkj0GzwM6dAtWdux0uj0ZXD7XiSNJ1
	4UCT/AcAoo6DZHW3ToGC80G/j75C7uBJYZgqZ0LjddQmO453W5gstvdgCoKcXOPUP/4=
X-Gm-Gg: ASbGncsnrmPUe45I8ngw5+U7GKR6ariEqV20oB5r1mEVd8yXj+QMMaSW0PQolL5dplc
	8Tztj4TcFhAkwd8ZZWrCOeLrwiTEyM4mgzBmc1guaLFXB2jwWQJCVsnuEGX9pum2kdnBAAU6vhQ
	/xHGlud+fFhq2YYGUGbI91cQXb42j9SdxcghK4QZPySrkHDl1VhtV/krcaA4KJNMG05BwF0Y30g
	EKwBuIbPP3eai48eBEiVdU+e3a96ogu3LhymyAnB5zSc37ttidaBYMDK5uLKZ0IhjW9QzM2w6on
	KYbqFARUcFZJel4q7ynic6nEI6GQ0tOUO0sMU6yEyc12Gi3p3vG23Lx1bn/OkuvczHLDGKtGExA
	fJXh9v5cInh0w72uYZCkbIV7430uUtqxbu7gA
X-Google-Smtp-Source: AGHT+IF/OcNrgYw3hgtvoO/MekAs2AHo39DQa2rN3+FnsXniz31yfEH69hiNRp80adgJjRiNtdFnTw==
X-Received: by 2002:a05:6512:224b:b0:553:2868:6355 with SMTP id 2adb3069b0e04-5550b8669b0mr5326369e87.18.1751370481798;
        Tue, 01 Jul 2025 04:48:01 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:48:01 -0700 (PDT)
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
Subject: [PATCH v3 13/24] pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
Date: Tue,  1 Jul 2025 13:47:15 +0200
Message-ID: <20250701114733.636510-14-ulf.hansson@linaro.org>
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

To make sure genpd tries to power off unused PM domains, let's call
of_genpd_sync_state() from our own ->sync_state() callback.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/qcom/rpmhpd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 078323b85b56..d9ad6a94b3ab 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -1027,6 +1027,8 @@ static void rpmhpd_sync_state(struct device *dev)
 	unsigned int i;
 	int ret;
 
+	of_genpd_sync_state(dev->of_node);
+
 	mutex_lock(&rpmhpd_lock);
 	for (i = 0; i < desc->num_pds; i++) {
 		pd = rpmhpds[i];
-- 
2.43.0


