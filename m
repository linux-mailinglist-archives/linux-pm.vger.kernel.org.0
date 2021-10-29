Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7B43FFB4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhJ2PmP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 11:42:15 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:40587 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJ2PmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 11:42:14 -0400
Received: by mail-oi1-f175.google.com with SMTP id k8so817631oik.7;
        Fri, 29 Oct 2021 08:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAnKrByzxlYuTvGkBOjeaG54WmBkl53hDOGdLVYByPQ=;
        b=i6ll4pn/gfiOx6hOkvznsMjABuH4Exycl1GCG2EoMCn74ggX1yE+/TO2SQIUDyhOOW
         EP15LbhDiUFnsziG7Ax3RHxLYyUimD+DUsjm7eDfQlfn8zfSRU6ZkZsIclMt35JpLp98
         YxtCSMFH6mlxc6hhJZOKxT2RGice7tSBIN7vHnlFFB+oFgYkxV0GQzzWMFMYN/7CAFnz
         1RoVlg8cTRdby7llG1utuFjRKsxMEvL7cWtyeilnG8J89MEGBG3BWXLDJJnPXKU8aKNp
         MJf+zq2sIeuCWCxKKS2mzrPhxGz/9w02VNUyjpG5ycxjQ29GhL3OnWq3g/LucWTn4jFW
         NSqw==
X-Gm-Message-State: AOAM531riGJ5ag8UjxQhPuQn757Wst91RtdYu8pouPr7TQ5uOYCkxoVH
        YeGC9yNB/Bmm7qESbwMUVEEfC7K+NRa9VC0VJkY=
X-Google-Smtp-Source: ABdhPJzYDwJyQqQ7JC1M6qyzBJGFPsoIMQgLzghjsRQDN9FAEWAPWpbaNU8Vtky1KIfqGcAGnrZfFaspRcPgO5cVhbY=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr8454704oif.154.1635521985809;
 Fri, 29 Oct 2021 08:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
 <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
 <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110281908150.9518@hadrien> <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com>
 <CAJZ5v0ij105B05xPGgfauwFv1KhXRnwh5p28R1y11qKWjxUOhg@mail.gmail.com>
 <CAJZ5v0gAax-uz+shKv4MNBiSBPKGroQGNKdYyUK4v6sRS15o_w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110282112060.9518@hadrien> <CAJZ5v0jmQgg_DwqSdFsoMd5qV_ZH=cHUJtb372mqv=GSWioRgw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110282124201.9518@hadrien> <CAJZ5v0j9fJi+Fa1404uH3V2XJUrVB5crEjcZ9tsnBtQWgCCu4w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110282217390.9518@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110282217390.9518@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Oct 2021 17:39:34 +0200
Message-ID: <CAJZ5v0ijM9V2UmgqM4FzckXA8SQy6pHpBTFm8LLv1Lp_L8JiLw@mail.gmail.com>
Subject: Re: problem in changing from active to passive mode
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000fcaa1d05cf7fa277"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--000000000000fcaa1d05cf7fa277
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 28, 2021 at 10:18 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 28 Oct 2021, Rafael J. Wysocki wrote:
>
> > On Thu, Oct 28, 2021 at 9:25 PM Julia Lawall <julia.lawall@inria.fr> wrote:

[cut]

> > Attached is a patch to do that, but please note that the 5.9 will need
> > to be patched too to address this issue.
>
> I'm not completely clear on what the new patch is doing and how I should
> test it.  If I stay in 5.15, the original patch worked for clearing des
> when going from passive to active.

Sorry for the confusion.

If applied to 5.15-rc alone, the last patch would cause des to be
cleared when switching from passive to active and if applied to both
5.15-rc and 5.9, it would fix the kexec issue as well.

Never mind, though.

The patch attached to this message should cause des to be cleared when
switching from passive to active (because it is based on the previous
patch doing that) and it should prevent nonzero des from being leaked
via the HWP_REQUEST MSR to the new kernel started via kexec.  With
this patch applied to 5.15-rc des should be 0 when switching from
passive to active and it should also be 0 after starting another
kernel via kexec while intel_pstate is running in the passive mode.

Can you please verify that it works as expected?

--000000000000fcaa1d05cf7fa277
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="intel_pstate-clear-desired-on-offline-and-suspend.patch"
Content-Disposition: attachment; 
	filename="intel_pstate-clear-desired-on-offline-and-suspend.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvcjdmkr0>
