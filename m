Return-Path: <linux-pm+bounces-6075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695189CF5E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA3F28495E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC01C0DE3;
	Tue,  9 Apr 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa9zwyxe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC515C9
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622708; cv=none; b=JjC2AmEIOq6Nmpx+D/zYUg+MgYLErnXfA/3m/3XSdNRF8HUFqxCONU7eoLAdImx/1NLMDSiw06g9Hqp59Pm6Lbx/WD2LzaWXPfc0eQjc57eITn9bkiEm8/SVdm+PylA1Hvoqu4vJC1R7Br3yVGKGBsQP1kjcrgBwhza2YFqoTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622708; c=relaxed/simple;
	bh=/BgxF6s3nLofgtY3DHafB2E+wInxdJO4ux1nu9Zhulw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXtqWGFSZFGas0gXzxJtenWuVLnWG1z1WOK8ukHpPEV4/K6ucYJMFQHAGutux2jDRFSkjqAcCfn09LjyZxzYtaVxf26dsyyd/GVDIB5JqNd/QHQC37Z+aMYFAO62LNFGbJaZdMVUdIGV1NpzHZ2KU4OvSWWF/OJFi8JHKjnpUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa9zwyxe; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso5289451276.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622706; x=1713227506; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3LKo4I7WBwf/SGHo1siPBYnhMRCO9+IAHitWocq890=;
        b=Qa9zwyxexZfy5rt3An9EjchGcj70CEVMorBptYYPmM8KydhL8SLbdGZ7Bb0pJL1yMd
         HpCaNxcDrpM504fDsZiA2kVX0FKuDtuHccwWcj4Ciliun9wBn6D35xH19pxSIMOkDJlL
         E4OSjB2Tj5TVrRmwMRrbzknVmq/8kdE8T+mCKfwF56+eQR5W1oULEglt+KpClJ+J9Ete
         m9X1vrC+RPFDwwg/kLkNEn9wNJTZuwDWxSXiZczUcchyx2x1nS7fMxz3YgaV712lZuZc
         Q4lCSXPxGEZewKt8+zge3JFuqHCHjQ0hZ1DtfD/hdFE+bO7obGIwf2amY6LVf5DMJeW+
         m4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622706; x=1713227506;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3LKo4I7WBwf/SGHo1siPBYnhMRCO9+IAHitWocq890=;
        b=LBfkf1hLa69FdKV8cBLqYiK8ukUnvBG0Px3Gko1G02DZIosc+mFfcRWhEwih96v+kL
         L8/eQAhD2ayDrsnHKU/j34np4DAkY/j+wmfwHm5bkU1mzRzWGoBsoHt8Y4zsB3jdE9nA
         5kLMmRZU0pA7SEM9f0VQGDFAIX0lJaXL8kYzRx7u6qFzGyIq4T/S+r9MATkI9BLgqm+i
         ZtSZk9nGoMP5kEEdSTNqN2rGLRtZ8CB4IOEHuv3PvneADO0VkjyvsQmK3oHct7Dh9qtN
         6QCTdNdu2iuDb3NMWRxCAhVwQ9Wsy4so69kf85LBhXZTLLPc1KK9JWTDJjN/NgBeOMsR
         hhzw==
X-Gm-Message-State: AOJu0YwzGRcJizq5j7iHQJ2JhuVluxfMAfHDKZjMpK3/cXhTgKr9wM7S
	BJKqWsGvu9awTepTdqvge88CoMG9RB25v9LIIUbDi3QU2EO8PET9nVvK4xV+
X-Google-Smtp-Source: AGHT+IErFwgMyq68QGYwlEwbyfGhHrNPjt/FCS0437JDOrcdiqLQIOe1FyrWV3r5NgEsXTHCcAnMFQ==
X-Received: by 2002:a25:ef04:0:b0:dd1:48cf:5c8 with SMTP id g4-20020a25ef04000000b00dd148cf05c8mr7409295ybd.2.1712622705714;
        Mon, 08 Apr 2024 17:31:45 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:45 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Peng Liu <liupeng17@lenovo.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 03/26] tools/power turbostat: Fix Bzy_MHz documentation typo
Date: Mon,  8 Apr 2024 20:30:57 -0400
Message-Id: <0b13410b52c4636aacb6964a4253a797c0fa0d16.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Peng Liu <liupeng17@lenovo.com>

The code calculates Bzy_MHz by multiplying TSC_delta * APERF_delta/MPERF_delta
The man page erroneously showed that TSC_delta was divided.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 8f08c3fd498d..1ba6340d3b3d 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -370,7 +370,7 @@ below the processor's base frequency.
 
 Busy% = MPERF_delta/TSC_delta
 
-Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
+Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
 
 Note that these calculations depend on TSC_delta, so they
 are not reliable during intervals when TSC_MHz is not running at the base frequency.
-- 
2.40.1


