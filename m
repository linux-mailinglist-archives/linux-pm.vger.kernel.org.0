Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243951512C3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 00:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgBCXOg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 18:14:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63218 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBCXOg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 18:14:36 -0500
Received: from 79.184.253.222.ipv4.supernova.orange.pl (79.184.253.222) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 200205067b441903; Tue, 4 Feb 2020 00:14:33 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpuidle: Documentation: Clean up PM QoS description
Date:   Tue, 04 Feb 2020 00:14:33 +0100
Message-ID: <2508205.dfSqNlTTCn@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Clean up the language in one paragraph in the PM QoS description in
Documentation/admin-guide/pm/cpuidle.rst.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpuidle.rst |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -632,16 +632,16 @@ class priority list and destroyed.  If t
 will be used, again, to determine the new effective value for the whole list
 and that value will become the new real constraint.
 
-In turn, for each CPU there is only one resume latency PM QoS request
-associated with the :file:`power/pm_qos_resume_latency_us` file under
+In turn, for each CPU there is one resume latency PM QoS request associated with
+the :file:`power/pm_qos_resume_latency_us` file under
 :file:`/sys/devices/system/cpu/cpu<N>/` in ``sysfs`` and writing to it causes
 this single PM QoS request to be updated regardless of which user space
 process does that.  In other words, this PM QoS request is shared by the entire
 user space, so access to the file associated with it needs to be arbitrated
 to avoid confusion.  [Arguably, the only legitimate use of this mechanism in
 practice is to pin a process to the CPU in question and let it use the
-``sysfs`` interface to control the resume latency constraint for it.]  It
-still only is a request, however.  It is a member of a priority list used to
+``sysfs`` interface to control the resume latency constraint for it.]  It is
+still only a request, however.  It is an entry in a priority list used to
 determine the effective value to be set as the resume latency constraint for the
 CPU in question every time the list of requests is updated this way or another
 (there may be other requests coming from kernel code in that list).



