Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA66E92E8
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfJ2WNc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:13:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:27222 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2WNc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 18:13:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 15:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="diff'?scan'208";a="198501923"
Received: from spandruv-mobl3.jf.intel.com ([10.255.229.217])
  by fmsmga008.fm.intel.com with ESMTP; 29 Oct 2019 15:13:31 -0700
Message-ID: <53fc01bf9ef25012a1a43b87954b62a02101d85c.camel@linux.intel.com>
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
Date:   Tue, 29 Oct 2019 15:13:30 -0700
In-Reply-To: <A94C23C3-E6B9-4390-B380-C49D87731D81@lca.pw>
References: <CAJZ5v0g6_-HBEKfHtfe8LFG9PKosGeUW3-gwTBW6F32OwFwO3g@mail.gmail.com>
         <A94C23C3-E6B9-4390-B380-C49D87731D81@lca.pw>
Content-Type: multipart/mixed; boundary="=-QOLy+FCNmsPb1Mw2UaNS"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-QOLy+FCNmsPb1Mw2UaNS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2019-10-29 at 18:01 -0400, Qian Cai wrote:
> > On Oct 29, 2019, at 5:47 PM, Rafael J. Wysocki <rafael@kernel.org>
> > wrote:
> > 
> > The MSR_IA32_ENERGY_PERF_BIAS MSR appears to be not present, which
> > should be caught by the X86_FEATURE_EPB check in
> > intel_pstate_set_epb().
> > 
> > Do you run this in a guest perchance?
> 
> No, it is a baremetal HPE server. The dmesg does say something like
> energy perf bias changed from performance to normal, and the cpuflag
> contains epb which I thought that would pass the feature check? I
> could upload the whole dmesg a bit later if that helps.

Try the attached change. You have a Skylake server with no EPP support.
This is odd.

Thanks,
Srinivas


--=-QOLy+FCNmsPb1Mw2UaNS
Content-Disposition: attachment; filename="epb_power.diff"
Content-Type: text/x-patch; name="epb_power.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfdGhlcm1hbC5jIGIvZHJpdmVycy9h
Y3BpL3Byb2Nlc3Nvcl90aGVybWFsLmMKaW5kZXggZWMyNjM4ZjFkZjRmLi5mNzBmNzQ2ZWQ1OGQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfdGhlcm1hbC5jCisrKyBiL2RyaXZl
cnMvYWNwaS9wcm9jZXNzb3JfdGhlcm1hbC5jCkBAIC0xMzAsNiArMTMwLDcgQEAgdm9pZCBhY3Bp
X3RoZXJtYWxfY3B1ZnJlcV9pbml0KGludCBjcHUpCiAJc3RydWN0IGFjcGlfcHJvY2Vzc29yICpw
ciA9IHBlcl9jcHUocHJvY2Vzc29ycywgY3B1KTsKIAlpbnQgcmV0OwogCisJbWVtc2V0KCZwci0+
dGhlcm1hbF9yZXEsIDAsIHNpemVvZihwci0+dGhlcm1hbF9yZXEpKTsKIAlyZXQgPSBkZXZfcG1f
cW9zX2FkZF9yZXF1ZXN0KGdldF9jcHVfZGV2aWNlKGNwdSksCiAJCQkJICAgICAmcHItPnRoZXJt
YWxfcmVxLCBERVZfUE1fUU9TX01BWF9GUkVRVUVOQ1ksCiAJCQkJICAgICBJTlRfTUFYKTsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyBiL2RyaXZlcnMvY3B1ZnJl
cS9pbnRlbF9wc3RhdGUuYwppbmRleCA5ZjAyZGU5YTFiNDcuLmVhYjhiMDQ4ZGM5ZiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCisrKyBiL2RyaXZlcnMvY3B1ZnJl
cS9pbnRlbF9wc3RhdGUuYwpAQCAtODUxLDcgKzg1MSw3IEBAIHN0YXRpYyB2b2lkIGludGVsX3Bz
dGF0ZV9od3BfZm9yY2VfbWluX3BlcmYoaW50IGNwdSkKIAlpZiAoYm9vdF9jcHVfaGFzKFg4Nl9G
RUFUVVJFX0hXUF9FUFApKQogCQl2YWx1ZSB8PSBIV1BfRU5FUkdZX1BFUkZfUFJFRkVSRU5DRShI
V1BfRVBQX1BPV0VSU0FWRSk7CiAJZWxzZQotCQlpbnRlbF9wc3RhdGVfc2V0X2VwYihjcHUsIEhX
UF9FUFBfQkFMQU5DRV9QT1dFUlNBVkUpOworCQlpbnRlbF9wc3RhdGVfc2V0X2VwYihjcHUsIDB4
MEYpOwogCiAJd3Jtc3JsX29uX2NwdShjcHUsIE1TUl9IV1BfUkVRVUVTVCwgdmFsdWUpOwogfQo=


--=-QOLy+FCNmsPb1Mw2UaNS--

