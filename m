Return-Path: <linux-pm+bounces-11755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04621942F93
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD67228A15E
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81EC1B29D8;
	Wed, 31 Jul 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="psCgaXB5"
X-Original-To: linux-pm@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065C1AB52C;
	Wed, 31 Jul 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430747; cv=none; b=sT/H/f9ieDYOSdGw203iuAztmPencGNFeUhoL2ouB63DiMhxf7utAS7++kV9RsGR/DYMThmEL3fTf8EpeegcZE4dQtAVcUDdfPjaFA+rzyzJtBoMWkcUK4WrGGloszC/J/Fo/MCm8qoWTSv4VYhMVFkfWtzJBI+QoJgO4qM37jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430747; c=relaxed/simple;
	bh=iSskvgHd2RV0PGf40AdW5HOVIBJ+OOv5C1Gm+PsLey8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=LebNN4MDuMvlZU+/MTiZkiFVHnPC+Z8ipykfZlYWyQGrh1xMDMIVUAEWp4GRo5RoxkQB7gfraKpClx4cbWvgZW+OoVCsy6tgIDteVtm25dpHO4uG8VRVA9LsZK78nQ6sDlCdu8fhdWjwvrrgUuj3uNiIqAVTRWvmLA5rZ4Q2ETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=psCgaXB5 reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=0h4LaQtBvmiVXs/Hf+P23R81FvK6xyzFgOO+MeKx4mk=; b=p
	sCgaXB540S9bk2RCFO1xY5k7RTkQBrGDTb2lojNxamDNLVAeWCR7JNRgg9LJE3gy
	ORUI0Lm7GlGQug9x1gxjOINkPiq1MznlRhxKruVctzCwnt2nwnig9NguYMQqL1Bu
	A1m/MiqNMgDfGybVXo3kyR0kSPCv4RGcLADwYXMhrs=
Received: from 00107082$163.com ( [111.35.189.52] ) by
 ajax-webmail-wmsvr-40-133 (Coremail) ; Wed, 31 Jul 2024 20:58:40 +0800
 (CST)
Date: Wed, 31 Jul 2024 20:58:40 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Gautham R.Shenoy" <gautham.shenoy@amd.com>
Cc: perry.yuan@amd.com, Alexander.Deucher@amd.com, Li.Meng@amd.com, 
	Mario.Limonciello@amd.com, Xiaojian.Du@amd.com, Xinmei.Huang@amd.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <87zfpxsweb.fsf@BLR-5CG11610CF.amd.com>
References: <20240730140111.4491-1-00107082@163.com>
 <87zfpxsweb.fsf@BLR-5CG11610CF.amd.com>
