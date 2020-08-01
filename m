Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0A235374
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 18:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHAQjc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Aug 2020 12:39:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:28970 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgHAQjb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Aug 2020 12:39:31 -0400
IronPort-SDR: pZJAcrW2OCc/hHe7i4ZVYwcW1p/YDc5e0dvbSHPgRJNGzYT1uNmJMWBrKjCwL5uqaMr30+m/MF
 0UUe+LzD6B3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="151911531"
X-IronPort-AV: E=Sophos;i="5.75,423,1589266800"; 
   d="txt'?scan'208";a="151911531"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 09:39:30 -0700
IronPort-SDR: m3hGwR8wWzEDR7gwPNrUqOp6ge3BGSba3XDKFpf+5Ay5AKTPiIX+oGCnwXiylkKWU1IHsq1tRN
 XTSc9toW8UWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,423,1589266800"; 
   d="txt'?scan'208";a="365881424"
Received: from ppurohit-mobl.amr.corp.intel.com ([10.212.162.156])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2020 09:39:30 -0700
Message-ID: <6febe0592d1830dac04aab281f66b47498dda887.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/2] cpufreq: intel_pstate: Implement passive mode
 with HWP enabled
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Francisco Jerez <francisco.jerez.plata@intel.com>
Date:   Sat, 01 Aug 2020 09:39:30 -0700
In-Reply-To: <13207937.r2GEYrEf4f@kreacher>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
         <13207937.r2GEYrEf4f@kreacher>
Content-Type: multipart/mixed; boundary="=-bU21ZBsdw4g45G9I/wXt"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-bU21ZBsdw4g45G9I/wXt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-07-28 at 17:09 +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> On Monday, July 27, 2020 5:13:40 PM CEST Rafael J. Wysocki wrote:
> > On Thursday, July 16, 2020 7:37:04 PM CEST Rafael J. Wysocki wrote:
> > > This really is a v2 of this patch:
> > > 
> > > https://patchwork.kernel.org/patch/11663271/
> > > 
> > > with an extra preceding cleanup patch to avoid making unrelated
> > > changes in the
> > > [2/2].
> > 
I applied this series along with
[PATCH] cpufreq: intel_pstate: Fix EPP setting via sysfs in active mode
on 5.8 latest master (On top of raw epp patchset).

When intel_pstate=passive from kernel command line then it is fine, no
crash. But switch dynamically, crashed:
Attached crash.txt. I may need to try your linux-pm tree.

Then after some playing I reached a state when I monitor MSR 0x774:
while true; do rdmsr 0x774; sleep 1; done
80002704
...
...
ff000101
ff000101
ff000101
ff000101
ff000101
ff000101
ff000101
ff000101

Don't have a recipe to reproduce this.

Thanks,
Srinivas

> > Almost the same as before, but the first patch has been reworked to
> > handle
> > errors in store_energy_performance_preference() correctly and
> > rebased on top
> > of the current linux-pm.git branch.
> > 
> > No functional changes otherwise.
> 
> One more update of the second patch.
> 
> Namely, I realized that the hwp_dynamic_boost sysfs switch was
> present in the
> passive mode after the v3 (and the previous versions) of that patch
> which isn't
> correct, so this modifies it to avoid exposing hwp_dynamic_boost in
> the passive
> mode.
> 
> The first patch is the same as in the v2.
> 
> Thanks!
> 
> 
> 

--=-bU21ZBsdw4g45G9I/wXt
Content-Disposition: attachment; filename="crash.txt"
Content-Type: text/plain; name="crash.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

