Return-Path: <linux-pm+bounces-19727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63AF9FB8EF
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 04:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC19A7A1EEA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 03:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B530713D503;
	Tue, 24 Dec 2024 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="phazsKt/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933512033A
	for <linux-pm@vger.kernel.org>; Tue, 24 Dec 2024 03:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735010302; cv=none; b=uOemEZJ+mcZGC7llfM2GvGqLmlzijtcXTv9kKgxU/fCAZ2bEcez42jxtuJi4BWeL3uERnB6Bqq0AbI+8OQpsNonDJa3unrtoefLTMTMyO5IjdjL/Z8MhXznflzARCh8t40e/E2HIyOEHXJW5Ju+y1pCxN2GGSh8aWxHSEgn/mVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735010302; c=relaxed/simple;
	bh=OfsjJVgK9em8cjYrZ3+dtfveAcrJYo7TuggwqB0LOLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5S+/Zji2QX88V6ICUiWfU04Y0M1mi+e54HwwnM3TA54j8bF0s1I2p3a9Z5gHH2OHzsX/9HrkLxFsSBuS2xEgy4jfTgh8C8DeVF/UUyfZvR5YyoNHIVWXyxLWJ5ukQnkRHQdScCSYKcc4ZIG5nSc5tfMOK9kEzFDhInaXm4qhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=phazsKt/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21680814d42so43173155ad.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 19:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1735010300; x=1735615100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ufro+fKLLvwhe1NVSTgqrCf9LVTo38kWx0DzJX1hULc=;
        b=phazsKt/zjot08bzDDgywm369IdFZXZ439nLQM6DepNDKE+XQ/nsccg8bNV7fLabC6
         Yau61UNmvuNHt3KEAXjpfdtWaQe2nmBHV+aLMnjbfRjGHBDl9A0iTO2rCwTTao7o7k4D
         f69uZL2uM5opKFNIDIK1Ra/4U7EU2ieVfjqtMgA7mHlz+4T8EbGQIifVC23ubbx93n5N
         CMbbzbBBCx09bCEfi+rbV8VzDmtLB3aoWQZd2cM5aUhQIUtNIUuSCtdfey9csMCXoBz3
         KvuXcKBlFYHrvXrMHvcdJsAQ4IXK/db+0eUjyzV6GcjaqRjuFlgUW90yQAN3Jwnxtrt9
         xWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735010300; x=1735615100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ufro+fKLLvwhe1NVSTgqrCf9LVTo38kWx0DzJX1hULc=;
        b=m7U8iTakv5Ps12zU68oMSUWQrN9WtX8TO2ciKeq6+FrtibbICadGHIiAvnUaIF4KPG
         eaqATCJAYoOuesw6FhcxD1cpmvIxpTAYrRBiEYiuAcO6uGk+FrB17s3uugzQ/VRk1dsH
         3PReBAbeKVv3upntlKdgBHj4umhJdXtZWy6UzSHwmGRMZsZfiKLXwJop0WCtMOCFnaMS
         Xd8C2Thvwhxp5nyrK/Y7ZeXHaazzQpj+jXZK7Vp655yvzz83SCoUqdUDzGiWfu5SsOYC
         djs+xK+MoovhhU681+aB0Xv4xh7X0WmBDsmRoMi+j1Fg4JJ/xbz/mik8O/Uo6ey6d0d5
         LJkg==
X-Gm-Message-State: AOJu0YzTm5z54S+ynvR92yv6luqeaEyzuWXUvIxCkzTIj8HfXy7cZiWF
	0e8yiqWOcQ6xxaz/mqB1oMy/MY2+3re7UDu2gfZCKSJyUI3koWXBLgZCTwjihYc=
X-Gm-Gg: ASbGncu2IHnPPUDFpPCFC96Es9Bp7fWPbMZ/J1HhmEEBGiPQZZA4exRMRI0ZfmlIk4C
	7/wluj9tW3muNuHPdI2xaronryF2D2d9fGDuFNv+Gb6W0yhT6f03ohOYXRi/rD0CLUKf24ToNLl
	zMGG9SiDgrBx9gsnZKonJlR9flYvgG9CxAMdjwMfTJsoPyQMlDdn9ivuHRJHpofPPkx++JQQSln
	VRFatfVLMavwvyObi/BHbk3FRPXTuS6odMxomq0WCPsq1Opy7BZNkqKsri6h8V9CModoT0MNzLv
	ftScoaugj2o18gJPBv9j3q/IZyuvxeNLJxpKmuETkBE=
X-Google-Smtp-Source: AGHT+IFi3B/nR6ksFKM0mV0f/XAoqnVazGsNJJKo1+/qxEk6HQxlG/ufGSgzyhKjUZG851tdYAzWgA==
X-Received: by 2002:a05:6a00:44cb:b0:725:1d37:ebff with SMTP id d2e1a72fcca58-72abe0960c6mr21180746b3a.22.1735010299707;
        Mon, 23 Dec 2024 19:18:19 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb9c9sm8705672b3a.155.2024.12.23.19.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 19:18:19 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] thermal: of: fix OF node leak in of_thermal_zone_find()
Date: Tue, 24 Dec 2024 12:18:09 +0900
Message-Id: <20241224031809.950461-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_thermal_zone_find() calls of_parse_phandle_with_args(), but does not
release the OF node reference obtained by it. Therefore, add a
of_node_put() call when the call is successful.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/thermal/thermal_of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index fab11b98ca49..5ab4ce4daaeb 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -160,6 +160,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 				return ERR_PTR(ret);
 			}
 
+			of_node_put(sensor_specs.np);
 			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
 								  sensor_specs.args[0] : 0)) {
 				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, child);
-- 
2.34.1


