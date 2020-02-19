Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567D5164DBB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 19:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgBSSgG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 13:36:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:27984 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgBSSgG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Feb 2020 13:36:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 10:36:06 -0800
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; 
   d="scan'208";a="348991894"
Received: from ramya1g-mobl.gar.corp.intel.com ([10.252.147.199])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 10:36:03 -0800
Message-ID: <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
Subject: Re: Hard Disk consumes lots of power in s2idle
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-ide@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>
Date:   Wed, 19 Feb 2020 10:36:00 -0800
In-Reply-To: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
References: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kai,

On Wed, 2020-02-19 at 22:22 +0800, Kai-Heng Feng wrote:
> Hi Srinivas,
> 
> Your previous work to support DEVSLP works well on SATA SSDs, so I am
> asking you the issue I am facing:
> Once a laptop has a HDD installed, the power consumption during
> S2Idle increases ~0.4W, which is quite a lot.
> However, HDDs don't seem to support DEVSLP, so I wonder if you know
> to do proper power management for HDDs?
What is the default here
cat /sys/power/mem_sleep
s2idle or deep?

Please follow debug steps here:
https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux

We need to check whether you get any PC10 residency or not.

Thanks,
Srinivas


> 
> Kai-Heng

