Return-Path: <linux-pm+bounces-8503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A328D7711
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 18:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2262812E1
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 16:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6934C61C;
	Sun,  2 Jun 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="CRudVvgc"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C894F883;
	Sun,  2 Jun 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717344473; cv=none; b=SXYcPg8wMhxW2sQtCdUs5Pb2xmOGT7plVaDgjb9G/zmarfAlSIyNa+ol7Blfzwulin7S466Gq2QAmajRJOCajggJohApwpQpGyKey8g1kPURioUmN9cV62UoIP0UQUuT8h4MxBcbDmNsKH7hWtXF/CJ9EfhmcYCQLjulEdDX/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717344473; c=relaxed/simple;
	bh=Ju0crAvUpQcXbkYu+TP9kmXKjP2IXGCY5n2DhpwUb1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HK0aEcrT8JtPZvabPvLM7m1bfT+RV7SFFoRyqtylUbGr03u8M5/FQAnHBJEEuygVicA3jq/n/z5Ow6SK6IPPDgsY3snobcrVz2lZ0KuE3j9TD/sPcnNkqK64dIm09ZjsEK3PQt0yoEGfyMlx2jNj7LmdTy4ZlkoNNAL+z6boMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=CRudVvgc; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717344470;
	bh=Ju0crAvUpQcXbkYu+TP9kmXKjP2IXGCY5n2DhpwUb1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CRudVvgcHf332tCswXpVi85XP2ZZ1F5GyMm3DG3CElwam8NF28k4hEonEdQBnX4v/
	 dMHaO3uxjnxsp6qSk17hsIjai9pm8Kh4dAs6umnVK8KJwpiJt0/WpcfnNmrjuLHSUU
	 UE2d/oq6vtZpIW24i7FRdx98MglZp6wxyexPd8FM=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 6485A66C4C;
	Sun,  2 Jun 2024 12:07:49 -0400 (EDT)
Message-ID: <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: Xi Ruoyao <xry111@xry111.site>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Mon, 03 Jun 2024 00:07:47 +0800
In-Reply-To: <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
	 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
	 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
Content-Type: multipart/mixed; boundary="=-0tomkQd8cEbg33kYGmlc"
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-0tomkQd8cEbg33kYGmlc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2024-06-02 at 06:40 -0700, srinivas pandruvada wrote:

/* snip */

> This requires user action,
> Please add a
> pr_info() to
> https://elixir.bootlin.com/linux/v6.10-rc1/C/ident/acpi_processor_notify
>=20
> Check if you got any message

With

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_drive=
r.c
index 67db60eda370..4585eb6566c8 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -57,6 +57,8 @@ static void acpi_processor_notify(acpi_handle handle, u32=
 event, void *data)
 	struct acpi_processor *pr;
 	int saved;
=20
+	pr_info("acpi_processor_notify: %d\n", event);
+
 	if (device->handle !=3D handle)
 		return;


I get nothing.

> Also what is=20
> cat /proc/cpuinfo
> and
> cpuid -1

Attached.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

--=-0tomkQd8cEbg33kYGmlc
Content-Type: application/gzip; name="cpuid.gz"
Content-Disposition: attachment; filename="cpuid.gz"
Content-Transfer-Encoding: base64

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
7Nq/qTykNvEC6UR7lZ1zXanoLONnQ7lajHIxysUoF6NcjHIxysUoF6NcjHIxysUoF6NcjHIxysUo
F6NcjHIxysUoF6NcjHIxysUoV7XwF0S5Wgcol8EoF6NcjHIxysUoF6NcjHJlP0a5GOV6jekZ5WKU
i1GuH4FytX42lKvDKBejXIxyMcrFKBejXIxyMcrFKBejXIxyMcrFKBejXIxyMcrFKBejXIxyMcrF
KBejXIxyVQt/QZSrc4BytRjlYpSLUS5GuRjlYpSLUa7sxygXo1yvMT2jXIxyMcr1I1Cu9s+GcnUZ
5WKUi1EuRrkY5WKUi1EuRrkY5WKUi1EuRrkY5WKUi1EuRrkY5WKUi1EuRrkY5WKUi1GuauEviHJ1
D1CuNqNcjHIxysUoF6NcjHIxypX9GOVilOs1pmeUi1EuRrl+BMrV+dlQLoNRLka5GOVilItRLka5
GOVilItRLka5GOVilItRLka5GOVilItRLka5GOVilItRLka5GOWqFv6CKJdxgHI1C5TLYJSLUS5G
uRjlYpSLUS5GuRjlYpTrL5+eUS5GuRjl+hEo19nPhnK1GeVilItRLka5GOVilItRLka5GOVilItR
Lka5GOVilItRLka5GOVilItRLka5GOVilItRrmrhL4hytQ9QLoNRLka5GOVilItRLka5GOXKfoxy
Mcr1GtMzysUoF6NcPwLl6v5sKNcZo1yMcjHKxSgXo1yMcjHKxSgXo1yMcjHKxSgXo1yMcjHKxSgX
o1yMcjHKxSgXo1yMcjHKVS38BVGuswOUq8UoF6NcjHIxysUoF6NcjHJlP0a5GOV6jekZ5WKUi1Gu
H4FyvfvZUK53jHIxysUoF6NcjHIxysUoF6NcjHIxysUoF6NcjHIxysUoF6NcjHIxysUoF6NcjHIx
ysUoV7XwF0S53h2gXG1GuRjlYpSLUS5GuRjlYpQr+zHKxSjXa0zPKBejXIxyvTbK9X+seU34WC4B
AA==


