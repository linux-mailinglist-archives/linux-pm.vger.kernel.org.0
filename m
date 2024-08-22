Return-Path: <linux-pm+bounces-12701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1D95AD01
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 07:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7556D1F21BED
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 05:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262E5588E;
	Thu, 22 Aug 2024 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="g+qvP3BS"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B943165;
	Thu, 22 Aug 2024 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305444; cv=none; b=jqZ0Tp6xhtoVEPcH/ysx8LEmyUYBt9weKKUAOL/uJHui2UUqn79yp9XmbveKJU++YLFkKMNS50pB8p5bNqAU6c1Q3kS8XSxvKgFDJIMQ/0LW3EuBqcpVR8CRH8+ATKtme2gK80IJo30w1GSdyVs/2fmnH+fOhKOXoqBvqDISao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305444; c=relaxed/simple;
	bh=+12MpKq0sFWB9yN0DH0Fk5rsOciMqj73C3b3pMu58DI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Su3SEyca1QAEntlQENhWoiaEidRhAYmjAGqKPpK4lzBTMT52R8fJfkgWiEtTDRmF1RYCvcdicYOh0HTOwp5EwOGjmUiF9v5qI4qLHrgHCfdXuwiRIcN5BcZkL41Uf44kaOcH2H75lXEFbr8g2/Va8EekWDOpk5J1aDKbs0PaNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=g+qvP3BS reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=j9S9dmKiBlpsdnZmzhzs9wQDVFgforjcGaFMTZ8AYp8=; b=g
	+qvP3BS9f+6yAkxqYMajuGCVdL9N9llU/GeGJhl66JyYhE7xzp3pKvN+wj69ixBL
	YsbimW6UvFbnOtGBXzyTRRzOn/j+/WNFxTMikHQi5mGDVfYcrJGweVAuM1ThBb2G
	Ny/CSN/2Tl3gyFg5dGjYOMDUlQMg5hLeqyjXMES5tg=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-114 (Coremail) ; Thu, 22 Aug 2024 13:43:12 +0800
 (CST)
Date: Thu, 22 Aug 2024 13:43:12 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, 
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, 
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"Huang, Ray" <Ray.Huang@amd.com>, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, 
	"Petkov, Borislav" <Borislav.Petkov@amd.com>, 
	"Huang, Shimmer" <Shimmer.Huang@amd.com>, 
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Yuan, Perry" <Perry.Yuan@amd.com>
Subject: =?GBK?Q?Re:=BB=D8=B8=B4:_[PATCH_RESENT]_cpufreq:_amd-pstate:?=
 =?GBK?Q?_add_quirk_for_Ryzen_3000_series_processor?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <DM4PR12MB5136B5BA5DEE9BE7A27F44B9F18F2@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20240809060905.777146-1-perry.yuan@amd.com>
 <37587d44.95af.191373f195c.Coremail.00107082@163.com>
 <b9899fcf-2774-b270-900a-72c7e1f10dfa@amd.com>
 <DM4PR12MB5136B5BA5DEE9BE7A27F44B9F18F2@DM4PR12MB5136.namprd12.prod.outlook.com>
