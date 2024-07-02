Return-Path: <linux-pm+bounces-10384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE8F92494F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 22:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707651C20481
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F220013B;
	Tue,  2 Jul 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS6qTz7J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E61CE0A1;
	Tue,  2 Jul 2024 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952374; cv=none; b=a70ytZI9mtdaKiwOQqCXtU3U9IO3e6ACRFX82wdRqOaiHzIMN7lnNsKFOkkahh5VE+YYTlNoYm6FbFKm1Fclj/3xWYpl4cU+x43v1sv14wwe0PVeD/EqRnOmqfe4VDlJ5iDtA6l3Hr55ocC+wwmATrFg8bAbv0SogjvMgxjQvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952374; c=relaxed/simple;
	bh=E9nK3Tw8qljGPX4plfl3//NJwCSaDr30AkzmNbsRcH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eiSDlD4gCPE1nM6w9h+wz4cs+L/XEUaZzn+1JTYcUVcOmLmz1rKV11qhVNcpAliCAHxEsVMSb/XjhP4sg4sKclh25YUmrFugwoLlQehNqlof6GNDMSoW9d5h0UhoUYXtkOq2+LSLgydn8xTfpRroSdxf54I+XPMkBLiU3ZiQ6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS6qTz7J; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424acfff613so41456095e9.0;
        Tue, 02 Jul 2024 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719952371; x=1720557171; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9nK3Tw8qljGPX4plfl3//NJwCSaDr30AkzmNbsRcH0=;
        b=CS6qTz7JtDBptFxVEAejXf/+POECifsaM8kJnK5UrgjyOyrhdBwjeR9uEOOThz6VYx
         LajpEstnnJ3cCovDZ1PvGB7SwHkJAINUlx2aiElI8IBSat+aH/3VLAsQK0dA/bJClNan
         zOD+yrKWaO4j7nRfOSpK0YkvNKPkNNvbTLEO9I2bgcR4SJFwUVLsD6dai2ZZtEJ3TfLk
         Ow9q278pBRolROl9kyn60687oNlGlYd/CNR0qM8RXj9Qk4y1zUYJBIM6pywVddbOja2o
         aO/gVL6bTDwlgfRqxOcyyScZyZaa1W4UPu6Gv5DBPgwjcwGo54nKBiVkUFaJYgjh8get
         wV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719952371; x=1720557171;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9nK3Tw8qljGPX4plfl3//NJwCSaDr30AkzmNbsRcH0=;
        b=QegpevaqR18nO8gS3aqXuw1FqR4e05nLLEPPkhcJxg9ltdZwZ9jtecVARM/s/WYkzJ
         hYK3rHlhu7B4em7rj0s3CBGwsKLfTxixzZSh4d0tIqZuR5kKqTlTPrmeAY4IfEVMamhl
         JZp17qppss6klhGZuxzGZPJDsvA/r6MttTIGZnAmCB6K1Z8v0ZRlOeh5UMUdJ/hOFokz
         jwfTNqBOg4hmIxDEMTBzoL09emiAYPxAV9w93N1cfjjCVk362mubjV/TaY+i8ZHmrZyD
         NzrHU2uOcYE5OvhHCWMPKB84kkEdl4KxAvNIpQYMkN++N8Ab5OwnpqhJRat1knxhNo1d
         qQJw==
X-Forwarded-Encrypted: i=1; AJvYcCXmmLDtCWgRm7kVZxa+VnILbXAIWBJEndfnYMLZ1V3HUQ/J2LLq62zMcDLVYyaEoQf1cBajP+bL7GqxrcuFkaEYMkEbs5rYSPU1wlntmGRgUekquRx4fqa+UD5QxLxiBtSUNxDxbGI5gd13Zmt6Um42wlDOpyek4+Xg1bdUPYbUAGT7xGitc5TCUUj99yWCpAKW2i/8vhhAgbWO
X-Gm-Message-State: AOJu0Ywo0FBkfq662LwFs9T0fHFRyR6v8o6xeXifL1UqaGIBoljQQE2b
	ZMtQSI480dWgOFn5ubn5shfe7Br9j9k6foj2pSG6K0ZYeNO4V07h
