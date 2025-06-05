Return-Path: <linux-pm+bounces-28161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE54ACF4E0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 19:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFD23AE0DF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166F1A7045;
	Thu,  5 Jun 2025 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=moritz.lienau@gmx.de header.b="kInt9oam"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801831DFF8
	for <linux-pm@vger.kernel.org>; Thu,  5 Jun 2025 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142860; cv=none; b=o6nlRBFtHBuItgsC17yPn6wKTW73nuWkVeqdNMOkAoNVRmJhRsoye1DOVRJ3VqDNNeLyEDQl3Z8wA4bSnZDn+G7sX+SVVIdBje0xHJ1bAdGNSFBwNI0Bwdi21vrgRtTT17PQufUXtL3cpieIj3IefyJsWhd+yB6k3OqU7eXi+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142860; c=relaxed/simple;
	bh=TNkpVnI+KeHVLr1DBdeDOyKHLEVxfkAxHNJtngM2fuI=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=HKH2cJWbopXG1NEwgKaeCSX19E8g4oYhlLm70ftttdxTOi1A3w4PfKttNcK7HdccuJUPVoVqDFQ+f1oQV/6K+HwyQX8EPlxoQ04pKinQrX9a6g4adFddQxwrEc6xg3ur+gDCXmUlAAsu/F+fjzWV7aAJ8DwoH0g9loaxmm1VEEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=moritz.lienau@gmx.de header.b=kInt9oam; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749142856; x=1749747656; i=moritz.lienau@gmx.de;
	bh=TNkpVnI+KeHVLr1DBdeDOyKHLEVxfkAxHNJtngM2fuI=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kInt9oamLNL7J3qSSA21peCTFqvHxh8QarrTBofHRdENrR3J5E6Sy35XFNM7oIDj
	 WfoFeAhBLa42RsvIGlv2Ix5h55uR2cDtrM13WLwGLriIH12e+S65aenHk/TYdu3sS
	 mmla8GE/tbI0/aU2JbX8pHtVPZrWUhk2G/Dz4dhQ4To3mFQPAQjiAA71ZAHznni2H
	 j3mK6699WQZXwEfHB+e6PlidFzqfDtFGg/4CIpJqSXbgRM2RCTp+C/AuBjr/ysoh+
	 0LGyvXXfvBFgfbfK4xiYL4arNfcgzkTGR8UeknPPzZmEdxXpSiBNk+GNUtRHLjSsr
	 fiWgyKUS86xlbEanSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.65.234.123] ([100.65.234.123]) by
 trinity-msg-rest-gmx-gmx-live-5d9b465786-trjg7 (via HTTP); Thu, 5 Jun 2025
 17:00:56 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-970d44a5-310b-432d-b4b9-9008299746ad-1749142856337@trinity-msg-rest-gmx-gmx-live-5d9b465786-trjg7>
From: moritz.lienau@gmx.de
To: linux-pm@vger.kernel.org
Subject: Assistance with intel_idle and c-states
Content-Type: text/plain; charset=UTF-8
Date: Thu, 5 Jun 2025 17:00:56 +0000
Content-Transfer-Encoding: quoted-printable
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:D8NWjl1SE4tTpRwM4p8a6m2zdPMszCL6s6MxLRRM4fRB/0UikwoP8l9zjjyb0P9hHl+g7
 5nzfNLeIP+S5By8satChtWZJ3291wxFlWcCqYSAN/n/J+kPNweY9owJo4bb9KKtraVliOuPvpALm
 i955/fpOW+XgBpZ7CAbljp40AlW83kPQs9rre5KfLvXi3z0oXe0ZJtESpeWuYg7YF27F6mpJ6U3T
 6r8N+6SDW2WHJtr6+AScdmLEnqCoo1B9OWUgq5cI4Ft0A6KE8AcPTxwEWDdfUoI6ITSpie/YR2r2
 eABrfYyRDMseKSkQ2FpC+D4Pk47z16irvtovm6uJTNWrtbZVgaSnGlIGJkgic30/Wrq8YkBroROc
 vmXk5AHAGAz
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KWL0Jq97gSs=;3Tcwxu7uMZw9Dpcs33b+lObRG4Q
 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
 YlSYoLFQwhDgNy8/kioU5oSCEgjauZqtNjxGA==

Dear Power Management Team,

I'm currently building my own home server using the Intel i5-14500T and wo=
uld
like to take advantage of the Intel C states for improved power efficiancy=
=2E
Sadly I have not been able to get the c states running in my proxmox kerne=
l=2E
Unfortunately, I haven't been able to get C-States working on my Proxmox k=
ernel=2E
I've verified that my hardware supports deeper C-States, updated all drive=
rs and
the microcode to version 0x3a, and even tested with a more recent kernel u=
sing
Fedora Workstation 42 - but with no success=2E All I get are the acpi stat=
es from
c1-c3 and POLL=2E
After looking into the matter I stumbled accross your intel_idle=2Ec insid=
e the
pve-kernel I've pulled from git=2E
It appeared as if the file has not been updated since 2020 since the copyr=
ight
is also from that year=2E Since the i5-14500T was released after that, I w=
onder if
support for it might be missing=2E

I would really appreciate your guidance on whether a newer version of the =
file
is available or it's possible to manually patch or modify the existing cod=
e to
support this cpu=2E
I=E2=80=99m not very familiar with C or linux kernels, so any help would b=
e extremely
helpful=2E
I hope it's okay to contact you directly=2E

Thank you in advance for your time and help=2E

Best regards,
Moritz Lienau

