Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4971E11D57E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 19:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfLLS2i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 13:28:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:12749 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbfLLS2h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Dec 2019 13:28:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 10:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="239040465"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2019 10:18:02 -0800
Date:   Thu, 12 Dec 2019 10:18:02 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
Message-ID: <20191212181802.GH3163@linux.intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 12, 2019 at 03:13:45PM +0100, Paolo Bonzini wrote:
> On 12/12/19 13:26, Borislav Petkov wrote:
> > 
> > vmx flags       : virtual_nmis preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpriority tsc_offsetting virtual_tpr mtf virt_apic_accesses ept vpid unrestricted_guest ple shadow_vmcs pml mode_based_ept_exec

Tying into the consistency comment below, any objection to always prefixing
"ept" for relevant controls instead of following the SDM?  Specifically,
that would yield ept_mode_based_exec and ept_spp

> > 
> > virtual_nmis		-> vnmis
> 
> Even vnmi
> 
> > preemption_timer	-> preempt_tmr
> 
> I would prefer the full one here.
> 
> > flexpriority		-> flexprio
> 
> Full name?
> 
> > tsc_offsetting		-> tsc_ofs
> 
> tsc_offset?

I'll go with tsc_offset.

> > virtual_tpr		-> vtpr
> 
> Do we need this?  It's usually included together with flexpriority.
> 
> > virt_apic_accesses	-> vapic

Using v<feature> across the board makes sense to keep things consistent,
i.e. vnmi, vtpr, vapic, etc...

Anyone have thoughts on how to shorten "APIC-register virtualization"
without colliding with vapic or apicv?  I currently have apic_reg_virt,
which is a bit wordy.  apic_regv isn't awful, but I don't love it.

The other control that will be awkard is "Virtual Interrupt Delivery".
vint_delivery?

> > unrestricted_guest	-> unres_guest
> 
> Full? Or just unrestricted

I prefer unrestricted_guest, a bare unrestricted just makes me wonder
"unrestricted what?".   But I can live with "unrestricted" if that's the
consensus.

> In general I would stick to the same names as kvm_intel module
> parameters (sans "enable_" if applicable) and not even bother publishing
> the others.  Some features are either not used by KVM or available on
> all VMX processors.

IMO there's value in printing features that are not 1:1 with module params.

I also think it makes sense to print features of interest even if KVM
doesn't (yet) support the feature, e.g. to allow a user/developer to check
if they can use/test a KVM build with support for a new feature without
having to build and install the new kernel.

> Paolo
> 
> > and so on. Those are just my examples - I betcha the SDM is more
> > creative here with abbreviations. But you guys are going to grep for
> > them. If it were me, I'd save on typing. :-)
