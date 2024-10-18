Return-Path: <linux-pm+bounces-15916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0029A3519
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFC51F215F2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E004E17BB34;
	Fri, 18 Oct 2024 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j9s2LE4d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4B20E30C
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231661; cv=none; b=pvXj6gV5G4zNA3ubKh3TMMvyO0qQgHDAtjLZAWLOweXfZ/xizHOEpZLQWerTx2ZyLIfQBkvw2lnzolN8o/hY2CHnK8Xf0B3iGej8lEaShh9jlDkZ9ppWdqD1D1SDfUXfP4R2GbfgufOd6uT3PkEOq9iUFFdTu+Mqrf8iLfvXP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231661; c=relaxed/simple;
	bh=qx8oTXUXtYli7sWJmWyke/yTU53z4iBIbZPNVW4VM3o=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=cnFpA4ywCpnrUYilYMhFzyid/q12N86yubLweg4QpYCaBKp4Zac8CSYSQCctfWqRGGFsasjxxIHi9bcsGXuCDFnvPBjYC5Eqko/Amcq4FVVHhfVDlqOmMEV6X5rTIi3CAeG19148FLDGDskaBJW/nrUnWAwDdhmx+3kVy+E015g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=j9s2LE4d; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d461162b8so1155678f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 23:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729231658; x=1729836458; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+neT5OpriWjps6KWJbIFkh/0/1ZoC1TLK72bxGIagaY=;
        b=j9s2LE4dDJFykp3jRtgvFUDfut9UHJrGZl9HPC0MG/CJcSD8UNNQ1FL51y/H2lbnzK
         JqR+LEuDVedfegvGH3bMcHmjZh0fO1SPUnltwKDCEwbCDklmbb/My36auSJPl2C795gI
         mmp2WJy8Ealj4tsJJ6RfJ1m8Y9CMGxZ3A5Y7Ii2IwuAjETbASfxMNLrib25iMUkmv8fV
         L+AHtR5nKg0mX0CJmcQXQmVjAV8nCm3ZNi4RWQV4D4bGEox1SJ7WK7QW0wtxBHj8MefP
         2D6yw34yrUc4bGcR+LaMzoUfAIBBYx4SITSHxWGaDYAylzUN4cfLwu4RGllBsN91hMet
         T7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729231658; x=1729836458;
        h=mime-version:message-id:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+neT5OpriWjps6KWJbIFkh/0/1ZoC1TLK72bxGIagaY=;
        b=hKPDGdPVMgMawmMuB8oTuNzZ4ojUUnebsX5H+nkYz5YSs6lJGbhISPL4ZNAooLjws9
         vNCr+G9y41ZiyYATpJj9+3Xm282iYtHHx7LZV4K4gAVEQO4d7oCSNY7FrHQ1gFAWe3Uc
         j5Ip0OiLSCDvaiFMOQ+LnFK00pyUSstL7DfrWsB6g+x0ME7PThhuKBoUeGnPZ3Co3IMM
         B3p0bJTKiPn/xW52zsBwiubIDqu7QL6kpdn2em0GGj1oQpdE/+XOgzUaoqDxT3LRyHf8
         lwTt260zXKsPOi6jY5WcgbNWSeYVsRssnE5lf0LpRYA1XIxvPNcE9MZF3OhnqJqD91EO
         6zwg==
X-Gm-Message-State: AOJu0Yy5QYPhLwK2UMemeStFQ3Uq3QLQLc4jgJ3FJkuOMZnl6OzasQwi
	9sxQuCziP86Rt43QtDE/yzmEI//cd5DD4qMtQBk/LhG9TDmsOw/cX9Qvbw==
X-Google-Smtp-Source: AGHT+IHpl5/hGJVbSRbu76Pbt3D3nd73JqcA+FmPyiKSp7+epboy3/jCCcWZ7Z8yarGgtxPGKIKaRg==
X-Received: by 2002:a5d:5e10:0:b0:37e:d2b7:acd5 with SMTP id ffacd0b85a97d-37ed2b7afc9mr104331f8f.8.1729231657902;
        Thu, 17 Oct 2024 23:07:37 -0700 (PDT)
Received: from ada ([2a00:23c6:7616:8b01:c50d:30d2:69a0:7638])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf046bdfsm981043f8f.31.2024.10.17.23.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 23:07:37 -0700 (PDT)
Date: Fri, 18 Oct 2024 07:07:30 +0100
From: Ed Robbins <edd.robbins@googlemail.com>
Subject: [PATCH] pmu_battery: Set power supply type to BATTERY
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <IOFJLS.120OJ5KJG9R72@googlemail.com>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

If the power supply type is not set it defaults to "Unknown" and upower
does not recognise it. In turn battery monitor applications do not see a
battery. Setting to POWER_SUPPLY_TYPE_BATTERY fixes this.

Signed-off-by: Ed Robbins <edd.robbins@gmail.com>
---
 drivers/power/supply/pmu_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/pmu_battery.c 
b/drivers/power/supply/pmu_battery.c
index eaab7500d9..ed83c5e05c 100644
--- a/drivers/power/supply/pmu_battery.c
+++ b/drivers/power/supply/pmu_battery.c
@@ -170,6 +170,7 @@ static int __init pmu_bat_init(void)
 		pbat->bat_desc.properties = pmu_bat_props;
 		pbat->bat_desc.num_properties = ARRAY_SIZE(pmu_bat_props);
 		pbat->bat_desc.get_property = pmu_bat_get_property;
+		pbat->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 		pbat->pbi = &pmu_batteries[i];
 		psy_cfg.drv_data = pbat;

-- 
2.34.1




