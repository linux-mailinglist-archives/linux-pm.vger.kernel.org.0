Return-Path: <linux-pm+bounces-8785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 435B990083D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 17:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B331F2731A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B49199380;
	Fri,  7 Jun 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdOkLoTu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA2F198E84;
	Fri,  7 Jun 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772709; cv=none; b=MI1zGRXifVaXlB3SCHCll6lzvA2ZQ0q4MN3/TEj2Q7elI3ldt5iGS4ujyhAFgCp0X3ZhJC3LHo627jt260BU9lUyVyHnFsyvzAXeumlJrngTfOzgKOAPy9e8ZUkRMV91yFK4cQmmkLSQ4O1uwqm2l7PEihwCsrNCgZoWlCtEsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772709; c=relaxed/simple;
	bh=hxdOBIFpzvLuVlj0/tQBcXCexd1esA1lmDKCEQeF3os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8yfinLrEuk9cQAYDi04enupDMgWYefh/yv8fmhug8dCxJPYkxpHl0ICjrrQVvPgUElNiCGCfgjI+XWBu4HbWV5busInbJFM/w9E3T/8fdWppptPcjZ+VB6d2qNBrhi5+J/mopCTyj/LDApu1BLzSuqabLGYqepRL0Spl88/uec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdOkLoTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98155C3277B;
	Fri,  7 Jun 2024 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772708;
	bh=hxdOBIFpzvLuVlj0/tQBcXCexd1esA1lmDKCEQeF3os=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JdOkLoTuwU5TUS/3Jnkj8onU1nEE/NJd1hlbXzy4ym2o4U3wTEN7j0d2ioefsrqeC
	 1HMy3F4DagBQrDgKMxVw3BRqaMVEpPMLL4l+RGFnT4d4305AzqxodiZjEyv6Gp7Ckx
	 NRDZZLpc69z1WsOAFWoGdbvDpIsi2uPQ0BVNpwCHdRTzymUJKWtnbuWXFqW5fX0nmG
	 bNucAus4qZMeheiMFGCXTt/mR1vJMveUCBfyDArgwAyZq6hImXuuA9RsnsjFIYlE2f
	 KPSzGEueSqnUutxCVFled7fBvaknBYjO0awW3BOe5kCk2F0m+Zns8RycmEAsz2gry6
	 rRoDKJ/O2czlw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d218bbba30so46029b6e.3;
        Fri, 07 Jun 2024 08:05:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb1bWKE1H/tLnut/mdXSjFEgelKxnRRz5vmoo9R4ge4F9UM0RErSSdnELQjM5Wtzh0DcQJNlys/q+SWcCw/HpFRzuUrl4NyTKUjuVL0n3Zj9BPFIgyaz0o6LMshq4UIIUQRhVWgGw=
X-Gm-Message-State: AOJu0Yx6Mlxi5TDDt6mjp6f/YP2GO/1Mf6binL19ciMLQNFN3vDS7hha
	xl9/F6j5QIWM0Z2DdfVcEtV/+xSvNT1hbtyoTEmWsIcRt1HSRtScdtvd16KX6p7fGICSldPNCG9
	lqM+OFRlVGgzPqqAWjNbgsXxEV2E=
X-Google-Smtp-Source: AGHT+IHRrjLeNDoOnuN/4gDMAgpm5VMxw9tymilfNC3lKc+GBnDyxi6xNkOedNoYPNPhHySGqiQCjeDa5/7W/juq1ck=
X-Received: by 2002:a4a:a788:0:b0:5ba:ca8a:6598 with SMTP id
 006d021491bc7-5baca8a70b5mr898315eaf.0.1717772707773; Fri, 07 Jun 2024
 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
 <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
 <29d69252dcdc398f147c9139a8666d09e7bd831d.camel@linux.intel.com>
 <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
 <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
 <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
 <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
 <f34c20ae3feac0e3570125f124e440d51c5e4d9b.camel@linux.intel.com>
 <1da736da33a61de92314934ecf7fa0420d6d6b81.camel@linux.intel.com>
 <aa643910265b9d92a397d5148b31d37b2c421b8b.camel@xry111.site>
 <63e98f2151ef64de92cf7e3da796937755ea5552.camel@linux.intel.com>
 <258ce61c155c28937620f6abe57a39f2b4b0ff56.camel@xry111.site>
 <101b903e58f2ebae60934edc374c7cda09f83de1.camel@linux.intel.com>
 <CAJZ5v0jBBgjBny0Ps9bvHc7q1Un_6sdudpNL0==Z5HB+gHH0Hw@mail.gmail.com>
 <651d11578646200cdb0a91c46ed09a22f29e94a0.camel@linux.intel.com>
 <1031cc4e4b507628531d9115ce7e4bc588dbab1c.camel@xry111.site> <a2f992adc034063de7f63e9065976f39f9929503.camel@linux.intel.com>
In-Reply-To: <a2f992adc034063de7f63e9065976f39f9929503.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 17:04:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gvY6FGwhzTKrmNnKc48ixWAgTeT3Sw2tOUfshDwq3NcA@mail.gmail.com>
Message-ID: <CAJZ5v0gvY6FGwhzTKrmNnKc48ixWAgTeT3Sw2tOUfshDwq3NcA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000d69a0061a4e20a2"

