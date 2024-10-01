Return-Path: <linux-pm+bounces-14982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A998B1E8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 03:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05FD6B217AC
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 01:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417106FBF;
	Tue,  1 Oct 2024 01:45:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089980B
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747144; cv=none; b=LMthAW+HwA8N7PiY+jj1Dk7u7h87Z4yuXRkwELPE8ejM+4MQHN5vXk6GSitcWbDbJNv5PgPp+MY8oTYvJ9Q+9yim/uPiDO0HXkcVMZ5kXy8+EHio9izXJN2DGdt9CfIXkDoSkw7mubE6vA3gIAIQ3eYwUGx5p7CSEkRZfHjk1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747144; c=relaxed/simple;
	bh=Pv65x14kKQDmuoVj/72q/ycoe3hBU4L70K0ii5GtrM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmjUP5AICYSVum/XlNp4E5VWRSLFFr6GHNFHwPaRqMUTJp2rRhs1rOEhg7h8Rr5o7/emddqmYidGPl3dJHtg2oq5xHH2hxeoxlecu8fypyeh7mIG5iF+dApnKELtBRQYDCI1rqNGdbOWGERBcIx5XkF05cbJb1vBN4+zysDlJcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: [172.20.10.11]
Received: from unknown (HELO [172.20.10.11])([112.96.224.72])
	by sina.com (10.182.253.25) with ESMTP
	id 66FB540E000056D6; Tue, 1 Oct 2024 09:44:51 +0800 (CST)
X-Sender: atzlinux@sina.com
X-Auth-ID: atzlinux@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=atzlinux@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=atzlinux@sina.com
X-SMAIL-MID: 68018512058798
X-SMAIL-UIID: CD729F66496E431EA18B4152FD9FDECA-20241001-094451-1
Message-ID: <18b21f90-ff6b-44b0-a0ae-49603594a22a@sina.com>
Date: Tue, 1 Oct 2024 09:44:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw
 spinlock
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-pm@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-rt-users@vger.kernel.org, 1076483@bugs.debian.org
References: <20240919081121.10784-2-ukleinek@debian.org>
 <229b9ff9ef6cf201b4e56d6ccb03c028c2d8f51f.camel@linux.intel.com>
 <tehuoiymoyorpsyefsigeyn3fbdngi6jqgrhx4zerzonpezrz2@o7zuls45rtxl>
Content-Language: en-US
From: =?UTF-8?B?eGlhbyBzaGVuZyB3ZW4o6IKW55ub5paHKQ==?= <atzlinux@sina.com>
Organization: https://www.atzlinux.com
In-Reply-To: <tehuoiymoyorpsyefsigeyn3fbdngi6jqgrhx4zerzonpezrz2@o7zuls45rtxl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GcmRZtzZhh0ND7fr81egPDRQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GcmRZtzZhh0ND7fr81egPDRQ
Content-Type: multipart/mixed; boundary="------------sL6WyUaCDcGT8ekMA14QEP9R";
 protected-headers="v1"
From: =?UTF-8?B?eGlhbyBzaGVuZyB3ZW4o6IKW55ub5paHKQ==?= <atzlinux@sina.com>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-pm@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-rt-users@vger.kernel.org, 1076483@bugs.debian.org
Message-ID: <18b21f90-ff6b-44b0-a0ae-49603594a22a@sina.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw
 spinlock
References: <20240919081121.10784-2-ukleinek@debian.org>
 <229b9ff9ef6cf201b4e56d6ccb03c028c2d8f51f.camel@linux.intel.com>
 <tehuoiymoyorpsyefsigeyn3fbdngi6jqgrhx4zerzonpezrz2@o7zuls45rtxl>
In-Reply-To: <tehuoiymoyorpsyefsigeyn3fbdngi6jqgrhx4zerzonpezrz2@o7zuls45rtxl>

--------------sL6WyUaCDcGT8ekMA14QEP9R
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

