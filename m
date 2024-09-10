Return-Path: <linux-pm+bounces-13941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C372B9733CD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 12:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5524D1F253BA
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7B18FC86;
	Tue, 10 Sep 2024 10:31:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33919993B
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964294; cv=none; b=BOZ/TJpSF4J5QJPj2EZKsROiPur75OeYqlzERWrOrA9ina9bbd5DLvaKEDUKmZQE5boX4ZfkaCCY/2xbNqTZ2f51oonn6g1hq4F9B1seNsZYOvNzmOkY4EzpuulkeNWdwlQJK6wfqBlNsdv0XBGZuBjy8jcFkzPHk4GxpM4JMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964294; c=relaxed/simple;
	bh=4vgGAC2/MIbHxWOHPWCtphUS5HSOlyiqAWITBBfKWIY=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=fVoY15/vpa7xG/dS58HIoMEBXrdR04j6o4tIzXZ4sgnyKGybIXEQiVnsoeMZ4FVvjZQKmcCnq566cGrc786sljsXrf9DFHpFZQjezYir6NHuqxtD45t5M9bW1XUPOYI21ohrobDWyivA9U8i3R/uV53zc82Exszs8oYHc1msqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002116LT (unknown [10.12.96.22])
	by app2 (Coremail) with SMTP id TQJkCgAX2+TuH+Bm51AAAA--.813S2;
	Tue, 10 Sep 2024 18:31:10 +0800 (CST)
Date: Tue, 10 Sep 2024 18:31:10 +0800
From: "chenshuo@eswincomputing.com" <chenshuo@eswincomputing.com>
To: "Christian Loehle" <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, 
	"Lukasz Luba" <lukasz.luba@arm.com>
Subject: Re: Re: PM: EM: Question Potential Issue with EM and OPP Table in cpufreq ondemand Governor
References: <202409101046414978042@eswincomputing.com>, 
	<f4478146-88d3-445c-8676-7246bf477c50@arm.com>
X-Priority: 3
X-GUID: 098C96DB-22FF-4AFB-AEA2-EB8A61AB7659
X-Has-Attach: no
X-Mailer: Foxmail 7.2.15.80[cn]
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202409101831099346787@eswincomputing.com>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID:TQJkCgAX2+TuH+Bm51AAAA--.813S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary5CryUKw17AF4ruw1rJFb_yoWxGF15pF
	s8Jayj9w4vvr45Zw15tF10kr4Y9an8ZF15Gr1DKry8A3yS9ryqgF1qqF1Dta48Cr18Zw1x
	Zw4jvFyvvw1DCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Pk9uIDkvMTAvMjQgMDM6NDYsIGNoZW5zaHVvQGVzd2luY29tcHV0aW5nLmNvbSB3cm90ZToKPj4g
