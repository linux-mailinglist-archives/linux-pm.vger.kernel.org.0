Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7F287A83
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgJHREp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 13:04:45 -0400
Received: from foss.arm.com ([217.140.110.172]:39554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbgJHREp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 13:04:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A269AD6E;
        Thu,  8 Oct 2020 10:04:44 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.48.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A21F3F802;
        Thu,  8 Oct 2020 10:04:41 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com
Subject: [PATCH v2 0/2] Improve the estimations in Intelligent Power Allocation
Date:   Thu,  8 Oct 2020 18:04:24 +0100
Message-Id: <20201008170426.465-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The Intelligent Power Allocation (IPA) estimates the needed coefficients for
internal algorithm. It can also estimate the sustainable power value when the
DT has not provided one. Fix the 'k_i' coefficient which might be to big
related to the other values, when the sustainable power is in an abstract
scale. Do the estimation only once and avoid expensive calculation every time
the IPA is called.

The patch set should apply on top of patches adding upper and lower bound for
power actors [1].

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20201007122256.28080-1-lukasz.luba@arm.com/

Lukasz Luba (2):
  thermal: power allocator: change the 'k_i' coefficient estimation
  thermal: power allocator: change how estimation code is called

 drivers/thermal/gov_power_allocator.c | 62 +++++++++++++--------------
 1 file changed, 31 insertions(+), 31 deletions(-)

-- 
2.17.1

