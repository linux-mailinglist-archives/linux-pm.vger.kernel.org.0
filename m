Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48DD281279
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 14:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBMYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 08:24:25 -0400
Received: from foss.arm.com ([217.140.110.172]:34542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBMYZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Oct 2020 08:24:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3AFF1063;
        Fri,  2 Oct 2020 05:24:24 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.50.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4885A3F70D;
        Fri,  2 Oct 2020 05:24:23 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com
Subject: [PATCH 0/2] Improve the estimations in Intelligent Power Allocation
Date:   Fri,  2 Oct 2020 13:24:14 +0100
Message-Id: <20201002122416.13659-1-lukasz.luba@arm.com>
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

Regards,
Lukasz Luba

Lukasz Luba (2):
  thermal: power allocator: change the 'k_i' coefficient estimation
  thermal: power allocator: estimate sustainable power only once

 drivers/thermal/gov_power_allocator.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.17.1

