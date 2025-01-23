Return-Path: <linux-pm+bounces-20854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C4EA1A344
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931477A439B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BB0214A95;
	Thu, 23 Jan 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEX0CHpN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8A214A6E
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632344; cv=none; b=nuMbEMCt5vROwSdP43tgaufIjBM3xfipPxTwLxlAUCci9/VjiEV6uVzq2nRYUfv4HIOuTapdwg0tKdvZZdpzHHBYnstrAHbWaTq7judPE6Wqni2cINO4kUGCxXcOfMK0kSK4/XNH+69VYi1eOYxNI597OwELgFJ+QuG+8sa2nBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632344; c=relaxed/simple;
	bh=1TgBER8sFGZQgqK+x2ai4Zw+YEr6+EpZ4fRhfGjT9Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NuIspIo74Ls35CwKEfXq9RZgi8HHnayr6x+FW7n1mIFe53AVFGUmX2Qme1kaGXlEZ8v5Y4jd2G2I1gMpADnTm9UvdMSzgs8pyLfw+eFvdn1YzYAd1l1/UAe9hamcL0uvtcPI+zpWfI7w6FZDtGnaoRHp+dxfV1hTTLMJRYAlIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEX0CHpN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2163b0c09afso13602305ad.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632342; x=1738237142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfvCGCHZNCxyn69/UWRqVioH0Lp44Bh/3oJ9xo86mtE=;
        b=mEX0CHpN8f+5R+8BRYRQ4PeGF3Js/rDGTNSJ6BgdZXhJlaeaz8D3CVo8CrTyNY7OQB
         xQTjeZe3sL6lBU1kKaL6/DtWe1ds3MIgtkeqE1nyoT4epz6JxjCVYW6JKVemUvfLDQOr
         HSBMlFgfTmDNWR+QPyEbLznbQplX7YWRgjU7UtIe9nPu+5yD3RON0cV0tOQn8C2xdphg
         IQeL2WVtDK1BubUR0uhbbazSB87hjXiLFDpq3EQbH17k4+7Rx7CBSa4xnKHwQKyaOnso
         toJocC+3TJQZQkEuzmJ7JrBYslJVm9pGeE8HzyxD9nV3neNi7x4VHheWniFr4BtzzRh0
         hBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632342; x=1738237142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfvCGCHZNCxyn69/UWRqVioH0Lp44Bh/3oJ9xo86mtE=;
        b=Tc7boZHxSst1ZXmXEAnre0LL8pTzwP8amX3M4dNgIr1WKjpRk2SxNUqZsEMxz5+aeW
         PXwJ4IAm7lntLPA/xoDuSZCaRXy1lfzOxbWhtFaaQBCKQRlyonjotZAzBtLBdhiAqbSj
         H2jhBLKtbmZzV1G4MWnu0XhJVphEPks8ttjVJIJhv17yzHMfpGf46+MEjrb4h1Lj36oT
         tIOGT9FqM3eccL3pymkJmr5RUNyDgvhhTsscAj4IETwhZXzULSchw50UKF8fFG2VBpVz
         1H/88Yc6em/QNxROf74sx9/zLkJ1lK2GDqu50J3bOmS7h7jJHm+OMwZQ0CaQVdBBUtHZ
         YfAg==
X-Gm-Message-State: AOJu0YztfBzuDaTnZ4O7SZyLDLloMsZK8iL/pKzQaPaNIQte+Jwm5Amu
	3VkChDUV652+Ky3tgMwTTGTlzsz3ZdGqrb5Q/3jEFa4UXFw0nycL0OjsYs1Sk3A=
X-Gm-Gg: ASbGncvTq5aGd+BIaVjK+hp5VSiq7tBw6NQ8DrwjJ9dNelZBJtKMnuAaePteFc9EzV9
	WiaBmy3xyrkCXDEm+NMt8CyTAcVzNIeyJqKYA9v4Cs9DrpFbSrgHby/iac0x3q/oosykGVrvN+Y
	/Isn7Km+i4uXo92ftSS9ftMnyMLY/1ia7y8XE9giCgSskdNDqODDPYOPf/UMyJVz9kb4bGtHfdR
	kGvUKoxnCCybH1VU/IQksIrvvv5tyvm8a5MMatAgFm+3jBQvww1u9PjcRmBCmIqDkvfeYSt4swo
	f+434ec=
X-Google-Smtp-Source: AGHT+IFOTJp7fcVtErTm2ko8MfwAJVCJqrxtj35BJRTuPk8xc83dAT0RCHhiqJHyXYcuqQ3GU0FTBg==
X-Received: by 2002:a17:902:c943:b0:215:5bd8:9f92 with SMTP id d9443c01a7336-21c351d328amr426236855ad.5.1737632342032;
        Thu, 23 Jan 2025 03:39:02 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3deb6csm111272655ad.175.2025.01.23.03.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:01 -0800 (PST)
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
Subject: [PATCH 18/33] cpufreq: pmac: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:54 +0530
Message-Id: <d3e73fe309baf9c839d76a3c6dbc3abd3ba06746.1737631669.git.viresh.kumar@linaro.org>
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

The cpufreq core handles this for basic attributes now, the drivers can
skip setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pmac32-cpufreq.c | 1 -
 drivers/cpufreq/pmac64-cpufreq.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 6c9f0888a2a7..a22c22bd693a 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -439,7 +439,6 @@ static struct cpufreq_driver pmac_cpufreq_driver = {
 	.suspend	= pmac_cpufreq_suspend,
 	.resume		= pmac_cpufreq_resume,
 	.flags		= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
-	.attr		= cpufreq_generic_attr,
 	.name		= "powermac",
 };
 
diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 74ff6c47df29..80897ec8f00e 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -332,7 +332,6 @@ static struct cpufreq_driver g5_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= g5_cpufreq_target,
 	.get		= g5_cpufreq_get_speed,
-	.attr 		= cpufreq_generic_attr,
 };
 
 
-- 
2.31.1.272.g89b43f80a514


