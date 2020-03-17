Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35961188922
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 16:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCQP0S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 11:26:18 -0400
Received: from mx3.freesources.org ([195.34.172.217]:57250 "EHLO
        mx3.freesources.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQP0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 11:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=freesources.org; s=20160526; h=Content-Type:In-Reply-To:MIME-Version:Date:
        Message-ID:Subject:References:Cc:To:From:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+vzL6yTntdZOAShQvAqIoGWMH0J9RRHNrOnPypYEikI=; b=F6oCQ38gU8hgYiygMCUCp8HoU
        r3xeG0qYNaQPgt8amHiGkhlNZLr0wTgCvYou6l/FzLmgfFNdCv2tgomLEX0cOjaryn8dOnRJsSP6w
        FrJ/gjEYESg97RzM/osaOqFbo8+CPyM2wLOmCXC72FyP+duxaafN/3Wiin/5JkFQjQxvg=;
Received: from ip-95-223-73-47.hsi16.unitymediagroup.de ([95.223.73.47] helo=[192.168.0.143])
        by mx3.freesources.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <jonas@freesources.org>)
        id 1jEE6h-00084m-BL; Tue, 17 Mar 2020 15:26:15 +0000
From:   Jonas Meurer <jonas@freesources.org>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Tim Dittler <tim.dittler@systemli.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <8a91f5f0-2180-a7f2-1c22-49b2038e1fbd@freesources.org>
 <efee087b-756d-046b-f161-192682772ee3@freesources.org>
Autocrypt: addr=jonas@freesources.org; prefer-encrypt=mutual; keydata=
 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
 2SCIHpzHfm/mpRL2
Subject: Re: RFH with debugging suspend issues
Message-ID: <cfeff7f6-5a5c-433d-3906-2edae84f1ad9@freesources.org>
Date:   Tue, 17 Mar 2020 16:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <efee087b-756d-046b-f161-192682772ee3@freesources.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bas8JfLHXAhyznufCSVd5XuGgLvO9SXrr"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bas8JfLHXAhyznufCSVd5XuGgLvO9SXrr
Content-Type: multipart/mixed; boundary="F2qgewK0XigJ4B0e67AIuoIUZgyjpOh02";
 protected-headers="v1"
From: Jonas Meurer <jonas@freesources.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Tim Dittler <tim.dittler@systemli.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID: <cfeff7f6-5a5c-433d-3906-2edae84f1ad9@freesources.org>
Subject: Re: RFH with debugging suspend issues
References: <8a91f5f0-2180-a7f2-1c22-49b2038e1fbd@freesources.org>
 <efee087b-756d-046b-f161-192682772ee3@freesources.org>
In-Reply-To: <efee087b-756d-046b-f161-192682772ee3@freesources.org>

--F2qgewK0XigJ4B0e67AIuoIUZgyjpOh02
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello again,

sorry for Cc'ing you directly, Rafael. But I'm not sure whether anybody
reads the linux-pm mailinglist without beeing addressed directly ;)
Maybe you can point us to a better place to ask for help here?

Jonas Meurer:
> Jonas Meurer:
>> I'm searching for help with debugging a suspend issue:
>>
>> Apparently, on some devices (Lenovo laptops in particular), the kernel=

>> causes a I/O operation on the root filesystem when suspending the syst=
em
>> - even though the final sync[1] is disabled thanks to setting
>> `/sys/power/sync_on_suspend` to 0, see my corresponding patch that got=

>> accepted in Linux 5.6[2].
>>
>> My current guess it that some hardware-specific firmware is loaded
>> during system suspend. But unfortunately, so far I failed to find what=

>> exactly it is despite following the 01.org debugging documentation[3].=

>> Maybe you can help me shed some light on it?
>=20
> I finally succeeded in reliably tracking this down to firmware loading.=

> With kernel boot parameters `initcall_debug ignore_loglevel`, the last
> logs before my system freezes are:
>=20
> PM: suspend entry (deep)
> (NULL device *): firmware: direct-loading firmware regulatory.db
> (NULL device *): firmware: direct-loading firmware regulatory.db.p7s
> (NULL device *): firmware: direct-loading firmware iwlwifi-8000C-36.uco=
de
>=20
> If I blacklist all modules that cause the kernel to load firmware (for
> me, that's cfg80211, iwlwifi and some bluetooth modules), then the issu=
e
> is gone.
>=20
> So without further investigation I could imagine three possible solutio=
ns:
>=20
> 1. Provide all firmware files to the kernel from the chroot. That
>    probably means to copy the firmware files to initramfs and to make
>    the kernel aware of the new firmware path at
>    `/sys/module/firmware_class/parameters/path`.
> 2. Find a way to manually trigger the firmware loading operation before=

>    we luksSuspend the LUKS devices.
> 3. Find a way do disable direct-loading of firmware by the kernel durin=
g
>    suspend.
>=20
> Maybe someone with more inside knowledge could comment on whether
> options 2 or 3 are possible at all and if not, whether kernel patches t=
o
> implement them would be acceptable.

Any chance to get a comment on this?

Cheers,
 jonas


--F2qgewK0XigJ4B0e67AIuoIUZgyjpOh02--

--bas8JfLHXAhyznufCSVd5XuGgLvO9SXrr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEELIzSg9Pv30M4kOeDUmLn/0kQSf4FAl5w7BQACgkQUmLn/0kQ
Sf4kBxAAm/N7zgCogqjVKE25P1+ZBBNsFe8+ZCxQE68PlvDTmYUIoe97b0WzNNM+
LiTGQUlXflAlW4uv2wod7pPJV0sjdfLNnBvlhCVcHYdFresUV69kMKUjm5dT4MFU
xICv55fwrRpALiNeJ6AGA7LVYgkkKwtf/2tK1Earfgn/2M1l1Ihgj6o58DoQaKBQ
hm+BVxVLUM6FDygtxG8W2nVwOGZAeY7YGTBvAumFY6qLDlvQHaE0uOi0avpQVqoe
wAsiUzCuQy2+eMB5SJpyK1ZvOSi9CDQpOU9mLfkRnDBbTxjsq+eJAmyt2ApxW1e0
UPVWJkUEVNbUaOJNL9Nuu7+yNJsynh/q1fY3V8ZhDVlr7nw/3krIcmqun5e7DPJx
mC3id4thO0f4IKuFKNMoKqO5Q9njDVn7l5cvASnn7d8fJYQLTKyYUDYUNNoNa9/F
KT6DsjmXjXpU4SAQcWGu0Js01DjwAePUiQcHFxjhD35YYRluyp10vbMv/qIDhJhS
Fb+9o4Zne6z+GcS6obUV7so8cVdo13MX64Am+vzDCWi4aEHz1L0+OBeffNjHEr++
y2OOfL5e4lJ8me0HyC9PBOJp7sOraUWJ+o8XXqB9bjdJKELua4wkiHZhOKY+76/a
0t6xxX22hm84mYicQkygZMDVhmmnitqumCUJgDb2xWNjbhJexrQ=
=xRX4
-----END PGP SIGNATURE-----

--bas8JfLHXAhyznufCSVd5XuGgLvO9SXrr--
