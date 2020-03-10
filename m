Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE28E180432
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 18:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCJRBW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 13:01:22 -0400
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:28484 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgCJRBW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 13:01:22 -0400
X-Halon-ID: bb644488-62f0-11ea-aa6d-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id bb644488-62f0-11ea-aa6d-005056917f90;
        Tue, 10 Mar 2020 18:01:10 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/3] thermal: rcar_thermal: Update how temperature is read
Date:   Tue, 10 Mar 2020 18:00:26 +0100
Message-Id: <20200310170029.1648996-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series simplifies how the temperature is read, actually notifies a 
zone on temperature changes and removes the need for locking in some 
code paths. The change is made possible by a quiet old commit [1] which 
made reading the ctemp value from hardware every time it's needed 
mandatory.

1. a1ade5653804b8eb ("thermal: rcar: check every rcar_thermal_update_temp() return value")

Niklas Söderlund (3):
  thermal: rcar_thermal: Always update thermal zone on interrupt
  thermal: rcar_thermal: Do not store ctemp in rcar_thermal_priv
  thermal: rcar_thermal: Remove lock in rcar_thermal_get_current_temp()

 drivers/thermal/rcar_thermal.c | 47 ++++++++++------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

-- 
2.25.1

