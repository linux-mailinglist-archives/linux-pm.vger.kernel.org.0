Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EC1EC2B9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 13:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfKAMeC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 08:34:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4650 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKAMeC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 08:34:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dbc26400000>; Fri, 01 Nov 2019 05:34:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Nov 2019 05:34:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Nov 2019 05:34:01 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 1 Nov
 2019 12:34:01 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 2D99742966; Fri,  1 Nov 2019 14:33:59 +0200 (EET)
Date:   Fri, 1 Nov 2019 14:33:59 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/18] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
Message-ID: <20191101123359.GG27141@pdeschrijver-desktop.Nvidia.com>
References: <20191015170015.1135-1-digetx@gmail.com>
 <20191016192133.GB26038@pdeschrijver-desktop.Nvidia.com>
 <72636eb3-5354-eea3-3a51-4975a04186b2@gmail.com>
 <53ee8bd3-5c53-f0aa-175c-7fa3024d0af5@gmail.com>
 <20191028140443.GA27141@pdeschrijver-desktop.Nvidia.com>
 <40de641f-c38e-51ee-ae27-c5db468c45b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <40de641f-c38e-51ee-ae27-c5db468c45b5@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572611648; bh=ClHEOCZNpQnrcTnVEWCJjHR07pbg7qvno12Y8tH2Dy8=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=JPm8R1IH6Np2IGI6y3kIMTOJ1rP/8Pi2c76MBsBfFNDkpBX901NBpRClwnNreTgEA
         qLExi2OcAxxXyaLsmVGDlzxVKZCFbZX8+dnqSIEeaFKzH3T+m7UvU4BbDPd6CYd2Hb
         2C/Nr53Dkt9wFk1K/NG0z6FRmVRTgbZzsIWOLmi7iqgl8fLUdV3nmiOu9fbcQI0bJU
         YCE8cefv6mBzfFUsp/YWJ1RbTDJleWRvHL3mMIK+RWYPBmJbnz3ALNrNs/8EW4VlBs
         4+j7XujCFSVktQig4fJTqLqwcK1o60tENBkdb5FAQwIIbTEz26Nr2lC1jW0+SscMt2
         jtOP5Lk1c2L8Q==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 03:47:56AM +0300, Dmitry Osipenko wrote:
..

> >>>> It would be useful to switch the power state terminology to the one used
> >>>> for later chips:
> >>>>
> >>>> LP0 becomes SC7
> >>>> LP1 becomes C1
> >>>> LP2 becomes CC7
> >>>>
> >>>> Meaning of these states is as follows
> >>>>
> >>>> C is a core state:
> >>>>
> >>>> C1 clock gating
> >>>> C2 not defined
> >>>> C3 not defined
> >>>> C4 not defined
> >>>> C5 not defined
> >>>> C6 not defined for ARM cores
> >>>> C7 power-gating
> >>>>
> >>>> CC is a CPU cluster C state:
> >>>>
> >>>> CC1 cluster clock gated
> >>>> CC2 not defined
> >>>> CC3 fmax@Vmin: not used prior to Tegra186
> >>>> CC4: cluster retention: no longer supported
> >>>> CC5: not defined
> >>>> CC6: cluster power gating
> >>>> CC7: cluster rail gating
> >>>>
> >>>> SC is a System C state:
> >>>>
> >>>> SC1: not defined
> >>>> SC2: not defined
> >>>> SC3: not defined
> >>>> SC4: not defined
> >>>> SC5: not defined
> >>>> SC6: not defined
> >>>> SC7: VDD_SOC off
> >>>
> >>> Hello Peter,
> >>>
> >>> But new "drivers/cpuidle/cpuidle-tegra.c" uses exactly that terminology,
> >>> please see "cpuidle: Refactor and move NVIDIA Tegra20 driver into
> >>> drivers/cpuidle/" and further patches. Am I missing something? Or do you
> >>> want the renaming to be a separate patch?
> >>>
> >>
> >> Or maybe you're suggesting to change the names everywhere and not only
> >> in the cpuidle driver? Please clarify :)
> > 
> > At least some of the variable and function names still say lp2?
> 
> The cpuidle driver uses LP2 terminology for everything that comes from
> the external arch / firmware includes. But it says CC6 for everything
> that is internal to the driver. So yes, there is a bit of new/old
> terminology mixing in the code.
> 
> The arch code / PMC driver / TF firmware are all saying LP2. The LP2
> naming is also a part of the device-tree binding.
> 
> It will be a lot of mess to rename the mach-tegra/pm.c code. I guess
> eventually it could be moved to drivers/soc/, so maybe it will be better
> to postpone the renaming until then?

Or maybe add a comment somewhere indicating:

LP2 = CC6
LP1 = C1
LP0 = SC7

TF predates the new naming, so that may make some sense.

Peter.
