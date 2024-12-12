Return-Path: <linux-pm+bounces-19104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5E99EDFE2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9365281E77
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE57206294;
	Thu, 12 Dec 2024 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsvGrCWO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F6206273;
	Thu, 12 Dec 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987101; cv=none; b=MEIw9YKov+/VJBzWzVHF7irj1/2AnKckuIePnLAACzky7LxKhj5YXQI1vOEYq7ZRrdmq0IYN9julOc0chGlMSmDRGpjVEv/9FzyCma3PdZWQBQE8LeZdYWr7OsSQ4GPI836DExg+hVv8K77NfpFqQx6iz1UArKgEZzY2jei+qpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987101; c=relaxed/simple;
	bh=yE0aQpLH/1FOUdWsRUbN03Tzw84skMe8N0rw7qw0z1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk2zs+9qxf0PAC5klaBZEXPkOoJ6ew8AOo75rDVUaiBAjWd7a+FeLCkS0tk970Prmy4xKBeOwGP5zghdIw7PITOI35HjUL1NXFymCEayfMnMBKsIpH9HcKXgGdBD5yodlGV4ADfzpdykF2XETOLhbNtnsN5MbbpCjRItuF/37dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsvGrCWO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728e81257bfso220358b3a.2;
        Wed, 11 Dec 2024 23:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987099; x=1734591899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+xNT9o8scJSCGD7/hX9myZPXhoesiiISnOX8ftRSxw=;
        b=PsvGrCWOM+koJ5jtRXUbwVD60HIWVOjTexVje1MaHTCBa/H/rBs+Y2h6b66CkovtA9
         8V8PHMYtVLQhinydEhWJahXGIx6EvdwrIZCWxiCh0zXWUN+yOyWmw+zSKDIOVhfVh8O3
         26rAxC+ydWgFZzd88bnLjMaPO5e0a6dlIAKE8tHmoDQ0ui3azNzMsuqSoYYI6fD4NsyS
         nll+/Zl2M1j9XRmcFb4vLt6DXDlF8wYaN8rk10/qUyJGANmp+pUZ1uNnCatjgB5AhtbU
         b8jwnU8ma5SlJH5GpsCzFELK1XIxvLFgYB2Vv4rAGkIx9yBXcu0TBOcjnNGyOx9wSPD6
         BBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987099; x=1734591899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+xNT9o8scJSCGD7/hX9myZPXhoesiiISnOX8ftRSxw=;
        b=N0Jaoy+JiElikkoJ9SOHF6gaYkyu/kHUHQDQgKwcyT2jiiXq0Yv0e8NRa3fuAteVrJ
         zxFdlD1oAgf6pMpAUXht521c7JpnWLHOsts0uwn7mVpwLeQvzVWDnxvmwGzVyLE6C9Cf
         tZoNIbtV+hpcdc2k8zyy2SFKsEwGtNQImZaVYk5PubIIGjQxjwqDe/0UyusdkH6Rx2QB
         RhpQIYaxBa4cTQSvc7TDTkBSs1wEgicmiNGVvP65WetlvaD/m0zsV3AUrWFfUukst9B7
         hbdbU36d12NgZkb+IpL5QQjxfciHK9dj0PSd1wMV9+t12IRV3kIQ0TJhUm5m/HPsCQ/7
         6yBA==
X-Forwarded-Encrypted: i=1; AJvYcCUNegh3j3N/3jvgYautehiaK5txkBiHrmxORu7XahKei7cwpEd+w1k3gX1yH9FAO67kgdem6IyMSD+D@vger.kernel.org, AJvYcCUj2yyhz/3shSi1Wo8AU1NcQucHkYkhkyK22Uzu+/PptBW6QWLBz87uko0g8WerjdWYZymFgvKUAcI=@vger.kernel.org, AJvYcCWjwtSZl5XbbGCQMo7Jbumxxhw5MCaMO15b8G9Wl4qhu7vrdREptCdTLjai3sX1DZ9QeWj/zL1IiKHqK9Kt@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcGtriwEfW4g0fRGy6cZZdqJlWHO9H3nJY9fWnL2JWCWxi/xL
	SfnWEaAs5psJNIGSy2vETiz9gTGULcUqqgt6sAtCh4C+ro+3tDbUyIi2A1qu
X-Gm-Gg: ASbGncvVNG2X3RmfCX/GhnI8xAuBw1TyHZWwIwdo3B6q3x4r35Lo1WO/jyU6Sm+I4Eb
	649F9Y8HUqIQOCuODiHng6EAnILqiRJr9NBIH4Fc5FUc8x6k+A0eiL4ok4H3JPZHuCQDkVFrGPb
	uTtwYUE4fRfeR0oLHr1Y9EG875vZhPsQsDg/5LXKz5n58zYABQFbg3rOYz4NOVz61B7Poyi9yws
	Cpvo1LrkYhrxuDo2Y/Iiy4S8orxzcx8kgVLsDTOKrJWDqs65yONXCEmNAxlJTXLUaXA/U5z
X-Google-Smtp-Source: AGHT+IEWZFABNU2cmsx9g4Vfkxtd5tDRV33KNAhW9o7B+oCf+G6xKL0qxxHdO05yjrF+abxzB9dUcw==
X-Received: by 2002:a05:6a21:398f:b0:1e1:b12e:edb8 with SMTP id adf61e73a8af0-1e1cebb7f15mr3582956637.30.1733987099042;
        Wed, 11 Dec 2024 23:04:59 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725ee10f928sm6519386b3a.32.2024.12.11.23.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:04:58 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>,
	Linux power management <linux-pm@vger.kernel.org>,
	Devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 6/7] cpufreq: apple-soc: Set fallback transition latency to APPLE_DVFS_TRANSITION_TIMEOUT
Date: Thu, 12 Dec 2024 15:03:05 +0800
Message-ID: <20241212070344.3858-7-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212070344.3858-1-towinchenmi@gmail.com>
References: <20241212070344.3858-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver already assumes transitions will not take longer than
APPLE_DVFS_TRANSITION_TIMEOUT in apple_soc_cpufreq_set_target(), so it
makes little sense to set CPUFREQ_ETERNAL as the transition latency
when the transistion latency is not given by the opp-table.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 94e57f055a5f..c9f31a3653e2 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -291,7 +291,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 
 	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
 	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = APPLE_DVFS_TRANSITION_TIMEOUT * 1000;
 
 	policy->cpuinfo.transition_latency = transition_latency;
 	policy->dvfs_possible_from_any_cpu = true;
-- 
2.47.1


