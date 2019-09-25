Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09357BE775
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfIYVf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 17:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfIYVf3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Sep 2019 17:35:29 -0400
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net [71.197.186.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B52A421D80;
        Wed, 25 Sep 2019 21:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569447328;
        bh=6giJGc/llVkN+NRE9PVhNvjJj8GYEZQg8PvTR+MJpMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=P5aGc5i7ZejW7VXXRnbSIVEMlXEzLY3uMIw7UAhbX99CaCEH9JjV5UA9+o3dT+9aU
         ph3PiNg9F1LvXTNmOLk0o2h8w1FlT5qept7AtZeI9SGfYVzPlNqAUAJp7/GVIgg0MB
         TcyVM7BN9fNolB9e7C6nZ9XwywuDyfhjzVIrzTUI=
From:   Kevin Hilman <khilman@kernel.org>
To:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] soc: amlogic: ee-pwrc: cleanup init state
Date:   Wed, 25 Sep 2019 14:35:26 -0700
Message-Id: <20190925213528.21515-1-khilman@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kevin Hilman <khilman@baylibre.com>

Cleanup the PM domain init state and ensure that the driver state
matches the HW state for all domains.

Tested on meson-g12a-sei510 and meson-sm1-sei610 and verified that fb
console still working (VPU power domain.)

Changes since v1:
- always call 'on' 

Kevin Hilman (2):
  soc: amlogic: ee-pwrc: rename get_power
  soc: amlogic: ee-pwrc: ensure driver state maches HW state

 drivers/soc/amlogic/meson-ee-pwrc.c | 57 +++++++++++------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

-- 
2.22.0

