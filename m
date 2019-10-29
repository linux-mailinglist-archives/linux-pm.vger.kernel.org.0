Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA26E92F0
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfJ2WPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:15:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:20625 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJ2WPS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 18:15:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 15:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="diff'?scan'208";a="225127666"
Received: from spandruv-mobl3.jf.intel.com ([10.255.229.217])
  by fmsmga004.fm.intel.com with ESMTP; 29 Oct 2019 15:15:16 -0700
Message-ID: <aaff9d379a325e5500651ca2f2e2ec7e21c245e3.camel@linux.intel.com>
Subject: Re: "Force HWP min perf before offline" triggers unchecked MSR
 access errors
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Oct 2019 15:15:16 -0700
In-Reply-To: <53fc01bf9ef25012a1a43b87954b62a02101d85c.camel@linux.intel.com>
References: <CAJZ5v0g6_-HBEKfHtfe8LFG9PKosGeUW3-gwTBW6F32OwFwO3g@mail.gmail.com>
         <A94C23C3-E6B9-4390-B380-C49D87731D81@lca.pw>
         <53fc01bf9ef25012a1a43b87954b62a02101d85c.camel@linux.intel.com>
Content-Type: multipart/mixed; boundary="=-EbG5otTQwJdOLYnc5Foy"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-EbG5otTQwJdOLYnc5Foy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2019-10-29 at 15:13 -0700, Srinivas Pandruvada wrote:
> On Tue, 2019-10-29 at 18:01 -0400, Qian Cai wrote:
> > > On Oct 29, 2019, at 5:47 PM, Rafael J. Wysocki <rafael@kernel.org
> > > >
> > > wrote:
> > > 
> > > The MSR_IA32_ENERGY_PERF_BIAS MSR appears to be not present,
> > > which
> > > should be caught by the X86_FEATURE_EPB check in
> > > intel_pstate_set_epb().
> > > 
> > > Do you run this in a guest perchance?
> > 
> > No, it is a baremetal HPE server. The dmesg does say something like
> > energy perf bias changed from performance to normal, and the
> > cpuflag
> > contains epb which I thought that would pass the feature check? I
> > could upload the whole dmesg a bit later if that helps.
> 
> Try the attached change. You have a Skylake server with no EPP
> support.
> This is odd.
> 
Sorry.
Ignore the previous one. It had some unrelated change.

> Thanks,
> Srinivas
> 

--=-EbG5otTQwJdOLYnc5Foy
Content-Disposition: attachment; filename="epb_power.diff"
Content-Type: text/x-patch; name="epb_power.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyBiL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYwppbmRleCA5ZjAyZGU5YTFiNDcuLmVhYjhiMDQ4ZGM5ZiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCisrKyBiL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYwpAQCAtODUxLDcgKzg1MSw3IEBAIHN0YXRpYyB2b2lkIGludGVs
X3BzdGF0ZV9od3BfZm9yY2VfbWluX3BlcmYoaW50IGNwdSkKIAlpZiAoYm9vdF9jcHVfaGFzKFg4
Nl9GRUFUVVJFX0hXUF9FUFApKQogCQl2YWx1ZSB8PSBIV1BfRU5FUkdZX1BFUkZfUFJFRkVSRU5D
RShIV1BfRVBQX1BPV0VSU0FWRSk7CiAJZWxzZQotCQlpbnRlbF9wc3RhdGVfc2V0X2VwYihjcHUs
IEhXUF9FUFBfQkFMQU5DRV9QT1dFUlNBVkUpOworCQlpbnRlbF9wc3RhdGVfc2V0X2VwYihjcHUs
IDB4MEYpOwogCiAJd3Jtc3JsX29uX2NwdShjcHUsIE1TUl9IV1BfUkVRVUVTVCwgdmFsdWUpOwog
fQo=


--=-EbG5otTQwJdOLYnc5Foy--

