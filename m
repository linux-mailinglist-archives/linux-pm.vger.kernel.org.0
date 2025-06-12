Return-Path: <linux-pm+bounces-28537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854D3AD6E20
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 12:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6027A4521
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187B23875D;
	Thu, 12 Jun 2025 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qekT6s2u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033DA2309B2
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725091; cv=none; b=IxCAqse325RzkLWKH2f+GYBUPTZasVOQ1ajzSFZkhfdQzubPEJGO9m2QOLQ+ZQiIu4AMbJNuXekuHIIZ5cN9R2h1Yv+/oC00sd+iEdmCbMlmCWY01Jf9Vtnoo4O1sPUVRkpQUuujXc9+GGpyRCMVnhYj4hG8/Hi39qsXrpj4peA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725091; c=relaxed/simple;
	bh=vipvqWY/c47GVY2ecLz3MC532b9GPpeAVV+aqHCbxZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LxtRajZQnege8qD2SeyCFCt8qLR0JNJccvDDYlHmJ4DRKPxTX4r1cAPfnX0FtLd8C0pLwCvQ6/fLa8RGUSXjW3I69GEk+UoZGqHGalKJto/xfjPzIt11Nf9gM2WwlUQhGizAhB2g6zljhrfjx/aNU6WE+SeyAVEIAq+T5VTwkvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qekT6s2u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2352e3db62cso7182955ad.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749725089; x=1750329889; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d647YjF3bYSyN8nr4z9fJNlObTSg64SSy5tUR37XPGc=;
        b=qekT6s2u/fv0z1x9Ag8WF+qWT+u9bWM8XwYOLPjkoE8+d5nCu33njCeJQZD8OmflC4
         mIi/sxfNaUt+ZYtnPPNClv/032fbTO0BVFFF0paaj1Azk4qFq+YDA5s21w8kJE2BqVvs
         aD4WgkAEpDhHFuzK0HERPtLX1t7lipKXPRkzBFvw397EA2OTRwtitLvRmL0iNDC+Q+WI
         mlhNBclmVGcSpnqfCGoFjRQRkYIyoQ3bctSXG/PPqSo71J9RSGVI66iuQCYs6hJB/iWg
         Aho1hZIOgtd7EqSgnhjiVVQl1BMiq2cLEjianx/vXHPDJKINOIST60NZIDrQoOZy08cN
         9GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749725089; x=1750329889;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d647YjF3bYSyN8nr4z9fJNlObTSg64SSy5tUR37XPGc=;
        b=ahTSm/Txbm/TlQr4ZQYxJ8NALYM0Be9ZMouJjr/HRCqtiyOz3xkmxLsQd0rEd29WAJ
         4KrzQLNzVPHGSMOQm1+cYZXcJykI+nby+5zoe1k05DrJsuMBZ9L0WE/2jyuN+6dmm1Y5
         zNIBPnJraDRHKs+cCDhXndKeb3nkP8kKErVsUtnD19AS048KYF5DJVj3Tg0W3aNWorrP
         KtjUN4/5+KOM9ExM5iRnRanYutHXPaprNbWUyh7jtr3UnPFsPalrzYFuDpQjSeDKXC0W
         W8EiTstBwsnLTUPKPc7EfKxqSsCPJ3Xg1Yk/v/cfPpcpxnoRNCICF7v3wZnmTfFREWzF
         vVxQ==
X-Gm-Message-State: AOJu0YzrXMdfukZEW1Nd6+WxMkg0R/+Mqd+dOPsf3/fz2uyyBzGQc34H
	cTm2a4Ofw00Rb73T8d7fjGZugTbvSshes66D8M6gqvznet41cU/rxHApu0J9xIqHiYk=
X-Gm-Gg: ASbGnctuGZsyCdaYfFaBg98zK6L/M1++n212PhXQOo7hjRKD8rRanrFsqrte6q/PiKB
	Pq8wcfiqa1ZpIFg89CMPDexMEWIcgcHITGAvXayZgJia80nuhTHvZRQgYEuaFFGtlnDuCEgvsUo
	ArSTxVCugALbWWzH+7bhHz+CuBV+oISaksPjhrff1epWdhE4kDug8bAenvghaf6nFj0HmOTI9f/
	1u8g1ey4sU9xU5ooImE3Mif6s0ART+izW3FgRYJrF3ae43szORu7dTcpRz1zAX2Fm2K5L87EOrz
	u5WmikeG3HNa7K4wrPkF+dQUK2Q3N8skQ3yVG3kPQYA8utK96sV0tidsHlZyZptWbkiM0pzA9A=
	=
X-Google-Smtp-Source: AGHT+IF/vOYjRTfyGOGArqX+efBue3d71exYYLP/krSi/aUTaqZSdIzBKprHd9c512ba/0k/qNTIjA==
X-Received: by 2002:a17:902:e74e:b0:234:8ec1:4af6 with SMTP id d9443c01a7336-23641b3291amr94548145ad.45.1749725089252;
        Thu, 12 Jun 2025 03:44:49 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd611e32dsm1060210a12.9.2025.06.12.03.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:44:48 -0700 (PDT)
Date: Thu, 12 Jun 2025 16:14:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, rust-for-linux@vger.kernel.org
Subject: [GIT PULL] cpufreq/arm fixes for 6.16-rc
Message-ID: <20250612104446.hhwn24f3nkasyefa@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-6.16-rc

for you to fetch changes up to c7f005f70d22cd5613cac30bf6d34867189e36a9:

  rust: cpu: Add CpuId::current() to retrieve current CPU ID (2025-06-12 10:31:28 +0530)

----------------------------------------------------------------
CPUFreq fixes for 6.16-rc

- Implement CpuId rust abstraction and use it to fix doctest failure
  (Viresh Kumar).
- Minor cleanups in the `# Safety` sections for cpufreq abstractions
  (Viresh Kumar).

----------------------------------------------------------------
Viresh Kumar (4):
      cpufreq: Convert `/// SAFETY` lines to `# Safety` sections
      rust: cpu: Introduce CpuId abstraction
      rust: Use CpuId in place of raw CPU numbers
      rust: cpu: Add CpuId::current() to retrieve current CPU ID

 MAINTAINERS                    |   1 +
 drivers/cpufreq/rcpufreq_dt.rs |   4 ++--
 rust/helpers/cpu.c             |   8 +++++++
 rust/helpers/helpers.c         |   1 +
 rust/kernel/cpu.rs             | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 rust/kernel/cpufreq.rs         | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 rust/kernel/cpumask.rs         |  51 ++++++++++++++++++++++++++++------------
 7 files changed, 299 insertions(+), 64 deletions(-)
 create mode 100644 rust/helpers/cpu.c

-- 
viresh

