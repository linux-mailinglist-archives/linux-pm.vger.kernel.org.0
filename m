Return-Path: <linux-pm+bounces-13411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F14969BB4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022BCB20ABE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BE31A0BE3;
	Tue,  3 Sep 2024 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="gwCbYHnL"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D35195;
	Tue,  3 Sep 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362840; cv=none; b=CvLXY8CGsmwv/8amVf7KaByVfpvwCrpDjmUJBPL5+ebYr082h0uIx1xTOfXBagnpM4AFVE3eqSMGvjnD7wxCwVAUDp03P6zjj7qpJ9Sl0QFMSyN88TngiD9tj1SByVRmV697s4ECwhYqDWUTY85B7BtuDOrjfPZfFdkKWDu6QKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362840; c=relaxed/simple;
	bh=UrhhHWFReJHjjnu/JLe7WxRLG5V0ZxwtyFjI7bs912A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=qr5wXZRFPe4fF4TQ1RhOvYXFsoPb9Hsyj2+WHTFY1KhzAFd+IW4u7AYK0YK9IxVtjKhpEfyBLYR9Q4Q9Xp0cIJW9GQf/5R7EIxMuPrGWnjqbittFCn2uPybdCi+aE2FnC9EFykOkrvAmsRIdeBeeWOhfP4HQ1jRnAXVWFpK6yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=gwCbYHnL reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=j1RcWAvsKdHSlutlkkpQ3uMJa7lkq98Rrsn9w1ALegE=; b=g
	wCbYHnL6HDKXmgITlUS7dKBrFMYb++gsU+V6TbpGW0WfDT41GfA5TJCHcq5QcIim
	KoUIVHo4ZlMpi2ANSl9IJFyAXt9TIUYsv6YF9GLszHtX8xX4GvLnrAXI5S0CWgmf
	/l23vVCPorZtyMmw78SRmzBxS5ixXE5lrOQ/M4QHwk=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-112 (Coremail) ; Tue, 3 Sep 2024 19:26:27 +0800 (CST)
Date: Tue, 3 Sep 2024 19:26:27 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, pavel@ucw.cz, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pm: sleep: do not set is_prepared when no_pm_callbacks
 is set
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <2024090347-latter-collide-772a@gregkh>
References: <20240902125933.5742-1-00107082@163.com>
 <2024090347-latter-collide-772a@gregkh>
