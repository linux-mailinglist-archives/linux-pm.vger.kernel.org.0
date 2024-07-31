Return-Path: <linux-pm+bounces-11732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F969942520
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 05:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3B0B22426
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 03:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402017BA9;
	Wed, 31 Jul 2024 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="E7Cf+K8a"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6834E18030;
	Wed, 31 Jul 2024 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397167; cv=none; b=PVENOHlGW5Dsr1x5Xi4mQDo8dPeIx3qtHWJ0MKXOuZOiOFRObqEkt/BBcu8ZmPlRVCgiilmHU3PubT+F0LGPQRT5Fp13m9J33z9eu0wBy6u68Q+IiX1yDB7EJauM6tuqOCYsamtjMDIYruXyWOk5meJwQ4ZxDzP6pOOtBzPvy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397167; c=relaxed/simple;
	bh=k1aVVA4fkCfACgId/oJAAqT+3aUaHVcEmCpVl7jk5vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=E8GnjkTZAKhfVckAuPQohXwqLkwxDSv1gVLaKK5ytcw45JsNPUuZ5lt7c9qf9OrMWpVRyCSrXQVGAwBOgT+9quI3PlS4q4Vbi2h/H4DYmfsCJi2miVfKdYNETgqupfMXiwa90CZ1sI9h1r5kfVAIBWbOAxgKxW+FpO9OdX7HEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=E7Cf+K8a reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=4oQ0aerFcngPb6L9SiGSAUHGOkYMJOzgScj4i4nIdKs=; b=E
	7Cf+K8aTNlZhev55A1+QNyZyHY0JtAdr7NqtgIXY5R8rw8csieMneSqHMtFkhVwV
	C8GXgj3GfG5OBBJn8n7ehqFx+UcT/kdCbMvhYQ/qU5CutcFxsVAKEbVcrR65kS0F
	MYRRBpqRggFeuIaglbenEWrziiCFz4U67FBM9rL6AE=
Received: from 00107082$163.com ( [111.35.189.52] ) by
 ajax-webmail-wmsvr-40-141 (Coremail) ; Wed, 31 Jul 2024 11:39:00 +0800
 (CST)
Date: Wed, 31 Jul 2024 11:39:00 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Xiaojian Du" <xiaojidu@amd.com>
Cc: perry.yuan@amd.com, Alexander.Deucher@amd.com, Li.Meng@amd.com, 
	Mario.Limonciello@amd.com, Xiaojian.Du@amd.com, Xinmei.Huang@amd.com, 
	gautham.shenoy@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	viresh.kumar@linaro.org
Subject: Re:Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <9c229562-06f8-fad8-8f3d-a236733ce699@amd.com>
References: <20240730140111.4491-1-00107082@163.com>
 <1d5f4859-6810-355f-3e0e-ed1c9e53c3f4@amd.com>
 <2c2569aa.47a.191062d0d40.Coremail.00107082@163.com>
 <9c229562-06f8-fad8-8f3d-a236733ce699@amd.com>
