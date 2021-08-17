Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE53EE531
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 05:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhHQDpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhHQDpx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 23:45:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3B0C061764
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 20:45:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nt11so29888823pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eE9NknD+cBA2dk5HGXpQFE/o0Xl3mRs/hkeWjC0WZPE=;
        b=tE9+YFs2voBFgsrXH9qccH0KPzeR+Bu+MN5IveK54SnWBHltQrqUHiaa81ewwtekGV
         xSBoEZ249JQNRQw85F1pl3FTxFawEE/kRj/MhvemQZ2lq6qJzvMVV9d7UeHHGZrPjuSC
         H/U4egqcbvrSR8kUS+CSJiPsxT5MFpw94eAzkFLTqGH+xPnlJoig0QVeYPId7zteQgdw
         7SWJ+FKgXbXePHSryaDNINfDdQbyVUUiYa5sY5xw4JV4jXXGsVvLt3AjnNlWNBImY6Pw
         X/T4hbSwJjRkSsqzPZ+VbUpy1X6vfTcREPnTSNZxpQiLec++V+mRBKKfKQLYP25ZwHhW
         qDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eE9NknD+cBA2dk5HGXpQFE/o0Xl3mRs/hkeWjC0WZPE=;
        b=XbFjqV1/bwwa6+rtWaVOToedGNAIvbJpud62Oj6PWC/8CeVX61XYLJdZPaLXGHVSJj
         ly8p0l3Xc0pVmQ2dn4jZa+A7CDwa3b7j3Rk/UjI2IbG3r9JuyQ0h34TBHTpLviZNfUnX
         JmSEqhvcv9YP4AeiQl8vuKQH+H5vyzNzR3zEhMIbL79dtQ86K4l2lveKR3XcozdIwaO3
         6I74GlRLkuv7DMaTClqyTWamFnpdVgy6koKR7Qb8tQj91+TuDzDCwj2MfP3FsEhMs+Ng
         6SQY4BIcWf1DQY608741N+hIt8GBfYtuFRBK7Cv4nW31FOeB2b3HAEPxv0NwQoT0zpvP
         91vA==
X-Gm-Message-State: AOAM531pO1rbqoOkDnAPqhl/MNMlaQAR4T6/PlJ3m/b/ltogQcIrsdyY
        28FBIBUD91ug75gZApHiSbJpWQ==
X-Google-Smtp-Source: ABdhPJya8SFeMQM7+fbOj7VQATyUXvduO1ao55v7v/f1KtuGuVGDojzgHG6oloLBWdVlIaLxQhBvbg==
X-Received: by 2002:a65:40c4:: with SMTP id u4mr1463755pgp.186.1629171921222;
        Mon, 16 Aug 2021 20:45:21 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z15sm753846pgc.13.2021.08.16.20.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 20:45:20 -0700 (PDT)
Date:   Tue, 17 Aug 2021 09:15:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.14
Message-ID: <20210817034516.pvyxlmq5do733ock@vireshk-i7>
References: <20210810085838.d3hv3rxli5vxozlz@vireshk-i7>
 <CAJZ5v0j4N+puor2x2_vqB-zaJe-m_-pv6cipV_fCbRyKAd6Zgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j4N+puor2x2_vqB-zaJe-m_-pv6cipV_fCbRyKAd6Zgg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-08-21, 16:42, Rafael J. Wysocki wrote:
> And now it looks like there's more stuff on this branch.

Sorry about that.

Hi Rafael,

This pull request contains:

- Addition of SoCs to blocklist for cpufreq-dt driver (Bjorn Andersson
  and Thara Gopinath).

- Fix error path for scmi driver (Lukasz Luba).

- Temporarily disable highest frequency for armada, its unsafe and
  breaks stuff.

-------------------------8<-------------------------

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes

for you to fetch changes up to 484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe:

  cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant (2021-08-09 09:31:22 +0530)

----------------------------------------------------------------
Bjorn Andersson (1):
      cpufreq: blacklist Qualcomm sc8180x in cpufreq-dt-platdev

Lukasz Luba (1):
      cpufreq: arm_scmi: Fix error path when allocation failed

Marek Behún (1):
      cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant

Thara Gopinath (1):
      cpufreq: blocklist Qualcomm sm8150 in cpufreq-dt-platdev

 drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
 drivers/cpufreq/cpufreq-dt-platdev.c  | 2 ++
 drivers/cpufreq/scmi-cpufreq.c        | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)