X-NTES-SC: AL_Qu2ZB/+dvU8j4SeYZ+kZnEYQheY4XMKyuPkg1YJXOp80oSTixAceb3lxO2Lx09CXJSq9th6ofwJ/+8pCT4dze4atHEIKzzLK20iGYBTlPtVj
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2d012670.aff7.191b7a2d57c.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_3tk8tZm10gfAA--.7876W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hFPqmWX0IqbZQADsz
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SEksIAoKQXQgMjAyNC0wOS0wMyAxODoyMzo1NSwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4gd3JvdGU6Cj5PbiBNb24sIFNlcCAwMiwgMjAyNCBhdCAwODo1OTozM1BNICsw
ODAwLCBEYXZpZCBXYW5nIHdyb3RlOgo+PiBXaGVuIHJlc3VtZSwgYSBwYXJlbnQgZGV2aWNlIHdp
dGggbm8gcG0gY2FsbGJhY2tzCj4+IHdvdWxkIGhhdmUgImlzX3ByZXBhcmVkIiBhbmQgImRpcmVj
dF9jb21wbGV0ZSIgYml0Cj4+IHNldCwgYW5kIHNraXAgdGhlICJmaWIiIGNoYW5jZSB0byB1bnNl
dCAiaXNfcHJlcGFyZWQiCj4+IGluIGRldmljZV9yZXN1bWUgYmVjYXVzZSBvZiB0aGUgZGlyZWN0
X2NvbXBsZXRlIGJpdC4KPj4gVGhpcyB3aWxsIHRyaWdnZXIgYSBrZXJuZWwgd2FybmluZyB3aGVu
IHJlc3VtZSBpdHMgY2hpbGQKPj4gRm9yIGV4YW1wbGUsIHdoZW4gc3VzcGVuZCBzeXN0ZW0gd2l0
aCBhbiBVU0Igd2ViY2FtCj4+IG9wZW5lZCwgZm9sbG93aW5nIHdhcm5pbmcgd291bGQgc2hvdyB1
cCBkdXJpbmcgcmVzdW1lOgo+PiAKPj4gID51c2IgMy0xLjE6IHJlc2V0IGhpZ2gtc3BlZWQgVVNC
IGRldmljZSBudW1iZXIgNCB1c2luZyB4aGNpX2hjZAo+PiAgPi4uCj4+ICA+ZXBfODE6IFBNOiBw
YXJlbnQgMy0xLjE6MS4xIHNob3VsZCBub3QgYmUgc2xlZXBpbmcKPj4gCj4+IFRoZSBkZXZpY2Ug
cGFyZW50aW5nIHJlbGF0aW9uc2hpcHMgYXJlOgo+PiBbdXNiIDMtMS4xXSA8PCBbdXZjdmlkZW8g
My0xLjE6MS4xXSA8PCBbZXBfODFdLgo+PiBXaGVuIHJlc3VtZSwgc2luY2UgdGhlIHZpcnR1YWwg
W3V2Y3ZpZGVvIDMtMS4xOjEuMV0gZGV2aWNlCj4+IGhhcyBubyBwbSBjYWxsYmFja3MsIGl0IHdv
dWxkIG5vdCBjbGVhciAiaXNfcHJlcGFyZWQiCj4+IG9uY2Ugc2V0LiAgVGhlbiwgd2hlbiByZXN1
bWUgW2VwXzgxXSwgcG0gbW9kdWxlIHdvdWxkCj4+IHlpZWxkIGEgd2FybiBzZWVpbmcgW2VwXzgx
XSdzIHBhcmVudCBbdXZjdmlkZW8gMy0xLjE6MS4xXQo+PiBoYXZpbmcgImlzX3ByZXBhcmVkIi4K
Pj4gCj4+IERvIG5vdCBzZXQgImlzX3ByZXBhcmVkIiBmb3IgdmlydHVhbCBkZXZpY2VzIGhhdmlu
Zwo+PiBubyBwbSBjYWxsYmFja3MgY2FuIGNsZWFyIHRob3NlIGtlcm5lbCB3YXJuaW5ncy4KPj4g
Cj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdhbmcgPDAwMTA3MDgyQDE2My5jb20+Cj4+IC0tLQo+
PiAgZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYyB8IDMgKystCj4+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPldoYXQgY29tbWl0IGlkIGRvZXMgdGhp
cyBmaXg/CgpXZWxsLCB0aGUgc3RhdGUgbWFuYWdlbWVudCBvZiBQTSBkZXZpY2VzIGlzIHF1aXRl
IGNvbXBsaWNhdGVkIHRvIG1lLCBsb3RzIG9mIGNvbW1pdHMgbWFrZSBzbWFsbCBjaGFuZ2VzIAph
bmQgIEkgY2Fubm90IGlkZW50aWZ5IGEgc2luZ2xlIGNvbW1pdCB0aGF0IHNvbGVseSBpbnRyb2R1
Y2VkIHRoZSBrZXJuZWwgd2FybmluZyB3aGVuIHN1c3BlbmQgYW4gb3BlbmVkIFVTQiB3ZWJjYW0u
CgpNb3N0IG9idmlvdXMgY29tbWl0IHNlZW1zIHRvIGJlIAphYThlNTRiNTU5NDc5ZDBjYjdlYjYz
MmJhNDQzYjhjYWNkMjBjZDRiICIgIlBNIC8gc2xlZXA6IEdvIGRpcmVjdF9jb21wbGV0ZSBpZiBk
cml2ZXIgaGFzIG5vIGNhbGxiYWNrcyIKYzYyZWM0NjEwYzQwYmNjNDRmMmQzZDVlZDFjMzEyNzM3
Mjc5ZTJmMyAiUE0gLyBjb3JlOiBGaXggZGlyZWN0X2NvbXBsZXRlIGhhbmRsaW5nIGZvciBkZXZp
Y2VzIHdpdGggbm8gY2FsbGJhY2tzIgoKYW5kIEkgd2lsbCB0cnkgcmV2ZXJ0IHRob3NlIGxvZ2lj
IGFuZCB1cGRhdGUgbGF0ZXIuCiAgCiAKPgo+dGhhbmtzLAo+Cj5ncmVnIGstaAoKCkRhdmlk

