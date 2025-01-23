Return-Path: <linux-pm+bounces-20841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C10A1A327
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E593AA461
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B620F996;
	Thu, 23 Jan 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlFARTKw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4920F98E
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632299; cv=none; b=JQUl5eOFSasqrJMbJbjZy7BV9PuogO8+KVkyJBcNVvy70LeKuupTdaemEfRDnqYh25eEL7Hx9A4DqsmlDiDn6WAOce6WtrPjnSMxS+7VsP2zENpesUMl/Vs0PJgaUjouVxuJiW8EnWQsQkizQsSH6JOLdUIwdl8vXuWStBQf7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632299; c=relaxed/simple;
	bh=pNTexRJWIf3fZZzwBCWXAepE4JkfhvFWKAeKA5yIT1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gExDZpnvLg/kzoyuh/BKOTepXo5YtcpNjUaVSPs12qhJZ1McszBrkPf1/vDObrA9zdfg705GeDIkiEkGZ2lTA71h/j11F9fZEyQGhcfaGOxQjUgmhlyaArjm/BSIuZ6BPVJPqBbMqA7+Q+JufMzO7JBQeNMz3aIcWIs0YQ1vbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LlFARTKw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216401de828so12336875ad.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632297; x=1738237097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSFP0rzuKci4fmBdM64F+0SOn2uhNTB/qBnSXaiAWeU=;
        b=LlFARTKw2bCU8Nz9btuFdYE8aPLkkphD+9xCG86/R5PQu8JseUObpnhI5TUIeyo1vs
         6W0fbQe4vyu+Zt+sPG5rUuXyCnivAXQPJHwQBsBM0RlUSlA/k9rGUiTcZpjUSsEeSRzg
         C8SCmlsWJWDgFeymvW9s3cVOHFQ9QjswQmWHdY8xYJpWq42CocGiuxZUwyCF8iA3W2e/
         AXP0pz9ybSTjObUkWJJf+1JA15Tsnfe5qCw9AWweHZv2OH+PvJTOOKgUUjGRD4sfD+MI
         pltWga1kZHwEO/SeAt7vXhBm5nNjidO4BMy+pv54L2QRXDi+nbr2+CjwLxonWamyh/9G
         4JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632297; x=1738237097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSFP0rzuKci4fmBdM64F+0SOn2uhNTB/qBnSXaiAWeU=;
        b=nPti3YB5CxbtLewbVLhb+hb6s6JSunn7JwM/uEZJiuD3s+sHUF7Bp/ANixZhIvVzWZ
         +iOpzHelzUwbF60VBkcm+KIMkMvmbAylSvNUfmdUD3D/r09XTh21GyMpIjcaTVn8f68V
         xOPzzWlnd9AWkWBDQ3pnyYU1Q6Tu0nt3JvziN2+EJyrBF9UFkn0OWs/si7ec+6pNFW+o
         0tnzhgdF6QnWy68h8SqTwNLfXezn0RGVyDRosxclTKGbPMpTgOpSJwWt2Onnbrpphpds
         BnZZbF5G8bWPSNjGVLGP8uNzQnkRkfftzMJLf5En4HBOlCBtfhRXYE1z7GDfE4dc+01g
         OYTw==
X-Gm-Message-State: AOJu0YwNO9TnWfBfggtomGSNlv4DbtIuYwlsQIE0vMzJkY+c5Qu6jpQU
	rrvZZ+KOwJfC2V00UIZ/dnWoLkV4/nKZgIHILjRTTMl0xOa+ZIULihidzynH0NMPE05qQvY7tMn
	e
X-Gm-Gg: ASbGncuTQAjReG3sMtcl7Ylip/8bWEm1gi356SoWPQcBYLAHqkrsanbf4JY6rrMYR6J
	nV3lodfLGW7Zkpeutj3ferQLJ69fDd+2ctAKKlbcLfIO6JW+efw1cpzsFSdVlGNWakyYate6GZt
	qU2WkVhTdpAyYy7KnDrPdGitjK5Z41BL1KH+EPO5uAhcNrDpqc4iS4xMKhBgoQmc2eTx5tkHD7l
	7Cwb72iihpACZkSqpp2nL0P+XFAJm+2o0JuxU1RvkF1wlHqbM+LKxa/fdjXC13exH130IZPT6PH
	Vzg90Dc=
X-Google-Smtp-Source: AGHT+IE5jdOmMEuUvJMGIentp08v5PmGBgmH8uckcFgvnSzhfckoJkoSjIBVmln4p0rR+rIkdNgFzg==
X-Received: by 2002:a17:903:1c7:b0:215:b75f:a18d with SMTP id d9443c01a7336-21c351bd440mr382125575ad.11.1737632297308;
        Thu, 23 Jan 2025 03:38:17 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3acf2csm110506705ad.121.2025.01.23.03.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:16 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/33] cpufreq: bmips: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:41 +0530
Message-Id: <b88de39b31fdb69f8b49bd4b7d5364a356ad58e0.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/bmips-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
index 17a4c174553d..36051880640b 100644
--- a/drivers/cpufreq/bmips-cpufreq.c
+++ b/drivers/cpufreq/bmips-cpufreq.c
@@ -150,7 +150,6 @@ static struct cpufreq_driver bmips_cpufreq_driver = {
 	.get		= bmips_cpufreq_get,
 	.init		= bmips_cpufreq_init,
 	.exit		= bmips_cpufreq_exit,
-	.attr		= cpufreq_generic_attr,
 	.name		= BMIPS_CPUFREQ_PREFIX,
 };
 
-- 
2.31.1.272.g89b43f80a514