5ZyoIDIwMjQvOS8yOCAxOTo1MSwgVXdlIEtsZWluZS1Lw7ZuaWcg5YaZ6YGTOg0KPiBIZWxs
bywNCj4gDQo+IE9uIEZyaSwgU2VwIDI3LCAyMDI0IGF0IDAzOjQ3OjA4QU0gLTA3MDAsIHNy
aW5pdmFzIHBhbmRydXZhZGEgd3JvdGU6DQo+PiBPbiBUaHUsIDIwMjQtMDktMTkgYXQgMTA6
MTEgKzAyMDAsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPj4+IG5vdGlmeV9od3BfaW50
ZXJydXB0KCkgaXMgY2FsbGVkIHZpYSBzeXN2ZWNfdGhlcm1hbCgpIC0+DQo+Pj4gc21wX3Ro
ZXJtYWxfdmVjdG9yKCkgLT4gaW50ZWxfdGhlcm1hbF9pbnRlcnJ1cHQoKSBpbiBoYXJkIGly
cQ0KPj4+IGNvbnRleHQuDQo+Pj4gRm9yIHRoaXMgcmVhc29uIGl0IG11c3Qgbm90IHVzZSBh
IHNpbXBsZSBzcGluX2xvY2sgdGhhdCBzbGVlcHMgd2l0aA0KPj4+IFBSRUVNUFRfUlQgZW5h
YmxlZC4gU28gY29udmVydCBpdCB0byBhIHJhdyBzcGlubG9jay4NCj4+Pg0KPj4+IFJlcG9y
dGVkLWJ5OiB4aWFvIHNoZW5nIHdlbiA8YXR6bGludXhAc2luYS5jb20+DQo+Pj4gTGluazog
aHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvMTA3NjQ4Mw0KPj4+IFNpZ25lZC1vZmYtYnk6IFV3
ZSBLbGVpbmUtS8O2bmlnIDx1a2xlaW5la0BkZWJpYW4ub3JnPg0KPj4NCj4+IE1pc3Npbmcg
VGVzdGVkLWJ5Pw0KPiANCj4gTmVpdGhlciBJIG5vciBhbnlib2R5IGVsc2UgZGlkIHRlc3Qg
dGhhdCBwYXRjaCBiZWZvcmUgSSBzZW50IGl0IHRvIHRoZQ0KPiBsaXN0IChhcGFydCBmcm9t
IGEgYnVpbGQgdGVzdCkuIEkgZ3Vlc3MgeGlhbyBzaGVuZyB3ZW4gbWlnaHQgaGF2ZQ0KPiBy
ZXBsaWVkIHdpdGggYSBUZXN0ZWQtYnkgdGFnLg0KWWVzLCBJIGhhZCB0ZXN0ZWQgdGhpcyBw
YXRjaCBvbiBteSBub3RlYm9vayhiYXNlIG9uIERlYmlhbiBrZXJuZWwgDQo2LjEwLjExLTEg
KDIwMjQtMDktMjIpIHNvdXJjZSBjb2RlKS4NCldvcmsgcGVyZmVjdCENCg0KVGhpcyBidWcg
ZXhpc3QgaW4gNi45LjktcnQtYW1kNjQgIzEgIERlYmlhbiA2LjkuOS0xOg0KaHR0cHM6Ly9s
aW51eC1oYXJkd2FyZS5vcmcvP3Byb2JlPWQ1N2Y0ZDI5YTgmbG9nPWRtZXNnDQoNClRoaXMg
YnVnIGZpeGVkIGluIFBSRUVNUFRfUlQgYXR6bGludXggNi4xMC4xMS0xICgyMDI0LTA5LTIy
KSB3aXRoIHRoaXMgDQpwYXRjaDoNCmh0dHBzOi8vbGludXgtaGFyZHdhcmUub3JnLz9wcm9i
ZT1kZTVhNDQzNzRhJmxvZz1kbWVzZw0KDQpUZXN0ZWQtYnk6IHhpYW8gc2hlbmcgd2VuIDxh
dHpsaW51eEBzaW5hLmNvbT4NCg0KPiANCj4+ICAgICAgQWNrZWQtYnk6IFNyaW5pdmFzIFBh
bmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KPiANCj4g
VGhhbmtzDQo+IFV3ZQ0KDQpSZWdhcmRzLA0KLS0gDQrogpbnm5vmlocgeGlhbyBzaGVuZyB3
ZW4NCkRlYmlhbiBRQSBwYWdlOiANCmh0dHBzOi8vcWEuZGViaWFuLm9yZy9kZXZlbG9wZXIu
cGhwP2xvZ2luPWF0emxpbnV4JTQwc2luYS5jb20NCkRlYmlhbiBzYWxzYTogaHR0cHM6Ly9z
YWxzYS5kZWJpYW4ub3JnL2F0emxpbnV4LWd1ZXN0DQpHbnVQRyBQdWJsaWMgS2V5OiAweDAw
MTg2NjAyMzM5MjQwQ0INCg==

--------------sL6WyUaCDcGT8ekMA14QEP9R--

--------------GcmRZtzZhh0ND7fr81egPDRQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEvGv7H5NUQYeSuhtTJ2Egg8PSprAFAmb7VA4FAwAAAAAACgkQJ2Egg8PSprDb
7Q//RYFRV9Z00mKSSTwdbvajx4XmdlUANLL0R/k/sROoJSwueX/LlE213a0v8Rq2zTAnseXarNTH
y12BJuM2zLVyAehEHWL/oBNfG8RMP1P936GxENu2k1ZoQTONyciBigTyL9201AAZLEoHFYaEWJB0
6B38ZtKCD/OKsX0N7CVULHt08SZ/T6Q4T4o/BbAIoC39Hxtst+jak3+UpSkulmlN+Y7s7yJyJQ4N
vPoavHOnn1oLldi4x4FDK+t6eHs6v5FzoVYeQCNIdmc2QyQSMC0C+jLC1vjMBFRdJKeuAA3F+14n
r0Ektqk/rfkLihwVN/NyF8uiofbLLkTvAQlPfDgNB1OS4iRB2/VTCGiRL/m+IWAyXTtQ6glI4FNs
MGcpCLT44MeKeVQRLokrPMOMUUfVl0aNGAey+G0AbHrZS4ArzlR/k7fdtiI8ExlVOE3Un8Ke78J2
gosXIe6UQw9To34Iq06xL+Y0A5kkfw6fUfa6Kevn0ZcATM+bmQKtiPUaJSIr90o8hiDyx6sF7jsu
uclIfuxPbGpTYjZRthKDNqH/0YV3uYtlcQuvPEAcMmi6i5CD7Tn4jNwAxQhbXDjJPNt3vfsY1e/l
xrkxpOB6wSMt6XiHKJfwEEJ865pDBBq39moAy/JZBnGe5CD4LKL3g3eb0Isyi+1ISL4m39ZtYsRW
DR0=
=+vRC
-----END PGP SIGNATURE-----

--------------GcmRZtzZhh0ND7fr81egPDRQ--

