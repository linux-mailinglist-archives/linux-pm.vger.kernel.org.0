Return-Path: <linux-pm+bounces-10556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66859265A6
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1B6289E6B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD1C181D02;
	Wed,  3 Jul 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcZIgWdS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7DF181CEC;
	Wed,  3 Jul 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022940; cv=none; b=TYcloX+Qw45xVZ1ebsuX3lreMSrtg9cYjMsJ6AbL2MaA/TJpUSFdfBch4zL6GAOHuZOcLmQHmf1yzBRef6l6L9U23jFp15zE9rboy9VBV+slDVm6/XVIiEf5+wEadv/3AJi0qRio2MvS39GiAbvpBq1IEnyXMj4UrqR9Vb+32A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022940; c=relaxed/simple;
	bh=Wrl2QCxQh9DL4QM23kjgDJ21J8YSKTQXFbPMz9pni74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msdAkZkWBlvjE21yyKJfpivHiPXxWcu+GAaBNTIvCEwqtLjeLR1i92KSjQw6r/bIyETEi+qKYOY6dEizW26anU+Qfg4QJ15bjLgxChoTPXyMTLLxpySGnzDiSIcnXvHzYGg7cza4cxyxkXKjThH7b1RhHj5jTBam8DlbtxmsybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcZIgWdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA87C4AF0E;
	Wed,  3 Jul 2024 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720022939;
	bh=Wrl2QCxQh9DL4QM23kjgDJ21J8YSKTQXFbPMz9pni74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bcZIgWdSHl9HqQ9LWnmRQCxhKdtymnFvObDMowIfDX0vIXUhmbAhMgYTRkUSumnAR
	 m3SBYSqMuezR0YxitmmwBymOefuijwH0aS8P6SMCa0dEAEbUuZDgaSQ58OxUvnl6HJ
	 i0hCxuUii7tmCd6aeedo/Nn5S7+Qe0cCw1ig1l76LEklhotELD0NfRMWK9XLXpxAOj
	 cQavn/1t2QmSQZ2noBvZ7som789iL75LNcJdVTzw/oxkvBbpJP1Dtdsr9VXV9hhtGI
	 0LgnXIEA0cC2qlw2z4OPhcIg6fW/5ZSPmORwAEzViUYgJNMEjmGECtwIpuo80hy48i
	 mwGqlWHLHmC6g==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25e19ad0050so78493fac.0;
        Wed, 03 Jul 2024 09:08:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWKQWCHNiDXrHDIUI44c3NDRla27AdvzgXeU42/ib8wUxNQcn+rlPEzF4uEBWEEgT2LQliUm2RX47I8+7+6yLSFT2TYVEw+Nq9ek3KIxkOAdWd6v6qerSo9MEfAfp+jIiO5P3+qQX/T1ETrcQhS4bweAe1fPyxPR/Hn1Y7rwCRHt4xIan9
X-Gm-Message-State: AOJu0YyyIxR9k9bFYd1dG5AYEr9jZVlpWejPrxY3V5Fms5fy3b2IAddf
	/J0MCYRlUxlLxEhusLVLsRZY+QvqfxphdsI9pLKT7Yn1x0tkU2m0fHSWYEj/h/aREqO9cpKKMna
	W1IbI1aht+DM+Hw7BQXUwZDezCXE=
X-Google-Smtp-Source: AGHT+IG/+G5oxAf3pRAL08K5QVCFB8+ouzzqF/SX5Qi842HGV2jF2VSe0OAQWbDffHLH1vdDzdUWiacN6hqcO09jXs0=
X-Received: by 2002:a05:6870:8a0b:b0:25c:f5f8:a7fd with SMTP id
 586e51a60fabf-25db34044admr11982494fac.2.1720022938630; Wed, 03 Jul 2024
 09:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2764814.mvXUDI8C0e@rjwysocki.net> <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
 <8d91a3c1-018f-495b-83be-979b795b5548@linaro.org> <12c5c133-9519-4a26-b9a3-2da1d3466e94@linaro.org>
 <15b67ce6-3238-435d-ad28-7c06efbe9153@linaro.org>