X-Google-Smtp-Source: AGHT+IE20cDeBFP0yCLhDrH0S8xtHB8MdXpDicw6ouPSihjjctVBiYFTfoe7kE+Lgdkaz+M6NVlp7w==
X-Received: by 2002:adf:f809:0:b0:367:8de4:84ef with SMTP id ffacd0b85a97d-3678de4869dmr1482112f8f.30.1719952370692;
        Tue, 02 Jul 2024 13:32:50 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:768c:7ffe:4763:3ff5? ([2001:8a0:e622:f700:768c:7ffe:4763:3ff5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc58esm14288733f8f.72.2024.07.02.13.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 13:32:50 -0700 (PDT)
Message-ID: <4b2da701dd261c1ed008288e17499250b11e80aa.camel@gmail.com>
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
Date: Tue, 02 Jul 2024 21:32:48 +0100
In-Reply-To: <87e0dac344d927ca6e2655ce7f7433ff73da6b58.camel@gmail.com>
References: <20240701124302.16520-1-ivitro@gmail.com>
	 <AM6PR04MB5941E53A5742E95EF1579C6688D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
	 <87e0dac344d927ca6e2655ce7f7433ff73da6b58.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA3LTAyIGF0IDIwOjI4ICswMTAwLCBWaXRvciBTb2FyZXMgd3JvdGU6Cj4g
T24gTW9uLCAyMDI0LTA3LTAxIGF0IDIzOjU5ICswMDAwLCBQZW5nIEZhbiB3cm90ZToKPiA+ID4g
U3ViamVjdDogW1BBVENIIHYxXSBhcm02NDogZHRzOiBpbXg4bXA6IEZpeCBWUFUgUEdDIHBvd2Vy
LWRvbWFpbgo+ID4gPiBwYXJlbnRzCj4gPiA+IAo+ID4gPiBGcm9tOiBWaXRvciBTb2FyZXMgPHZp
dG9yLnNvYXJlc0B0b3JhZGV4LmNvbT4KPiA+ID4gCj4gPiA+IE9uIGlNWDhNIFBsdXMgUXVhZExp
dGUgKFZQVS1sZXNzIFNvQyksIHRoZSBkZXBlbmRlbmN5IGJldHdlZW4KPiA+ID4gVlBVIHBvd2Vy
IGRvbWFpbnMgbGVhZCB0byBhIGRlZmVycmVkIHByb2JlIGVycm9yIGR1cmluZyBib290Ogo+ID4g
PiBbwqDCoCAxNy4xNDAxOTVdIGlteC1wZ2MgaW14LXBnYy1kb21haW4uODogZmFpbGVkIHRvIGNv
bW1hbmQgUEdDCj4gPiA+IFvCoMKgIDE3LjE0NzE4M10gcGxhdGZvcm0gaW14LXBnYy1kb21haW4u
MTE6IGRlZmVycmVkIHByb2JlIHBlbmRpbmc6Cj4gPiA+IChyZWFzb24gdW5rbm93bikKPiA+ID4g
W8KgwqAgMTcuMTQ3MjAwXSBwbGF0Zm9ybSBpbXgtcGdjLWRvbWFpbi4xMjogZGVmZXJyZWQgcHJv
YmUgcGVuZGluZzoKPiA+ID4gKHJlYXNvbiB1bmtub3duKQo+ID4gPiBbwqDCoCAxNy4xNDcyMDdd
IHBsYXRmb3JtIGlteC1wZ2MtZG9tYWluLjEzOiBkZWZlcnJlZCBwcm9iZSBwZW5kaW5nOgo+ID4g
PiAocmVhc29uIHVua25vd24pCj4gPiA+IAo+ID4gPiBUaGlzIGlzIGluY29ycmVjdCBhbmQgc2hv
dWxkIGJlIHRoZSBWUFUgYmxrLWN0cmwgY29udHJvbGxpbmcgdGhlc2UgcG93ZXIKPiA+ID4gZG9t
YWlucywgd2hpY2ggaXMgYWxyZWFkeSBkb2luZyBpdC4KPiA+ID4gCj4gPiA+IEFmdGVyIHJlbW92
aW5nIHRoZSBgcG93ZXItZG9tYWluYCBwcm9wZXJ0eSBmcm9tIHRoZSBWUFUgUEdDIG5vZGVzLAo+
ID4gPiBib3RoIGlNWDhNIFBsdXMgdy8gYW5kIHcvb3V0IFZQVSBib290IGNvcnJlY3RseS4gSG93
ZXZlciwgaXQgYnJlYWtzCj4gPiA+IHRoZSBzdXNwZW5kL3Jlc3VtZSBmdW5jdGlvbmFsaXR5LiBB
IGZpeCBmb3IgdGhpcyBpcyBwZW5kaW5nLCBzZWUgTGlua3MuCj4gPiA+IAo+ID4gPiBDYzogPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+Cj4gPiA+IEZpeGVzOiBkZjY4MDk5MmRkNjIgKCJhcm02NDog
ZHRzOiBpbXg4bXA6IGFkZCB2cHUgcGdjIG5vZGVzIikKPiA+ID4gTGluazoKPiA+ID4gU3VnZ2Vz
dGVkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KPiA+ID4gU2lnbmVk
LW9mZi1ieTogVml0b3IgU29hcmVzIDx2aXRvci5zb2FyZXNAdG9yYWRleC5jb20+Cj4gPiAKPiA+
IEZvciBWUFUtTGVzcyA4TVAsIGFsbCB0aGUgVlBVIFBHQyBub2RlcyBzaG91bGQgYmUgZHJvcHBl
ZCwKPiA+IHJpZ2h0Pwo+IAo+IFRoZXkgZG9uJ3QgbmVlZCB0byBiZSBkcm9wcGVkLiBUYWtpbmcg
dGhlIGlNWDhNTSBMaXRlIHZhcmlhbnRlIGFzIGV4YW1wbGUgKGl0Cj4gYWxzbyBkb2Vzbid0IGhh
dmUgVlBVKSwgdGhlIG5vZGVzIGFyZSB0aGVyZSBhbmQgdGhpcyBpc3N1ZSBpcyBub3QgcHJlc2Vu
dC4KPiAKPiA+IAo+ID4gV2h5IG5vdCB1c2UgYm9vdGxvYWRlciB0byB1cGRhdGUgdGhlIGRldmlj
ZSB0cmVlIGJhc2VkIG9uIGZ1c2UKPiA+IHNldHRpbmdzPwo+IAo+IFdoaWxlIGZpeGluZyBWUFUg
YmxrLWN0cmwgc3VzcGVuZC9yZXN1bWUgZnVuY3Rpb25hbGl0eSwgSSByZWNlaXZlZCBmZWVkYmFj
awo+IHRoYXQKPiB0aGlzIFZQVSBHUEMgZGVwZW5kZW5jeSBpcyBpbmNvcnJlY3QgYW5kIGlzIHVw
IHRvIFZQVSBibGstY3RybCB0byBjb250cm9sIHRoZQo+IEdQQyBkb21haW5zLgoKWW91IGZpbmQg
aXQgaGVyZToKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2ZjZDZhY2MyNjhiODY0MjM3MWNm
Mjg5MTQ5YjJiMWMzZTkwYzdmNDUuY2FtZWxAcGVuZ3V0cm9uaXguZGUvCgoKUmVnYXJkcywKVml0
b3IgU29hcmVzCj4gQXMgd2UgZGlzYWJsZSB0aGUgVlBVIGJsay1jdHJsIG5vZGUgb24gdGhlIGJv
b3Rsb2FkZXIsIHJlbW92aW5nIHRoZSBkZXBlbmRlbmN5Cj4gc29sdmVzIHRoZSBpc3N1ZS4KPiAK
PiBSZWdhcmRzLAo+IFZpdG9yIFNvYXJlcwo+ID4gCj4gPiBSZWdhcmRzLAo+ID4gUGVuZy4KPiA+
IAo+ID4gPiAtLS0KPiA+ID4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAu
ZHRzaSB8IDMgLS0tCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCj4gPiA+
IAo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1w
LmR0c2kKPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQo+
ID4gPiBpbmRleCBiOTJhYmI1YTVjNTMuLjEyNTQ4MzM2YjczNiAxMDA2NDQKPiA+ID4gLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kKPiA+ID4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kKPiA+ID4gQEAgLTg4MiwyMSAr
ODgyLDE4IEBAIHBnY192cHVtaXg6IHBvd2VyLWRvbWFpbkAxOSB7Cj4gPiA+IAo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHBnY192cHVfZzE6IHBvd2VyLQo+ID4gPiBkb21haW5AMjAgewo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjcG93ZXItZG9tYWlu
LQo+ID4gPiBjZWxscyA9IDwwPjsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBwb3dlci1kb21haW5zID0KPiA+ID4gPCZwZ2NfdnB1bWl4PjsKPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0KPiA+ID4gPElNWDhNUF9QT1dF
Ul9ET01BSU5fVlBVX0cxPjsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY2xvY2tzID0gPCZjbGsKPiA+ID4gSU1YOE1QX0NMS19WUFVfRzFfUk9PVD47Cj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ID4gCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcGdjX3ZwdV9nMjogcG93ZXItCj4gPiA+IGRvbWFpbkAyMSB7Cj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNwb3dlci1kb21haW4tCj4gPiA+IGNlbGxz
ID0gPDA+Owo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBvd2Vy
LWRvbWFpbnMgPQo+ID4gPiA8JnBnY192cHVtaXg+Owo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPQo+ID4gPiA8SU1YOE1QX1BPV0VSX0RPTUFJTl9WUFVf
RzI+Owo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9ja3Mg
PSA8JmNsawo+ID4gPiBJTVg4TVBfQ0xLX1ZQVV9HMl9ST09UPjsKPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Owo+ID4gPiAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZ2NfdnB1
X3ZjODAwMGU6IHBvd2VyLQo+ID4gPiBkb21haW5AMjIgewo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjcG93ZXItZG9tYWluLQo+ID4gPiBjZWxscyA9IDwwPjsK
PiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwb3dlci1kb21haW5z
ID0KPiA+ID4gPCZwZ2NfdnB1bWl4PjsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmVnID0KPiA+ID4gPElNWDhNUF9QT1dFUl9ET01BSU5fVlBVX1ZDODAwMEU+
Owo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8
JmNsawo+ID4gPiBJTVg4TVBfQ0xLX1ZQVV9WQzhLRV9ST09UPjsKPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Owo+ID4gPiAtLQo+ID4gPiAyLjM0LjEKPiA+IAo+IAoK


