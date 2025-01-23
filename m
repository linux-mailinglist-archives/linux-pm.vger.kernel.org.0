Return-Path: <linux-pm+bounces-20858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00FA1A35C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A1A16C9DD
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C7215F56;
	Thu, 23 Jan 2025 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXmpZ6eQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4220F994
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632358; cv=none; b=JQziuc7+5ycd0dFj+f4F9e1tC+xzb9glwTnEUsUFchzMdME5c8hYDW5C1anPnd1PTGw6D9XolPAp8IDiWtQORidlbO8D+iPFEYtt2oW/hkuB/+ipagrPPAhy3ti0N/T10/JPlK1G6dDoAq2k6KKiXg9wnjJZJoV9m1U868mCjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632358; c=relaxed/simple;
	bh=feCbCIcFx3cOhmMWRrLjYWMUrTUQrRROQKIptj7tDMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hpm/bJcAgXMRuOQMoIw6g6MWnql3TOlFHI2UagY8NpbQ/RALOprdM45oPfKuGWPx30EO4rYLKDpMecdV5vKfrMDrVGvrVPAs8iwu45OkDN3MAmRwtBaiv+ntGRFLNvBB2oDizpncsm2Odjx+4R6618qgEDKyZSntBLrFvkc0bsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXmpZ6eQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-219f8263ae0so14170635ad.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632356; x=1738237156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiUnW/A/sIuOYtot6QrMnnQMyB23bhvBzFaSXjZ6+H8=;
        b=zXmpZ6eQVfh9c9LoRCKrjdRhZpYX3CQIYuHQRPU/DiMnrMAL56uuYkFM+k1YQVInrT
         iVjH3fZk7gfnJqZAtQHxxOu/yezLInW0Uop7CcQCghV/VYKm0sgOo/0iXp1POXSsFPdU
         HoxWQkFJ6pnvP62nk2qmR90MJtF701SmDy/S6U6Bsp9Rmab9aaAJv6J+3g46ZYVSvhJo
         lyiM16M7NLeJlf5typX0QABLpJ99UbsFVOvN8N13pGc2O8AYVHlwolkQb+grrUNN8nzs
         o+5llnwqrSrM2nsDh3fPwWnG1bOj0MI5RFu3PbiL4TT1x+kap0YVZTrSy91EO1TEUe4R
         WcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632356; x=1738237156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiUnW/A/sIuOYtot6QrMnnQMyB23bhvBzFaSXjZ6+H8=;
        b=hG3vifFred4lve7H9Ryp2SQ/wXUfAmVP+RdxWnRdQ7p3CmdcK6fs38z4vC72U94W7e
         QIWMhFz09W/ZS7d3ZBIMPTeqX/T5YEnH0gAvCDRwYWk+3Ldl7hK1DRgYP0XOoXntOcIs
         TzMqG+fs5swAUArqJ9Z04GE99OzRDpB350dmeG0FIsuZyA22RJ/BlNroFmxYxDtaNgeh
         bKcJhgO5ZBk9vMXUnkSco+siV5yw7jY90NXTGbCocKSgviHerHtZ0NFlDStG/wBO26Tz
         mMwwC7jo/h7g31aq539PCGJuXRrJiFKH+JTP/Mdx+Dl5Ojz0Fw8tyYd5DdmFSS3MhcmZ
         1bpg==
X-Gm-Message-State: AOJu0YxfvKynZpSQcyb0rkcUBghRuZ7eNM1/VjuvdrzQ0TeM/5WkYtqB
	1wR7DBXSyZXSGpzBhMU3XYEBvS+cqL2I66aLfrflL4XOx043+A24AmGzvOOOpsg=
X-Gm-Gg: ASbGncvGMqnIHKsHHeTYCwMfBKdQqt5AhGDx0kNqCRUaJEzB5LhaSUA5VQfRKNEcnAt
	yeLCmxEnd2p0Zwls6OarKwLe+If82F/th7nNU9CWxa8V5Z6keTzPvbqTxfbf/wxdnw+gwPGVrzb
	iCaLFWYrmTPgPzCrb0P9qyiFvh/Lk4ER1+Gk4coQsIdcmxeMrzIQMuaO5mYbSIh9zumOMpZSpyw
	yXcu+P58oURWGG/omb8h+uoCwD1wc3iKpHHUagu4HgVjBWWGZATFgCW/UMsoS8isDX0BpTw/EvZ
	TKWc+8s=
X-Google-Smtp-Source: AGHT+IHsz/dPNZuGemgfxRCMc7Wv+q1opoL1kPmm83F9upPwA6huOYPB4w5KEgeEmi3wQhmJChOggw==
X-Received: by 2002:a05:6a20:9185:b0:1ea:e93d:7574 with SMTP id adf61e73a8af0-1eb214c97a5mr42403278637.18.1737632355847;
        Thu, 23 Jan 2025 03:39:15 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa8948sm12851228b3a.164.2025.01.23.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:15 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 22/33] cpufreq: qoriq: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:58 +0530
Message-Id: <f9ba40332495d6966ed774dbe0e5e3157a8ec12f.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/qoriq-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index a37ce051236c..8d1f5ac59132 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -254,7 +254,6 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qoriq_cpufreq_target,
 	.get		= cpufreq_generic_get,
-	.attr		= cpufreq_generic_attr,
 };
 
 static const struct of_device_id qoriq_cpufreq_blacklist[] = {
-- 
2.31.1.272.g89b43f80a514


