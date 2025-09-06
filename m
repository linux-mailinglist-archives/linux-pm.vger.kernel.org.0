Return-Path: <linux-pm+bounces-34068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C3B473D7
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 18:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A021667E8
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172A1F2BAB;
	Sat,  6 Sep 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3VkcHHV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093631C863B;
	Sat,  6 Sep 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175220; cv=none; b=Pn5g46R2dyAISsOdtUzOk79IjdjLV3hjOxcw7LUEH+EMlG1Zx/lEpXfqT4+382hlKM0cgkhlrcWb9T/81xAsBg3Fzqugk78nBzxHskqPUJOjsJNVou+nVXrMzwTfSvvxe/5Ua2rcUV37k5XWQHe1L9gN6SagXWUo2SFoIRcSSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175220; c=relaxed/simple;
	bh=hLRERVRp0WcjpP7lxma/M30tLMcZ7du1iTsdJ/brzK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy/Afap3zPBeHMeMikE5ZiWB8E2lwSkBOFuPUwksHqtzBX1tah/JJsNWRRyVA74oCMaguL8PZ+fHks/D6kl1Ldog5A98a9aqzwu4QfyyNmvpEfkSQPa53qg2pJUSsMghz8Qcfq9dr8B9QYkb/PDRgzJXkZiA7yo2cRdRrVy3S3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3VkcHHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DBAC4CEE7;
	Sat,  6 Sep 2025 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757175219;
	bh=hLRERVRp0WcjpP7lxma/M30tLMcZ7du1iTsdJ/brzK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L3VkcHHVdSHn6ugkVRCxDxZk9Ir30lEkprmmHkCc53MiVa7L7Lemlix7aGy6P20A3
	 vWyR3DUt4oBSWBQQ4Kgoe/RCrSFuZbtseRuJt+Yi2V9RvITm/7grRk+qORFJfpAins
	 akmIrxTwc5I3FW4+WOi64/B+xzx2gph3WiVupVV/yPY0IVOnusXUyiyUPex8lSIIdJ
	 PMjhalmlU3Hy7D2YTO7Wwrrkom1XW3F5C9bJSdcH4NWHVbTVdQZrpekcE3C39IrPpo
	 xNx5N0uy9Emb9ZcSPDlNwR7XNwGzcrxPPNvJEbXak1Km9yZ5xEqERrOwJY/d2GpQAL
	 B/jD4n5y9tvVQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6205e2b7a8fso736278eaf.0;
        Sat, 06 Sep 2025 09:13:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8X/Twyj45l1y4qA50LhuKS16d7DFhkF8r3tLHoOeGHBPPbRolcOgwHvq48uuCgeT8GKKn/pzSHHhRNrk=@vger.kernel.org, AJvYcCWRvbcsai9++IFrA80qwXwN1jqYu76mSTGcBkafTjLVOIzR9ifrNFZiiccHYHwF1u9LktQ4DepplWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8BPB/ZB+evaWTufljNO4scHbZ58iQ+z8GjZIQwmjmE7t11eY
	rzq3fReLyy+q/xdoB3Y2fbSKyZpjET4cgSvIKAXPO3GK8VNMebQynjJiBRZIDhZWVjYhf5qAOvK
	Gjw6md0Jqn9/fzsjYq7BzEdiz62X1HSU=
X-Google-Smtp-Source: AGHT+IExy1C0u5pm54h3eQeNGwO2U+TH+hsvJZPeM+nxavXx34Fx5cMexFqeAmdc1DuBCSunFYFYr+5EVc6RgoogTjc=
X-Received: by 2002:a05:6820:4de6:b0:621:69bf:7629 with SMTP id
 006d021491bc7-62178a834dfmr854802eaf.8.1757175218849; Sat, 06 Sep 2025
 09:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904000608.260817-1-srinivas.pandruvada@linux.intel.com>
 <20250904000608.260817-2-srinivas.pandruvada@linux.intel.com> <CAJZ5v0gwXiRTo_Lri3rduA-RqDhwgK4ymwX3ttxqhTw9W6d=fQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gwXiRTo_Lri3rduA-RqDhwgK4ymwX3ttxqhTw9W6d=fQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 6 Sep 2025 18:13:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jqLnnBL8fLJ3vxS_61rAigru8T1a9Q-k+cg2kptv_zUA@mail.gmail.com>
