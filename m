Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6161ACE5D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgDPRFm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 13:05:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:7539 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbgDPRFl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 13:05:41 -0400
IronPort-SDR: ZtviEUcwAw04AQ6vGY2G6qGqhVhluMbOfUY9MOTyDKQ/HBJlrfEQCTppp6icNF6lCYwwlEBLwe
 lgH+ydAGIQXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 10:05:40 -0700
IronPort-SDR: r2p37llV8oTWEX2XJNI4HUD191O2WCdTioOapylF9eDQt2rnWXEtqiqUUUL7PgwyfxBRBlAi4M
 pxaUQq64DoUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="257290016"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga006.jf.intel.com with ESMTP; 16 Apr 2020 10:05:39 -0700
Date:   Fri, 17 Apr 2020 01:06:11 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Len Brown' <lenb@kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3][v2] tools/power turbostat: Introduce functions to
 accumulate RAPL consumption
Message-ID: <20200416170611.GA23628@chenyu-office.sh.intel.com>
References: <cover.1586782089.git.yu.c.chen@intel.com>
 <db96fd31afd0ff65e4041665293b96c984e675bc.1586782089.git.yu.c.chen@intel.com>
 <001901d613a4$010e0a70$032a1f50$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901d613a4$010e0a70$032a1f50$@net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,
Thanks for reviewing this patch.
On Wed, Apr 15, 2020 at 09:03:34PM -0700, Doug Smythies wrote:
> On 2020.04.15 05:57 Chen Yu wrote:
> 
> ...
> 
> > v2: According to Len's suggestion:
> >    1. Enable the accumulated RAPL mechanism by default.
> 
> I am not a fan of this, but O.K.
> 
> >    2. Re-use the rapl_joule_counter_range to represent the
> >       the timeout of periodical timer.
> 
> No, please no. It is too easy to still have an overflow.
> 
> ...
> > +	/*
> > +	 * A wraparound time is calculated early.
> > +	 */
> > +	its.it_interval.tv_sec = rapl_joule_counter_range;
> 
> Would this be o.K.?
> 
> +	its.it_interval.tv_sec = rapl_joule_counter_range / 2;
> 
This should be okay. I've checked the defination of TDP, and
on a wiki page it has mentioned that[1]:
"Some sources state that the peak power for a microprocessor
is usually 1.5 times the TDP rating"
although the defination of TDP varies, using 2 * TDP should
be safe.
> > +	its.it_interval.tv_nsec = 0;
> 
> The way it was sent, this patch set does not work.
> It still overflows.
> 
> Example, sample time calculated to ensure overflow:
> 
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 100.00  3500    3592125 80      9.72    0.12
> 100.00  3500    3587391 79      9.77    0.12
> 
> Actual package watts was around 65.
> 
> However, if this additional patch is applied (I only fixed one of them):
> 
> doug@s18:~/temp-k-git/linux/tools/power/x86/turbostat$ git diff
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 29fc4069f467..4d72d9be5209 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1350,7 +1350,8 @@ delta_package(struct pkg_data *new, struct pkg_data *old)
> 
>         old->gfx_mhz = new->gfx_mhz;
> 
> -       DELTA_WRAP32(new->energy_pkg, old->energy_pkg);
> +/*     DELTA_WRAP32(new->energy_pkg, old->energy_pkg);  */
> +       old->energy_pkg = new->energy_pkg - old->energy_pkg;
>         DELTA_WRAP32(new->energy_cores, old->energy_cores);
>         DELTA_WRAP32(new->energy_gfx, old->energy_gfx);
>         DELTA_WRAP32(new->energy_dram, old->energy_dram);
> 
> Then it seems to work.
> 
Nice catch, I did not realize that the energy_pkg field has
already been converted into accumuted variable which does not
need to consider the wrapping(64bit should be long enough for
normal test cases).

Thanks,
Chenyu
> Example:
> 
> doug@s15:~/temp-turbostat$ sudo ./turbostat --Summary --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 1200
> ...
> RAPL: 690 sec. Joule Counter Range, at 95 Watts
> ...
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 100.00  3500    3592328 80      64.32   0.12
> 100.00  3500    3595195 79      64.37   0.12
> 
> ... Doug
> 
> 