WyAgMjMyLjQ4MzQyMF0gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRy
ZXNzOiAwMDAwMDAwMDAwMDAwMDMwClsgIDIzMi40ODM0MzVdICNQRjogc3VwZXJ2aXNvciByZWFk
IGFjY2VzcyBpbiBrZXJuZWwgbW9kZQpbICAyMzIuNDgzNDQxXSAjUEY6IGVycm9yX2NvZGUoMHgw
MDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UKWyAgMjMyLjQ4MzQ0Nl0gUEdEIDAgUDREIDAgClsgIDIz
Mi40ODM0NTddIE9vcHM6IDAwMDAgWyMxXSBTTVAgTk9QVEkKWyAgMjMyLjQ4MzQ2OV0gQ1BVOiA3
IFBJRDogMjA2NCBDb21tOiBiYXNoIFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICA1LjguMC1y
YzYrICM2ClsgIDIzMi40ODM0NzRdIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBYUFMgMTMgNzM5
MCAyLWluLTEvMDZDRFZZLCBCSU9TIDEuMy4xIDAzLzAyLzIwMjAKWyAgMjMyLjQ4MzQ5MV0gUklQ
OiAwMDEwOnN5c2ZzX3JlbW92ZV9maWxlX25zKzB4Ni8weDIwClsgIDIzMi40ODM1MDBdIENvZGU6
IGZmIDRjIDg5IGU3IGU4IGJiIGNlIGZmIGZmIDRjIDg5IGVmIGU4IDQzIGY5IDFkIDAwIDQxIDVj
IDQxIDVkIDVkIGMzIDY2IDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDY2IDkwIDBmIDFm
IDQ0IDAwIDAwIDU1IDw0OD4gOGIgN2YgMzAgNDggOGIgMzYgNDggODkgZTUgZTggY2IgZTIgZmYg
ZmYgNWQgYzMgNjYgMGYgMWYgODQgMDAKWyAgMjMyLjQ4MzUwN10gUlNQOiAwMDE4OmZmZmZhYTM3
YzFjOTNkZjggRUZMQUdTOiAwMDAxMDI0NgpbICAyMzIuNDgzNTE0XSBSQVg6IDAwMDAwMDAwMDAw
MDAwMDEgUkJYOiAwMDAwMDAwMDAwMDAwMDA3IFJDWDogMDAwMDAwMDAwMDAwMDAwOApbICAyMzIu
NDgzNTE5XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmZmZmZmE4N2YxZjYwIFJESTog
MDAwMDAwMDAwMDAwMDAwMApbICAyMzIuNDgzNTI0XSBSQlA6IGZmZmZhYTM3YzFjOTNlMTggUjA4
OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogZmZmZmZmZmZhNzkxZmYwMApbICAyMzIuNDgzNTI5XSBS
MTA6IGZmZmY4YTE1YmMwZjM2MDAgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIxMjogMDAwMDAwMDAw
MDAwMDAwOApbICAyMzIuNDgzNTMzXSBSMTM6IGZmZmY4YTE1YjMwNTkxOTcgUjE0OiBmZmZmZmZm
ZmZmZmZmZmYyIFIxNTogZmZmZjhhMTU5Zjk0NTAyMApbICAyMzIuNDgzNTQxXSBGUzogIDAwMDA3
ZjA2OGEzZDQ3NDAoMDAwMCkgR1M6ZmZmZjhhMTViZjdjMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAw
MDAwMDAwMDAwClsgIDIzMi40ODM1NDddIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6
IDAwMDAwMDAwODAwNTAwMzMKWyAgMjMyLjQ4MzU1Ml0gQ1IyOiAwMDAwMDAwMDAwMDAwMDMwIENS
MzogMDAwMDAwMDQ2ZWM3ODAwNCBDUjQ6IDAwMDAwMDAwMDA3NjBlZTAKWyAgMjMyLjQ4MzU1N10g
UEtSVTogNTU1NTU1NTQKWyAgMjMyLjQ4MzU2MV0gQ2FsbCBUcmFjZToKWyAgMjMyLjQ4MzU4MV0g
ID8gaW50ZWxfcHN0YXRlX2RyaXZlcl9jbGVhbnVwKzB4YmQvMHhkMApbICAyMzIuNDgzNTkwXSAg
c3RvcmVfc3RhdHVzKzB4OWIvMHgxODAKWyAgMjMyLjQ4MzYwM10gIGtvYmpfYXR0cl9zdG9yZSsw
eDEyLzB4MjAKWyAgMjMyLjQ4MzYxMF0gIHN5c2ZzX2tmX3dyaXRlKzB4M2UvMHg1MApbICAyMzIu
NDgzNjIzXSAga2VybmZzX2ZvcF93cml0ZSsweGRhLzB4MWIwClsgIDIzMi40ODM2MzZdICB2ZnNf
d3JpdGUrMHhjOS8weDIwMApbICAyMzIuNDgzNjQ3XSAga3N5c193cml0ZSsweDY3LzB4ZTAKWyAg
MjMyLjQ4MzY1N10gIF9feDY0X3N5c193cml0ZSsweDFhLzB4MjAKWyAgMjMyLjQ4MzY2OF0gIGRv
X3N5c2NhbGxfNjQrMHg1Mi8weGMwClsgIDIzMi40ODM2ODBdICBlbnRyeV9TWVNDQUxMXzY0X2Fm
dGVyX2h3ZnJhbWUrMHg0NC8weGE5ClsgIDIzMi40ODM2ODldIFJJUDogMDAzMzoweDdmMDY4YTRl
ODA1NwpbICAyMzIuNDgzNjkzXSBDb2RlOiBCYWQgUklQIHZhbHVlLgpbICAyMzIuNDgzNjk5XSBS
U1A6IDAwMmI6MDAwMDdmZmUwZDRmYWVjOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAw
MDAwMDAwMDAwMDAxClsgIDIzMi40ODM3MDVdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAw
MDAwMDAwMDAwMDAwMDggUkNYOiAwMDAwN2YwNjhhNGU4MDU3ClsgIDIzMi40ODM3MTBdIFJEWDog
MDAwMDAwMDAwMDAwMDAwOCBSU0k6IDAwMDA1NWI1MmUzYTY3MDAgUkRJOiAwMDAwMDAwMDAwMDAw
MDAxClsgIDIzMi40ODM3MTVdIFJCUDogMDAwMDU1YjUyZTNhNjcwMCBSMDg6IDAwMDAwMDAwMDAw
MDAwMGEgUjA5OiAwMDAwMDAwMDAwMDAwMDA3ClsgIDIzMi40ODM3MTldIFIxMDogMDAwMDU1YjUy
Y2NhNTAxNyBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDA4ClsgIDIz
Mi40ODM3MjRdIFIxMzogMDAwMDdmMDY4YTVjMzZhMCBSMTQ6IDAwMDA3ZjA2OGE1YzQ0YTAgUjE1
OiAwMDAwN2YwNjhhNWMzOGEwClsgIDIzMi40ODM3MzVdIE1vZHVsZXMgbGlua2VkIGluOiBtc3Ig
cmZjb21tIGNjbSBjbWFjIGFsZ2lmX2hhc2ggYWxnaWZfc2tjaXBoZXIgYWZfYWxnIHdhY29tIHVz
YmhpZCBoaWRfbXVsdGl0b3VjaCBibmVwIGhpZF9zZW5zb3JfYWxzIGhpZF9zZW5zb3JfaW5jbF8z
ZCBoaWRfc2Vuc29yX2FjY2VsXzNkIGhpZF9zZW5zb3JfbWFnbl8zZCBoaWRfc2Vuc29yX2d5cm9f
M2QgaGlkX3NlbnNvcl9yb3RhdGlvbiBoaWRfc2Vuc29yX3RyaWdnZXIgaW5kdXN0cmlhbGlvX3Ry
aWdnZXJlZF9idWZmZXIga2ZpZm9fYnVmIGhpZF9zZW5zb3JfaWlvX2NvbW1vbiBpbmR1c3RyaWFs
aW8gaGlkX3NlbnNvcl9jdXN0b20geDg2X3BrZ190ZW1wX3RoZXJtYWwgaGlkX3NlbnNvcl9odWIg
aW50ZWxfcG93ZXJjbGFtcCBoaWRfZ2VuZXJpYyBpbnRlbF9pc2h0cF9sb2FkZXIgc25kX3NvZl9w
Y2kgc25kX3NvZl9pbnRlbF9ieXQgaW50ZWxfaXNodHBfaGlkIHNuZF9zb2ZfaW50ZWxfaXBjIGRl
bGxfbGFwdG9wIGRlbGxfd21pIGNyb3NfZWNfaXNodHAgc25kX3NvZl9pbnRlbF9oZGFfY29tbW9u
IG1laV9oZGNwIHJ0c3hfcGNpX3NkbW1jIGludGVsX3JhcGxfbXNyIGludGVsX3dtaV90aHVuZGVy
Ym9sdCBjb3JldGVtcCB3bWlfYm1vZiBkZWxsX3NtYmlvcyBzbmRfc29jX2hkYWNfaGRhIGNyb3Nf
ZWMgc25kX3NvZl94dGVuc2FfZHNwIHNuZF9zb2ZfaW50ZWxfaGRhIHNuZF9zb2Yga3ZtX2ludGVs
IGRlbGxfd21pX2Rlc2NyaXB0b3Igc25kX2hkYV9jb2RlY19oZG1pIGRjZGJhcyBzbmRfaGRhX2V4
dF9jb3JlIGRlbGxfc21tX2h3bW9uIG5sc19pc284ODU5XzEgc25kX3NvY19hY3BpX2ludGVsX21h
dGNoIGt2bSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgc25kX3NvY19hY3BpIHNuZF9oZGFfY29kZWNf
Z2VuZXJpYyBpd2xtdm0gbGVkdHJpZ19hdWRpbyBzbmRfc29jX2NvcmUgY3JjdDEwZGlmX3BjbG11
bCBjcmMzMl9wY2xtdWwgZ2hhc2hfY2xtdWxuaV9pbnRlbCBhZXNuaV9pbnRlbApbICAyMzIuNDgz
ODIxXSAgY3J5cHRvX3NpbWQgY3J5cHRkIHNuZF9jb21wcmVzcyBnbHVlX2hlbHBlciBhYzk3X2J1
cyBzbmRfcGNtX2RtYWVuZ2luZSByYXBsIG1hYzgwMjExIGludGVsX2NzdGF0ZSBzbmRfaGRhX2lu
dGVsIHNuZF9pbnRlbF9kc3BjZmcgc25kX2hkYV9jb2RlYyBzbmRfaGRhX2NvcmUgam95ZGV2IHNu
ZF9od2RlcCBzbmRfcGNtIGxpYmFyYzQgZWZpX3BzdG9yZSBpd2x3aWZpIGJ0dXNiIHNuZF9zZXFf
bWlkaSBzbmRfc2VxX21pZGlfZXZlbnQgYnRydGwgc25kX3Jhd21pZGkgYnRiY20gYnRpbnRlbCBz
bmRfc2VxIGJsdWV0b290aCBjZmc4MDIxMSBzbmRfc2VxX2RldmljZSBzbmRfdGltZXIgc25kIGky
Y19pODAxIGkyY19zbWJ1cyB1Y3NpX2FjcGkgcHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNlIHR5cGVj
X3Vjc2kgaW50ZWxfcmFwbF9jb21tb24gaW50ZWxfbHBzc19wY2kgaW50ZWxfbHBzcyBpZG1hNjQg
cnRzeF9wY2kgc291bmRjb3JlIG1laV9tZSBlY2RoX2dlbmVyaWMgbWVpIGludGVsX2lzaF9pcGMg
ZWNjIGkyY19oaWQgaW50ZWxfaXNodHAgaW50ZWxfc29jX2R0c19pb3NmIHR5cGVjIHZpcnRfZG1h
IHdtaSBoaWQgaW50MzQwM190aGVybWFsIHNvY19idXR0b25fYXJyYXkgaW50MzQweF90aGVybWFs
X3pvbmUgaW50MzQwMF90aGVybWFsIGludGVsX2hpZCBhY3BpX3RoZXJtYWxfcmVsIHNwYXJzZV9r
ZXltYXAgYWNwaV9wYWQgYWNwaV90YWQgc2NoX2ZxX2NvZGVsIHBhcnBvcnRfcGMgcHBkZXYgbHAg
cGFycG9ydCBpcF90YWJsZXMgeF90YWJsZXMgYXV0b2ZzNCBpOTE1IGkyY19hbGdvX2JpdCBkcm1f
a21zX2hlbHBlciBzeXNjb3B5YXJlYSBzeXNmaWxscmVjdCBzeXNpbWdibHQgZmJfc3lzX2ZvcHMg
Y2VjIGRybSBwc21vdXNlIG52bWUgbnZtZV9jb3JlIGlucHV0X2xlZHMgc2VyaW9fcmF3IG1hY19o
aWQgdmlkZW8gcGluY3RybF9pY2VsYWtlIHBpbmN0cmxfaW50ZWwKWyAgMjMyLjQ4Mzk0MF0gQ1Iy
OiAwMDAwMDAwMDAwMDAwMDMwClsgIDIzMi40ODM5NTBdIC0tLVsgZW5kIHRyYWNlIDMxZGI0MWJh
YjZmZGZmNmYgXS0tLQpbICAyMzMuODEyMjYwXSBSSVA6IDAwMTA6c3lzZnNfcmVtb3ZlX2ZpbGVf
bnMrMHg2LzB4MjAKWyAgMjMzLjgxMjI4MV0gQ29kZTogZmYgNGMgODkgZTcgZTggYmIgY2UgZmYg
ZmYgNGMgODkgZWYgZTggNDMgZjkgMWQgMDAgNDEgNWMgNDEgNWQgNWQgYzMgNjYgNjYgMmUgMGYg
MWYgODQgMDAgMDAgMDAgMDAgMDAgNjYgOTAgMGYgMWYgNDQgMDAgMDAgNTUgPDQ4PiA4YiA3ZiAz
MCA0OCA4YiAzNiA0OCA4OSBlNSBlOCBjYiBlMiBmZiBmZiA1ZCBjMyA2NiAwZiAxZiA4NCAwMApb
ICAyMzMuODEyMjkyXSBSU1A6IDAwMTg6ZmZmZmFhMzdjMWM5M2RmOCBFRkxBR1M6IDAwMDEwMjQ2
ClsgIDIzMy44MTIzMDJdIFJBWDogMDAwMDAwMDAwMDAwMDAwMSBSQlg6IDAwMDAwMDAwMDAwMDAw
MDcgUkNYOiAwMDAwMDAwMDAwMDAwMDA4ClsgIDIzMy44MTIzMDhdIFJEWDogMDAwMDAwMDAwMDAw
MDAwMCBSU0k6IGZmZmZmZmZmYTg3ZjFmNjAgUkRJOiAwMDAwMDAwMDAwMDAwMDAwClsgIDIzMy44
MTIzMTNdIFJCUDogZmZmZmFhMzdjMWM5M2UxOCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBm
ZmZmZmZmZmE3OTFmZjAwClsgIDIzMy44MTIzMThdIFIxMDogZmZmZjhhMTViYzBmMzYwMCBSMTE6
IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiAwMDAwMDAwMDAwMDAwMDA4ClsgIDIzMy44MTIzMjNdIFIx
MzogZmZmZjhhMTViMzA1OTE5NyBSMTQ6IGZmZmZmZmZmZmZmZmZmZjIgUjE1OiBmZmZmOGExNTlm
OTQ1MDIwClsgIDIzMy44MTIzMzFdIEZTOiAgMDAwMDdmMDY4YTNkNDc0MCgwMDAwKSBHUzpmZmZm
OGExNWJmN2MwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyAgMjMzLjgxMjMzN10g
Q1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbICAyMzMu
ODEyMzQzXSBDUjI6IDAwMDAwMDAwMDAwMDAwMzAgQ1IzOiAwMDAwMDAwNDZlYzc4MDA0IENSNDog
MDAwMDAwMDAwMDc2MGVlMApbICAyMzMuODEyMzQ5XSBQS1JVOiA1NTU1NTU1NAoK


--=-bU21ZBsdw4g45G9I/wXt--

