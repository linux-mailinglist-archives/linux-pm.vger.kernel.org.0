Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E4400472
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 20:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhICSBj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 14:01:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:63742 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhICSBi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Sep 2021 14:01:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="199704461"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208,223";a="199704461"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 11:00:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208,223";a="468029941"
Received: from achiranj-mobl.gar.corp.intel.com ([10.213.105.90])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 11:00:35 -0700
Message-ID: <d6bf08cbfd9f29ddb8cf29f522d68efc5c676624.camel@linux.intel.com>
Subject: Re: Bug: d0e936adbd22 crashes at boot
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Date:   Fri, 03 Sep 2021 11:00:31 -0700
In-Reply-To: <767fe00f-bf31-1eb0-09cc-1be91c633bb4@kernel.dk>
References: <942f4041-e4e7-1b08-3301-008ab37ff5b8@kernel.dk>
         <c56cde110210bec6537fe69b495334c6c70c814e.camel@linux.intel.com>
         <3ac87893-55ba-f2d4-bb1e-382868f12d4c@kernel.dk>
         <7f115f0476618d34b24ddec772acbbd7c0c4a572.camel@linux.intel.com>
         <767fe00f-bf31-1eb0-09cc-1be91c633bb4@kernel.dk>
Content-Type: multipart/mixed; boundary="=-+dSVwqJX7Zgse2q0tlJv"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-+dSVwqJX7Zgse2q0tlJv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Axobe,

On Fri, 2021-09-03 at 09:00 -0600, Jens Axboe wrote:
> On 9/3/21 8:38 AM, Srinivas Pandruvada wrote:
> > On Fri, 2021-09-03 at 08:15 -0600, Jens Axboe wrote:
> > > On 9/3/21 8:13 AM, Srinivas Pandruvada wrote:
> > > > Hi Axboe,
> > > > 
> > > > Thanks for reporting.
> > > > On Fri, 2021-09-03 at 07:36 -0600, Jens Axboe wrote:
> > > > > Hi,
> > > > > 
> > > > > Booting Linus's tree causes a crash on my laptop, an x1 gen9.
> > > > > This
> > > > > was
> > > > > a bit
> > > > > difficult to pin down as it crashes before the display is up,
> > > > > but I
> > > > > managed
> > > > > to narrow it down to:
> > > > > 
> > > > > commit d0e936adbd2250cb03f2e840c6651d18edc22ace
> > > > > Author: Srinivas Pandruvada < 
> > > > > srinivas.pandruvada@linux.intel.com>
> > > > > Date:   Thu Aug 19 19:40:06 2021 -0700
> > > > > 
> > > > >     cpufreq: intel_pstate: Process HWP Guaranteed change
> > > > > notification
> > > > > 
> > > > > which crashes with a NULL pointer deref in
> > > > > notify_hwp_interrupt() -
> > > > > > 
> > > > > queue_delayed_work_on().
> > > > > 
> > > > > Reverting this change makes the laptop boot fine again.
> > > > > 
> > > > Does this change fixes your issue?
> > > 
> > > I would assume so, as it's crashing on cpudata == NULL :-)
> > > 
> > > But why is it NULL? Happy to test patches, but the below doesn't
> > > look
> > > like
> > > a real fix and more of a work-around.
> > 

Please try the attached.

Thanks,
Srinivas

> > This platform is sending an HWP interrupt on a CPU which we didn't
> > yet
> > bring it up for pstate control. So somehow firmware decided to send
> > very early during boot, which previously we would have ignored it
> > 
> > Actually try this, with more prevention
> 
> I can give this a whirl.
> 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index b4ffe6c8a0d0..6ee88d7640ea 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1645,12 +1645,24 @@ void notify_hwp_interrupt(void)
> >         if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> >                 return;
> >  
> > -       rdmsrl(MSR_HWP_STATUS, value);
> > +       rdmsrl_safe(MSR_HWP_STATUS, &value);
> >         if (!(value & 0x01))
> >                 return;
> >  
> > +       /*
> > +        * After hwp_active is set and all_cpu_data is allocated,
> > there
> > +        * is small window.
> > +        */
> > +       if (!all_cpu_data) {
> > +               wrmsrl_safe(MSR_HWP_STATUS, 0);
> > +               return;
> > +       }
> 
> What synchronizes the all_cpu_data setup and the interrupt? Can the
> interrupt come in while it's still being setup?
> 