SGkgUmFmYWVsLAo+wqAKPigrQ0MgTHVrYXN6KQo+wqAKPj4KPj4gSSBhbSBlbmNvdW50ZXJpbmcg
YW4gaXNzdWUgcmVsYXRlZCB0byB0aGUgRW5lcmd5IE1vZGVsIChFTSkgd2hlbiB1c2luZyBjcHVm
cmVxIHdpdGggdGhlIG9uZGVtYW5kIGdvdmVybm9yLiBCZWxvdyBpcyBhIGRldGFpbGVkIGRlc2Ny
aXB0aW9uOgo+Pgo+PiAxLiBQcm9ibGVtIERlc2NyaXB0aW9uOgo+PiDCoCDCoFdoZW4gdXNpbmcg
Y3B1ZnJlcSB3aXRoIHRoZSBvbmRlbWFuZCBnb3Zlcm5vciBhbmQgZW5hYmxpbmcgdGhlIGVuZXJn
eSBtb2RlbCAoRU0pLCB0aGUgQ1BVIE9QUCB0YWJsZSBpcyBjb25maWd1cmVkIHdpdGggZnJlcXVl
bmNpZXMgYW5kIHZvbHRhZ2VzIGZvciBlYWNoIGZyZXF1ZW5jeSBwb2ludC4gQWRkaXRpb25hbGx5
LCB0aGUgYGR5bmFtaWMtcG93ZXItY29lZmZpY2llbnRgIGlzIGNvbmZpZ3VyZWQgaW4gdGhlIERU
UyB1bmRlciB0aGUgQ1BVIG5vZGUuIEhvd2V2ZXIsIEkgb2JzZXJ2ZSBhYm5vcm1hbCBkeW5hbWlj
IGZyZXF1ZW5jeSBzY2FsaW5nLCB3aGVyZSB0aGUgQ1BVIGZyZXF1ZW5jeSBhbHdheXMgc3RheXMg
YXQgdGhlIGhpZ2hlc3QgZnJlcXVlbmN5IHBvaW50IGluIHRoZSBPUFAgdGFibGUuIEJlbG93IGlz
IGFuIGV4YW1wbGUgb2YgdGhlIERUUyBjb25maWd1cmF0aW9uOgo+PiBgYGAKPj4gY3B1MDogY3B1
QDDCoAo+PiB7wqAKPj4gLi4uCj4+IG9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmQwX2NwdV9vcHBf
dGFibGU+O8KgCj7CoAo+RG8geW91IG1pbmQgc2hhcmluZyA8JmQwX2NwdV9vcHBfdGFibGU+Pwo+
wqAKT2YgY291cnNlLCB0aGUgZW50aXJlIERUUyBmaWxlIGlzIGluY29udmVuaWVudCB0byBjb3B5
LCB0aGUgbWFpbiB1c2VmdWwgc2VnbWVudHMgSSBoYXZlIGFyZToKYGBgCglkMF9jcHVfb3BwX3Rh
YmxlOiBvcHAtdGFibGUwIHsKCQljb21wYXRpYmxlID0gIm9wZXJhdGluZy1wb2ludHMtdjIiOwoJ
CW9wcC1zaGFyZWQ7CgoJCW9wcC0yNDAwMDAwMCB7CgkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8Q0xL
X0ZSRVFfMjRNPjsKCQkJb3BwLW1pY3Jvdm9sdCA9IDw4MDAwMDA+OwoJCQljbG9jay1sYXRlbmN5
LW5zID0gPDcwMDAwPjsKCQl9OwoJCW9wcC0xMDAwMDAwMDAgewoJCQlvcHAtaHogPSAvYml0cy8g
NjQgPENMS19GUkVRXzEwME0+OwoJCQlvcHAtbWljcm92b2x0ID0gPDgwMDAwMD47CgkJCWNsb2Nr
LWxhdGVuY3ktbnMgPSA8NzAwMDA+OwoJCX07CgkJb3BwLTIwMDAwMDAwMCB7CgkJCW9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfMjAwTT47CgkJCW9wcC1taWNyb3ZvbHQgPSA8ODAwMDAwPjsK
CQkJY2xvY2stbGF0ZW5jeS1ucyA9IDw3MDAwMD47CgkJfTsKCQlvcHAtNDAwMDAwMDAwIHsKCQkJ
b3BwLWh6ID0gL2JpdHMvIDY0IDxDTEtfRlJFUV80MDBNPjsKCQkJb3BwLW1pY3Jvdm9sdCA9IDw4
MDAwMDA+OwoJCQljbG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKCQl9OwoJCW9wcC01MDAwMDAw
MDAgewoJCQlvcHAtaHogPSAvYml0cy8gNjQgPENMS19GUkVRXzUwME0+OwoJCQlvcHAtbWljcm92
b2x0ID0gPDgwMDAwMD47CgkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8NzAwMDA+OwoJCX07CgkJb3Bw
LTYwMDAwMDAwMCB7CgkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfNjAwTT47CgkJCW9w
cC1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKCQkJY2xvY2stbGF0ZW5jeS1ucyA9IDw3MDAwMD47CgkJ
fTsKCQlvcHAtNzAwMDAwMDAwIHsKCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDxDTEtfRlJFUV83MDBN
PjsKCQkJb3BwLW1pY3Jvdm9sdCA9IDw4MDAwMDA+OwoJCQljbG9jay1sYXRlbmN5LW5zID0gPDcw
MDAwPjsKCQl9OwoJCW9wcC04MDAwMDAwMDAgewoJCQlvcHAtaHogPSAvYml0cy8gNjQgPENMS19G
UkVRXzgwME0+OwoJCQlvcHAtbWljcm92b2x0ID0gPDgwMDAwMD47CgkJCWNsb2NrLWxhdGVuY3kt
bnMgPSA8NzAwMDA+OwoJCX07CgkJb3BwLTkwMDAwMDAwMCB7CgkJCW9wcC1oeiA9IC9iaXRzLyA2
NCA8Q0xLX0ZSRVFfOTAwTT47CgkJCW9wcC1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKCQkJY2xvY2st
bGF0ZW5jeS1ucyA9IDw3MDAwMD47CgkJfTsKCQlvcHAtMTAwMDAwMDAwMCB7CgkJCW9wcC1oeiA9
IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfMTAwME0+OwoJCQlvcHAtbWljcm92b2x0ID0gPDgwMDAwMD47
CgkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8NzAwMDA+OwoJCX07CgkJb3BwLTEyMDAwMDAwMDAgewoJ
CQlvcHAtaHogPSAvYml0cy8gNjQgPENMS19GUkVRXzEyMDBNPjsKCQkJb3BwLW1pY3Jvdm9sdCA9
IDw4MDAwMDA+OwoJCQljbG9jay1sYXRlbmN5LW5zID0gPDcwMDAwPjsKCQl9OwoJCW9wcC0xMzAw
MDAwMDAwIHsKCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDxDTEtfRlJFUV8xMzAwTT47CgkJCW9wcC1t
aWNyb3ZvbHQgPSA8ODAwMDAwPjsKCQkJY2xvY2stbGF0ZW5jeS1ucyA9IDw3MDAwMD47CgkJfTsK
CQlvcHAtMTQwMDAwMDAwMCB7CgkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8Q0xLX0ZSRVFfMTQwME0+
OwoJCQlvcHAtbWljcm92b2x0ID0gPDgwMDAwMD47CgkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8NzAw
MDA+OwoJCX07Cgl9OwouLi4JCglDNjQ6IGNwdXMgewoJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJ
CSNzaXplLWNlbGxzID0gPDA+OwoJCXRpbWViYXNlLWZyZXF1ZW5jeSA9IDxSVENDTEtfRlJFUT47
CgkJY3B1MDogY3B1QDAgewoJCQkuLi4KCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmZDBfY3B1
X29wcF90YWJsZT47CgkJCSNjb29saW5nLWNlbGxzID0gPDI+OwoJCQlkeW5hbWljLXBvd2VyLWNv
ZWZmaWNpZW50ID0gPDIwMDA+O8KgCgkJCUMxOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7CgkJCQkj
aW50ZXJydXB0LWNlbGxzID0gPDE+OwoJCQkJY29tcGF0aWJsZSA9ICJyaXNjdixjcHUtaW50YyI7
CgkJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsKCQkJfTsKCQl9OwoJCWNwdTE6IGNwdUAxIHsKCQkJ
Li4uCgkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmQwX2NwdV9vcHBfdGFibGU+OwoJCQkjY29v
bGluZy1jZWxscyA9IDwyPjsKCQkJZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9IDwyMDAwPjsK
CQkJQzI6IGludGVycnVwdC1jb250cm9sbGVyIHsKCQkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47
CgkJCQljb21wYXRpYmxlID0gInJpc2N2LGNwdS1pbnRjIjsKCQkJCWludGVycnVwdC1jb250cm9s
bGVyOwoJCQl9OwoJCX07CQoJCWNwdTI6IGNwdUAyIHsKCQkJLi4uCgkJCW9wZXJhdGluZy1wb2lu
dHMtdjIgPSA8JmQwX2NwdV9vcHBfdGFibGU+OwoJCQkjY29vbGluZy1jZWxscyA9IDwyPjsKCQkJ
ZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9IDwyMDAwPjsKCQkJQzM6IGludGVycnVwdC1jb250
cm9sbGVyIHsKCQkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47CgkJCQljb21wYXRpYmxlID0gInJp
c2N2LGNwdS1pbnRjIjsKCQkJCWludGVycnVwdC1jb250cm9sbGVyOwoJCQl9OwoJCX07CQoJCWNw
dTM6IGNwdUAzIHsKCQkJLi4uCgkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmQwX2NwdV9vcHBf
dGFibGU+OwoJCQkjY29vbGluZy1jZWxscyA9IDwyPjsKCQkJZHluYW1pYy1wb3dlci1jb2VmZmlj
aWVudCA9IDwyMDAwPjsKCQkJQzQ6IGludGVycnVwdC1jb250cm9sbGVyIHsKCQkJCSNpbnRlcnJ1
cHQtY2VsbHMgPSA8MT47CgkJCQljb21wYXRpYmxlID0gInJpc2N2LGNwdS1pbnRjIjsKCQkJCWlu
dGVycnVwdC1jb250cm9sbGVyOwoJCQl9OwoJCX07CQkKCX07CQkKYGBgCj4+ICNjb29saW5nLWNl
bGxzID0gPDI+OyBkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDIwMDA+OyB9Owo+PiAuLi4K
Pj4gYGBgCj4+IDIuIFJvb3QgQ2F1c2UgQW5hbHlzaXM6Cj4+IFdoZW4gdXNpbmcgdGhlIE9QUCB0
YWJsZSBhbmQgY29uZmlndXJpbmcgdGhlICJkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50LCIgdGhl
IGBlbV9kZXZfcmVnaXN0ZXJfcGVyZl9kb21haW4oKWAgZnVuY3Rpb24gaW4gYGtlcm5lbC9wb3dl
ci9lbmVyZ3lfbW9kZWwuY2Agc2V0cyB0aGUgZmxhZ3MgdG8gYEVNX1BFUkZfRE9NQUlOX01JQ1JP
V0FUVFNgLiBJbiB0aGUgYGVtX2NyZWF0ZV9wZXJmX3RhYmxlKClgIGZ1bmN0aW9uLCBgZW1fY29t
cHV0ZV9jb3N0cygpYCBpbmNsdWRlcyB0aGUgZm9sbG93aW5nIGNvZGU6Cj4+IGBgYAo+PiBpZiAo
dGFibGVbaV0uY29zdCA+PSBwcmV2X2Nvc3QpIHsKPj4gwqAgwqAgdGFibGVbaV0uZmxhZ3MgPSBF
TV9QRVJGX1NUQVRFX0lORUZGSUNJRU5UOwo+PiDCoCDCoCBkZXZfZGJnKGRldiwgIkVNOiBPUFA6
JWx1IGlzIGluZWZmaWNpZW50XG4iLCB0YWJsZVtpXS5mcmVxdWVuY3kpOwo+PiB9Cj4+IGBgYAo+
PiBTaW5jZSB0aGUgY29zdCBpcyBjYWxjdWxhdGVkIGFzIHBvd2VyICogbWF4X2ZyZXF1ZW5jeSAv
IGZyZXF1ZW5jeSwgdGhlIGNvc3QgZm9yIGVhY2ggZnJlcXVlbmN5IHBvaW50IGJlY29tZXMgYSBj
b25zdGFudCB2YWx1ZS4gQ29uc2VxdWVudGx5LCBleGNlcHQgZm9yIG5yX3N0YXRlcyAtIDEgKHdo
ZXJlIHByZXZfc3RhdGUgaXMgaW5pdGlhbGl6ZWQgYXMgVUxPTkdfTUFYKSwgYWxsIG90aGVyIGZy
ZXF1ZW5jeSBwb2ludHMnIGNvc3QgaXMgZXF1YWwgdG8gcHJldl9jb3N0LiBBcyBhIHJlc3VsdCwg
b25seSB0aGUgaGlnaGVzdCBmcmVxdWVuY3kgcG9pbnQgKHRhYmxlW25yX3N0YXRlcyAtIDFdKSBp
cyBub3QgZmxhZ2dlZCBhcyBFTV9QRVJGX1NUQVRFX0lORUZGSUNJRU5UIGluIHRoZSBFTSBwZXJm
b3JtYW5jZSB0YWJsZS4KPj4KPj4gSW4gdGhlIGVtX2NwdWZyZXFfdXBkYXRlX2VmZmljaWVuY2ll
cygpIGZ1bmN0aW9uLCB0aGUgZm9sbG93aW5nIGNvZGUgaXMgZXhlY3V0ZWQ6Cj4+IGBgYAo+PiBm
b3IgKGkgPSAwOyBpIDwgcGQtPm5yX3BlcmZfc3RhdGVzOyBpKyspIHsKPj4gwqAgwqAgaWYgKCEo
dGFibGVbaV0uZmxhZ3MgJiBFTV9QRVJGX1NUQVRFX0lORUZGSUNJRU5UKSkKPj4gwqAgwqAgwqAg
wqAgY29udGludWU7Cj4+Cj4+IMKgIMKgIGlmICghY3B1ZnJlcV90YWJsZV9zZXRfaW5lZmZpY2ll
bnQocG9saWN5LCB0YWJsZVtpXS5mcmVxdWVuY3kpKQo+PiDCoCDCoCDCoCDCoCBmb3VuZCsrOwo+
PiB9Cj4+IGBgYAo+PiBBcyBhIHJlc3VsdCwgYWxsIGZyZXF1ZW5jeSBwb2ludHMgbWFya2VkIGFz
IEVNX1BFUkZfU1RBVEVfSU5FRkZJQ0lFTlQgYXJlIGZsYWdnZWQgYXMgQ1BVRlJFUV9JTkVGRklD
SUVOVF9GUkVRIGluIHRoZSBjcHVmcmVxX3RhYmxlX3NldF9pbmVmZmljaWVudCgpIGZ1bmN0aW9u
LCBjYXVzaW5nIHRoZXNlIGZyZXF1ZW5jaWVzIHRvIGJlIHNraXBwZWQgZHVyaW5nIGZyZXF1ZW5j
eSBzY2FsaW5nLgo+Pgo+PiAzLiBQcm9wb3NlZCBDaGFuZ2UgYW5kIFRlc3Rpbmc6wqAKPj4gT24g
TGludXggNi42LCB0aGlzIGJlaGF2aW9yIGFmZmVjdHMgdGhlIG5vcm1hbCBvcGVyYXRpb24gb2Yg
dGhlIGNwdWZyZXEgb25kZW1hbmQgZ292ZXJub3IsIHdoaWNoIGluIHR1cm4gY2F1c2VzIHBhc3Np
dmUgY29vbGluZyBkZXZpY2VzIHRvIG1hbGZ1bmN0aW9uIHdoZW4gdXNpbmcgdGhlIHBvd2VyIGFs
bG9jYXRvciBzdHJhdGVneSBpbiB0aGUgdGhlcm1hbCBmcmFtZXdvcmsuIEkgbWFkZSBhIHRlbXBv
cmFyeSBmaXggYnkgY2hhbmdpbmcgdGhlIGNvbmRpdGlvbiBmcm9tOgo+PiBpZiAodGFibGVbaV0u
Y29zdCA+PSBwcmV2X2Nvc3QpCj4+IHRvOgo+PiBpZiAodGFibGVbaV0uY29zdCA+IHByZXZfY29z
dCkKPj4gQWZ0ZXIgdGhpcyBjaGFuZ2UsIHRoZSBpc3N1ZSBzZWVtcyByZXNvbHZlZCBmb3Igbm93
LiBIb3dldmVyLCBJIGFtIGNvbmNlcm5lZCBhYm91dCBwb3RlbnRpYWwgc2lkZSBlZmZlY3RzIG9m
IHRoaXMgbW9kaWZpY2F0aW9uLgo+wqAKPkJ1dCB0aGlzIGRvZXNuJ3Qgc29sdmUgdGhlIGFjdHVh
bCBpc3N1ZSwgaWYgY29zdCA9PSBwcmV2X2Nvc3QgZm9yIGFsbAo+T1BQcyB0aGVuIGFsbCBvZiB0
aGVtIGJ1dCBvbmUgYXJlIGluZGVlZCBpbmVmZmljaWVudC4KRGVzcGl0ZSB0aGlzLCB1bmRlciBh
biBvbmRlbWFuZCBwb2xpY3kgYmFzZWQgb24gRFZGUywgdGhlIHNvZnR3YXJlIG1pZ2h0IG5vdCBr
bm93IHRoZSByZWFsIHBvd2VyIGNvbnN1bXB0aW9uLCBhbmQgY2FuIG9ubHkgdXNlIHRoZSBmb3Jt
dWxhIFA9QypWXjIqZip1c2FnZV9yYXRlLgpBZGRpdGlvbmFsbHksIHRoaXMgYXQgbGVhc3QgZW5z
dXJlcyB0aGF0IHRoZSB0aGVybWFsIGZyYW1ld29yayB1c2luZyB0aGUgSVBBIHN0cmF0ZWd5IGNh
biBwcm9wZXJseSBjb29sIGRvd24u


