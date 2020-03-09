Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529CB17DF83
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 13:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCIMIs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 08:08:48 -0400
Received: from mx3.freesources.org ([195.34.172.217]:38256 "EHLO
        mx3.freesources.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgCIMIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 08:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=freesources.org; s=20160526; h=Content-Type:In-Reply-To:MIME-Version:Date:
        Message-ID:Subject:References:Cc:To:From:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2bq9N0JBtYGfmrsWl9n1OWu9oAmgUDVz0l6/kVZttzE=; b=M62Lkd1gO3B4OuFBhaph5pcQ4
        lXht9PmvriLivZG6NW5n1m9sK4yDdVtbnErcnZh+FAY/lgOdqoJtjmsarnE+EehWV+VbECpnkXsZa
        iaKROevUTRAtqKosdiR+Nf9m4+7yLcVLA93uwFlVRbniUY9nOo/8INbNDNqWCfo3ZFBxk=;
Received: from ip4d14f93d.dynamic.kabel-deutschland.de ([77.20.249.61] helo=[192.168.178.60])
        by mx3.freesources.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <jonas@freesources.org>)
        id 1jBHD9-0006LR-Ts; Mon, 09 Mar 2020 12:08:43 +0000
From:   Jonas Meurer <jonas@freesources.org>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Tim Dittler <tim.dittler@systemli.org>
References: <8a91f5f0-2180-a7f2-1c22-49b2038e1fbd@freesources.org>
Autocrypt: addr=jonas@freesources.org; prefer-encrypt=mutual; keydata=
 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
 2SCIHpzHfm/mpRL2
Subject: Re: RFH with debugging suspend issues
Message-ID: <efee087b-756d-046b-f161-192682772ee3@freesources.org>
Date:   Mon, 9 Mar 2020 13:08:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8a91f5f0-2180-a7f2-1c22-49b2038e1fbd@freesources.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CDHeYxDIFns2gQiv797qmG8geZKszeHfM"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CDHeYxDIFns2gQiv797qmG8geZKszeHfM
Content-Type: multipart/mixed; boundary="qLZDMs1N5LwWmY1xMk3wGfrrhPrJ0pQJO";
 protected-headers="v1"
From: Jonas Meurer <jonas@freesources.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Tim Dittler <tim.dittler@systemli.org>
Message-ID: <efee087b-756d-046b-f161-192682772ee3@freesources.org>
Subject: Re: RFH with debugging suspend issues
References: <8a91f5f0-2180-a7f2-1c22-49b2038e1fbd@freesources.org>
In-Reply-To: <8a91f5f0-2180-a7f2-1c22-49b2038e1fbd@freesources.org>

--qLZDMs1N5LwWmY1xMk3wGfrrhPrJ0pQJO
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello again,

Jonas Meurer:
> I'm searching for help with debugging a suspend issue:
>=20
> Apparently, on some devices (Lenovo laptops in particular), the kernel
> causes a I/O operation on the root filesystem when suspending the syste=
m
> - even though the final sync[1] is disabled thanks to setting
> `/sys/power/sync_on_suspend` to 0, see my corresponding patch that got
> accepted in Linux 5.6[2].
>=20
> My current guess it that some hardware-specific firmware is loaded
> during system suspend. But unfortunately, so far I failed to find what
> exactly it is despite following the 01.org debugging documentation[3].
> Maybe you can help me shed some light on it?

I finally succeeded in reliably tracking this down to firmware loading.
With kernel boot parameters `initcall_debug ignore_loglevel`, the last
logs before my system freezes are:

PM: suspend entry (deep)
(NULL device *): firmware: direct-loading firmware regulatory.db
(NULL device *): firmware: direct-loading firmware regulatory.db.p7s
(NULL device *): firmware: direct-loading firmware iwlwifi-8000C-36.ucode=


If I blacklist all modules that cause the kernel to load firmware (for
me, that's cfg80211, iwlwifi and some bluetooth modules), then the issue
is gone.

So without further investigation I could imagine three possible solutions=
:

1. Provide all firmware files to the kernel from the chroot. That
   probably means to copy the firmware files to initramfs and to make
   the kernel aware of the new firmware path at
   `/sys/module/firmware_class/parameters/path`.
2. Find a way to manually trigger the firmware loading operation before
   we luksSuspend the LUKS devices.
3. Find a way do disable direct-loading of firmware by the kernel during
   suspend.

Maybe someone with more inside knowledge could comment on whether
options 2 or 3 are possible at all and if not, whether kernel patches to
implement them would be acceptable.

Cheers
 jonas

PS: Inside our Debian cryptsetup-suspend project, we track this issue at
    https://salsa.debian.org/mejo/cryptsetup-suspend/issues/38


--qLZDMs1N5LwWmY1xMk3wGfrrhPrJ0pQJO--

--CDHeYxDIFns2gQiv797qmG8geZKszeHfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEELIzSg9Pv30M4kOeDUmLn/0kQSf4FAl5mMcgACgkQUmLn/0kQ
Sf6uyA//Yz2q+1UfB2EQTGZoqLqSuF0FeEeh3cbNU3aQW6FpdCCDb0rH5nZiLAEE
wvjszVPLAXBUPFl+KCix1vSpYbXh61LXrAllOXLvQbm93Lxawu0glwZq0sgj+Jwo
4VcYyYGxbn8X6oBgRPwxin/CPGg1diDLQ9kOlC+9DPGnvNDfz/nWTMzrL3FA6MSF
6DCkY9my9Q8kjIxo6I43V75+acTjyeAMjeUv/3+DRq9otM7+qnLOrNurldqsqHt7
7cKHrDWcEdY+ay0iITwUamK+Ut/2/vbVnlDOZArUP+R2kpJ/d2WOXZofYZ30UxbJ
sa0gYV2/nExSBHgClaLkAcDLLz3M5zuvRGTlwMKzqVOa4Qrn0XhXguNfd9umCHpz
eEhr/XTsYuJ73KeC+mspW8E60h7r2cidzceDZZI+wBt1np/kCTjehnXxfL0d+ffN
YlmKcoPGn4Q7rprZ8B1EXa0EaiJUh6tvzuim/VljAZCqSRfsyV4EaQBrixqcgfa9
G6+Z1oUiyYYGHF0Rsgkj7VmAq88cYeNPl3DDVN1N1K47j+t396HPT7WZSEvz2ajv
pTgS0jer84wwUySnDYHaUKCmxfVi0K6NN/K88SrnNAnZYVXJ9N5DsqikH14HOv8R
/qQwKbglBXuN+Y/dm/TM6NAvqOAQSxH6l/BuBdL5q2396rOfB2g=
=4MSq
-----END PGP SIGNATURE-----

--CDHeYxDIFns2gQiv797qmG8geZKszeHfM--
