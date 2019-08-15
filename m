Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27348F62E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfHOVER (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 17:04:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOVER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 17:04:17 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyMup-000685-8z; Thu, 15 Aug 2019 23:04:11 +0200
Date:   Thu, 15 Aug 2019 23:04:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family
 15h/16h
In-Reply-To: <a24a2c7d-cfab-a049-37e8-7260a9063a7c@citrix.com>
Message-ID: <alpine.DEB.2.21.1908152301300.1908@nanos.tec.linutronix.de>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com> <a24a2c7d-cfab-a049-37e8-7260a9063a7c@citrix.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1612320073-1565903051=:1908"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1612320073-1565903051=:1908
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 15 Aug 2019, Andrew Cooper wrote:

> On 14/08/2019 22:17, Lendacky, Thomas wrote:
> > +static void init_hide_rdrand(struct cpuinfo_x86 *c)
> > +{
> > +	/*
> > +	 * The nordrand option can clear X86_FEATURE_RDRAND, so check for
> > +	 * RDRAND support using the CPUID function directly.
> > +	 */
> > +	if (!(cpuid_ecx(1) & BIT(30)) || rdrand_force)
> > +		return;
> > +
> > +	msr_clear_bit(MSR_AMD64_CPUID_FN_00000001, 62);
> > +	clear_cpu_cap(c, X86_FEATURE_RDRAND);
> > +	pr_info_once("hiding RDRAND via CPUID\n");
> 
> If you're virtualised, the write to MSR_AMD64_CPUID_FN_1 almost
> certainly won't take effect, which means userspace will still be able to
> see the bit.
> 
> Best to leave everything untouched if you can't actually clear the bit. 
> All you can do is trust that your hypervisor knows what it is doing.

Well, we can read the CPUID entry again after writing that MSR bit. If it
still says RDRAND is available then we know that the hypervisor did not
allow the write and print something to that effect.

Thanks,

	tglx
--8323329-1612320073-1565903051=:1908--
