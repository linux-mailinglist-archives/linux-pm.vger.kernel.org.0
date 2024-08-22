Return-Path: <linux-pm+bounces-12777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9493195C103
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8981F24651
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808C41D173D;
	Thu, 22 Aug 2024 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3xKNhLU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD317DFFC
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366768; cv=none; b=ddzqQzli5n6rFtAk98ztOtna7tyDC9fxXHIbGNZfFvFa0khyuqLrHD7G2l5dtNYYp9HyvokP3rptTxj45gr6MzkHvX6EdxdHI3Vz09fUxHmMnoZwdhzDyagPKUlerH+/vl1zGh5pWWSVoHO1GwO3bo0OX15QzaE1ZbTyfMLIdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366768; c=relaxed/simple;
	bh=4Hf5PUu0dXlsRl1rofCzd3OSIBQjJkDX+UBrSNvcZ2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=seMfPdCOYorc8/pBKPjM37Wlq4ri8FTSDjCZ67sgiWZWlhMX/WFzpyjVwDNDv3AfYLnrrNcbuVyHZ84YFI/3nahjPLIGEjALKwiXFcNs7RPE1DB7938XPU48XFC3pMY8Fl5nu2g17YwSGjsPLiTRns/QxvexnSJxYmfZ9n787n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3xKNhLU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so13529351fa.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366764; x=1724971564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDln139mCm+Zd13awBRXGy0VzjVE5RxG35fqlHyQFyw=;
        b=U3xKNhLU7CNufN+VX/I0zLBaAaZyFinctlx47h0b17yvCoJJZG2pela49fTpF+MHnY
         uKTwazliZzHKmovCpCp4qYQFngN8Fassu8U01Y8aciaXCb3YB+qgwdhHKXOPwno0W6AH
         wm8nOKZNeFop25cloaCc2wGFlqLYlYerAB8tu6x9pXhLhOym36QF/7PejHFRO3REfSQE
         fkjxQk7+x7cGjVRp/gSFVw3jaGLlqt1HzxL7OpPozgPYrDJTmBwPc+2ZUeeI95nFHmF6
         +MaGXkBJj4gdUpvoPNu5DV1LF+KxUfVTQIDsqT2v/CK8QJTRPwMR/5JriX7XKH2meIPW
         pfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366764; x=1724971564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDln139mCm+Zd13awBRXGy0VzjVE5RxG35fqlHyQFyw=;
        b=e8qbVv/6F3AiSKdwKWkLVkh/Urm/DkOYDJ7Fv+cFgVpDG/4uRxEufZJwW4qy24gKSd
         vrTsiphuJ1qS9OvIB0iaT8/7eHS/SKtJG7B4xXaNiKW4YTY+WtFvfEs2zsfoQ9fAf1Wx
         ycbrTlR5uaEQpM6jPuCjttx5RYZoczrMST9DYejCnPeV1daYcL4sN9qEasNi4kNEmp6y
         gkUqe/ExdAQKkp1ZIpedMzdj2BVFakcs+QKhY735RF8x4iWsWjSs1F9n4+vjBDmodHoJ
         0H5YP1cv7sO6sl/PfaJpRgkQxWpq1YUN+yUrNvqG4j7Jtj/mNgl4kY8pncIQTDcIwh96
         pRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaYYL+VhlEH1aiaaiOzjVvD6SaAscd+puAgfPxUWEU+hPa4Mwsif/4Q/Pl7gFHJ50d+1TOG5rsVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFWHnrPL+am2w82CUsfDvfKmVGpPN2L96tkhwCZ43CwlonO2n
	io7JZe3AHJ4bokIVjqRnc9/EKPX5SXNc9XudKB0Q56C43gB33u1tl1nezTDUitQ=
X-Google-Smtp-Source: AGHT+IFjVQunj9GKCtth0S4ejm9CXTEW6D+raTuzjDc0w/Drq5/I9hvp1yQaTp6WSmFZ8QYDX2Jjiw==
X-Received: by 2002:a05:6512:128a:b0:52f:c27b:d572 with SMTP id 2adb3069b0e04-534387c4b18mr189259e87.59.1724366764414;
        Thu, 22 Aug 2024 15:46:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:03 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] OPP/pmdomain: Assign required_devs for required OPPs through genpd
Date: Fri, 23 Aug 2024 00:45:37 +0200
Message-Id: <20240822224547.385095-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
	- Combine the two series [1] and [2] into one.
	- A few minor changes to consumer drivers.
	- Clarification in commit messages.

Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
drivers to attach a device to its PM domains. Their corresponding virtual
devices that are created by genpd during attach, are later being assigned
as the required_devs for the corresponding required OPPs. In principle,
using dev_pm_opp_set_config() for this works fine.

However, attaching a device to its PM domains is in general better done
with dev_pm_domain_attach|detach_list(). To avoid having two different ways
to manage this, this series prepare for the removal of _opp_attach_genpd().

Moreover, it converts the few existing users of the _opp_attach_genpd() into
dev|devm__pm_domain_attach(), allowing the final patch to drop the redundant
code that becomes redundant.

To test this, I have used a QEMU setup, with local PM test-drivers to try to
test all various combinations of single/multi power/performance PM domains for
a device. Hopefully I have covered it all, but I would certainly appreciate if
someone could help to run a slew of tests on some HWs.

Note, due to dependencies I think this whole series is best funneled together
through my pmdomain tree. If you think there may be issues with this approach,
please let me know so we can figure out the best merging strategy.

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20240718234319.356451-1-ulf.hansson@linaro.org/
[2]
https://lore.kernel.org/all/20240723144610.564273-1-ulf.hansson@linaro.org/


Ulf Hansson (10):
  OPP: Fix support for required OPPs for multiple PM domains
  OPP: Rework _set_required_devs() to manage a single device per call
  pmdomain: core: Manage the default required OPP from a separate
    function
  OPP/pmdomain: Set the required_dev for a required OPP during genpd
    attach
  pmdomain: core: Drop the redundant dev_to_genpd_dev()
  OPP: Drop redundant code in _link_required_opps()
  drm/tegra: gr3d: Convert into devm_pm_domain_attach_list()
  media: venus: Convert into devm_pm_domain_attach_list() for OPP PM
    domain
  cpufreq: qcom-nvmem: Convert to dev_pm_domain_attach|detach_list()
  OPP: Drop redundant _opp_attach|detach_genpd()

 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  79 ++----
 drivers/gpu/drm/tegra/gr3d.c                  |  38 +--
 drivers/media/platform/qcom/venus/core.c      |   8 +-
 drivers/media/platform/qcom/venus/core.h      |   6 +-
 .../media/platform/qcom/venus/pm_helpers.c    |  44 +--
 drivers/opp/core.c                            | 252 ++++++------------
 drivers/opp/of.c                              |  39 +--
 drivers/opp/opp.h                             |   5 +-
 drivers/pmdomain/core.c                       | 107 ++++++--
 include/linux/pm_domain.h                     |   6 -
 include/linux/pm_opp.h                        |  42 +--
 11 files changed, 217 insertions(+), 409 deletions(-)

-- 
2.34.1


