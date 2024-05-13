Return-Path: <linux-pm+bounces-7782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B812C8C47BF
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEF91F24773
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B6F7BB15;
	Mon, 13 May 2024 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdDZz8n3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A17711C
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629283; cv=none; b=ZM+LzazGKP52CNk21kyY3MjxhGRh2P5XEzy3xy3D3SUSvhVDlu0V56AiPekCvo8vr6eCfbVxPYgGt12DMa1C+bcOWvOsOknQQOas18XFwOrvfBnz63K4WwUurbW3HbInSAa+6JOkPiHsz50goZEhB83KHCA2naIiVKy9eZlBHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629283; c=relaxed/simple;
	bh=XlFFdYry0q0WJig95AmmRW4jD0BclrpvtjAMnFQqNrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jX7KlJE8FyGVo/N8g3MviXGe4eF6Fgv7HQmbzxncnbnB0ojn5SVeQM/iZJPLczIlhXpmE5iQQSD51scwb5CGDTbc+cCSkqM/8rqr+CncDV6sK6Y5mf8YLOeqZCgQW1keJobEUdLzoLqohyjccu7cdj7c/TklLuI+Rf9YHqF9Eqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdDZz8n3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61e0c2b5cd2so39458427b3.1
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629280; x=1716234080; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgHX1Ehmf+BT3aFoKb7Fd0l8e76+EzPxBCtVI3FRhgQ=;
        b=BdDZz8n3vb/eAo/xgDNFn/SxdlEK+E24+SFBLKCPq6SRFPLSt7Vu1uGVxb9M5KQ7Ut
         b9BnU9pplTqMaBLsYsR7mixJAYeyas/w2686Pm+mqVAy8wHRfB7bFQEUhKzp2A185oMC
         9ld/LIERRwfI9FoV8V+49hGMjrq/DKllCqVLWK2hnSTlURA4ChZ12L3T7DXNK4Nc4OBl
         bI61ieqlubMLM3TS9+J1BYOnX/KvBDzz71lGCtnS9TFycd5UowRGkTUV1AQ+JHWLZLdY
         s9mC1Gk5l6K8ttd+U6OqXFTbMC98srCxHdOpnC2+K+s5+cpYxBwwL+kzlrleyViNoa25
         qsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629280; x=1716234080;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgHX1Ehmf+BT3aFoKb7Fd0l8e76+EzPxBCtVI3FRhgQ=;
        b=m36VjFWQYLBj1/4bkQCga+3hs/MVob2tja6VH9gepvtJ97pZxF0j+yLtxeHsTPDLsp
         1Cv5CKJP6PHPvY+9SWNqsvVz4uF/tO5hP6q+OCIN2MJBdvbrP/sf71dDdWUNxJsI4gkq
         CJU7DnFqhQ33Giz2PoEykKDErA4QdOdpaCwJk7ezqAdqEd0g2l8ka5JTv4FtZ/vi4bEr
         RBOkvqFx+5XhzebFktzoOElbJp+Ph8EStJMLhrd5MpfxHGlVUxlv3x2vju/dnUAzNoaP
         wmx1BU8VEleIL4iueB+Q7tXSpzKuEuTZhV3opsCICSx+ey9RXQptQaYr4pxrK+79s7oP
         mkpQ==
X-Gm-Message-State: AOJu0Yzeyl63ObywAoIkjC29dFVWMg9Cie4LO3OLXBP+rdUAGhiv0Ic2
	GCOSa3KwglhIo9Y5MNiFAPkzEn6E70TcWhD0ANCMoQj5AFhB70woHOmx9Q==
X-Google-Smtp-Source: AGHT+IHcb6rySCYyAnLERtE8+CuB9kSYi+u+u8xJhBWe6Z0j6jyUh9j4LJSPyyLKQgdBC7R7ZJ/VOA==
X-Received: by 2002:a81:4904:0:b0:61b:f6f:eab with SMTP id 00721157ae682-622af7af019mr80050247b3.2.1715629280532;
        Mon, 13 May 2024 12:41:20 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:20 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 14/15] tools/power turbostat: Ignore pkg_cstate_limit when it is not available
Date: Mon, 13 May 2024 15:40:50 -0400
Message-Id: <baac2f4c7f3b21bc3ba296f7aba1eebe6d4a5155.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
References: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

When running in no-msr mode, the pkg_cstate_limit is not populated, thus
we use perf to determine if given pcstate counter is present on the
platform.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0369df4f1078..b3a5a373ba02 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7112,9 +7112,7 @@ void cstate_perf_init_(bool soft_c1)
 
 			const bool counter_needed = BIC_IS_ENABLED(cai->bic) ||
 			    (soft_c1 && (cai->flags & CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY));
-			const bool counter_supported =
-			    (platform->supported_cstates & cai->feature_mask) &&
-			    (pkg_cstate_limit >= cai->pkg_cstate_limit);
+			const bool counter_supported = (platform->supported_cstates & cai->feature_mask);
 
 			if (counter_needed && counter_supported) {
 				/* Use perf API for this counter */
@@ -7123,7 +7121,8 @@ void cstate_perf_init_(bool soft_c1)
 					cci->source[cai->rci_index] = CSTATE_SOURCE_PERF;
 
 					/* User MSR for this counter */
-				} else if (!no_msr && cai->msr && probe_msr(cpu, cai->msr) == 0) {
+				} else if (!no_msr && cai->msr && pkg_cstate_limit >= cai->pkg_cstate_limit
+					   && probe_msr(cpu, cai->msr) == 0) {
 					cci->source[cai->rci_index] = CSTATE_SOURCE_MSR;
 					cci->msr[cai->rci_index] = cai->msr;
 				}
-- 
2.40.1


