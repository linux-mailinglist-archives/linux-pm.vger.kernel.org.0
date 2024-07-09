Return-Path: <linux-pm+bounces-10816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB2B92B0C5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C12B1C211E7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB02A823DF;
	Tue,  9 Jul 2024 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQhq11UM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C327C148
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508679; cv=none; b=axaN7Jz5cB8HDyQjXw94vkzafSvPiOEet7qNrIfecYv5jcK9lW8hs3q9cat7jI2Kolfmo+7bkWMwchjNW4FBzSs4ntFLQgrgClD74gRWeQukiKBh2NbhP3a2B7ct3iyia9KKYzzXZPsU0/cNdOInm4hI6LTmN01XEUEix67zZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508679; c=relaxed/simple;
	bh=0GAz6PwuTUdeA5he6BD/te1uOg1fJrXiM2RPhcjpGhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VyT8nWuNZmYAzIFUfX1jdg6tc98L6TUPCSVxKKAvP0yAV8m2DBNUZ/xgEAd/4cBBRFLdjXYcgz72QqJSGq0itg1i0umF4FHFvZK5BalBCAPx9E8Yl93ma/UtHBerQKumrwCVyNaWASk/+GudGtidR8ohCZIaAMunhtKSdxhqd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aQhq11UM; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c697fc4aa2so53869eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 00:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720508677; x=1721113477; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+iG2Z+DvUDwyzM+9ArydfZtYffSGz12RuZbbVi5+CMk=;
        b=aQhq11UMI0Y3w7M0jNnkk9zuHChq0QJQL80uQ510BxXqLTnOxTxMYx2rrUzFnhf5EO
         yks2cJyrb7mV5LZB+CbvUr9Brhgi9/ZmkEi012t7/hZgaR/Pm6GhgczddqqWMQVZmpHp
         Vz+rWdvhTt2/opdNywFvExVo2zCpQWpeyyDzVxRJXKByN1dcZ2hjwVxyLYBVi/xryVBd
         eiWHie8wLrY5iFyze+1wcP6AW+EsJ87YDksHWQeNoTI6xnu7hzT2RO+5fmZypSxrc2SK
         jt8oxoIo+3gC3tCNEmpyJ3EZyuCAaTNaWZKOQqvoAXQLynuK1eXXT4Q6xjpkJomgkvMR
         9XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720508677; x=1721113477;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iG2Z+DvUDwyzM+9ArydfZtYffSGz12RuZbbVi5+CMk=;
        b=VlzQGvmqfj8D8ppIJB1kpX6mTczjJNWOlqsukq8d1F5BOmhQhTFdkXQ1LimnAIrznh
         qD1/MUV3P8eXt21jXd8OsTJk9udqiebp49RwiGwc1qe1qZqLXB4GN5uf7l98dqiGSAr+
         4yjBLByppkxeEk/A+8nVg1ITKuAvFTT6wT2keUBYSV3JaSEkaQt0yZICFUir2LFgbG+G
         uC0Xf5jK96u7mHZaqzerD0QKaOAVM4aMEKqcgtfCnClmNh0uVlN0e/5/iEeKT81Qzsiv
         GzjCqzWz6SMoXnoBABFBuw3WoIJC/2rZGdYQlLZ25fuO7acfQ4H6Msx+tEXruEaeqApc
         jl5g==
X-Gm-Message-State: AOJu0YznNRQYBTI0Tesr6f3/tm26jmp21a656ZQgscTfWDxmoTW7QCiX
	z8+2pj6g6mkTrbzFW1COhwNCSTnr2/fdAhhL1pCXFR6STRDug7lPFZf3JB8w5mM=
X-Google-Smtp-Source: AGHT+IFNEJBrxDgCcW05ng0dovtbdh3GxrkY9ekaHbNqN2Jj9DaGGyBX9ws9dYxq70l6h++UMi0mxg==
X-Received: by 2002:a05:6359:5e26:b0:19f:4ca6:86c2 with SMTP id e5c5f4694b2df-1aade31d113mr148891655d.25.1720508677095;
        Tue, 09 Jul 2024 00:04:37 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d66bc0fe5sm688687a12.65.2024.07.09.00.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:04:36 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:34:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.11
Message-ID: <20240709070434.lhqicz2px555sykz@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.11

for you to fetch changes up to e3943f00afdb71684c4f209f9d3a90d6b79771fc:

  OPP: Introduce an OF helper function to inform if required-opps is used (2024-06-26 11:17:20 +0530)

----------------------------------------------------------------
OPP Updates for 6.11

- Introduce an OF helper function to inform if required-opps is used (Ulf Hansson).
- Generic cleanus (Ulf Hansson and Viresh Kumar).

----------------------------------------------------------------
Ulf Hansson (2):
      OPP: Drop a redundant in-parameter to _set_opp_level()
      OPP: Introduce an OF helper function to inform if required-opps is used

Viresh Kumar (1):
      OPP: Fix missing cleanup on error in _opp_attach_genpd()

 drivers/opp/core.c     | 15 ++++++++-------
 drivers/opp/of.c       | 32 ++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

-- 
viresh

