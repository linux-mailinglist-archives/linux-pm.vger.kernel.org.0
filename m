Return-Path: <linux-pm+bounces-14090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9AA9769A7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 14:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D3CB25361
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E821A42C0;
	Thu, 12 Sep 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X88/05e6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A31A0BFA;
	Thu, 12 Sep 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145592; cv=none; b=Pk8B+Cgn73N4y7Uw+k+P8jtEZ4dU2SEjKZScuyk4FvHfMOmklwBn4qHPCfd9IM4If95EGtrYAwPFs9BzbZnhOK0uE1irxEsec8mT8YzrDxQz8WUTLTn9wg9y/+an0l+fEVC8QH/IkdqnapgoBIrPEazGGfUZgiZiT7DtiOheEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145592; c=relaxed/simple;
	bh=VC7BSoXNLgSQgEMoDUEnlowTpaY1dtOnnAYVz/6VlWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4h3VYUhVarzpiKrVBjVLnn+o6VyFrZS6jhhSKsFyUGjY9gMJcLa2YpEdpnxH4KglRjPX59Vm7CAX9REghCPpMMRpG/o71ACgTBqKGefFy19RDf7ryVONJCHBjnIRpeR1xpxEhrZ8ZDc+oPUdavYdbbuN94CnptpU8awrKqK1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X88/05e6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so7484705e9.3;
        Thu, 12 Sep 2024 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726145588; x=1726750388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRV3JeZPMlo2rd2LhDPamjdsBHnBryS6wiApphTr87M=;
        b=X88/05e6dYUTXQe7FTIrkYv8+Lqacl04AtfcsK+kz6szHQ+mt60ZwBUp76i+gyzfAy
         tvqC780ZAJzsFLP2QN4YovzosbCsDVbJwAIYEIMy67Mand3udsJQDxdp3el2knr2pw7a
         Xe/Ye2oyGRyPrzqRZDNV0OSGWaIU0npRI0JoQxMG70WDabvmEHzrqtLNvmgKLxEVGF4s
         zYVIQvJzdrPX4ysacuV71Ukybd24ABPcumSNCpqRhzm8PIab3w6z0MIyvVgtqiQOM4kG
         z0bMQdfpVkRcM1vx2rIvbvmMyCT9FLvcU0fYHVXCVcMBsgVSUVX9jIZWmUTAIrgs8XmK
         QqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726145588; x=1726750388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRV3JeZPMlo2rd2LhDPamjdsBHnBryS6wiApphTr87M=;
        b=Rmx/mw4iBba/0+N0phCAsGvhgCcPpXOdcAyTicvXbWTy0D0+SwpfHEBY9fyD4jR70Y
         4NQvfyFDT17v8bIk2Ka5+C/jQ8TTh3ht2QuUXp+OEc5aSBAAvz6JbRG9sw4L/EhRzxoi
         Ee9Vm8OdkxLvd93fGfBMjqA1qXYaqIhNfEiFbiyxCyjWqatpH8/KmHbntZaeGa5DbFrG
         0cMckLSLcOIgCV5pOh3pyk+xE0+abAAKYLDhtSwUQc0Knqf8BIk+UGOQhs52QiT79yqs
         TEMQqhOr1qiXorrTdg8IivqOGivaOVoIxqpWSPnv8sYEfxJ0iGiFE5MAyeJP9FHamtLh
         FfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWNT4nMTUyNJoRv07FM9odPnj2nHZvZVmVcRuEceFoM7kflelT3vbuFWGpz0o+4tKUJTDOeOrEqA65eKo6@vger.kernel.org, AJvYcCWay+doQuIzhpAT1QnFnjqXyVe2s1lIbeOz+s3sObhHozU4WbT7LWPSdD7VKG3poDtsv7cHsiBpWbErVlSXjcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUiqgIq04U2wmf/tnaYSRK3yg2xfGgcqxx+7O26T6YzTYx71fM
	ByHvggamROq4OcJMh6N7ny1xV5n/nDS8V9BQ6lnoDPX12UbTT5vL
X-Google-Smtp-Source: AGHT+IFWw7o5Wcq89wSOXhtivCssyEbH4tqhg5lcaHIq3y7GNp22/Wfx+KnDNLGUn2oBZ6CVdMP2tA==
X-Received: by 2002:a05:600c:450a:b0:42c:b63e:fe8f with SMTP id 5b1f17b1804b1-42cdb547eaemr20493005e9.13.1726145587939;
        Thu, 12 Sep 2024 05:53:07 -0700 (PDT)
Received: from void.void ([141.226.9.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cae056541sm176176045e9.25.2024.09.12.05.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 05:53:07 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] power: supply: Fix a typo
Date: Thu, 12 Sep 2024 15:52:51 +0300
Message-ID: <20240912125303.44118-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/power/supply/adp5061.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index dac9875d993c..458fd3024373 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -590,7 +590,7 @@ static int adp5061_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		/*
 		 * This property is used to set the VWEAK threshold
-		 * bellow this value, weak charge mode is entered
+		 * below this value, weak charge mode is entered
 		 * above this value, fast chargerge mode is entered
 		 */
 		return adp5061_get_vweak_th(st, val);
-- 
2.46.0


