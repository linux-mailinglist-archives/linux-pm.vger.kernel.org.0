Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390E97A5A6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 12:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfG3KKI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 06:10:08 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:44702
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725209AbfG3KKI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 06:10:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ClDADsFkBd/1/rO8tmHQEBHwUBBgG?=
 =?us-ascii?q?BTgKDUwwVEheNLYgdAYJDAYkskRsJAQEBAQEBAQEBGxwBAYQ6BIJoNwYOAQM?=
 =?us-ascii?q?BAQEEAQEBAQUBbYRlRYYncnCDNIF3E64KhAYBhHKBSIE0AYcIhG6BQD+DdWy?=
 =?us-ascii?q?EAyWFfwSVOpVDCYEld5QYGYIelXOLZIFZmWgigVhNHxmDKIJ4jVZENY52AQE?=
X-IPAS-Result: =?us-ascii?q?A2ClDADsFkBd/1/rO8tmHQEBHwUBBgGBTgKDUwwVEheNL?=
 =?us-ascii?q?YgdAYJDAYkskRsJAQEBAQEBAQEBGxwBAYQ6BIJoNwYOAQMBAQEEAQEBAQUBb?=
 =?us-ascii?q?YRlRYYncnCDNIF3E64KhAYBhHKBSIE0AYcIhG6BQD+DdWyEAyWFfwSVOpVDC?=
 =?us-ascii?q?YEld5QYGYIelXOLZIFZmWgigVhNHxmDKIJ4jVZENY52AQE?=
X-IronPort-AV: E=Sophos;i="5.64,326,1559491200"; 
   d="scan'208";a="229598848"
Received: from 203-59-235-95.perm.iinet.net.au (HELO rtcentos7.electromag.com.au) ([203.59.235.95])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 30 Jul 2019 18:10:05 +0800
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rtresidd@electromag.com.au, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rfontana@redhat.com, allison@lohutok.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND v2 0/2] power/supply/sbs-battery: Add ability to force load a battery via the devicetree
Date:   Tue, 30 Jul 2019 18:10:02 +0800
Message-Id: <1564481404-39505-1-git-send-email-rtresidd@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the ability to force load a hot pluggable battery during boot where
there is no gpio detect method available and the module is statically
built. Normal polling will then occur on that battery when it is inserted.

Richard Tresidder (2):
  dt-binding docs: sbs_sbs-battery: Addition of force_load binding
  power/supply/sbs-battery: Add ability to force load a battery via the
    devicetree

 Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt | 4 +++-
 drivers/power/supply/sbs-battery.c                                 | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
1.8.3.1

