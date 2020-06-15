Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5F1F9ACE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgFOOuF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 10:50:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:31388 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgFOOuD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jun 2020 10:50:03 -0400
IronPort-SDR: 07sYa3DN4r8wWMaZTh55VIIE11Ny33YsK85Drf/k3U35DXOod/175iqMgJ+IZ34jx9jtChoojC
 tGAAFxxtOxJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 07:50:02 -0700
IronPort-SDR: suM3XximiGcQGJthmCzARsx7To90s99gOsXEcJemdjzD4FW/OL61W0O90GO1mHVDcvatAvBWtx
 wvzxtsKnr+1g==
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="476042238"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 07:50:01 -0700
Message-ID: <260f56be4fa1d2e61f3b7250cc2562cd63dd914e.camel@linux.intel.com>
Subject: Re: [THERMAL] INT3403 and new 0x91 thermal events in dmesg
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Alex Hung <alex.hung@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com
Date:   Mon, 15 Jun 2020 07:49:50 -0700
In-Reply-To: <990f39d9-82b8-73fe-e956-f5d7423a0616@canonical.com>
References: <ee531821-83f1-2c80-4e2c-b2a359af7583@canonical.com>
         <779a84cab9e01cbb8cafaea59ead79b26a2573df.camel@intel.com>
         <990f39d9-82b8-73fe-e956-f5d7423a0616@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2020-06-14 at 22:16 -0600, Alex Hung wrote:
> On 2020-06-13 8:44 p.m., Zhang Rui wrote:
> > On Fri, 2020-06-12 at 15:02 -0600, Alex Hung wrote:
> > > Hi,
> > > 
> > > A user reported int3403 was flooding his dmesg like following
> > > 
> > > [ 8.112761] int3403 thermal INT3403:00: Unsupported event [0x91]
> > > [ 10.121722] int3403 thermal INT3403:00: Unsupported event [0x91]
> > > [ 12.165233] int3403 thermal INT3403:00: Unsupported event [0x91]
> > > 
> > > Buglink: 
> > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1882823
> > > 
> > > In int3403_thermal.c the events are defined up to
> > > INT3403_THERMAL_EVENT
> > > (0x90), and thus int3403 complains 0x91 is not supported.
> > > 
> > > I did a quick search online and found this is not the only case:
> > > https://www.spinics.net/lists/ibm-acpi-devel/msg04629.html
> > > (though
> > > the
> > > 0x91 was unrelated to this problem).
> > > 
> > > This is likely a new feature in int3403 but I wasn't able to find
> > > any
> > > specifications or documents. Does anyone know what it is and how
> > > this
> > > can be added to int3403_thermal.c ?
> > > 
> > I'm not sure if this is a new feature that we have to support or
> > not,
> > but before that, we can downgrade the error message just like what
> > we
> > did in 44c0c23725a1("drivers: thermal: processor_thermal: Downgrade
> > error message").
> 
> Thanks for suggestions. I will send a patch to downgrade the error
> message.
> 
> Would it be a good idea to cc stable?
Downgrade and CC to stable is fine.

Thanks,
Srinivas

> 
> 
> Cheers,
> Alex Hung
> 
> > thanks,
> > rui
> > 
> > 

