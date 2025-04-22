Return-Path: <linux-pm+bounces-25884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D9A9651D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 11:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F214617958D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8EE20E703;
	Tue, 22 Apr 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9a9vsHB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA602036FA
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315646; cv=none; b=Oji7An6Tdg6CINqIPLVPf8szanYCpzhJlIoTbOQhKlaYG2ytZNQ1dsN7fj5Tq6ecbU9LzuUPIJbdImziHi0HuoV0G3ADyX/64Sp2bQXSQxE0KeYwKJcoOhuOYwf0GTkl0JR/LOmlLH9nkFNvdLojDPyfyYXAzQJwm+WlKlX5P9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315646; c=relaxed/simple;
	bh=egRR99i9nHWRLJSkLdIOmqIX1zLBqzvayXnVEdpZ92s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ifyArlwAOCK/VZj3M1PJgObSk4b+x3+kS7NrP7YWdWKTwsQLcpSdt16yEnVeo61SpanBj/W1IgjDsN9pg/fTgENLPizRCpp4rvCYBPCqaGHlkWsQfpWcS3DR2NXym5eiKM7Rfrr3MVCrCl7kJhbH9JCg4+M8cSZ3n1Hw0eJ9b9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l9a9vsHB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-aee773df955so4723265a12.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 02:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745315644; x=1745920444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iPZNfcaggW8uG4XfjMHFTZr4Y8+XA41YuZRRPWh0lH0=;
        b=l9a9vsHBElBpk7f9N47KZ/b8UBTiLIrRttfW4lCISTz02sXkE0vrYFxRtkVKCzZte1
         7xUdMB1oJQGzbtFY9bIhhB9p2wRwlwDi393ec03iqfkdJLWM67RRjxszDk0zo7WHeu1m
         +d3Of0ugO7UULMP1sxfvKoKvEzJehKUfS2HhXKxs37SdEnhjpJ9HOhUymvsajY5ocXBI
         smqppvIO9ErQjHRlZFwClTFYs9PPyNaq4rDm6Ja8uaaS+i3cx1wYG4x+PbV7rHyBspdO
         5Bv9xLp3wU7Gu2WUUCJlGnq8b5CTiAxJOEhQkLmOkmPDBuVNkJKU9eGUxoKqkFGIxPrt
         nxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315644; x=1745920444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPZNfcaggW8uG4XfjMHFTZr4Y8+XA41YuZRRPWh0lH0=;
        b=HMQZjJFggd26fsbAHrEpTDTEcFAIT3Il6TbJGujp7lSjwvq7RcWHG/mYgpVARMH/Qt
         jZRAdt95EZFHo1HPdw/yEVS0Yi2eMwogbVgzYdnRQU1VFU+pWI18baia/I7b10FopszZ
         GeLnkuyD0zPHfzjrI9sP0CehuFYFTjIjpKZ1Xwd1Hm2weH+LOzphYKTQfWv9JwjNKhYu
         2cKG0H2Gxw26MUPwWKTjnpJQpaw/Q6jTqr1QO3j8VqddIFi87VBtojnkAbVx/Ybuyi6W
         x0G4z9Dbp7GVr8EK4YDWj2X4t2XvhhVO4lp8oCtE8oqe4HoVkTpzlDtar+JIefG65wqn
         nBgQ==
X-Gm-Message-State: AOJu0YzloxYOKF1TMzzjsT7AYBq84exsAHdDWE+kJjqFfM+Lys0XcKI7
	itC8oOW6FWsqkOtOwYsPDdj2ZuqukDbXQbBi2QQYIo+KDaCmwTahPkYP+TLzSCc=
X-Gm-Gg: ASbGncu7VjzynHCwuHHYfMzp21pRV+8e+zb6hF6ZPYDIohgraeA79LmOz0ozSBC+g0N
	Qyf2i8IzJHaUagmgSZvV7CiazcvJks2dSGMvNO/ERxzKpqYqMG0FbezppgbMdlAHiQSN2mj5jhc
	TV1yDz2gl3HZ/RSuSwSLXshfqhw0ujNv5NaW107FB8JC1YP0VAyJmlEJvmtYJaFR4tSHLBNBSAm
	jhk8ciOZNHMP0td1tHBE1BgTsbdrLoE2fACCHxj6MMSF4Au3YJW9MX0W2axd/LaBRoyzkN+B+8g
	QGA33BOQcZ3LslD16OHKqOX7E3stFZKvumOeiy2+yw==
X-Google-Smtp-Source: AGHT+IHKou40qiS7674aCZgsNbYQ3NjPMMj46gtqN3TSMH1ZrnQNn1nfjehtyZw5rtQa72SBcl4KYg==
X-Received: by 2002:a17:903:3c6e:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-22c53e1a157mr219276895ad.2.1745315644374;
        Tue, 22 Apr 2025 02:54:04 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eced75sm80823325ad.173.2025.04.22.02.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:54:03 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 0/6] cpufreq: Boost related cleanups / fixes
Date: Tue, 22 Apr 2025 15:23:50 +0530
Message-Id: <cover.1745315548.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series tries to fix boost related issues found recently.

The first two patches (hopefully) fixes the boost related breakage
introduced recently. These should be applied for v6.15-rc4. Nicholas,
please give the first two patches a try.

The other four patches are general optimizations and fixes for boost
handling in general. These can be applied to -rc or next merge window.

--
Viresh

Viresh Kumar (6):
  cpufreq: acpi: Don't enable boost on policy exit
  cpufreq: acpi: Re-sync CPU boost state on system resume
  cpufreq: Don't unnecessarily call set_boost()
  cpufreq: Introduce policy_set_boost()
  cpufreq: Preserve policy's boost state after resume
  cpufreq: Force sync policy boost with global boost on sysfs update

 drivers/cpufreq/acpi-cpufreq.c | 38 ++++++++++------------
 drivers/cpufreq/cpufreq.c      | 58 ++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 46 deletions(-)

-- 
2.31.1.272.g89b43f80a514


