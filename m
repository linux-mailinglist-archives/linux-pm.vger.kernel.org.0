Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51BB21BD68
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGJTLj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:11:39 -0400
Received: from foss.arm.com ([217.140.110.172]:35404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJTLi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 15:11:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B3E231B;
        Fri, 10 Jul 2020 12:11:38 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53B003FA00;
        Fri, 10 Jul 2020 12:11:34 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     lukasz.luba@arm.com, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: [PATCH v2 0/2] Exynos5422 DMC: adjust to new devfreq monitoring mechanism
Date:   Fri, 10 Jul 2020 20:11:20 +0100
Message-Id: <20200710191122.11029-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is a v2 patch set adjusting Exynos5422 DMC to the new devfreq monitoring
mechanism. This time the IRQ mode is explicitly controlled using module
parameter (in default the driver uses polling mode = devfreq monitoring).

The detailed cover letter describing the topic can be found here [1].

The patches should apply on top of Chanwoo's devfreq-next branch, where
the new devfreq mechanism is queued [2]. If there is no objections
I think they can go via this tree, since they logically use it.

Changes:
v2:
- added Reviewed-by from Chanwoo for patch 1/2
- added module_param which controls the mode in which the driver operates
- switched in default to devfreq monitoring mechanism instead of interrupts

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20200708153420.29484-1-lukasz.luba@arm.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next

Lukasz Luba (2):
  memory: samsung: exynos5422-dmc: Adjust polling interval and
    uptreshold
  memory: samsung: exynos5422-dmc: Add module param to control IRQ mode

 drivers/memory/samsung/exynos5422-dmc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.17.1

