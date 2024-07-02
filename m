Return-Path: <linux-pm+bounces-10380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7E92484B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 21:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5896A1F213C4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D061CFD6A;
	Tue,  2 Jul 2024 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3acl89+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3F1CE09B;
	Tue,  2 Jul 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948519; cv=none; b=VU5F1HOhr8cbas876mF2QBnKwTHRHltdWmWyG+6Pqdp8z/mZi7Mx0al97c/lisRwcl6XGCzKPNKcEVmA7N4jmGhMC3ic4mVCRJXVi7E7BmlXviSQs9KUEuvF/42wSIu2wMeD3U3/IgQpsVaZIVghCibjlnNk31MDCrpBely7qio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948519; c=relaxed/simple;
	bh=tul9GGxVOJheZfp6ob6RkPcc0U0d7m5QmW2bOPPbdg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZMRG/hCWThzgdj8P+ptwuPmO38wFx81htWyYRXvOcdUMA+H2Ul7yrqyS/8aAqzqK99xozRwBS01sn8DyMrIKEa9U/VpcuG6gajj54L36oDXSGilZVpqYAmUAVscj2IBwBnK1rXT2bCaj5f1lIh8GZSk3vuQxT2jwVJgtZfVFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3acl89+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424ad289912so32273125e9.2;
        Tue, 02 Jul 2024 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719948516; x=1720553316; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tul9GGxVOJheZfp6ob6RkPcc0U0d7m5QmW2bOPPbdg8=;
        b=E3acl89+9FCgDvAhl+5crCOYHlEXKkK50tzu0SGTg8FWhUHLw6zyr3YH/z7YOgKkCE
         RFN9jwXxuaoCs9fZ0XN6Em/Aw+3sBTFj8ZfQwj4Agudk4c/QiLYxFDv+R5zfzYWXT+RQ
         ooVGlXFpHSzTn2JJs0yZR54TNTlC1gXN+bMvNgb1rDPFw9lRKizljwpG6sEhawx8Effu
         XHcf6eEUATInxC05KvrHYL4N9TVihQPfsQTHiUZhr5uGgjf6F3lNZc4prkFDlBZ9p0kc
         QRpbMbQGsDzrhHo0BwSShyFPCAh+LM40CFA2MQR/OwUVgdo5IPx6/1djZYcrsb18xVBe
         k6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719948516; x=1720553316;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tul9GGxVOJheZfp6ob6RkPcc0U0d7m5QmW2bOPPbdg8=;
        b=jJ3tt7BkQMhmmmrtnJme0BylPuaYG6aIeWGsPJAUKhuyCFw+N1cELLz7xXXmn61quR
         Sfg1VBnhmrbzcUWTEpn1oK/OcfjAuzUaWBkOIqLvjqirSjVOYJ3Xh5O10MdlumEoTz8X
         H+Lf5BfzLIFjKq85TY08Q85/Xw1PBC+0KKcxyhHqSxq1VOblgWWPsq4565VURsjcd1t0
         NMc3kI85G6zoCOoaS6xPzY0dUxIJ+roqYpKCKXYlaxXYQpnF6JC0u0fkOM/1Wx58xMUL
         rRaxI3JvEjwc29Hgs9YyrGps4t1YPJV3ufJqDfkVVUdWOneQB9wgkgiSt4x80YxLrzzb
         1Ang==
X-Forwarded-Encrypted: i=1; AJvYcCWc3dTQIwKR2OpCvY/EEI1ElMvzlXTbf4fRWYGjao8O05E0e2HVbJdMaEopgULnHHIubkjai3GZ5QX4ImdgZAZVPoXlMla5MImlCEhkti38HWy01gExG9cvNere95D7Dyjw00DSIgNKbIZXD5BY8apvkpqKkIE+8hbQJHoK7/4e4ItgHV0uoYqhzhbBQ4LJvGkF8BHNBpNYAhkp
X-Gm-Message-State: AOJu0YxY4qcQZBSJIN7qkwqMI6biN1JEJZlSsGJC7L7Y3SZSR/8zZCL5
	3SjUn+Cio+r3PW6NZghz7TvS4cLKB2QhKPrllSIBZFSsvuCnqI4K
