Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74974140DBB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 16:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAQPXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 10:23:10 -0500
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:63789 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728780AbgAQPXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 10:23:09 -0500
X-Halon-ID: 40b0dbbe-393d-11ea-a00b-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p54ac5d7b.dip0.t-ipconnect.de [84.172.93.123])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 40b0dbbe-393d-11ea-a00b-005056917a89;
        Fri, 17 Jan 2020 16:23:08 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 0/2] thermal: rcar_{gen3_}thermal: Remove temperature 
Date:   Fri, 17 Jan 2020 16:22:40 +0100
Message-Id: <20200117152242.3804288-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series removes the checks that the read out temperature are within
the guaranteed operation limits described in the hardware manual. It has
been discussed with the hardware guys and the judgement is that it's
better to report a best effort temperature instead of failing with -EIO.

Niklas Söderlund (2):
  thermal: rcar_thermal: Remove temperature bound
  thermal: rcar_gen3_thermal: Remove temperature bound

 drivers/thermal/rcar_gen3_thermal.c | 4 +---
 drivers/thermal/rcar_thermal.c      | 7 +------
 2 files changed, 2 insertions(+), 9 deletions(-)

-- 
2.24.1

