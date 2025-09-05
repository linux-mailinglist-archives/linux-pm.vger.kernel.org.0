Return-Path: <linux-pm+bounces-34030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F56B46515
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 23:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE9D5C71FC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735562EA179;
	Fri,  5 Sep 2025 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rODhC/Pz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30F28689A;
	Fri,  5 Sep 2025 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106143; cv=none; b=ML/8a1MXoJXSTpvEDcsqQzxf1gS0VYg+kl6DAlcTrTTNJY427c3dtgM1S4aQIbksRO4H+CJTRnSqB2/75AW7hyy58jJDQ/g9onkSH+oDbkD6870flRc5RNym2vA8+f7aZOU7m9qNjVqf9MqmjrwA9QKHT4aPLPd9uKm2mAMfckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106143; c=relaxed/simple;
	bh=kwY2S5NjOZ+gZjDu2Onn6j/3FsL1tvQyzQDEIbUvNJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4D2L9aobgHUADg6su4xJ7B0/pWaW7Q4FSCtuN9F9NktiufflGc8UJ34TOnPdaVw7wOlCMHrVGBZUf0qaXjPVvKJ3Qo9og/jHwuQVJ6hMjND6k5s2LONBGiqIZyKwTfee6LNK1Oq6729CYJWBlXOGF9hNzwYUF3LOyvyDuqkf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rODhC/Pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82F6C4CEF5;
	Fri,  5 Sep 2025 21:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757106142;
	bh=kwY2S5NjOZ+gZjDu2Onn6j/3FsL1tvQyzQDEIbUvNJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rODhC/Pze0mfcLKAwwCuDKiffB9SwKu5tBvBZNCSwLTp+Cj3PgS+ohDbv+IeGcBBv
	 e8iYyBrB4C2mUMwDR3LRY/cBolsKTjLy1gD0hPAsP6qPJAiBC6V+ToB9HGgucDjFKX
	 cMfe+rv6fehSxxVSg6qLMoFYH8xCC/IS+OBFY+9qgoVQi8eyPUnh2t02NsgK48IXf9
	 VVyCQRNS2m0fnt6Fj0JHBM9hL33INOvVyR+Pf5fjPz7lcB8vyGUV+pwNOGRnX11xYC
	 oJt61DVJUItYXpKRrq6Gp52CR5IE4DnZeoN0+dpquqo8+OuDv7qxGUgq57Bpm1oT+m
	 Ty3Ru7siMbyyA==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-746d3b0f7e5so1626075a34.2;
        Fri, 05 Sep 2025 14:02:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFasGANDuWLZOztlTn65Mkwp3TE8EWMdNGLNiShcDOk8d8DLdcq+0vTgoRKCG1xPQG8nkcSbbbCD4=@vger.kernel.org, AJvYcCXJfFJNt50EfFHHgYSijJvrpQLKCh+IUa37Ez++yrXT4cPe0u1gfh7UpQKt3XQITxrra8u8lpFKztBaQDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Tx208C9HvAsVq9S1T93ioHgLQIwoWhC0yME0bxtHMZN7dRvZ
	Wv+S0vAGKNgYV1xqDfACmmK8Al+yw+2gnH20v7YH8rDrAxqTtMyl1l6piHMFBoLh3VTTSbKMRDu
	KCleCz+zYIersVBwYIj29YScQgBL7k1k=
X-Google-Smtp-Source: AGHT+IEeNVVSDNzysoUGWeLsPstgJDEyh0yPYX6bTO+sXI4KhoXS14OY39/BHJ4Rm2B/hFcgyZjRY80F/NseCqGmXKs=
X-Received: by 2002:a05:6808:219b:b0:438:399b:a8a0 with SMTP id
 5614622812f47-43b29a30f74mr129081b6e.17.1757106141930; Fri, 05 Sep 2025
 14:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904000608.260817-1-srinivas.pandruvada@linux.intel.com> <20250904000608.260817-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250904000608.260817-2-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 23:02:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gwXiRTo_Lri3rduA-RqDhwgK4ymwX3ttxqhTw9W6d=fQ@mail.gmail.com>
X-Gm-Features: Ac12FXyVYjofZKYAzM7HP2Dwmb-gyuukosjkOhE8MXG5W6EPhE9-8XYNMTd5iU8
Message-ID: <CAJZ5v0gwXiRTo_Lri3rduA-RqDhwgK4ymwX3ttxqhTw9W6d=fQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Enable HWP without EPP feature
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006c72a4063e1427f4"

