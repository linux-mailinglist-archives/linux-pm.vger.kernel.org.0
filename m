Return-Path: <linux-pm+bounces-11734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F22C942579
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 06:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B17B20FC8
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 04:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6E2905;
	Wed, 31 Jul 2024 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Janxiiu6"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF918039;
	Wed, 31 Jul 2024 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722400484; cv=none; b=UImTXgKa0HuoVQ/ixjFiFKND2O05G4a0u01N6CIt2gxEp+nJWwFwudjQZkceuSpW7jN6dBkfeVYT/TnbuFYF4bYoL81efqGjNb5dMXC11Sc8W9fKuYVvCDllR6NJPzitJ9ZWMY2+VOudGMOAqXFRl3WZJhCeTNsCxXBRtGsLwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722400484; c=relaxed/simple;
	bh=V/VsL1iJdl/lK6/fE4RPn3MWXns7iKkHGw5IqqZ/5Lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=qVaCj3HMpZnmvY/ANOCc5c3zVbjMFU1RXyOM+xOuklTSc50lo1jsYtIEhr7A+JXlJ92MfSUiJJmOaxR2T9pF2z010sSoN+5rIQ3tD4cihqFfceUwKaFbM7YdWYS/gbUhLbYPpDmVGreklwGmExEOiXg18CKSgfygxYQUbUEpuEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Janxiiu6 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=QDgJcuUHtS0SBybOgwNpLvXjX2NfykPkpulIsNo07AE=; b=J
	anxiiu62deFbXXuRuU5b+BOBuXhEJWLpVoQlW1a8hfANdWuO4LNTbSgNchtEW2PX
	BzsmDowQK9N/hr10HkWSSKS7acfxBCD+y3oSQpXeAxs6xE/+T9Y41B2RhRuU8YRy
	9jpwXPFi/G93MCBfqbN7OEODayU1elVpGYVd3sciQU=
Received: from 00107082$163.com ( [111.35.189.52] ) by
 ajax-webmail-wmsvr-40-104 (Coremail) ; Wed, 31 Jul 2024 12:33:36 +0800
 (CST)
Date: Wed, 31 Jul 2024 12:33:36 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Xiaojian Du" <xiaojidu@amd.com>
Cc: perry.yuan@amd.com, Alexander.Deucher@amd.com, Li.Meng@amd.com, 
	Mario.Limonciello@amd.com, Xiaojian.Du@amd.com, Xinmei.Huang@amd.com, 
	gautham.shenoy@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	viresh.kumar@linaro.org
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <7e2275d5-19dc-555e-e8e1-ed79b408c0e3@amd.com>
References: <20240730140111.4491-1-00107082@163.com>
 <1d5f4859-6810-355f-3e0e-ed1c9e53c3f4@amd.com>
 <2c2569aa.47a.191062d0d40.Coremail.00107082@163.com>
 <9c229562-06f8-fad8-8f3d-a236733ce699@amd.com>
 <51a44058.3913.19106dea781.Coremail.00107082@163.com>
 <7e2275d5-19dc-555e-e8e1-ed79b408c0e3@amd.com>