X-Google-Smtp-Source: AGHT+IEvjPTxMj0JsgTr5zdhlobmpuoHq2YNMq0ll0Nna1fgaDgjHIF7g/bD9TLi2GctXVCTSByhDw==
X-Received: by 2002:a05:600c:304a:b0:424:ac90:8571 with SMTP id 5b1f17b1804b1-4257a01161cmr64297235e9.18.1719948515718;
        Tue, 02 Jul 2024 12:28:35 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:768c:7ffe:4763:3ff5? ([2001:8a0:e622:f700:768c:7ffe:4763:3ff5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55aeasm206364485e9.17.2024.07.02.12.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:28:35 -0700 (PDT)
Message-ID: <87e0dac344d927ca6e2655ce7f7433ff73da6b58.camel@gmail.com>
Subject: Re: [PATCH v1] arm64: dts: imx8mp: Fix VPU PGC power-domain parents
From: Vitor Soares <ivitro@gmail.com>
To: Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vitor Soares <vitor.soares@toradex.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>,  Lucas Stach <l.stach@pengutronix.de>
Date: Tue, 02 Jul 2024 20:28:33 +0100
In-Reply-To: <AM6PR04MB5941E53A5742E95EF1579C6688D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240701124302.16520-1-ivitro@gmail.com>
	 <AM6PR04MB5941E53A5742E95EF1579C6688D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDIzOjU5ICswMDAwLCBQZW5nIEZhbiB3cm90ZToKPiA+IFN1
YmplY3Q6IFtQQVRDSCB2MV0gYXJtNjQ6IGR0czogaW14OG1wOiBGaXggVlBVIFBHQyBwb3dlci1k
b21haW4KPiA+IHBhcmVudHMKPiA+IAo+ID4gRnJvbTogVml0b3IgU29hcmVzIDx2aXRvci5zb2Fy
ZXNAdG9yYWRleC5jb20+Cj4gPiAKPiA+IE9uIGlNWDhNIFBsdXMgUXVhZExpdGUgKFZQVS1sZXNz
IFNvQyksIHRoZSBkZXBlbmRlbmN5IGJldHdlZW4KPiA+IFZQVSBwb3dlciBkb21haW5zIGxlYWQg
dG8gYSBkZWZlcnJlZCBwcm9iZSBlcnJvciBkdXJpbmcgYm9vdDoKPiA+IFvCoMKgIDE3LjE0MDE5
NV0gaW14LXBnYyBpbXgtcGdjLWRvbWFpbi44OiBmYWlsZWQgdG8gY29tbWFuZCBQR0MKPiA+IFvC
oMKgIDE3LjE0NzE4M10gcGxhdGZvcm0gaW14LXBnYy1kb21haW4uMTE6IGRlZmVycmVkIHByb2Jl
IHBlbmRpbmc6Cj4gPiAocmVhc29uIHVua25vd24pCj4gPiBbwqDCoCAxNy4xNDcyMDBdIHBsYXRm
b3JtIGlteC1wZ2MtZG9tYWluLjEyOiBkZWZlcnJlZCBwcm9iZSBwZW5kaW5nOgo+ID4gKHJlYXNv
biB1bmtub3duKQo+ID4gW8KgwqAgMTcuMTQ3MjA3XSBwbGF0Zm9ybSBpbXgtcGdjLWRvbWFpbi4x
MzogZGVmZXJyZWQgcHJvYmUgcGVuZGluZzoKPiA+IChyZWFzb24gdW5rbm93bikKPiA+IAo+ID4g
VGhpcyBpcyBpbmNvcnJlY3QgYW5kIHNob3VsZCBiZSB0aGUgVlBVIGJsay1jdHJsIGNvbnRyb2xs
aW5nIHRoZXNlIHBvd2VyCj4gPiBkb21haW5zLCB3aGljaCBpcyBhbHJlYWR5IGRvaW5nIGl0Lgo+
ID4gCj4gPiBBZnRlciByZW1vdmluZyB0aGUgYHBvd2VyLWRvbWFpbmAgcHJvcGVydHkgZnJvbSB0
aGUgVlBVIFBHQyBub2RlcywKPiA+IGJvdGggaU1YOE0gUGx1cyB3LyBhbmQgdy9vdXQgVlBVIGJv
b3QgY29ycmVjdGx5LiBIb3dldmVyLCBpdCBicmVha3MKPiA+IHRoZSBzdXNwZW5kL3Jlc3VtZSBm
dW5jdGlvbmFsaXR5LiBBIGZpeCBmb3IgdGhpcyBpcyBwZW5kaW5nLCBzZWUgTGlua3MuCj4gPiAK
PiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KPiA+IEZpeGVzOiBkZjY4MDk5MmRkNjIg
KCJhcm02NDogZHRzOiBpbXg4bXA6IGFkZCB2cHUgcGdjIG5vZGVzIikKPiA+IExpbms6Cj4gPiBT
dWdnZXN0ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgo+ID4gU2ln
bmVkLW9mZi1ieTogVml0b3IgU29hcmVzIDx2aXRvci5zb2FyZXNAdG9yYWRleC5jb20+Cj4gCj4g
Rm9yIFZQVS1MZXNzIDhNUCwgYWxsIHRoZSBWUFUgUEdDIG5vZGVzIHNob3VsZCBiZSBkcm9wcGVk
LAo+IHJpZ2h0PwoKVGhleSBkb24ndCBuZWVkIHRvIGJlIGRyb3BwZWQuIFRha2luZyB0aGUgaU1Y
OE1NIExpdGUgdmFyaWFudGUgYXMgZXhhbXBsZSAoaXQKYWxzbyBkb2Vzbid0IGhhdmUgVlBVKSwg
dGhlIG5vZGVzIGFyZSB0aGVyZSBhbmQgdGhpcyBpc3N1ZSBpcyBub3QgcHJlc2VudC4KCj4gCj4g
V2h5IG5vdCB1c2UgYm9vdGxvYWRlciB0byB1cGRhdGUgdGhlIGRldmljZSB0cmVlIGJhc2VkIG9u
IGZ1c2UKPiBzZXR0aW5ncz8KCldoaWxlIGZpeGluZyBWUFUgYmxrLWN0cmwgc3VzcGVuZC9yZXN1
bWUgZnVuY3Rpb25hbGl0eSwgSSByZWNlaXZlZCBmZWVkYmFjayB0aGF0CnRoaXMgVlBVIEdQQyBk
ZXBlbmRlbmN5IGlzIGluY29ycmVjdCBhbmQgaXMgdXAgdG8gVlBVIGJsay1jdHJsIHRvIGNvbnRy
b2wgdGhlCkdQQyBkb21haW5zLgpBcyB3ZSBkaXNhYmxlIHRoZSBWUFUgYmxrLWN0cmwgbm9kZSBv
biB0aGUgYm9vdGxvYWRlciwgcmVtb3ZpbmcgdGhlIGRlcGVuZGVuY3kKc29sdmVzIHRoZSBpc3N1
ZS4KClJlZ2FyZHMsClZpdG9yIFNvYXJlcwo+IAo+IFJlZ2FyZHMsCj4gUGVuZy4KPiAKPiA+IC0t
LQo+ID4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaSB8IDMgLS0t
Cj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kKPiA+IGIvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kKPiA+IGluZGV4IGI5MmFiYjVhNWM1
My4uMTI1NDgzMzZiNzM2IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1wLmR0c2kKPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcC5kdHNpCj4gPiBAQCAtODgyLDIxICs4ODIsMTggQEAgcGdjX3ZwdW1peDogcG93ZXIt
ZG9tYWluQDE5IHsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZ2NfdnB1X2cxOiBw
b3dlci0KPiA+IGRvbWFpbkAyMCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAjcG93ZXItZG9tYWluLQo+ID4gY2VsbHMgPSA8MD47Cj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBvd2VyLWRvbWFpbnMgPQo+ID4gPCZwZ2NfdnB1bWl4
PjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9Cj4gPiA8
SU1YOE1QX1BPV0VSX0RPTUFJTl9WUFVfRzE+Owo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY2xvY2tzID0gPCZjbGsKPiA+IElNWDhNUF9DTEtfVlBVX0cxX1JPT1Q+
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHBnY192cHVfZzI6IHBvd2VyLQo+ID4gZG9tYWluQDIxIHsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNwb3dlci1kb21haW4tCj4gPiBjZWxscyA9IDww
PjsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcG93ZXItZG9tYWlu
cyA9Cj4gPiA8JnBnY192cHVtaXg+Owo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmVnID0KPiA+IDxJTVg4TVBfUE9XRVJfRE9NQUlOX1ZQVV9HMj47Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8JmNsawo+ID4gSU1Y
OE1QX0NMS19WUFVfRzJfUk9PVD47Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiAK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGdjX3ZwdV92YzgwMDBlOiBwb3dlci0KPiA+IGRv
bWFpbkAyMiB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjcG93
ZXItZG9tYWluLQo+ID4gY2VsbHMgPSA8MD47Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHBvd2VyLWRvbWFpbnMgPQo+ID4gPCZwZ2NfdnB1bWl4PjsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9Cj4gPiA8SU1YOE1QX1BPV0VS
X0RPTUFJTl9WUFVfVkM4MDAwRT47Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBjbG9ja3MgPSA8JmNsawo+ID4gSU1YOE1QX0NMS19WUFVfVkM4S0VfUk9PVD47Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiAtLQo+ID4gMi4zNC4xCj4gCgo=


