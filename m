Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B167F1A0E65
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 15:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgDGNbE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 09:31:04 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46515 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgDGNbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 09:31:04 -0400
Received: by mail-vs1-f67.google.com with SMTP id z125so2128077vsb.13
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2020 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PuP95pVbFQYLwVP/nv0qO9FfBSm3TrhJmC4ds9qXhk=;
        b=1w1df4RUeeL0VXPeqcyMGJbfByV2WYJmZC7sKAeNL9F9J9/8ILhODXlqWk8iLFAhnb
         w/HDEYdNoDrwBasbNfqwV9lp3R40WUFTTN4Lxf/+SjA4k7SJSgtJKax8PQuyBimSyf9q
         1JcejYcYCOahTojFNZqTKl8Z/S9zO6wlH8DyUqrZiUVMMiYnTUJvsN4d6uWZGrViK8Il
         N+hErK9txJfx0zOnl3HEShvCd4kM+/6CaCGGopJtZHL3tY8oNk94Ps+euXHg5dN/vrs3
         /fTV5DRZPFUwMrJM/zqIg9g46dgGOTLTAPICvLEIoPuTMXn6SuVVo/4gk8kj6YB5enRr
         RWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PuP95pVbFQYLwVP/nv0qO9FfBSm3TrhJmC4ds9qXhk=;
        b=iawG40p3SzDDUjr+6jni9zlhjxucdnA5B2hV8cF7mL6BtNle9sKBPft37HhYUmk5+J
         0njLihUIhdQZGGZmQmK3V49sxyQcvvnugK0eYy6gpJYCqvoHtnoiyNpzHRkfQd3Sl3yC
         NScylFAeQcHKoZOWgVC3HKJs5JA8mDt0d6jbDptWNsvbCWVQR82p3ilcqwXGPpvV4Cxi
         y8Mx4aB0KbmK5VcxasVyzOcVnPNnUP/e7pfkzYEYwcBCASh9BSJ+kD2xtS9nuFyh0FJO
         DaTeRwN/PwCG53UZiTy5Xo6pIhSAFzqTb0Wh8bzSt6HKzgJm9usI+DDLrptFPO31hDCi
         QwEA==
X-Gm-Message-State: AGi0Puad12Tp3DJl7B1aSi5zV7ow5Yst5RKHUQsF/GnFBlXF1ze/bE3Y
        tMs/gTqH8IysV46i39Ks3rufcCJXcWCJd7qLeKtuMifca/8=
X-Google-Smtp-Source: APiQypJIsS5LtRIAMLOYYbraXYPuIBtAA/lQ8r44QqMyhwgvIj2oD2e4b8RhGlT6ilFbbaSHQrUmMUlH0XnQLV3KEX8=
X-Received: by 2002:a67:69d5:: with SMTP id e204mr1615782vsc.159.1586266262706;
 Tue, 07 Apr 2020 06:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200330140859.12535-1-tiwai@suse.de>
In-Reply-To: <20200330140859.12535-1-tiwai@suse.de>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 7 Apr 2020 19:00:51 +0530
Message-ID: <CAHLCerOGgv8k1ce43jvmhZwXWVQ_uB1WgrQN_NbkBphWE9NfHA@mail.gmail.com>
Subject: Re: [PATCH] thermal: Add a sanity check for invalid state at stats update
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001bff0005a2b36595"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--0000000000001bff0005a2b36595
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 30, 2020 at 7:39 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> The thermal sysfs handler keeps the statistics table with the fixed
> size that was determined from the initial max_states() call, and the
> table entry is updated at each sysfs cur_state write call.  And, when
> the driver's set_cur_state() ops accepts the value given from
> user-space, the thermal sysfs core blindly applies it to the
> statistics table entry, which may overflow and cause an Oops.
> Although it's rather a bug in the driver's ops implementations, we
> shouldn't crash but rather give a proper warning instead.
>
> This patch adds a sanity check for avoiding such an OOB access and
> warns with a stack trace to show the suspicious device in question.

Hi Takashi,

Instead of this warning, I think we should reject such input when
writing to cur_state.

See attached patch. If you think this OK, I'll submit it.

Regards,
Amit

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>
> We've hit some crash by stress tests, and this patch at least works
> around the crash itself.  While the actual bug fix of the buggy driver
> is still being investigated, I submit the hardening in the core side
> at first.
>
>  drivers/thermal/thermal_sysfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb4dff7..a23c4e701d63 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -772,6 +772,11 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>
>         spin_lock(&stats->lock);
>
> +       if (dev_WARN_ONCE(&cdev->device, new_state >= stats->max_states,
> +                         "new state %ld exceeds max_state %ld",
> +                         new_state, stats->max_states))
> +               goto unlock;
> +
>         if (stats->state == new_state)
>                 goto unlock;
>
> --
> 2.16.4
>

