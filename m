Return-Path: <linux-pm+bounces-28296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193DAD189E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 08:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1513A5D5A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F82459F7;
	Mon,  9 Jun 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR7ywKbf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A153610D;
	Mon,  9 Jun 2025 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749450935; cv=none; b=BaxZpHp6CjDID3OTjsUwqPVaablDO1as4w/oTnIsLEabViMTLrXM3/c18EqfcP5GfEeeUn+4jL/KrVAxRdU8XCgPIiwPzmpd2cAjbLiqYjHD0nOifnxikSPzkkgA05zo6FdBtY8g1mBpZ4IJz973Ed4KKgXCRMzVq0tJCn2IMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749450935; c=relaxed/simple;
	bh=eLeuTaQZ+mEjmhuaoA3ei0mbiUMW1mObJTYwjfYNIWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1/4lAj4OemardP8eww4YYFcVqmQacZzvZ1cGr5MpMmcIcPx9L/nGdFNKQ8xxV7zyPeTYywMzIdcSEVNnqxJRNmGIVn640MrewVKbfwxZ1By94LA/6QH0pzBCP1g8m6VFmQW1kJz0R8cHWCMFnNP/B3gSL/ezpFM/5GTI8OraKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR7ywKbf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so5029772a12.3;
        Sun, 08 Jun 2025 23:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749450932; x=1750055732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5QjZTzRsvth07TwPIj9Bqpfw7PuFxeIFc4P3or3VHQ=;
        b=BR7ywKbfoT9gBA/ruItom26URDTalhJdJ0xsXsxpOCbthmkenCDDHgxwhXfgzzjnHn
         UVUeWkxSKHvWNjW6mOQhbwp+wCTjr/ziKLo/5/IaJN8enJJHqy+/6lzd5FFcSIMLErbD
         SAzyydYxbM8NghiLNU/8uNaqxclH7LcNkl3A/ldUPUtVbTl5zYQdfzoujZPHBA0BnCwM
         Bb15mJ3xHruJ7c+zAw5HP8nSLydSt+r7UnIyvDq/jleJz/CGCUUePF0or6fdElRRxyzS
         LX8VL0TJx7vRJY5+38waXPmj4ej4bHlfbU+82t/T2+SaSe9t4sPVXEzAUTao7Q8tLfJ6
         nbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749450932; x=1750055732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5QjZTzRsvth07TwPIj9Bqpfw7PuFxeIFc4P3or3VHQ=;
        b=NaRBMH/pR3Y+mh5aXc/tBICDErbOSIRQI0sqiTtHSe5PHUf7nreMrXz3CaHUh37z58
         cY2/wkZrnm3PN9Zx+1fEHmDg3ePFNkZXEB7rMWJqv2iuBoB/1l8nettaul5tbQE3RvBM
         k9qxT95u9DqhadDVVS4J4mxAOSqF0Gg1/jIi0TVQb1TikIZV7z4NNYeMBGpkAW9YN3U8
         m/+wGmhut8uDr99qms4qGLFJriX4sOYNTq4bRKmfMnaYihoyUIUUX9cZPqlAqBV7vzZ+
         S5Je+hfppi85vRlRZbDbK0SNU5rELztpQfNApSJyc3ZvOKZeuqMcLmnOiReMWDqA7/id
         RlBg==
X-Forwarded-Encrypted: i=1; AJvYcCU/NcJRzLLSIiOVYHJhUBWHwI7fyxzPq/OuLeqcfTksLrTuRmszsRyVIMw68NmCi0Bt87tv4tBEUdMNvlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJ2RXdpisjDUMLduZF2I3xECWj7KrUlll0YDC+8BkoKTurDUN
	uKiKrqsPCQlYHOLSpbi91kkitBIp1VXAStwb7H9wJ7iN1QUvhg7GizIVey5fvQ==
X-Gm-Gg: ASbGncutCXK9dOKHVcLbIIW6qRqn1ic+ZIL2OE84X4pXgibRxdmMS2gbtpqdDYl38Dx
	+ue3minrpiRnokMHcHfjEvSpl4hc6+uy/z3+MAvYuFyw/OJHChecQ5PuN4bY3gsYc/7XIkH6CKZ
	TgGr1T/7kWyfD4a6iPOOLWVvFXkljcckqOBo9U7NHLv6KRIRnpIHB7uBG3TMeXYuwXTgdpF/2Ik
	6CC18yuylT4mwG91+hJEXxrBFbGNnRIO7BYENd0YgQAU8jQ+3OoNdlao5pkl/rdDkPGN/b2d6bP
	nk9aGqqdBXQwHHNw+58wbV1D+P4YdUi+d9JAB7mOVrOlfyBnAr5Idw==
X-Google-Smtp-Source: AGHT+IGXZra7Xr70TDC239IEydaDWpezL0pc8rf8jjOV14kiuQEftAI3djMfCzXCg27Br/+QvUSdyA==
X-Received: by 2002:a05:6402:1e92:b0:607:2417:6d04 with SMTP id 4fb4d7f45d1cf-6077351442cmr10350880a12.14.1749450932025;
        Sun, 08 Jun 2025 23:35:32 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783c0620sm4394270a12.49.2025.06.08.23.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 23:35:31 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH] intel_idle: Update arguments of mwait_idle_with_hints()
Date: Mon,  9 Jun 2025 08:35:01 +0200
Message-ID: <20250609063528.48715-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a17b37a3f416 ("x86/idle: Change arguments of mwait_idle_with_hints() to u32")
changed the type of arguments of mwait_idle_with_hints() from unsigned
long to u32. Change the type of variables in the call to
mwait_idle_with_hints() to unsigned int to follow the change.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/idle/intel_idle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8ccb483204fa..f3ab1d6e3276 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -152,8 +152,8 @@ static __always_inline int __intel_idle(struct cpuidle_device *dev,
 					int index, bool irqoff)
 {
 	struct cpuidle_state *state = &drv->states[index];
-	unsigned long eax = flg2MWAIT(state->flags);
-	unsigned long ecx = 1*irqoff; /* break on interrupt flag */
+	unsigned int eax = flg2MWAIT(state->flags);
+	unsigned int ecx = 1*irqoff; /* break on interrupt flag */
 
 	mwait_idle_with_hints(eax, ecx);
 
@@ -226,9 +226,9 @@ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
 static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 				       struct cpuidle_driver *drv, int index)
 {
-	unsigned long ecx = 1; /* break on interrupt flag */
 	struct cpuidle_state *state = &drv->states[index];
-	unsigned long eax = flg2MWAIT(state->flags);
+	unsigned int eax = flg2MWAIT(state->flags);
+	unsigned int ecx = 1; /* break on interrupt flag */
 
 	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
 		fpu_idle_fpregs();
-- 
2.49.0


