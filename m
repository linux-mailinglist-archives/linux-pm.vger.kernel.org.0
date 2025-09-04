Return-Path: <linux-pm+bounces-33873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16EB44497
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3E4188BB2F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9483126D2;
	Thu,  4 Sep 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp3/OryI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B583126DB
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007669; cv=none; b=MsAmYbsHAVMoJOK5QwjhVT0gW37fD9pzg6HE4I3/zFoP8Al2adne7Qtx6bvIfFRG0BY2vZASo2wbt6fjMp6vi/y9ict59A1BLtfksl7K9wvDvpfYzoaWd3oDu5PSPmElJDI7ZZDkMdAjt9vOikRL2aSFWGNER7xPU9VOKLstM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007669; c=relaxed/simple;
	bh=cKlCCcpVo2F7bvGrSv8YN+XkH/S5RD8AqKKuONtECGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuJFykSvekIau84dYVTKHEjA+a+RTLou1sBs2mdMe80aOiVFT6Sh2rpXazrwUQ3xRwITT/bnD6VVaZWc4HOo6YR0rU2kL/s0Nj8M2gds1HX7OUBDtaozt/0KQtB6ZcqeIY7gHmusJPxsVPkf2e5N599rAApF/CJH/bX80cWFPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp3/OryI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A5FC4CEF7
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757007668;
	bh=cKlCCcpVo2F7bvGrSv8YN+XkH/S5RD8AqKKuONtECGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pp3/OryI+uoh543QihMbrMLG9WMlPGGclJpg321aZWVhAu/AXAWgZzKOQdREfzMbe
	 BvzOa9ZY5ld/TaLuvtU1a+QISgQATxUjLWsru+cNAsGZLxS95PpVttzddjkMyea6gq
	 drxSxDUqj9WG45pNhgScHI5cO9aemZ1uTVv8l47pKeKH82Cdn+63KPyZY9C8txl5TK
	 79RmM+BNrpg7FVM5uNgGCyUsZkSJarayXme75edBej5dsoJRXs+bEAspSJXUk/8xE3
	 H8LwETZaEYGU6ANfSZEv42Xls+oVzGEFMaAFsOPkKFWBViH17KSw96iH8qwBFvs8hn
	 B4+4stfW2h/ag==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61e6d96adcdso789956eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 10:41:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw7yvHFjV53ONUf33Uk/1FpTv0vXxYI/MEEeUxvekzSV4dBR3TqtDUVd6anDBZ65bYBWbsJT+dyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfptgxPOuaDRZ12RrsNmVdhesbSOwL0THk6uYgaeRJBXxAqykV
	gaaVwVUrFRnN3xkoobS2VGOIfqL9VTYr/QvfbhpEhbafN/+YFE7bAHzQIH16tp8CKfRqBBlxuRB
	eVgXfffwi0U7UxJYz8ve71Ut+glhYVnc=
X-Google-Smtp-Source: AGHT+IH9LKbxyQ24ASeVFeeKKpz80590R93GUR1N0X43zA8+c8+TxnNhJF0/b+LmlFNZzwWH0ozIW1XTyEnNICpNk9w=
X-Received: by 2002:a05:6820:228a:b0:61e:7755:35d9 with SMTP id
 006d021491bc7-61e775537a8mr2728090eaf.7.1757007668060; Thu, 04 Sep 2025
 10:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com> <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com> <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
 <fbf349ec-f200-4eff-9a5b-6674a1eef52a@arm.com> <d9e8f92f-08d1-4006-accd-7a2b65b0bc6c@panix.com>
 <CAJZ5v0jmMbWjFZUZe56ZYzjsHYE1=fSb+5MWNLMN_K4ZCJPu+Q@mail.gmail.com>
 <e08a1424-6873-4c61-b97b-94c4e9a9077c@panix.com> <CAJZ5v0iw0SZAZd9HvwZdT=kqPq0AUJp_8LjWA6byOX3K4BVjrg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iw0SZAZd9HvwZdT=kqPq0AUJp_8LjWA6byOX3K4BVjrg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 19:40:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8PGqHYN-XR=pkBCyvhN9kwUDupeU6MJTJoCbiJv8F7Q@mail.gmail.com>
