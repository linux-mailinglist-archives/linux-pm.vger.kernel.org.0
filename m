Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AA1F9DC1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 18:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgFOQoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 12:44:32 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21317 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbgFOQoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 12:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592239465; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gzJFOxzePLrhAGO6yZASWVqRUFnTSbwx/UV/OhRuXuLycaVvot5B4TUVKUz5OKdaoJBfc2KI36bMqckNeEhAHSrrP+FripHmloBpoCH6kyBJNEZZnXtm1pxbeVZ4NEoF1yx3w8LRnl8Oes4nKPwdlLUIkcCQRf6C86yPHUy6Qck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1592239465; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=3BtunwQNhfmUev5u561de8qnJRR0tjvZ7JoHFd/7YyM=; 
        b=jvNu7aQK8g816Ow3j6ydO90eg3q0A2Q4eJHIB7ox9ivqnuIiZqD/DYiBCDDoa3nzTSUBVybTJGYobbFqhCryhfp7sXwm9zmOmY3x4lQG4WaLuznDMvttEMjXXCob7iO0k8wc/1G5GbeI2ItWNveLPhvXX/oUB+JGryIFRSGFjd4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=qubes-os.org;
        spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
        dmarc=pass header.from=<frederic.pierret@qubes-os.org> header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592239465;
        s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
        h=Subject:References:To:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type;
        bh=3BtunwQNhfmUev5u561de8qnJRR0tjvZ7JoHFd/7YyM=;
        b=SbkwnCqztJh7yZ0COESlgz7HV/ITAMq/o1qED3BynLPuN8xYV9kE1nXlpj7BJ5IN
        p2dbp78oEPDNdH7rK4nyATnI9Pr+tnCS0nmWgTQEIZh2bdIs7F7o2XDqZ5DqB7wFzge
        jiymhGk3hmw66NQL6uxxxyLCcmlJwWsvXY1VJwPE=
Received: from [10.137.0.45] (92.188.110.153 [92.188.110.153]) by mx.zohomail.com
        with SMTPS id 1592239462374549.545096427669; Mon, 15 Jun 2020 09:44:22 -0700 (PDT)
Subject: Re: dummy-psu
References: <a8223cce-636f-578b-7304-eb0e4868e018@qubes-os.org>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
From:   =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?= 
        <frederic.pierret@qubes-os.org>
Message-ID: <ccb6ed3d-db27-1648-d4bd-94efc8508e41@qubes-os.org>
Date:   Mon, 15 Jun 2020 18:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a8223cce-636f-578b-7304-eb0e4868e018@qubes-os.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nApEuuY79cy3RBhIVAbyWc694u2BgssEE"
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nApEuuY79cy3RBhIVAbyWc694u2BgssEE
Content-Type: multipart/mixed; boundary="VJo6B20cQaE7ukLT6HgoD8eqLpCN6lKjm"

--VJo6B20cQaE7ukLT6HgoD8eqLpCN6lKjm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear all,
Just a little ping to know if anyone has been interested in this project.=


Best regards,
Fr=C3=A9d=C3=A9ric Pierret

On 2020-06-05 16:02, Fr=C3=A9d=C3=A9ric Pierret wrote:
> Dear all,
>=20
> I'm working on a kernel module currently called "dummy-psu" (https://gi=
thub.com/fepitre/dummy-psu) which creates a power supply AC and a battery=
 like in 'drivers/power/supply/test_power.c'. After loaded, this driver a=
llows to modify integer values of the virtual psu created through its sys=
fs attribute directly. String values are currently set through module par=
ameters. Such module allows for example to test ACPI tools or desktop plu=
gins.
>=20
> In the context of the Qubes OS project, it allows to setup into a VM, P=
SU components with real information coming from the host system battery o=
r ac with some refresh time.
>=20
> I'm writing to you to know if you would be interested to have such modu=
le integrating side to test_power.c.
>=20
> Another name could be "virtual-psu". Any kind of improvements are very =
welcomed. Thank you.
>=20
> Best regards,
> Fr=C3=A9d=C3=A9ric Pierret
>=20


--VJo6B20cQaE7ukLT6HgoD8eqLpCN6lKjm--

--nApEuuY79cy3RBhIVAbyWc694u2BgssEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn6ZLkvlecGvyjiymSEAQtc3FduIFAl7npVwACgkQSEAQtc3F
duL4CBAArTKQe82V738uxiBqjretSp7em9GrzWrcvuaxiS+yZzMqhGKTt3qFvhCQ
f0lQSwa3y+VyAwN4kEFcfOtUbHpQf+szKybrh4QExnOMk6+WrrGQGpGWwqcyidUp
398xwNhsKWTulAQ4tEu+rMh2sSoaAjLtvTm6WfinxfjefgkUZ6TJcOtPbf75tdMA
bcATPpFXSflwNBcKc5YiaNvw3p6AVCv7QbG6tfW69+tX0mdIvcAeVp7RtlgcPvOs
OjzOFniYMiv5uWGvXMBOfQtLWdReONDU0umkgURlKeEbCl7I/pHOVGFU9li4WZsR
EtDV6Ds2JErlHO3VQ40P+2WxMONz7OWJC+0uWq7Drbcb80tIOh1xX+kR3Rg92RSq
RJ9ZZ8GBbmGlSiP6VhnzpxyFG5v840ENawOXuIx5KmOoAIHqNaJLUiJ0uLg2nUiN
BpQsjogg1lzkO0zraHlb15bHMiI1mDhzCYiCbGacjNV+c1qONrVllvHVY85vT7Fc
DrnyBjSiKqMnWxQyu9Cv0V53afLnGq/+IfT7jE9TwtOellLLQel5hAGdHxC0uMxS
M85Kr6Z/Mln9g1pwaZSm83fvydoa0HJ6fLNTzc5Zh7SGhSJjCItyGrw5jBXxo9ko
CcZfeAfeOPm80KGZ+S58X1F1j7c8clUcGOVDjGb63a8RVo/+3+4=
=Ki1q
-----END PGP SIGNATURE-----

--nApEuuY79cy3RBhIVAbyWc694u2BgssEE--