--0000000000006c72a4063e1427f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:06=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When EPP feature is not available (CPUID CPUID.06H:EAX[10] is not set),
> intel_pstate will not enable HWP.
>
> Some processors support DEC feature (Dynamic Efficiency Control). But in
> this case HWP must be enabled.
>
> So, enable HWP even if EPP feature is not available but DEC feature is
> present.
>
> When EPP feature is not available don't publish sysfs attributes
> "energy_performance_available_preferences" and
> "energy_performance_preference", but continue to enable HWP.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 35 +++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index c28454b16723..d74abe909fbc 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -904,6 +904,11 @@ static struct freq_attr *hwp_cpufreq_attrs[] =3D {
>         NULL,
>  };
>
> +static struct freq_attr *hwp_cpufreq_default_attrs[] =3D {
> +       &base_frequency,
> +       NULL,
> +};
> +
>  static bool no_cas __ro_after_init;
>
>  static struct cpudata *hybrid_max_perf_cpu __read_mostly;
> @@ -1370,6 +1375,9 @@ static void intel_pstate_hwp_offline(struct cpudata=
 *cpu)
>  #define POWER_CTL_EE_ENABLE    1
>  #define POWER_CTL_EE_DISABLE   2
>
> +/* Enable bit for Dynamic Efficiency Control (DEC) */
> +#define POWER_CTL_DEC_ENABLE   27
> +
>  static int power_ctl_ee_state;
>
>  static void set_power_ctl_ee_state(bool input)
> @@ -3761,6 +3769,17 @@ static const struct x86_cpu_id intel_hybrid_scalin=
g_factor[] =3D {
>         {}
>  };
>
> +static bool dec_enabled(void)
> +{
> +       u64 power_ctl;
> +
> +       rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
> +       if (power_ctl & BIT(POWER_CTL_DEC_ENABLE))
> +               return true;
> +
> +       return false;
> +}
> +
>  static int __init intel_pstate_init(void)
>  {
>         static struct cpudata **_all_cpu_data;
> @@ -3793,15 +3812,24 @@ static int __init intel_pstate_init(void)
>                  * Avoid enabling HWP for processors without EPP support,
>                  * because that means incomplete HWP implementation which=
 is a
>                  * corner case and supporting it is generally problematic=
.
> +                * But when DEC enable bit is set (MSR 0x1FC bit 27), con=
tinue
> +                * to enable HWP.
>                  *
>                  * If HWP is enabled already, though, there is no choice =
but to
>                  * deal with it.
>                  */
> -               if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || hwp=
_forced) {
> +               if (!no_hwp || hwp_forced) {
> +                       if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> +                               intel_pstate.attr =3D hwp_cpufreq_attrs;
> +                               intel_cpufreq.attr =3D hwp_cpufreq_attrs;
> +                       } else if (dec_enabled()) {
> +                               intel_pstate.attr =3D hwp_cpufreq_default=
_attrs;
> +                               intel_cpufreq.attr =3D hwp_cpufreq_defaul=
t_attrs;
> +                       } else {
> +                               goto skip_hwp_enable;
> +                       }
>                         hwp_active =3D true;
>                         hwp_mode_bdw =3D id->driver_data;
> -                       intel_pstate.attr =3D hwp_cpufreq_attrs;
> -                       intel_cpufreq.attr =3D hwp_cpufreq_attrs;
>                         intel_cpufreq.flags |=3D CPUFREQ_NEED_UPDATE_LIMI=
TS;
>                         intel_cpufreq.adjust_perf =3D intel_cpufreq_adjus=
t_perf;
>                         if (!default_driver)
> @@ -3811,6 +3839,7 @@ static int __init intel_pstate_init(void)
>
>                         goto hwp_cpu_matched;
>                 }
> +skip_hwp_enable:
>                 pr_info("HWP not enabled\n");
>         } else {
>                 if (no_load)
> --

I think that this would work, but then it looks super ad hoc and I'd
like to completely rearrange it.

My (totally untested) version is attached.  Please let me know if this
can be made work for you and if so, I'll turn it into a proper patch.

--0000000000006c72a4063e1427f4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="cpufreq-intel_pstate-Enable-HWP-without-EPP-feature.patch"
Content-Disposition: attachment; 
	filename="cpufreq-intel_pstate-Enable-HWP-without-EPP-feature.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mf7bjsw10>
X-Attachment-Id: f_mf7bjsw10

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgIDUzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pCgotLS0gYS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRl
LmMKKysrIGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCkBAIC04OTcsMTEgKzg5Nywx
OSBAQCBzdGF0aWMgc3NpemVfdCBzaG93X2Jhc2VfZnJlcXVlbmN5KHN0cnVjCiAKIGNwdWZyZXFf
ZnJlcV9hdHRyX3JvKGJhc2VfZnJlcXVlbmN5KTsKIAorZW51bSBod3BfY3B1ZnJlcV9hdHRyX2lu
ZGV4IHsKKwlIV1BfQkFTRV9GUkVRVUVOQ1lfSU5ERVggPSAwLAorCUhXUF9QRVJGT1JNQU5DRV9Q
UkVGRVJFTkNFX0lOREVYLAorCUhXUF9QRVJGT1JNQU5DRV9BVkFJTEFCTEVfUFJFRkVSRU5DRVNf
SU5ERVgsCisJSFdQX0NQVUZSRVFfQVRUUl9DT1VOVCwKK307CisKIHN0YXRpYyBzdHJ1Y3QgZnJl
cV9hdHRyICpod3BfY3B1ZnJlcV9hdHRyc1tdID0gewotCSZlbmVyZ3lfcGVyZm9ybWFuY2VfcHJl
ZmVyZW5jZSwKLQkmZW5lcmd5X3BlcmZvcm1hbmNlX2F2YWlsYWJsZV9wcmVmZXJlbmNlcywKLQkm
YmFzZV9mcmVxdWVuY3ksCi0JTlVMTCwKKwlbSFdQX0JBU0VfRlJFUVVFTkNZX0lOREVYXSA9ICZi
YXNlX2ZyZXF1ZW5jeSwKKwlbSFdQX1BFUkZPUk1BTkNFX1BSRUZFUkVOQ0VfSU5ERVhdID0gJmVu
ZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJlbmNlLAorCVtIV1BfUEVSRk9STUFOQ0VfQVZBSUxBQkxF
X1BSRUZFUkVOQ0VTX0lOREVYXSA9CisJCQkJJmVuZXJneV9wZXJmb3JtYW5jZV9hdmFpbGFibGVf
cHJlZmVyZW5jZXMsCisJW0hXUF9DUFVGUkVRX0FUVFJfQ09VTlRdID0gTlVMTCwKIH07CiAKIHN0
YXRpYyBib29sIG5vX2NhcyBfX3JvX2FmdGVyX2luaXQ7CkBAIC0xMzcwLDYgKzEzNzgsOSBAQCBz
dGF0aWMgdm9pZCBpbnRlbF9wc3RhdGVfaHdwX29mZmxpbmUoc3RyCiAjZGVmaW5lIFBPV0VSX0NU
TF9FRV9FTkFCTEUJMQogI2RlZmluZSBQT1dFUl9DVExfRUVfRElTQUJMRQkyCiAKKy8qIEVuYWJs
ZSBiaXQgZm9yIER5bmFtaWMgRWZmaWNpZW5jeSBDb250cm9sIChERUMpICovCisjZGVmaW5lIFBP
V0VSX0NUTF9ERUNfRU5BQkxFCTI3CisKIHN0YXRpYyBpbnQgcG93ZXJfY3RsX2VlX3N0YXRlOwog
CiBzdGF0aWMgdm9pZCBzZXRfcG93ZXJfY3RsX2VlX3N0YXRlKGJvb2wgaW5wdXQpCkBAIC0zNzU5
LDYgKzM3NzAsMzAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkIGludGVsX2h5Ygog
CXt9CiB9OwogCitzdGF0aWMgYm9vbCBod3BfaXNfc3VwcG9ydGVkKHZvaWQpCit7CisJdTY0IHBv
d2VyX2N0bDsKKworCS8qCisJICogQXZvaWQgZW5hYmxpbmcgSFdQIGZvciBwcm9jZXNzb3JzIHdp
dGhvdXQgRVBQIHN1cHBvcnQgdW5sZXNzIHRoZQorCSAqIER5bmFtaWMgRWZmaWNpZW5jeSBDb250
cm9sIChERUMpIGVuYWJsZSBiaXQgKE1TUl9JQTMyX1BPV0VSX0NUTCwKKwkgKiBiaXQgMjcpIGlz
IHNldCBiZWNhdXNlIHRoYXQgbWVhbnMgaW5jb21wbGV0ZSBIV1AgaW1wbGVtZW50YXRpb24KKwkg
KiB3aGljaCBpcyBhIGNvcm5lciBjYXNlIGFuZCBzdXBwb3J0aW5nIGl0IGlzIGdlbmVyYWxseSBw
cm9ibGVtYXRpYy4KKwkgKi8KKwlpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hXUF9FUFAp
KQorCQlyZXR1cm4gdHJ1ZTsKKworCXJkbXNycShNU1JfSUEzMl9QT1dFUl9DVEwsIHBvd2VyX2N0
bCk7CisJaWYgKCEocG93ZXJfY3RsICYgQklUKFBPV0VSX0NUTF9ERUNfRU5BQkxFKSkpCisJCXJl
dHVybiBmYWxzZTsKKworCS8qIFdpdGhvdXQgRVBQIHN1cHBvcnQsIGRvbid0IGV4cG9zZSBFUFAt
cmVsYXRlZCBzeXNmcyBhdHRyaWJ1dGVzLiAqLworCWh3cF9jcHVmcmVxX2F0dHJzW0hXUF9QRVJG
T1JNQU5DRV9QUkVGRVJFTkNFX0lOREVYXSA9IE5VTEw7CisJaHdwX2NwdWZyZXFfYXR0cnNbSFdQ
X1BFUkZPUk1BTkNFX0FWQUlMQUJMRV9QUkVGRVJFTkNFU19JTkRFWF0gPSBOVUxMOworCisJcmV0
dXJuIHRydWU7Cit9CisKIHN0YXRpYyBpbnQgX19pbml0IGludGVsX3BzdGF0ZV9pbml0KHZvaWQp
CiB7CiAJc3RhdGljIHN0cnVjdCBjcHVkYXRhICoqX2FsbF9jcHVfZGF0YTsKQEAgLTM3ODgsMTQg
KzM4MjMsMTAgQEAgc3RhdGljIGludCBfX2luaXQgaW50ZWxfcHN0YXRlX2luaXQodm9pZAogCiAJ
CWNvcHlfY3B1X2Z1bmNzKCZjb3JlX2Z1bmNzKTsKIAkJLyoKLQkJICogQXZvaWQgZW5hYmxpbmcg
SFdQIGZvciBwcm9jZXNzb3JzIHdpdGhvdXQgRVBQIHN1cHBvcnQsCi0JCSAqIGJlY2F1c2UgdGhh
dCBtZWFucyBpbmNvbXBsZXRlIEhXUCBpbXBsZW1lbnRhdGlvbiB3aGljaCBpcyBhCi0JCSAqIGNv
cm5lciBjYXNlIGFuZCBzdXBwb3J0aW5nIGl0IGlzIGdlbmVyYWxseSBwcm9ibGVtYXRpYy4KLQkJ
ICoKLQkJICogSWYgSFdQIGlzIGVuYWJsZWQgYWxyZWFkeSwgdGhvdWdoLCB0aGVyZSBpcyBubyBj
aG9pY2UgYnV0IHRvCi0JCSAqIGRlYWwgd2l0aCBpdC4KKwkJICogSWYgSFdQIGlzIGVuYWJsZWQg
YWxyZWFkeSwgdGhlcmUgaXMgbm8gY2hvaWNlIGJ1dCB0byBkZWFsCisJCSAqIHdpdGggaXQuCiAJ
CSAqLwotCQlpZiAoKCFub19od3AgJiYgYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hXUF9FUFAp
KSB8fCBod3BfZm9yY2VkKSB7CisJCWlmIChod3BfZm9yY2VkIHx8ICghbm9faHdwICYmIGh3cF9p
c19zdXBwb3J0ZWQoKSkpIHsKIAkJCWh3cF9hY3RpdmUgPSB0cnVlOwogCQkJaHdwX21vZGVfYmR3
ID0gaWQtPmRyaXZlcl9kYXRhOwogCQkJaW50ZWxfcHN0YXRlLmF0dHIgPSBod3BfY3B1ZnJlcV9h
dHRyczsK
--0000000000006c72a4063e1427f4--

