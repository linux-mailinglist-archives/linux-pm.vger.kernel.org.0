Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E573698A0
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhDWRpp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 13:45:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:48372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhDWRpp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 13:45:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2562B19B;
        Fri, 23 Apr 2021 17:45:07 +0000 (UTC)
Date:   Fri, 23 Apr 2021 19:45:05 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, joedecke@de.ibm.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle/pseries: Fixup CEDE0 latency only for POWER10
 onwards
Message-ID: <20210423174505.GE6564@kitsune.suse.cz>
References: <1619104049-5118-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210423073551.GZ6564@kitsune.suse.cz>
 <YILu6/GK+RwpskCc@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YILu6/GK+RwpskCc@drishya.in.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 09:29:39PM +0530, Vaidyanathan Srinivasan wrote:
> * Michal Such?nek <msuchanek@suse.de> [2021-04-23 09:35:51]:
> 
> > On Thu, Apr 22, 2021 at 08:37:29PM +0530, Gautham R. Shenoy wrote:
> > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > > 
> > > Commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> > > CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
> > > of the Extended CEDE states advertised by the platform
> > > 
> > > On some of the POWER9 LPARs, the older firmwares advertise a very low
> > > value of 2us for CEDE1 exit latency on a Dedicated LPAR. However the
> > Can you be more specific about 'older firmwares'?
> 
> Hi Michal,
> 
> This is POWER9 vs POWER10 difference, not really an obsolete FW.  The
> key idea behind the original patch was to make the H_CEDE latency and
> hence target residency come from firmware instead of being decided by
> the kernel.  The advantage is such that, different type of systems in
> POWER10 generation can adjust this value and have an optimal H_CEDE
> entry criteria which balances good single thread performance and
> wakeup latency.  Further we can have additional H_CEDE state to feed
> into the cpuidle.  

So all POWER9 machines are affected by the firmware bug where firmware
reports CEDE1 exit latency of 2us and the real latency is 5us which
causes the kernel to prefer CEDE1 too much when relying on the values
supplied by the firmware. It is not about 'older firmware'.

I still think it would be preferrable to adjust the latency value
reported by the firmware to match reality over a kernel workaround.

Thanks

Michal
