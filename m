Return-Path: <linux-pm+bounces-41788-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJrsEmndfGl1PAIAu9opvQ
	(envelope-from <linux-pm+bounces-41788-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 17:33:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB259BC8D6
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 17:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 904E5301A426
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7CD2F6562;
	Fri, 30 Jan 2026 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwILNuqy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1F19F137
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790821; cv=none; b=LQNRMo10CmT7wb7VORma0ucQlb2bYIwGF/INKfmUv/AFoHBCcf2Oh+AXN8jUYlMpwjHCWQl6fxN84TubMssrNpDJAL0onOrBwf6PDN8JdEVFTFCsbvYJwbkZro7y+JEsWFRV7pMGfXPJpap3Oma56pIE64lWI/zuK1Xzwlc6DVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790821; c=relaxed/simple;
	bh=xdNjbHCu0uIQ/cyXdl51qz3EMjyyX8AEKvqiEPxVoTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s8NH4vtioUSsXrCxRMPEoIyZek5zlT76nppK4wYNmTACoyjMgrDcPm9nff6OHBZ5MrvfXCg/fJ/c8lVsC4FP32Bzx5ya2pvKhAwsWCAIsoIFNJdnqqk69PonVGmjN4ltgwylEXxobY5/jW0N/91a01GxWY+e+ULgJg85R5r11w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwILNuqy; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f04f1348cso1408826b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769790819; x=1770395619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRyJbPVKDYOcEx/uJfavPdGQ3FZcp74iFXGk3iA9oPM=;
        b=PwILNuqyWqB2DRAjTNw8FdQwPa6MQjWwAH+xKP76g8QRFRtNLadlbePyL1LpwPkv83
         iZTgM5G7G33dT16jheOBkrJcImLBTtBerUCss0RAOLtp/MXLu/QbXz3BxgMrVRJtkcT1
         etdQIG2EF57EWtehiD5PjPlWMOKbboEoiFnsQSXnYlQp5jH4ZbEHe9DSohsobrZlkTe3
         PjqJSAdSBIq+tHZwSF1Lu8CL5XfRn4cTbF9Qcuc1Fk2eiVkoCI0PQFRMv9xPnnCnWaoE
         /rqhjAkrW2TKhnI8zdCdWNY1MhVFDIUw8XDpfN+vaZ1bRwUzz9Jc/fyBeblIWiucGDU+
         brdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769790819; x=1770395619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRyJbPVKDYOcEx/uJfavPdGQ3FZcp74iFXGk3iA9oPM=;
        b=iFOA1onAREXlp5WtLZDHjth+G5NKjiMH0d1n7/mp7yrT+KLj2qrLRXGgKMjaEyBgkU
         nHJnSuIcdR9okEHsSAotcxMVMEo3f/GOmYIRj2NIi88Fsc9AfQX4Qh11tlXNhCG26YHV
         R/rjXzSyVepdS4lwkm2lyD1f+XdwsvE06AKzVO6kWD8AuZXn7fGegsUxCPqxVO6r4cVj
         ocBnofloEwjDx42XEWVtCaDaUeReqBYhr09+iXgESK4HjfZcTCXPjPxMbQFMNcg7lrNv
         lKtbBWybKH+xY6mbNmxCdgPgiyBxcGMkZZftNhWj0EoJSSNNzUry5mcRAoHjqDFv1zZ1
         UV2w==
X-Gm-Message-State: AOJu0YyRXVOJsQ+zNIMGawmXS+umRGOK+HvRT3wnaYnDsvQ7jHAkGPWX
	zl0cgLeIxzZKXfbQgJyEjA2cD/DpwO95Sx2aTU3TXMi5Ylj3wcRaAec9iQ5iNQ==
X-Gm-Gg: AZuq6aIWBjKNUOvIDoRGJq2Ze8ui6XsTkwCLYX+w5alXVQJLWiomul3F5T1Krg+5N7y
	+1irZdsHfmvznM1nZKEf3qoegpGY3lNh/csZ7SjAKoL+dieS8kpg4xSclD5QOv/UxK1I2KVxjNm
	0CZjmpDr2TJd8pEWlb71LkFRfgvpdiYFHRKJ8oFjbkTimYsI1dSraM4oy53RSThAWsVPGUL0zyu
	fGMTZUUHOHTuXzHt7DXJwZdcPW4GcqEKPn+sQKg4Ev2RuLqggQdSi9fvX8b4sZXOBgR+v3v9xqd
	IaWi//OMsjkSJqzsbsZdgyf/y3Y4oBRDtcRzXpQkfs5EdkTGN+QvffuFJLB/ZASsJ7cy/qaRV2C
	oC1OlgmRuZUqt955P9na747kRfj81gG/57LRO84qVZ3qjcLJR6lYJbhh2i5PJpmWhFG6pi/tH0u
	pKLOIBw2Ym
X-Received: by 2002:a05:6820:1387:b0:662:f8a9:9ec with SMTP id 006d021491bc7-6630f3854a5mr1643640eaf.56.1769790818641;
        Fri, 30 Jan 2026 08:33:38 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f99447b5sm5147524eaf.2.2026.01.30.08.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:33:37 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	jonas@kwiboo.se,
	pgwipeout@gmail.com,
	finley.xiao@rock-chips.com,
	kever.yang@rock-chips.com,
	shawn.lin@rock-chips.com,
	sebastian.reichel@collabora.com,
	heiko@sntech.de,
	ulf.hansson@linaro.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Diederik de Haas <diederik@cknow-tech.com>
Subject: [PATCH V2] pmdomain: rockchip: quiet regulator error on -EPROBE_DEFER
Date: Fri, 30 Jan 2026 10:31:01 -0600
Message-ID: <20260130163102.51757-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kwiboo.se,gmail.com,rock-chips.com,collabora.com,sntech.de,linaro.org,hotmail.com,cknow-tech.com];
	TAGGED_FROM(0.00)[bounces-41788-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macroalpha82@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB259BC8D6
X-Rspamd-Action: no action

From: Chris Morgan <macromorgan@hotmail.com>

Change the dev_err() to dev_err_probe() under rockchip_pd_power_on()
to prevent errors early in the boot process when the requested
regulator is not yet available. This converts errors like the following
to debug messages:

rockchip-pm-domain fd8d8000.power-management:power-controller: Failed to enable supply: -517

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>
---
Changes since v1:
 - Simplified return to single line
---
 drivers/pmdomain/rockchip/pm-domains.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 997e93c12951..6d3fb18f4ab3 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -705,10 +705,9 @@ static int rockchip_pd_power_on(struct generic_pm_domain *domain)
 	int ret;
 
 	ret = rockchip_pd_regulator_enable(pd);
-	if (ret) {
-		dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(pd->pmu->dev, ret,
+				     "Failed to enable supply: %d\n", ret);
 
 	ret = rockchip_pd_power(pd, true);
 	if (ret)
-- 
2.43.0