X-NTES-SC: AL_Qu2ZBv+buksi5CSeYekZnEYQheY4XMKyuPkg1YJXOp80oyT93j8eZW9KM0Tz+cePFj6joAiGVDlT1/RreIlbT5KgsI3J1ynzMtPiR14NyOFZ
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <38b23ce.4a8c.191789c4356.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD338Dxz8ZmQI8LAA--.57361W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxpDqmXAnVgxnwAHsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksIAoKQXQgMjAyNC0wOC0yMiAxMjoyNTo0OSwgIkR1LCBYaWFvamlhbiIgPFhpYW9qaWFuLkR1
QGFtZC5jb20+IHdyb3RlOgo+W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBE
aXN0cmlidXRpb24gT25seV0KPgo+SGkgRGF2aWQsCj4KPkkgYnVpbHQgb25lIHRlc3QgY29tYmlu
YXRpb246IEI1NTAgbW90aGVyYm9hcmQrIFI5LTM5MDBYIENQVSsgNi4xMC1yYzQga2VybmVsLgo+
T24gbXkgdGVzdCBtYWNoaW5lLCBhbWQtcHN0YXRlIGRyaXZlciBwYXNzaXZlL2FjdGl2ZSBtb2Rl
IHdvcmtzIGFmdGVyIGVuYWJsaW5nIENQUEMgaW4gQklPUywgbm8gY29kZSBjaGFuZ2UgaW4gYW1k
LXBzdGF0ZS4KPk15IEJJT1MgaXMgdXBkYXRlZCBvbiAyMDIzIEF1Zy4gQnV0IG5vIG1hdHRlciBD
UFBDIGlzIGVuYWJsZWQgb3Igbm90IGluIEJJT1MsICJsc2NwdSIgd29uJ3Qgc2hvdyBDUFBDIGZs
YWcgb24gUjktMzkwMFggQ1BVLgo+QW55IGNoYW5jZSB0byB1cGRhdGUgeW91ciBCSU9TIGZpcnN0
Pwo+Tm90aWNlZCB5b3VyIG1vdGhlcmJvYXJkIGlzICJNU0kgQjQ1ME0gTU9SVEFSIE1BWCIsIHRo
ZSBsYXRlc3QgdGhyZWUgdmVyc2lvbnMgb2YgQklPUyBhcmUgcmVsZWFzZWQgaW4gMjAyNCBBdWcu
IDIxc3QvMjAyNCBBdWcuIDl0aC8yMDIzIE9jdC4gMjZ0aC4KPmh0dHBzOi8vd3d3Lm1zaS5jbi9N
b3RoZXJib2FyZC9CNDUwTS1NT1JUQVItTUFYL3N1cHBvcnQKPgpUaGFua3MgZm9yIHRoZSBpbmZv
cm1hdGlvbi4gICAoSSBkaWQgY2hhbmdlIG15IEJJT1MncyBDUFBDIGNvbmZpZyBmcm9tICJhdXRv
IiB0byAiZW5hYmxlIiwgYnV0IGVycm9yIG1lc3NhZ2Ugc3RpbGwuKQpCdXQgYWNjb3JkaW5nIHRv
ICAgYW5vdGhlciBtYWlsIGZyb20gZ2F1dGhhbS5zaGVub3lAYW1kLmNvbSwgIG15IHVuZGVyc3Rh
bmRpbmcgaXMgdGhhdCBteSBDUFUoQU1EIFJ5emVuIDMgMzEwMCA0LUNvcmUgUHJvY2Vzc29yKSBk
b2VzIG5vdCBoYXZlIHRoaXMgQ1BQQyBmZWF0dXJlLCAgd291bGQgdXBncmFkZSBteSBCSU9TIHJl
YWxseSBoZWxwPwpgYGAKICAgIEkgY2hlY2tlZCB0aGUgcHVibGljbHkgYXZhaWxhYmxlIFBQUnMg
b2YgdGhlIEZhbWlseSAxN2ggbW9kZWxzIDB4NjAKICAgIChSZW5vaXIpIFsxXSBhbmQgRmFtaWx5
IDE3aCBtb2RlbCAweDcxIChNYXRpc3NlKSBbMl0uIEluIGJvdGggdGhlc2UKICAgIFBQUnMsIENQ
VUlEIDB4ODAwMDAwMDggRUJYWzI3XSBpcyBhIHJlc2VydmVkIGJpdC4KICAgIAogICAgSW4gZmFj
dCwgRGF2aWQgcmVwb3J0ZWQgdGhpcyBpc3N1ZSBvbiBNYXRpc3NlIHN5c3RlbS4KYGBgCgpBbnl3
YXksIEkgd2lsbCBnaXZlIEJJT1MgdXBncmFkaW5nICBhIHRyeS4gCgo+SWYgdGhpcyBpc3N1ZSBp
cyBmaXhlZCBpbiBCSU9TLCBubyBuZWVkIHRvIG1vZGlmeSB0aGUgdXBzdHJlYW0ga2VybmVsIGNv
ZGUsIHJpZ2h0PwoKSSB0aGluayAsIGV2ZW4gd2hlbiB1cGdyYWRpbmcgQklPUyB3b3VsZCBub3Qg
aGVscCwgdGhlIHF1aXJrIGp1c3QgZm9yIG15IHN5c3RlbSBpcyBub3Qgd29ydGggYmUgaW4ga2Vy
bmVsIDopLi4uLi4uCgo+Cj5UaGFua3MsCj5YaWFvamlhbgo+CgpUaGFua3MKRGF2aWQ=

