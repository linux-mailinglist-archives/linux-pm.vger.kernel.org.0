Return-Path: <linux-pm+bounces-28133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE03ACE634
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 23:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5178189A29A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 21:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F0212FB3;
	Wed,  4 Jun 2025 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7gQphlW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5E1FC0FE;
	Wed,  4 Jun 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749073153; cv=none; b=LDz0thWBX+M8ycGuzBGmza3kIOiaYLxn62J91gGgJDPnu4ZgJ6NKYEYGUMm+DMdlSWXBPyafWtOnGxRtihT8GboiLS+yindAJxET4dRLA+6fOYglSw3jrV89EY69RT16wCO8lOblPU8BQ4med0EBCIge0eUvP6Nxm3Fx0EKC3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749073153; c=relaxed/simple;
	bh=qlbMPk4dPEEyzeLo2479cFLePiocNA54ZUrQynVHcPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CP+F4I2PQq0MxVJcjC6ndV4ZeVrOqp/7mQCu17OmX0aScnWMzolRF/5V3XSD18kmx2COs2Bjn+n4KNRDHzVGfgKgUQ6we57Q6DxRWQmKwqHT8YntnRcLn2v0PrlM726VDUr0cJVAAAiObq77yUrHfSqfI6prb2mNWSR9RARNXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7gQphlW; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e3c6b88dbso2934697b3.0;
        Wed, 04 Jun 2025 14:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749073150; x=1749677950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ji9MGXCP+HPw0QDJgV4StrwExJhPA0b32dnkFwNjpHU=;
        b=e7gQphlWdQ56FnUVfNjpaTTEuCwuaQhqU72CgFA2bIPN/HXlOEyq7o5XTPNPmgZgMJ
         UIH0sxv0xnpym9StdFE8xfG0883K3C/37hdKHUES89W8K5cOUcjWLTBs0ND+k+eObHZ8
         sPL706WlPUQSzsIT68QCidY4F9r58eUiKrXWDabsS93NF2WIsviNu5mT3mgoH8tTFste
         JAMgCCSylPyvDigYF5Dy1v/29iDVRFE0CuVaVbRahzT4UYfuxU/WBteHSgpJ7EkgFIcO
         KQ1yanf5PON1F8rAyARFapFfjT8SY1PcCCQQ6iyOdRhxWWSUB9m3WPK7coP/H3XiDAPx
         va6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749073150; x=1749677950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ji9MGXCP+HPw0QDJgV4StrwExJhPA0b32dnkFwNjpHU=;
        b=SifvAkmf60/pYXzibV92l5OCAFIshmwOw2DwLo6XGQjZG5kHHE7eRcLIrKgpjodqJ2
         u9BSoRkwTsGeOygfAbaa0yK4a8smjWePWyWEjn7L1q14iSXP2eHES/tIvl7O4ExYGHf+
         IgJTqBSPnJs13AnY6bJijN3uME7/OD50ZqG5K3SCfk3CuZftQLEfCOykIIGX/yPnEdq7
         Vmom5P0JAjAskVW89DRimTg2U9vG/j7NMNCpyd0foa2EnsiIQdSulfkBJhjhsPn3Gt4K
         nSwlV8dMPSgQzjMH3gxumHhE+zZ5jhCy45Rn/UwSCpseWyNVKo3JvyAToNILBWWQZ/pa
         TgzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPq8bT0RwW4cX/Zr4OMuJCDSm58NsbRCPgUaM4IMN4SsSsAOB6jFBb/OtY6pNB6TpfPqXFpIMSv+0=@vger.kernel.org, AJvYcCW1Ib8ZEn0ffKNNi1wS+yK+wwrNv5t4oCb9DB1aRzlNu5/IuuEiP5OyQdQ81lQpjB2FPlZ2C5sMzLhYXfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7VjvSl8mIeVegWxY0P5sjVCbishJBAHRi4tCqOedDI/YGgxu
	rXpHquE8MAFixatLC/tk2zGBNCE1SZbQK0/lB/+bNuk2WsqM6N0tcBEE
X-Gm-Gg: ASbGncvaFE4ZlKswfRBHzArXxm9L4WytUCL8gK/U/NWXYrSLbM7PLC4ePpOAZkVfnf5
	iSGe53XEQcFsTURwq9DkwxUg3H1GEuBvSLe5GEjz0u9BqMVzH0L1JsJ9sWspEm8qDf5MlTYYahk
	VTK56Ez8pH/TABr4d6llcCUVTqVuVyMB1bRfScJWgstLrind/oW60nJBf7BgKuIBwPjrx3yIf9S
	bawIpsCByJDRVd4ZB1QtJ8+nZtKLwinushosv+Csf715vDVm/ox+78YDXXtotEgoqV2DcNkatAS
	LJbm9R+QIGtFnB8IXTZbvhyzCBS7JQuYOGrdkL81zwC6Veju55OUrWVhDlFtz49yNpCfDrljHbQ
	gUbJvEScn5uU=
X-Google-Smtp-Source: AGHT+IEfJDCrc+C4RZEsb1oC+1wSuk1DhTOprUPAFfz1n70iG84/kH6FqLEPeHzWlX0yOx095YpK+A==
X-Received: by 2002:a05:690c:3609:b0:70e:7706:824e with SMTP id 00721157ae682-710d9d6c09emr65844037b3.6.1749073150393;
        Wed, 04 Jun 2025 14:39:10 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8ad003cbsm31741797b3.105.2025.06.04.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 14:39:09 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: [PATCH] cpuidle: dt: fix opencoded for_each_cpu() in idle_state_valid()
Date: Wed,  4 Jun 2025 17:39:06 -0400
Message-ID: <20250604213908.27819-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov [NVIDIA] <yury.norov@gmail.com>

The function opencodes the for_each_cpu_from() by using an open for-loop.
Fix that in sake of readability.

While there, drop the 'valid' variable as it's pretty useless here.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 drivers/cpuidle/dt_idle_states.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 97feb7d8fb23..558d49838990 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -98,7 +98,6 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
 {
 	int cpu;
 	struct device_node *cpu_node, *curr_state_node;
-	bool valid = true;
 
 	/*
 	 * Compare idle state phandles for index idx on all CPUs in the
@@ -107,20 +106,17 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
 	 * retrieved from. If a mismatch is found bail out straight
 	 * away since we certainly hit a firmware misconfiguration.
 	 */
-	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
-	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
+	cpu = cpumask_first(cpumask) + 1;
+	for_each_cpu_from(cpu, cpumask) {
 		cpu_node = of_cpu_device_node_get(cpu);
 		curr_state_node = of_get_cpu_state_node(cpu_node, idx);
-		if (state_node != curr_state_node)
-			valid = false;
-
 		of_node_put(curr_state_node);
 		of_node_put(cpu_node);
-		if (!valid)
-			break;
+		if (state_node != curr_state_node)
+			return false;
 	}
 
-	return valid;
+	return true;
 }
 
 /**
-- 
2.43.0


