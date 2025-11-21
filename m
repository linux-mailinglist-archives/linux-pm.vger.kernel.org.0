Return-Path: <linux-pm+bounces-38368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 848DDC79265
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67A004EBACD
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9F345751;
	Fri, 21 Nov 2025 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8n//RAo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4434403C
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730670; cv=none; b=i29JtufObs95ed5Dcf99DXIuqUjWjl29u61vuydhWbgBf7ORDsyJu2jwiMpZKftxE02Cb0HwGcz8rUaLr0KmVnoqdSHDVdbd27ncc5Wvh0o4lujBq1V9o6Wf6xlcDvvM/dk4ckXQz2UCcJDXQXFm+2vlwqDYnZE4RHfAnEsG4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730670; c=relaxed/simple;
	bh=JIYgszXNH0+jUKbQeR1Qnn/VbarzzshNt59U4gEqEK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFYo7LfLlnMNfCj922qndPsSUfExK18ACW/1xG2FHmFrOyzeOnXAiRyCVhwIdHwRUOfSedfjizwFEUuwlMVa6tnlZHI2qIlTSOvjjEyaxrHwjnF4zRN8R9kYfwm/Zbdy6sb7hDul05lg3hcJva7kpFlv2h3tNWbwObJWackau4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8n//RAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1AAC4CEFB
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 13:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763730669;
	bh=JIYgszXNH0+jUKbQeR1Qnn/VbarzzshNt59U4gEqEK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V8n//RAoJaXbyG/NykKaLbrkpW9S3T/XfJSSPZvw/T+v/rlrCrjAUtEhNTOfasiGc
	 sH8oRb+G5/TVBpeSYrgfxws/B+fZy5/Ad/nbH+vzMgAYrDKZwT94xRzFETzgjeTadr
	 koJM6ouwQ+O6JEJVwLnjv9Jvcp3wgLRIEMSYddi/+TKEGrtZQI2NRQcRcnNGJa5P9s
	 V9hM+HUmFeI28PwiyaVX2sFA6G+gsIwkBq/nszvnDvBhidLgz40UuN1eLWn9gUm32W
	 xrpmhB9wEHwhmRBYUeSBbSlTXDevUoUudgM5QY5X0vjmyQq0DbubQCV88/OF4vQZXe
	 xcKhJY1X3oBjA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso1270951fac.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 05:11:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGWzdp1Tz0FNm25h3MdbXdzQ1UB+B9ApFjqtw+3FdA/Nc4XZnxtY8JgIvfYFB4phQUdhIecaJKLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwNKkRvm74Y287lE/1mnFfZyIxuwM9UWoV+8fgMQ5z8FpCjHj
	/uQIRZ9lS1ErkMHR66hnWNvK+c+BzyK+PZuaz3XeCAm40WlspM/v29IM79NqHXxerKuuMzwIV6I
	i4g+hKZ/qXyoziOsH72yZju6GsN/Zd9U=
X-Google-Smtp-Source: AGHT+IGN3qq9mxPnMrC9Lfj98rFkvXMzHsdrNeR1Gcm9BGsVmmtpx4DeRJz1cZ8PyQVmNJWLKd/C2lpyhpx400YUIdU=
X-Received: by 2002:a05:6808:2110:b0:450:ba5b:a46b with SMTP id
 5614622812f47-45112d8cc9bmr807890b6e.64.1763730669214; Fri, 21 Nov 2025
 05:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121010756.6687-1-val@packett.cool>
In-Reply-To: <20251121010756.6687-1-val@packett.cool>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Nov 2025 14:10:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h1VTozCKweKvma3dQiUCz8KkR88Hue1cL_jDaKiP+BEw@mail.gmail.com>
X-Gm-Features: AWmQ_blcWB5zoePI22y4acEeAzm9bTDT2TYoTrkXb4JkvJhzZsLYBoEjcWPdnG0
Message-ID: <CAJZ5v0h1VTozCKweKvma3dQiUCz8KkR88Hue1cL_jDaKiP+BEw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: warn and fixup on sanity check instead of
 rejecting the driver
To: Val Packett <val@packett.cool>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000004b6f206441a8c22"

--00000000000004b6f206441a8c22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:08=E2=80=AFAM Val Packett <val@packett.cool> wrot=
e:
>
> On Device Tree platforms, the latency and target residency values come
> directly from device trees, which are numerous and weren't all written
> with cpuidle invariants in mind. For example, qcom/hamoa.dtsi currently
> trips this check: exit latency 680000 > residency 600000.

So this breaks cpuidle expectations and it doesn't work correctly on
the affected platforms.

> Instead of harshly rejecting the entire cpuidle driver with a mysterious
> error message, print a warning and set the target residency value to be
> equal to the exit latency.

This generally doesn't work because the new target residency may be
greater than the target residency of the next state.

> Fixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and targ=
et residency")
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  drivers/cpuidle/driver.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 1c295a93d582..06aeb59c1017 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -199,8 +199,11 @@ static int __cpuidle_driver_init(struct cpuidle_driv=
er *drv)
>                  * exceed its target residency which is assumed in cpuidl=
e in
>                  * multiple places.
>                  */
> -               if (s->exit_latency_ns > s->target_residency_ns)
> -                       return -EINVAL;
> +               if (s->exit_latency_ns > s->target_residency_ns) {
> +                       pr_warn("cpuidle: state %d: exit latency %lld > r=
esidency %lld (fixing)\n",
> +                               i, s->exit_latency_ns, s->target_residenc=
y_ns);
> +                       s->target_residency_ns =3D s->exit_latency_ns;

And you also need to update s->target_residency.

Moreover, that needs to be done when all of the target residency and
exit latency values have been computed and full sanitization of all
the states would need to be done (including the ordering checks), but
the kernel has insufficient information to do that (for instance, if
the ordering is not as expected, it is not clear how to fix it up).
Even the above sanitization is unlikely to result in the intended
behavior.

So if returning the error code doesn't work, printing a warning is as
much as can be done, like in the attached patch.

If this works for you, I'll submit it properly later.

> +               }
>         }
>
>         return 0;
> --

