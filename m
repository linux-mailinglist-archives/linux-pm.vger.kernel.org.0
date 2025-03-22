Return-Path: <linux-pm+bounces-24429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB97DA6CB93
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A10A16E106
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CFE16DECB;
	Sat, 22 Mar 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="gk2OfcHW"
X-Original-To: linux-pm@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [82.94.249.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7FB22318
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.94.249.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742663676; cv=none; b=fWklJAA+Cp4VPc/ESX8YFgkBC7sExiHPLM7sFlnT//gbpVRcsdQJVNtfI7+/R7N0479PEnTxLeI4gimFik+v1mwRpksnlpT2JSIh4IQXrUlofhIO7Oa+sRp3oueM1mPAOTbqQ9QhtmdCb8zJS/l8SBfsBHpiO9ZqNV5GmTpuWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742663676; c=relaxed/simple;
	bh=au+yljSMjctj4dEiq1ddcWMUfVe+yy+Bxe85yyInsqo=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=LrqH8HB7JGFCzN/GJtIMc+ewgKrp5Ba29SKElDIAv61bAJeBSdw/nmQoW5P4wV/0otU3C0pszCbd+9OOZGWh4QtJ2ZWbI/mZwrM0pX80JvwzvgeNwveE8k9Z2BCqq6xfysGkz0R7+gb8OObeNiWYVObjlR5uVjbvs7wpSsbuHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=gk2OfcHW; arc=none smtp.client-ip=82.94.249.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1742663063;
	bh=f1mTLMRt3XHthIxze0PAtoVs+DWkMNn2LidG7T+zus4=;
	h=Date:From:To:Cc:Subject:From;
	b=gk2OfcHWGQGzGfym6yyENOuCJLB8K4OYMWKJ4AFb7P0yoDJ0qfg3XQyy+GZYoq07y
	 MLAI9hceCVUqCyhpm5GlNsLbmHH4ZiON43UMS8VAgYv2t05YEYYJCXgO6mTwBQSaqp
	 m+ixJhBfqq/aTuzVCIRwHBIV8aSwBDyqbEKb2fnQ=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4ZKlzC2p7ZzGp4d;
	Sat, 22 Mar 2025 17:04:23 +0000 (UTC)
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4ZKlzC2cy2zGp4Y;
	Sat, 22 Mar 2025 17:04:23 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.1)
	(envelope-from <invernomuto@paranoici.org>)
	id 1tw2Gj-00000000OAX-3Wi5;
	Sat, 22 Mar 2025 18:04:21 +0100
Date: Sat, 22 Mar 2025 18:03:57 +0100
From: Francesco Poli <invernomuto@paranoici.org>
To: linux-pm list <linux-pm@vger.kernel.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: cpupower: systemd unit to run cpupower at boot
Message-Id: <20250322180357.1c17a180f1808533de77f186@paranoici.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Sat__22_Mar_2025_18_03_57_+0100_KTxyxrej=eZjFosd"

--Signature=_Sat__22_Mar_2025_18_03_57_+0100_KTxyxrej=eZjFosd
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__22_Mar_2025_18_03_57_+0100_x59OeMwBaG2EwAr0"


--Multipart=_Sat__22_Mar_2025_18_03_57_+0100_x59OeMwBaG2EwAr0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Linux CPU power monitoring subsystem maintainers,
the 'cpupower' program is a very convenient tool to manage
cpufreq/cpuidle tunables.  Thanks for maintaining it!

The typical use case requires to run 'cpupower' at boot, in order to
set the desired values (governor and/or min and max frequencies, and so
forth).  It may be run in other situations, but, in my experience,
'cpupower' is usually run at boot and then forgotten.

However, there is no convenient way to automatically run 'cpupower' at
boot with the desired options.  Unless the GNU/Linux distribution you
are using provides one, I mean...
I've seen people who put some commands into the deprecated 'rc.local'
file and all other sorts of do-it-yourself strategies to run 'cpupower'
at boot.

It would be nice, if 'cpupower' came with some upstream-maintained
mechanism to run it at boot.

