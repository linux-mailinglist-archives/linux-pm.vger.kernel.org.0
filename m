Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E814F48
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEFPJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:09:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:62153 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfEFPJT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 May 2019 11:09:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 08:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="155580576"
Received: from spandruv-mobl3.jf.intel.com ([10.251.2.135])
  by FMSMGA003.fm.intel.com with ESMTP; 06 May 2019 08:09:18 -0700
Message-ID: <b7e0708b951b5848a1a8cd3be1e9cf1ffa112cb4.camel@linux.intel.com>
Subject: Re: [PATCH] drivers: thermal: processor_thermal: Downgrade error
 message
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 May 2019 08:09:18 -0700
In-Reply-To: <1557147020.2456.5.camel@intel.com>
References: <20190430034213.40028-1-srinivas.pandruvada@linux.intel.com>
         <1557147020.2456.5.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-05-06 at 20:50 +0800, Zhang Rui wrote:
> On 一, 2019-04-29 at 20:42 -0700, Srinivas Pandruvada wrote:
> > Downgrade "Unsupported event" message from dev_err to dev_dbg.
> > Otherwise it
> > floods with this message one some platforms.
> > 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.c
> > om>
> > ---
> >  .../thermal/intel/int340x_thermal/processor_thermal_device.c    |
> > 2
> > +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > index 4b206b594825..436c256f111d 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > @@ -275,7 +275,7 @@ static void proc_thermal_notify(acpi_handle
> > handle, u32 event, void *data)
> >  				THERMAL_DEVICE_POWER_CAPABILITY_CHAN
> > GED);
> >  		break;
> >  	default:
> > -		dev_err(proc_priv->dev, "Unsupported event
> > [0x%x]\n", event);
> > +		dev_dbg(proc_priv->dev, "Unsupported event
> > [0x%x]\n", event);
> >  		break;
> >  	}
> >  }
> 
> a similar patch has been applied, the only difference is that I'm
> using
> dev_notice instead.
> 
https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/commit
> /?h=next&id=3c7110fab805766450c5d2eac1c994d4c8c230d3

I think dev_notice still appear with non debug log level (!=7), so
dmesg from most distro will still have this print, which will concern
some users unnecessarily, which we can't do anything.

Thanks,
Srinivas

> 
> thanks,
> rui

