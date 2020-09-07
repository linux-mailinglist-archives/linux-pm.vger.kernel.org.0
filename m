Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3D25F21F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 05:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgIGDnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 23:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGDnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 23:43:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522FEC061573;
        Sun,  6 Sep 2020 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OC6dYvGpOUqcsO2Cuk0vyQYkMIcQvVL+7YIPo+XBuqA=; b=UYAW71mwW6BtN0KRFjkxS66kg6
        yDANSH8rdxOIkIEwww0bJcljLCvdaS2z0nYcztoX+fT6ICW8hpd1HNYC2HTxaO91oORrEYmpV7Fjm
        np+6Ow1yAqmHT59yEG1AgkP7MMAHwVb6nxPbd5FjkASeC5s/Y95XCT62RfBjxd+Xp8LZVwv5gl0Oo
        9dOIUWNKU+rteIKTEGdrCbxWVnuH4UtotQh04jSw7dq5q7y79jmgVfIZ5JBZ1S8LLCD0FPLDSL8R5
        J0htz5LxRdK6a0nzZO75B+fT4V8EOFetlImpfCRjRSHXo4pHOdoYfqZd53aIWIODQDmdqL+sTuez2
        53g1ZzyA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kF83T-00063n-Tj; Mon, 07 Sep 2020 03:42:56 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] PM: <linux/device.h>: fix @em_pd kernel-doc warning
Message-ID: <d97f40ad-3033-703a-c3cb-2843ce0f6371@infradead.org>
Date:   Sun, 6 Sep 2020 20:42:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning in <linux/device.h>:

../include/linux/device.h:613: warning: Function parameter or member 'em_pd' not described in 'device'

Fixes: 1bc138c62295 ("PM / EM: add support for other devices than CPUs in Energy Model")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/device.h |    1 +
 1 file changed, 1 insertion(+)

--- lnx-59-rc4.orig/include/linux/device.h
+++ lnx-59-rc4/include/linux/device.h
@@ -454,6 +454,7 @@ struct dev_links_info {
  * @pm_domain:	Provide callbacks that are executed during system suspend,
  * 		hibernation, system resume and during runtime PM transitions
  * 		along with subsystem-level and driver-level callbacks.
+ * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pinctl.rst for details.
  * @msi_list:	Hosts MSI descriptors

