Return-Path: <linux-pm+bounces-9932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8104691600E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 09:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25D0281DB4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2CC145FFE;
	Tue, 25 Jun 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOaLj6cr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF0838DE9;
	Tue, 25 Jun 2024 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300766; cv=none; b=sanlTBLlGVrVi+3cJx99yu+DfENJrSjGA+Z3c7gFuxv5QzpyKWMXlDPgov/98bbPPa/tIumr0jz9cckeqiE6G+1QvfCrQWY7/f3AcQZ0laKzu8PeJYki0RGDUnvMZB1M3y+i3KUXBCkHvqejz4m2NdUIiUdnVCCqSlChqKOxfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300766; c=relaxed/simple;
	bh=IUbiVP8xony8icYLC/qkNTBb91qBC1whw3FP1LZqLd8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DcEux/RStLqs2vVtsy71LqzX0iPJ1kUrvt9V4NSnwhNM2i1jT27z8gATxcMU+ti4NVRw9sM4gFyfw/RhviW+rgCwyxyeUehpN5qFt93760MJm05hKLXaSS57bxmGh3XMRAP6v8nf45zrivSSu6FHAfZ4Y5inauqcnHOCYIFtDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOaLj6cr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so39203185e9.2;
        Tue, 25 Jun 2024 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719300763; x=1719905563; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IUbiVP8xony8icYLC/qkNTBb91qBC1whw3FP1LZqLd8=;
        b=NOaLj6cr0T+fXerShawUP4lNxlqxV/sqkASFOBdHDAx8Z7zWxWPgkCzfwUF1wLdVTG
         mKYXe/uOjKbAxSYAxbFskFkmF0IiZ3fxdrcvJMq6lqMhVb6mnBBaDW2z9VX6VQ/S5yJ/
         4l0M62Niemc3lkyrF6+da2Z8p1+yr7QW7W8U0IR6VBqfScqfEwWKsFA0THFMvgFeiAY0
         fPguWyIVQcO/F4HQyyO20hXieWTJJPmn8cn+vzaUOlmYM/FX9yf5oyewE4PzSVdm8CzW
         trBCs8iMKqLe7DttUTDIJL2mXTshfi5axAfv+YWyerFDhA0yIpalVc9OiUnacTrml1/z
         ZMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719300763; x=1719905563;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUbiVP8xony8icYLC/qkNTBb91qBC1whw3FP1LZqLd8=;
        b=jZ41CjqD94Hst/RLi7FVDKHcHel6HwIAg8weGoa3tapdiWNJcxFCOobZXDa1xl2dF4
         ab/aAygQs2jXO+Mh/Vm+GBlDSTPX6TB0UMVWsclEnUJsMRpdkOLWltyvSKARqXbxTcAr
         lPLmFCC5WQzXNHYw3GmzG4PDbP8/hkEE4TKZYQvSOaTD71hPdBWxt240WmoSQj7kEDsL
         ubC1vvdcUGVZs8U21avqcEdAWuyHB1PBrRQGUXX7yOI4pCQ6oGPF4rOa55vZ74K+ySVc
         vqYA52byzkx2qv5xCBTzbxmxOqMH2FsVwHitZvCUvZtJuOaQXBoa+gxT/MMB3Db5GBOz
         o/xg==
X-Forwarded-Encrypted: i=1; AJvYcCV6dZSC4BmCRSdwJtalSqe2ZZs3+4Hx00V9tefE+k7zRfmC/+ftK90ZdrqcidPwU730uejosF14T8TWLy/edgJg7oaVgFF/CYZ3fe236MvaanKpm80dNlT5q9rtl5+EnosM0YM01XQbZ/BHijEzqzaZD7DyMElhGSmeztirUjk=
X-Gm-Message-State: AOJu0YzWtnvytpKojNVYDm+9+4phnlJi+N8/l2O9eIV5034RSxCU8bww
	MvZPt/czrF/fxH2bL30GEly8AYimjCSgO5nLOylQuQHqLuAOOXMY
