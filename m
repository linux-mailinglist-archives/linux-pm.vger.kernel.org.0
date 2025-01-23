Return-Path: <linux-pm+bounces-20851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021CEA1A33F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BB53A54B0
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E888720F964;
	Thu, 23 Jan 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYxmbj96"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE42139B5
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632333; cv=none; b=OnYSPZQlRIFgrLRj8p48JHcMdqJuLWt3t23dC2VhGRXUJP9DE7pm6Vjcn54Qd3NCn6Iv4spiBiD5Kf5KZNeXvRwgTpDFxtBUgZ7IC+rk4b2D4c/e6/6f3mIk2coAV34xFu8maKw6JnlNZvPt6exlv+e0BSRVMC2y0o44NRMGHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632333; c=relaxed/simple;
	bh=igX5ZUgBwCdDAnj7x2Moq6k+WA2yw2v+2BGH2OQnJUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iESJRM01ITQafD4qW/veV3m46VXbSpiEguExWhGrnRFFPgx2MECmIi3n9P/BsucanobIuheLdeHqVcpDmPSpm8oPVqYh8nj3AOiAR0XeWjtBrV639A4XugwVkPHudy0BSGaXkWCaiiXlogbptdSreeFhUjgGlQFA2+sGnb5UTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EYxmbj96; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215770613dbso8686235ad.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632332; x=1738237132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjQgNBAFe49xaXae+rYQPhtfMBBIQd9+kyHPZESGBA0=;
        b=EYxmbj96rmhMrbBc29uqC9oECp7T0xnQfCLeAycuWyned002/xy37+bzKaWAxgqKQn
         gXifJkSeoWK8hDRE0zh80AEBL1a/fatR+mnaVv1JaZa+n/ybNxfI9am6zSho35MrD2n/
         qn/tMQMWrSG/rQYkvyU0X9sO+d3bh4DKjLYS+9FMXbjHxgejC1/1ixyGQODVvctKg3M1
         /BuPXxU0x+lm50ebnfzxvsJ5u917sE//PuqCZsVzuua8qmVnMrUvVBQj3+vXauAFjAIw
         An0Y/CfVntlCdHyYc7pF4a7ywFDRgn1gD2y6C4sym6i5hmHC19kdkwFRevh0qJAl8PSq
         xfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632332; x=1738237132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjQgNBAFe49xaXae+rYQPhtfMBBIQd9+kyHPZESGBA0=;
        b=iSLEb7kLOSBm6vhxufbka6uE/cAGRW5gW0AHEPgJhxh4xFm8cj9NYll2spaU7DhyqJ
         MYh+8AFGK3cwjUDxoZuCxmqxdAc43DwXpwK6YY7p39gri4kiRwJFhQuZhjkJYOETHuoZ
         A8dXCm59p7WdR2Gi75C5/9dYxIsps8pU6ArqKr4+ptKDtgpVlwx30NqkogMDmVB9/KfB
         CzER6FMbe6/gxyeQrD0Y3MSmSkdPmKI4mIB28qGpYyZvH98j1pp1ljdH/uyuYjYMCYAN
         Y8yxpyNqBHAocWViMXNBaB6OfFbwF/0G6lo661lkljHoMutLYO9gXJdstZvcKSZPMKhZ
         Yq8A==
X-Gm-Message-State: AOJu0YwdWhiIsNN5TYwF54k57lfwxSDmrcG5DdsDA4uAD2MDisye0h+/
	/zDtp9Q7k+2jNsTw9oNqPh+dXfoOjGfq8YFMs0hKk9yP6Sd5K30LvqQoxx8lGOA=
X-Gm-Gg: ASbGncvwKEO/125cicLEZiMnhZd1khZxRgprBJ/OPOCyvirpAgKntZp7RkxKfjRYjcF
	HV7ZLa7Gp/s48RhP2/ZHJtFEgiB5ukfRPr2HhG7wjA60bH6pGKZy3wSPLp0vH77OE4fN+gBgr7D
	6RdUredxmEO7QEghSX0bd+tXJ/IeKKuW9It2jsjJ4MFNCXObk1vd4K+n7aJJUIaCcQlTBvRW/9y
	nSV3gFPSCp/dgBSdorw0tBYUJStcvb/ZvdZITH28mnzPHypVJHh4PjYqQ/CRdr0Nx1AcVUGi6j8
	agRKe/8=
X-Google-Smtp-Source: AGHT+IFmHslrORl8iCSfMyQPeWS7T03UGbsvKy3s6/N5wWrGhzpF0qVtjOGI5Dkz5XcIfMQH+4A4Wg==
X-Received: by 2002:a05:6a20:432a:b0:1e1:dbfd:582b with SMTP id adf61e73a8af0-1eb21498454mr34159462637.15.1737632331808;
        Thu, 23 Jan 2025 03:38:51 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48cd0sm13058058b3a.131.2025.01.23.03.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:51 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/33] cpufreq: omap: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:51 +0530
Message-Id: <f5921d2d24bf616e16acfe7a47a0ea5be9e3c8ef.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/omap-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 106220c0fd11..bbb01d93b54b 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -147,7 +147,6 @@ static struct cpufreq_driver omap_driver = {
 	.exit		= omap_cpu_exit,
 	.register_em	= cpufreq_register_em_with_opp,
 	.name		= "omap",
-	.attr		= cpufreq_generic_attr,
 };
 
 static int omap_cpufreq_probe(struct platform_device *pdev)
-- 
2.31.1.272.g89b43f80a514


