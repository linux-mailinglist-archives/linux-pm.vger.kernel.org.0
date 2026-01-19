Return-Path: <linux-pm+bounces-41115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F6ED3ACB4
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88CE93015AD0
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C12238C23;
	Mon, 19 Jan 2026 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7XnROix"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02A329E50
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833093; cv=none; b=uVqgIGEq5hnj+FmtdK1zjIQLk9He9khFEiP3p9nFDzVSB9czdj46yNKO7DZJ7h8a9vwJ5ZtKq6V/ih30m+CbzhOdgFg4iPvsJrlNSxDPGMCpf/0f91HoDbhe0VpDFcwBlZqoSclUs1U97/yCxXEc/ymzggZYHTBZjl/OlJPNb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833093; c=relaxed/simple;
	bh=yGeQdbn6x9oSBbHSzCn9rm1Vz2KBAcj4GxREfHkdZRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwutQYPTXRp6RYQ3P6wGbB85716nyRETiycpyvZIVjKTk1pqyom0yL1JjLeH7sxWVoEnuyN/Q/TsEMJ6aRYgpYmS2j3tmEpR+PqrJ47Y8TyKpQPg/b2ylmeytFfEnYw6URO4eL6niXBU3tGAossFHW6/7edQgYJbTirPQo0loaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x7XnROix; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b79451206so3959958e87.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 06:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768833089; x=1769437889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/GHq/FwupelaKODLYbp4EN6rGymDtQOU5bIeaMRLa0=;
        b=x7XnROixH/kzrYc0lgRug5jC/OECF9NYqqNZYkpOIASx7kLoqD+qP8XnXb2lHYLqZ0
         l04D6qnqeWKf8i6imX1mIutq3qnCCCjMh6DqLkhaDszBo/bQ+MUnzij3b6/JNJ5PLG0f
         kR9wSbvKYkUEeQT0BzPuoIi7Sl/dTF77RF44+BgjNvypUv1diSNrI+QalF3Boiq6TlPT
         tU2uCAq5G2zgih4sQpbE+HQgSMDknbKf0TNk9NFgvLdgOfbzqxqvtanZ/PHWIkAwzgrC
         WWHGu25JE/mlMcC9bj8NaJ39WFyaw4RWFXwdJaNYJg4ssFcdhfkV2mjo8IVoktip7X+b
         k9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768833089; x=1769437889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/GHq/FwupelaKODLYbp4EN6rGymDtQOU5bIeaMRLa0=;
        b=v/4ysvFhFqXFXJeMdj+skoJrP+Z2k/hUdqBp52qY7S4mEaz1iyIn1uXbrpFWcijKkR
         Ny66RNiy2xqS3Tz+iT04gxoZhIz/psvg7GV4H/B5pajIOXqCFCo1dehG7WpTk0yRtZZE
         qOZHbUZmRAFk61iR9U37d5RWYEzQOFD9dLpINdQbRYL2q7M8kwgK3vuqx4OSka6Mx6K6
         2ptC+Frn/b6RW+iRvIUO730djthoBiQipGZcNqCN1+Fy9HEF9DPQswHnyukZQRVc5OnC
         9bTnNAVuqjW8M3pnBo3Qzu7TH0boZdWDOw1whJCMrkPH1YqwkLI0VrQTYmM2yY7Ar8Nl
         0plQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe59Enyh1Sw0KtwSpEKgkSG8WKFOXHK0qZg1ttvOIaxcVLnuaulC9rMbW0S6AdfNxO6WfH7vLCiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7R4+ND3MMKqNufclZ2Jb7MstBiPjvinK0Tm7TgOs7IEEgxab4
	SRS7m7eVDH8CXstV0M7pfGiVaH+sxtAsgS1Oez9mWGa3LbVocE63/aA2gCCY8fP4Gug=
X-Gm-Gg: AY/fxX5WNqEkTx02g0hmZCCaazZc60rR3LfSd2l+rtebQ6Ye/zxTsHWkx8KKUvAiLAD
	vBcjIkWdiZP1XJZ+CY3uzPbKdWVZj8H1VqKSCM1i3uGOZgd+MTRlMG98x1J2HIdDTf0/LnF79Od
	cpRLKCpJ/WV3WQ02WxxyeVrohckQrnzA01rD4EoFvNuCZ2aCanzmILPVcXrpF88Gh+pYQ1bv+HB
	JIp6BnB8qQFrgKXZpQVk42opK8CW+LqQF5eZ6Q/ODN8BaYyGNmo+nko+nGhICs4/nPtvL7+29O1
	t0W7+6x4vRWlirdkxmtspofv4khJojU4VsWnlrZrdfoU+qsLjGJ89/CKIS9/hfMyPCBLbKrS2oH
	VbXdXfUzu+z+fxCZajkqpH1o/byvcKW4gIMHnuJyNDOQWO0s+yrY07UV9FUMG6pNqYwvEKBP8v0
	YeGpwipNMai5GJAw98yJVh1eTdoVlUze8nn/GVj6lg5xRugIRse20s3A2lI8A0
X-Received: by 2002:a05:6512:33cc:b0:59b:7a1e:d3e with SMTP id 2adb3069b0e04-59baeef85d1mr4063767e87.43.1768833089322;
        Mon, 19 Jan 2026 06:31:29 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33e7fcsm3407211e87.20.2026.01.19.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:31:28 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pmdomain: core: Show latency/residency for domain idle states in debugfs
Date: Mon, 19 Jan 2026 15:31:14 +0100
Message-ID: <20260119143121.161583-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119143121.161583-1-ulf.hansson@linaro.org>
References: <20260119143121.161583-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to how cpuidle provides the values for latency and residency for
CPU's idle states through sysfs, let's make the corresponding data for PM
domain's idle states available for user space, via genpd's debugfs support.

Suggested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 919dff2081d6..bf512ff0857d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3809,15 +3809,24 @@ static int idle_states_desc_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	seq_puts(s, "State  Name\n");
+	seq_puts(s, "State  Latency(us)  Residency(us)  Name\n");
 
 	for (i = 0; i < genpd->state_count; i++) {
 		struct genpd_power_state *state = &genpd->states[i];
+		u64 latency, residency;
 		char state_name[7];
 
+		latency = state->power_off_latency_ns +
+			state->power_on_latency_ns;
+		do_div(latency, NSEC_PER_USEC);
+
+		residency = state->residency_ns;
+		do_div(residency, NSEC_PER_USEC);
+
 		snprintf(state_name, ARRAY_SIZE(state_name), "S%-5d", i);
-		seq_printf(s, "%-6s %s\n",
-			   state_name, state->name ?: "N/A");
+		seq_printf(s, "%-6s %-12llu %-14llu %s\n",
+			   state_name, latency, residency,
+			   state->name ?: "N/A");
 	}
 
 	genpd_unlock(genpd);
-- 
2.43.0


