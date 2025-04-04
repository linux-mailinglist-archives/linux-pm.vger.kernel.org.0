Return-Path: <linux-pm+bounces-24824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF57A7C1B5
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCAD3B8D24
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 16:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F8820E007;
	Fri,  4 Apr 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+1nuHta"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0171EF370;
	Fri,  4 Apr 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785075; cv=none; b=NK3+4sK1z/ZR2c8ov59xZyWy1WMputFytJiRgpDb7ez0iGU11e93da+Sq2cml+RVdZTMyqG2VGh9urNdyHq3N5+JNADBGajUDrfBzoLobW4sqw8jt7atpl2uxQVlhUyAyQBdyyubJ46EB4hln3aGS1ADaV6MMvjwOn9KhrPw5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785075; c=relaxed/simple;
	bh=jd/7IZ1uZPU6UQm0EzVBwWHG9PUeSbDpdEAjlLYE5Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPW4IQnJZ0/VFjkj0NKVp5bWR0bLPMfJFMbPi5CNEfY8N4q42EzeOqy6JR367104O9YP8tLSgcuZ/VEePsm0bohk/kLPHXW2dGBR0BOzP4tICwnh8e8m6oP1eQt0wb07hkzmkwGuvEGRMOrbA0miUlUkW6QB4caeKvBBZXqxGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+1nuHta; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so1900186b3a.2;
        Fri, 04 Apr 2025 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743785074; x=1744389874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuDjKqU/zJ9aMgBXHX6eXeC15pS8mlcSXTl6w1NpC/w=;
        b=G+1nuHta7YhlpzffZBt1WK165DIWertm2+gUS9cDQq2sSY1F+Gs5kAUcvSoYkmKwiT
         6RyGq6NKUXBqPBdGBrsrB27DIj0yizYm8WAFQUWAosGOgrN9nt+BH3bJXIEenylVqM4X
         iZFSb/joTM30SGqyIyo6Lj7i3MlCyU95AJVsfeaktvc18S5iMbkf/XQGLXMVN9NJpzUF
         eWLA7bBT7UwwLzMrx79CSGRcn7N9JYIkOzV4YY1ulzpgzhEu2ZAIAjmFWV2hp1sxKHKI
         ReC7zzOyXsqdD95ipt16I0p0gDm+SXX2XtiV5lm/yH4+a0uGaEzSaj9kzkuIVkEUmwYv
         7W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785074; x=1744389874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuDjKqU/zJ9aMgBXHX6eXeC15pS8mlcSXTl6w1NpC/w=;
        b=cBAkKnoU90T3qt8RIz8DzTAVLRPBdb5I/VzviSpt9bQ3g3SpuuJiQfa79Qe1CcttNS
         tlTONfOOhcvivowRParMfsVMbDgVnXPtLQEI0FqFQ2J75at+N+FZz+QdSB3sJiQa0BjX
         /+KW0soYBQSYUgzq4X4vaPrrtbwgISBxVLmSo5L8GAajyC/CkDOyyF0/4/ByfeXYidEf
         nxR9OqW9/iDxVhqNoFqFHLAVD4PXQyHXleQysYhwJfdyNg/A47eLtv3ueS+0GCD4Po9f
         jx7RtxTD9GABEIMK4LY3zTrpGbAm1XFXurt+fbL15XcdtviGRJ+6UF5xRwB6s/HVoLuM
         W8EA==
X-Forwarded-Encrypted: i=1; AJvYcCVsk0WckLg7aHuADQL+wjdoTHuZOtZdoOF6KGZinIRAFP9BQ+KoPa+CEYSDIIu4gaIuNzgOQEf5nrk=@vger.kernel.org, AJvYcCWlLY2bQeeYwQ8Z34J1lW7Pu3ufb5kuE/5EtklTof5Pd3yvIHufaOMrHuCHyop5BIfiF10u9qo+UGyICc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGuDmSjs3ZnVQThSZNtntEgL1e+2iyaw4M6qVgY/jiFR7J6/m
	vPC1dG9c1+NFydUZPxfFaB1popOL4Uq09uthenFnp5heVA4dbMwe
X-Gm-Gg: ASbGncvQTXN+VY/MZIYHaXikNhK0DumxxmYkXghpdPhmjRaXP7umc7l/qWTAUm1EAaa
	AX/vP14uIU9S1fDyLO+zkU0EUP2dGX+3/E+/5CT/Lao+s0X+UvUirNYVS9Uq7HUFewRrQVTppw7
	0X2dxWDubnOYqfyX4WbiYSLJdeAxqfS8iUsNqhvl9j43zJJvBE3B9eKeN0xkbKlD1RywtLnhDrf
	OQDwPo/P/FqBhRkTia1TlgUWXtOB8qDY9crzwad8cVxAQOxz7lVWbjK+/GB4vO07kGQ7RuAbEsM
	L8gs5aMQcNqkjVdFYGPB1iIX0bhECz80e4D3icEVivQ=
X-Google-Smtp-Source: AGHT+IGA2+5a3BkHSLQ7fnrH0CvUccQdBM+8f757JwVDB2xJq2KAZWTALrj8BSSj5G/WcAs0lQvHgg==
X-Received: by 2002:a05:6a00:10d2:b0:739:4723:c4d7 with SMTP id d2e1a72fcca58-739e7142c56mr4155788b3a.22.1743785073708;
        Fri, 04 Apr 2025 09:44:33 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea093asm3710786b3a.102.2025.04.04.09.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 09:44:33 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pengyu Luo <mitltlatltl@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Add SM8650 to cpufreq-dt-platdev blocklist
Date: Sat,  5 Apr 2025 00:42:19 +0800
Message-ID: <20250404164219.166918-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SM8650 have already been supported by qcom-cpufreq-hw driver, but
never been added to cpufreq-dt-platdev. This makes noise

[    0.388525] cpufreq-dt cpufreq-dt: failed register driver: -17
[    0.388537] cpufreq-dt cpufreq-dt: probe with driver cpufreq-dt failed with error -17

So adding it to the cpufreq-dt-platdev driver's blocklist to fix it.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2aa00769c..a010da0f6 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -175,6 +175,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm8350", },
 	{ .compatible = "qcom,sm8450", },
 	{ .compatible = "qcom,sm8550", },
+	{ .compatible = "qcom,sm8650", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.49.0