X-NTES-SC: AL_Qu2ZAP+SuEkv5iieZekZnEYQheY4XMKyuPkg1YJXOp80sibt8xA+d3VEIWrE0s2SDT2JuhKuUQRCyehKYIhUWIhNmCgbddsVac9BtkRuJsqR
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <51a44058.3913.19106dea781.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f63VsalmaQ5NAA--.64416W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQQtqmVOB302nwAGsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDctMzEgMTE6MTY6MTQsICJYaWFvamlhbiBEdSIgPHhpYW9qaWR1QGFtZC5jb20+
IHdyb3RlOgo+Cj5PbiAyMDI0LzcvMzEgODoyNSwgRGF2aWQgV2FuZyB3cm90ZToKPj4gSGkgRHUs
Cj4+Cj4+IFRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlCj4+Ci4uLgo+Pj4KPj4+IFRhcmdl
dCBzeXN0ZW0sIGluY2x1ZGluZyBDUFUrYmFzZWJvYXJkK0JJT1MsIGlzIHN1cHBvc2VkIHRvIGVu
YWJsZSBhbmQKPj4+IHVzZSBDUFBDIGZlYXR1cmUgZm9yIGJldHRlciBQZXJmb3JtYW5jZSBwZXIg
V2F0dC4KPj4gSSBhZ3JlZSB0aGF0IHRoZSB3YXJuaW5nIGd1aWRlIG1ha2VzIHRvdGFsIHNlbnNl
LCAgYnV0ICB0aGUgICplcnJvcnMqIGRvZXMgbm90LCB3aHkgYm90aGVyIHRyeWluZyBhbmQgcmVw
b3J0IGVycm9yIHdoZW4gdGhlIGZlYXR1cmUgaXMgZGlzYWJsZWQgYnkgQklPUy4KPj4KPkl0IGhh
cyB0byBkbyB0aGF0Lgo+QU1EIHN0cm9uZ2x5IHJlY29tbWVuZHMgdXNlcnMgdG8gZW5hYmxlIHRo
aXMgZmVhdHVyZSwgYnV0IGVhY2ggT0VNIHdpbGwgCj5oYXZlIGN1c3RvbWl6ZWQgQklPUywgc29t
ZSBzdXBwb3J0IENQUEMgYnV0IGRpc2FibGUgYnkgZGVmYXVsdCwKPnNvbWUgc3VwcG9ydCBDUFBD
IGFuZCBlbmFibGUgYnkgZGVmYXVsdCwgYW5kIHNvbWUgZGlzYWJsZSBDUFBDIGRpcmVjdGx5IAo+
d2l0aG91dCBwcm92aWRpbmcgc3dpdGNoIG9wdGlvbi4KPgo+U2luY2UgbmV3ZXIgTGludXgga2Vy
bmVsIGVuYWJsZXMgdGhlIGFtZC1wc3RhdGUgZHJpdmVyIGJ5IGRlZmF1bHQsIGFuZCAKPm5ld2Vy
IEFNRCBaZW4gWCBDUFUgc3VwcG9ydHMgdGhpcyBmZWF0dXJlLAo+YnV0IHVzZXIgZmluZCB0aGF0
IENQUEMgaXMgbm90IGVmZmVjdGl2ZSB1bmRlciB0aGVpciBzb2Z0d2FyZSBhbmQgCj5oYXJkd2Fy
ZSBjb21iaW5hdGlvbiwKPmlmIHRoaXMgZHJpdmVyIGRvZXMgbm90IHRyeSB0byBsb2FkIG1vZHVs
ZSBhbmQgcHJpbnQgbm8gaW5mb3JtYXRpb24sIGl0IAo+d2lsbCBtaXNsZWFkIHVzZXJzIHRoYXQg
dGhlIHByb2JsZW0gaXMgY2F1c2VkIGJ5IHRoZSBhbWQtcHN0YXRlIGRyaXZlci4KPgo+VGhhbmtz
LAo+WGlhb2ppYW4KPgoKSSBmZWVsIHRoYXQgeW91IGFyZSBhcmd1aW5nIGZvciB0aGUgd2Fybmlu
ZyBhbmQgdGhlIGVycm9ycyBzZXBhcmF0ZWx5LgpTZXBhcmF0ZWx5LCAgIEkgYWdyZWUgd2Fybmlu
ZyBvciBlcnJvciBtZXNzYWdlIG1ha2Ugc2Vuc2UgYXMgeW91IGV4cGxhaW5lZCwgIGJ1dCB0b2dl
dGhlciBJIGZlZWwgY29uZnVzZWQ6ClJlY2VpdmluZyBhIHdhcm5pbmcgdGhhdCBDUFBDIGZlYXR1
cmUgaXMgZGlzYWJsZSBieSBCSU9TIGFscmVhZHkgbm90aWZ5IHVzZXJzIHRoYXQgYW1kLXBzdGF0
ZSB3b3VsZCBub3Qgd29yaywgcmlnaHQ/CklzIGl0IHBvc3NpYmxlLCB0aGF0IHRob3NlIHR3byBj
b25kaXRpb24gY29leGlzdHM6IENQUEMgaXMgZGlzYWJsZWQgYnkgQklPUywgYW5kICBhbWQtcHN0
YXRlIGNvdWxkIGZ1bmN0aW9uIHByb3Blcmx5PwoKClRoYW5rcwpEYXZpZAoK