--0000000000001bff0005a2b36595
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-thermal-Reject-invalid-cur_state-input-from-userspac.patch"
Content-Disposition: attachment; 
	filename="0001-thermal-Reject-invalid-cur_state-input-from-userspac.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k8pxym180>
X-Attachment-Id: f_k8pxym180

RnJvbSA1NDI2NjI2MGQ0ODNhYjQ0NzY1MTBkZDQ0NjFhMWNhZmM2MTFlMTdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8NTQyNjYyNjBkNDgzYWI0NDc2NTEwZGQ0NDYxYTFj
YWZjNjExZTE3ZC4xNTg2MjY2MjI0LmdpdC5hbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+CkZyb206
IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAbGluYXJvLm9yZz4KRGF0ZTogVHVlLCA3IEFw
ciAyMDIwIDE4OjQ4OjE0ICswNTMwClN1YmplY3Q6IFtQQVRDSF0gdGhlcm1hbDogUmVqZWN0IGlu
dmFsaWQgY3VyX3N0YXRlIGlucHV0IGZyb20gdXNlcnNwYWNlCgpXZSBkb24ndCBjaGVjayBpZiB0
aGUgY3VyX3N0YXRlIHZhbHVlIGlucHV0IGluIHN5c2ZzIGlzIGdyZWF0ZXIgdGhhbiB0aGUKbWF4
aW11bSBjb29saW5nIHN0YXRlIHRoYXQgdGhlIGNvb2xpbmcgZGV2aWNlIHN1cHBvcnRzLiBUaGlz
IGNhbiBjYXVzZQphY2Nlc3MgdG8gdW5hbGxvY2F0ZWQgbWVtb3J5IGluIGNhc2UgVEhFUk1BTF9T
VEFUSVNUSUNTIGluIGVuYWJsZWQgYW5kCmNvdWxkIGFsc28gY3Jhc2ggY29vbGluZyBkZXZpY2Vz
IHRoYXQgZG9uJ3QgY2hlY2sgZm9yIGFuIGludmFsaWQgc3RhdGUgaW4KdGhlaXIgc2V0X2N1cl9z
dGF0ZSgpIGNhbGxiYWNrLgoKUmV0dXJuIGFuIGVycm9yIGlmIHRoZSBzdGF0ZSBiZWluZyByZXF1
ZXN0ZWQgaW4gZ3JlYXRlciB0aGFuIHRoZSBtYXhpbXVtCmNvb2xpbmcgc3RhdGUgdGhlIGRldmlj
ZSBzdXBwb3J0cy4KClJlcG9ydGVkLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+ClNp
Z25lZC1vZmYtYnk6IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAbGluYXJvLm9yZz4KLS0t
CiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9zeXNmcy5jIHwgOSArKysrKysrKy0KIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3RoZXJtYWwvdGhlcm1hbF9zeXNmcy5jIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfc3lz
ZnMuYwppbmRleCA3ZTFkMTFiZGQyNTguLjgwMzNlNWE5Mzg2YSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy90aGVybWFsL3RoZXJtYWxfc3lzZnMuYworKysgYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9z
eXNmcy5jCkBAIC03MDMsNyArNzAzLDcgQEAgY3VyX3N0YXRlX3N0b3JlKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCiAJCWNvbnN0IGNoYXIgKmJ1Ziwg
c2l6ZV90IGNvdW50KQogewogCXN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2ID0g
dG9fY29vbGluZ19kZXZpY2UoZGV2KTsKLQl1bnNpZ25lZCBsb25nIHN0YXRlOworCXVuc2lnbmVk
IGxvbmcgc3RhdGUsIG1heF9zdGF0ZTsKIAlpbnQgcmVzdWx0OwogCiAJaWYgKHNzY2FuZihidWYs
ICIlbGRcbiIsICZzdGF0ZSkgIT0gMSkKQEAgLTcxMiw2ICs3MTIsMTMgQEAgY3VyX3N0YXRlX3N0
b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCiAJ
aWYgKChsb25nKXN0YXRlIDwgMCkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwlyZXN1bHQgPSBjZGV2
LT5vcHMtPmdldF9tYXhfc3RhdGUoY2RldiwgJm1heF9zdGF0ZSk7CisJaWYgKHJlc3VsdCkKKwkJ
cmV0dXJuIHJlc3VsdDsKKworCWlmIChzdGF0ZSA+PSBtYXhfc3RhdGUpCisJCXJldHVybiAtRUlO
VkFMOworCiAJbXV0ZXhfbG9jaygmY2Rldi0+bG9jayk7CiAKIAlyZXN1bHQgPSBjZGV2LT5vcHMt
PnNldF9jdXJfc3RhdGUoY2Rldiwgc3RhdGUpOwotLSAKMi4yMC4xCgo=
--0000000000001bff0005a2b36595--
