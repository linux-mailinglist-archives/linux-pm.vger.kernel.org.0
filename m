Return-Path: <linux-pm+bounces-13445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A9196A4C2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 18:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C61F24EB3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9FA18C321;
	Tue,  3 Sep 2024 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="pYO8eKZt"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E1190055;
	Tue,  3 Sep 2024 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381849; cv=none; b=EBE1v/avIl+Xb0hfgSTRMW8xXp4SDCSfzRmjlQYRw8VGn1D1ybZ4CQ9crlhKWYcFVbm0jXx3HlkLb4VS2kMgNnScp0oGpO37FU3wTnFGbAlFOgdsGH207JSjWyb6PyMKr1uZeICg8MODAhezETk+v0ZvyDe3rvydCkX4weG+WUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381849; c=relaxed/simple;
	bh=EZPjTHsMbPmhyUg+GGkRG8szo5c7T+YYyqS3v+vfFgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=sxuVGxDzaxnFf3ZTW5DiP1X2shDhQCJPWqj2pnAMnnkQZAJyouvNhaeKFV4z+rCkejIPlMvh2QXkn4197dEe0zfV/cMi1fWFjsDwuwXbFF6wIoosCZrsmnPhDy4ypYdPTarSCfK2OPaMecE/uvuRqzJG+4ajwDBfv2CYPzuRK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=pYO8eKZt reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=fATYkWcUiyi4eQEtaDXZAo+k3ccL09Hr3+AuA8z6u9I=; b=p
	YO8eKZtH+EegQEWhjs4/CR9u4eTL63xHYVWplPpuCsHrV+gWWx7eot67X+QpCMag
	vYyb2x+yjAUPqEr4qXlsGoi+wSxtvuJnEZim6PBDLsBCTOeG6QW4nXzNUHdlvTkI
	hsxdUdRnxaxA+rxpacSTqeh9STJHplqowfD4yF+fVw=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Wed, 4 Sep 2024 00:42:37 +0800 (CST)
Date: Wed, 4 Sep 2024 00:42:37 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: add: move warn message out of mutex lock.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJZ5v0gFnHX982G96aU51tirmdQPiQAYExS5CFcjQc4vgXHAtQ@mail.gmail.com>
References: <20240902054959.28073-1-00107082@163.com>
 <CAJZ5v0gZ9oAByawssaARFN1_crTuMZ-CnU5Fy9D1sWv+Moo-sg@mail.gmail.com>
 <CAJZ5v0itLuorOY-4PyDL5eFkWTf2s9JX++oBkzqi1cYcaHYdmA@mail.gmail.com>
 <408f4579.bfd0.191b8ac0e66.Coremail.00107082@163.com>
 <CAJZ5v0gFnHX982G96aU51tirmdQPiQAYExS5CFcjQc4vgXHAtQ@mail.gmail.com>
