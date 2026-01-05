Return-Path: <linux-pm+bounces-40213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 691EDCF4DE5
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 18:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 099AE30D7AF7
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3F31AA96;
	Mon,  5 Jan 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s67cTzxq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A730E0EC
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631487; cv=none; b=LzPNIFS/U3JuXRBCXwG3sWTj6TdDgqavuq9cUte08rnVfqkDGffCNiAoOqKdW72sysD8bYBWyfR18r6AbyDc5QrwyvIbUq1jzY++buLErHC0NmojWaHcQVBHbun+eTyQrVelUh7VqzbbsuxOAo+QYzLcHKrVS6vFhFzi4/LoNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631487; c=relaxed/simple;
	bh=ysL1IfLuQqLs930QYIuvsI/XaCNHlG4InlrdhPVFass=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j5lMNzgGAoV6fTmfsXeH6uFaRbXLKR5Zct09ucnHK8Rmp1b9/z5Z+VofQjUP253w0Ne9ROH+bP9KDkpI3JHo92t5phB+2Ct6RK5AAp2FCaa3tVEWi64ftokxdW6Vkx9vOWiiIZfQSLnD1mLqvl3GXT6x2PQrXk/Dn9+SZ4YvEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s67cTzxq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b8b5410a1so121299a12.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 08:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767631484; x=1768236284; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ysL1IfLuQqLs930QYIuvsI/XaCNHlG4InlrdhPVFass=;
        b=s67cTzxqQT3++zeW3nmgazOyFU6yUgMdUPuXIyiEMETVRvc5Sb5QY4YM2dM2N7AjVX
         P3xQEOnoHTwdEmomhxpQQ4TiIokqAvF8TrY0Lw39XNw7AjtSCaFtTFHJdiZVQ4cB9RtX
         RF18yqvTdCd89G9j4ZRQzO/RngMJ5hjKh7hKdzo61XRsFNcvb2+UxlIZWDqgjmw0FNLf
         XucNj7VdQCLMMEchTj1jTxwfxZAV8PZgq2K0YWuzBTVY89feyI98/ZFB4dpOIusudiLS
         EarrzvOCOghrlOskF6L7PSpW8uKEemtJ8t5nWDjZ1SoV4EnJyti6z+piG1l+YKGnrxTf
         VRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631484; x=1768236284;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysL1IfLuQqLs930QYIuvsI/XaCNHlG4InlrdhPVFass=;
        b=WIcMJWIApHc9UyKhaNA83Yp6WIvPe7TchOmi+gtnHeJCnQFGu6Cecbnpt+drlbYr6Q
         xPU5jXe1DlBwQu1Bhp4wsFSKEdFFvFQCjjUZ93FFvzbwlSzxx/DfHod3hhdO+iLD7qQe
         Lkea9zLAAo+tPGWNgXT2SDdyrz/sC2xR3Peq+WZhDdOIEByBnxRZCN4j4Cy/Nx+a8oNn
         tNrkVT9WkpwbYP0vNn57Xfzw68Xx5h9Dffiw4ToQIeL9YNXUeqYsMRYui0E6dcUgo7LZ
         H0JuDr/+3vdyKGABPvSX0dKmq4l/9s0U07tsJWXaVi89Z28enKbfoD8nMfnmdlAtXyT2
         UeVw==
X-Forwarded-Encrypted: i=1; AJvYcCV9JbMPPzmRjqqd6becslZg1uHOyuS6U0rnOC5gGvTD0AItckRBPGDXke608REUGU8WEzg/mvGqAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywszpj3hMbRgYp36lLXOT205bQSdTnKZlHMZPp3mDZjjvB5Cf39
	j+yNRA5w+xcW4nbOaG2CPKs/LsgwNEDZMOlUzzeds722lNGLhXPnnvhH30cQs9T9bZ8=
X-Gm-Gg: AY/fxX4qIgDeuoKEUBhK9K2yvx/yTpaknC2+CaxRUWNuougae1AAUFnMj+n/3+m02sY
	T2zbkgbt3d9ZQ386ze6kKTMC9kZ5xmTs2RfLyaIHcbkihfLMgd19Om6/tO17gOoFuSOjNISEdZN
	iqNnn1AXvfenr5wmGEJWBm8Fo9E3pGtv+almXbN1nzOuHRCIdbdIB2UgfBcPW8xTVFJNArPFOxq
	3Uc5ggN6GcjZ0V8myP4vdb9UKzMUEFgHEMuJM4hQXIW0/nIE1sRZhyrrab3UsiSx5wjjwhrhXMK
	mHeKj189KnTCXvGpOq123IdXpWkKeCVHb8PKtaOdf0t9Lp7Zzm0W9OitgtwhsmwcoK0TRFQhT17
	efXjZRqCdhISCc4zHQvDdkwj+0IQy6qLpIeaj+Z3GGdg19O6mKzYMSEb0LIkrUFInTitMGuNYuj
	TI/dl2KeRKcAfEIXE9D15b7zcYOxO5