X-Google-Smtp-Source: AGHT+IFQYHSqm3GQqXLWbrZB5wbRTMZyfH87/rDkZdNAX1vqWHQh9STJrmf+Vfmk5Dj1ToAGm5tdnA==
X-Received: by 2002:a05:600c:3503:b0:422:218e:b8d7 with SMTP id 5b1f17b1804b1-4248cc66a78mr61826015e9.38.1719300762265;
        Tue, 25 Jun 2024 00:32:42 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:4c7c:9f31:be11:4a56? ([2001:8a0:e622:f700:4c7c:9f31:be11:4a56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0bea1esm200800705e9.13.2024.06.25.00.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:32:41 -0700 (PDT)
Message-ID: <513930aa50c2f55e7853a53dd42f43ac219ff384.camel@gmail.com>
Subject: Re: [PATCH v1] pmdomain: imx8m-blk-ctrl: fix suspend/resume order
From: Vitor Soares <ivitro@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach
 <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Vitor Soares <vitor.soares@toradex.com>,
 linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Tue, 25 Jun 2024 08:32:40 +0100
In-Reply-To: <CAPDyKFr9Vzgm2C6Z57Bg5mUQxg5LK6goN2og3+RC3BkTZjiqJw@mail.gmail.com>
References: <20240418155151.355133-1-ivitro@gmail.com>
	 <CAPDyKFr9Vzgm2C6Z57Bg5mUQxg5LK6goN2og3+RC3BkTZjiqJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTA1LTEwIGF0IDExOjM0ICswMjAwLCBVbGYgSGFuc3NvbiB3cm90ZToKPiBP
biBUaHUsIDE4IEFwciAyMDI0IGF0IDE3OjUyLCBWaXRvciBTb2FyZXMgPGl2aXRyb0BnbWFpbC5j
b20+IHdyb3RlOgo+ID4gCj4gPiBGcm9tOiBWaXRvciBTb2FyZXMgPHZpdG9yLnNvYXJlc0B0b3Jh
ZGV4LmNvbT4KPiA+IAo+ID4gRHVyaW5nIHRoZSBwcm9iZSwgdGhlIGdlbnBkIHBvd2VyX2RldiBp
cyBhZGRlZCB0byB0aGUgZHBtX2xpc3QgYWZ0ZXIKPiA+IGJsa19jdHJsIGR1ZSB0byBpdHMgcGFy
ZW50L2NoaWxkIHJlbGF0aW9uc2hpcC4gTWFraW5nIHRoZSBibGtfY3RybAo+ID4gc3VzcGVuZCBh
ZnRlciBhbmQgcmVzdW1lIGJlZm9yZSB0aGUgZ2VucGQgcG93ZXJfZGV2Lgo+ID4gCj4gPiBBcyBh
IGNvbnNlcXVlbmNlLCB0aGUgc3lzdGVtIGhhbmdzIHdoZW4gcmVzdW1pbmcgdGhlIFZQVSBkdWUg
dG8gdGhlCj4gPiBwb3dlciBkb21haW4gZGVwZW5kZW5jeS4KPiA+IAo+ID4gVG8gZW5zdXJlIHRo
ZSBwcm9wZXIgc3VzcGVuZC9yZXN1bWUgb3JkZXIsIGFkZCBhIGRldmljZSBsaW5rIGJldHdlZW0K
PiA+IGJsa19jdHJsIGFuZCBnZW5wZCBwb3dlcl9kZXYuIEl0IGd1YXJhbnRlZXMgZ2VucGQgcG93
ZXJfZGV2IGlzIHN1c3BlbmRlZAo+ID4gYWZ0ZXIgYW5kIHJlc3VtZWQgYmVmb3JlIGJsay1jdHJs
Lgo+IAo+IEJlZm9yZSBkaXNjdXNzaW5nICRzdWJqZWN0IHBhdGNoLCB3b3VsZCB5b3UgbWluZCBl
eHBsYWluaW5nIHRvIG1lIHdoeQo+IGlteDhtLWJsay1jdHJsIG5lZWRzIHRvIHVzZSB0aGUgLT5z
dXNwZW5kKCkgY2FsbGJhY2sgYXQgYWxsPwo+IAo+IExvb2tpbmcgY2xvc2VyIGF0IHRoYXQgY29k
ZSAoaW14OG1fYmxrX2N0cmxfc3VzcGVuZCgpKSwgaXQgY2FsbHMKPiBwbV9ydW50aW1lX2dldF9z
eW5jKCkgZm9yIGRldmljZXMgdG8gcG93ZXIgb24gImV2ZXJ5dGhpbmciLiBXaHkgaXNuJ3QKPiB0
aGF0IG1hbmFnZWQgYnkgdGhlIGNvbnN1bWVyIGRyaXZlcnMgKG9uIGEgY2FzZSBieSBjYXNlIGJh
c2lzKSB0aGF0Cj4gYXJlIG1hbmFnaW5nIHRoZSBkZXZpY2VzIHRoYXQgYXJlIGF0dGFjaGVkIHRv
IHRoZSBnZW5wZHMgaW5zdGVhZD8KPiAKPiBLaW5kIHJlZ2FyZHMKPiBVZmZlCj4gCgpIaSBMdWNh
cywgeW91IGtub3cgdGhlIGRyaXZlciBhcmNoaXRlY3R1cmUgYmV0dGVyIHRoYW4gSSBkby4gV291
bGQgeW91IG1pbmQKYWRkcmVzc2luZyBVbGYgY29uY2VybnM/CgoKSW4gYWRkaXRpb24gdG8gdGhh
dCwgSSB3b3VsZCBzYXkgdGhhdCBnaXZlbiB0aGF0IHRoaXMgaXMgYSBidWcgZml4LCBpdCB3b3Vs
ZCBiZQpuaWNlIHRvIGhhdmUgaXQgbWVyZ2VkLiBIYXZpbmcgYSBidWdneSBkcml2ZXIgaW4gdGhl
IGtlcm5lbCBpcyBub3Qgc29sdmluZyB0aGlzCmtpbmQgb2YgYXJjaGl0ZWN0dXJhbCBxdWVzdGlv
bi4KCgpCZXN0IHJlZ2FyZHMsClZpdG9yIFNvYXJlcwoKPiA+IAo+ID4gQ2M6IDxzdGFibGVAdmdl
ci5rZXJuZWwub3JnPgo+ID4gQ2xvc2VzOgo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
L2ZjY2JiMDQwMzMwYTcwNmE0ZjdiMzQ4NzVkYjFkODk2YTBiZjgxYzguY2FtZWxAZ21haWwuY29t
Lwo+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNDA5MDg1ODAyLjI5
MDQzOS0xLWl2aXRyb0BnbWFpbC5jb20vCj4gPiBGaXhlczogMjY4NGFjMDVhOGM0ICgic29jOiBp
bXg6IGFkZCBpLk1YOE0gYmxrLWN0cmwgZHJpdmVyIikKPiA+IFN1Z2dlc3RlZC1ieTogTHVjYXMg
U3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXRvciBT
b2FyZXMgPHZpdG9yLnNvYXJlc0B0b3JhZGV4LmNvbT4KPiA+IC0tLQo+ID4gCj4gPiBUaGlzIGlz
IGEgbmV3IHBhdGNoLCBidXQgaXMgYSBmb2xsb3ctdXAgb2Y6Cj4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyNDA0MDkwODU4MDIuMjkwNDM5LTEtaXZpdHJvQGdtYWlsLmNvbS8KPiA+
IAo+ID4gQXMgc3VnZ2VzdGVkIGJ5IEx1Y2FzLCB3ZSBhcmUgYWRkcmVzc2luZyB0aGlzIFBNIGlz
c3VlIGluIHRoZSBpbXg4bS1ibGstY3RybAo+ID4gZHJpdmVyIGluc3RlYWQgb2YgaW4gdGhlIGlt
eDhtbS5kdHNpLgo+ID4gCj4gPiDCoGRyaXZlcnMvcG1kb21haW4vaW14L2lteDhtLWJsay1jdHJs
LmMgfCAxNiArKysrKysrKysrKysrKysrCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4bS1i
bGstY3RybC5jCj4gPiBiL2RyaXZlcnMvcG1kb21haW4vaW14L2lteDhtLWJsay1jdHJsLmMKPiA+
IGluZGV4IGNhOTQyZDc5MjljMi4uY2QwZDIyOTYwODBkIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVy
cy9wbWRvbWFpbi9pbXgvaW14OG0tYmxrLWN0cmwuYwo+ID4gKysrIGIvZHJpdmVycy9wbWRvbWFp
bi9pbXgvaW14OG0tYmxrLWN0cmwuYwo+ID4gQEAgLTI4Myw2ICsyODMsMjAgQEAgc3RhdGljIGlu
dCBpbXg4bV9ibGtfY3RybF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlCj4gPiAqcGRldikK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBj
bGVhbnVwX3BkczsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiAKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogRW5mb3JjZSBzdXNwZW5kL3Jlc3VtZSBvcmRlcmluZyBieSBtYWtpbmcg
Z2VucGQgcG93ZXJfZGV2Cj4gPiBhCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogcHJvdmlkZXIgb2YgYmxrLWN0cmwuIEdlbnBkIHBvd2VyX2RldiBpcyBzdXNwZW5kZWQgYWZ0
ZXIKPiA+IGFuZAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHJlc3VtZWQg
YmVmb3JlIGJsay1jdHJsLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFkZXZpY2VfbGlua19hZGQoZGV2
LCBkb21haW4tPnBvd2VyX2RldiwKPiA+IERMX0ZMQUdfU1RBVEVMRVNTKSkgewo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IC1FSU5WQUw7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2Vycl9w
cm9iZShkZXYsIHJldCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImZhaWxlZCB0byBsaW5rIHRvICVz
XG4iLCBkYXRhLT5uYW1lKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwbV9nZW5wZF9yZW1vdmUoJmRvbWFpbi0+Z2VucGQpOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9wbV9kb21haW5fZGV0YWNo
KGRvbWFpbi0+cG93ZXJfZGV2LCB0cnVlKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXBfcGRzOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfQo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFdlIHVzZSBydW50aW1l
IFBNIHRvIHRyaWdnZXIgcG93ZXIgb24vb2ZmIG9mIHRoZSB1cHN0cmVhbQo+ID4gR1BDCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRvbWFpbiwgYXMgYSBzdHJpY3QgaGll
cmFyY2hpY2FsIHBhcmVudC9jaGlsZCBwb3dlcgo+ID4gZG9tYWluCj4gPiBAQCAtMzI0LDYgKzMz
OCw3IEBAIHN0YXRpYyBpbnQgaW14OG1fYmxrX2N0cmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQo+ID4gKnBkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoCBvZl9nZW5wZF9kZWxfcHJvdmlkZXIo
ZGV2LT5vZl9ub2RlKTsKPiA+IMKgY2xlYW51cF9wZHM6Cj4gPiDCoMKgwqDCoMKgwqDCoCBmb3Ig
KGktLTsgaSA+PSAwOyBpLS0pIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
dmljZV9saW5rX3JlbW92ZShkZXYsIGJjLT5kb21haW5zW2ldLnBvd2VyX2Rldik7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG1fZ2VucGRfcmVtb3ZlKCZiYy0+ZG9tYWluc1tp
XS5nZW5wZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3BtX2RvbWFp
bl9kZXRhY2goYmMtPmRvbWFpbnNbaV0ucG93ZXJfZGV2LCB0cnVlKTsKPiA+IMKgwqDCoMKgwqDC
oMKgIH0KPiA+IEBAIC0zNDMsNiArMzU4LDcgQEAgc3RhdGljIHZvaWQgaW14OG1fYmxrX2N0cmxf
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UKPiA+ICpwZGV2KQo+ID4gwqDCoMKgwqDCoMKg
wqAgZm9yIChpID0gMDsgYmMtPm9uZWNlbGxfZGF0YS5udW1fZG9tYWluczsgaSsrKSB7Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlteDhtX2Jsa19jdHJsX2RvbWFp
biAqZG9tYWluID0gJmJjLT5kb21haW5zW2ldOwo+ID4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkZXZpY2VfbGlua19yZW1vdmUoJnBkZXYtPmRldiwgZG9tYWluLT5wb3dlcl9k
ZXYpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBtX2dlbnBkX3JlbW92ZSgm
ZG9tYWluLT5nZW5wZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3Bt
X2RvbWFpbl9kZXRhY2goZG9tYWluLT5wb3dlcl9kZXYsIHRydWUpOwo+ID4gwqDCoMKgwqDCoMKg
wqAgfQo+ID4gLS0KPiA+IDIuMzQuMQo+ID4gCgo=


