Return-Path: <linux-pm+bounces-13442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3396A40B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540AFB29962
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8D18A6AC;
	Tue,  3 Sep 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="D/Y2JiiJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028F926ACC;
	Tue,  3 Sep 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380227; cv=none; b=nLFIcnWwUILZfb889IIxr9rdMkk3yap39CSzkoDuv3+15KuOJG0B024lC/z7YsPKjnhIG7TN0ujjOUE8+lZz4EBG1ELYCClukxHwQZiJZfM+wa4jKv80q3HRkNprhZSYTMjL6tNnEuriCnPb0cMwW8UTw/mEmnJmfp31TfiUATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380227; c=relaxed/simple;
	bh=ybz1Oo+4mfh4Ny3r0ptMOoF47R/WIq99bZzaWePM+sc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=scv4wCj3zxZ8vVp2hwTlNMyGc1ZfC4sDc6ByPYxwFrIOR82YdQe1KcnqUc57OwV6VMvaMP/Vcr3IxMT2XoSbYoAi8sGEIWl4jEg5IgAi6Earl8avreL8OXWeCwl/wcRLfuxSJqCOxtDOLkt4P9sr40hTmOhvM4Dk01f8xkoWV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=D/Y2JiiJ reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=KwK4ua8dyD8+BVRinKjXFoQ4sPizUkipw0ydVwYNosE=; b=D
	/Y2JiiJ1OJjowT2tN50sqTWwbJBmogfGOoeLg7LNxdjdwV00mHuSbnXF+VygvRTM
	yOgMuTy/pSkBYXJYjNGx4iDtTjJTeQqtCrEhYwUPnssOH4DIXdHwIPCCimQ+rLxr
	w9fCHrsBh0umN1Pm6r8kiFGsErHO0mr2s9XFDLIMTQ=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-107 (Coremail) ; Wed, 4 Sep 2024 00:16:09 +0800 (CST)
Date: Wed, 4 Sep 2024 00:16:09 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: add: move warn message out of mutex lock.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJZ5v0itLuorOY-4PyDL5eFkWTf2s9JX++oBkzqi1cYcaHYdmA@mail.gmail.com>
References: <20240902054959.28073-1-00107082@163.com>
 <CAJZ5v0gZ9oAByawssaARFN1_crTuMZ-CnU5Fy9D1sWv+Moo-sg@mail.gmail.com>
 <CAJZ5v0itLuorOY-4PyDL5eFkWTf2s9JX++oBkzqi1cYcaHYdmA@mail.gmail.com>
X-NTES-SC: AL_Qu2ZB/+Tv0kt7yOYYukXn0oTju85XMCzuv8j3YJeN500uSTH1Q45T1FJFnf51MefLBmmnja8eQFL5c9Rf6dzRKJwFtRwDIU85RrSKgjlpCMU
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <408f4579.bfd0.191b8ac0e66.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3P7tKNtdmiGsfAA--.64750W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gRPqmWX0I5sjQACs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksCgpBdCAyMDI0LTA5LTAzIDIyOjEwOjE2LCAiUmFmYWVsIEouIFd5c29ja2kiIDxyYWZhZWxA
a2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBUdWUsIFNlcCAzLCAyMDI0IGF0IDM6MDHigK9QTSBSYWZh
ZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiBPbiBNb24sIFNl
cCAyLCAyMDI0IGF0IDc6NTDigK9BTSBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29tPiB3cm90
ZToKPj4gPgo+PiA+IGRwbV9saXN0X210eCBkb2VzIG5vdCBwcm90ZWN0IGFueSBkYXRhIHVzZWQg
YnkKPj4gPiBkZXZfd2FybiBmb3IgY2hlY2tpbmcgcGFyZW50J3MgcG93ZXIsIG1vdmUKPj4gPiBk
ZXZfd2FybiBvdXQgb2YgbXV0ZXggbG9jayBibG9jayBtYWtlIHRoZQo+PiA+IGxvY2sgbW9yZSBl
ZmZpY2llbnQsIGVzcGVjaWFsbHkgd2hlbiB0aGUgd2Fybgo+PiA+IGlzIHRyaWdnZXJlZC4KPj4K
Pj4gSXQgZG9lcyBwcm90ZWN0IHRoZSBwb3dlci5pc19wcmVwYXJlZCBmbGFnIG9mIHRoZSBwYXJl
bnQuCj4KPkluIGZhY3QsIHRoZSB1cGRhdGUgb2YgaXQgaW4gZGV2aWNlX3Jlc3VtZSgpIGlzIHJh
Y3kgd2l0aCByZXNwZWN0IHRvCj50aGUgY2hlY2sgaW4gZGV2aWNlX3BtX2FkZCgpLCBidXQgdGhl
IHB1cnBvc2Ugb2YgaXQgaXMgbW9zdGx5IHRvIGFsbG93Cj50aGUgZGV2aWNlIGRyaXZlcidzIHJl
c3VtZSBjYWxsYmFjayB0byBhZGQgY2hpbGRyZW4gd2l0aG91dCB0cmlnZ2VyaW5nCj50aGUgd2Fy
bmluZy4KCgpLaW5kIG9mIGNvbmZ1c2VkIGJ5IHRoaXMuLi4gaWYgZHBtX2xpc3RfbXR4IGNvdWxk
IHByb3RlY3QgcG93ZXIuaXNfcHJlcGFyZWQsIAp0aGVuIGNvZGVzIHRoYXQgY2hhbmdlIHBvd2Vy
LmlzX3ByZXBhcmVkIHNob3VsZCBhbHNvIGhvbGQgdGhpcyBsb2NrLCBidXQgbm9ybWFsbHkKdGhl
eSBvbmx5IHVzZSBkZXZpY2VfbG9jayhkZXYpOwoKCkRhdmlk