X-Google-Smtp-Source: AGHT+IHMPq7hes2husjubrT6pbdK3YBWuHV6Kv168VWiyeDREVlAzmwHmgmU7dDwuzvHpVfXm/CQRw==
X-Received: by 2002:a05:6402:268a:b0:64b:3093:3560 with SMTP id 4fb4d7f45d1cf-6507921efe9mr59078a12.6.1767631483506;
        Mon, 05 Jan 2026 08:44:43 -0800 (PST)
Received: from draszik.lan ([212.129.74.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-650762a2238sm208296a12.34.2026.01.05.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:44:43 -0800 (PST)
Message-ID: <d2c50afe586956ef3a60f17eb77b20fc73fe8dc8.camel@linaro.org>
Subject: Re: [PATCH v3 3/5] mfd: max77759: add register bitmasks and modify
 irq configs for charger
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Mon, 05 Jan 2026 16:45:17 +0000
In-Reply-To: <20251227-max77759-charger-v3-3-54e664f5ca92@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
	 <20251227-max77759-charger-v3-3-54e664f5ca92@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU2F0LCAyMDI1LTEyLTI3IGF0IDAwOjA0ICswMDAwLCBBbWl0IFN1bmlsIERoYW1uZSB2aWEg
QjQgUmVsYXkgd3JvdGU6Cj4gRnJvbTogQW1pdCBTdW5pbCBEaGFtbmUgPGFtaXRzZEBnb29nbGUu
Y29tPgo+IAo+IEFkZCByZWdpc3RlciBiaXRtYXNrcyBmb3IgY2hhcmdlciBmdW5jdGlvbi4KPiBJ
biBhZGRpdGlvbiBzcGxpdCB0aGUgY2hhcmdlciBJUlFzIGZ1cnRoZXIgc3VjaCB0aGF0IGVhY2gg
Yml0IHJlcHJlc2VudHMKPiBhbiBJUlEgZG93bnN0cmVhbSBvZiBjaGFyZ2VyIHJlZ21hcCBpcnEg
Y2hpcC4gSW4gYWRkaXRpb24gcG9wdWxhdGUgdGhlCj4gYWNrX2Jhc2UgdG8gb2ZmbG9hZCBpcnEg
YWNrIHRvIHRoZSByZWdtYXAgaXJxIGNoaXAgZnJhbWV3b3JrLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IEFtaXQgU3VuaWwgRGhhbW5lIDxhbWl0c2RAZ29vZ2xlLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMv
bWZkL21heDc3NzU5LmPCoMKgwqDCoMKgwqAgfMKgIDkxICsrKysrKysrKysrKysrKysrLS0KPiDC
oGluY2x1ZGUvbGludXgvbWZkL21heDc3NzU5LmggfCAyMDIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyNTYgaW5zZXJ0aW9u
cygrKSwgMzcgZGVsZXRpb25zKC0pCj4gCj4gWy4uLl0KPiDCoAo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L21mZC9tYXg3Nzc1OS5oIGIvaW5jbHVkZS9saW51eC9tZmQvbWF4Nzc3NTkuaAo+
IGluZGV4IGM2ZmFjZTM0ZTM4NS4uZTY3NGE1MTllNzgyIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUv
bGludXgvbWZkL21heDc3NzU5LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L21mZC9tYXg3Nzc1OS5o
Cj4gQEAgLTU5LDM1ICs1OSw2NSBAQAo+IMKgI2RlZmluZSBNQVg3Nzc1OV9NQVhRX1JFR19BUF9E
QVRBSU4wwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweGIxCj4gwqAjZGVmaW5lIE1BWDc3NzU5X01B
WFFfUkVHX1VJQ19TV1JTVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweGUwCj4gwqAKPiAtI2Rl
ZmluZSBNQVg3Nzc1OV9DSEdSX1JFR19DSEdfSU5UwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAweGIwCj4gLSNkZWZpbmUgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hHX0lOVDLCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAweGIxCj4gLSNkZWZpbmUgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hHX0lOVF9N
QVNLwqDCoMKgwqDCoMKgwqDCoMKgIDB4YjIKPiAtI2RlZmluZSBNQVg3Nzc1OV9DSEdSX1JFR19D
SEdfSU5UMl9NQVNLwqDCoMKgwqDCoMKgwqDCoCAweGIzCj4gLSNkZWZpbmUgTUFYNzc3NTlfQ0hH
Ul9SRUdfQ0hHX0lOVF9PS8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiNAo+IC0jZGVmaW5lIE1B
WDc3NzU5X0NIR1JfUkVHX0NIR19ERVRBSUxTXzAwwqDCoMKgwqDCoMKgwqAgMHhiNQo+IC0jZGVm
aW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19ERVRBSUxTXzAxwqDCoMKgwqDCoMKgwqAgMHhiNgo+
IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19ERVRBSUxTXzAywqDCoMKgwqDCoMKgwqAg
MHhiNwo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19ERVRBSUxTXzAzwqDCoMKgwqDC
oMKgwqAgMHhiOAo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzAwwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMHhiOQo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZH
XzAxwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiYQo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVH
X0NIR19DTkZHXzAywqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiYgo+IC0jZGVmaW5lIE1BWDc3NzU5
X0NIR1JfUkVHX0NIR19DTkZHXzAzwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiYwo+IC0jZGVmaW5l
IE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzA0wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiZAo+
IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzA1wqDCoMKgwqDCoMKgwqDCoMKg
wqAgMHhiZQo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzA2wqDCoMKgwqDC
oMKgwqDCoMKgwqAgMHhiZgo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzA3
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjMAo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NI
R19DTkZHXzA4wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjMQo+IC0jZGVmaW5lIE1BWDc3NzU5X0NI
R1JfUkVHX0NIR19DTkZHXzA5wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjMgo+IC0jZGVmaW5lIE1B
WDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzEwwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjMwo+IC0j
ZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzExwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MHhjNAo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzEywqDCoMKgwqDCoMKg
wqDCoMKgwqAgMHhjNQo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzEzwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMHhjNgo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19D
TkZHXzE0wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjNwo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1Jf
UkVHX0NIR19DTkZHXzE1wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjOAo+IC0jZGVmaW5lIE1BWDc3
NzU5X0NIR1JfUkVHX0NIR19DTkZHXzE2wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjOQo+IC0jZGVm
aW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzE3wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhj
YQo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzE4wqDCoMKgwqDCoMKgwqDC
oMKgwqAgMHhjYgo+IC0jZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzE5wqDCoMKg
wqDCoMKgwqDCoMKgwqAgMHhjYwo+ICsjZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19JTlTC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiMAo+ICsjZGVmaW5l
wqDCoCBNQVg3Nzc1OV9DSEdSX1JFR19DSEdfSU5UX0FJQ0zCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIEJJVCg3KQo+ICsjZGVmaW5lwqDCoCBNQVg3Nzc1OV9DSEdSX1JFR19DSEdfSU5UX0NI
R0lOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKDYpCj4gKyNkZWZpbmXCoMKgIE1BWDc3
NzU5X0NIR1JfUkVHX0NIR19JTlRfV0NJTsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklU
KDUpCj4gKyNkZWZpbmXCoMKgIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19JTlRfQ0hHwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVCg0KQo+ICsjZGVmaW5lwqDCoCBNQVg3Nzc1OV9DSEdS
X1JFR19DSEdfSU5UX0JBVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCSVQoMykKPiAr
I2RlZmluZcKgwqAgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hHX0lOVF9JTkxJTcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEJJVCgyKQo+ICsjZGVmaW5lwqDCoCBNQVg3Nzc1OV9DSEdSX1JFR19DSEdf
SU5UX1RITTLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVCgxKQo+ICsjZGVmaW5lwqDC
oCBNQVg3Nzc1OV9DSEdSX1JFR19DSEdfSU5UX0JZUMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBCSVQoMCkKPiArI2RlZmluZSBNQVg3Nzc1OV9DSEdSX1JFR19DSEdfSU5UMsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiMQo+ICsjZGVmaW5lwqDCoCBNQVg3
Nzc1OV9DSEdSX1JFR19DSEdfSU5UMl9JTlNFTMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCSVQo
NykKPiArI2RlZmluZcKgwqAgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hHX0lOVDJfU1lTX1VWTE8xwqDC
oMKgwqDCoMKgwqDCoCBCSVQoNikKPiArI2RlZmluZcKgwqAgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hH
X0lOVDJfU1lTX1VWTE8ywqDCoMKgwqDCoMKgwqDCoCBCSVQoNSkKPiArI2RlZmluZcKgwqAgTUFY
Nzc3NTlfQ0hHUl9SRUdfQ0hHX0lOVDJfQkFUX09JTE/CoMKgwqDCoMKgwqDCoMKgwqAgQklUKDQp
Cj4gKyNkZWZpbmXCoMKgIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19JTlQyX0NIR19TVEFfQ0PCoMKg
wqDCoMKgwqDCoCBCSVQoMykKPiArI2RlZmluZcKgwqAgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hHX0lO
VDJfQ0hHX1NUQV9DVsKgwqDCoMKgwqDCoMKgIEJJVCgyKQo+ICsjZGVmaW5lwqDCoCBNQVg3Nzc1
OV9DSEdSX1JFR19DSEdfSU5UMl9DSEdfU1RBX1RPwqDCoMKgwqDCoMKgwqAgQklUKDEpCj4gKyNk
ZWZpbmXCoMKgIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19JTlQyX0NIR19TVEFfRE9ORcKgwqDCoMKg
wqAgQklUKDApCj4gKyNkZWZpbmUgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hHX0lOVF9NQVNLwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiMgo+ICsjZGVmaW5lIE1BWDc3NzU5X0NIR1Jf
UkVHX0NIR19JTlQyX01BU0vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiMwo+ICsj
ZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19JTlRfT0vCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMHhiNAo+ICsjZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19ERVRB
SUxTXzAwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweGI1Cj4gKyNkZWZpbmXCoMKgIE1B
WDc3NzU5X0NIR1JfUkVHX0NIR19ERVRBSUxTX09PX0NIR0lOX0RUTFPCoCBHRU5NQVNLKDYsIDUp
Cj4gKyNkZWZpbmUgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hHX0RFVEFJTFNfMDHCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDB4YjYKPiArI2RlZmluZcKgwqAgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hH
X0RFVEFJTFNfMDFfQkFUX0RUTFPCoMKgwqAgR0VOTUFTSyg2LCA0KQo+ICsjZGVmaW5lwqDCoCBN
QVg3Nzc1OV9DSEdSX1JFR19DSEdfREVUQUlMU18wMV9DSEdfRFRMU8KgwqDCoCBHRU5NQVNLKDMs
IDApCj4gKyNkZWZpbmUgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hHX0RFVEFJTFNfMDLCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDB4YjcKPiArI2RlZmluZcKgwqAgTUFYNzc3NTlfQ0hHUl9SRUdf
Q0hHX0RFVEFJTFNfMDJfQ0hHSU5fU1RTwqDCoCBCSVQoNSkKPiArI2RlZmluZSBNQVg3Nzc1OV9D
SEdSX1JFR19DSEdfREVUQUlMU18wM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiOAo+
ICsjZGVmaW5lIE1BWDc3NzU5X0NIR1JfUkVHX0NIR19DTkZHXzAwwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAweGI5Cj4gKyNkZWZpbmXCoMKgIE1BWDc3NzU5X0NIR1JfUkVHX0NI
R19DTkZHXzAwX01PREXCoMKgwqDCoMKgwqDCoMKgwqDCoCBHRU5NQVNLKDMsIDApCj4gKyNkZWZp
bmUgTUFYNzc3NTlfQ0hHUl9SRUdfQ0hHX0NORkdfMDHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDB4YmEKPiArI2RlZmluZSBNQVg3Nzc1OV9DSEdSX1JFR19DSEdfQ05GR18wMsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhiYgo+ICsjZGVmaW5lwqDCoCBNQVg3
Nzc1OV9DSEdSX1JFR19DSEdfQ05GR18wMl9DSEdDQwnCoMKgwqDCoMKgwqAgR0VOTUFTSyg1LCAw
KQoKU21hbGwgbml0IC0gdGhlcmUgc2VlbXMgdG8gYmUgYSBzdHJheSBUQUIgaW4gdGhpcyBsaW5l
LgoKT3RoZXIgdGhhbiB0aGF0OgpSZXZpZXdlZC1ieTogQW5kcsOpIERyYXN6aWsgPGFuZHJlLmRy
YXN6aWtAbGluYXJvLm9yZz4K


