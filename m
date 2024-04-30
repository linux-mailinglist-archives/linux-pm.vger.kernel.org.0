Return-Path: <linux-pm+bounces-7339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D88B6FA6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 12:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5DC1C21ED0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40413D240;
	Tue, 30 Apr 2024 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woGRXCaE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F8129E98
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472881; cv=none; b=tbvWwBljPmQt8s1U540Dg2Jqk5GXOnJ0xjs+vlo57cNIF2FVjEFCUIURztaTYg90XEeKPQhM05Btx+lZdmeN9zdLJnFQ7ioADEPqvxojwLd0Bk+pLJI9UOsmfSffocoRp4wi+caKIIS9qBiQOSHmf9v1X2EfGQGl+vObsb9fBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472881; c=relaxed/simple;
	bh=sLk3fEE7NUBFZXPEs25LXUyugPhq8JEdv5ZGrzbOmgU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QXT3nq9n+FCrhGzIZXJSlQ6bUcVpdUaz2XKol2G3wyaUZORfaJm7OrTwfROZQnt4Se3IisA5VfUff7vLIkljO0qesHURnC1w0UNUqzl0icGNsWUFQrNNC39IFTZKlxxJcfDc7utPHhaAi7BkJ4rmhSQ/0trSBBcpFE0dq49SVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=woGRXCaE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso370645ad.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714472879; x=1715077679; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23XnMxN3QO0MYdUnPt9/dMrwrGMxZBA4YMh3U1kQE1Y=;
        b=woGRXCaESBXOwHEH3LM1x8B+tBAaW08qV66cro/rmVfhnHdUpp10Vj8anoYqXpyedr
         phv8Rp0qNW+8r14kZMFGfnwRGDdWeMjlSwiJqRb+7hs6trVvlE6hlbP2D0gomhihS/AU
         xoY1rbFCo/V617PTMIic7cALky6FJV6wPPkfFFLylDbKrfLmpuCBLkwAF1TYjD8iVZHf
         sWDap1I6A8kkNyrsqjBhRaIjxseJ1s1jzFxY7VhxBol7ht6HLmXqMZE3w/4J+0VFprI5
         qyp8+8HEP9/kH/7nB4oLv2g6mK8hJHfNvC5VTdzzIZwh0lnmN6hsLpnLzaJRbfjCzJze
         xClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472879; x=1715077679;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23XnMxN3QO0MYdUnPt9/dMrwrGMxZBA4YMh3U1kQE1Y=;
        b=HgBKBaGQ5GwR0z9YgP1HZ7tPgcw1OS4QU5gLnzArutgEQFCaISba0CiGwljkZr4ZvG
         wyM4DeIaDFhKp4HN0fjqa6Fj9c/dIsOQZc/QrTzbQJsiSTKoPKPNa8QTfPrjGRCgp/dR
         r6B6pQnrUEKd0nPlEYYst8Xg77aPQo/C8k9P62HB2gH9wYQEWlBfZOa+M1CmWdvAa/pk
         8+sWb5QEc+4tazJa7lch7020rYbKPF7rWDDbJzoNDhgkc0U6uAHeRILjqYQmBBfmtB2a
         gECqc2uZynES3GTykX9fV8DdL+3sfiEYcF0+bI3cDUUiQNuM3M7DqknF+ARQg2VcPzQC
         2bEQ==
X-Gm-Message-State: AOJu0Yw9T8B4WNkPyBFj/qzO+zkhC3sWWn7g4BXa0HZdNB7eulks1jjy
	T+pAhDjiRIX53hkCZqoes/fIL6APcQcPTJ2lgCVRw2fwwglX4s6Bho5iv541tCc=
