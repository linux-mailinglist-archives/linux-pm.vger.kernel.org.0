Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE46D2217EA
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 00:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGOWoC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 18:44:02 -0400
Received: from cmta19.telus.net ([209.171.16.92]:57742 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgGOWoC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 18:44:02 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id vq85jpCCMpULuvq87jKKo9; Wed, 15 Jul 2020 16:44:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1594853040; bh=6ACtj8xaXsfbyulJytfvZMxPLfY5MKaSB3i29CQN+bA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=2QWHn1C2rMpO3Md+XvLmDhie6mraPML0mCIX6+IzlUZX9R2qjaOXOVeG6B8muei+/
         DCTNkZQmr45EakRdPg5zCGt0uE9wS889FGPqU9FN3IWdUAJcGnclLtAqIJPMSGp++s
         hkD3VF8osBjv6fzGQy8ibbwpWgrE4XDrPo5+l87wGrYT492xQwy9AkjyKQ916ULKl6
         LddlspODqYhJv9WtA0tdhCnZmtaXggY8ab93M6Ni3zcWYjRZdeCEECAhw2I8Js6QCE
         7ehBnQp9UiqQVoOBkIqZjyUB0ymArQ+bVyGv2Zi9mxpGcsY+0n+ThOny3Q87wR2kUZ
         N/gA2sX9Hiu3Q==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=T9TysMCQ c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8
 a=VwQbUJbxAAAA:8 a=oIXUCu8WpdxPYI8FhRMA:9 a=QEXdDO2ut3YA:10
 a=7715FyvI7WU-l6oqrZBK:22 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <000701d656be$c48083e0$4d818ba0$@net> <CAJZ5v0hKeHBNC2Bzdizm=42jtOqq8VOswCNNNk5HA9x_Y2T_Ng@mail.gmail.com>
In-Reply-To: <CAJZ5v0hKeHBNC2Bzdizm=42jtOqq8VOswCNNNk5HA9x_Y2T_Ng@mail.gmail.com>
Subject: RE: cpufreq: intel_pstate: EPB with performance governor
Date:   Wed, 15 Jul 2020 15:43:56 -0700
Message-ID: <001d01d65af9$6dd46180$497d2480$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZax5USJ7b0/bCwRGufashhLK3HEAALx4cQ
X-CMAE-Envelope: MS4wfAbsy4nFZBl2Ik2sEBL/LzYSn+U2ZtajmXuQ4viu7qY4XyrWvk9FgxEne9ka+WY5zPsefCl508QN11C/mOX0DFutu9tbjZ2gEcscNjbQbOdlSbi1l4kC
 cW9t/IALNFZ1MXiVrGOtk1tBJxYEx1e/Fu/24kEHHCuWR9ZaPxCUVit7YzKHv8mr29C2DcRYBiUjAKds496+ujRix8iT3WK6Moi7IICNdrF89bbRoKmC/4yi
 62lNvykfvR8FWiiK9/LOog==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thank you for your reply.

On 2020.07.15 09:47 Rafael J. Wysocki wrote:
> On Fri, Jul 10, 2020 at 3:34 PM Doug Smythies <dsmythies@telus.net> wrote:
> >
> > Hi Srinivas and/or Rafael,
> >
> > Can you please confirm or deny that an older
> > commit:
> >
> > commit 8442885fca09b2d26375b9fe507759879a6f661e
> > cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
> >
> > has been superseded by:
> >
> > arch/x86/kernel/cpu/intel_epb.c
> 
> No, it hasn't.
> 
> However, intel_pstate only touches the EPB if EPP is not supported,
> which should become a non-issue after this patch posted by me
> yesterday: https://patchwork.kernel.org/patch/11663315/
> 
> If EPP is supported, intel_pstate will use it and it will never look
> at the EPB even.
> 
> > and that now there is no way to have some default EPB (say 6) for
> > governors other than performance, while still getting an EPB of 0
> > for the performance governor.
> 
> If EPP is supported, what happens to the EPB is completely orthogonal
> to cpufreq etc.

Yes, I know.
I am talking about when HWP is disabled.

And I do not understand your reference to that patch from yesterday,
as it seems unrelated to me.

> 
> So it is possible to have the EPB different from 0, but it should be
> the same for all governors unless changed via energy_perf_bias.

And I am saying that contradicts the earlier referenced patch.
We want EPB set to 0 for performance mode, otherwise I challenge the
name "performance" governor.

Yes, EPB can be whatever for the other governors.

> 
> If EPP is not supported, though, then without the patch mentioned
> above, intel_pstate may fiddle with the EPB.
> 
> > Additional notes:
> > Both my test computers have EPB as 0 upon startup,
> 
> That is before intel_epb_init() runs, because it will change the EPB
> to "normal" (6).

Yes, I know.

> 
> > But I also tried this:
> >
> > diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> > index f4dd73396f28..b536e381cd56 100644
> > --- a/arch/x86/kernel/cpu/intel_epb.c
> > +++ b/arch/x86/kernel/cpu/intel_epb.c
> > @@ -74,7 +74,8 @@ static int intel_epb_save(void)
> >
> >  static void intel_epb_restore(void)
> >  {
> > -       u64 val = this_cpu_read(saved_epb);
> > +//     u64 val = this_cpu_read(saved_epb);
> > +       u64 val = 6;
> >         u64 epb;
> >
> >         rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> >
> > which did get rid of this message:
> > kernel: [    0.102158] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> 
> Which is exactly what happens when this message is printed.
> 
> Instead of commenting out the line of code above, which is not a
> correct thing to do in general,

Yes, of course. That was just a test, and the only way I could think of
to prove that the system started with it as 0.

> you can simply set the EPB to 0 via
> energy_perf_bias for all CPUs and it should stick.

And I am saying I should not have to do that, or even know about it,
when I want to use the performance governor.
But yes, I expect the driver to remember the default, or otherwise set,
value of EPB for all the other governors.

... Doug


