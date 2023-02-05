Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D92468AE1C
	for <lists+linux-pm@lfdr.de>; Sun,  5 Feb 2023 04:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBEDBT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Feb 2023 22:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBEDBS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Feb 2023 22:01:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF514481;
        Sat,  4 Feb 2023 19:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675566077; x=1707102077;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=J5rKfO/Yu/v6wy9vkPDjCdZqVkB933t7NlbkQ9vNOk4=;
  b=OoS2zxQtslL8pHXN9vrXPkruZiQQiub29nYLxSKonx9EiJcBoBLA5Rir
   dBOVhNI5+/fR9FLrttNvhuPfYT8WM/vMipzJoKIKvGkNhbm4C/TLcXNnC
   GRJz8EH8TQy/m1pRS/E0o5eVRl99q3Mw36Ymi8lV+AHNv83p4iKVA907D
   8m563OyAnWiSBh7tQUYN8Px9pGZ+x8egbdThwRLmQq2RrbvubOKni5r7S
   Q1FcRBN5JZ3z46+48fvObSMGsBHfD+UD26zxzCfDOVdRiTZWmwsZNWbUl
   3cvyOSADSoEB+EFZJvoWna8slPuKjuPP276/7t3j/0esccPhwHXBA9Jyf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="329027578"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="329027578"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 19:01:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="668067210"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="668067210"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.8])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 19:01:16 -0800
Message-ID: <59013edba75633f2f1afec284c7aaa0baf36f06e.camel@linux.intel.com>
Subject: Re: [PATCH v5 4/4] thermal/drivers/intel_powerclamp: Add additional
 module params
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Date:   Sat, 04 Feb 2023 19:01:15 -0800
In-Reply-To: <ef3ded05dfc68b89c01f712bf54bc021ef33cc6d.camel@intel.com>
References: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com>
         <20230201182854.2158535-5-srinivas.pandruvada@linux.intel.com>
         <ef3ded05dfc68b89c01f712bf54bc021ef33cc6d.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUnVpLAoKPiAKWy4uLl0KCj4gI2lmZGVmIENPTkZJR19DUFVNQVNLX09GRlNUQUNLCj4gdHlw
