Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79826232CCE
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 10:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG3ICE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 04:02:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:35081 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgG3ICE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 04:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596096120;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=jAU4zx3KLqkuh8Fcd/ydkgYI0tR+fPGhEugBXGuulu4=;
        b=ghpia/QWWSbJ+4iVQDDxiEZ7No2+czDYvO6nSObq7QZYuFZe2t0sSouGgOHAUBrVA7
        tZUltMqEj7FuKT0HSuEtTIE2PBZr22xmRcb2zcgHN144e7bwv3OieYK1shqvjP+DJkTL
        KzzbeUXV//lW0QCg/+vhF8CGj7wq6Xt+e6zK/6wo7D0lBeH2/bDWwCnUyiCLIYnI9OPt
        3RXraJ/aLf7LcBR51Jf3S/KJnYCv3d6nabmMGTT082yIvtoFjIajRbVjRKgkjI0gg1VX
        DK8FN5fCHuJ2LHhXA242sArbs/NjWq6pTdIv+9snC2BrfH/pY41xGZOTSaQL5xbSir3M
        oeoA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6NeHYC"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew6U81wgul
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 30 Jul 2020 10:01:58 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [RFC PATCH 0/3] opp: required_opps: Power on genpd, scale down in reverse order
Date:   Thu, 30 Jul 2020 10:01:43 +0200
Message-Id: <20200730080146.25185-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I'm trying to get CPR (Core Power Reduction, AVS) working for MSM8916 on mainline.
Shortly said there are two power domains that must be scaled with the CPU OPP table:

  - (VDD)MX
  - CPR

My idea for this was to add both as "required-opps" to the CPR OPP table
and let the OPP core take care of all the scaling.

There are two remaining problems that need to be addressed for that to work:

  1. The power domains should be scaled down in reverse order
     (MX, CPR when scaling up, CPR, MX when scaling down).
  2. Something has to enable the virtual genpd devices to make the rpmpd driver
     actually respect the performance states we vote for.

Both issues were briefly discussed before (see links in the patches),
but I think we did not agree on an exact solution yet. After some consideration,
I thought it would be best to address these directly in the OPP core.

However, note that this patch is RFC because it is just supposed to initiate
discussion if alternative solutions would be better. :)

Stephan Gerhold (3):
  opp: Reduce code duplication in _set_required_opps()
  opp: Set required OPPs in reverse order when scaling down
  opp: Power on (virtual) power domains managed by the OPP core

 drivers/opp/core.c | 115 ++++++++++++++++++++++++++++++++++++---------
 drivers/opp/opp.h  |   1 +
 2 files changed, 93 insertions(+), 23 deletions(-)

--
2.27.0
