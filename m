Return-Path: <linux-pm+bounces-30556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845CAFFF40
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C759B1C27098
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE52E11A5;
	Thu, 10 Jul 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P96Rwtpj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758B2D9787
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143233; cv=none; b=Kzst1KW9qEDrAe0CmULkJ24F8X356481qAD3w20GlZRNJY+a2OWBHOFu6fwQAfUL97IZSCMw+wVMMiQu8RXDOi66S9qopT+E79JBJO2lBvk+Mo0lNC00CNI/c8WGuA7mzzqtRUlxnPOWTa0So5LPB26N6yUfdIsyuSofF9p5M64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143233; c=relaxed/simple;
	bh=2ialj3ffNNqXJ+tFyTS7uvxfvmvcjXBiITgVM1cZTTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUWXLtFTf/pUOfZJDdaSHqZLPONSY7s6KRoxjUjLHkirT4Qzuc/GDnvEREZqudJM9gGA0GZfpBNPJSbCf6jBXDt7hbBomapTy/k3F2A5CQSlAs9fhKajOA0FHxyWonxvyUYplaI8gNUnWfjEYxziILFJQ80WegO3iGADutAJ3AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P96Rwtpj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55502821bd2so768220e87.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752143229; x=1752748029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMrHrwj6C4PnAa1hwUllth+c9S0hJcOtmNg/4I4sqcg=;
        b=P96RwtpjVC25o1Is6n3sltloP8MNpfNpNRrEgUKQ7K/TANl/HiTmPhGxqlZ3Pgvttg
         jkNkOBoVkhsZPw2+MDJzUG1V6qi0c/HoPHut6BLbRwT3lFUwOOwMo/p85EeDX/K2OVrU
         U9D7p9Vd/sCcCzdrmfzKxcWbNYyeUXndIvdqXCD3fb7xe6yVSUqPnjtRFsEsg8Lcb1ER
         pmRgkHjmkWn7/Di8Jk4TO9aMSQ3hE80Kg30YjS8iU4v3RZZzyiJe/6ZdGxFKm8wlCIBM
         yoIdNcCzgJo2UXzzLQeN/VEI/SmWtnJnaCdHDGXBhMbSzsFu1NivKxJsK3UXX8uanyAd
         fyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143229; x=1752748029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMrHrwj6C4PnAa1hwUllth+c9S0hJcOtmNg/4I4sqcg=;
        b=taIZQ46MgcGrpm9H3LS3NWH2iNNR9jhhUBx37hPO7DtvLHFOwZV3Ky1y2TvkDP95u/
         HdcmkhlDI13oN/u2/KrsXfuNAR+pddI4qVZ6zNhgHlTNW/L/m9YuupGfoW8B5lsJdRMj
         5NGN7UsAKT5M/a9H6L8BirwuzwZeeSonEZ8kp0AMVePmLK1unFD4sK3QoOdoFM/YSPbW
         umMqWDpmCORrc6DE/N5Kp19jb1flIp2OzihkZP6CSX+dyUPL1Qf53Hi8kNRp5L6QcTa7
         tOWRfxmSASCjfj2flD73ANWiuPR3ncqdXaia1kTzzZjVvoB3ZN0Tjoc51mAwoqdnFCnD
         lcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjdi/u4ez5wFXsOT+A4RHZWAZU5YFJqSJQzTN8o7nkxIbPhToWcMAvrWhfr6GMvBqgSozWoumxEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwetbpayNozIFEuatHuz4J+g8nKeqNfr8FYPlSW7DPNLLCYh0D4
	4+JvgvD6K2SNZS8B1K/OgCFPdfVZQ/1W9+XGw2OjXn1sLCvFVI6+G9Hn75GRrZNB0mY=
X-Gm-Gg: ASbGnctpxO6P2Br03QrbXtDP7Pd/r0RNeKcgy11YZ49Pu+dEj8lZU3OHmvH4/ck472c
	dbg5dis04JJlr8OSMFoH5fp1RatYk4odRSUeSHaYZTkgrca4HuN9QN9oyXq3fvXmA5QNAUGPcCJ
	lZIiBXGGUBeYXSrako/oP36Gak37iRh/1A0Dl5znHacsOEKeP9W6NsQmoCfUwZU03xQsev7k+Pq
	0UzV3IRxEwr4LvXWei1i5UVJdAGO2f9b5DTgmpNN7uEyGTHCj7wT/0lrDD1JnFMR3OF+16NqGsj
	AaDxWj0v8JgJiDs1W5NAIWHvffoBOt/Rdby2AtJ+SR4L3bRK2GMAs2C8w5VXwvmXHGfk1Lre
X-Google-Smtp-Source: AGHT+IEbwAYT58wBNJO6H6c+k8X2Vy8uQf5jbBswQDcyQ8gT0o6ph/EqrKs9YgCXi1YgCf3JOkjDxA==
X-Received: by 2002:a05:6512:2252:b0:553:341f:12a3 with SMTP id 2adb3069b0e04-55935b358d9mr704060e87.39.1752143228189;
        Thu, 10 Jul 2025 03:27:08 -0700 (PDT)
Received: from uffe-tuxpro14.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d315dsm321144e87.110.2025.07.10.03.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:27:07 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: power: Remove info about non-existing QoS interfaces
Date: Thu, 10 Jul 2025 12:26:56 +0200
Message-ID: <20250710102656.127654-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_latency_qos_add|remove_notifier() doesn't exist, hence let's drop the
documentation of them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/power/pm_qos_interface.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 69b0fe3e2542..5019c79c7710 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -52,13 +52,6 @@ int cpu_latency_qos_request_active(handle):
   Returns if the request is still active, i.e. it has not been removed from the
   CPU latency QoS list.
 
-int cpu_latency_qos_add_notifier(notifier):
-  Adds a notification callback function to the CPU latency QoS. The callback is
-  called when the aggregated value for the CPU latency QoS is changed.
-
-int cpu_latency_qos_remove_notifier(notifier):
-  Removes the notification callback function from the CPU latency QoS.
-
 
 From user space:
 
-- 
2.43.0


