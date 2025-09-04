Return-Path: <linux-pm+bounces-33797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B9B4323A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44B318909D0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9225C818;
	Thu,  4 Sep 2025 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbPJvd8e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17725A326
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966904; cv=none; b=iY5cVI3w85My4A3pNNVbdz2Cp6Jh5XhHol35upiKO/ENNVr8+NGIlmi/NAXFO+M3O9AWyYDW++nw2KYnROm05QJvx9fVqlwZosftirYFbuxyeeyJXo8w+MdINPn0dC0KFjf52UJ//EpBQJqrHAEsk9OZqUW25+SgH22MV4UvTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966904; c=relaxed/simple;
	bh=dsjFbCPPBcQUN6NyZlDbgqX9JMBy6m992126rerFcqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V/nYjB2gHHMR+ZFaYPed+vstnJPAQ2fR1g8O2asPpmSnOUBFbOgff/TgAquPmNYlEifHuLu4tD7/SHlS4orH+8LrDuI/dFmPBT7cKeVEoq3Ae5XzsdZneoj+36pi8X2AeAresbLqUr/QEPC4f8nbrZrwmamPQSWJXZm7FIzhHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbPJvd8e; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7724fe9b24dso523288b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 23:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756966902; x=1757571702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVgZ/gNKs42YfhP0pDOFqKNX9bgP5Vvk7tKDnOpJ1lk=;
        b=sbPJvd8eP/rgdEorQd/UT8U2iQSKjayVAuRnknGlOFBlbn/A4ewYY8zgYg6su0UEh8
         yK1IJYQDC81EUihlPihvmZMDUgUIHrifbT9zMR6XbK6dKp/IJ8kXe2WLlzNJduY+g6T5
         y/z1X03qK61QrvQBzefgA6kJS80tz2jrmMMOPFVC06CHJ7PPJNrKerifgi8RLujbuOVb
         oXnhya30+EIl9QLhuxDEgQbg8nUaVvEosQHWj+k8xzThLmBwk+l6/k/go02nxu3mabQq
         4HuOENZLu/9B0tA2M7TQ893c75JL4P/nibE8k6r9t1+5WxopCNEC2pOicVtFktJv64yQ
         6UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966902; x=1757571702;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVgZ/gNKs42YfhP0pDOFqKNX9bgP5Vvk7tKDnOpJ1lk=;
        b=SOts1qYLltPBhNHBPNinejvQGeV4wC3pdx3EglJziC68oqEB29ru44z18LI/ci10fc
         65gF01mpwcI2f9LCx/+ujc4ptPFYyy/Hbg2Vx0C/nBoSihiPviNrKjLLgeZuGJxJZzFm
         WqudnkRlGLsAtJRLet/G2nMEZeXR+vzwuk+bvubCqQ8eo9j9VLMYS7uE7P5vdL4AX8Hn
         5owfz7j5Ofq+btmcgwHWXI5KQdiGWHWGij3pmtRejfaSqW+n2NHOVZXlXl7qJsE6KPmn
         1ns7toSFyK5tilxHBDBqa+xGSysJEAU8J85oNEbx3WDCUCNo1nlqgX0fN4ARR15uLBfH
         1wNg==
X-Gm-Message-State: AOJu0YwOpPaq46pVGmpacXZgSTT3MMIMXlK3PClY/fYkyK4vF857nd2q
	EjlVOyiLv+H27id8esnQ/6KqQ7rHnMFvbfDErBQqQTH/g5QG0Bs2RSERpI+8fT3Q0oI=
X-Gm-Gg: ASbGncveG+VLDJsjIMy2/AvJ+2YMFDtLZ58Lo3vRiNf2y7Fz3FFnhvZc9HkPnzxcrss
	PL3WHmeRfDGKbG8hGSnFFt3Y4iRh8RWrdAwrLu/TIsa8DyLQrbQDVQHlrQFmqDroJCs3awEjjOf
	c/Y9GZ80j3t6/9pOncqrwzxe6eKg2lkrQR0cTVni+UaLquKERtbSC3kxv+jh2cHP/x0LDvYq/b1
	mwOXhNjcoowVCMCGP6Dh975fF2hieQqD5xW6L6+Aj3kUEQE/7XQu6CXEglLMRzpOlYqQRR17dxY
	DhMNXG4nHC427pqsOeoTFiV9BUNqFWeHJcrODArxdYdHEi9Ygd0MgbPwrOAW3Sb20Mhkvr/M5va
	b0utIEL8dvr5DVF2/N9u/TJWM
X-Google-Smtp-Source: AGHT+IFLMzri4rEUNbRN96sAyOhp5tYQX/waUPboQ1bFVmORRXdHQnIuWPf3NvQ7st+W4OskDHL2Uw==
X-Received: by 2002:a05:6a20:430f:b0:243:78a:8272 with SMTP id adf61e73a8af0-243d6f8a600mr27358997637.56.1756966901893;
        Wed, 03 Sep 2025 23:21:41 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d6cde2f0fsm15384596a12.13.2025.09.03.23.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:21:41 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:51:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.18
Message-ID: <20250904062139.kt5ajtvocp5c3ihl@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Rafael,

I will out of office until end of September and so the early pull
request.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.18

for you to fetch changes up to 05db35963eef7a55f1782190185cb8ddb9d923b7:

  OPP: Add support to find OPP for a set of keys (2025-08-26 10:40:58 +0530)

----------------------------------------------------------------
OPP updates for 6.18

- Add support to find OPP for a set of keys (Krishna Chaitanya Chundru).

- Minor optimization to OPP Rust implementation (Onur Özkan).

----------------------------------------------------------------
Krishna Chaitanya Chundru (1):
      OPP: Add support to find OPP for a set of keys

Onur Özkan (1):
      rust: opp: use to_result for error handling

 drivers/opp/core.c     | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 30 ++++++++++++++++++++++++++++++
 rust/kernel/opp.rs     | 16 +++++-----------
 3 files changed, 134 insertions(+), 11 deletions(-)

-- 
viresh