--0000000000000d69a0061a4e20a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 2:05=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2024-06-05 at 13:21 +0800, Xi Ruoyao wrote:
> > On Tue, 2024-06-04 at 09:56 -0700, srinivas pandruvada wrote:
> > > > > With such a delay, I am not sure how this even worked before.
> >
> > It didn't work out of box but it worked after manually writing 0 to
> > no_turbo after 20 seconds, see
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D218702.
>
> That make sense. So it never worked out of box. The store_no_turbo()
> has additional read for turbo flag before, which is removed now. I
> think adding that back will will restore old behavior.
>
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 4b986c044741..0d5330e5b96b 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1301,6 +1301,8 @@ static ssize_t store_no_turbo(struct kobject *a,
> struct kobj_attribute *b,
>
>         no_turbo =3D !!clamp_t(int, input, 0, 1);
>
> +       global.turbo_disabled =3D turbo_is_disabled();
> +
>         if (no_turbo =3D=3D global.no_turbo)
>                 goto unlock_driver;
>
>
> Need to adjust the mutex around it also.

Anyhow, it can be made work.

global.turbo_disabled can be updated right before it is checked in
store_no_turbo(), so if 0 is written to no_turbo (and global.no_turbo
is 1), it will succeed if global.turbo_disabled changes from 1 to 0.

Something like the attached (untested) patch.

--0000000000000d69a0061a4e20a2
Content-Type: text/x-patch; charset="US-ASCII"; name="intel_pstate-turbo_disabled.patch"
Content-Disposition: attachment; 
	filename="intel_pstate-turbo_disabled.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lx4tgzik0>
X-Attachment-Id: f_lx4tgzik0

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgIDE5ICsrKysrKysrKysrKy0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoK
SW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYworKysgbGlu
dXgtcG0vZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCkBAIC0xMzAyLDEyICsxMzAyLDE3
IEBAIHN0YXRpYyBzc2l6ZV90IHN0b3JlX25vX3R1cmJvKHN0cnVjdCBrb2IKIAogCW5vX3R1cmJv
ID0gISFjbGFtcF90KGludCwgaW5wdXQsIDAsIDEpOwogCi0JaWYgKG5vX3R1cmJvID09IGdsb2Jh
bC5ub190dXJibykKLQkJZ290byB1bmxvY2tfZHJpdmVyOwotCi0JaWYgKGdsb2JhbC50dXJib19k
aXNhYmxlZCkgewotCQlwcl9ub3RpY2Vfb25jZSgiVHVyYm8gZGlzYWJsZWQgYnkgQklPUyBvciB1
bmF2YWlsYWJsZSBvbiBwcm9jZXNzb3JcbiIpOworCVdSSVRFX09OQ0UoZ2xvYmFsLnR1cmJvX2Rp
c2FibGVkLCB0dXJib19pc19kaXNhYmxlZCgpKTsKKwlpZiAoZ2xvYmFsLnR1cmJvX2Rpc2FibGVk
ICYmICFub190dXJibykgeworCQlwcl9ub3RpY2UoIlR1cmJvIGRpc2FibGVkIGJ5IEJJT1Mgb3Ig
dW5hdmFpbGFibGUgb24gcHJvY2Vzc29yXG4iKTsKIAkJY291bnQgPSAtRVBFUk07CisJCWlmIChn
bG9iYWwubm9fdHVyYm8pCisJCQlnb3RvIHVubG9ja19kcml2ZXI7CisJCWVsc2UKKwkJCW5vX3R1
cmJvID0gMTsKKwl9CisKKwlpZiAobm9fdHVyYm8gPT0gZ2xvYmFsLm5vX3R1cmJvKSB7CiAJCWdv
dG8gdW5sb2NrX2RyaXZlcjsKIAl9CiAKQEAgLTE3NjIsNyArMTc2Nyw3IEBAIHN0YXRpYyB1NjQg
YXRvbV9nZXRfdmFsKHN0cnVjdCBjcHVkYXRhICoKIAl1MzIgdmlkOwogCiAJdmFsID0gKHU2NClw
c3RhdGUgPDwgODsKLQlpZiAoUkVBRF9PTkNFKGdsb2JhbC5ub190dXJibykgJiYgIWdsb2JhbC50
dXJib19kaXNhYmxlZCkKKwlpZiAoUkVBRF9PTkNFKGdsb2JhbC5ub190dXJibykgJiYgIVJFQURf
T05DRShnbG9iYWwudHVyYm9fZGlzYWJsZWQpKQogCQl2YWwgfD0gKHU2NCkxIDw8IDMyOwogCiAJ
dmlkX2ZwID0gY3B1ZGF0YS0+dmlkLm1pbiArIG11bF9mcCgKQEAgLTE5MjcsNyArMTkzMiw3IEBA
IHN0YXRpYyB1NjQgY29yZV9nZXRfdmFsKHN0cnVjdCBjcHVkYXRhICoKIAl1NjQgdmFsOwogCiAJ
dmFsID0gKHU2NClwc3RhdGUgPDwgODsKLQlpZiAoUkVBRF9PTkNFKGdsb2JhbC5ub190dXJibykg
JiYgIWdsb2JhbC50dXJib19kaXNhYmxlZCkKKwlpZiAoUkVBRF9PTkNFKGdsb2JhbC5ub190dXJi
bykgJiYgIVJFQURfT05DRShnbG9iYWwudHVyYm9fZGlzYWJsZWQpKQogCQl2YWwgfD0gKHU2NCkx
IDw8IDMyOwogCiAJcmV0dXJuIHZhbDsK
--0000000000000d69a0061a4e20a2--