X-NTES-SC: AL_Qu2ZAPibv0wq4CaQZ+kZnEYQheY4XMKyuPkg1YJXOp80tiTLyB48X0BMLXjU0f6EMzKxjye1dBdoxcZGUIRpYpkwYpNAGAUCb3CbjOKIT5m/
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6cddbf5f.4164.1910710a3b2.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3n6uhvqlmWiNNAA--.43203W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRQtqmVOB4NuvQAEsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNy0zMSAxMjoyMTowNSwgIlhpYW9qaWFuIER1IiA8eGlhb2ppZHVAYW1kLmNvbT4g
d3JvdGU6Cj4KPk9uIDIwMjQvNy8zMSAxMTozOSwgRGF2aWQgV2FuZyB3cm90ZToKPj4gQXQgMjAy
NC0wNy0zMSAxMToxNjoxNCwgIlhpYW9qaWFuIER1IiA8eGlhb2ppZHVAYW1kLmNvbT4gd3JvdGU6
Cj4+PiBPbiAyMDI0LzcvMzEgODoyNSwgRGF2aWQgV2FuZyB3cm90ZToKPj4+PiBIaSBEdSwKPj4+
Pgo+Pj4+IFRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlCj4+Pj4KPj4+PiAuLi4KPj4+PiBJ
IGZlZWwgdGhhdCB5b3UgYXJlIGFyZ3VpbmcgZm9yIHRoZSB3YXJuaW5nIGFuZCB0aGUgZXJyb3Jz
IHNlcGFyYXRlbHkuCj4+Pj4gU2VwYXJhdGVseSwgICBJIGFncmVlIHdhcm5pbmcgb3IgZXJyb3Ig
bWVzc2FnZSBtYWtlIHNlbnNlIGFzIHlvdSBleHBsYWluZWQsICBidXQgdG9nZXRoZXIgSSBmZWVs
IGNvbmZ1c2VkOgo+Pj4+IFJlY2VpdmluZyBhIHdhcm5pbmcgdGhhdCBDUFBDIGZlYXR1cmUgaXMg
ZGlzYWJsZSBieSBCSU9TIGFscmVhZHkgbm90aWZ5IHVzZXJzIHRoYXQgYW1kLXBzdGF0ZSB3b3Vs
ZCBub3Qgd29yaywgcmlnaHQ/Cj5XYXJuaW5nIGlzIG5vdCBlbm91Z2gsIGVycm9yIHdpbGwgZ3Vp
ZGUgdXNlciB0byBzd2l0Y2ggdG8gYWNwaSBjcHUgCj5kcml2ZXIgb3Igc2VlayBtb3JlIHN1cHBv
cnQgZnJvbSBPRU0uCj4+Pj4gSXMgaXQgcG9zc2libGUsIHRoYXQgdGhvc2UgdHdvIGNvbmRpdGlv
biBjb2V4aXN0czogQ1BQQyBpcyBkaXNhYmxlZCBieSBCSU9TLCBhbmQgIGFtZC1wc3RhdGUgY291
bGQgZnVuY3Rpb24gcHJvcGVybHk/Cj4+Pj4KPj4+PiAgIAo+Cj5ObyBwb3NzaWJsZSwgdGhlIGN1
cnJlbnQgYW1kLXBzdGF0ZSBkcml2ZXIgaXMgYmFzZWQgb24gQ1BQQyBmZWF0dXJlLgo+Cj5UaGFu
a3MuCj5YaWFvamlhbgo+CgpTbywgd2hhdCBhYm91dCB0aGUgcGF0Y2ggSSBtZW50aW9uZWQ6ICB3
aGVuIENQUEMgaXMgZGlzYWJsZWQgYnkgIEJJT1MsIHByaW50IHdhcm5pbmcgbWVzc2FnZSBhbmQg
YWJvcnQgYW1kLXBzdGF0ZSBkcml2ZXIgcmVnaXN0cmF0aW9uPwooSSBtYWRlIGEgY29kZSBibG9j
ayBtaXN0YWtlIGluIHRoZSBwYXRjaCBJIHBvc3RlZCBiZWZvcmUpCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMK
aW5kZXggNjhjNjE2YjU3MmYyLi5iMDZmYWVhNThmZDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1
ZnJlcS9hbWQtcHN0YXRlLmMKKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYwpAQCAt
MTgzNyw4ICsxODM3LDYgQEAgc3RhdGljIGJvb2wgYW1kX2NwcGNfc3VwcG9ydGVkKHZvaWQpCiAg
ICAgICAgICogSWYgdGhlIENQUEMgZmVhdHVyZSBpcyBkaXNhYmxlZCBpbiB0aGUgQklPUyBmb3Ig
cHJvY2Vzc29ycyB0aGF0IHN1cHBvcnQgTVNSLWJhc2VkIENQUEMsCiAgICAgICAgICogdGhlIEFN
RCBQc3RhdGUgZHJpdmVyIG1heSBub3QgZnVuY3Rpb24gY29ycmVjdGx5LgogICAgICAgICAqIENo
ZWNrIHRoZSBDUFBDIGZsYWcgYW5kIGRpc3BsYXkgYSB3YXJuaW5nIG1lc3NhZ2UgaWYgdGhlIHBs
YXRmb3JtIHN1cHBvcnRzIENQUEMuCi0gICAgICAgICogTm90ZTogYmVsb3cgY2hlY2tpbmcgY29k
ZSB3aWxsIG5vdCBhYm9ydCB0aGUgZHJpdmVyIHJlZ2lzdGVyYXRpb24gcHJvY2VzcyBiZWNhdXNl
IG9mCi0gICAgICAgICogdGhlIGNvZGUgaXMgYWRkZWQgZm9yIGRlYnVnZ2luZyBwdXJwb3Nlcy4K
ICAgICAgICAgKi8KICAgICAgICBpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVf
Q1BQQykpIHsKICAgICAgICAgICAgICAgIGlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFU
VVJFX1pFTjEpIHx8IGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfWkVOMikpIHsKQEAg
LTE4NTYsNiArMTg1NCw3IEBAIHN0YXRpYyBib29sIGFtZF9jcHBjX3N1cHBvcnRlZCh2b2lkKQot
ICAgICAgICBpZiAod2FybikKKyAgICAgICAgaWYgKHdhcm4pIHsKICAgICAgICAgICAgICAgIHBy
X3dhcm5fb25jZSgiVGhlIENQUEMgZmVhdHVyZSBpcyBzdXBwb3J0ZWQgYnV0IGN1cnJlbnRseSBk
aXNhYmxlZCBieSB0aGUgQklPUy5cbiIKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJQbGVhc2UgZW5hYmxlIGl0IGlmIHlvdXIgQklPUyBoYXMgdGhlIENQUEMgb3B0aW9u
LlxuIik7CisgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7CisgICAgICAgICB9CiAgICAgICAg
cmV0dXJuIHRydWU7CiB9IAoKCgpUaGFua3MKRGF2aWQKCg==