X-Gm-Features: Ac12FXw_2G1K4mf8f1kGGntWx65vzH9D6Mf710bkFOsrLLNIN4VO-eDHdv_ARU8
Message-ID: <CAJZ5v0jqLnnBL8fLJ3vxS_61rAigru8T1a9Q-k+cg2kptv_zUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Enable HWP without EPP feature
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ba6230063e243cb8"

--000000000000ba6230063e243cb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:02=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 4, 2025 at 2:06=E2=80=AFAM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > When EPP feature is not available (CPUID CPUID.06H:EAX[10] is not set),
> > intel_pstate will not enable HWP.
> >
> > Some processors support DEC feature (Dynamic Efficiency Control). But i=
n
> > this case HWP must be enabled.
> >
> > So, enable HWP even if EPP feature is not available but DEC feature is
> > present.
> >
> > When EPP feature is not available don't publish sysfs attributes
> > "energy_performance_available_preferences" and
> > "energy_performance_preference", but continue to enable HWP.
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 35 +++++++++++++++++++++++++++++++---
> >  1 file changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
> > index c28454b16723..d74abe909fbc 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -904,6 +904,11 @@ static struct freq_attr *hwp_cpufreq_attrs[] =3D {
> >         NULL,
> >  };
> >
> > +static struct freq_attr *hwp_cpufreq_default_attrs[] =3D {
> > +       &base_frequency,
> > +       NULL,
> > +};
> > +
> >  static bool no_cas __ro_after_init;
> >
> >  static struct cpudata *hybrid_max_perf_cpu __read_mostly;
> > @@ -1370,6 +1375,9 @@ static void intel_pstate_hwp_offline(struct cpuda=
ta *cpu)
> >  #define POWER_CTL_EE_ENABLE    1
> >  #define POWER_CTL_EE_DISABLE   2
> >
> > +/* Enable bit for Dynamic Efficiency Control (DEC) */
> > +#define POWER_CTL_DEC_ENABLE   27
> > +
> >  static int power_ctl_ee_state;
> >
> >  static void set_power_ctl_ee_state(bool input)
> > @@ -3761,6 +3769,17 @@ static const struct x86_cpu_id intel_hybrid_scal=
ing_factor[] =3D {
> >         {}
> >  };
> >
> > +static bool dec_enabled(void)
> > +{
> > +       u64 power_ctl;
> > +
> > +       rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
> > +       if (power_ctl & BIT(POWER_CTL_DEC_ENABLE))
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  static int __init intel_pstate_init(void)
> >  {
> >         static struct cpudata **_all_cpu_data;
> > @@ -3793,15 +3812,24 @@ static int __init intel_pstate_init(void)
> >                  * Avoid enabling HWP for processors without EPP suppor=
t,
> >                  * because that means incomplete HWP implementation whi=
ch is a
> >                  * corner case and supporting it is generally problemat=
ic.
> > +                * But when DEC enable bit is set (MSR 0x1FC bit 27), c=
ontinue
> > +                * to enable HWP.
> >                  *
> >                  * If HWP is enabled already, though, there is no choic=
e but to
> >                  * deal with it.
> >                  */
> > -               if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || h=
wp_forced) {
> > +               if (!no_hwp || hwp_forced) {
> > +                       if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> > +                               intel_pstate.attr =3D hwp_cpufreq_attrs=
;
> > +                               intel_cpufreq.attr =3D hwp_cpufreq_attr=
s;
> > +                       } else if (dec_enabled()) {
> > +                               intel_pstate.attr =3D hwp_cpufreq_defau=
lt_attrs;
> > +                               intel_cpufreq.attr =3D hwp_cpufreq_defa=
ult_attrs;
> > +                       } else {
> > +                               goto skip_hwp_enable;
> > +                       }
> >                         hwp_active =3D true;
> >                         hwp_mode_bdw =3D id->driver_data;
> > -                       intel_pstate.attr =3D hwp_cpufreq_attrs;
> > -                       intel_cpufreq.attr =3D hwp_cpufreq_attrs;
> >                         intel_cpufreq.flags |=3D CPUFREQ_NEED_UPDATE_LI=
MITS;
> >                         intel_cpufreq.adjust_perf =3D intel_cpufreq_adj=
ust_perf;
> >                         if (!default_driver)
> > @@ -3811,6 +3839,7 @@ static int __init intel_pstate_init(void)
> >
> >                         goto hwp_cpu_matched;
> >                 }
> > +skip_hwp_enable:
> >                 pr_info("HWP not enabled\n");
> >         } else {
> >                 if (no_load)
> > --
>
> I think that this would work, but then it looks super ad hoc and I'd
> like to completely rearrange it.
>
> My (totally untested) version is attached.  Please let me know if this
> can be made work for you and if so, I'll turn it into a proper patch.

Bah, the EPP-related attributes need to be hidden when EPP is not
there, even if hwp_forced is set.

Attached is a new version, please let me know if it works for you.

--000000000000ba6230063e243cb8
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="intel_pstate-Enable-HWP-without-EPP-v2.patch"
Content-Disposition: attachment; 
	filename="intel_pstate-Enable-HWP-without-EPP-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mf8gp9ea0>
X-Attachment-Id: f_mf8gp9ea0

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgIDcyICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9u
cygrKSwgMTYgZGVsZXRpb25zKC0pCgotLS0gYS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRl
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
CiBzdGF0aWMgdm9pZCBzZXRfcG93ZXJfY3RsX2VlX3N0YXRlKGJvb2wgaW5wdXQpCkBAIC0zNzU4
LDYgKzM3NjksMjYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkIGludGVsX2h5Ygog
CXt9CiB9OwogCitzdGF0aWMgYm9vbCBod3BfY2hlY2tfZXBwKHZvaWQpCit7CisJaWYgKGJvb3Rf
Y3B1X2hhcyhYODZfRkVBVFVSRV9IV1BfRVBQKSkKKwkJcmV0dXJuIHRydWU7CisKKwkvKiBXaXRo
b3V0IEVQUCBzdXBwb3J0LCBkb24ndCBleHBvc2UgRVBQLXJlbGF0ZWQgc3lzZnMgYXR0cmlidXRl
cy4gKi8KKwlod3BfY3B1ZnJlcV9hdHRyc1tIV1BfUEVSRk9STUFOQ0VfUFJFRkVSRU5DRV9JTkRF
WF0gPSBOVUxMOworCWh3cF9jcHVmcmVxX2F0dHJzW0hXUF9QRVJGT1JNQU5DRV9BVkFJTEFCTEVf
UFJFRkVSRU5DRVNfSU5ERVhdID0gTlVMTDsKKworCXJldHVybiBmYWxzZTsKK30KKworc3RhdGlj
IGJvb2wgaHdwX2NoZWNrX2RlYyh2b2lkKQoreworCXU2NCBwb3dlcl9jdGw7CisKKwlyZG1zcnEo
TVNSX0lBMzJfUE9XRVJfQ1RMLCBwb3dlcl9jdGwpOworCXJldHVybiAhIShwb3dlcl9jdGwgJiBC
SVQoUE9XRVJfQ1RMX0RFQ19FTkFCTEUpKTsKK30KKwogc3RhdGljIGludCBfX2luaXQgaW50ZWxf
cHN0YXRlX2luaXQodm9pZCkKIHsKIAlzdGF0aWMgc3RydWN0IGNwdWRhdGEgKipfYWxsX2NwdV9k
YXRhOwpAQCAtMzc3OCwyMyArMzgwOSwzMiBAQCBzdGF0aWMgaW50IF9faW5pdCBpbnRlbF9wc3Rh
dGVfaW5pdCh2b2lkCiAKIAlpZCA9IHg4Nl9tYXRjaF9jcHUoaHdwX3N1cHBvcnRfaWRzKTsKIAlp
ZiAoaWQpIHsKLQkJaHdwX2ZvcmNlZCA9IGludGVsX3BzdGF0ZV9od3BfaXNfZW5hYmxlZCgpOwor
CQlib29sIGVwcF9wcmVzZW50ID0gaHdwX2NoZWNrX2VwcCgpOwogCi0JCWlmIChod3BfZm9yY2Vk
KQorCQkvKgorCQkgKiBJZiBIV1AgaXMgZW5hYmxlZCBhbHJlYWR5LCB0aGVyZSBpcyBubyBjaG9p
Y2UgYnV0IHRvIGRlYWwKKwkJICogd2l0aCBpdC4KKwkJICovCisJCWh3cF9mb3JjZWQgPSBpbnRl
bF9wc3RhdGVfaHdwX2lzX2VuYWJsZWQoKTsKKwkJaWYgKGh3cF9mb3JjZWQpIHsKIAkJCXByX2lu
Zm8oIkhXUCBlbmFibGVkIGJ5IEJJT1NcbiIpOwotCQllbHNlIGlmIChub19sb2FkKQorCQkJbm9f
aHdwID0gMDsKKwkJfSBlbHNlIGlmIChub19sb2FkKSB7CiAJCQlyZXR1cm4gLUVOT0RFVjsKKwkJ
fSBlbHNlIGlmICghZXBwX3ByZXNlbnQgJiYgIWh3cF9jaGVja19kZWMoKSkgeworCQkJLyoKKwkJ
CSAqIEF2b2lkIGVuYWJsaW5nIEhXUCBmb3IgcHJvY2Vzc29ycyB3aXRob3V0IEVQUCBzdXBwb3J0
CisJCQkgKiB1bmxlc3MgdGhlIER5bmFtaWMgRWZmaWNpZW5jeSBDb250cm9sIChERUMpIGVuYWJs
ZQorCQkJICogYml0IChNU1JfSUEzMl9QT1dFUl9DVEwsIGJpdCAyNykgaXMgc2V0IGJlY2F1c2Ug
dGhhdAorCQkJICogbWVhbnMgaW5jb21wbGV0ZSBIV1AgaW1wbGVtZW50YXRpb24gd2hpY2ggaXMg
YSBjb3JuZXIKKwkJCSAqIGNhc2UgYW5kIHN1cHBvcnRpbmcgaXQgaXMgZ2VuZXJhbGx5IHByb2Js
ZW1hdGljLgorCQkJICovCisJCQlub19od3AgPSAxOworCQl9CiAKIAkJY29weV9jcHVfZnVuY3Mo
JmNvcmVfZnVuY3MpOwotCQkvKgotCQkgKiBBdm9pZCBlbmFibGluZyBIV1AgZm9yIHByb2Nlc3Nv
cnMgd2l0aG91dCBFUFAgc3VwcG9ydCwKLQkJICogYmVjYXVzZSB0aGF0IG1lYW5zIGluY29tcGxl
dGUgSFdQIGltcGxlbWVudGF0aW9uIHdoaWNoIGlzIGEKLQkJICogY29ybmVyIGNhc2UgYW5kIHN1
cHBvcnRpbmcgaXQgaXMgZ2VuZXJhbGx5IHByb2JsZW1hdGljLgotCQkgKgotCQkgKiBJZiBIV1Ag
aXMgZW5hYmxlZCBhbHJlYWR5LCB0aG91Z2gsIHRoZXJlIGlzIG5vIGNob2ljZSBidXQgdG8KLQkJ
ICogZGVhbCB3aXRoIGl0LgotCQkgKi8KLQkJaWYgKCghbm9faHdwICYmIGJvb3RfY3B1X2hhcyhY
ODZfRkVBVFVSRV9IV1BfRVBQKSkgfHwgaHdwX2ZvcmNlZCkgeworCisJCWlmICghbm9faHdwKSB7
CiAJCQlod3BfYWN0aXZlID0gdHJ1ZTsKIAkJCWh3cF9tb2RlX2JkdyA9IGlkLT5kcml2ZXJfZGF0
YTsKIAkJCWludGVsX3BzdGF0ZS5hdHRyID0gaHdwX2NwdWZyZXFfYXR0cnM7Cg==
--000000000000ba6230063e243cb8--