X-Gm-Features: Ac12FXwOFMiXRQa1ZORQkl3BbvMqOJ9utxtJr4-Zf2gjKwBZOzbo9uiWkVz6M1M
Message-ID: <CAJZ5v0j8PGqHYN-XR=pkBCyvhN9kwUDupeU6MJTJoCbiJv8F7Q@mail.gmail.com>
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU topology
To: Kenneth Crudup <kenny@panix.com>
Cc: Christian Loehle <christian.loehle@arm.com>, lukasz.luba@arm.com, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: multipart/mixed; boundary="000000000000ec45c6063dfd3909"

--000000000000ec45c6063dfd3909
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:53=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Wed, Sep 3, 2025 at 8:43=E2=80=AFPM Kenneth Crudup <kenny@panix.com> w=
rote:
> >
> >
> > Is there a way to distinguish between "offline cores" and
> > "'non-'existent" cores?
> >
> > This way we could just skip the ones that "aren't" there, right?
>
> I'm not quite sure about the underlying use case TBH.
>
> The em_check_capacity_update() call may not be necessary on x86 at
> all, but I need to double check.

So AFAICS, this can be addressed by something like the attached patch
(the majority of changes in it is just moving kerneldoc comments
around and function renaming).

Since intel_pstate handles capacity updates itself, it can do without
em_check_capacity_update().

--000000000000ec45c6063dfd3909
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-em-register-basic.patch"
Content-Disposition: attachment; filename="pm-em-register-basic.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mf5ow9l30>
X-Attachment-Id: f_mf5ow9l30

