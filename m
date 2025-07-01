Return-Path: <linux-pm+bounces-29944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFE8AF0693
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 00:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351633B1D9D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1621302CA4;
	Tue,  1 Jul 2025 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D76sgXXG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E5D2FE365
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751409007; cv=none; b=gW8vDn9m9wCgB+6ftp4peIkakPjoDoCzSb/XMe3zdbzn8WzfLDEnwA7FSKjv3olF7u0eQe+G9LPgrT2QT38KRYUM3l3dRZVdRq0oERAIegRlc/jdIRqFViiZz8+fcn3ReVJj5nMxUnO6BG0gZEthLGp0ruRtpVCH3J/7W4IOfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751409007; c=relaxed/simple;
	bh=3JrBXH7Zk+tWwvjkRUHmx/6T/vrRcj5uCGINdZkPoik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=byQzoYM/+vDaa9VNVZFddqOqiWtseG14h1R+Co687RKZFf9KdJW6hQoJ2I1qwfHtDRyjQ4SLTo+X7v+eUV2Zu2uE+5AAweIqUFKYdefd3sj2zlFGQ5yKyijLY6jJcHUqgpTruK5DTXn9k+4v837lMLnfaIuwtqxigYX3fQ5VmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D76sgXXG; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2ea080f900cso1071151fac.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751409004; x=1752013804; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Etb4UD6KqWxQem0MdhNJMYQBBrscnivKN90g3gZa3fM=;
        b=D76sgXXG06wExVnxqSdQNW6uxmpBLeMCIpz4WUifeaFnKAJPJ6O9Ma48gRblbpqY5x
         J2pBiQVKbKJCCOM/skV5Knq0ajni/ANA/GnxQFmE3zFlIdf5y4HMwSJrY5qGKRUQurez
         bXf/clrlEUjZRXlgBsGNEwpbWXup1cvA41zOA8/Tv6hUqeNZmnb3qaKJ+zP9wCBqsbeK
         sNSvz0s86TRw9YA4Koiqe4/lSCRfPt/j4AbMKlhxArWHmXmJLvFBE/HZWTFg40qjcFlP
         5KFH2aU3V01LmciJw00UYQF8BjKHOL2NzKSpQ9oSLlHiqpU6O7GnuKfp2tdIGrRCkBSb
         2D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751409004; x=1752013804;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Etb4UD6KqWxQem0MdhNJMYQBBrscnivKN90g3gZa3fM=;
        b=XcpEVoVcw8oWfj3c3cynv3HA/SfMiEg37jtAjWjafuyMFNJxm2SRiLOFbyjdt0YyKp
         MLNoE/2Lk5RYYi6AnBIDD1ugisitZZbSD6xSelNsjYf1ELRXAYlEaO11r7t5AoGKPqja
         rviO4DNj63uCC7Tit0XSfifkGsEb33RaZQQ/d59POhUA4qypw79g3UbJMuEB7xam6fZl
         /bQgOsHB/gB8UQuUHCjpxIfuueaWZPtKoCIBdBAlfdIdYBIjWX6eQjop8MYVuJYUD+K7
         v4/QunR3RHvljsiNhS/bUnGcliWBlX30k4jQDorQMnFjoa9/HzNFXFl0+6aAjNWbW/Dc
         sp4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJA7kYAK9IH2yrFafu0ufB8wvQruOxEev3oX1NoqLcrtBTocSn643AAqo62a8/c4KXZBzMJgWyZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+s42KIGDWNbuQQrVYV2bLqwkjZ1ci30fgTW9UKVEg22+Zw8gB
	APOoGb5tLHFegXSG9xI0P72VnDC6ZyGLJy3R+E4gfSboDUWwYzmkJ/rSj2YrAvv6UB/BTVRjYXd
	bGqZLK/k=
X-Gm-Gg: ASbGncso5Kzr2jQgDMs4zqdSvtebmlDY5J8oAPo8islsbISTOIarbG7SZ8itaet5HTJ
	uJQvvcyIrAEfNaFo37W93bxjk7tYc/senUcMufIkvIRc5DzfRusIWi/7y8wmuBobF17vTBIVx0Q
	oS9WYx3uj0HTuzz4572d61ske2JzPkvTXSEFf3CYw0WoqvhmfM7qdHAjUo2rJUP89JqCHCxOJEE
	H0drz6bs3eZiEi73Thy+TN/1/WKXK1yvY/Nq54vZiFm9TqCGliwnn2xhqfdINSZucWj9tZFXOyg
	v3Q5PnRglkO8oVMsqelSou51uEVkw7Lxdp3n++GBYdazWi1rXDyjRIybZrz1tUrsdI5CrA==
X-Google-Smtp-Source: AGHT+IGtlelvTdZBEfLOgu4yc8UC9jO/FagWLMwPc+EiONKKAYKCxJCDRSlYN5VFSZ2lgO/XNp9I/g==
X-Received: by 2002:a05:6870:b603:b0:2ef:14cc:caa8 with SMTP id 586e51a60fabf-2f5a8d1e8cfmr458910fac.3.1751409003574;
        Tue, 01 Jul 2025 15:30:03 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d663:8de8:cafb:14e3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd4f37065sm3517369fac.21.2025.07.01.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:30:03 -0700 (PDT)
Date: Tue, 1 Jul 2025 17:30:01 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cpufreq: armada-8k: Fix off by one in
 armada_8k_cpufreq_free_table()
Message-ID: <7ae149bf-5e4d-40df-b1c2-31d5ef418f05@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The freq_tables[] array has num_possible_cpus() elements so, to avoid an
out of bounds access, this loop should be capped at "< nb_cpus" instead
of "<= nb_cpus".  The freq_tables[] array is allocated in
armada_8k_cpufreq_init().

Cc: stable@vger.kernel.org
Fixes: f525a670533d ("cpufreq: ap806: add cpufreq driver for Armada 8K")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cpufreq/armada-8k-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 006f4c554dd7..d96c1718f7f8 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -103,7 +103,7 @@ static void armada_8k_cpufreq_free_table(struct freq_table *freq_tables)
 {
 	int opps_index, nb_cpus = num_possible_cpus();
 
-	for (opps_index = 0 ; opps_index <= nb_cpus; opps_index++) {
+	for (opps_index = 0 ; opps_index < nb_cpus; opps_index++) {
 		int i;
 
 		/* If cpu_dev is NULL then we reached the end of the array */
-- 
2.47.2


