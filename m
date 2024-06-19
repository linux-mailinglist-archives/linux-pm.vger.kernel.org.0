Return-Path: <linux-pm+bounces-9583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF9190EFBB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844C71F21A64
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A982A1514E4;
	Wed, 19 Jun 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7yF7jEU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182115098E
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806150; cv=none; b=nLfkbged5pJrwfpQenIEndqX6OhGkb6fLoi+Vo0oZHm/exbdJbu+o/zL/zhQ4vJJC29ewuiEmoLdEtsopdoUQjXdr5y5X0OS36gjFE12jOGOg0bhIWdtGMkHMwgw4kYjVX9yYd5QLPN8/UFgLv0QJn6skMyb0ddhxv0AKiYFfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806150; c=relaxed/simple;
	bh=p1L/5WV4IXuFQfEzRqNkQGg76bWmSg2tiKmoi6P2mIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ziz+UV+hHqJG3ErA4Jm1/BPanB1FRijEN//9n1/FT7FC0oh0bVFAtUnU2OeJ1NoRbnhN1tIwBP74i4udpel1D8++F1MVSlraiH419Q3F9xedau4YV80XK8EMdEYl3iMsUHXja874jizp6yXdJZ6Hv2MhxaOijFAVb9rfiNFFYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P7yF7jEU; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so7464391fa.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806147; x=1719410947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1K1pfLjx3yXde9nph0uxH/MYhA+YR/At4AWwuoRbU0=;
        b=P7yF7jEUQoKqne+fN5LFnkYRcW2vYKJBuVwDTBKCLV+ub0r0OJBbgaLvfyfz0Um8Te
         N7TB4ly/88uZV0qwc3F5Xqp++h/U8PpstQXa5UlC2b2D0agiTPydkibtsdN0TODEXmUI
         BFty1N7iv28efjLTE8rWeLd95/IJ3rqYN+nT2WXkLyBxrxsMeqse8fv1lpN2IoEd3VKA
         WGcq1ahZnu1zHciMKsDfZhX7mWmlbV4LyHW0Bw13rT9/23o3n6kHxUNTXmh1WqxFOljZ
         FgWt/Uqy3k4bDU5tRxfYBpAGsJO2NL5w1TAjlpLAI0AhIZOlHIuA7qBCZ2Nw0Nyp7mux
         n1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806147; x=1719410947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1K1pfLjx3yXde9nph0uxH/MYhA+YR/At4AWwuoRbU0=;
        b=Cpzg24D7aUcNQr7C8jXlu5lmI0R6vt7CIgfR0jGBUIdjWFp6B58CECY3UimgMwkVv8
         0EOaj5Yqo1lt8gyHTDASdr0pSPPfwTCns3SiYVXZVaYz7Bzk4oMHLDVmYYPybTJ/UkeF
         CYehiYY+IpMQoYMogI3IVTveEeNWPWZaTymhTxLGrpHh85P061axaCvCV21wOW0FCY2w
         u/A6fR0sT4VtHOsrOw247+XANuBcuccJAQgbexHTLt3cMU+WCkzDCSxFiYEgzfUcQkRZ
         kadkNP+HVoL55r4KqlUKDaiMdksgc+IDmCmErR7u75EzkoknU81gHhLAy47lbr0sWUuU
         PPsA==
X-Forwarded-Encrypted: i=1; AJvYcCX6owDXIh+ILaLq5rbrZx1cysS8v1uGiAchpnJtGJBZls+rycZ0l5vRGjj7uraiLjdXklBBdmudkP08n8SV1X4+jCAUr5H4qJY=
X-Gm-Message-State: AOJu0YyFUx/wnfyiK1uQOpuLK8msOtwxiR6Rbu9x936kLJJc0qSydcoE
	+tTbO1zBOM/ay2tvbvDgLeQGuDUnHKkKmmVM6jdFant4uAT29MWN6sDKwWWw4As=
X-Google-Smtp-Source: AGHT+IEVGpl8euILARdKcz9t6ynE/gJP+grfmU6GsH/Be6u3fMQfkdUuTeM52zWE+8c5drYOKvWenA==
X-Received: by 2002:a19:7006:0:b0:52c:c725:9d16 with SMTP id 2adb3069b0e04-52ccaa5f3dfmr1796341e87.30.1718806147197;
        Wed, 19 Jun 2024 07:09:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:06 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] OPP: Drop a redundant in-parameter to _set_opp_level()
Date: Wed, 19 Jun 2024 16:08:44 +0200
Message-Id: <20240619140849.368580-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619140849.368580-1-ulf.hansson@linaro.org>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The in-parameter "opp_table" isn't needed by _set_opp_level(). Let's
therefore drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 45eca65f27f9..02ba963d11ff 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,8 +1061,7 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
-			  struct dev_pm_opp *opp)
+static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
 {
 	unsigned int level = 0;
 	int ret = 0;
@@ -1113,8 +1112,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = _set_opp_level(devs[index], opp_table,
-					     required_opp);
+			ret = _set_opp_level(devs[index], required_opp);
 			if (ret)
 				return ret;
 		}
@@ -1172,7 +1170,7 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 	if (opp_table->regulators)
 		regulator_disable(opp_table->regulators[0]);
 
-	ret = _set_opp_level(dev, opp_table, NULL);
+	ret = _set_opp_level(dev, NULL);
 	if (ret)
 		goto out;
 
@@ -1221,7 +1219,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			return ret;
 		}
 
-		ret = _set_opp_level(dev, opp_table, opp);
+		ret = _set_opp_level(dev, opp);
 		if (ret)
 			return ret;
 
@@ -1268,7 +1266,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			return ret;
 		}
 
-		ret = _set_opp_level(dev, opp_table, opp);
+		ret = _set_opp_level(dev, opp);
 		if (ret)
 			return ret;
 
-- 
2.34.1


