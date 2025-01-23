Return-Path: <linux-pm+bounces-20856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B0CA1A349
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C3B1884B16
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800B215767;
	Thu, 23 Jan 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mgnyj5Hj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D52153F1
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632351; cv=none; b=taoSrVsvvyzUHEGkAnC3bmnmC+046w5/P2SgTER/T1DjjQtIU4ajVVDSVwfTZAJ3iHijuhp3A0BlcEUGYe17S2ilH+dQIN36dlELCGwH68TnPsgkFCFF/RQaRNaOBxu2s4oPv5DtFG1Ub4thqwgJJr6982U8ln27F8zuyy5uoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632351; c=relaxed/simple;
	bh=nBYWr6u0ZfDo3OuGnUqOwU6bkdCzsoe1frBrwoTxnF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+6A9K5pKRkezfxOJ7CGHn/lJOvsawF34dBx/5FCOrN3gsOpz1mxco9YQJ7RCq3h9NnPLzf1fSiEOOF4vrzb03yYYIKgx28wusa53w8ULF7XOypEWCLn1yIAVM514qh8fBDqgXHImi2muX83CePVhlFcFnuxzUMtD2CJ7me5HuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mgnyj5Hj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216634dd574so8750485ad.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632349; x=1738237149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOQaZrUykuIT2nDOu/hapfD8pr24HO9XboBFcdlFf5E=;
        b=Mgnyj5Hjegq1sjgvt7Oe77prbEQbucNRxGoZ8STlL8zQjBTknzCJcOVPApqSWCOF24
         W5LK3CFRByoUm7JQiCB9OSIVjK2jxNyVIxM8/zXgT57YxljA+FcC50g2VBmgMvkE7h1B
         FQtBx41886l4Ng30cxn3Fm8EePIvbvG0v/Jx+dW2Kmf90x9BZlJJfL1R1HUOglKb95l6
         ns88hhZMYuL8jEWdDZBIt+qXL4vc695Dn7W7sthJ1h2JXijCFT9/chDDePgZGoOBQphb
         21bS8pgLJ5zE5ET2ttjGEwtw/ULC4w/yMWENhS7bRSXnSlv/d3e/ZrMeJyHkAAZkT41/
         WweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632349; x=1738237149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOQaZrUykuIT2nDOu/hapfD8pr24HO9XboBFcdlFf5E=;
        b=LzWCOY1QQPom3gySeHaGINpsdxcPkoxUL1npgNktuFZL8D9Dxt3Gob6le+mRIGuQ1X
         SRYx0n3Ftp3f9nmJ2f76vKeXUDurJ63+9TDJnYRApdEc1CrZ+swaqFp+qqOceIWEP5ra
         TXnypD5Hed3C7YodaZ4nJTF0L19K7B6Qgf053EMhvQw1K21XTzSh0nYu9qQ7yEJ20IPf
         48LcRzDYFz1CwBS8EtjVVEq9yMaP2LRfQOS31ZxBcHvBH1CF0VHX4DrQq3j2ZoqrnDIj
         UkINl57BFKAXyuAyGzhGcZ9oOj5+8FGKPXjagIVlSY6CtYNYJ7XbxZNdxQC9ZymQwkqJ
         Fixg==
X-Gm-Message-State: AOJu0Yx89xUGONpGVitIakofy/X9nxb2jJbaOKL/jTdj6RTQRY/7QY+7
	FiDilhQRgaoaCfn1NNjP+QoeJze8d1l1GToUBNA1BTidE6SuHNMlgRky/WEUQDY=
X-Gm-Gg: ASbGncs71WuGKmzNh1Pqmdy2Bg4XhT7mljMi+kPaKObSxWdQ46ukkcztCuIYysaZtL6
	/enDrP5pc4KU6khEDDtwjnd26Qgt/Oka36r41LaEPuAwSgfCGonhqE0LaPf7hkAr+2IB/VCgyju
	ddg9ZFIl7EGtPmOHHCeJD+Z/oA12TKLSBxzi7kBhNgjpeElkKyJnZSs0dG3twtyKfGgPCfu1aUI
	RTHqIpeI6LA+THBq3ZNF+WGpMWIV1ubat1zuYqcRVYLUj4TGKF5hbiovNME7h1ovGUGjZ4ISfz7
	/7PuB+wqPGS6nV79Xw==
X-Google-Smtp-Source: AGHT+IHIGxlnIT9W1m1496ap5CdNvSqcyAIJOYfXO5RvLWjmiK3vtYAvEomKz83J4zLXKOM8QP8JXg==
X-Received: by 2002:a05:6a20:1596:b0:1e1:bdae:e058 with SMTP id adf61e73a8af0-1eb215ec58cmr42346024637.37.1737632349101;
        Thu, 23 Jan 2025 03:39:09 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa39c6sm12950387b3a.160.2025.01.23.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:08 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/33] cpufreq: powernv: Stop setting common freq attributes
Date: Thu, 23 Jan 2025 17:05:56 +0530
Message-Id: <1f5393d54b2c04206afefd521ebdf3fc03004a11.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this now, the driver can skip setting it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 8de759247771..0c3e907c58bc 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -388,9 +388,7 @@ static struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
 #define SCALING_BOOST_FREQS_ATTR_INDEX		2
 
 static struct freq_attr *powernv_cpu_freq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
 	&cpufreq_freq_attr_cpuinfo_nominal_freq,
-	&cpufreq_freq_attr_scaling_boost_freqs,
 	NULL,
 };
 
-- 
2.31.1.272.g89b43f80a514