X-Attachment-Id: f_kvcjdmkr0

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgIDI4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYwo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUu
YworKysgbGludXgtcG0vZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCkBAIC0xMDA1LDkg
KzEwMDUsMTIgQEAgc3RhdGljIHZvaWQgaW50ZWxfcHN0YXRlX2h3cF9vZmZsaW5lKHN0cgogCQkg
Ki8KIAkJdmFsdWUgJj0gfkdFTk1BU0tfVUxMKDMxLCAyNCk7CiAJCXZhbHVlIHw9IEhXUF9FTkVS
R1lfUEVSRl9QUkVGRVJFTkNFKGNwdS0+ZXBwX2NhY2hlZCk7Ci0JCVdSSVRFX09OQ0UoY3B1LT5o
d3BfcmVxX2NhY2hlZCwgdmFsdWUpOwogCX0KIAorCS8qIENsZWFyIHRoZSBkZXNpcmVkIHBlcmYg
ZmllbGQgaW4gdGhlIGNhY2hlZCBIV1AgcmVxdWVzdCB2YWx1ZS4gKi8KKwl2YWx1ZSAmPSB+SFdQ
X0RFU0lSRURfUEVSRih+MEwpOworCVdSSVRFX09OQ0UoY3B1LT5od3BfcmVxX2NhY2hlZCwgdmFs
dWUpOworCiAJdmFsdWUgJj0gfkdFTk1BU0tfVUxMKDMxLCAwKTsKIAltaW5fcGVyZiA9IEhXUF9M
T1dFU1RfUEVSRihSRUFEX09OQ0UoY3B1LT5od3BfY2FwX2NhY2hlZCkpOwogCkBAIC0zMDAyLDYg
KzMwMDUsMjcgQEAgc3RhdGljIGludCBpbnRlbF9jcHVmcmVxX2NwdV9leGl0KHN0cnVjdAogCXJl
dHVybiBpbnRlbF9wc3RhdGVfY3B1X2V4aXQocG9saWN5KTsKIH0KIAorc3RhdGljIGludCBpbnRl
bF9jcHVmcmVxX3N1c3BlbmQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpCit7CisJaW50
ZWxfcHN0YXRlX3N1c3BlbmQocG9saWN5KTsKKworCWlmIChod3BfYWN0aXZlKSB7CisJCXN0cnVj
dCBjcHVkYXRhICpjcHUgPSBhbGxfY3B1X2RhdGFbcG9saWN5LT5jcHVdOworCQl1NjQgdmFsdWUg
PSBSRUFEX09OQ0UoY3B1LT5od3BfcmVxX2NhY2hlZCk7CisKKwkJLyoKKwkJICogQ2xlYXIgdGhl
IGRlc2lyZWQgcGVyZiBmaWVsZCBpbiBNU1JfSFdQX1JFUVVFU1QgaW4gY2FzZQorCQkgKiBpbnRl
bF9jcHVmcmVxX2FkanVzdF9wZXJmKCkgaXMgaW4gdXNlIGFuZCB0aGUgbGFzdCB2YWx1ZQorCQkg
KiB3cml0dGVuIGJ5IGl0IG1heSBub3QgYmUgc3VpdGFibGUuCisJCSAqLworCQl2YWx1ZSAmPSB+
SFdQX0RFU0lSRURfUEVSRih+MEwpOworCQl3cm1zcmxfb25fY3B1KGNwdS0+Y3B1LCBNU1JfSFdQ
X1JFUVVFU1QsIHZhbHVlKTsKKwkJV1JJVEVfT05DRShjcHUtPmh3cF9yZXFfY2FjaGVkLCB2YWx1
ZSk7CisJfQorCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIg
aW50ZWxfY3B1ZnJlcSA9IHsKIAkuZmxhZ3MJCT0gQ1BVRlJFUV9DT05TVF9MT09QUywKIAkudmVy
aWZ5CQk9IGludGVsX2NwdWZyZXFfdmVyaWZ5X3BvbGljeSwKQEAgLTMwMTEsNyArMzAzNSw3IEBA
IHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgaW50ZWxfY3B1ZnIKIAkuZXhpdAkJPSBpbnRl
bF9jcHVmcmVxX2NwdV9leGl0LAogCS5vZmZsaW5lCT0gaW50ZWxfY3B1ZnJlcV9jcHVfb2ZmbGlu
ZSwKIAkub25saW5lCQk9IGludGVsX3BzdGF0ZV9jcHVfb25saW5lLAotCS5zdXNwZW5kCT0gaW50
ZWxfcHN0YXRlX3N1c3BlbmQsCisJLnN1c3BlbmQJPSBpbnRlbF9jcHVmcmVxX3N1c3BlbmQsCiAJ
LnJlc3VtZQkJPSBpbnRlbF9wc3RhdGVfcmVzdW1lLAogCS51cGRhdGVfbGltaXRzCT0gaW50ZWxf
cHN0YXRlX3VwZGF0ZV9saW1pdHMsCiAJLm5hbWUJCT0gImludGVsX2NwdWZyZXEiLAo=
--000000000000fcaa1d05cf7fa277--
