Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB82531A2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHZOmI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHZOmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 10:42:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95984C061574;
        Wed, 26 Aug 2020 07:42:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8A105299F7C
Received: by jupiter.universe (Postfix, from userid 1000)
        id 51AE548010D; Wed, 26 Aug 2020 16:42:00 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 0/2] power: supply: smb347-charger: Cleanups
Date:   Wed, 26 Aug 2020 16:41:57 +0200
Message-Id: <20200826144159.353837-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

Please check the following cleanup patches for smb347 driver
do not break functionality on your Nexus 7.

-- Sebastian

Sebastian Reichel (2):
  power: supply: smb347-charger: Drop pdata support
  power: supply: smb347-charger: Use generic property framework

 drivers/power/supply/smb347-charger.c | 305 ++++++++++++++------------
 include/linux/power/smb347-charger.h  | 114 ----------
 2 files changed, 167 insertions(+), 252 deletions(-)
 delete mode 100644 include/linux/power/smb347-charger.h

-- 
2.28.0