I use Debian GNU/Linux, which provides no such mechanism.  So I thought
I could build one.
I took a look at how this is done in the [Arch Linux package] and I
enhanced/modernized the systemd unit (the three files in Arch Linux are
released under "GPL-2.0-or-later" terms).

[Arch Linux package]: <https://gitlab.archlinux.org/archlinux/packaging/pac=
kages/linux-tools>

The attached files are tested on Debian GNU/Linux trixie (current
Debian testing, which will be released as stable Debian 13 in some
months, possibly on next summer) and work fine for me and for some
other people.
The 'cpupower.sh' script has been further improved, after analyzing it
with 'shellcheck'.

I hereby release the files under the terms of the GNU GPL license,
version 2 or later.
Could you please ship the three files with the official 'cpupower'
tool?

Thanks for reading so far and for considering my little contribution.
Please let me know, thanks for your time!


N.B.:
As I am sure you know, if a user wants to manually install the
three files, the commands are:

  # install -m 644 cpupower.default /etc/default/cpupower
  # install -m 755 cpupower.sh /usr/libexec/cpupower
  # install -m 644 cpupower.service /usr/lib/systemd/system/
  # systemctl daemon-reload

After this manual installation, the '/etc/default/cpupower' file can be
edited as appropriate and then the following command can be issued:

  # systemctl enable --now cpupower.service





--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Multipart=_Sat__22_Mar_2025_18_03_57_+0100_x59OeMwBaG2EwAr0
Content-Type: application/octet-stream;
 name="cpupower.default"
Content-Disposition: attachment;
 filename="cpupower.default"
Content-Transfer-Encoding: base64

IyBkZWZhdWx0cyBmaWxlIGZvciBsaW51eC1jcHVwb3dlcgoKIyAtLS0gQ1BVIGNsb2NrIGZyZXF1
ZW5jeSAtLS0KCiMgRGVmaW5lIENQVSBnb3Zlcm5vcgojIHZhbGlkIGdvdmVybm9yczogb25kZW1h
bmQsIHBlcmZvcm1hbmNlLCBwb3dlcnNhdmUsIGNvbnNlcnZhdGl2ZSwgdXNlcnNwYWNlLgojR09W
RVJOT1I9J29uZGVtYW5kJwoKIyBMaW1pdCBmcmVxdWVuY3kgcmFuZ2UKIyBWYWxpZCBzdWZmaXhl
czogSHosIGtIeiAoZGVmYXVsdCksIE1IeiwgR0h6LCBUSHoKI01JTl9GUkVRPSIyLjI1R0h6Igoj
TUFYX0ZSRVE9IjNHSHoiCgojIFNwZWNpZmljIGZyZXF1ZW5jeSB0byBiZSBzZXQuCiMgUmVxdWly
ZXMgdXNlcnNwYWNlIGdvdmVybm9yIHRvIGJlIGF2YWlsYWJsZS4KIyBJZiB0aGlzIG9wdGlvbiBp
cyBzZXQsIGFsbCB0aGUgcHJldmlvdXMgZnJlcXVlbmN5IG9wdGlvbnMgYXJlIGlnbm9yZWQKI0ZS
RVE9CgojIC0tLSBDUFUgcG9saWN5IC0tLQoKIyBTZXRzIGEgcmVnaXN0ZXIgb24gc3VwcG9ydGVk
IEludGVsIHByb2Nlc3NvcmUgd2hpY2ggYWxsb3dzIHNvZnR3YXJlIHRvIGNvbnZleQojIGl0cyBw
b2xpY3kgZm9yIHRoZSByZWxhdGl2ZSBpbXBvcnRhbmNlIG9mIHBlcmZvcm1hbmNlIHZlcnN1cyBl
bmVyZ3kgc2F2aW5ncyB0bwojIHRoZSAgcHJvY2Vzc29yLiBTZWUgbWFuICgxKSBDUFVQT1dFUi1T
RVQgZm9yIGFkZGl0aW9uYWwgZGV0YWlscy4KI1BFUkZfQklBUz0K

--Multipart=_Sat__22_Mar_2025_18_03_57_+0100_x59OeMwBaG2EwAr0
Content-Type: application/octet-stream;
 name="cpupower.service"
Content-Disposition: attachment;
 filename="cpupower.service"