ZWRlZiBzdHJ1Y3QgY3B1bWFzayAqY3B1bWFza192YXJfdDsKPiAjZWxzZQo+IHR5cGVkZWYgc3Ry
dWN0IGNwdW1hc2sgY3B1bWFza192YXJfdFsxXTsKPiBmaQo+IAo+IEkgaGFwcGVuZWQgdG8gYnVp
bGQgd2l0aCBDT05GSUdfQ1BVTUFTS19PRkZTVEFDSyBjbGVhcmVkLCBhbmQgZ290Cj4gZm9sbG93
aW5nIGVycm9ycwo+IAo+IApUcnkgdjIgZm9yIHRoZSBtb2R1bGUgcGFyYW1ldGVycwoKVGhhbmtz
LApTcmluaXZhcwoKPiAkIG1ha2UKPiDCoCBDQUxMwqDCoMKgIHNjcmlwdHMvY2hlY2tzeXNjYWxs
cy5zaAo+IMKgIERFU0NFTkQgb2JqdG9vbAo+IMKgIEFSwqDCoMKgwqDCoCBkcml2ZXJzL3RoZXJt
YWwvaW50ZWwvYnVpbHQtaW4uYQo+IMKgIENDIFtNXcKgIGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9p
bnRlbF9wb3dlcmNsYW1wLm8KPiBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfcG93ZXJjbGFt
cC5jOiBJbiBmdW5jdGlvbgo+IOKAmGFsbG9jYXRlX2lkbGVfaW5qZWN0aW9uX21hc2vigJk6Cj4g
ZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3Bvd2VyY2xhbXAuYzoxMjI6NjogZXJyb3I6IHRo
ZSBhZGRyZXNzIG9mCj4g4oCYaWRsZV9pbmplY3Rpb25fY3B1X21hc2vigJkgd2lsbCBhbHdheXMg
ZXZhbHVhdGUgYXMg4oCYdHJ1ZeKAmSBbLQo+IFdlcnJvcj1hZGRyZXNzXQo+IMKgIDEyMiB8wqAg
aWYgKCFpZGxlX2luamVjdGlvbl9jcHVfbWFzaykgewo+IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqAg
Xgo+IGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9wb3dlcmNsYW1wLmM6IEluIGZ1bmN0aW9u
IOKAmGNwdW1hc2tfZ2V04oCZOgo+IGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9wb3dlcmNs
YW1wLmM6MTgzOjY6IGVycm9yOiB0aGUgYWRkcmVzcyBvZgo+IOKAmGlkbGVfaW5qZWN0aW9uX2Nw
dV9tYXNr4oCZIHdpbGwgYWx3YXlzIGV2YWx1YXRlIGFzIOKAmHRydWXigJkgWy0KPiBXZXJyb3I9
YWRkcmVzc10KPiDCoCAxODMgfMKgIGlmICghaWRsZV9pbmplY3Rpb25fY3B1X21hc2spCj4gwqDC
oMKgwqDCoCB8wqDCoMKgwqDCoCBeCj4gZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3Bvd2Vy
Y2xhbXAuYzogSW4gZnVuY3Rpb24g4oCYbWF4X2lkbGVfc2V04oCZOgo+IGRyaXZlcnMvdGhlcm1h
bC9pbnRlbC9pbnRlbF9wb3dlcmNsYW1wLmM6MjIwOjY6IGVycm9yOiB0aGUgYWRkcmVzcyBvZgo+
IOKAmGlkbGVfaW5qZWN0aW9uX2NwdV9tYXNr4oCZIHdpbGwgYWx3YXlzIGV2YWx1YXRlIGFzIOKA
mHRydWXigJkgWy0KPiBXZXJyb3I9YWRkcmVzc10KPiDCoCAyMjAgfMKgIGlmIChpZGxlX2luamVj
dGlvbl9jcHVfbWFzayAmJgo+IGNwdW1hc2tfZXF1YWwoY3B1X3ByZXNlbnRfbWFzaywgaWRsZV9p
bmplY3Rpb25fY3B1X21hc2spICYmCj4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoCBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgo+IGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9wb3dlcmNsYW1wLmM6
IEluIGZ1bmN0aW9uCj4g4oCYcG93ZXJjbGFtcF9leGl04oCZOgo+IGRyaXZlcnMvdGhlcm1hbC9p
bnRlbC9pbnRlbF9wb3dlcmNsYW1wLmM6ODI1OjY6IGVycm9yOiB0aGUgYWRkcmVzcyBvZgo+IOKA
mGlkbGVfaW5qZWN0aW9uX2NwdV9tYXNr4oCZIHdpbGwgYWx3YXlzIGV2YWx1YXRlIGFzIOKAmHRy
dWXigJkgWy0KPiBXZXJyb3I9YWRkcmVzc10KPiDCoCA4MjUgfMKgIGlmIChpZGxlX2luamVjdGlv
bl9jcHVfbWFzaykKPiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+Cj4gY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKPiBtYWtlWzRd
OiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjUyOgo+IGRyaXZlcnMvdGhlcm1hbC9pbnRl
bC9pbnRlbF9wb3dlcmNsYW1wLm9dIEVycm9yIDEKPiBtYWtlWzNdOiAqKiogW3NjcmlwdHMvTWFr
ZWZpbGUuYnVpbGQ6NTA0OiBkcml2ZXJzL3RoZXJtYWwvaW50ZWxdCj4gRXJyb3IgMgo+IG1ha2Vb
Ml06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDQ6IGRyaXZlcnMvdGhlcm1hbF0gRXJy
b3IgMgo+IG1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDQ6IGRyaXZlcnNd
IEVycm9yIDIKPiBtYWtlOiAqKiogW01ha2VmaWxlOjIwMjE6IC5dIEVycm9yIDIKPiAKPiA+ICsK
PiA+ICtzdGF0aWMgaW50IGFsbG9jYXRlX2lkbGVfaW5qZWN0aW9uX21hc2sodm9pZCkKPiA+ICt7
Cj4gPiArwqDCoMKgwqDCoMKgwqAvKiBUaGlzIG1hc2sgaXMgYWxsb2NhdGVkIG9ubHkgb25lIHRp
bWUgYW5kIGZyZWVkIGR1cmluZwo+ID4gbW9kdWxlCj4gPiBleGl0ICovCj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAoIWlkbGVfaW5qZWN0aW9uX2NwdV9tYXNrKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKCF6YWxsb2NfY3B1bWFza192YXIoJmlkbGVfaW5qZWN0aW9uX2Nw
dV9tYXNrLAo+ID4gR0ZQX0tFUk5FTCkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNwdW1hc2tfY29weShpZGxlX2luamVjdGlvbl9jcHVfbWFzaywK
PiA+IGNwdV9wcmVzZW50X21hc2spOwo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyBpbnQgY3B1bWFz
a19zZXQoY29uc3QgY2hhciAqYXJnLCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtCj4gPiAqa3Ap
Cj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgaW50IHJldDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoG11dGV4X2xvY2soJnBvd2VyY2xhbXBfbG9jayk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
wqAvKiBDYW4ndCBzZXQgbWFzayB3aGVuIGNvb2xpbmcgZGV2aWNlIGlzIGluIHVzZSAqLwo+ID4g
K8KgwqDCoMKgwqDCoMKgaWYgKHBvd2VyY2xhbXBfZGF0YS5jbGFtcGluZykgewo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IC1FQUdBSU47Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZ290byBza2lwX2NwdW1hc2tfc2V0Owo+ID4gK8KgwqDCoMKgwqDC
oMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFdo
ZW4gbW9kdWxlIHBhcmFtZXRlcnMgYXJlIHBhc3NlZCBmcm9tIGtlcm5lbCBjb21tYW5kCj4gPiBs
aW5lCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBkdXJpbmcgaW5zbW9kLCB0aGUgbW9kdWxlIHBhcmFt
ZXRlciBjYWxsYmFjayBpcyBjYWxsZWQKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGJlZm9yZSBwb3dl
cmNsYW1wX2luaXQoKSwgc28gd2UgY2FuJ3QgYXNzdW1lIHRoYXQgc29tZQo+ID4gK8KgwqDCoMKg
wqDCoMKgICogY3B1bWFzayBjYW4gYmUgYWxsb2NhdGVkIGJlZm9yZSBoZXJlLgo+ID4gK8KgwqDC
oMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBhbGxvY2F0ZV9pZGxlX2luamVj
dGlvbl9tYXNrKCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gc2tpcF9jcHVtYXNrX3NldDsKPiA+ICsKPiAKPiBKdXN0
IGEgc3VnZ2VzdGlvbiwgY2FuIHdlIGhhdmUgYSBxdWljayBwYXRoIGZvciByZXN0b3JpbmcgdG8g
YWxsIGNwdQo+IG1vZGU/Cj4gCj4gU2F5LCBlY2hvID4gL3N5cy9tb2R1bGUvaW50ZWxfcG93ZXJj
bGFtcC9wYXJhbWV0ZXJzL2NwdW1hc2sKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9IGJpdG1h
cF9wYXJzZShhcmcsIHN0cmxlbihhcmcpLAo+ID4gY3B1bWFza19iaXRzKGlkbGVfaW5qZWN0aW9u
X2NwdV9tYXNrKSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBucl9jcHVtYXNrX2JpdHMpOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHNraXBfY3B1bWFza19zZXQ7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoY3B1bWFza19lbXB0eShpZGxlX2luamVjdGlv
bl9jcHVfbWFzaykpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSAt
RUlOVkFMOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gc2tpcF9jcHVt
YXNrX3NldDsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGlm
IChjcHVtYXNrX2VxdWFsKGNwdV9wcmVzZW50X21hc2ssCj4gPiBpZGxlX2luamVjdGlvbl9jcHVf
bWFzaykgJiYKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbWF4X2lkbGUgPiBNQVhfQUxMX0NQVV9JRExFKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0ID0gLUVJTlZBTDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBnb3RvIHNraXBfY3B1bWFza19zZXQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJnBvd2VyY2xhbXBfbG9jayk7Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+ICsKPiA+ICtza2lwX2NwdW1hc2tfc2V0
Ogo+ID4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZwb3dlcmNsYW1wX2xvY2spOwo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGlj
IGludCBjcHVtYXNrX2dldChjaGFyICpidWYsIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW0gKmtw
KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghaWRsZV9pbmplY3Rpb25fY3B1X21hc2sp
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gYml0bWFwX3ByaW50X3RvX3BhZ2VidWYoZmFsc2Us
IGJ1ZiwKPiA+IGNwdW1hc2tfYml0cyhpZGxlX2luamVjdGlvbl9jcHVfbWFzayksCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbnJfY3B1bWFza19iaXRzKTsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIGNwdW1hc2tfb3BzID0gewo+ID4gK8KgwqDC
oMKgwqDCoMKgLnNldCA9IGNwdW1hc2tfc2V0LAo+ID4gK8KgwqDCoMKgwqDCoMKgLmdldCA9IGNw
dW1hc2tfZ2V0LAo+ID4gK307Cj4gPiArCj4gPiArbW9kdWxlX3BhcmFtX2NiKGNwdW1hc2ssICZj
cHVtYXNrX29wcywgTlVMTCwgMDY0NCk7Cj4gPiArTU9EVUxFX1BBUk1fREVTQyhjcHVtYXNrLCAi
TWFzayBvZiBDUFVzIHRvIHVzZSBmb3IgaWRsZQo+ID4gaW5qZWN0aW9uLiIpOwo+ID4gKwo+ID4g
K3N0YXRpYyBpbnQgbWF4X2lkbGVfc2V0KGNvbnN0IGNoYXIgKmFyZywgY29uc3Qgc3RydWN0IGtl
cm5lbF9wYXJhbQo+ID4gKmtwKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoHU4IF9tYXhfaWRs
ZTsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCByZXQgPSAwOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDC
oMKgbXV0ZXhfbG9jaygmcG93ZXJjbGFtcF9sb2NrKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDC
oC8qIENhbid0IHNldCBtYXNrIHdoZW4gY29vbGluZyBkZXZpY2UgaXMgaW4gdXNlICovCj4gPiAr
wqDCoMKgwqDCoMKgwqBpZiAocG93ZXJjbGFtcF9kYXRhLmNsYW1waW5nKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gLUVBR0FJTjsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIHNraXBfbGltaXRfc2V0Owo+ID4gK8KgwqDCoMKgwqDCoMKg
fQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0ga3N0cnRvdTgoYXJnLCAxMCwgJl9tYXhf
aWRsZSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGdvdG8gc2tpcF9saW1pdF9zZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
wqBpZiAoX21heF9pZGxlID4gTUFYX1RBUkdFVF9SQVRJTykgewo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldCA9IC1FSU5WQUw7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZ290byBza2lwX2xpbWl0X3NldDsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICsK
PiA+ICvCoMKgwqDCoMKgwqDCoGlmIChpZGxlX2luamVjdGlvbl9jcHVfbWFzayAmJgo+ID4gY3B1
bWFza19lcXVhbChjcHVfcHJlc2VudF9tYXNrLAo+ID4gaWRsZV9pbmplY3Rpb25fY3B1X21hc2sp
ICYmCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgX21heF9pZGxlID4gTUFYX0FMTF9DUFVfSURM
RSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IC1FSU5WQUw7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBza2lwX2xpbWl0X3NldDsKPiA+
ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoG1heF9pZGxlID0gX21h
eF9pZGxlOwo+ID4gKwo+ID4gK3NraXBfbGltaXRfc2V0Ogo+ID4gK8KgwqDCoMKgwqDCoMKgbXV0
ZXhfdW5sb2NrKCZwb3dlcmNsYW1wX2xvY2spOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0
dXJuIHJldDsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFy
YW1fb3BzIG1heF9pZGxlX29wcyA9IHsKPiA+ICvCoMKgwqDCoMKgwqDCoC5zZXQgPSBtYXhfaWRs
ZV9zZXQsCj4gPiArwqDCoMKgwqDCoMKgwqAuZ2V0ID0gcGFyYW1fZ2V0X2ludCwKPiA+ICt9Owo+
ID4gKwo+ID4gK21vZHVsZV9wYXJhbV9jYihtYXhfaWRsZSwgJm1heF9pZGxlX29wcywgJm1heF9p
ZGxlLCAwNjQ0KTsKPiA+ICtNT0RVTEVfUEFSTV9ERVNDKG1heF9pZGxlLCAibWF4aW11bSBpbmpl
Y3RlZCBpZGxlIHRpbWUgdG8gdGhlCj4gPiB0b3RhbAo+ID4gQ1BVIHRpbWUgcmF0aW8gaW4gcGVy
Y2VudCByYW5nZToxLTEwMCIpOwo+ID4gKwo+ID4gwqBzdHJ1Y3QgcG93ZXJjbGFtcF9jYWxpYnJh
dGlvbl9kYXRhIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGNvbmZpZGVuY2U7
wqAgLyogdXNlZCBmb3IgY2FsaWJyYXRpb24sCj4gPiBiYXNpY2FsbHkgYQo+ID4gY291bnRlcgo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIGdldHMgaW5jcmVtZW50ZWQgZWFjaCB0aW1lIGEKPiA+IGNsYW1w
aW5nCj4gPiBAQCAtMzQyLDYgKzQ3MSwxMCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IGdldF9ydW5f
dGltZSh2b2lkKQo+ID4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBjb21wZW5zYXRlZF9y
YXRpbzsKPiA+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgcnVudGltZTsKPiA+IMKgCj4g
PiArwqDCoMKgwqDCoMKgwqAvKiBObyBjb21wZW5zYXRpb24gZm9yIG5vbiBzeXN0ZW13aWRlIGlk
bGUgaW5qZWN0aW9uICovCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAobWF4X2lkbGUgPiBNQVhfQUxM
X0NQVV9JRExFKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAoZHVy
YXRpb24gKiAxMDAgLwo+ID4gcG93ZXJjbGFtcF9kYXRhLnRhcmdldF9yYXRpbyAtCj4gPiBkdXJh
dGlvbik7Cj4gCj4gVGhlIGNvbW1lbnQgYW5kIHRoZSBjb2RlIGlzIG5vdCBhbGlnbmVkLgo+IHdl
IGNhbiBzdGlsbCBzZXQgbWF4X2lkbGUgdG8gYSB2YWx1ZSBsb3dlciB0aGFuIE1BWF9BTExfQ1BV
X0lETEUgZm9yCj4gbm9uIHN5c3RlbXdpZGUgaWRsZSBpbmplY3Rpb24sIHJpZ2h0Pwo+IAo+IHRo
YW5rcywKPiBydWkKPiAKPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgwqAvKgo+ID4gwqDCoMKgwqDC
oMKgwqDCoCAqIG1ha2Ugc3VyZSB1c2VyIHNlbGVjdGVkIHJhdGlvIGRvZXMgbm90IHRha2UgZWZm
ZWN0IHVudGlsCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogdGhlIG5leHQgcm91bmQuIGFkanVzdCB0
YXJnZXRfcmF0aW8gaWYgdXNlciBoYXMgY2hhbmdlZAo+ID4gQEAgLTQ2MCwyMSArNTkzLDExIEBA
IHN0YXRpYyB2b2lkIHRyaWdnZXJfaWRsZV9pbmplY3Rpb24odm9pZCkKPiA+IMKgICovCj4gPiDC
oHN0YXRpYyBpbnQgcG93ZXJjbGFtcF9pZGxlX2luamVjdGlvbl9yZWdpc3Rlcih2b2lkKQo+ID4g
wqB7Cj4gPiAtwqDCoMKgwqDCoMKgwqAvKgo+ID4gLcKgwqDCoMKgwqDCoMKgICogVGhlIGlkbGUg
aW5qZWN0IGNvcmUgd2lsbCBvbmx5IGluamVjdCBmb3Igb25saW5lIENQVXMsCj4gPiAtwqDCoMKg
wqDCoMKgwqAgKiBTbyB3ZSBjYW4gcmVnaXN0ZXIgZm9yIGFsbCBwcmVzZW50IENQVXMuIEluIHRo
aXMgd2F5Cj4gPiAtwqDCoMKgwqDCoMKgwqAgKiBpZiBzb21lIENQVSBnb2VzIG9ubGluZS9vZmZs
aW5lIHdoaWxlIGlkbGUgaW5qZWN0Cj4gPiAtwqDCoMKgwqDCoMKgwqAgKiBpcyByZWdpc3RlcmVk
LCBub3RoaW5nIGFkZGl0aW9uYWwgY2FsbHMgYXJlIHJlcXVpcmVkLgo+ID4gLcKgwqDCoMKgwqDC
oMKgICogVGhlIHNhbWUgcnVudGltZSBhbmQgaWRsZSB0aW1lIGlzIGFwcGxpY2FibGUgZm9yCj4g
PiAtwqDCoMKgwqDCoMKgwqAgKiBuZXdseSBvbmxpbmVkIENQVXMgaWYgYW55Lgo+ID4gLcKgwqDC
oMKgwqDCoMKgICoKPiA+IC3CoMKgwqDCoMKgwqDCoCAqIEhlcmUgY3B1X3ByZXNlbnRfbWFzayBj
YW4gYmUgdXNlZCBhcyBpcy4KPiA+IC3CoMKgwqDCoMKgwqDCoCAqIGNhc3QgdG8gKHN0cnVjdCBj
cHVtYXNrICopIGlzIHJlcXVpcmVkIGFzIHRoZQo+ID4gLcKgwqDCoMKgwqDCoMKgICogY3B1X3By
ZXNlbnRfbWFzayBpcyBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqLCBvdGhlcndpc2UKPiA+IC3CoMKg
wqDCoMKgwqDCoCAqIHRoZXJlIHdpbGwgYmUgY29tcGlsZXIgd2FybmluZ3MuCj4gPiAtwqDCoMKg
wqDCoMKgwqAgKi8KPiA+IC3CoMKgwqDCoMKgwqDCoGlpX2RldiA9IGlkbGVfaW5qZWN0X3JlZ2lz
dGVyX2Z1bGwoKHN0cnVjdCBjcHVtYXNrCj4gPiAqKWNwdV9wcmVzZW50X21hc2ssCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZGxlX2luamVjdF91cGRhdGUpOwo+ID4gK8KgwqDCoMKg
wqDCoMKgaWYgKGNwdW1hc2tfZXF1YWwoY3B1X3ByZXNlbnRfbWFzaywKPiA+IGlkbGVfaW5qZWN0
aW9uX2NwdV9tYXNrKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpaV9kZXYg
PQo+ID4gaWRsZV9pbmplY3RfcmVnaXN0ZXJfZnVsbChpZGxlX2luamVjdGlvbl9jcHVfbWFzaywK
PiA+IGlkbGVfaW5qZWN0X3VwZGF0ZSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBlbHNlCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWlfZGV2ID0KPiA+IGlkbGVfaW5qZWN0X3JlZ2lz
dGVyKGlkbGVfaW5qZWN0aW9uX2NwdV9tYXNrKTsKPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgwqBp
ZiAoIWlpX2Rldikgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9lcnIo
InBvd2VyY2xhbXA6IGlkbGVfaW5qZWN0X3JlZ2lzdGVyCj4gPiBmYWlsZWRcbiIpOwo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVBR0FJTjsKPiA+IEBAIC01MTAs
NyArNjMzLDcgQEAgc3RhdGljIGludCBzdGFydF9wb3dlcl9jbGFtcCh2b2lkKQo+ID4gwqDCoMKg
wqDCoMKgwqDCoHJldCA9IHBvd2VyY2xhbXBfaWRsZV9pbmplY3Rpb25fcmVnaXN0ZXIoKTsKPiA+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXJldCkgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB0cmlnZ2VyX2lkbGVfaW5qZWN0aW9uKCk7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKHBvbGxfcGtnX2NzdGF0ZV9lbmFibGUpCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKHBvbGxfcGtnX2NzdGF0ZV9lbmFibGUgJiYgbWF4X2lkbGUg
PAo+ID4gTUFYX0FMTF9DUFVfSURMRSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmcG9sbF9wa2dfY3N0YXRl
X3dvcmsKPiA+ICwKPiA+IDApOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgCj4gPiBAQCAt
NTY1LDcgKzY4OCw3IEBAIHN0YXRpYyBpbnQgcG93ZXJjbGFtcF9zZXRfY3VyX3N0YXRlKHN0cnVj
dAo+ID4gdGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldiwKPiA+IMKgwqDCoMKgwqDCoMKgwqBt
dXRleF9sb2NrKCZwb3dlcmNsYW1wX2xvY2spOwo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqBu
ZXdfdGFyZ2V0X3JhdGlvID0gY2xhbXAobmV3X3RhcmdldF9yYXRpbywgMFVMLAo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
KHVuc2lnbmVkIGxvbmcpIChNQVhfVEFSR0VUX1JBVElPIC0KPiA+IDEpKTsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCh1
bnNpZ25lZCBsb25nKSAobWF4X2lkbGUgLSAxKSk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFw
b3dlcmNsYW1wX2RhdGEudGFyZ2V0X3JhdGlvICYmIG5ld190YXJnZXRfcmF0aW8gPiAwKQo+ID4g
ewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9pbmZvKCJTdGFydCBpZGxl
IGluamVjdGlvbiB0byByZWR1Y2UgcG93ZXJcbiIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwb3dlcmNsYW1wX2RhdGEudGFyZ2V0X3JhdGlvID0gbmV3X3RhcmdldF9yYXRp
bzsKPiA+IEBAIC02NTYsNiArNzc5LDEzIEBAIHN0YXRpYyBpbnQgX19pbml0IHBvd2VyY2xhbXBf
aW5pdCh2b2lkKQo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqAvKiBwcm9iZSBjcHUgZmVhdHVy
ZXMgYW5kIGlkcyBoZXJlICovCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dmFsID0gcG93ZXJjbGFt
cF9wcm9iZSgpOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldHZhbCkKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0dmFsOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDC
oMKgbXV0ZXhfbG9jaygmcG93ZXJjbGFtcF9sb2NrKTsKPiA+ICvCoMKgwqDCoMKgwqDCoHJldHZh
bCA9IGFsbG9jYXRlX2lkbGVfaW5qZWN0aW9uX21hc2soKTsKPiA+ICvCoMKgwqDCoMKgwqDCoG11
dGV4X3VubG9jaygmcG93ZXJjbGFtcF9sb2NrKTsKPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgwqBp
ZiAocmV0dmFsKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0
dmFsOwo+ID4gwqAKPiA+IEBAIC02ODksNiArODE5LDkgQEAgc3RhdGljIHZvaWQgX19leGl0IHBv
d2VyY2xhbXBfZXhpdCh2b2lkKQo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqBjYW5jZWxfZGVs
YXllZF93b3JrX3N5bmMoJnBvbGxfcGtnX2NzdGF0ZV93b3JrKTsKPiA+IMKgwqDCoMKgwqDCoMKg
wqBkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoZGVidWdfZGlyKTsKPiA+ICsKPiA+ICvCoMKgwqDC
oMKgwqDCoGlmIChpZGxlX2luamVjdGlvbl9jcHVfbWFzaykKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBmcmVlX2NwdW1hc2tfdmFyKGlkbGVfaW5qZWN0aW9uX2NwdV9tYXNrKTsK
PiA+IMKgfQo+ID4gwqBtb2R1bGVfZXhpdChwb3dlcmNsYW1wX2V4aXQpOwo+ID4gCgo=

