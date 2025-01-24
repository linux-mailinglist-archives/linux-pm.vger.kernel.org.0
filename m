Return-Path: <linux-pm+bounces-20936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA54A1B2D0
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73EBB7A4191
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F0219E99;
	Fri, 24 Jan 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLsDizuc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71F219A80;
	Fri, 24 Jan 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711728; cv=none; b=LYUjRd8FkeRPwoVQFbNlwMz+ycbwQnlWsZ5xYh0mfAl8/ifkU15sHIcLiQ89PR9bUaX9o/Y2g/bVUQ2qOga8F/jeU/nlbxQgsPzcS0x1F5DAzMl8cxhpwqO6B4xmWPczxdOULtG8eX33pjD6llICMUpAJ0B35M7l5IoUDr6sLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711728; c=relaxed/simple;
	bh=HiaSOjvay0PDEU6IvhGDA9srpEJb+zcTJ9i8VAYmvDs=;
	h=Message-ID:From:To:CC:Subject:Date:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YljquxsmHZNiuNnzztlDBFXxgLAg5tZRldfpUbDq/MN/lVmbY6DjULUzBMOXtg0vawuIcOvpd7wSEZQDkCgjExv2fvxMHIPVrlKtq3QmgdwBWcidruy7TJitnGLGn6DrN5iTfZHH1PzPRx97W/WYzNIxQE2J6CDyQfv/NsUk0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLsDizuc; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso13394735ab.1;
        Fri, 24 Jan 2025 01:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737711726; x=1738316526; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-id:msip_labels
         :content-language:accept-language:in-reply-to:references:date
         :thread-index:thread-topic:subject:cc:to:from:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiaSOjvay0PDEU6IvhGDA9srpEJb+zcTJ9i8VAYmvDs=;
        b=PLsDizucOvMKawPnWMjqcxbs9c1GZLzHU1yEmLwp86OYAEfEtkd9tKkyJOOHxfW7ac
         5X3PUhda1pLqoaadHhcFB8sxYUxD3UrpsxKeb6hJApZnyLeQgqEcsJVLWP24S13Zs6G7
         WYuhMIlW4tGSZKmqQ36A7l4dqN9llqj1MKUIPseak/PJXjuekwi7m7m+Ssr6lnqmaaHR
         Um1Ce+D0FzpHZhe42xtWM3U8zHP1xzSKcdfQJT179yYSHgQO7aV9xua+icCQiC13aCxc
         8Inp4K4oqDV9gOsIMKGx7l8FUcyMO67WQQRnGdBM/EGltHeHM2TkRf8hVeUzBex7wlf/
         lfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737711726; x=1738316526;
        h=mime-version:content-transfer-encoding:content-id:msip_labels
         :content-language:accept-language:in-reply-to:references:date
         :thread-index:thread-topic:subject:cc:to:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiaSOjvay0PDEU6IvhGDA9srpEJb+zcTJ9i8VAYmvDs=;
        b=EtbyTTJOTGOLhqvBdQQObZtI17bVhV0kpk3PUX93qW1aUxdObdvsMTHWD8htXPeKeK
         RRXPm7lM8qFJPB7X9ZxJ69+6fQwzpDm5IVfTXkkmgWo5S1vCvC6ViiyMRvdzaDlrQrb6
         L5paVeuvLByVemlvnwL0D7lY5ObpGfUqWwDLFpVLXj+MP7gDaSAqBCgHPuy+ehpulX54
         Gau5NN77PV9ExbrvwY83yyDL8YpcrkMp6i/qvTuqgZBn78QUaNbUMDGqiAZy/eDKgGgZ
         QIk729SYKgn5lqDmxP4FEtX/m6qZfICGUK60+VXIkGGS8FyfMVvV0V6CJvOONklETOrU
         dOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuBfegEhp87u3Ifo1Wevg5pBBa/JU5EAfFey4qAYE2i99iiF9sZ2pV+c/AqPGNR1It0dXm948rynI=@vger.kernel.org, AJvYcCV34O/NXZFACCWm56I9sjD35v5JZ0ypB5zWQLYQOrAHhu86l7G4+y6TFxR7VphmB/Bm+zt20BEiI4FKY9Jo@vger.kernel.org, AJvYcCWkrJC2MIXB9MfGkrW63gFKL2b+mio/iWz3EglI2c6kOlBkXHdpIrvQ5CmsE1LvNz22qNuku/XTfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwIx/yHvRzzNLBD7CXBuvUUgkq0ZLVMkBJPX5OxvVrFLEnYz+H
	lgs/Fp2+5VOW4KtRW3r9h6PviaQlMCyGB0tAxp7Nfqj4EuuWogcIaUhFpn8Gnqs=