X-Google-Smtp-Source: AGHT+IFjlty8sQ8XLelXGYl9f3a6biL5KwxdZVA/9rD2nyRrWfIYJw6pdq9oeas2ik+5/8x6CyLN1A==
X-Received: by 2002:a17:903:1205:b0:1e4:ccf6:209f with SMTP id l5-20020a170903120500b001e4ccf6209fmr15916378plh.28.1714472879208;
        Tue, 30 Apr 2024 03:27:59 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id kj3-20020a17090306c300b001e5a1678d62sm22018194plb.63.2024.04.30.03.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:27:58 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:57:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.10
Message-ID: <20240430102756.fgar4rdd5s42245l@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.10

for you to fetch changes up to fde234239d161f958390e41d26cda2bb166f1994:

  dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatibles (2024-04-26 18:13:41 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.10

- Sun50i: Add support for opp_supported_hw, H616 platform and general
  cleaups (Andre Przywara, Martin Botka, Brandon Cheo Fusi, Dan
  Carpenter, and Viresh Kumar).

- cppc: Fix possible null pointer dereference (Aleksandr Mishin).

- Eliminate uses of of_node_put() (Javier Carrasco, and Shivani Gupta).

- brcmstb-avs: ISO C90 forbids mixed declarations (Portia Stephens).

- mediatek: Add support for MT7988A (Sam Shih).

- cpufreq-qcom-hw: Add SM4450 compatibles in DT bindings (Tengfei Fan).

----------------------------------------------------------------
Aleksandr Mishin (1):
      cppc_cpufreq: Fix possible null pointer dereference

Andre Przywara (2):
      cpufreq: sun50i: Add support for opp_supported_hw
      arm64: dts: allwinner: h616: enable DVFS for all boards

Brandon Cheo Fusi (1):
      cpufreq: sun50i: Refactor speed bin decoding

Dan Carpenter (1):
      cpufreq: sun50i: fix error returns in dt_has_supported_hw()

Javier Carrasco (3):
      cpupfreq: tegra124: eliminate uses of of_node_put()
      cpufreq: dt: eliminate uses of of_node_put()
      cpufreq: dt-platdev: eliminate uses of of_node_put()

Martin Botka (5):
      firmware: smccc: Export revision soc_id function
      cpufreq: dt-platdev: Blocklist Allwinner H616/618 SoCs
      dt-bindings: opp: Describe H616 OPPs and opp-supported-hw
      cpufreq: sun50i: Add H616 support
      arm64: dts: allwinner: h616: Add CPU OPPs table

Portia Stephens (1):
      cpufreq: brcmstb-avs-cpufreq: ISO C90 forbids mixed declarations

Sam Shih (1):
      cpufreq: mediatek: Add support for MT7988A

Shivani Gupta (1):
      cpufreq: ti: Implement scope-based cleanup in ti_cpufreq_match_node()

Tengfei Fan (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatibles

Viresh Kumar (1):
      cpufreq: sun50i: Fix build warning around snprint()

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml                  |   2 ++
 Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml |  87 ++++++++++++++++++++++++++-------------------------
 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi                  |   5 +++
 arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi                          | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts                    |   5 +++
 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts                          |   5 +++
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi                                  |   8 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi                 |   5 +++
 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts                   |   5 +++
 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts                    |   5 +++
 arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts                 |   5 +++
 drivers/cpufreq/brcmstb-avs-cpufreq.c                                           |   5 ++-
 drivers/cpufreq/cppc_cpufreq.c                                                  |  14 +++++++--
 drivers/cpufreq/cpufreq-dt-platdev.c                                            |  10 +++---
 drivers/cpufreq/cpufreq-dt.c                                                    |  21 ++++---------
 drivers/cpufreq/mediatek-cpufreq.c                                              |  10 ++++++
 drivers/cpufreq/sun50i-cpufreq-nvmem.c                                          | 209 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 drivers/cpufreq/tegra124-cpufreq.c                                              |  19 ++++--------
 drivers/cpufreq/ti-cpufreq.c                                                    |   4 +--
 drivers/firmware/smccc/smccc.c                                                  |   1 +
 20 files changed, 420 insertions(+), 120 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi

-- 
viresh

