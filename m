Return-Path: <linux-pm+bounces-26993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD57AB26F6
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 09:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF24E1895346
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FAA184540;
	Sun, 11 May 2025 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFC/9Jth"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003812BAF7;
	Sun, 11 May 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746947524; cv=none; b=hk/SwEYpVg2d4X7R/7vUn0iK1fqq3Jyu5VgzZUcBrkJjf5YPf1ylFIBTRyMIiZaAg9xS8AOnwykvwIa/ICN8tAqQH/BUm2UGOgUkl50mM2+/FBXgkyILG4taNHLoO7LsWjPPLrCEkVpwvr61jU7uPc9EovE6+1sGwoH5oeJFMcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746947524; c=relaxed/simple;
	bh=SeCSX6KSiMRaMdTA/4jD3Ptv2EU+WnihkySqxC3wfzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K0kydSdh+cMKqg/bRMlRtZ4BOwi9kc6sXxA7Hocux6bHaFSAlhR6b1aSiclAiDLGfPSZJdhciIuNjNZx7KsxsbsgYlxMY7SBeRV8c5WkYmXEoby1DO5dNZPUYuAhXJdrQOE5W3Jug6XkOMKVtWeeuebDsTp09GyVyEciWGF18Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFC/9Jth; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742596d8b95so470853b3a.1;
        Sun, 11 May 2025 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746947522; x=1747552322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m0xN7ARhwIGpNZ+k0QSJwzwuUu37YWzJSbk2lnPQURY=;
        b=kFC/9JthUVPsn6twcqb4QPDIWZlvzJGQ+BmnljLi8HEIb4GAAZ5icdsNYqEuAT/FEB
         gVqrar4edjWIVAH84aqrSV2l34TllZGUcDM4qVT42QcvdexMPB09spyzHvlZ/9gxjHh8
         /8WBJzDkgUuKKqsrG6rEp4rtKXq8kqBFin4QffgnwhSnS5lZBG7m3oy2wS9bcF2S/0H4
         D34N2wad7p8hlKD41MKWnbUEkAhGByqPaySUPkAbeVV9TlnyWmZ5ks8+ZjqMEL+49ChL
         s9c4ANZ5BKPvSGSXpZhZiKWbZndut1pWmdDwGnCwtNA9n8PliuM3PdigjM5P9BkbDSXq
         Lr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746947522; x=1747552322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0xN7ARhwIGpNZ+k0QSJwzwuUu37YWzJSbk2lnPQURY=;
        b=w7nvKQ6CnsAmtoPXtri7iCkCZ4KYVqNBHQ40Disnn+yI4FSd9PIluZ47PO7IlN+S2L
         9HouFzlOnUGN4gOm1Le0ovdMzKipES4HP2nfny6gfeRQONBP9u/JqEolPkqgLHO3LNPe
         qRpG+AUW4Vmv9qkYHbNAyjV5QiOlQ6ZI2AJrdEO6t0ZhGTJ/L4ZLhZvTarHkbsdh33cs
         vRyo95Mvoe9q6n8sPx4tgdBx+syDpEz3vaPPff3WOU+TpS1tLUdryRJTAUoqapXAHj2Z
         jB+CgJMTE0V5A/R4tJeXLwy+70QWURAYgMfzPCpc1YeYxquPwinMqdjvHEP6rKV+Fhnd
         RxWA==
X-Forwarded-Encrypted: i=1; AJvYcCUcHvUMynYuk9n+V290blsIm5m6/XQVsgU2BuPBjNyvJH6L43RJFE5rImObNW4tmGPyd/QwaaAJIO24qks=@vger.kernel.org, AJvYcCWiXLpeiCqisSFKEvduTCqwf3Qrr3TqfVkyK0b1OVOpX/W9y3xXA6FwQjBt1odgd8EQHWLAMPeVOzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcSV7HKgCYMHw2xVIy3v0f0ErsFWFAGyXKL8swxy3YnHn8B6n
	WedM9fSZOAlZ59m2xJVOLuIqGmY3iJaD2nwtAXvlMzOQfqjo63ET
X-Gm-Gg: ASbGncupYwXmQTpAN5MCPDfUzFDDq5vmdV8kZUo6GjSswaNmyqKr/7Vt8v+idiUNnuy
	E3SmGxXCmwTfgaEZxWY33WTDLCgclJLF/xST3JOLwK8uf/B73VDGg2J24dUvpmoOkTyMF6u7+kF
	ifJ2CO2tfG5LN8LxmZ/VenuXLDZZSsg/W0srOw7rF0i1i+qgkdgI01Ghyh1mmMp8/hLA82Q7pzw
	IdBrKLIQV/CVZ0zitK9As4PyE0gZJt+1Ug5/FcnI+ZBg7I0be7GJ4AUcZyAarxmdy5ymKYWimyw
	ZnOccQ/HoDK0jXs3JXPeHlnYnM48zLRRPIVgEhN3ajJ9AZA9Kcgqwq7d+7Y=
X-Google-Smtp-Source: AGHT+IHoEsdKtGlGv5WCy4XZLfvQbsiP+LL8qhQCwFiBQenBxxTnABi30rSn1jwaurZnAEwE5yabcw==
X-Received: by 2002:a05:6a00:4c8d:b0:73e:5aa:4f64 with SMTP id d2e1a72fcca58-7423bc5e8b2mr11308423b3a.10.1746947522137;
        Sun, 11 May 2025 00:12:02 -0700 (PDT)
Received: from atom0118.. ([2405:201:c009:5aac:8c27:1b8d:e286:ddd7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a3c600sm4135025b3a.134.2025.05.11.00.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 00:12:01 -0700 (PDT)
From: Atul Kumar Pant <atulpant.linux@gmail.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: Atul Kumar Pant <atulpant.linux@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: EM: Fix typos in example driver code
Date: Sun, 11 May 2025 12:41:41 +0530
Message-Id: <20250511071141.13237-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the API name to free the allocated table in the example driver code
that modifies the EM. Also fix the passing of correct table when
updating the cost.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 Documentation/power/energy-model.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index ada4938c3..29388f6d1 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -381,17 +381,17 @@ up periodically to check the temperature and modify the EM data::
   26		rcu_read_unlock();
   27
   28		/* Calculate 'cost' values for EAS */
-  29		ret = em_dev_compute_costs(dev, table, pd->nr_perf_states);
+  29		ret = em_dev_compute_costs(dev, new_table, pd->nr_perf_states);
   30		if (ret) {
   31			dev_warn(dev, "EM: compute costs failed %d\n", ret);
-  32			em_free_table(em_table);
+  32			em_table_free(em_table);
   33			return;
   34		}
   35
   36		ret = em_dev_update_perf_domain(dev, em_table);
   37		if (ret) {
   38			dev_warn(dev, "EM: update failed %d\n", ret);
-  39			em_free_table(em_table);
+  39			em_table_free(em_table);
   40			return;
   41		}
   42
-- 
2.34.1


