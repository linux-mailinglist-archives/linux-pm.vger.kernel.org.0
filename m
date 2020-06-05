Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF91F0362
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 01:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgFEXGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 19:06:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41992 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgFEXGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 19:06:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 642A92A5233
Received: by jupiter.universe (Postfix, from userid 1000)
        id A54F7480100; Sat,  6 Jun 2020 01:06:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 0/2] SBS battery PEC support
Date:   Sat,  6 Jun 2020 01:06:23 +0200
Message-Id: <20200605230625.192427-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Second try to enable PEC for SBS battery. Mainline currently
has 3 different platforms using sbs-battery with an I2C driver
not implementing I2C_M_RECV_LEN:

 * i2c-exynos5
 * i2c-rk3x
 * i2c-tegra

On those platforms PEC will be temporarly disabled for SBS
functions requesting strings. I considered moving the emulation
to I2C core, but it's specific to the SBS battery. The hack
only works because the strings are constant.

Changes since PATCHv1:
 * dropped all applied changes
 * rebased on top of power-supply's for-next branch
 * keep existing string reading method as fallback

-- Sebastian

Sebastian Reichel (2):
  power: supply: sbs-battery: use i2c_smbus_read_block_data()
  power: supply: sbs-battery: add PEC support"

 drivers/power/supply/sbs-battery.c | 89 +++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

-- 
2.26.2

