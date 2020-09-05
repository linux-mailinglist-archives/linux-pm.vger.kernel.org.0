Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C266925E8F3
	for <lists+linux-pm@lfdr.de>; Sat,  5 Sep 2020 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIEQBt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 5 Sep 2020 12:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgIEQBp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 5 Sep 2020 12:01:45 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pm@vger.kernel.org
Subject: [Bug 209069] CPU stuck at 800 MHz at any load
Date:   Sat, 05 Sep 2020 16:01:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dsmythies@telus.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-209069-137361-ePrZVyI0yz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209069-137361@https.bugzilla.kernel.org/>
References: <bug-209069-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209069

--- Comment #11 from Doug Smythies (dsmythies@telus.net) ---
Created attachment 292363
  --> https://bugzilla.kernel.org/attachment.cgi?id=292363&action=edit
example of needed information

Please, we need more information. Do you know for certain that you were
defaulting to "active" mode before and now "passive" mode. What is your kernel
configuration in the CPU frequency scaling area? What, if anything, is
specified on your grub command line? What governor to you end up with?

attached is an example of needed information.

-- 
You are receiving this mail because:
You are the assignee for the bug.
