Return-Path: <linux-pm+bounces-14386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4CB97B80C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 08:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E491F22071
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 06:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12B8169AE6;
	Wed, 18 Sep 2024 06:41:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net (zg8tmtu5ljy1ljeznc42.icoremail.net [159.65.134.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B34405
	for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2024 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.65.134.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726641692; cv=none; b=LL8scvXi9c5IZyFw0aEDsQhFKg9AwpJ7+fc5joU6uuJ+qq4y2ImVrpNsWxeQIb5yKHRLpGhymr+M9iWfXLvm+QaS9Liq/3A+RtHqG6jbZS+PW8YubIKvdeRW4xB2cHvjV3jWv1HkDqPkf8CBaNAtWF5E85zHpjYIZh7HPrR7jj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726641692; c=relaxed/simple;
	bh=1wUYZgONhMrXGOnHcVvgoVidTkq647QWSbH0Nn6ioM0=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=V1l477h6D3ycWWhlUea+GtD+ZGiShUTS1k/ZWTzDLL39SgF6evwoZsu6CwTNe4gmfw7ZVmqWX0G9w6QhogBnafgX8Sfo03Cm3NOCcKOa08NEVAraKt08qgIrmrvLbUXTP3T75ykfSRLNXNfP59fZl5hCIbIESDjo9fRK6P+dXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=159.65.134.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002116LT (unknown [10.12.96.22])
	by app2 (Coremail) with SMTP id TQJkCgAn6+QJdupmHfkBAA--.5344S2;
	Wed, 18 Sep 2024 14:41:14 +0800 (CST)
Date: Wed, 18 Sep 2024 14:41:14 +0800
From: "chenshuo@eswincomputing.com" <chenshuo@eswincomputing.com>
To: "Christian Loehle" <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, 
	"Lukasz Luba" <lukasz.luba@arm.com>
Subject: Re: Re: PM: EM: Question Potential Issue with EM and OPP Table in cpufreq ondemand Governor
References: <202409101046414978042@eswincomputing.com>, 
	<f4478146-88d3-445c-8676-7246bf477c50@arm.com>, 
	<202409101831099346787@eswincomputing.com>
X-Priority: 3
X-GUID: 13D3675E-3CE8-4B0E-84E0-A495E6B67410
X-Has-Attach: no
X-Mailer: Foxmail 7.2.15.80[cn]
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202409181441135658871@eswincomputing.com>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID:TQJkCgAn6+QJdupmHfkBAA--.5344S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr18Kw18Cry7ur1UtFWkWFg_yoWxAF18pF
	s8Xayj9rs29r1UZwn0qa4vkr4a9rsxZFWrur1qkryIy34SqryqgF1qqF1DK3y8CF18X34x
	Xr1Ygr929w1DC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAa7VCE64xvF2IEb7IF0Fy264xvF2IEb7IF0Fy264kE
	64k0F2IE7I0Y6sxI4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0V
	AYjxAxZF0Ex2IqxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UMVCEFcxC0VAY
	jxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IUeGZXDUUUUU==
X-CM-SenderInfo: xfkh02xkxrqvxvzl0uprps33xlqjhudrp/

Pj5PbiA5LzEwLzI0IDAzOjQ2LCBjaGVuc2h1b0Blc3dpbmNvbXB1dGluZy5jb20gd3JvdGU6Cj4+
PiBIaSBSYWZhZWwsCj4+wqAKPj4oK0NDIEx1a2FzeikKPj7CoAo+Pj4KPj4+IEkgYW0gZW5jb3Vu
dGVyaW5nIGFuIGlzc3VlIHJlbGF0ZWQgdG8gdGhlIEVuZXJneSBNb2RlbCAoRU0pIHdoZW4gdXNp
bmcgY3B1ZnJlcSB3aXRoIHRoZSBvbmRlbWFuZCBnb3Zlcm5vci4gQmVsb3cgaXMgYSBkZXRhaWxl
ZCBkZXNjcmlwdGlvbjoKPj4+Cj4+PiAxLiBQcm9ibGVtIERlc2NyaXB0aW9uOgo+Pj4gwqAgwqBX
aGVuIHVzaW5nIGNwdWZyZXEgd2l0aCB0aGUgb25kZW1hbmQgZ292ZXJub3IgYW5kIGVuYWJsaW5n
IHRoZSBlbmVyZ3kgbW9kZWwgKEVNKSwgdGhlIENQVSBPUFAgdGFibGUgaXMgY29uZmlndXJlZCB3
aXRoIGZyZXF1ZW5jaWVzIGFuZCB2b2x0YWdlcyBmb3IgZWFjaCBmcmVxdWVuY3kgcG9pbnQuIEFk
ZGl0aW9uYWxseSwgdGhlIGBkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50YCBpcyBjb25maWd1cmVk
IGluIHRoZSBEVFMgdW5kZXIgdGhlIENQVSBub2RlLiBIb3dldmVyLCBJIG9ic2VydmUgYWJub3Jt
YWwgZHluYW1pYyBmcmVxdWVuY3kgc2NhbGluZywgd2hlcmUgdGhlIENQVSBmcmVxdWVuY3kgYWx3
YXlzIHN0YXlzIGF0IHRoZSBoaWdoZXN0IGZyZXF1ZW5jeSBwb2ludCBpbiB0aGUgT1BQIHRhYmxl
LiBCZWxvdyBpcyBhbiBleGFtcGxlIG9mIHRoZSBEVFMgY29uZmlndXJhdGlvbjoKPj4+IGBgYAo+
Pj4gY3B1MDogY3B1QDDCoAo+Pj4ge8KgCj4+PiAuLi4KPj4+IG9wZXJhdGluZy1wb2ludHMtdjIg
PSA8JmQwX2NwdV9vcHBfdGFibGU+O8KgCj4+wqAKPj5EbyB5b3UgbWluZCBzaGFyaW5nIDwmZDBf
Y3B1X29wcF90YWJsZT4/Cj4+wqAKPk9mIGNvdXJzZSwgdGhlIGVudGlyZSBEVFMgZmlsZSBpcyBp
bmNvbnZlbmllbnQgdG8gY29weSwgdGhlIG1haW4gdXNlZnVsIHNlZ21lbnRzIEkgaGF2ZSBhcmU6
Cj5gYGAKPmQwX2NwdV9vcHBfdGFibGU6IG9wcC10YWJsZTAgewo+Y29tcGF0aWJsZSA9ICJvcGVy
YXRpbmctcG9pbnRzLXYyIjsKPm9wcC1zaGFyZWQ7Cj4KPm9wcC0yNDAwMDAwMCB7Cj5vcHAtaHog
PSAvYml0cy8gNjQgPENMS19GUkVRXzI0TT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAwMD47Cj5j
bG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtMTAwMDAwMDAwIHsKPm9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfMTAwTT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAwMD47Cj5j
bG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtMjAwMDAwMDAwIHsKPm9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfMjAwTT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAwMD47Cj5j
bG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtNDAwMDAwMDAwIHsKPm9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfNDAwTT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAwMD47Cj5j
bG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtNTAwMDAwMDAwIHsKPm9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfNTAwTT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAwMD47Cj5j
bG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtNjAwMDAwMDAwIHsKPm9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfNjAwTT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAwMD47Cj5j
bG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtNzAwMDAwMDAwIHsKPm9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfNzAwTT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAwMD47Cj5j
bG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtODAwMDAwMDAwIHsKPm9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfODAwTT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAwMD47Cj5j
bG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtOTAwMDAwMDAwIHsKPm9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfOTAwTT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAwMD47Cj5j
bG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtMTAwMDAwMDAwMCB7Cj5vcHAtaHog
PSAvYml0cy8gNjQgPENMS19GUkVRXzEwMDBNPjsKPm9wcC1taWNyb3ZvbHQgPSA8ODAwMDAwPjsK
PmNsb2NrLWxhdGVuY3ktbnMgPSA8NzAwMDA+Owo+fTsKPm9wcC0xMjAwMDAwMDAwIHsKPm9wcC1o
eiA9IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfMTIwME0+Owo+b3BwLW1pY3Jvdm9sdCA9IDw4MDAwMDA+
Owo+Y2xvY2stbGF0ZW5jeS1ucyA9IDw3MDAwMD47Cj59Owo+b3BwLTEzMDAwMDAwMDAgewo+b3Bw
LWh6ID0gL2JpdHMvIDY0IDxDTEtfRlJFUV8xMzAwTT47Cj5vcHAtbWljcm92b2x0ID0gPDgwMDAw
MD47Cj5jbG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKPn07Cj5vcHAtMTQwMDAwMDAwMCB7Cj5v
cHAtaHogPSAvYml0cy8gNjQgPENMS19GUkVRXzE0MDBNPjsKPm9wcC1taWNyb3ZvbHQgPSA8ODAw
MDAwPjsKPmNsb2NrLWxhdGVuY3ktbnMgPSA8NzAwMDA+Owo+fTsKPn07Cj4uLi4KPkM2NDogY3B1
cyB7Cj4jYWRkcmVzcy1jZWxscyA9IDwxPjsKPiNzaXplLWNlbGxzID0gPDA+Owo+dGltZWJhc2Ut
ZnJlcXVlbmN5ID0gPFJUQ0NMS19GUkVRPjsKPmNwdTA6IGNwdUAwIHsKPi4uLgo+b3BlcmF0aW5n
LXBvaW50cy12MiA9IDwmZDBfY3B1X29wcF90YWJsZT47Cj4jY29vbGluZy1jZWxscyA9IDwyPjsK
PmR5bmFtaWMtcG93ZXItY29lZmZpY2llbnQgPSA8MjAwMD47wqAKPkMxOiBpbnRlcnJ1cHQtY29u
dHJvbGxlciB7Cj4jaW50ZXJydXB0LWNlbGxzID0gPDE+Owo+Y29tcGF0aWJsZSA9ICJyaXNjdixj
cHUtaW50YyI7Cj5pbnRlcnJ1cHQtY29udHJvbGxlcjsKPn07Cj59Owo+Y3B1MTogY3B1QDEgewo+
Li4uCj5vcGVyYXRpbmctcG9pbnRzLXYyID0gPCZkMF9jcHVfb3BwX3RhYmxlPjsKPiNjb29saW5n
LWNlbGxzID0gPDI+Owo+ZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9IDwyMDAwPjsKPkMyOiBp
bnRlcnJ1cHQtY29udHJvbGxlciB7Cj4jaW50ZXJydXB0LWNlbGxzID0gPDE+Owo+Y29tcGF0aWJs
ZSA9ICJyaXNjdixjcHUtaW50YyI7Cj5pbnRlcnJ1cHQtY29udHJvbGxlcjsKPn07Cj59Owo+Y3B1
MjogY3B1QDIgewo+Li4uCj5vcGVyYXRpbmctcG9pbnRzLXYyID0gPCZkMF9jcHVfb3BwX3RhYmxl
PjsKPiNjb29saW5nLWNlbGxzID0gPDI+Owo+ZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9IDwy
MDAwPjsKPkMzOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7Cj4jaW50ZXJydXB0LWNlbGxzID0gPDE+
Owo+Y29tcGF0aWJsZSA9ICJyaXNjdixjcHUtaW50YyI7Cj5pbnRlcnJ1cHQtY29udHJvbGxlcjsK
Pn07Cj59Owo+Y3B1MzogY3B1QDMgewo+Li4uCj5vcGVyYXRpbmctcG9pbnRzLXYyID0gPCZkMF9j
cHVfb3BwX3RhYmxlPjsKPiNjb29saW5nLWNlbGxzID0gPDI+Owo+ZHluYW1pYy1wb3dlci1jb2Vm
ZmljaWVudCA9IDwyMDAwPjsKPkM0OiBpbnRlcnJ1cHQtY29udHJvbGxlciB7Cj4jaW50ZXJydXB0
LWNlbGxzID0gPDE+Owo+Y29tcGF0aWJsZSA9ICJyaXNjdixjcHUtaW50YyI7Cj5pbnRlcnJ1cHQt
Y29udHJvbGxlcjsKPn07Cj59Owo+fTsKPmBgYAo+Pj4gI2Nvb2xpbmctY2VsbHMgPSA8Mj47IGR5
bmFtaWMtcG93ZXItY29lZmZpY2llbnQgPSA8MjAwMD47IH07Cj4+PiAuLi4KPj4+IGBgYAo+Pj4g
Mi4gUm9vdCBDYXVzZSBBbmFseXNpczoKPj4+IFdoZW4gdXNpbmcgdGhlIE9QUCB0YWJsZSBhbmQg
Y29uZmlndXJpbmcgdGhlICJkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50LCIgdGhlIGBlbV9kZXZf
cmVnaXN0ZXJfcGVyZl9kb21haW4oKWAgZnVuY3Rpb24gaW4gYGtlcm5lbC9wb3dlci9lbmVyZ3lf
bW9kZWwuY2Agc2V0cyB0aGUgZmxhZ3MgdG8gYEVNX1BFUkZfRE9NQUlOX01JQ1JPV0FUVFNgLiBJ
biB0aGUgYGVtX2NyZWF0ZV9wZXJmX3RhYmxlKClgIGZ1bmN0aW9uLCBgZW1fY29tcHV0ZV9jb3N0
cygpYCBpbmNsdWRlcyB0aGUgZm9sbG93aW5nIGNvZGU6Cj4+PiBgYGAKPj4+IGlmICh0YWJsZVtp
XS5jb3N0ID49IHByZXZfY29zdCkgewo+Pj4gwqAgwqAgdGFibGVbaV0uZmxhZ3MgPSBFTV9QRVJG
X1NUQVRFX0lORUZGSUNJRU5UOwo+Pj4gwqAgwqAgZGV2X2RiZyhkZXYsICJFTTogT1BQOiVsdSBp
cyBpbmVmZmljaWVudFxuIiwgdGFibGVbaV0uZnJlcXVlbmN5KTsKPj4+IH0KPj4+IGBgYAo+Pj4g
U2luY2UgdGhlIGNvc3QgaXMgY2FsY3VsYXRlZCBhcyBwb3dlciAqIG1heF9mcmVxdWVuY3kgLyBm
cmVxdWVuY3ksIHRoZSBjb3N0IGZvciBlYWNoIGZyZXF1ZW5jeSBwb2ludCBiZWNvbWVzIGEgY29u
c3RhbnQgdmFsdWUuIENvbnNlcXVlbnRseSwgZXhjZXB0IGZvciBucl9zdGF0ZXMgLSAxICh3aGVy
ZSBwcmV2X3N0YXRlIGlzIGluaXRpYWxpemVkIGFzIFVMT05HX01BWCksIGFsbCBvdGhlciBmcmVx
dWVuY3kgcG9pbnRzJyBjb3N0IGlzIGVxdWFsIHRvIHByZXZfY29zdC4gQXMgYSByZXN1bHQsIG9u
bHkgdGhlIGhpZ2hlc3QgZnJlcXVlbmN5IHBvaW50ICh0YWJsZVtucl9zdGF0ZXMgLSAxXSkgaXMg
bm90IGZsYWdnZWQgYXMgRU1fUEVSRl9TVEFURV9JTkVGRklDSUVOVCBpbiB0aGUgRU0gcGVyZm9y
bWFuY2UgdGFibGUuCj4+Pgo+Pj4gSW4gdGhlIGVtX2NwdWZyZXFfdXBkYXRlX2VmZmljaWVuY2ll
cygpIGZ1bmN0aW9uLCB0aGUgZm9sbG93aW5nIGNvZGUgaXMgZXhlY3V0ZWQ6Cj4+PiBgYGAKPj4+
IGZvciAoaSA9IDA7IGkgPCBwZC0+bnJfcGVyZl9zdGF0ZXM7IGkrKykgewo+Pj4gwqAgwqAgaWYg
KCEodGFibGVbaV0uZmxhZ3MgJiBFTV9QRVJGX1NUQVRFX0lORUZGSUNJRU5UKSkKPj4+IMKgIMKg
IMKgIMKgIGNvbnRpbnVlOwo+Pj4KPj4+IMKgIMKgIGlmICghY3B1ZnJlcV90YWJsZV9zZXRfaW5l
ZmZpY2llbnQocG9saWN5LCB0YWJsZVtpXS5mcmVxdWVuY3kpKQo+Pj4gwqAgwqAgwqAgwqAgZm91
bmQrKzsKPj4+IH0KPj4+IGBgYAo+Pj4gQXMgYSByZXN1bHQsIGFsbCBmcmVxdWVuY3kgcG9pbnRz
IG1hcmtlZCBhcyBFTV9QRVJGX1NUQVRFX0lORUZGSUNJRU5UIGFyZSBmbGFnZ2VkIGFzIENQVUZS
RVFfSU5FRkZJQ0lFTlRfRlJFUSBpbiB0aGUgY3B1ZnJlcV90YWJsZV9zZXRfaW5lZmZpY2llbnQo
KSBmdW5jdGlvbiwgY2F1c2luZyB0aGVzZSBmcmVxdWVuY2llcyB0byBiZSBza2lwcGVkIGR1cmlu
ZyBmcmVxdWVuY3kgc2NhbGluZy4KPj4+Cj4+PiAzLiBQcm9wb3NlZCBDaGFuZ2UgYW5kIFRlc3Rp
bmc6wqAKPj4+IE9uIExpbnV4IDYuNiwgdGhpcyBiZWhhdmlvciBhZmZlY3RzIHRoZSBub3JtYWwg
b3BlcmF0aW9uIG9mIHRoZSBjcHVmcmVxIG9uZGVtYW5kIGdvdmVybm9yLCB3aGljaCBpbiB0dXJu
IGNhdXNlcyBwYXNzaXZlIGNvb2xpbmcgZGV2aWNlcyB0byBtYWxmdW5jdGlvbiB3aGVuIHVzaW5n
IHRoZSBwb3dlciBhbGxvY2F0b3Igc3RyYXRlZ3kgaW4gdGhlIHRoZXJtYWwgZnJhbWV3b3JrLiBJ
IG1hZGUgYSB0ZW1wb3JhcnkgZml4IGJ5IGNoYW5naW5nIHRoZSBjb25kaXRpb24gZnJvbToKPj4+
IGlmICh0YWJsZVtpXS5jb3N0ID49IHByZXZfY29zdCkKPj4+IHRvOgo+Pj4gaWYgKHRhYmxlW2ld
LmNvc3QgPiBwcmV2X2Nvc3QpCj4+PiBBZnRlciB0aGlzIGNoYW5nZSwgdGhlIGlzc3VlIHNlZW1z
IHJlc29sdmVkIGZvciBub3cuIEhvd2V2ZXIsIEkgYW0gY29uY2VybmVkIGFib3V0IHBvdGVudGlh
bCBzaWRlIGVmZmVjdHMgb2YgdGhpcyBtb2RpZmljYXRpb24uCj4+wqAKPj5CdXQgdGhpcyBkb2Vz
bid0IHNvbHZlIHRoZSBhY3R1YWwgaXNzdWUsIGlmIGNvc3QgPT0gcHJldl9jb3N0IGZvciBhbGwK
Pj5PUFBzIHRoZW4gYWxsIG9mIHRoZW0gYnV0IG9uZSBhcmUgaW5kZWVkIGluZWZmaWNpZW50Lgo+
RGVzcGl0ZSB0aGlzLCB1bmRlciBhbiBvbmRlbWFuZCBwb2xpY3kgYmFzZWQgb24gRFZGUywgdGhl
IHNvZnR3YXJlIG1pZ2h0IG5vdCBrbm93IHRoZSByZWFsIHBvd2VyIGNvbnN1bXB0aW9uLCBhbmQg
Y2FuIG9ubHkgdXNlIHRoZSBmb3JtdWxhIFA9QypWXjIqZip1c2FnZV9yYXRlLgo+QWRkaXRpb25h
bGx5LCB0aGlzIGF0IGxlYXN0IGVuc3VyZXMgdGhhdCB0aGUgdGhlcm1hbCBmcmFtZXdvcmsgdXNp
bmcgdGhlIElQQSBzdHJhdGVneSBjYW4gcHJvcGVybHkgY29vbCBkb3duLgpSZWdhcmRpbmcgdGhp
cyBwcm9ibGVtLCBhcmUgdGhlcmUgYW55IGVycm9ycyBvciBvbWlzc2lvbnMgaW4gbXkgc2V0dGlu
Z3M/IElmIG5vdCwgZG8geW91IGhhdmUgYW55IGJldHRlciBzb2x1dGlvbnM/IExvb2tpbmcgZm9y
d2FyZCB0byB5b3VyIHJlcGx5IQ==


