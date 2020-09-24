Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8B276F5C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgIXLGQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgIXLGP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 07:06:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A46C0613CE
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 04:06:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so3454972lfn.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 04:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LzyEVfHWmhqp2YeTW1iTgqjO0Sx0b8TSpBv6gZq633w=;
        b=mufSaWhJTEpeaZqLGunvZqqHp9vEfBBCJzxEWCpJIHPJWzWi4QefkwK17iHLj/pM7s
         fo3Q/6tkCYEU1JO1FR8d0Fw1SbQjuYNK7wD1jJbywuEiIMVj1wu0Mng26Fk8TMYlTMB0
         ij9xlXAM5BmSstdnt4c6W+tgp8uqsCiOftPyb/HBtk14B1VLqILUzVHnIWT+skfcvSUt
         U8qor5QHgb8M4sS19ELlkfjSP4OJ8fk7aoQwkmaWj9VdJN7KhP6kR53XUzhLzSssLOfs
         TO42wpmo034sPiyRDcX4NGwSLBrA3zYMOw4IZcHOTu/pGikUUPWXM4fOpxD0Y/ULdQP+
         lwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LzyEVfHWmhqp2YeTW1iTgqjO0Sx0b8TSpBv6gZq633w=;
        b=aZIy2P+jEuLXD1kdzKGzpPraHmEql3TMKJiFICCJ3D9rRmD8iuPiYqezv23GWIKFDQ
         bxRqBRBrmEIcEhkI8NHmQ1hJKBUJfRvKNNwUvGyGWjPSJqI3zhYexwtAT3uE+JPTzkiO
         v+kjZEiQjUAi6F/V0d6zee3DY5vNcCRfvd022q7u0ZVALmKAv6xGN/2l/dborL4cS5wx
         ff1oo1EG8u6aWWF434m2ohYLNGiyf/yfN7g1JjCX4vX3TbWdbkgFDDlmd4NjM6+Aln3I
         3ENhK9MOhOUoJ4gaDcNAwX1DX7Btdf5GNR4GpJdlLW4SxGBtY/l07qZKxIHHqrPBn8h6
         QlvA==
X-Gm-Message-State: AOAM532pz8h4gfV/ITHj/fwg74j2s28uc87ptRn96ua3V9oZaK+nDT6j
        gn7YePDCTUNsOlNj1gApZfby0w==
X-Google-Smtp-Source: ABdhPJx2FKWu3aQ4RnPGtoMvMr5etGzGRJYG6Q3BiqdvsBtHHdBydd7wU/4y8htyLWyho1WG9GSMIg==
X-Received: by 2002:ac2:5110:: with SMTP id q16mr102229lfb.561.1600945572287;
        Thu, 24 Sep 2020 04:06:12 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id w4sm1762393lfr.139.2020.09.24.04.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:06:11 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] PM / Domains: Add power on/off notifiers for genpd
Date:   Thu, 24 Sep 2020 13:04:46 +0200
Message-Id: <20200924110449.329523-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v2:
	- Improved error handling in patch3.

A device may have specific HW constraints that must be obeyed to, before its
corresponding PM domain (genpd) can be powered off - and vice verse at power
on. These constraints can't be managed through the regular runtime PM based
deployment for a device, because the access pattern for it, isn't always
request based. In other words, using the runtime PM callbacks to deal with the
constraints doesn't work for these cases.

For these reasons, this series introduces a power on/off notification mechanism
to genpd. To add/remove a notifier for a device, the device must already have
been attached to the genpd, which also means that it needs to be a part of the
PM domain topology.

The intent is to allow these genpd power on/off notifiers to replace the need
for the existing CPU_CLUSTER_PM_ENTER|EXIT notifiers. For example, those would
otherwise be needed in psci_pd_power_off() in cpuidle-psci-domain.c, when
powering off the CPU cluster.

Another series that enables drivers/soc/qcom/rpmh-rsc.c to make use of the new
genpd on/off notifiers, are soon to be posted. However, I would appreciate any
feedback on the approach taken, even before that series hits LKML.

Kind regards
Ulf Hansson


Ulf Hansson (3):
  PM / Domains: Rename power state enums for genpd
  PM / Domains: Allow to abort power off when no ->power_off() callback
  PM / Domains: Add support for PM domain on/off notifiers for genpd

 drivers/base/power/domain.c | 187 +++++++++++++++++++++++++++++-------
 include/linux/pm_domain.h   |  19 +++-
 2 files changed, 171 insertions(+), 35 deletions(-)

-- 
2.25.1

