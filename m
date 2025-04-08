Return-Path: <linux-pm+bounces-24943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C553A80F4B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 17:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E1444596F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1261221547;
	Tue,  8 Apr 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUfjh3MI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EEE1F098D;
	Tue,  8 Apr 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124645; cv=none; b=LzOct7H2t+PjkxG0ZUZsGZ6Br5sy2YVvgrUUcZpTKTQqEJKVWD/Mhm2Kj8fpG4kRCCuNQdvRso20EMqCYTTKa49e2U/YmObxut+n3Lnmrbef5Z34hKfyJ82cByCy7bqvv74/PTAtseA0bf+oMZIlWmKhxQjuF/cxDp1Pz1bsXUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124645; c=relaxed/simple;
	bh=WZGh3rGoMhTBpSqtABT75GEMEZbDnOtq0NcyCJQe5lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AzbuSyjLYtv1ZXi6DHUFIZgMu9AUye2/y/5ZMMWOd4pTh5fYfNrCE5rYcrRZiT6riRpdtkdUq2uzB2L7/aAzFeOxvsJCZgZYBqemPKY/qHSNyYSJgs28vxkUmHp57l93C5yxjcNCdy7QEMLTwRaCeu9QM8Qcdx6P2brREngf/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUfjh3MI; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-736b98acaadso5632691b3a.1;
        Tue, 08 Apr 2025 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744124644; x=1744729444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8fWycJvdwJ/W6pQ9mNqxjashiEaKH5pjJ73XaWiG04=;
        b=QUfjh3MImv/waj1ytBEuONPyyjcVIYTQcPNkVsBWoNC3PBOacp7iANOeKOUkIsUU9R
         oBu7RIxEiTL0SETN/dU4fJB5h2lnrvFztWjZpWYTLYpxY0nHNVViuJTnk0CAlW8NL+Eu
         RS22iOgJBnigRQJOIcUuNf1KYzKQnEXLCjEmG8q4cYL3JgPRFL1tr6aguUfnBG5RBGmL
         mm1xcjAGKKOJv11XH2a39SjcL+xDUUijoWB17B/rzKr2A/5NwE3cJkO/6v8LdByVP6yC
         5NF5U1rEImaqe7SNnUqMfwG8s1DU0hxqi9myGCVZQhyBKiPrPKSNGjvwUpAIJZ1TjbQv
         3Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124644; x=1744729444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8fWycJvdwJ/W6pQ9mNqxjashiEaKH5pjJ73XaWiG04=;
        b=qOo49/Izx02nHBRtOLJWzbFHBSGpMflf3JF+dN0+h2LlMlHpRQco0+3tu/V1+d2rjN
         pLVEmVGMkB8C2Jt0wT8L/jDoDLh/b8LbGyb7hMFDlQ8iIZu8Z+n07y01r0s97g47bmVC
         TgaJ/WkET9Mup9AG7s+V951JxeBDJt7LcedUfZAx7RT0mooozZHjZEzEf/KTklYuGkMa
         e+R+J4WLjCLK3+4xSp2WemhCva/dZyU0wnobP0NnJfg9a+EdHtkMqHPmpg7fFffm25J5
         p+b7shuhQLAM7FMKyDOKI0H3GzeZPYOWblhJA5D+EvzCAZa0tjlUknXJnehjHUaUeiqZ
         cHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8087ZrGCEPBnD87HEPlzDAN3jx4rPmjNlOmorYaDnnRKXIuoaJdEXMBPGbUBTRibxAODDD3i0PZ4=@vger.kernel.org, AJvYcCXt7xhXRteKEVAn5BaUzLc2/hb2gS38bxTV8FjcdoHhkEdO1cBpZ9Q/JyWGgCPecyveMfiXANU4PTKY9dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nRevekzVDmk7IjptbzbVQI6U87kldD/xNNqteEnddfQgF2RO
	udzBTUBxmN6p7ScXbwwBt3tYgx2XCiSL5COyMN20wTu0ero9hHVNuLj0P2vk
X-Gm-Gg: ASbGncvbAPe+VeOc022Y+6bP+rcNf+5ruOozSq7T5vftGBMZcOTPrQPc3XqF2Fwmmca
	gRn8X2R6DUvZPhx2WoR6bA1TeHoQMFKp3Kb7D/i7vTfa159mHabFTMqxsyQntTYH31KgG0EzpMp
	5LEnuvQMEc71earQvyxh89oLBbdJgB7PFl0wKoK5tyXSSXSM3F3ojrFSngZCrXq7KsaQsyzknQT
	n4vwLE4xG6hrpxelULoAO2b0Gj+4JLG3UwaE3HWqPahdeWuCRRIAuPSV4JVq5E849wl7TDRVXaI
	ugAbHSQZ5jj8r0S5BIUqnVGg/VC/LJ2wcdO1O0QqCfknEHIqaKBbWShPs0GtrvOjQd2kDCZj6HQ
	oILnCnQ==
X-Google-Smtp-Source: AGHT+IFmr2DimbBD7TGGduHkaksfKx7Cu1H6lgcQktUMtC0UA/F2Thx2FeH+vbcjDpvPVC3DCPlH9A==
X-Received: by 2002:a05:6a00:3cc1:b0:739:4a30:b900 with SMTP id d2e1a72fcca58-73b6aa3db66mr18058531b3a.7.1744124643494;
        Tue, 08 Apr 2025 08:04:03 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea097asm11068474b3a.90.2025.04.08.08.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:04:02 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2 0/2] cpufreq: scmi/scpi: Fix NULL pointer dereference in get_rate()
Date: Tue,  8 Apr 2025 23:03:52 +0800
Message-Id: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes potential NULL pointer dereferences in scmi_cpufreq_get_rate()
and scpi_cpufreq_get_rate() when cpufreq_cpu_get_raw() returns NULL.

Henry Martin (2):
  cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
  cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()

 drivers/cpufreq/scmi-cpufreq.c | 10 ++++++++--
 drivers/cpufreq/scpi-cpufreq.c | 13 ++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.34.1