--=-0tomkQd8cEbg33kYGmlc
Content-Type: application/gzip; name="cpuinfo.gz"
Content-Disposition: attachment; filename="cpuinfo.gz"
Content-Transfer-Encoding: base64

H4sICK2YXGYAA2NwdWluZm8A7ZlLb+M2EMfP1aeY4y7QGtbDsp1T0R52i2IvRe8ERVISG76WpGR5
P32HkpO2CHIKFjAaHizxPZw/h/NDIuctEyFY/8MD7ItZGG49kRxrn4SZpBG/mShUwdwEPdVSXbGn
LbTlQv2AxbLZbxUwVIvUUMYxTYV13oc/PsKv1osPf375CPLwU1nW+/1n+BnqXbn/9PlbEaJwTpoh
zSy0ZLgbXC3tZena1eqXz9+SobqujrtDWxWMslFAkN/SqFN5ruD3Xwo3XoNkVMG6830RZKdw1ZCG
FAw3kDrWnrRkakhdTUGdZE890sgocYlbW2rq3ZT6riKkIhELEy5Ka25tuJbkoMSMWjxAdSwu7nm4
omgdKzgPZi2AC3BBQAwMdPDgqADNBLDltBqEIBzo6LFnSD0UmLYzDotpWt0CU72awgg8BqDMSdB6
gX7BpQIui78KHzBGiBpchy3XgHrgsSzguBPl0IHHucyB0iiACZGaSNJ2qI/4YyNxwvfaGnCiC9Ch
HS8cGazlYKxTsETrrLLDFas43bp19qYBXeemR/KQPBp7MaT34is4I8ExpSf1lX/F3YvQNoBWZLQe
eCAMV57RFRHS1pMT6C4E3g3Qa1RhKVu07FAXztAzPJnkbEPK7VXBUq36oVrotbOOmbjugQvKMQYE
iVILD1QEWAKdBdAZhStbhnp4avD86NgTFIV2GmqOO3de9CKycfON9HRSEYTrgNFIVAWMu/QKoeMg
Ox/wgZ0h4mutE2FGapjggPsmYaTcXqBXYnFeWi/jFReLMDt0BQuEcujDEDq6hQfW/5pQjE7LMu0V
DWmMDaxWILxGa2ZeZcDjJDSNOJRVf3ujxJ4HgaYpX3AidbcOuYq5xZBF60xdOlwJryjB2jaGobQj
JXhgW7273Aqz2qRLE9cCg2UQsZvLrRogOCVRG8seUfcoWIQpiOR7iI946CNuHGMsBbPC+MLQGi8u
/YixUfbXtUhZJBdpklipinlhfbvHgaRAmo1+2tiMYsCkpQP3OIEN7lHcesi86jT06MScjnz+J/ae
RphnB0knI1XDc88WPauG6XAwpLj08vZumw7PKfnxNLpK+vmQvNWcMCWox/OPsIpMVMm3a8Woo51E
fSTmhRTqW2542DzCYBN6TSq3QHUWcyInuLZPR/0cJguxRl2fIia90p3+T1ilizCvMWT7PgiMsXRx
dOxRi3RHnsNuMpgAo5csWRqmdPfWESj0ADMOcArvklarmZTeSYpOjgkQjz6tn3IL5teim7YsFxyq
4AXBiHguVmuRYKbAWnd1FPNTuFA3BBDrNXH46GDgmGxGWXR2sHikSZi2qva7E+bqW867Jfu22ZI/
QduD0cLErZFyju6EdViaXp8BDzbAExR+hOa0tczSx4mqwtkLKq2poYNI6zwUhfsXB8s75mCzr8pd
fTi8jYPlqxysXnKwyhzMHMwczBzMHHxfHKzumIPV+XTYHc+nt3GwepWDzUsONpmDmYOZg5mDmYPv
i4P1HXPw3Jx2dXl+GwbrVzHYvsRgmzGYMZgxmDGYMfi+MNjcMQbr9ljumqb+Xp8Hy5ccLDMHMwcz
BzMHMwffFwcPd8zBZr+vds35+L0+D9YvOVhnDmYOZg5mDmYOvi8OtnfMwep0OO+O7Rv/L/r658HD
Sw4eMgczBzMHMwczB98XB493zEH8e3C33++/1+fB40sMHjMGMwYzBjMGMwb//xj8G2St3Ok+OAAA



--=-0tomkQd8cEbg33kYGmlc--

