Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE2E1AFD02
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDSSLf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 14:11:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44708 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgDSSLf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 14:11:35 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 229b8e72d03b56cd; Sun, 19 Apr 2020 20:11:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Todd Brandt <todd.e.brandt@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        todd.e.brandt@intel.com, len.brown@intel.com
Subject: Re: [PATCH] pm-graph v5.6
Date:   Sun, 19 Apr 2020 20:11:32 +0200
Message-ID: <3707790.Y7hmQpvp8T@kreacher>
In-Reply-To: <0e9a2f5f4f6d0e93de661ae3464568d7dff0f5c9.1586368480.git.todd.e.brandt@linux.intel.com>
References: <0e9a2f5f4f6d0e93de661ae3464568d7dff0f5c9.1586368480.git.todd.e.brandt@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, April 8, 2020 7:58:19 PM CEST Todd Brandt wrote:
> sleepgraph:
> - force usage of python3 instead of using system default
> - fix bugzilla 204773 (https://bugzilla.kernel.org/show_bug.cgi?id=204773)
> - fix issue of platform info not being reset in -multi (logs fill up)
> - change -ftop call to "pm_suspend", this is one level below state_store
> - add -wificheck command to read out the current wifi device details
> - change -wifi behavior to poll /proc/net/wireless for wifi connect
> - add wifi reconnect time to timeline, include time in summary column
> - add "fail on wifi_resume" to timeline and summary when wifi fails
> - add a set of commands to collect data before/after suspend in the log
> - add "-cmdinfo" command which prints out all the data collected
> - check for cmd info tools at start, print found/missing in green/red
> - fix kernel suspend time calculation: tool used to look for start of
>     pm_suspend_console, but the order has changed. latest kernel starts
>     with ksys_sync, use this instead
> - include time spent in mem/disk in the header (same as freeze/standby)
> - ignore turbostat 32-bit capability warnings
> - print to result.txt when -skiphtml is used, just say result: pass
> - don't exit on SIGTSTP, it's a ctrl-Z and the tool may come back
> - -multi argument supports duration as well as count: hours, minutes, seconds
> - update the -multi status output to be more informative
> - -maxfail sets maximum consecutive fails before a -multi run is aborted
> - in -summary, ignore dmesg/ftrace/html files that are 0 size
> 
> bootgraph:
> - force usage of python3 instead of using system default
> 
> README:
> - add endurance testing instructions
> 
> Makefile:
> - remove pycache on uninstall

The sign-off tag was missing, but I added it (under the assumption that it was
omitted by mistake) and queued up the patch for 5.7-rc3.

Thanks!



