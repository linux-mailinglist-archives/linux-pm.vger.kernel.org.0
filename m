Return-Path: <linux-pm+bounces-1640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C5481F7CC
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B511C21550
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F189280B;
	Thu, 28 Dec 2023 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZaXJ7p6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B46FCA
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so73495791fa.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 03:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703763729; x=1704368529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbh0l/OCUlD5uVSuXEGMcXjE9wl3eO27IjVISScAPlo=;
        b=LZaXJ7p6c9EuH8ElUlfPZf/8XX8OUluDcLEJ4/mQSU1Ie578J8w2yeSnjXmLNPsFbI
         LnI32SjSdYjxYTY3/QxC5HJc9JpG0OAzhBTKV0oDbzyVPlEI5NTl/eWDBdzkjNJxGSbL
         LFOg5VvzKiWTRdT6ItQevwsBEvnLhKbwhicriB8sQoW9uy/GCVjwFZNX3qK96O7ys798
         v8DzstZO+Krr4n0mt2JORu2zmh8opg6XmWhOU7dVsMbHWb2Id7OLKG1QOsuqMtfOtqF+
         8L1QJSXpAPMmyh/+5GQDF+4L+iMPlYl9wjSv04xWNzH2z1aY0VZ6aq8OvLLjKBj+nfQS
         jkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703763729; x=1704368529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbh0l/OCUlD5uVSuXEGMcXjE9wl3eO27IjVISScAPlo=;
        b=bbA/i4mK2MyZF28lB29YLcLYlhMoytX+WFe68Oh9yT9nVz6VjFG4MvdCrhnf35PJ/d
         iba8syOkPXGP/u0ulbEbNQ9RCiXWY0Sl7J6G7/nI0WXFt4GnXFwg27zKu2Nv+mGVrCeB
         pk8d2ff2UjRi1uGZpk0ij3MzAoi1+3nA/oizbjJN6q6OdNblT0nPrk15DHDKyJuo3O9a
         Goj+bC7hjM5+3eKzEMWYQw0NoRVDYPjMSw5INmQJ+PzNQMkLPoYotzqQSFCz15eCoW8/
         oL5XGZG48XDIix4G33gsnZz8qEPvvPswCP+7ChRoJG5YVtTQ9mMCGDFX3W9EZ2MFcEyo
         hLNQ==
X-Gm-Message-State: AOJu0YwvNBerj8KWPNQNszp87HfEXcSBQIAbJS/vk/did+ef08UhQOvv
	lj4CzqIWCiHoooq4ZEEo230qP91+G8mvhQ==
X-Google-Smtp-Source: AGHT+IHSnOW4rpsICrtsFJGdeaeqXLcYGA//H43gyGrL38Vu+aM+ohhsDrXuAXLflLZoBD6Jm7JHIA==
X-Received: by 2002:a2e:3c02:0:b0:2cc:69f5:de84 with SMTP id j2-20020a2e3c02000000b002cc69f5de84mr4762669lja.100.1703763729234;
        Thu, 28 Dec 2023 03:42:09 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a4-20020a05651c210400b002cc32fbe2e5sm2792867ljq.51.2023.12.28.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:42:08 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ben Horgan <Ben.Horgan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH 0/5] PM: domains: Add helpers for multi PM domains to avoid open-coding
Date: Thu, 28 Dec 2023 12:41:52 +0100
Message-Id: <20231228114157.104822-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching/detaching of a device to multiple PM domains has started to become a
common operation for many drivers, typically during ->probe() and ->remove().
In most cases, this has lead to lots of boilerplate code in the drivers.

This series adds a pair of helper functions to manage the attach/detach of a
device to its multiple PM domains. Moreover, a couple of drivers have been
converted to use the new helpers as a proof of concept.

Note 1)
The changes in the drivers have only been compile tested, while the helpers
have been tested along with a couple of local dummy drivers that I have hacked
up to model both genpd providers and genpd consumers.

Note 2)
I was struggling to make up mind if we should have a separate helper to attach
all available power-domains described in DT, rather than providing "NULL" to the
dev_pm_domain_attach_list(). I decided not to, but please let me know if you
prefer the other option.

Note 3)
For OPP integration, as a follow up I am striving to make the
dev_pm_opp_attach_genpd() redundant. Instead I think we should move towards
using dev_pm_opp_set_config()->_opp_set_required_devs(), which would allow us to
use the helpers that $subject series is adding.

Kind regards
Ulf Hansson

Ulf Hansson (5):
  PM: domains: Add helper functions to attach/detach multiple PM domains
  remoteproc: imx_dsp_rproc: Convert to
    dev_pm_domain_attach|detach_list()
  remoteproc: imx_rproc: Convert to dev_pm_domain_attach|detach_list()
  remoteproc: qcom_q6v5_adsp: Convert to
    dev_pm_domain_attach|detach_list()
  media: venus: Convert to dev_pm_domain_attach|detach_list() for vcodec

 drivers/base/power/common.c                   | 133 +++++++++++++++
 drivers/media/platform/qcom/venus/core.c      |  12 +-
 drivers/media/platform/qcom/venus/core.h      |   7 +-
 .../media/platform/qcom/venus/pm_helpers.c    |  48 ++----
 drivers/remoteproc/imx_dsp_rproc.c            |  82 +--------
 drivers/remoteproc/imx_rproc.c                |  73 +-------
 drivers/remoteproc/qcom_q6v5_adsp.c           | 160 ++++++++----------
 include/linux/pm_domain.h                     |  38 +++++
 8 files changed, 288 insertions(+), 265 deletions(-)

-- 
2.34.1


