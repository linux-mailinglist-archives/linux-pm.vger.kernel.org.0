Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08B3146061
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 02:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAWBcr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 20:32:47 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61226 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728668AbgAWBcq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 20:32:46 -0500
X-IronPort-AV: E=Sophos;i="5.70,351,1574092800"; 
   d="scan'208";a="82502156"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2020 09:32:43 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1F9E850A996B;
        Thu, 23 Jan 2020 09:23:28 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 23 Jan 2020 09:32:40 +0800
Received: from TEST.g08.fujitsu.local (10.167.226.147) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Thu, 23 Jan 2020 09:32:40 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
Subject: [RFC PATCH 0/2] x86/boot: early ACPI MADT processing cleanup
Date:   Thu, 23 Jan 2020 09:32:36 +0800
Message-ID: <20200123013238.19059-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1F9E850A996B.AAF91
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

CCed linux-acpi@vger.kernel.org

Cao jin (2):
  x86/acpi: Improve code readablity of early madt processing
  x86/acpi: Cleanup acpi_process_madt()

 arch/x86/kernel/acpi/boot.c | 72 +++++++++++++++----------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

-- 
2.21.0