X-Gm-Gg: ASbGncslt4aPN1oCKm2rKVcii3qXU03dyKv11bv8jgvpP6tZD1BR1tnztVP7wHtAxWO
	X59iIWPXsXSYh4dxpbb50azW7EO2XvTVqli9C5MyxCWj5y03zRdO4QhEzvZpxhYFoA6B3gXXBJp
	DZT48RTLvFpRNL0QcHZVpdMx2LBQKjH3TrIqDjsRThizRz9rEe8GIlkZyiToLIROYywsdz7466b
	1INmB85vR+HRdRoTWr0FiBO/DGHX+M2inbuCi7AH2PNyZ7cly/snC4g/FyIqYWpGFteTLj3/T6Y
	iT4KclG8Y72hkPiLFrpNYmCrDIGx0YAZMy9OPmyJbGRK7kluA+WZFQJDswtZE1HCzZk=
X-Google-Smtp-Source: AGHT+IGPe4dH5t61pJCPEVfqud58UJpTXEmd8lE5AaqTQQZAHJ3kvJz0t72oV4bVGYoL13iA4wBmPA==
X-Received: by 2002:a05:6e02:12ec:b0:3ce:afa6:93cf with SMTP id e9e14a558f8ab-3cf74495d71mr198873785ab.17.1737711725772;
        Fri, 24 Jan 2025 01:42:05 -0800 (PST)
Received: from AS8PR05MB8006.eurprd05.prod.outlook.com ([2603:1026:c03:646a::5])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1db6c462sm465754173.92.2025.01.24.01.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:42:05 -0800 (PST)
Message-ID: <6793606d.050a0220.a73fe.0803@mx.google.com>
X-Google-Original-Message-ID: 6.8
From: zuoqian <zuoqian113@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: scpi: compare against frequency instead of rate
Thread-Topic: [PATCH] cpufreq: scpi: compare against frequency instead of rate
Thread-Index: ATNxLTEzzjf736TYkxRUUnZFlp+LHjNkMjQxbnl0VHo0MzE0Njg4ODg4
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Fri, 24 Jan 2025 09:42:01 +0000
References: <20250123075321.4442-1-zuoqian113@gmail.com>
 <ad11dfc1-5e88-4421-b427-3955d4220133@stanley.mountain>
 <Z5IzMhTOhtujyH0n@bogus>
 <8ebf8f26-c3d9-43c0-b417-ce3131a84eb4@stanley.mountain>
