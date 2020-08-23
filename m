Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A7024F066
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 01:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHWXEb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 19:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHWXE2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 19:04:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C411AC061573;
        Sun, 23 Aug 2020 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=v34t1N2mYe9Af+5RjwXf4HVMIq4eM3wL/1dL7e36QP8=; b=Y4Vf/dNrO+91A6H3uaWeUOMznt
        K9I4ZjAH0eez3Z0SCVIXb9pgotmYapZEqXszgrIn9KHp6NCbA/QqCS4INvADBopC4qSFnF/ljYGBV
        buIdZENVpvP+OMpXwRUUlMgnd0sVXVZ6GKSd+87vYRIEh7rbiD6nIJy/BZWoYLHaOMrHqpkausiEf
        P8F/rWTGJ4bdH26rk2AzqnXpl635Wvp3oJU9ZWP7swzUSv2Bw9F2A4pMEkuL9+pbQLWfP/uvvEEp+
        d5IvCk8JTqwle+pLkQxOAR5S3f4I4Juom8S39qZuol8+/1AEZAa+mqPCGX1lLrvISwj7aHivyhyng
        8tN4effw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9z25-00089U-O4; Sun, 23 Aug 2020 23:04:14 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix pm/intel_pstate build warning and wording
Message-ID: <884e2ee2-7426-cda1-aae2-676062c67f10@infradead.org>
Date:   Sun, 23 Aug 2020 16:04:11 -0700
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

Fix documentation build warning and sentence wording:

Documentation/admin-guide/pm/intel_pstate.rst:568: WARNING: Unexpected indentation.

Fixes: f473bf398bf1 ("cpufreq: intel_pstate: Allow raw energy performance preference value")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-59-rc2.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ lnx-59-rc2/Documentation/admin-guide/pm/intel_pstate.rst
@@ -564,8 +564,8 @@ Energy-Performance Preference (EPP) knob
 Energy-Performance Bias (EPB) knob. It is also possible to write a positive
 integer value between 0 to 255, if the EPP feature is present. If the EPP
 feature is not present, writing integer value to this attribute is not
-supported. In this case, user can use
- "/sys/devices/system/cpu/cpu*/power/energy_perf_bias" interface.
+supported. In this case, user can use the
+"/sys/devices/system/cpu/cpu*/power/energy_perf_bias" interface.
 
 [Note that tasks may by migrated from one CPU to another by the scheduler's
 load-balancing algorithm and if different energy vs performance hints are

