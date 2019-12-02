Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D7410EC46
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 16:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLBPZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 10:25:30 -0500
Received: from node.akkea.ca ([192.155.83.177]:57652 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLBPZ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 10:25:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 5E0E94E2010;
        Mon,  2 Dec 2019 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575300329; bh=SRlLW1ZF40agOMpOXjZbip0TWQHQvK7ikhKiQ8zf5fI=;
        h=From:To:Cc:Subject:Date;
        b=YEu6o5IwAZWA6sJuSU/ES9a9wn22E4Bq5gW8IrGSp34c6AUwu/6BHKMY5voAS15jZ
         iE7IcHlIOSAHkiRxkr9BLgLeLGkIP4RUAMzdxhC5BcrpI3dKvXqLC1z2+UoZfa+ABt
         WkfuuJYc8hMgMr0brddBVooHmIIsFJlyzJ3uxuw8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e-8yhoq18yFP; Mon,  2 Dec 2019 15:25:29 +0000 (UTC)
Received: from thinkpad-tablet.cg.shawcable.net (S0106905851b613e9.cg.shawcable.net [70.77.244.40])
        by node.akkea.ca (Postfix) with ESMTPSA id 727FE4E2003;
        Mon,  2 Dec 2019 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575300329; bh=SRlLW1ZF40agOMpOXjZbip0TWQHQvK7ikhKiQ8zf5fI=;
        h=From:To:Cc:Subject:Date;
        b=YEu6o5IwAZWA6sJuSU/ES9a9wn22E4Bq5gW8IrGSp34c6AUwu/6BHKMY5voAS15jZ
         iE7IcHlIOSAHkiRxkr9BLgLeLGkIP4RUAMzdxhC5BcrpI3dKvXqLC1z2+UoZfa+ABt
         WkfuuJYc8hMgMr0brddBVooHmIIsFJlyzJ3uxuw8=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 0/2] Add MAX17055 fuel guage
Date:   Mon,  2 Dec 2019 08:25:18 -0700
Message-Id: <20191202152520.27558-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend the max17042_battery driver to include the MAX17055.

Angus Ainslie (Purism) (2):
  power: supply: max17042: add MAX17055 support
  dts: bindings: max17042_battery: add all of the compatible strings

 .../power/supply/max17042_battery.txt         |  6 ++-
 drivers/power/supply/max17042_battery.c       | 15 ++++--
 include/linux/power/max17042_battery.h        | 48 ++++++++++++++++++-
 3 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.17.1