LS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAgICA0ICstCiBpbmNsdWRlL2xp
bnV4L2VuZXJneV9tb2RlbC5oICAgfCAgIDEwICsrKysrKwoga2VybmVsL3Bvd2VyL2VuZXJneV9t
b2RlbC5jICAgIHwgICA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LQogMyBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkKCi0t
LSBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYworKysgYi9kcml2ZXJzL2NwdWZyZXEv
aW50ZWxfcHN0YXRlLmMKQEAgLTEwMzQsOCArMTAzNCw4IEBAIHN0YXRpYyBib29sIGh5YnJpZF9y
ZWdpc3Rlcl9wZXJmX2RvbWFpbigKIAlpZiAoIWNwdV9kZXYpCiAJCXJldHVybiBmYWxzZTsKIAot
CWlmIChlbV9kZXZfcmVnaXN0ZXJfcGVyZl9kb21haW4oY3B1X2RldiwgSFlCUklEX0VNX1NUQVRF
X0NPVU5ULCAmY2IsCi0JCQkJCWNwdW1hc2tfb2YoY3B1KSwgZmFsc2UpKQorCWlmIChlbV9kZXZf
cmVnaXN0ZXJfcGRfbm9fdXBkYXRlKGNwdV9kZXYsIEhZQlJJRF9FTV9TVEFURV9DT1VOVCwgJmNi
LAorCQkJCQkgY3B1bWFza19vZihjcHUpLCBmYWxzZSkpCiAJCXJldHVybiBmYWxzZTsKIAogCWNw
dWRhdGEtPnBkX3JlZ2lzdGVyZWQgPSB0cnVlOwotLS0gYS9pbmNsdWRlL2xpbnV4L2VuZXJneV9t
b2RlbC5oCisrKyBiL2luY2x1ZGUvbGludXgvZW5lcmd5X21vZGVsLmgKQEAgLTE2OCw2ICsxNjgs
OSBAQCBzdHJ1Y3QgZW1fcGVyZl9kb21haW4gKmVtX2NwdV9nZXQoaW50IGNwCiBzdHJ1Y3QgZW1f
cGVyZl9kb21haW4gKmVtX3BkX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYpOwogaW50IGVtX2Rldl91
cGRhdGVfcGVyZl9kb21haW4oc3RydWN0IGRldmljZSAqZGV2LAogCQkJICAgICAgc3RydWN0IGVt
X3BlcmZfdGFibGUgKm5ld190YWJsZSk7CitpbnQgZW1fZGV2X3JlZ2lzdGVyX3BkX25vX3VwZGF0
ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBucl9zdGF0ZXMsCisJCQkJIGNvbnN0
IHN0cnVjdCBlbV9kYXRhX2NhbGxiYWNrICpjYiwKKwkJCQkgY29uc3QgY3B1bWFza190ICpjcHVz
LCBib29sIG1pY3Jvd2F0dHMpOwogaW50IGVtX2Rldl9yZWdpc3Rlcl9wZXJmX2RvbWFpbihzdHJ1
Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBucl9zdGF0ZXMsCiAJCQkJY29uc3Qgc3RydWN0
IGVtX2RhdGFfY2FsbGJhY2sgKmNiLAogCQkJCWNvbnN0IGNwdW1hc2tfdCAqY3B1cywgYm9vbCBt
aWNyb3dhdHRzKTsKQEAgLTM0NCw2ICszNDcsMTMgQEAgc3RydWN0IGVtX2RhdGFfY2FsbGJhY2sg
e307CiAjZGVmaW5lIEVNX1NFVF9BQ1RJVkVfUE9XRVJfQ0IoZW1fY2IsIGNiKSBkbyB7IH0gd2hp
bGUgKDApCiAKIHN0YXRpYyBpbmxpbmUKK2ludCBlbV9kZXZfcmVnaXN0ZXJfcGRfbm9fdXBkYXRl
KHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IG5yX3N0YXRlcywKKwkJCQkgY29uc3Qg
c3RydWN0IGVtX2RhdGFfY2FsbGJhY2sgKmNiLAorCQkJCSBjb25zdCBjcHVtYXNrX3QgKmNwdXMs
IGJvb2wgbWljcm93YXR0cykKK3sKKwlyZXR1cm4gLUVJTlZBTDsKK30KK3N0YXRpYyBpbmxpbmUK
IGludCBlbV9kZXZfcmVnaXN0ZXJfcGVyZl9kb21haW4oc3RydWN0IGRldmljZSAqZGV2LCB1bnNp
Z25lZCBpbnQgbnJfc3RhdGVzLAogCQkJCWNvbnN0IHN0cnVjdCBlbV9kYXRhX2NhbGxiYWNrICpj
YiwKIAkJCQljb25zdCBjcHVtYXNrX3QgKmNwdXMsIGJvb2wgbWljcm93YXR0cykKLS0tIGEva2Vy
bmVsL3Bvd2VyL2VuZXJneV9tb2RlbC5jCisrKyBiL2tlcm5lbC9wb3dlci9lbmVyZ3lfbW9kZWwu
YwpAQCAtNTI3LDMxICs1MjcsMTkgQEAgc3RydWN0IGVtX3BlcmZfZG9tYWluICplbV9jcHVfZ2V0
KGludCBjcAogRVhQT1JUX1NZTUJPTF9HUEwoZW1fY3B1X2dldCk7CiAKIC8qKgotICogZW1fZGV2
X3JlZ2lzdGVyX3BlcmZfZG9tYWluKCkgLSBSZWdpc3RlciB0aGUgRW5lcmd5IE1vZGVsIChFTSkg
Zm9yIGEgZGV2aWNlCi0gKiBAZGV2CQk6IERldmljZSBmb3Igd2hpY2ggdGhlIEVNIGlzIHRvIHJl
Z2lzdGVyCi0gKiBAbnJfc3RhdGVzCTogTnVtYmVyIG9mIHBlcmZvcm1hbmNlIHN0YXRlcyB0byBy
ZWdpc3RlcgotICogQGNiCQk6IENhbGxiYWNrIGZ1bmN0aW9ucyBwcm92aWRpbmcgdGhlIGRhdGEg
b2YgdGhlIEVuZXJneSBNb2RlbAotICogQGNwdXMJOiBQb2ludGVyIHRvIGNwdW1hc2tfdCwgd2hp
Y2ggaW4gY2FzZSBvZiBhIENQVSBkZXZpY2UgaXMKLSAqCQlvYmxpZ2F0b3J5LiBJdCBjYW4gYmUg
dGFrZW4gZnJvbSBpLmUuICdwb2xpY3ktPmNwdXMnLiBGb3Igb3RoZXIKLSAqCQl0eXBlIG9mIGRl
dmljZXMgdGhpcyBzaG91bGQgYmUgc2V0IHRvIE5VTEwuCi0gKiBAbWljcm93YXR0cwk6IEZsYWcg
aW5kaWNhdGluZyB0aGF0IHRoZSBwb3dlciB2YWx1ZXMgYXJlIGluIG1pY3JvLVdhdHRzIG9yCi0g
KgkJaW4gc29tZSBvdGhlciBzY2FsZS4gSXQgbXVzdCBiZSBzZXQgcHJvcGVybHkuCi0gKgotICog
Q3JlYXRlIEVuZXJneSBNb2RlbCB0YWJsZXMgZm9yIGEgcGVyZm9ybWFuY2UgZG9tYWluIHVzaW5n
IHRoZSBjYWxsYmFja3MKLSAqIGRlZmluZWQgaW4gY2IuCi0gKgotICogVGhlIEBtaWNyb3dhdHRz
IGlzIGltcG9ydGFudCB0byBzZXQgd2l0aCBjb3JyZWN0IHZhbHVlLiBTb21lIGtlcm5lbAotICog
c3ViLXN5c3RlbXMgbWlnaHQgcmVseSBvbiB0aGlzIGZsYWcgYW5kIGNoZWNrIGlmIGFsbCBkZXZp
Y2VzIGluIHRoZSBFTSBhcmUKLSAqIHVzaW5nIHRoZSBzYW1lIHNjYWxlLgorICogZW1fZGV2X3Jl
Z2lzdGVyX3BkX25vX3VwZGF0ZSgpIC0gUmVnaXN0ZXIgYSBwZXJmIGRvbWFpbiBmb3IgYSBkZXZp
Y2UKKyAqIEBkZXYgOiBEZXZpY2UgdG8gcmVnaXN0ZXIgdGhlIFBEIGZvcgorICogQG5yX3N0YXRl
cyA6IE51bWJlciBvZiBwZXJmb3JtYW5jZSBzdGF0ZXMgaW4gdGhlIG5ldyBQRAorICogQGNiIDog
Q2FsbGJhY2sgZnVuY3Rpb25zIGZvciBwb3B1bGF0aW5nIHRoZSBlbmVyZ3kgbW9kZWwKKyAqIEBj
cHVzIDogQ1BVcyB0byBpbmNsdWRlIGluIHRoZSBuZXcgUEQgKG1hbmRhdG9yeSBpZiBAZGV2IGlz
IGEgQ1BVIGRldmljZSkKKyAqIEBtaWNyb3dhdHRzIDogV2hldGhlciBvciBub3QgdGhlIHBvd2Vy
IHZhbHVlcyBpbiB0aGUgRU0gd2lsbCBiZSBpbiB1VwogICoKLSAqIElmIG11bHRpcGxlIGNsaWVu
dHMgcmVnaXN0ZXIgdGhlIHNhbWUgcGVyZm9ybWFuY2UgZG9tYWluLCBhbGwgYnV0IHRoZSBmaXJz
dAotICogcmVnaXN0cmF0aW9uIHdpbGwgYmUgaWdub3JlZC4KLSAqCi0gKiBSZXR1cm4gMCBvbiBz
dWNjZXNzCisgKiBMaWtlIGVtX2Rldl9yZWdpc3Rlcl9wZXJmX2RvbWFpbigpLCBidXQgZG9lcyBu
b3QgdHJpZ2dlciBhIENQVSBjYXBhY2l0eQorICogdXBkYXRlIGFmdGVyIHJlZ2lzdGVyaW5nIHRo
ZSBQRCwgZXZlbiBpZiBAZGV2IGlzIGEgQ1BVIGRldmljZS4KICAqLwotaW50IGVtX2Rldl9yZWdp
c3Rlcl9wZXJmX2RvbWFpbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBucl9zdGF0
ZXMsCi0JCQkJY29uc3Qgc3RydWN0IGVtX2RhdGFfY2FsbGJhY2sgKmNiLAotCQkJCWNvbnN0IGNw
dW1hc2tfdCAqY3B1cywgYm9vbCBtaWNyb3dhdHRzKQoraW50IGVtX2Rldl9yZWdpc3Rlcl9wZF9u
b191cGRhdGUoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgbnJfc3RhdGVzLAorCQkJ
CSBjb25zdCBzdHJ1Y3QgZW1fZGF0YV9jYWxsYmFjayAqY2IsCisJCQkJIGNvbnN0IGNwdW1hc2tf
dCAqY3B1cywgYm9vbCBtaWNyb3dhdHRzKQogewogCXN0cnVjdCBlbV9wZXJmX3RhYmxlICplbV90
YWJsZTsKIAl1bnNpZ25lZCBsb25nIGNhcCwgcHJldl9jYXAgPSAwOwpAQCAtNjM2LDYgKzYyNCwz
OSBAQCBpbnQgZW1fZGV2X3JlZ2lzdGVyX3BlcmZfZG9tYWluKHN0cnVjdCBkCiB1bmxvY2s6CiAJ
bXV0ZXhfdW5sb2NrKCZlbV9wZF9tdXRleCk7CiAKKwlyZXR1cm4gcmV0OworfQorRVhQT1JUX1NZ
TUJPTF9HUEwoZW1fZGV2X3JlZ2lzdGVyX3BkX25vX3VwZGF0ZSk7CisKKy8qKgorICogZW1fZGV2
X3JlZ2lzdGVyX3BlcmZfZG9tYWluKCkgLSBSZWdpc3RlciB0aGUgRW5lcmd5IE1vZGVsIChFTSkg
Zm9yIGEgZGV2aWNlCisgKiBAZGV2CQk6IERldmljZSBmb3Igd2hpY2ggdGhlIEVNIGlzIHRvIHJl
Z2lzdGVyCisgKiBAbnJfc3RhdGVzCTogTnVtYmVyIG9mIHBlcmZvcm1hbmNlIHN0YXRlcyB0byBy
ZWdpc3RlcgorICogQGNiCQk6IENhbGxiYWNrIGZ1bmN0aW9ucyBwcm92aWRpbmcgdGhlIGRhdGEg
b2YgdGhlIEVuZXJneSBNb2RlbAorICogQGNwdXMJOiBQb2ludGVyIHRvIGNwdW1hc2tfdCwgd2hp
Y2ggaW4gY2FzZSBvZiBhIENQVSBkZXZpY2UgaXMKKyAqCQlvYmxpZ2F0b3J5LiBJdCBjYW4gYmUg
dGFrZW4gZnJvbSBpLmUuICdwb2xpY3ktPmNwdXMnLiBGb3Igb3RoZXIKKyAqCQl0eXBlIG9mIGRl
dmljZXMgdGhpcyBzaG91bGQgYmUgc2V0IHRvIE5VTEwuCisgKiBAbWljcm93YXR0cwk6IEZsYWcg
aW5kaWNhdGluZyB0aGF0IHRoZSBwb3dlciB2YWx1ZXMgYXJlIGluIG1pY3JvLVdhdHRzIG9yCisg
KgkJaW4gc29tZSBvdGhlciBzY2FsZS4gSXQgbXVzdCBiZSBzZXQgcHJvcGVybHkuCisgKgorICog
Q3JlYXRlIEVuZXJneSBNb2RlbCB0YWJsZXMgZm9yIGEgcGVyZm9ybWFuY2UgZG9tYWluIHVzaW5n
IHRoZSBjYWxsYmFja3MKKyAqIGRlZmluZWQgaW4gY2IuCisgKgorICogVGhlIEBtaWNyb3dhdHRz
IGlzIGltcG9ydGFudCB0byBzZXQgd2l0aCBjb3JyZWN0IHZhbHVlLiBTb21lIGtlcm5lbAorICog
c3ViLXN5c3RlbXMgbWlnaHQgcmVseSBvbiB0aGlzIGZsYWcgYW5kIGNoZWNrIGlmIGFsbCBkZXZp
Y2VzIGluIHRoZSBFTSBhcmUKKyAqIHVzaW5nIHRoZSBzYW1lIHNjYWxlLgorICoKKyAqIElmIG11
bHRpcGxlIGNsaWVudHMgcmVnaXN0ZXIgdGhlIHNhbWUgcGVyZm9ybWFuY2UgZG9tYWluLCBhbGwg
YnV0IHRoZSBmaXJzdAorICogcmVnaXN0cmF0aW9uIHdpbGwgYmUgaWdub3JlZC4KKyAqCisgKiBS
ZXR1cm4gMCBvbiBzdWNjZXNzCisgKi8KK2ludCBlbV9kZXZfcmVnaXN0ZXJfcGVyZl9kb21haW4o
c3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgbnJfc3RhdGVzLAorCQkJCWNvbnN0IHN0
cnVjdCBlbV9kYXRhX2NhbGxiYWNrICpjYiwKKwkJCQljb25zdCBjcHVtYXNrX3QgKmNwdXMsIGJv
b2wgbWljcm93YXR0cykKK3sKKwlpbnQgcmV0ID0gZW1fZGV2X3JlZ2lzdGVyX3BkX25vX3VwZGF0
ZShkZXYsIG5yX3N0YXRlcywgY2IsIGNwdXMsIG1pY3Jvd2F0dHMpOworCiAJaWYgKF9pc19jcHVf
ZGV2aWNlKGRldikpCiAJCWVtX2NoZWNrX2NhcGFjaXR5X3VwZGF0ZSgpOwogCg==
--000000000000ec45c6063dfd3909--