In-Reply-To: <8ebf8f26-c3d9-43c0-b417-ce3131a84eb4@stanley.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="gb2312"
Content-ID: <62F0EB0C10D4AF4A92DE832A2CEA22B1@1>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCBKYW4gMjMsIDIwMjUgYXQgMDQ6MDQ6MTNQTSArMDMwMCwgRGFuIENhcnBlbnRlciB3
cm90ZToKPiBPbiBUaHUsIEphbiAyMywgMjAyNSBhdCAxMjoxNjo1MFBNICswMDAwLCBTdWRlZXAg
SG9sbGEgd3JvdGU6Cj4gPiAoZm9yIHNvbWUgcmVhc29uIEkgZG9uJ3QgaGF2ZSB0aGUgb3JpZ2lu
YWwgZW1haWwpCj4gPiAKPiA+IE9uIFRodSwgSmFuIDIzLCAyMDI1IGF0IDAyOjEyOjE0UE0gKzAz
MDAsIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4gPiA+IE9uIFRodSwgSmFuIDIzLCAyMDI1IGF0IDA3
OjUzOjIwQU0gKzAwMDAsIHp1b3FpYW4gd3JvdGU6Cj4gPiA+ID4gVGhlIENQVSByYXRlIGZyb20g
Y2xrX2dldF9yYXRlKCkgbWF5IG5vdCBiZSBkaXZpc2libGUgYnkgMTAwMAo+ID4gPiA+IChlLmcu
LCAxMzMzMzMzMzMpLiBCdXQgdGhlIHJhdGUgY2FsY3VsYXRlZCBmcm9tIGZyZXF1ZW5jeSBpcyBh
bHdheXMKPiA+ID4gPiBkaXZpc2libGUgYnkgMTAwMCAoZS5nLiwgMTMzMzMzMDAwKS4KPiA+ID4g
PiBDb21wYXJpbmcgdGhlIHJhdGUgY2F1c2VzIGEgd2FybmluZyBkdXJpbmcgQ1BVIHNjYWxpbmc6
Cj4gPiA+ID4gImNwdWZyZXE6IF9fdGFyZ2V0X2luZGV4OiBGYWlsZWQgdG8gY2hhbmdlIGNwdSBm
cmVxdWVuY3k6IC01Ii4KPiA+ID4gPiBXaGVuIHdlIGNob29zZSB0byBjb21wYXJlIGZyZXF1ZW5j
eSBoZXJlLCB0aGUgaXNzdWUgZG9lcyBub3Qgb2NjdXIuCj4gPiA+ID4gCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogenVvcWlhbiA8enVvcWlhbjExM0BnbWFpbC5jb20+Cj4gPiA+ID4gLS0tCj4gPiA+
ID4gIGRyaXZlcnMvY3B1ZnJlcS9zY3BpLWNwdWZyZXEuYyB8IDUgKysrLS0KPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4gPiAKPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jIGIvZHJpdmVy
cy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jCj4gPiA+ID4gaW5kZXggY2Q4OWMxYjk4MzJjLi4zYmZm
NGJiNWFiNGEgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL3NjcGktY3B1ZnJl
cS5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jCj4gPiA+ID4g
QEAgLTM5LDggKzM5LDkgQEAgc3RhdGljIHVuc2lnbmVkIGludCBzY3BpX2NwdWZyZXFfZ2V0X3Jh
dGUodW5zaWduZWQgaW50IGNwdSkKPiA+ID4gPiAgc3RhdGljIGludAo+ID4gPiA+ICBzY3BpX2Nw
dWZyZXFfc2V0X3RhcmdldChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwgdW5zaWduZWQg
aW50IGluZGV4KQo+ID4gPiA+ICB7Cj4gPiA+ID4gLQl1NjQgcmF0ZSA9IHBvbGljeS0+ZnJlcV90
YWJsZVtpbmRleF0uZnJlcXVlbmN5ICogMTAwMDsKPiA+ID4gCj4gPiA+IHBvbGljeS0+ZnJlcV90
YWJsZVtpbmRleF0uZnJlcXVlbmN5IGlzIGEgdTMyIHNvIGluIHRoaXMgb3JpZ2luYWwKPiA+ID4g
Y2FsY3VsYXRpb24sIGV2ZW4gdGhvdWdoICJyYXRlIiBpcyBkZWNsYXJlZCBhcyBhIHU2NCwgaXQg
Y2FuJ3QgYWN0dWFsbHkKPiA+ID4gYmUgbW9yZSB0aGFuIFVJTlRfTUFYLgo+ID4gPgo+ID4gCj4g
PiBBZ3JlZWQgYW5kIHVuZGVyc3Rvb2QuCj4gPiAKPiA+ID4gPiArCXVuc2lnbmVkIGxvbmcgZnJl
cSA9IHBvbGljeS0+ZnJlcV90YWJsZVtpbmRleF0uZnJlcXVlbmN5Owo+ID4gPiA+ICAJc3RydWN0
IHNjcGlfZGF0YSAqcHJpdiA9IHBvbGljeS0+ZHJpdmVyX2RhdGE7Cj4gPiA+ID4gKwl1NjQgcmF0
ZSA9IGZyZXEgKiAxMDAwOwo+ID4gPgo+ID4gPiBTbyB5b3UndmUgZml4ZWQgdGhpcyBieSBjYXN0
aW5nIHBvbGljeS0+ZnJlcV90YWJsZVtpbmRleF0uZnJlcXVlbmN5Cj4gPiA+IHRvIHVuc2lnbmVk
IGxvbmcsIHdoaWNoIGZpeGVzIHRoZSBwcm9ibGVtIG9uIDY0Yml0IHN5c3RlbXMgYnV0IGl0IHN0
aWxsCj4gPiA+IHJlbWFpbnMgb24gMzJiaXQgc3lzdGVtcy4gIEl0IHdvdWxkIGJlIGJldHRlciB0
byBkZWNsYXJlIGZyZXEgYXMgYSB1NjQuCj4gPiA+Cj4gPiAKPiA+IEp1c3QgdHJ5aW5nIHRvIHVu
ZGVyc3RhbmQgaWYgdGhhdCBtYXR0ZXJzLiBmcmVxIGlzIGluIGtIeiBhcyBjb3BpZWQKPiA+IGZy
b20gcG9saWN5LT5mcmVxX3RhYmxlW2luZGV4XS5mcmVxdWVuY3kgYW5kIHdlIGNvbXBhcmUgaXQg
d2l0aAo+ID4ga0haIGJlbG93IGFzIHRoZSBvYnRhaW5lZCBjbG9jayByYXRlIGlzIGRpdmlkZWQg
YnkgMTAwMC4gV2hhdCBhbSBJCj4gPiBtaXNzaW5nID8gSWYgaXQgaGVscHMsIGl0IGNhbiBiZSBy
ZW5hbWVkIGFzIGZyZXFfaW5fa2h6IGFuZCBldmVuIGtlZXAKPiA+IGl0IGFzICJ1bnNpZ25lZCBp
bnQiIGFzIGluIHN0cnVjdCBjcHVmcmVxX2ZyZXF1ZW5jeV90YWJsZS4KPiA+IAo+IAo+IAo+IEkg
bWlzdW5kZXJzdG9vZCB0aGUgaW50ZWdlciBvdmVyZmxvdyBidWcgYmVjYXVzZSBJIHJlYWQgdG9v
IG11Y2ggaW50byB0aGUKPiBmYWN0IHRoYXQgInJhdGUiIHdhcyBkZWNsYXJlZCBhcyBhIHU2NC4g
IEl0IHdvdWxkIGhhdmUgYmVlbiBmaW5lIHRvCj4gZGVjbGFyZSBpdCBhcyBhIHVuc2lnbmVkIGxv
bmcuICBUaGUgY3B1ZnJlcSBpbnRlcm5hbHMgZG9uJ3Qgc3VwcG9ydAo+IGFueXRoaW5nIG1vcmUg
dGhhbiBVTE9OR19NQVguICBJIGhhdmUgaGVhcmQgc29tZW9uZSBzYXkgdGhhdCBuZXcgc3lzdGVt
cwo+IGFyZSBidW1waW5nIHVwIGFnYWluc3QgdGhlIDRHSHogbGltaXQgYnV0IHByZXN1bWFibHkg
dGhhdCB3b3VsZCBvbmx5IGJlCj4gaGlnaCBlbmQgNjRiaXQgc3lzdGVtcywgbm90IG9sZCAzMmJp
dCBzeXN0ZW0uCj4gCj4gVGhlIC0+ZnJlcV90YWJsZVtdIGZyZXF1ZW5jeSBpcyBpbiBrSHogc28g
YSB1MzIgaXMgZmluZS4gIEkgZ3Vlc3MgaWYgd2UKPiBnZXQgZnJlcXVlbmNpZXMgb2YgYSBUSHog
dGhlbiB3ZSdsbCBoYXZlIHRvIHVwZGF0ZSB0aGF0LiAgQnV0IHdoZW4gd2UKPiBjb252ZXJ0IHRv
IEh6IHRoZW4gd2UgbmVlZCBhIGNhc3QgdG8gYXZvaWQgYW4gaW50ZWdlciBvdmVyZmxvdyBmb3Ig
c3lzdGVtcwo+IHdoaWNoIGFyZSBvdmVyIHRoZSA0R0h6IGJvdW5kYXJ5Lgo+IAo+IAl1bnNpZ25l
ZCBsb25nIHJhdGUgPSAodW5zaWduZWQgbG9uZylraHogKiAxMDAwOwo+IAo+IFRoZSBzZWNvbmQg
YnVnIGlzIHRoYXQgd2UgbmVlZCB0byBjb21wYXJlIGtIeiBpbnN0ZWFkIG9mIEh6IGFuZCB0aGF0
J3MKPiBzdHJhaWdodCBmb3J3YXJkLgo+IAo+IHJlZ2FyZHMsCj4gZGFuIGNhcnBlbnRlcgo+CgpU
aGFuayB5b3UgZm9yIHlvdXIgdmFsdWFibGUgZmVlZGJhY2suSSB3aWxsIG1ha2UgdGhlIGNoYW5n
ZXMgdG8gdGhlIHBhdGNoIGFuZCAKcmVzdWJtaXQgaXQsIGluY2x1ZGluZyByZW5hbWluZyBmcmVx
IGFuZCBrZWVwaW5nIGl0IGFzIGFuICJ1bnNpZ25lZCBpbnQiLgoKUmVnYXJkcywKWnVvcWlhbgo=

