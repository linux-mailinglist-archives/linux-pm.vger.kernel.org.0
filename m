Return-Path: <linux-pm+bounces-19729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD4B9FB9CB
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 07:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AB31882E1F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 06:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF613774D;
	Tue, 24 Dec 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAiWBpzD"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFA145B0C
	for <linux-pm@vger.kernel.org>; Tue, 24 Dec 2024 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735021422; cv=none; b=sGI4d2fglnTpsH/chzoRdxBYSpO0ZP9bCPR20QMc06Tbxouaa+tgWhtNJndpaI+ZoDrCt15cb93r175XQo11nQRH06ilig662qhnmC2Jv67NVZMMS/tvC2MugkilIanGSUymm3whfpmrLXL+eiFZYdixZ7r7U/mNfSepy8ivK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735021422; c=relaxed/simple;
	bh=KctfPhfAyHhrt+e0+CUldPpyF+8FgOIuioVktpwHf6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2NvCNPkbbzcuHoGVRPyEJ11pLc+/dkYLd7DnilVisam5P7+8YhVig58MPGmMYORdTi27w1kvygzqJ6NUqktesp+6KMeLOAWJsSkHNlqZYKy2v3rkBEidrZ5wSlFsYL1hG02BRFsZuRMGnyzToXGdn7tunKbxGHrmataKcLHv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAiWBpzD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735021419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uJZM3hqn9QtSLU1MUVvqBs1z282Qm2e3N81k4MFb1+8=;
	b=dAiWBpzDGTv4Em4gxG7R6pRK98xSI/G4dEHw5gjO4izsIK6W66rEAr/6h+IViA1EFFkxzV
	82/bdzUWKECCWZvAyYybmMeaq6iZpPXS59FaBuTePsjTVzSoZEfbpnz/KPneyC25Pyzc86
	qVJvXhxMx/QDxOKcw3fgOI5mM7Y+o5I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-wD6dwqaDPUGYbX_-feldDA-1; Tue, 24 Dec 2024 01:23:37 -0500
X-MC-Unique: wD6dwqaDPUGYbX_-feldDA-1
X-Mimecast-MFC-AGG-ID: wD6dwqaDPUGYbX_-feldDA
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-467a0a6c846so119543361cf.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 22:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735021417; x=1735626217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJZM3hqn9QtSLU1MUVvqBs1z282Qm2e3N81k4MFb1+8=;
        b=ooKGjzrsKf6hTLzQIXJcGh/AMfmh5eE1jYqcLzN6DxTWnZMHrk8AWkdyJJud5Ilgpi
         6eAanBOQD6p76OEHUWXUfnkFefiJhQ5qLIE+ssLmfWvfSCuhIAk2J+tr1q+h1vyFXnGp
         10R9oLwyWAult6YZjYFILTfLPoXwybfHMYz1BIqN8ycZ17iyeErCGk1oWDboxd5aqp9N
         YKwBrEFWHrHEOibe48tLh0tlWbq/cCmCklJxVB8QMRodrNQq9HI4Oi4PQNPknFVbqsp5
         +ePovg+zs5kcyqz+DSPZnkVYODRHyX9b6VaguYfSj4dJyvrG2ZLWXPtoB3kSKMkvlhc/
         mPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpOgZ63mL08jT19lAcMj6QpE2O853XyfYbr97BRUt6p+G7HEn82Pqyh1EOWfZA5t+cBZr6hNfSlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zQ9M+XWdRiv0nkMAvwknYRG4WFCT+/+DggUzI0qMwSGzMhkN
	itn4Bc0mD0Gh+JdleodTk01Wwm3DnF6Tb/GobeNjGTT9XJcwVUGApk3DB4oZ8vdTax4u0dLlOEw
	QpIr3faISG2Pc2tgsQbW+pw0TkV4z2Oluzm9S28qC5ia97eXf9TtN64P8
X-Gm-Gg: ASbGncth3Idb5X2Tp2Rv054Fn+bozrksvAM2qgEtO1wWqrFtWtwy+W561pjmwIFNKAa
	cvkvi/yJyQHiydzw6GaJfJoNmTMM9FvVuWV/LDu0etXQZe3pBQ/JFaEE3KXrPNS264UiRX6FkYI
	y13HdsSmOQLD5qFNX7H8SmrpcJWlJBfBHsfDX0U3T6sBA5sfd6Fe8CdgixGrSpc4+KbmBmUCb0+
	cb2sbDxAutmsS8N469CFCDH7capnnthPU2e3gxb9DNpBRcRpGLrg2aMA44GIimdY1HF
X-Received: by 2002:ac8:7d42:0:b0:467:7441:2717 with SMTP id d75a77b69052e-46a4a8d2adamr313494811cf.19.1735021416959;
        Mon, 23 Dec 2024 22:23:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/OSWmlrPjay5mAbXNcAYNfJpVQrN3GJ41Kn35W2lGPp1TWj/EuG0UN4EEIqV0DMNuOtCyuQ==
X-Received: by 2002:ac8:7d42:0:b0:467:7441:2717 with SMTP id d75a77b69052e-46a4a8d2adamr313494071cf.19.1735021415743;
        Mon, 23 Dec 2024 22:23:35 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.66.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e688cd3sm50743991cf.36.2024.12.23.22.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 22:23:35 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] pm: cpupower: Add header changes for cpufreq.h to SWIG bindings
Date: Tue, 24 Dec 2024 01:23:28 -0500
Message-ID: <20241224062329.39606-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"cpupower: Add support for showing energy performance preference" added
two new functions to cpufreq.h. This patch adds them to the bindings.

Link: https://lore.kernel.org/linux-pm/8dc731c3-6586-4265-ae6a-d93ed219a963@linuxfoundation.org/T/#t

Tested by compiling both libcpupower and the headers; running the test
script that does not use the functions as a basic sanity test.

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 tools/power/cpupower/bindings/python/raw_pylibcpupower.swg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg b/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
index 96556d87a745..a8226c79cfea 100644
--- a/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
+++ b/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
@@ -134,6 +134,9 @@ void cpufreq_put_stats(struct cpufreq_stats *stats);
 
 unsigned long cpufreq_get_transitions(unsigned int cpu);
 
+char *cpufreq_get_energy_performance_preference(unsigned int cpu);
+void cpufreq_put_energy_performance_preference(char *ptr);
+
 int cpufreq_set_policy(unsigned int cpu, struct cpufreq_policy *policy);
 
 int cpufreq_modify_policy_min(unsigned int cpu, unsigned long min_freq);
-- 
2.47.1