X-NTES-SC: AL_Qu2ZB/+Tvk8u4SeebekXn0oTju85XMCzuv8j3YJeN500tybIyAIZXVZIAWfs18K/ACSCmTGPUhN0zfR6UIZYdZyN9pBSZwIrsVrgYxg2GTk8
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <352ad1a.c130.191b8c44b51.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3X1J+PNdmnelHAA--.39594W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxVPqmXAnnH+EAABsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDktMDQgMDA6MjM6NTcsICJSYWZhZWwgSi4gV3lzb2NraSIgPHJhZmFlbEBrZXJu
ZWwub3JnPiB3cm90ZToKPk9uIFR1ZSwgU2VwIDMsIDIwMjQgYXQgNjoxNuKAr1BNIERhdmlkIFdh
bmcgPDAwMTA3MDgyQDE2My5jb20+IHdyb3RlOgo+Pgo+PiBIaSwKPj4KPj4gQXQgMjAyNC0wOS0w
MyAyMjoxMDoxNiwgIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmFmYWVsQGtlcm5lbC5vcmc+IHdyb3Rl
Ogo+PiA+T24gVHVlLCBTZXAgMywgMjAyNCBhdCAzOjAx4oCvUE0gUmFmYWVsIEouIFd5c29ja2kg
PHJhZmFlbEBrZXJuZWwub3JnPiB3cm90ZToKPj4gPj4KPj4gPj4gT24gTW9uLCBTZXAgMiwgMjAy
NCBhdCA3OjUw4oCvQU0gRGF2aWQgV2FuZyA8MDAxMDcwODJAMTYzLmNvbT4gd3JvdGU6Cj4+ID4+
ID4KPj4gPj4gPiBkcG1fbGlzdF9tdHggZG9lcyBub3QgcHJvdGVjdCBhbnkgZGF0YSB1c2VkIGJ5
Cj4+ID4+ID4gZGV2X3dhcm4gZm9yIGNoZWNraW5nIHBhcmVudCdzIHBvd2VyLCBtb3ZlCj4+ID4+
ID4gZGV2X3dhcm4gb3V0IG9mIG11dGV4IGxvY2sgYmxvY2sgbWFrZSB0aGUKPj4gPj4gPiBsb2Nr
IG1vcmUgZWZmaWNpZW50LCBlc3BlY2lhbGx5IHdoZW4gdGhlIHdhcm4KPj4gPj4gPiBpcyB0cmln
Z2VyZWQuCj4+ID4+Cj4+ID4+IEl0IGRvZXMgcHJvdGVjdCB0aGUgcG93ZXIuaXNfcHJlcGFyZWQg
ZmxhZyBvZiB0aGUgcGFyZW50Lgo+PiA+Cj4+ID5JbiBmYWN0LCB0aGUgdXBkYXRlIG9mIGl0IGlu
IGRldmljZV9yZXN1bWUoKSBpcyByYWN5IHdpdGggcmVzcGVjdCB0bwo+PiA+dGhlIGNoZWNrIGlu
IGRldmljZV9wbV9hZGQoKSwgYnV0IHRoZSBwdXJwb3NlIG9mIGl0IGlzIG1vc3RseSB0byBhbGxv
dwo+PiA+dGhlIGRldmljZSBkcml2ZXIncyByZXN1bWUgY2FsbGJhY2sgdG8gYWRkIGNoaWxkcmVu
IHdpdGhvdXQgdHJpZ2dlcmluZwo+PiA+dGhlIHdhcm5pbmcuCj4+Cj4+Cj4+IEtpbmQgb2YgY29u
ZnVzZWQgYnkgdGhpcy4uLiBpZiBkcG1fbGlzdF9tdHggY291bGQgcHJvdGVjdCBwb3dlci5pc19w
cmVwYXJlZCwKPj4gdGhlbiBjb2RlcyB0aGF0IGNoYW5nZSBwb3dlci5pc19wcmVwYXJlZCBzaG91
bGQgYWxzbyBob2xkIHRoaXMgbG9jaywgYnV0IG5vcm1hbGx5Cj4+IHRoZXkgb25seSB1c2UgZGV2
aWNlX2xvY2soZGV2KTsKPgo+SXQgaXMgY29uZnVzaW5nLCBzb3JyeSBhYm91dCB0aGF0Lgo+Cj5U
aGUgYm90dG9tIGxpbmUgdGhvdWdoIGlzIHRoYXQgeW91IHdhbnQgdG8gZ2V0IHJpZCBvZiB0aGUg
c3B1cmlvdXMKPndhcm5pbmcgaW4gZGV2aWNlX3BtX2FkZCgpIEFGQUlDUy4KPgo+VG8gdGhhdCBl
bmQsIGNhbiB5b3UgcGxlYXNlIHRyeSB0aGUgcGF0Y2ggSSBzZW50IGluIHRoZSBvdGhlciB0aHJl
YWQ6Cj4KCj5odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wbS9DQUpaNXYwaE1ubkRqS0pM
TWdjVF9wMW5uZWp5eUF5YXFhQV9BRjV0K189UHNTTWZjZVFAbWFpbC5nbWFpbC5jb20vCgoKClN1
cmUswqAgSSB3aWxsIHRyeSBpdCBhbmQgdXBkYXRlIGxhdGVyLgpCdXQgdGhpcyBwYXRjaCBpcyBq
dXN0IGFib3V0IGNvZGUtcmVmYWN0b3IsIG5vdCBhYm91dCB0aGUgd2FybiBpdHNlbGYuLi4uLgoK
CkRhdmlkCiAK

