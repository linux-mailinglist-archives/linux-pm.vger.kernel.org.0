Return-Path: <linux-pm+bounces-32959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8DB33288
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 22:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE244257D
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 20:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA821B905;
	Sun, 24 Aug 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/7nVS+h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660CA1CD1F;
	Sun, 24 Aug 2025 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756066149; cv=none; b=BHASfKJSDbDquKKhALnXs5/JdTgZdTEadj5ESyNFvjuKXrf69BbZ3A1tMAACQfmG0ksBncYKVRzhczPfgU2jsse3auu0cYnzHdW0FnQHrHt6kFgHYGprmLXr2DqqlrqQ6Zi4e5mtGuaAfLYzzCZ+PkgMi7qNJjOKJekNeOKRQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756066149; c=relaxed/simple;
	bh=ifaq3JmFy6c2hSmtcLUr1xyhxnA70o4yY0KL/8hEoN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0eYEBL5Egp5BAmyB0lZeM6dKzuJ76lBvfN2vs57InAcMwybdYyyP2kik6+ukb0/YoSJupArO4DbaHQVlHMXBvSxdmPCI4k0V4KmssOayR57SX83NsDyUS6GOboYCThQD73MtAusMDf40R9RVIovjTRqay1N7epSejCUcjmeDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/7nVS+h; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49cfd967b9so558638a12.3;
        Sun, 24 Aug 2025 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756066147; x=1756670947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKsZ491OP7hlZbw5HTmLns54/Ml7auODI+8Ckx9ZQ9o=;
        b=S/7nVS+h8KUTNlURgwGvRusKu/MFOKwCs4qlSqxdNtygOrNh6JI2I38rhgNVbAQ3Ey
         1nz3z1VlZnLwHQLdkNK94A+b2C0H9JCZuHWZV6t6hXLPYklh9C5PGkaMtLpBalOpkhVq
         LnIrGh+70e3HsCAufxkhApIHX2itBnd6tBsuHOYaYkATeDhFW/0docCO4juiIWiQl6Nr
         p6HqZuBjoBPko+I9uwKB0rdMVAgIa1al9DURsOx9yqQJ/K7k20H/GxNv/LM9ao5ZXcbq
         +FIqjeHAcjKHInqmHWOI4/VOT4pDrX0LNfj6yvPvgz1opda5ad77sHPbexR3ua8PNK+f
         XBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756066147; x=1756670947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKsZ491OP7hlZbw5HTmLns54/Ml7auODI+8Ckx9ZQ9o=;
        b=XPms8k8RO/0Up3L44b63bwOObkjUFXA4rbSFSzvT8WwO1z6awQUruwx/qWyJCa3fIs
         Ap6uQbWOH9YbFmZxHVdq/gREvS85GV2PwNS1p9DOvhou5Gf7qibQevXQ5zJrDUXpF8i4
         ivj1HfKGtoM/FLK6IgyeSSBOlZJyf7WA8x4jfEjiDgU6FUIbTqhPCIkpSnaTbTbUeSqt
         qXgtP8RF2O2GiLkDaPkUGiywaWdLWLnuyWvgVgWkQKhiFCLujI4XihKaxtYSQlQUF7bQ
         ZyPudxq2cjDcaCHJASioifUr62uEe5GmFM3cTTKvDWAq26pAZ5OYLrfr2nvy6qMbans4
         vFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/slx6Exy9bCjhdKSL4wxFULS+jchPH8bzl7yK2Xi76zUT99pJ75O7JYXtEh55t2uJOFfJjl+B0LXLYJM=@vger.kernel.org, AJvYcCXLnDmautkOSVrtOZAKI5YYnnduLXwmrHTksTu5MjwDPROQtgTyt7wuoeTqDza8qcLJFV5UUAQKlr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb38FNKIfHKBnifnPWQmBOVj4+4av/r3+eZm+VF2+FDbnekGP7
	eGKv1eI2uSU1GMNH8IOpfSgaWqndNvB140yQ1++Vul3zzvwLqsjGugcl
X-Gm-Gg: ASbGncswDZSI8Ldh6P0YD9wDbRJRnkzxG7oSDM7vfvTnm++JFYE9m7l5JmVmsrQnuUA
	eYCikJcCZddp7y08FvgzAf9hSsEBxeK93mhYxgBJHlMyu5wJwiR0l1zFEVVU79QeIKx+HQmidJl
	uW5m7K/LJ+Qv2XpRkmG/J6YGsTjOx/sRHonP1T6OyZjxRF8abwFGQ5pDXD+MhDKR7V33txL8uLL
	O6GSBaeggu/Tm1acS3OBxeF+8jztuKb27wV45JWvUiSHwQpvtbNqbd8BPcdXEvo5pHHsaeX1Fe1
	sAD6JZY+TLlvIGvrpme8XOUTifqCzSiqKjqHC258GNkrQJ8LrbuP/i1rs6xozQXkCVFpBJoXtXt
	gD7QIFp6x3FFU1kEq86qFYb+qpptwrx7fve0FfAp/nVZUYWtpa78LBN9Q6ND20UjEREtImbuZFg
	==
X-Google-Smtp-Source: AGHT+IFfgdzWlxSxSC6eqyPCOJa/vlWcJRzwYmzWAoFJk6n/bfg69IRTk7d6f/LyPO3DzTQg1K23Tg==
X-Received: by 2002:a17:903:2012:b0:240:2145:e51d with SMTP id d9443c01a7336-2462ef440e3mr90841585ad.31.1756066147454;
        Sun, 24 Aug 2025 13:09:07 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a02bsm49389595ad.2.2025.08.24.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 13:09:07 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: ray.huang@amd.com,
	gautham.shenoy@amd.com,
	mario.limonciello@amd.com,
	perry.yuan@amd.com
Cc: jserv@ccns.ncku.edu.tw,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] tools/power/x86/amd_pstate_tracer: Fix python gnuplot package names
Date: Mon, 25 Aug 2025 04:09:02 +0800
Message-Id: <20250824200902.163745-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prerequisites section listed non-existent packages
"phython-gnuplot" and "phython3-gnuplot", which may mislead users and
cause installation failures.

Update the names to the correct distribution package names
"python-gnuplot" and "python3-gnuplot", helping users avoid confusion
and saving time for those following the instructions.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
index feb9f9421c7b..875b086550d1 100755
--- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
+++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
@@ -11,7 +11,7 @@ Prerequisites:
     gnuplot 5.0 or higher
     gnuplot-py 1.8 or higher
     (Most of the distributions have these required packages. They may be called
-     gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, ... )
+     gnuplot-py, python-gnuplot or python3-gnuplot, gnuplot-nox, ... )
 
     Kernel config for Linux trace is enabled
 
-- 
2.34.1


