Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3561B144A86
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 04:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgAVDre (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 22:47:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16388 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729099AbgAVDre (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 22:47:34 -0500
X-IronPort-AV: E=Sophos;i="5.70,347,1574092800"; 
   d="scan'208";a="82364061"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Jan 2020 11:47:24 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 445764CE3B60;
        Wed, 22 Jan 2020 11:38:13 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 22 Jan 2020 11:47:24 +0800
Received: from TEST.g08.fujitsu.local (10.167.226.147) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Wed, 22 Jan 2020 11:47:23 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
Subject: [RFC PATCH 0/2] x86/boot: early ACPI MADT processing cleanup
Date:   Wed, 22 Jan 2020 11:47:21 +0800
Message-ID: <20200122034723.1863-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 445764CE3B60.A9DCC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Logic in early_acpi_process_madt() & acpi_process_madt() is really hard to
follow now. Clean them up.

Done basic boot test on my x86-64 PC.

Cao jin (2):
  x86/acpi: Improve code readablity of early madt processing
  x86/acpi: Cleanup acpi_process_madt()

 arch/x86/kernel/acpi/boot.c | 72 +++++++++++++++----------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

-- 
2.21.0



