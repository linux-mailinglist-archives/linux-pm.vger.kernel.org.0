Return-Path: <linux-pm+bounces-11472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9402B93E07E
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C572A1C20E03
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324C18733B;
	Sat, 27 Jul 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhyF7KYc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C93538A
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104811; cv=none; b=i+xDbBrcdF7ZM0FYMAwqaBzcO1t5AseUZ0jocyhvY9Xofl0NCe04E+xVNwjOz47iOQqiMgtKr8+BhtTdGjVCw50NmsaPRJXhu20CbuE2E01JGnD8fPN1uTHBazz0Vt3dA0OjvX3zTMpuA15M55f6XwvAVJjL4Kh5EvDQ8NLDdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104811; c=relaxed/simple;
	bh=u+gNWd8iT5sDxxLHEkos8l1K0Y9S+LxpXX9ZtHcGEY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuaxRRnrH7dlpnLwTy81j4fPs7dce2USWPlK8Fx+3jyOyMogLhPnh2DQERRahSD73Ap5wBgKhyiZtmCwR39yU0ksuNH7/1MpoTkyArE3EpsBeCDeLBZqBMvrUPAc1vu6hR10t3p4tfq62ZTQFDDDZAZ3LGTjAXcdbtyMp8VMrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhyF7KYc; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70940c9657dso607548a34.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104808; x=1722709608; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dp2dN4Lx1ReZt/IfAA6cWnZpSjAxrnU/bcjge0cnSAY=;
        b=PhyF7KYcTsvUea5+e2Hi47qAErPGzgK0FS+Vuifr57yZQREld49VF6hinHDG2R5+pK
         2lh/5Cm2FpFtj2gzVzHtYyial6NsebfS3ZlMhDf6jtXg5dwzAUFcrm2B7OnoCpKjuo5B
         aOKQ7/2RB7rQW5TWAibF9kAwUIcopBx1ABAp/A+71rHqdKsVbW3fMW6Rhx8ZpM4jQmXy
         E6BF9k4RFhPqPQm6w5rpKbOo5E77M7XOKHc6KDXmG/HP3evIXO8DqXJAVcWlVtIlLIcx
         wowtdZQ3ep/zG//d0kRNV3TS5Hitia2gZpIpwlpTwHxj0vv29JpEaQiFepa8Y1FrTWSB
         yztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104808; x=1722709608;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp2dN4Lx1ReZt/IfAA6cWnZpSjAxrnU/bcjge0cnSAY=;
        b=L0ihNGjzqF1lwPSyhsyigZ7x8SWVwxDDLA1MFIHAdh4wFcL/OPDIARTPRaK7iX+7oZ
         lrPnIDd8sqhXLYsXTHCfoCYB10+IFqMQp1iD3XvnMvS3/gHTMPqtnNPyFSl7xiDBPMqp
         Q3PGHiJ1ImALgVknRlRMiKHDnlT1cNnnVegFzVgygi13eITPfbwObcDgnEnG0UEyQxbz
         fhe2Qz+g22H4Edsp1eC2y0803nfgi/jpRyFuVvcYx6QKfEdAKtEKWqiv0j7fpd+XQaXJ
         /hSi4cJRPucLSROSA1CG1GrFIJoUCqsICd7Vysaw+7jtiz7XHKibqrro+toVy0oDBqdV
         ZMMg==
X-Gm-Message-State: AOJu0Ywo7syirCfc9bOkmswmdXXq5DK4xNK/huyuhgdr4IZwhecwKbkF
	vPJ8fSRp3suw3g4gRFX5Hv2RXQu/KORUSaRq/r6gil3UWhAOpV7B6C++nQ==
X-Google-Smtp-Source: AGHT+IEwMu2WSEdo0j8GJ8xc4f2Yb6MiwXw7WCJnywAEEVHzcYKoPLe0tE2Es6YPf2rDEASZbDJqFQ==
X-Received: by 2002:a05:6830:6713:b0:709:36c6:68db with SMTP id 46e09a7af769-70940c55010mr4067469a34.25.1722104808565;
        Sat, 27 Jul 2024 11:26:48 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:48 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 02/18] tools/power turbostat: Remove anonymous union from rapl_counter_info_t
Date: Sat, 27 Jul 2024 14:23:28 -0400
Message-ID: <c81c8ee445e84703cd90171365ed596ef94399cc.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
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

fd_perf field used to be part of the union, but later moved out of it,
because we test it with fd_perf != -1 to determine if any perf counter
is opened, making the union unused.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 02312e62c857..1ac74cd49cc9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1085,15 +1085,9 @@ struct rapl_counter_info_t {
 	unsigned long long flags[NUM_RAPL_COUNTERS];
 	double scale[NUM_RAPL_COUNTERS];
 	enum rapl_unit unit[NUM_RAPL_COUNTERS];
-
-	union {
-		/* Active when source == RAPL_SOURCE_MSR */
-		struct {
-			unsigned long long msr[NUM_RAPL_COUNTERS];
-			unsigned long long msr_mask[NUM_RAPL_COUNTERS];
-			int msr_shift[NUM_RAPL_COUNTERS];
-		};
-	};
+	unsigned long long msr[NUM_RAPL_COUNTERS];
+	unsigned long long msr_mask[NUM_RAPL_COUNTERS];
+	int msr_shift[NUM_RAPL_COUNTERS];
 
 	int fd_perf;
 };
-- 
2.43.0


