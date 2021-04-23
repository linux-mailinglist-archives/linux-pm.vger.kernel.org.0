Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3761D368DFB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbhDWHga (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 03:36:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:47082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWHga (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 03:36:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35199B008;
        Fri, 23 Apr 2021 07:35:53 +0000 (UTC)
Date:   Fri, 23 Apr 2021 09:35:51 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, joedecke@de.ibm.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle/pseries: Fixup CEDE0 latency only for POWER10
 onwards
Message-ID: <20210423073551.GZ6564@kitsune.suse.cz>
References: <1619104049-5118-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619104049-5118-1-git-send-email-ego@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 22, 2021 at 08:37:29PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
> of the Extended CEDE states advertised by the platform
> 
> On some of the POWER9 LPARs, the older firmwares advertise a very low
> value of 2us for CEDE1 exit latency on a Dedicated LPAR. However the
Can you be more specific about 'older firmwares'?

Also while this is a performance regression on such firmwares it
should be fixed by updating the firmware to current version.

Having sub-optimal performance on obsolete firmware should not require a
kernel workaround, should it?

It's not like the kernel would crash on the affected firmware.

Thanks

Michal