--00000000000004b6f206441a8c22
Content-Type: text/x-patch; charset="US-ASCII"; name="cpuidle-warn.patch"
Content-Disposition: attachment; filename="cpuidle-warn.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mi8vnx550>
X-Attachment-Id: f_mi8vnx550

LS0tCiBkcml2ZXJzL2NwdWlkbGUvZHJpdmVyLmMgfCAgIDE4ICsrKysrKysrLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgotLS0gYS9k
cml2ZXJzL2NwdWlkbGUvZHJpdmVyLmMKKysrIGIvZHJpdmVycy9jcHVpZGxlL2RyaXZlci5jCkBA
IC04LDYgKzgsOCBAQAogICogVGhpcyBjb2RlIGlzIGxpY2VuY2VkIHVuZGVyIHRoZSBHUEwuCiAg
Ki8KIAorI2RlZmluZSBwcl9mbXQoZm10KSBLQlVJTERfTU9ETkFNRSAiOiAiIGZtdAorCiAjaW5j
bHVkZSA8bGludXgvbXV0ZXguaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRl
IDxsaW51eC9zY2hlZC5oPgpAQCAtMTUyLDcgKzE1NCw3IEBAIHN0YXRpYyB2b2lkIGNwdWlkbGVf
c2V0dXBfYnJvYWRjYXN0X3RpbWUKICAqIF9fY3B1aWRsZV9kcml2ZXJfaW5pdCAtIGluaXRpYWxp
emUgdGhlIGRyaXZlcidzIGludGVybmFsIGRhdGEKICAqIEBkcnY6IGEgdmFsaWQgcG9pbnRlciB0
byBhIHN0cnVjdCBjcHVpZGxlX2RyaXZlcgogICovCi1zdGF0aWMgaW50IF9fY3B1aWRsZV9kcml2
ZXJfaW5pdChzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydikKK3N0YXRpYyB2b2lkIF9fY3B1aWRs
ZV9kcml2ZXJfaW5pdChzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydikKIHsKIAlpbnQgaTsKIApA
QCAtMTk1LDE1ICsxOTcsMTMgQEAgc3RhdGljIGludCBfX2NwdWlkbGVfZHJpdmVyX2luaXQoc3Ry
dWN0CiAJCQlzLT5leGl0X2xhdGVuY3kgPSBkaXZfdTY0KHMtPmV4aXRfbGF0ZW5jeV9ucywgTlNF
Q19QRVJfVVNFQyk7CiAKIAkJLyoKLQkJICogRW5zdXJlIHRoYXQgdGhlIGV4aXQgbGF0ZW5jeSBv
ZiBhIENQVSBpZGxlIHN0YXRlIGRvZXMgbm90Ci0JCSAqIGV4Y2VlZCBpdHMgdGFyZ2V0IHJlc2lk
ZW5jeSB3aGljaCBpcyBhc3N1bWVkIGluIGNwdWlkbGUgaW4KLQkJICogbXVsdGlwbGUgcGxhY2Vz
LgorCQkgKiBXYXJuIGlmIHRoZSBleGl0IGxhdGVuY3kgb2YgYSBDUFUgaWRsZSBzdGF0ZSBleGNl
ZWRzIGl0cworCQkgKiB0YXJnZXQgcmVzaWRlbmN5IHdoaWNoIGlzIGFzc3VtZWQgdG8gbmV2ZXIg
aGFwcGVuIGluIGNwdWlkbGUKKwkJICogaW4gbXVsdGlwbGUgcGxhY2VzLgogCQkgKi8KIAkJaWYg
KHMtPmV4aXRfbGF0ZW5jeV9ucyA+IHMtPnRhcmdldF9yZXNpZGVuY3lfbnMpCi0JCQlyZXR1cm4g
LUVJTlZBTDsKKwkJCXByX3dhcm4oIklkbGUgc3RhdGUgJWQgdGFyZ2V0IHJlc2lkZW5jeSB0b28g
bG93XG4iLCBpKTsKIAl9Ci0KLQlyZXR1cm4gMDsKIH0KIAogLyoqCkBAIC0yMzMsOSArMjMzLDcg
QEAgc3RhdGljIGludCBfX2NwdWlkbGVfcmVnaXN0ZXJfZHJpdmVyKHN0cgogCWlmIChjcHVpZGxl
X2Rpc2FibGVkKCkpCiAJCXJldHVybiAtRU5PREVWOwogCi0JcmV0ID0gX19jcHVpZGxlX2RyaXZl
cl9pbml0KGRydik7Ci0JaWYgKHJldCkKLQkJcmV0dXJuIHJldDsKKwlfX2NwdWlkbGVfZHJpdmVy
X2luaXQoZHJ2KTsKIAogCXJldCA9IF9fY3B1aWRsZV9zZXRfZHJpdmVyKGRydik7CiAJaWYgKHJl
dCkK
--00000000000004b6f206441a8c22--