X-NTES-SC: AL_Qu2ZAPiYv08p5iWRZ+kXn0oTju85XMCzuv8j3YJeN500mSXt0QA9Y09JGEbrzsGEKAKMgCiOVDZp48NWcaB9f44c8JlJf7TLehw1lLTj9v3b
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f793cc8.a13d.19108df0a58.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v7QBNapmnHJvAA--.13654W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRctqmVOB4ulsQACsI
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksCgpBdCAyMDI0LTA3LTMxIDE4OjEyOjEyLCAiR2F1dGhhbSBSLlNoZW5veSIgPGdhdXRoYW0u
c2hlbm95QGFtZC5jb20+IHdyb3RlOgo+SGVsbG8gRGF2aWQsCj4KPkRhdmlkIFdhbmcgPDAwMTA3
MDgyQDE2My5jb20+IHdyaXRlczoKPgo+PiBIaSwKPj4KPj4gSSBub3RpY2Ugc29tZSBrZXJuZWwg
d2FybmluZyBhbmQgZXJyb3JzIHdoZW4gSSB1cGRhdGUgdG8gNi4xMS4wLXJjMToKPj4KPj4gIGtl
cm5lbDogWyAgICAxLjAyMjczOV0gYW1kX3BzdGF0ZTogVGhlIENQUEMgZmVhdHVyZSBpcyBzdXBw
b3J0ZWQgYnV0IGN1cnJlbnRseSBkaXNhYmxlZCBieSB0aGUgQklPUy4KPj4gIGtlcm5lbDogWyAg
ICAxLjAyMjczOV0gUGxlYXNlIGVuYWJsZSBpdCBpZiB5b3VyIEJJT1MgaGFzIHRoZSBDUFBDIG9w
dGlvbi4KPj4gIGtlcm5lbDogWyAgICAxLjA5ODA1NF0gYW1kX3BzdGF0ZTogbWluX2ZyZXEoMCkg
b3IgbWF4X2ZyZXEoMCkgb3Igbm9taW5hbF9mcmVxKDApIHZhbHVlIGlzIGluY29ycmVjdAo+PiAg
a2VybmVsOiBbICAgIDEuMTEwMDU4XSBhbWRfcHN0YXRlOiBtaW5fZnJlcSgwKSBvciBtYXhfZnJl
cSgwKSBvciBub21pbmFsX2ZyZXEoMCkgdmFsdWUgaXMgaW5jb3JyZWN0Cj4+ICBrZXJuZWw6IFsg
ICAgMS4xMjIwNTddIGFtZF9wc3RhdGU6IG1pbl9mcmVxKDApIG9yIG1heF9mcmVxKDApIG9yIG5v
bWluYWxfZnJlcSgwKSB2YWx1ZSBpcyBpbmNvcnJlY3QKPj4gIGtlcm5lbDogWyAgICAxLjEzNDA2
Ml0gYW1kX3BzdGF0ZTogbWluX2ZyZXEoMCkgb3IgbWF4X2ZyZXEoMCkgb3Igbm9taW5hbF9mcmVx
KDApIHZhbHVlIGlzIGluY29ycmVjdAo+PiAga2VybmVsOiBbICAgIDEuMTM0NjQxXSBhbWRfcHN0
YXRlOiBtaW5fZnJlcSgwKSBvciBtYXhfZnJlcSgwKSBvciBub21pbmFsX2ZyZXEoMCkgdmFsdWUg
aXMgaW5jb3JyZWN0Cj4+ICBrZXJuZWw6IFsgICAgMS4xMzUxMjhdIGFtZF9wc3RhdGU6IG1pbl9m
cmVxKDApIG9yIG1heF9mcmVxKDApIG9yIG5vbWluYWxfZnJlcSgwKSB2YWx1ZSBpcyBpbmNvcnJl
Y3QKPj4gIGtlcm5lbDogWyAgICAxLjEzNTY5M10gYW1kX3BzdGF0ZTogbWluX2ZyZXEoMCkgb3Ig
bWF4X2ZyZXEoMCkgb3Igbm9taW5hbF9mcmVxKDApIHZhbHVlIGlzIGluY29ycmVjdAo+PiAga2Vy
bmVsOiBbICAgIDEuMTM2MzcxXSBhbWRfcHN0YXRlOiBtaW5fZnJlcSgwKSBvciBtYXhfZnJlcSgw
KSBvciBub21pbmFsX2ZyZXEoMCkgdmFsdWUgaXMgaW5jb3JyZWN0Cj4+ICBrZXJuZWw6IFsgICAg
MS4xMzYzOTBdIGFtZF9wc3RhdGU6IGZhaWxlZCB0byByZWdpc3RlciB3aXRoIHJldHVybiAtMTkK
Pj4gIGtlcm5lbDogWyAgICAxLjEzODQxMF0gbGVkdHJpZy1jcHU6IHJlZ2lzdGVyZWQgdG8gaW5k
aWNhdGUgYWN0aXZpdHkgb24gQ1BVcwo+Pgo+Pgo+PiBUaG9zZSB3YXJuaW5nIG1lc3NhZ2Ugd2Fz
IGludHJvZHVjZWQgYnkgY29tbWl0Ogo+PiAgYmZmN2QxM2MxOTBhZDk4Y2Y0Zjg3NzE4OWIwMjJj
NzVkZjRjYjM4MyAoImNwdWZyZXE6IGFtZC1wc3RhdGU6IGFkZCBkZWJ1ZyBtZXNzYWdlIHdoaWxl
IENQUEMgaXMgc3VwcG9ydGVkIGFuZCBkaXNhYmxlZCBieSBTQklPUykKPj4gLCB3aGljaCBtYWtl
IHNlbnNlLgo+Cj4KPklmIENQUEMgaXMgZGlzYWJlZCBpbiB0aGUgQklPUywgdGhlbiB0aGUgX0NQ
QyBvYmplY3RzIHNob3VsZG4ndCBoYXZlCj5iZWVuIGNyZWF0ZWQuIEFuZCB0aGUgZXJyb3IgbWVz
c2FnZSB0aGF0IHlvdSBzaG91bGQgaGF2ZSBzZWVuIGlzCj4idGhlIF9DUEMgb2JqZWN0IGlzIG5v
dCBwcmVzZW50IGluIFNCSU9TIG9yIEFDUEkgZGlzYWJsZWQiLgo+Cj4KPkNvdWxkIHlvdSBwbGVh
c2Ugc2hhcmUgdGhlIGZhbWlseSBhbmQgbW9kZWwgbnVtYmVyIG9mIHRoZSBwbGF0Zm9ybSB3aGVy
ZQo+eW91IGFyZSBvYnNlcnZpbmcgdGhpcyA/CgpNeSBgY2F0IC9wcm9jL2NwdWluZm9gIHNob3dz
IHNvbWV0aGluZyBhcyBmb2xsb3dpbmc6CnByb2Nlc3Nvcgk6IDAKdmVuZG9yX2lkCTogQXV0aGVu
dGljQU1ECmNwdSBmYW1pbHkJOiAyMwptb2RlbAkJOiAxMTMKbW9kZWwgbmFtZQk6IEFNRCBSeXpl
biAzIDMxMDAgNC1Db3JlIFByb2Nlc3NvcgpzdGVwcGluZwk6IDAKbWljcm9jb2RlCTogMHg4NzAx
MDIxCmNwdSBNSHoJCTogMzYwMC4wMDAKY2FjaGUgc2l6ZQk6IDUxMiBLQgpwaHlzaWNhbCBpZAk6
IDAKc2libGluZ3MJOiA4CmNvcmUgaWQJCTogMApjcHUgY29yZXMJOiA0CmFwaWNpZAkJOiAwCmlu
aXRpYWwgYXBpY2lkCTogMApmcHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2
ZWwJOiAxNgp3cAkJOiB5ZXMKZmxhZ3MJCTogZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNl
IGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHVzaCBtbXggZnhz
ciBzc2Ugc3NlMiBodCBzeXNjYWxsIG54IG1teGV4dCBmeHNyX29wdCBwZHBlMWdiIHJkdHNjcCBs
bSBjb25zdGFudF90c2MgcmVwX2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90c2MgY3B1aWQg
ZXh0ZF9hcGljaWQgYXBlcmZtcGVyZiByYXBsIHBuaSBwY2xtdWxxZHEgbW9uaXRvciBzc3NlMyBm
bWEgY3gxNiBzc2U0XzEgc3NlNF8yIG1vdmJlIHBvcGNudCBhZXMgeHNhdmUgYXZ4IGYxNmMgcmRy
YW5kIGxhaGZfbG0gY21wX2xlZ2FjeSBzdm0gZXh0YXBpYyBjcjhfbGVnYWN5IGFibSBzc2U0YSBt
aXNhbGlnbnNzZSAzZG5vd3ByZWZldGNoIG9zdncgaWJzIHNraW5pdCB3ZHQgdGNlIHRvcG9leHQg
cGVyZmN0cl9jb3JlIHBlcmZjdHJfbmIgYnBleHQgcGVyZmN0cl9sbGMgbXdhaXR4IGNwYiBjYXRf
bDMgY2RwX2wzIGh3X3BzdGF0ZSBzc2JkIG1iYSBpYnBiIHN0aWJwIHZtbWNhbGwgZnNnc2Jhc2Ug
Ym1pMSBhdngyIHNtZXAgYm1pMiBjcW0gcmR0X2EgcmRzZWVkIGFkeCBzbWFwIGNsZmx1c2hvcHQg
Y2x3YiBzaGFfbmkgeHNhdmVvcHQgeHNhdmVjIHhnZXRidjEgY3FtX2xsYyBjcW1fb2NjdXBfbGxj
IGNxbV9tYm1fdG90YWwgY3FtX21ibV9sb2NhbCBjbHplcm8gaXJwZXJmIHhzYXZlZXJwdHIgcmRw
cnUgd2Jub2ludmQgYXJhdCBucHQgbGJydiBzdm1fbG9jayBucmlwX3NhdmUgdHNjX3NjYWxlIHZt
Y2JfY2xlYW4gZmx1c2hieWFzaWQgZGVjb2RlYXNzaXN0cyBwYXVzZWZpbHRlciBwZnRocmVzaG9s
ZCBhdmljIHZfdm1zYXZlX3ZtbG9hZCB2Z2lmIHZfc3BlY19jdHJsIHVtaXAgcmRwaWQgb3ZlcmZs
b3dfcmVjb3Ygc3VjY29yIHNtY2Egc2V2IHNldl9lcwpidWdzCQk6IHN5c3JldF9zc19hdHRycyBz
cGVjdHJlX3YxIHNwZWN0cmVfdjIgc3BlY19zdG9yZV9ieXBhc3MgcmV0YmxlZWQgc210X3JzYiBz
cnNvCmJvZ29taXBzCTogNzE5OS45NQpUTEIgc2l6ZQk6IDMwNzIgNEsgcGFnZXMKY2xmbHVzaCBz
aXplCTogNjQKY2FjaGVfYWxpZ25tZW50CTogNjQKYWRkcmVzcyBzaXplcwk6IDQzIGJpdHMgcGh5
c2ljYWwsIDQ4IGJpdHMgdmlydHVhbApwb3dlciBtYW5hZ2VtZW50OiB0cyB0dHAgdG0gaHdwc3Rh
dGUgY3BiIGVmZl9mcmVxX3JvIFsxM10gWzE0XQoKCgoKPgo+LS0KPlRoYW5rcyBhbmQgUmVnYXJk
cwo+Z2F1dGhhbS4KCgo=

