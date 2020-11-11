Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC32AEC2A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 09:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgKKIms (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 03:42:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:53924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgKKIms (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Nov 2020 03:42:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2D9AAC75;
        Wed, 11 Nov 2020 08:42:46 +0000 (UTC)
From:   Thomas Renninger <mail@renninger.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Off-topic therml_stats - trans_table - File too large (exceeding static page alloc)
Date:   Wed, 11 Nov 2020 09:42:45 +0100
Message-ID: <4294133.gPUqu62deI@c100>
In-Reply-To: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

sorry for high-jacking this thread, it is at least related and afaik you are
deeper involved in this:

(cutting CC list)

Am Dienstag, 10. November 2020, 12:07:37 CET schrieb Viresh Kumar:
> The cpufreq and thermal core, both provide sysfs statistics to help
> userspace learn about the behavior of frequencies and cooling states.
...
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state0 4097
There is the trans_table for cooling devices in the same dir:
/sys/devices/virtual/thermal/cooling_device*/stats/trans_table

I recently stumbled over this in a bug report and realized that it it seem
to overflow rather quickly due  to static memory usage.
Fixing it seem to be rather complex, not sure it's worth it.

for device 0-3 I get:
cat /sys/devices/virtual/thermal/cooling_device0/stats/trans_table
 From  :    To
       : state 0  
state 0:       0

and when it seem to get interesting (device 4 and 5), I get:
cat /sys/devices/virtual/thermal/cooling_device4/stats/trans_table
cat: /sys/devices/virtual/thermal/cooling_device4/stats/trans_table: File too large


Just a heads up.
Maybe it's worth to touch this as well if sysfs is changed in this area anyway.
Afaik sysfs forbids such data like whole transition tables in one file and dynamic
mem alloc.
Either it gets split up into
../cooling_device0/stats/trans_to_1
../cooling_device0/stats/trans_to_2
or maybe this should better live in debugfs?
or it could get reverted/deprecated?
or there might be another better solution to show this info...

No need to continue this off-topic thread.
Just a heads up in case someone has a neat idea...

           Thomas