--=-+dSVwqJX7Zgse2q0tlJv
Content-Disposition: attachment;
	filename*0=0001-cpufreq-intel_pstate-Fix-for-HWP-interrupt-before-dr.pat;
	filename*1=ch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-cpufreq-intel_pstate-Fix-for-HWP-interrupt-before-dr.patch";
	charset="UTF-8"

RnJvbSAzODBkNWEzNDBlYmViMTcyYzkzYTg3OGZkODRhMTJlN2JmZWE5Y2ZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogRnJpLCAzIFNlcCAyMDIxIDEwOjQxOjM1IC0wNzAw
ClN1YmplY3Q6IFtURVNUIFBBVENIXSBjcHVmcmVxOiBpbnRlbF9wc3RhdGU6IEZpeCBmb3IgSFdQ
IGludGVycnVwdCBiZWZvcmUKIGRyaXZlciBpcyByZWFkeQoKSW4geDEgZ2VuOSBsYXB0b3AsIG9u
ZSBIV1AgaW50ZXJydXB0IGFycml2ZXMgYmVmb3JlIGRyaXZlciBpcyByZWFkeQp0byBoYW5kbGUg
b24gdGhhdCBDUFUuIEhlcmUgZmlybXdhcmUgaXMgZW5hYmxpbmcgYW5kIHNlbmRpbmcgYW4KaW50
ZXJydXB0IGZvciBndWFyYW50ZWUgY2hhbmdlLiBTaW5jZSBkcml2ZXIgZGlkbid0IGhhdmUgY3B1
ZGF0YQppbml0aWFsaXplZCBpdCB3aWxsIGNhdXNlIE5VTEwgcG9pbnRlciB3aGVuIHRyeWluZyB0
byBzY2hlZHVsZQpwcm9jZXNzaW5nIG9mIGludGVycnVwdCBpbiBhIHdvcmt3cXVldWUuCgpUbyBh
dm9pZCB0aGlzIHNldCBhIGNwdW1hc2sgb2YgQ1BVcyBmb3Igd2hpY2ggZHJpdmVyIGhhcyBpbml0
aWFsaXplZAppbnRlcnJ1cHRzLiBJZiBub3QgaW5pdGlhbGl6ZWQgc2ltcGx5IGNsZWFyIHRoZSBI
V1Agc3RhdHVzLgoKU2luY2UgdGhlIHNhbWUgdGhpbmcgbWF5IGhhcHBlbiBkdXJpbmcgUzMgcmVz
dW1lLCBjbGVhciB0aGUgY3B1bWFzawpkdXJpbmcgb2ZmbGluZSBhbmQgbGV0IGl0IHJlY3JlYXRl
IGl0IGR1cmluZyBvbmxpbmUuCgpTaWduZWQtb2ZmLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhIDxz
cmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4KLS0tCiBkcml2ZXJzL2NwdWZyZXEv
aW50ZWxfcHN0YXRlLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5n
ZWQsIDIyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgYi9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMK
aW5kZXggYjRmZmU2YzhhMGQwLi41YWM4NmJmYTEwODAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYworKysgYi9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMK
QEAgLTI5OCw2ICsyOTgsOCBAQCBzdGF0aWMgYm9vbCBod3BfYm9vc3QgX19yZWFkX21vc3RseTsK
IAogc3RhdGljIHN0cnVjdCBjcHVmcmVxX2RyaXZlciAqaW50ZWxfcHN0YXRlX2RyaXZlciBfX3Jl
YWRfbW9zdGx5OwogCitzdGF0aWMgY3B1bWFza190IGh3cF9pbnRyX2VuYWJsZV9tYXNrOworCiAj
aWZkZWYgQ09ORklHX0FDUEkKIHN0YXRpYyBib29sIGFjcGlfcHBjOwogI2VuZGlmCkBAIC0xMDY3
LDExICsxMDY5LDE1IEBAIHN0YXRpYyB2b2lkIGludGVsX3BzdGF0ZV9od3Bfc2V0KHVuc2lnbmVk
IGludCBjcHUpCiAJd3Jtc3JsX29uX2NwdShjcHUsIE1TUl9IV1BfUkVRVUVTVCwgdmFsdWUpOwog
fQogCitzdGF0aWMgdm9pZCBpbnRlbF9wc3RhdGVfZGlzYWJsZV9od3BfaW50ZXJydXB0KHN0cnVj
dCBjcHVkYXRhICpjcHVkYXRhKTsKKwogc3RhdGljIHZvaWQgaW50ZWxfcHN0YXRlX2h3cF9vZmZs
aW5lKHN0cnVjdCBjcHVkYXRhICpjcHUpCiB7CiAJdTY0IHZhbHVlID0gUkVBRF9PTkNFKGNwdS0+
aHdwX3JlcV9jYWNoZWQpOwogCWludCBtaW5fcGVyZjsKIAorCWludGVsX3BzdGF0ZV9kaXNhYmxl
X2h3cF9pbnRlcnJ1cHQoY3B1KTsKKwogCWlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFdQ
X0VQUCkpIHsKIAkJLyoKIAkJICogSW4gY2FzZSB0aGUgRVBQIGhhcyBiZWVuIHNldCB0byAicGVy
Zm9ybWFuY2UiIGJ5IHRoZQpAQCAtMTY0NSwyMCArMTY1MSwzNSBAQCB2b2lkIG5vdGlmeV9od3Bf
aW50ZXJydXB0KHZvaWQpCiAJaWYgKCFod3BfYWN0aXZlIHx8ICFib290X2NwdV9oYXMoWDg2X0ZF
QVRVUkVfSFdQX05PVElGWSkpCiAJCXJldHVybjsKIAotCXJkbXNybChNU1JfSFdQX1NUQVRVUywg
dmFsdWUpOworCXJkbXNybF9zYWZlKE1TUl9IV1BfU1RBVFVTLCAmdmFsdWUpOwogCWlmICghKHZh
bHVlICYgMHgwMSkpCiAJCXJldHVybjsKIAorCWlmICghY3B1bWFza190ZXN0X2NwdSh0aGlzX2Nw
dSwgJmh3cF9pbnRyX2VuYWJsZV9tYXNrKSkgeworCQl3cm1zcmxfc2FmZShNU1JfSFdQX1NUQVRV
UywgMCk7CisJCXJldHVybjsKKwl9CisKIAljcHVkYXRhID0gYWxsX2NwdV9kYXRhW3RoaXNfY3B1
XTsKIAlzY2hlZHVsZV9kZWxheWVkX3dvcmtfb24odGhpc19jcHUsICZjcHVkYXRhLT5od3Bfbm90
aWZ5X3dvcmssIG1zZWNzX3RvX2ppZmZpZXMoMTApKTsKIH0KIAorc3RhdGljIHZvaWQgaW50ZWxf
cHN0YXRlX2Rpc2FibGVfaHdwX2ludGVycnVwdChzdHJ1Y3QgY3B1ZGF0YSAqY3B1ZGF0YSkKK3sK
KworCWlmIChjcHVtYXNrX3Rlc3RfYW5kX2NsZWFyX2NwdShjcHVkYXRhLT5jcHUsICZod3BfaW50
cl9lbmFibGVfbWFzaykpIHsKKwkJd3Jtc3JsX29uX2NwdShjcHVkYXRhLT5jcHUsIE1TUl9IV1Bf
SU5URVJSVVBULCAweDAwKTsKKwkJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZjcHVkYXRhLT5o
d3Bfbm90aWZ5X3dvcmspOworCX0KK30KKwogc3RhdGljIHZvaWQgaW50ZWxfcHN0YXRlX2VuYWJs
ZV9od3BfaW50ZXJydXB0KHN0cnVjdCBjcHVkYXRhICpjcHVkYXRhKQogewogCS8qIEVuYWJsZSBI
V1Agbm90aWZpY2F0aW9uIGludGVycnVwdCBmb3IgZ3VhcmFudGVlZCBwZXJmb3JtYW5jZSBjaGFu
Z2UgKi8KIAlpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hXUF9OT1RJRlkpKSB7CiAJCUlO
SVRfREVMQVlFRF9XT1JLKCZjcHVkYXRhLT5od3Bfbm90aWZ5X3dvcmssIGludGVsX3BzdGF0ZV9u
b3RpZnlfd29yayk7CiAJCXdybXNybF9vbl9jcHUoY3B1ZGF0YS0+Y3B1LCBNU1JfSFdQX0lOVEVS
UlVQVCwgMHgwMSk7CisJCWNwdW1hc2tfc2V0X2NwdShjcHVkYXRhLT5jcHUsICZod3BfaW50cl9l
bmFibGVfbWFzayk7CiAJfQogfQogCi0tIAoyLjE3LjEKCg==


--=-+dSVwqJX7Zgse2q0tlJv--