Content-Transfer-Encoding: base64

W1VuaXRdCkRlc2NyaXB0aW9uPUFwcGx5IGNwdXBvd2VyIGNvbmZpZ3VyYXRpb24KQ29uZGl0aW9u
VmlydHVhbGl6YXRpb249IWNvbnRhaW5lcgoKW1NlcnZpY2VdClR5cGU9b25lc2hvdApFbnZpcm9u
bWVudEZpbGU9LS9ldGMvZGVmYXVsdC9jcHVwb3dlcgpFeGVjU3RhcnQ9L3Vzci9saWJleGVjL2Nw
dXBvd2VyClJlbWFpbkFmdGVyRXhpdD15ZXMKCltJbnN0YWxsXQpXYW50ZWRCeT1tdWx0aS11c2Vy
LnRhcmdldAo=

--Multipart=_Sat__22_Mar_2025_18_03_57_+0100_x59OeMwBaG2EwAr0
Content-Type: text/x-sh;
 name="cpupower.sh"
Content-Disposition: attachment;
 filename="cpupower.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh
# Copyright (C) 2012, S=C3=A9bastien Luttringer
# Copyright (C) 2024, Francesco Poli <invernomuto@paranoici.org>
# SPDX-License-Identifier: GPL-2.0-or-later

ESTATUS=3D0

# apply CPU clock frequency options
if test -n "$FREQ"
then
    cpupower frequency-set -f "$FREQ" > /dev/null || ESTATUS=3D1
elif test -n "${GOVERNOR}${MIN_FREQ}${MAX_FREQ}"
then
    cpupower frequency-set \
      ${GOVERNOR:+ -g "$GOVERNOR"} \
      ${MIN_FREQ:+ -d "$MIN_FREQ"} ${MAX_FREQ:+ -u "$MAX_FREQ"} \
      > /dev/null || ESTATUS=3D1
fi

# apply CPU policy options
if test -n "$PERF_BIAS"
then
    cpupower set -b "$PERF_BIAS" > /dev/null || ESTATUS=3D1
fi

exit $ESTATUS

--Multipart=_Sat__22_Mar_2025_18_03_57_+0100_x59OeMwBaG2EwAr0--

--Signature=_Sat__22_Mar_2025_18_03_57_+0100_KTxyxrej=eZjFosd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmfe7X0ACgkQPhwn4R9p
v/5bqBAAwkfPp2SUoMGO+wCQ6H4jDRpo8VniDC4uAUhyESnEvrACdX7tgMHn0PEe
oPFFdINatZjX+LHx7R+MhAaXBrtIrDjDFHignWkXXMjrJWbFZbPuukJR+Ml12o6W
bcJ+7CUJS1ZN5soyKL3+RFq09sAnuy62+G8fLr70OKSANonZrWTo7hFtOnNTRxKC
I/BaPgFIomoUezL/a06f4kvK5XFu0aStkMgifKYRrPiWw6EcXVxpuM0pqZ9u0klH
H3/N4/H10KE6/q4RG2zBTgoQnxsrdzTv4CfqHBx0/S7IrILx62dzXkw171ZWxoK5
B3z4DmjCX68Lg1Bs+F53HZ0msCRvon7J2j2JqhP8xTD4pnwDx6JxHZar3roexWQj
qcdA3u9kPKGN9Gq0uSd4ssj85Y9YCJmNH29GenVjjS73PN0/g+mK76qej8FEAXbf
46dCzSrrqApAC9HPRZ3986wdoojkKNjsMuArstidPQxDQJyM/vF5GsagC5otuYxI
s1cDAskbRThEneTx5Xez92LvCS2l64Cr0DsFPyXf6ggd4uK66eGo5aESdmW7c9di
aMDhf36RooJhM8ySRfP9U1vjinu5c6wCthoMAhZ8e5RH+2WqJEl8YWNZwElE1Vni
/x/xNF2DhnCXXffNK2GSB5xwTcswdjs6gHxQXdw12mRWmmvH6BE=
=Sz0a
-----END PGP SIGNATURE-----

--Signature=_Sat__22_Mar_2025_18_03_57_+0100_KTxyxrej=eZjFosd--