In-Reply-To: <15b67ce6-3238-435d-ad28-7c06efbe9153@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jul 2024 18:08:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jiCgPKRha81NyUChNVGe02+GDNX442NsZL=XDPao_4WA@mail.gmail.com>
Message-ID: <CAJZ5v0jiCgPKRha81NyUChNVGe02+GDNX442NsZL=XDPao_4WA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: neil.armstrong@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004400ae061c5a0c44"

--0000000000004400ae061c5a0c44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:00=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 03/07/2024 14:43, neil.armstrong@linaro.org wrote:
> > Hi,
> >
> > On 03/07/2024 14:25, Daniel Lezcano wrote:
> >>
> >> Hi Neil,
> >>
> >> it seems there is something wrong with the driver actually.
> >>
> >> There can be a moment where the sensor is not yet initialized for
> >> different reason, so reading the temperature fails. The routine will
> >> just retry until the sensor gets ready.
> >>
> >> Having these errors seem to me that the sensor for this specific
> >> thermal zone is never ready which may be the root cause of your issue.
> >> The change is spotting this problem IMO.
> >
> > Probably, but it gets printed every second until system shutdown, but
> > only for a single thermal_zone.
> >
> > Using v1 of Rafael's patch makes the message disappear completely.
>
> Yes, because you have probably the thermal zone polling delay set to
> zero, thus it fails the first time and does no longer try to set it up
> again. The V1 is an incomplete fix.
>
> Very likely the problem is in the sensor platform driver, or in the
> thermal zone description in the device tree which describes a non
> functional thermal zone.

I agree, but polling this useless thermal zone forever is not
particularly useful.

I was kind of afraid that something like this would happen, but then I
didn't want to complicate the patch unnecessarily until I knew that it
really would happen.

So attached is a modification of the $subject patch that will double
the temperature recheck delay after every failed attempt to get the
zone temperature and it will give up eventually (in this particular
version, after the recheck delay exceeds 30 s).

I would appreciate giving it a go (obviously, by replacing the
$subject one with it).

--0000000000004400ae061c5a0c44
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-poll-if-temp-invalid-v3.patch"
Content-Disposition: attachment; 
	filename="thermal-poll-if-temp-invalid-v3.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ly617b6o0>
X-Attachment-Id: f_ly617b6o0

RnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgpTdWJq
ZWN0OiBbUEFUQ0ggdjNdIHRoZXJtYWw6IGNvcmU6IENhbGwgbW9uaXRvcl90aGVybWFsX3pvbmUo
KSBpZiB6b25lIHRlbXBlcmF0dXJlIGlzIGludmFsaWQKCkNvbW1pdCAyMDJhYTBkNGJiNTMgKCJ0
aGVybWFsOiBjb3JlOiBEbyBub3QgY2FsbCBoYW5kbGVfdGhlcm1hbF90cmlwKCkKaWYgem9uZSB0
ZW1wZXJhdHVyZSBpcyBpbnZhbGlkIikgY2F1c2VkIF9fdGhlcm1hbF96b25lX2RldmljZV91cGRh
dGUoKQp0byByZXR1cm4gZWFybHkgaWYgdGhlIGN1cnJlbnQgdGhlcm1hbCB6b25lIHRlbXBlcmF0
dXJlIHdhcyBpbnZhbGlkLgoKVGhpcyB3YXMgZG9uZSB0byBhdm9pZCBydW5uaW5nIGhhbmRsZV90
aGVybWFsX3RyaXAoKSBhbmQgZ292ZXJub3IKY2FsbGJhY2tzIGluIHRoYXQgY2FzZSB3aGljaCBs
ZWQgdG8gY29uZnVzaW9uLiAgSG93ZXZlciwgaXQgd2VudCB0b28KZmFyIGJlY2F1c2UgbW9uaXRv
cl90aGVybWFsX3pvbmUoKSBzdGlsbCBuZWVkcyB0byBiZSBjYWxsZWQgZXZlbiB3aGVuCnRoZSB6
b25lIHRlbXBlcmF0dXJlIGlzIGludmFsaWQgdG8gZW5zdXJlIHRoYXQgaXQgd2lsbCBiZSB1cGRh
dGVkCmV2ZW50dWFsbHkgaW4gY2FzZSB0aGVybWFsIHBvbGxpbmcgaXMgZW5hYmxlZCBhbmQgdGhl
IGRyaXZlciBoYXMgbm8Kb3RoZXIgbWVhbnMgdG8gbm90aWZ5IHRoZSBjb3JlIG9mIHpvbmUgdGVt
cGVyYXR1cmUgY2hhbmdlcyAoZm9yIGV4YW1wbGUsCml0IGRvZXMgbm90IHJlZ2lzdGVyIGFuIGlu
dGVycnVwdCBoYW5kbGVyIG9yIEFDUEkgbm90aWZpZXIpLgoKQWxzbyBpZiB0aGUgLnNldF90cmlw
cygpIHpvbmUgY2FsbGJhY2sgaXMgZXhwZWN0ZWQgdG8gc2V0IHVwIG1vbml0b3JpbmcKaW50ZXJy
dXB0cyBmb3IgYSB0aGVybWFsIHpvbmUsIGl0IG5lZWRzIHRvIGJlIHByb3ZpZGVkIHdpdGggdmFs
aWQKYm91bmRhcmllcyBhbmQgdGhhdCBjYW4gb25seSBiZSBkb25lIGlmIHRoZSB6b25lIHRlbXBl
cmF0dXJlIGlzIGtub3duLgoKQWNjb3JkaW5nbHksIHRvIGVuc3VyZSB0aGF0IF9fdGhlcm1hbF96
b25lX2RldmljZV91cGRhdGUoKSB3aWxsCnJ1biBhZ2FpbiBhZnRlciBhIGZhaWxpbmcgem9uZSB0
ZW1wZXJhdHVyZSBjaGVjaywgbWFrZSBpdCBjYWxsCm1vbml0b3JfdGhlcm1hbF96b25lKCkgcmVn
YXJkbGVzcyBvZiB3aGV0aGVyIG9yIG5vdCB0aGUgem9uZQp0ZW1wZXJhdHVyZSBpcyB2YWxpZCBh
bmQgbWFrZSB0aGUgbGF0dGVyIHNjaGVkdWxlIGEgdGhlcm1hbCB6b25lCnRlbXBlcmF0dXJlIHVw
ZGF0ZSBpZiB0aGUgem9uZSB0ZW1wZXJhdHVyZSBpcyBpbnZhbGlkIGV2ZW4gaWYKcG9sbGluZyBp
cyBub3QgZW5hYmxlZCBmb3IgdGhlIHRoZXJtYWwgem9uZSAoaG93ZXZlciwgaWYgdGhpcwpjb250
aW51ZXMgdG8gZmFpbCwgZ2l2ZSB1cCBhZnRlciBzb21lIHRpbWUpLgoKRml4ZXM6IDIwMmFhMGQ0
YmI1MyAoInRoZXJtYWw6IGNvcmU6IERvIG5vdCBjYWxsIGhhbmRsZV90aGVybWFsX3RyaXAoKSBp
ZiB6b25lIHRlbXBlcmF0dXJlIGlzIGludmFsaWQiKQpSZXBvcnRlZC1ieTogRGFuaWVsIExlemNh
bm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+ClNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBX
eXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4KLS0tCiBkcml2ZXJzL3RoZXJtYWwv
dGhlcm1hbF9jb3JlLmMgfCAgIDEzICsrKysrKysrKysrKy0KIGRyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuaCB8ICAgIDkgKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCkluZGV4OiBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvdGhl
cm1hbF9jb3JlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL3RoZXJtYWwv
dGhlcm1hbF9jb3JlLmMKKysrIGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUu
YwpAQCAtMzAwLDYgKzMwMCwxNCBAQCBzdGF0aWMgdm9pZCBtb25pdG9yX3RoZXJtYWxfem9uZShz
dHJ1Y3QKIAkJdGhlcm1hbF96b25lX2RldmljZV9zZXRfcG9sbGluZyh0eiwgdHotPnBhc3NpdmVf
ZGVsYXlfamlmZmllcyk7CiAJZWxzZSBpZiAodHotPnBvbGxpbmdfZGVsYXlfamlmZmllcykKIAkJ
dGhlcm1hbF96b25lX2RldmljZV9zZXRfcG9sbGluZyh0eiwgdHotPnBvbGxpbmdfZGVsYXlfamlm
Zmllcyk7CisJZWxzZSBpZiAodHotPnRlbXBlcmF0dXJlID09IFRIRVJNQUxfVEVNUF9JTlZBTElE
ICYmCisJCSB0ei0+cmVjaGVja19kZWxheV9qaWZmaWVzIDw9IFRIRVJNQUxfTUFYX1JFQ0hFQ0tf
REVMQVkpIHsKKwkJdGhlcm1hbF96b25lX2RldmljZV9zZXRfcG9sbGluZyh0eiwgdHotPnJlY2hl
Y2tfZGVsYXlfamlmZmllcyk7CisJCS8qIERvdWJsZSB0aGUgcmVjaGVjayBkZWxheSBmb3IgdGhl
IG5leHQgYXR0ZW1wdC4gKi8KKwkJdHotPnJlY2hlY2tfZGVsYXlfamlmZmllcyArPSB0ei0+cmVj
aGVja19kZWxheV9qaWZmaWVzOworCQlpZiAodHotPnJlY2hlY2tfZGVsYXlfamlmZmllcyA+IFRI
RVJNQUxfTUFYX1JFQ0hFQ0tfREVMQVkpCisJCQlkZXZfaW5mbygmdHotPmRldmljZSwgIlRlbXBl
cmF0dXJlIHVua25vd24sIGdpdmluZyB1cFxuIik7CisJfQogfQogCiBzdGF0aWMgc3RydWN0IHRo
ZXJtYWxfZ292ZXJub3IgKnRoZXJtYWxfZ2V0X3R6X2dvdmVybm9yKHN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0eikKQEAgLTQzMCw2ICs0MzgsNyBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfdGVt
cGVyYXR1cmUoc3RydWN0IHRoCiAKIAl0ei0+bGFzdF90ZW1wZXJhdHVyZSA9IHR6LT50ZW1wZXJh
dHVyZTsKIAl0ei0+dGVtcGVyYXR1cmUgPSB0ZW1wOworCXR6LT5yZWNoZWNrX2RlbGF5X2ppZmZp
ZXMgPSAxOwogCiAJdHJhY2VfdGhlcm1hbF90ZW1wZXJhdHVyZSh0eik7CiAKQEAgLTUxNCw3ICs1
MjMsNyBAQCB2b2lkIF9fdGhlcm1hbF96b25lX2RldmljZV91cGRhdGUoc3RydWN0CiAJdXBkYXRl
X3RlbXBlcmF0dXJlKHR6KTsKIAogCWlmICh0ei0+dGVtcGVyYXR1cmUgPT0gVEhFUk1BTF9URU1Q
X0lOVkFMSUQpCi0JCXJldHVybjsKKwkJZ290byBtb25pdG9yOwogCiAJdHotPm5vdGlmeV9ldmVu
dCA9IGV2ZW50OwogCkBAIC01MzYsNiArNTQ1LDcgQEAgdm9pZCBfX3RoZXJtYWxfem9uZV9kZXZp
Y2VfdXBkYXRlKHN0cnVjdAogCiAJdGhlcm1hbF9kZWJ1Z191cGRhdGVfdHJpcF9zdGF0cyh0eik7
CiAKK21vbml0b3I6CiAJbW9uaXRvcl90aGVybWFsX3pvbmUodHopOwogfQogCkBAIC0xNDM4LDYg
KzE0NDgsNyBAQCB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJpcHMoCiAKIAl0
aGVybWFsX3NldF9kZWxheV9qaWZmaWVzKCZ0ei0+cGFzc2l2ZV9kZWxheV9qaWZmaWVzLCBwYXNz
aXZlX2RlbGF5KTsKIAl0aGVybWFsX3NldF9kZWxheV9qaWZmaWVzKCZ0ei0+cG9sbGluZ19kZWxh
eV9qaWZmaWVzLCBwb2xsaW5nX2RlbGF5KTsKKwl0ei0+cmVjaGVja19kZWxheV9qaWZmaWVzID0g
MTsKIAogCS8qIHN5cyBJL0YgKi8KIAkvKiBBZGQgbm9kZXMgdGhhdCBhcmUgYWx3YXlzIHByZXNl
bnQgdmlhIC5ncm91cHMgKi8KSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVybWFs
X2NvcmUuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuaAorKysgbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5oCkBA
IC02Nyw2ICs2Nyw4IEBAIHN0cnVjdCB0aGVybWFsX2dvdmVybm9yIHsKICAqIEBwb2xsaW5nX2Rl
bGF5X2ppZmZpZXM6IG51bWJlciBvZiBqaWZmaWVzIHRvIHdhaXQgYmV0d2VlbiBwb2xscyB3aGVu
CiAgKgkJCWNoZWNraW5nIHdoZXRoZXIgdHJpcCBwb2ludHMgaGF2ZSBiZWVuIGNyb3NzZWQgKDAg
Zm9yCiAgKgkJCWludGVycnVwdCBkcml2ZW4gc3lzdGVtcykKKyAqIEByZWNoZWNrX2RlbGF5X2pp
ZmZpZXM6IGRlbGF5IGFmdGVyIGEgZmFpbGVkIHRoZXJtYWwgem9uZSB0ZW1wZXJhdHVyZSBjaGVj
aworICogCQkJYmVmb3JlIGF0dGVtcHRpbmcgdG8gY2hlY2sgaXQgYWdhaW4KICAqIEB0ZW1wZXJh
dHVyZToJY3VycmVudCB0ZW1wZXJhdHVyZS4gIFRoaXMgaXMgb25seSBmb3IgY29yZSBjb2RlLAog
ICoJCQlkcml2ZXJzIHNob3VsZCB1c2UgdGhlcm1hbF96b25lX2dldF90ZW1wKCkgdG8gZ2V0IHRo
ZQogICoJCQljdXJyZW50IHRlbXBlcmF0dXJlCkBAIC0xMDgsNiArMTEwLDcgQEAgc3RydWN0IHRo
ZXJtYWxfem9uZV9kZXZpY2UgewogCWludCBudW1fdHJpcHM7CiAJdW5zaWduZWQgbG9uZyBwYXNz
aXZlX2RlbGF5X2ppZmZpZXM7CiAJdW5zaWduZWQgbG9uZyBwb2xsaW5nX2RlbGF5X2ppZmZpZXM7
CisJdW5zaWduZWQgbG9uZyByZWNoZWNrX2RlbGF5X2ppZmZpZXM7CiAJaW50IHRlbXBlcmF0dXJl
OwogCWludCBsYXN0X3RlbXBlcmF0dXJlOwogCWludCBlbXVsX3RlbXBlcmF0dXJlOwpAQCAtMTMz
LDYgKzEzNiwxMiBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSB7CiAJc3RydWN0IHRoZXJt
YWxfdHJpcF9kZXNjIHRyaXBzW10gX19jb3VudGVkX2J5KG51bV90cmlwcyk7CiB9OwogCisvKgor
ICogTWF4aW11bSBkZWxheSBhZnRlciBhIGZhaWxpbmcgdGhlcm1hbCB6b25lIHRlbXBlcmF0dXJl
IGNoZWNrIGJlZm9yZQorICogYXR0ZW1wdGluZyB0byBjaGVjayBpdCBhZ2FpbiAoaW4gamlmZmll
cykuCisgKi8KKyNkZWZpbmUgVEhFUk1BTF9NQVhfUkVDSEVDS19ERUxBWQkoMzAgKiBIWikKKwog
LyogRGVmYXVsdCBUaGVybWFsIEdvdmVybm9yICovCiAjaWYgZGVmaW5lZChDT05GSUdfVEhFUk1B
TF9ERUZBVUxUX0dPVl9TVEVQX1dJU0UpCiAjZGVmaW5lIERFRkFVTFRfVEhFUk1BTF9HT1ZFUk5P
UiAgICAgICAic3RlcF93aXNlIgo=
--0000000000004400ae061c5a0c44--

