Return-Path: <linux-pm+bounces-27569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8878AAC2441
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E02BA231DD
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C42957DD;
	Fri, 23 May 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcySSXDa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12C2957A8
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007657; cv=none; b=M91c+HGy5SSF+AVfiqD6rfm3aMtzqKrfK0ePHc3fkCHfaEEDm1Yh9M24C8thnIGhA7NusbJ1k0cbuOu53izEwyIiJFELmamKITFQx+lDKfCh1Qbakg5Dhz0Kpa/9XjruhHL8geiRI1RsDhDXLVt0/A4FcQOO1es391+iAs4o0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007657; c=relaxed/simple;
	bh=eQFb13pt3SMV+zjHPOqe2QvR/SdOjsFXtEEtguGWM4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nN+Fns8JK6b2v8w8CtZx0TGbdRyunP2tS+KIbFSalHDCaUNxzEUuvsAxTzxwa1e+xHIPOnSr3dZg0bO2y5hWRVZImpy5gJUzkldpvmDLfPUNGtsDl8i38mfsu9LPc4fe5OD7CDefg64MYh+ORWCiDC25+TM/FLsvkGlOiU821MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vcySSXDa; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-551efd86048so7532967e87.3
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007654; x=1748612454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFJTs6Oe3tZDiqGEPhPZQpV8g2gqNJNZcx49AsG9G/8=;
        b=vcySSXDaEmyKLQNROiOx3LAt3/1GNq2ZFNmXBzxpqKjIfgJsR5X6CwRNO9ihMLUYET
         5PnEyQz5vRKUgHUBSfPSCahbh5xDMRvnGziVVZaGisT3z6M3r7QUmvel7WMxBBp+eX2J
         LBZqTLawK4mv55uOu1JLiiKz1q8ri6MRaQQdgUkEzTQxdWQjzrO97SNRHRnpYdy2d8ZG
         h+TEXhZKOwYMTXUe+blLQ44RgaGqFL1o3G1wX6qjWsD2C89j+22O+gdZfvlsY6L1nR0b
         Y8bPTZYgdy4e4QXUEHK/K0XaFj+Ur5wh2qw+c2IzbMzdT3QMIwj+XiC30n30LxdJnNAn
         LozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007654; x=1748612454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFJTs6Oe3tZDiqGEPhPZQpV8g2gqNJNZcx49AsG9G/8=;
        b=aG3KQ/95bLfJqv/Cgi8xVs0KDxYiJKAcPFQOUwVEccIOuwoZPeCPr8QXx0P3Es842r
         DvnKNBI5LzQy7VMce9oMXUythzCiVCZuzNu2qV6Z2a2uFvlz4RH+iIZYPP6vazquybjy
         qgjfnjeoujB+983tZEZ4UT/GLm51fOr7tsh+x1W4NapNRAISbyNW1TnFYYPC8BFe89cc
         pLueN8Vjh0ybC/FosIWxM57iQ8lsok/d55fm1BBcrrRbOdnRdcrBNFluolXwgE7Fi/qD
         7sL7OKJC4Qoi7NkaA/3bCnWa0lxe4Hw0169Nrgd+cbnHwaqk13r7S6PjDlhQcNHWVJGl
         HlIg==
X-Forwarded-Encrypted: i=1; AJvYcCX5pc2TSdIv9fsjTws7UnfaOW4m3PDIDTN5UG72Z79IoWVGkllejVKHTNQOQYiny7Yjz17/u4bL0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQh+ErBjN/jlH3KUsByzRj3sIeGySnyF2lQU4V9bep8993EVz
	3URcTmM03z1y/DPyYkrf5JozmMqWAG0vIOj0clZ09EWiOghFKYP3IkqeK+XP2BCrWCs=
X-Gm-Gg: ASbGncsGA4VdYS86jAxlj3/hloBsg4LWVadfHHI1A/ETMKumyUMaeY6jWZynWY+XkFH
	FFUrRP2aa0TAKTd8CR674aDKpmEsFsGCJYpbVPMrnl0Ay51emznowDWLMBLcXCInhOa1zxhtj4j
	yc225AgVQwkyra6tahDO9rlVnzggpgeDkCp3o+Bm+sJUT108pw8DDRbLDdkOsx3uBsnA0abEq4v
	3cOEM3K7RHId/zoQX0D55lQmN9GjuJ7yuDnVzfnfP/Em5cCCm90ryjmy08u9/XAJd8OV+BpEhuO
	8Kx7rNkXVLpat39iWqPvYsuLVN+bhqbeoz3fvO+k9yHJaBbrvJ+l7670xZyagmPZ+LEJa6uKJfd
	hqV+Au7kIYJdC+whLA8FoRf93sg==
X-Google-Smtp-Source: AGHT+IG9T3c3b5OoxUcS87R1wLRRFL3PdXpvlFYoXNj4F4WD4Ace3E+S/nh+np/agz5oYIx0/z8iEg==
X-Received: by 2002:a05:6512:6802:b0:549:5850:f275 with SMTP id 2adb3069b0e04-550e990904dmr8181500e87.50.1748007653840;
        Fri, 23 May 2025 06:40:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:53 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/21] pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
Date: Fri, 23 May 2025 15:40:06 +0200
Message-ID: <20250523134025.75130-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make sure genpd tries to power off unused PM domains, let's call
of_genpd_sync_state() from our own ->sync_state() callback.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/qcom/rpmpd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 0be6b3026e3a..833c46944600 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -1144,6 +1144,8 @@ static void rpmpd_sync_state(struct device *dev)
 	unsigned int i;
 	int ret;
 
+	of_genpd_sync_state(dev->of_node);
+
 	mutex_lock(&rpmpd_lock);
 	for (i = 0; i < desc->num_pds; i++) {
 		pd = rpmpds[i];
-- 
2.43.0


