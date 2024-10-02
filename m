Return-Path: <linux-pm+bounces-15052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F330298D2F7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58A2283193
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9C1CF7DD;
	Wed,  2 Oct 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMP7R0NR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD411CF7AD
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871764; cv=none; b=RnZnx8LXOREbFzIRFtUl2ejC9tM9JGAkCic5C6BLfo90UGXuiqH8ydQSv1R1VkDkEqVEIAsPZ1fPkL6wq5jM5+CXBHwYKjtblsP815UezVS11Q4hxXXgwRo5Vt/x7mXS+W7BHTbiJtJdpAghvUwknFwewAvnSWKY9PtiiMnsTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871764; c=relaxed/simple;
	bh=x3vsbDfierSzFRrQFum7/2UiP1geyRdGfdTybww3M1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gTvHDv3YIDJ2XvGERURVo68YDByxA6lvUzz/v6euDuc077XeG2xcUzQh5G6tDhMx6DmlHBnfQMKoeIL4NK4ifEAc7gtIo2PcaxjJHPBf6JFbs24sFJf5jkfsI1pkvqbrJ5LfHS6m7uTLSi3bpL9q9sTZvTD2Ak1g7JL37fXD1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LMP7R0NR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53992157528so3976767e87.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871760; x=1728476560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQqVyxDvEWjTmmvG9BCvIQQDCR/TS1dw1HUpo9ttVho=;
        b=LMP7R0NRr+Fm6USPtalHAEY1npd+y/QZDMwq40qHxjedKOGrqGE0lLPkZym9HtKTQe
         VGfclq07EvKNqp8wMj4mH9142kMCegroZrq39o0ZwI1mUFy9bC8I4mO8MGZRCJOWyKAq
         bbeFNe+S9yR5JoEsXHafyZO9G7JIYN5LThe796YKxc5TeF7PLgjtl9YtkN9+bLcR2BnC
         pW1oYrY5B70dH00/GgxkTBjEjAAOWfX+QJYsB9pZ+iid/fJVC2CSAumsbnfJHqmUfwnH
         T7WNg1LNXsSZ80hKWZT5x9FXw2KLPgkGBbyFbbq8yaBZwe90H1u/9iJz6sIu6FV0Lexw
         Nk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871760; x=1728476560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQqVyxDvEWjTmmvG9BCvIQQDCR/TS1dw1HUpo9ttVho=;
        b=CgRRYHSvwJayLZHblzA5SHYQG1QJKO4oCWgd4owbWTRrxLgrStjpTEmvUPBjXkxK9x
         i8eKVB0S3TERYJVNM7BUtOzpomzzzqAJDxVoPzYFNopwyd2OgRjmvtTm/CpgW8nCYNDY
         GCZ3UlzudBub0AbLq4fbpO1+B73gPPwpP8knUyc7rB6jEPZSB8eJjKlYBz5Ir+Uh+W92
         SI3skEXvhwE/OynwdUT4MM9wF4hn7PBQlPd8YtRlFr4YDUSrzKx9QMaKtTIP9WhdFsMM
         hDNuw2dbfL/4zRXMGHiq1po1f8MaROyDTn26v6We/4GJjdhJi33Niy1NzRH17Vb4NSI6
         gpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAukqWi43U30IIUqIhtWsbniWkaeWjfoFdar/D2052i60lHXrzzDGK9yMV805MqOf5QfnHOw2wfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVHYcAAcIy2uJQrh7UalbDvouJaFo6lI83lGnZ9Z59rUwJO2N
	iBg3Jo0RcOPlj2ayaaZ83+M0PsrBkX4ekaS+HhH6iikhQVzxhhlGjeE2v+8jQSE=
X-Google-Smtp-Source: AGHT+IGkdIq3Z94WzFKrLjvVjRVqOvUim5HWVDFGQ3X2YlPmlUBY8smvw3gUtH35sLjRTrOlJGV3uQ==
X-Received: by 2002:a05:6512:1189:b0:539:9f52:9ea with SMTP id 2adb3069b0e04-539a07a8999mr1648429e87.53.1727871759573;
        Wed, 02 Oct 2024 05:22:39 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:38 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
Subject: [PATCH v4 00/11] OPP/pmdomain: Simplify assignment of required_devs for required OPPs
Date: Wed,  2 Oct 2024 14:22:21 +0200
Message-Id: <20241002122232.194245-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note, due to dependencies this whole series is best funneled together through my
pmdomain tree. Thus I am looking acks/reviews/tests.

Changes in v4:
	- We realized that genpd can't solely be responsible for assigning
	required-devs. In particular in the multiple PM domain case, we need
	platform code to specify the index for a device's required OPPs [1].
	In this version we take that into account by extending
	dev_pm_domain_attach_list() to cope with required OPPs too.

[1]
https://lore.kernel.org/all/CAPDyKFp2s4mPtdU6pMzPbBqqLFxZa1esrXyqXL6UJO-gU-PsVw@mail.gmail.com/

Through dev_pm_opp_set_config() the *_opp_attach_genpd() allows consumer
drivers to attach a device to its PM domains. Their corresponding virtual
devices that are created by genpd during attach, are later being assigned
as the required_devs for the corresponding required OPPs. In principle,
this works fine.

However, attaching a device to its PM domains is in general better done
with dev_pm_domain_attach|detach_list(). To avoid having two different ways
to manage this, this series prepares for the removal of *_opp_attach_genpd()
to finally also remove it.

Kind regards
Ulf Hansson


Ulf Hansson (11):
  Revert "drm/tegra: gr3d: Convert into
    dev_pm_domain_attach|detach_list()"
  PM: domains: Fix alloc/free in dev_pm_domain_attach|detach_list()
  OPP: Rework _set_required_devs() to manage a single device per call
  PM: domains: Support required OPPs in dev_pm_domain_attach_list()
  pmdomain: core: Manage the default required OPP from a separate
    function
  pmdomain: core: Set the required dev for a required OPP during genpd
    attach
  OPP: Drop redundant code in _link_required_opps()
  drm/tegra: gr3d: Convert into devm_pm_domain_attach_list()
  media: venus: Convert into devm_pm_domain_attach_list() for OPP PM
    domain
  cpufreq: qcom-nvmem: Convert to dev_pm_domain_attach|detach_list()
  OPP: Drop redundant *_opp_attach|detach_genpd()

 drivers/base/power/common.c                   |  44 +++-
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  82 +++-----
 drivers/gpu/drm/tegra/gr3d.c                  |  11 +-
 drivers/media/platform/qcom/venus/core.c      |   8 +-
 drivers/media/platform/qcom/venus/core.h      |   6 +-
 .../media/platform/qcom/venus/pm_helpers.c    |  44 +---
 drivers/opp/core.c                            | 198 +++++-------------
 drivers/opp/of.c                              |  39 +---
 drivers/opp/opp.h                             |   5 +-
 drivers/pmdomain/core.c                       |  76 +++++--
 include/linux/pm_domain.h                     |   9 +
 include/linux/pm_opp.h                        |  42 +---
 12 files changed, 210 insertions(+), 354 deletions(-)

-- 
2.34.1


