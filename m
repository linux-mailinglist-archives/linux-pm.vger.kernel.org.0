Return-Path: <linux-pm+bounces-20861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6F2A1A363
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D443AFF72
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5C21661E;
	Thu, 23 Jan 2025 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpdX5lel"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB821660E
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632368; cv=none; b=IOoaF5y25+5wktclwr6V5jTWshTUxJIKAgVmBhcdbTZODEMIvmGsMayWsUsSdow6zVekOekYVpRzTsXic21yemzRLiSoObn6+9h2y57iR8AwgozYGwhhnqx2SZorIM/oDXDoefguRA+EseyveX23CbLsh3vxHVV5AUeX/vtBpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632368; c=relaxed/simple;
	bh=ISnDu8HFa/lMeUi1aSqC0GPxgTXvokFOJYnohLySKhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZIsIo17ez9xEYas2lVAWufXZQppTnlIkkknscgDLOtmWHH86Oo513rYcrSdcKo0Javy5aUWNGlkUVyhvnuwTzNF50FkqKL4OT6NnpSGdJ+dksGvrO/mvvjpShU9cJEPNqHV/greqnDguLbHXX/aNy9GcXcu33j8xPMWb9IBVwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FpdX5lel; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso1143095a91.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632366; x=1738237166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bidGXEhWbEsWi+5Sth126LejibvpIMLA/P72ifY2Y/8=;
        b=FpdX5lelOIK58W32hV07DR31kCXPX10mFmUBXsJNAwfuNczwYakcwz8HSyKh250Atg
         lZixakHB/OPPq+YETzH4NbGs+WhgkpxVnRPpsunvWX598FikNYVX3vjs+T8x9nMPc6uW
         It/UrvBtmUp35CldDl4eMZ0FNuynFiX4vIjaR58unop7kVf41n30MYtd6eyuth+vMkLW
         1hFGCv+Go5/uKugpf7Q6AuVoZWj+aYTuO2dnrESFC3w/1IR3muynkJ57Lskhq/e5dJNz
         XqICDzRpjMNQaHdu0C4ezzEtN/9BHPGZzATL14+HHikgcxjVeieLyiCwLoflttU6pGft
         14TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632366; x=1738237166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bidGXEhWbEsWi+5Sth126LejibvpIMLA/P72ifY2Y/8=;
        b=JgkCUcn+iKRwFjJFyXcuPb0agi9UvZ7J9qabU3YjQ0Rq5/Uw62padnB9//2QU6Ez64
         eyqcd2iEtII6aWnsn66eEx46CKEaSFqgCObIc20kj9amsym639Sp8Nr7kN4P14Fwgomz
         X20lmrXyDlHHQL+zeA82E4Vd0n7yGUqoy+74RyzJ1Y6oxjbqNxsYse8fIvsHprjSVrxG
         QNpIvd70J3uIAsyTnHuiYwiF6F+6LNi3or7q3iZ1X+tQ/0z1e8xvi//zjEc6zxSBXDUi
         tIkR4uBnMFqooxht01gjv0/pIB93hlYLqcgqlbR/2+PTlJKc3pPZJ7frxjf37uiIzw3N
         Tzdw==
X-Gm-Message-State: AOJu0YyS4fcOJzD/NfXwW74fffCJ9Qrg5EuLD5JpPLtOs2KPXoEUEwoZ
	sFsT3tMf687s/U1hWQrKK54n/yANayCPLIn9O6NtI5Fo+NHRzapfGYhPidsPxZWQSwn6aMW4vaY
	u
X-Gm-Gg: ASbGncv8IdV86AuozmqKdVQqQyvFVAdckqQ54VazYFS04v5E3uw8qQPBoaehozOhW2F
	96636BGtN2Hp2IR7FXvj2eA0Ps2HRPidQDa2wjn1nxcpkJWyVqkV3t91zR/sTYXn01ld++1ybkH
	LDZauhxpxvRFQh/7v0QmjWcRP+5uj70SNncDxGMVjNFOpFvR7TBzL72egSqJlPnS9eKuV5Z0ENm
	dFFBylhccZbUX9WEQmc56MnKHeri0Xa6p4MCiVPrQRA3XKH+uls/n1CtZvTo/CO98nAQYA+r78/
	FUmz4uA=
X-Google-Smtp-Source: AGHT+IHMoaj306mgy718YKGGZ2ZKiv1T27I/McQDNCDh5aizBvwSBcMBEOMZ/suJHkPkfqgWyPwUEA==
X-Received: by 2002:a17:90b:37ce:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2f782d6f0b9mr39599393a91.33.1737632365880;
        Thu, 23 Jan 2025 03:39:25 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd309d91sm12546450a12.48.2025.01.23.03.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:25 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 25/33] cpufreq: scpi: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:06:01 +0530
Message-Id: <2b89078adc1472d5ab9377ad7675cf4c07a8f7cc.1737631669.git.viresh.kumar@linaro.org>
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

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scpi-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index cd89c1b9832c..54574978986c 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -183,7 +183,6 @@ static struct cpufreq_driver scpi_cpufreq_driver = {
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.attr	= cpufreq_generic_attr,
 	.get	= scpi_cpufreq_get_rate,
 	.init	= scpi_cpufreq_init,
 	.exit	= scpi_cpufreq_exit,
-- 
2.31.1.272.g89b43f80a514


