Return-Path: <linux-pm+bounces-27905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519B3AC9F7A
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jun 2025 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D27C1892D87
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jun 2025 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA11487E9;
	Sun,  1 Jun 2025 17:21:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from rdmp.org (unknown [195.15.247.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F604437C
	for <linux-pm@vger.kernel.org>; Sun,  1 Jun 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.15.247.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798461; cv=none; b=PxZVb8+/s2T2OFyiCfiHhWo9mAmzofmrM3SRg0w/dXJlu0mEp5FuUvw598RCX95dbCFb8HxVNPojjcwB9zQoiorntarOBkHPMAq1BMcgc2HQBM3INpUcflge61gTeueMMy6OJPlM39hpBC0HuKb/PEDQgfOe6eQm08bdtaRVN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798461; c=relaxed/simple;
	bh=uxMW7mbDxqDVGDiyqSomjrjlKir8TH/biEjeQ5AQHCo=;
	h=Message-ID:Subject:From:To:Date:References:Content-Type:
	 MIME-Version; b=mMqlVhaUxe9AYBZGNM13TpHp7uAp8QbG59ukXVdsu2bUFyMHwjWWrKVbd+cOj6h/WHJLHyND7foSkLlr/U3OptVBNYXhYKXr2UT6NrcGlrMpn8JmiRGfeKrM1/75arEJbBJXPUJBaarWZB6UhVsyeK/sWm1AJPQUDHej29lrIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rdmp.org; spf=pass smtp.mailfrom=rdmp.org; arc=none smtp.client-ip=195.15.247.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rdmp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rdmp.org
Received: from [127.0.0.1] (helo=[IPv6:::1])
	by rdmp.org with esmtp (Exim 4.96.1)
	(envelope-from <no-reply@rdmp.org>)
	id 1uLlxL-0000bX-1c
	for linux-pm@vger.kernel.org;
	Sun, 01 Jun 2025 16:54:43 +0000
Message-ID: <c8c2f8fd741f1d212d67e7b732305c5afc2fa3fb.camel@rdmp.org>
Subject: Ping: How should userland app be notified when kernel comes out of
 suspend or hibernation?
From: Dale Mellor <no-reply@rdmp.org>
Reply-To: mcron-lsfnyl@rdmp.org
To: linux-pm@vger.kernel.org
Date: Sun, 01 Jun 2025 17:54:39 +0100
Autocrypt: addr=no-reply@rdmp.org; prefer-encrypt=mutual;
 keydata=mQGiBEVzDvERBACZX9wo4yeeG5za78Qa3FfgDaKRN3AfZL1j7kF+opTmi9dr+TNlyXaNe
 ZIr1zTLlzEwcQSmA53eGq1nKzaifNuSvOMs458rPOJAkTtQMdR73w6FECU5kQ12WSw8f1l/7rbwLS
 EJws7/7a1TomZloJ4MOzzC7NLaznjpcMnMAbzYAwCgijxh3R8QsuLqKWarKm1LyJf/HuED+wbU5X3
 MwtbsSm/FR5nHxAm3yIlK3oTlsERCm3nQ3yhkCmGMV/wgJ97DfyGr8seoxkhASsfxwXIEaWvs+HTR
 RqLV6Qkvts4KJE/JU6NRw3iN1IWvl78+GBj8gkJWh+WpJ9aCoe5SPC9QAymXHNgss2LaBtugyVcSG
 JxsoFNulBfiA/0fkuPdVT+zHH7TyldCMdPI271RM/48wUiui926sp4xzsw6at1xF39csgQRs7ovY5
 u7/2nqy10gyJ0uiSB+VbU6Gw6u6+kj/gBKjbGkN+q2uOCUhpETDeFCCaYAh5SsVoJvPpaTmCMhWvH
 IWbCikWXF9zip3u8LVaodrUK6DMM0mbQbRGFsZSBNZWxsb3IgPGRhbGVAcmRtcC5vcmc+iGMEExEC
 ACMCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAUCT7coSQIZAQAKCRDKRx/VAWGKSX2cAJ0b/96wa
 xa3oJn0ulHPUrQuybn2zwCeO1LxgKJbJyqikvkXQkJeIykBMBe0IURhbGUgTWVsbG9yIDxncGctbX
 V0d213QHJkbXAub3JnPohiBBMRAgAiBQJYj4buAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAA
 KCRDKRx/VAWGKSb0BAJwL521IItt2DjhgQkzfVEo3Iaq1BgCfamd8jH46nEZmdelguy9qhgFU1zS0
 IURhbGUgTWVsbG9yIDxibGFjay1ob2xlQHJkbXAub3JnPoh4BBMRCgA4FiEE4jwh7YZP9POnEUzfy
 kcf1QFhikkFAmAegbECGwMFCwkIBwMFFQoJCAsFFgMCAQACHgECF4AACgkQykcf1QFhikmzDACdGQ
 JiU5xblgF37KqF5DhFyCYL8RkAn1zmEn5O3OEi8RkdJ135YVk2F0YCtChEYWxlIE1lbGxvciA8Z3V
 peC1kZXZlbC0wYnJnNmFAcmRtcC5vcmc+iHgEExEKADgWIQTiPCHthk/086cRTN/KRx/VAWGKSQUC
 Zj+48gIbAwULCQgHAwUVCgkICwUWAwIBAAIeAQIXgAAKCRDKRx/VAWGKScdFAJ0bIZ2bVJh7B66pO
 QRw3pqMEz0kFgCeOFE3Vir3UeXVpnNoOf3T4ZQ30q0=
References: <1e2af6bddb8cd51e5076285659a6f5bc92b026f9.camel@rdmp.org>
Organization: DM Bespoke Computer Solutions Ltd
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-n0d6J4cei4fxj3B/wYt/"
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-n0d6J4cei4fxj3B/wYt/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just bouncing this back up.  Is anybody able to give any advice?=20
Thanks in advance.

-------- Forwarded Message --------
Date: 02/14/25 23:09:34

I am the originator of the GNU mcron app, which waits (using select)
for set amounts of time before executing some function on behalf of the
user.=C2=A0 But when the system comes out of sleep the timings are all wron=
g
and need to be re-evaluated.=C2=A0 But how does my application know when
this needs to happen?

I'm currently trying to use the ACPI netlink interface, which
conveniently gives me a socket I can add to the select call and wakes
me up when some power-changing event occurs.=C2=A0 However, there is not an
event specifically for notifying the coming out of sleep, and different
systems will have different hardware which reacts in this situation
(the netlink interface has a soft specification and requires
introspection to understand the data it delivers).

What is the 'official' way to do this?



--=-n0d6J4cei4fxj3B/wYt/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iF0EABEKAB0WIQTiPCHthk/086cRTN/KRx/VAWGKSQUCaDyFzwAKCRDKRx/VAWGK
SeX6AJ9JHankohwfM2DRAYjynKaY76z7LwCfZjr8qu4ccYclzeMcahKearW/6HY=
=Ec5w
-----END PGP SIGNATURE-----

--=-n0d6J4cei4fxj3B/wYt/--

