Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550AD48409
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfFQNdU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 09:33:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:5446 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFQNdU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jun 2019 09:33:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 06:33:20 -0700
X-ExtLoop1: 1
Received: from unknown (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.255.29.180])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2019 06:33:18 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 0/3] powercap/intel_rapl: add support for more Icelake platforms
Date:   Mon, 17 Jun 2019 21:33:12 +0800
Message-Id: <1560778395-15088-1-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series add intel_rapl support for more IceLake platforms including
ICX, ICX-D and ICL desktop.

Note that all the patches depend on commit e35faeb64146
("x86/CPU: Add more Icelake model numbers") which is just merged in 5.2-rc5.

thanks,
rui

