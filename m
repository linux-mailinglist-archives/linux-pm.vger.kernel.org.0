Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C29E2DF8C
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfE2OVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 10:21:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfE2OVK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 10:21:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41F19AEDB;
        Wed, 29 May 2019 14:21:09 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     ego@linux.vnet.ibm.com
Cc:     Abhishek Goel <huntbag@linux.vnet.ibm.com>, shuah@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpupower : frequency-set -r option misses the last cpu in related cpu list
Date:   Wed, 29 May 2019 16:21:08 +0200
Message-ID: <1825219.HmmgU4QcfA@house>
In-Reply-To: <CAHZ_5Ww2fMBGUR4gzNRZs-uV16j-hAevxT-vbNULRPsmKA7dow@mail.gmail.com>
References: <20190529093033.30068-1-huntbag@linux.vnet.ibm.com> <CAHZ_5Ww2fMBGUR4gzNRZs-uV16j-hAevxT-vbNULRPsmKA7dow@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wednesday, May 29, 2019 2:12:34 PM CEST Gautham R Shenoy wrote:
> Hi Abhishek,
> 
> On Wed, May 29, 2019 at 3:02 PM Abhishek Goel

...
 
> >                                 bitmask_setbit(cpus_chosen, cpus->cpu);
> >                                 cpus = cpus->next;
> >                         
> >                         }
> > 
> > +                       /* Set the last cpu in related cpus list */
> > +                       bitmask_setbit(cpus_chosen, cpus->cpu);
> 
> Perhaps you could convert the while() loop to a do ..  while(). That
> should will ensure
> that we terminate the loop after setting the last valid CPU.

It would do exactly the same, right?
IMHO it's not worth the extra hassle of resubmitting. Setting the last value 
outside a while loop is rather common.

I do not have a CPU with related cores at hand.
If you tested this it would be nice to see this pushed:

Reviewed-by: Thomas Renninger <trenn@suse.de>

Thanks!

   Thomas
