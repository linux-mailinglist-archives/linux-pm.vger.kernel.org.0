Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A554E23FFE
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfETSH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 14:07:27 -0400
Received: from node.akkea.ca ([192.155.83.177]:58432 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfETSH1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 14:07:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 0DAB04E2050;
        Mon, 20 May 2019 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558375647; bh=RL8B9Oh5lGQzuQ3eprF83Pb5jfnioaLQDRsVV9I8B1Q=;
        h=From:To:Cc:Subject:Date;
        b=uDY9L3R5IQlZ6dySfFkVJgwPpQBp9vn7Y3XmTthkht56dMOEYCe/QnlkZe1BUDd/l
         RsoRKMNNtpQcA43ZACKcZCfn9vAxLQiZMKWR5Pz8wFFavPN+q+n8XZUSQOIt/Rx4/Y
         iwyYuHz8j6+EFG8dq/QnNe8JhNEJFXWNKmsEmx9g=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EdZm5TrH3vA3; Mon, 20 May 2019 18:07:26 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 22D484E204B;
        Mon, 20 May 2019 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558375646; bh=RL8B9Oh5lGQzuQ3eprF83Pb5jfnioaLQDRsVV9I8B1Q=;
        h=From:To:Cc:Subject:Date;
        b=u7tKSdLli2B5lXxpXN1Qmgkb+KGQJ0qBqBRXYh2QIc1ECHPZWQROkrvUpnLkj+z17
         XtwVsoaeaHO1yFoXxgp26QfDhG8skAg9vMNSXlRtoqJiz/BldZH3OCoixyvaAkUhAc
         pGj07wEWG0R7yv73pyudNDhW0NVuhFMxD50cP9BE=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 0/2] Allow VINDPM to be set in the device tree
Date:   Mon, 20 May 2019 11:07:10 -0700
Message-Id: <20190520180712.32405-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The BQ25890 can control the input voltage limit so allow it to be set.

Angus Ainslie (Purism) (1):
  dt-bindings: power: supply: Add documentation for the VINDPM
    properties

Eric Kuzmenko (1):
  power: supply: bq25890: Add support for setting bq25890 and bq25896's
    VINDPM

 .../devicetree/bindings/power/supply/bq25890.txt    |  8 ++++++++
 drivers/power/supply/bq25890_charger.c              | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.17.1

