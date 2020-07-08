Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A891218280
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGHI3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 04:29:22 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21310 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgGHI3V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 04:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594196951; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jD96cNVk4WverTyy8Fiywg+kdEL/iExZzz/45XYdWKHMcQqWMXjKX7SAVK47EUbHVysVrIgquEj32BdSoqIzyYQPOA6v7jHpKTHd8G1lGNWy1mfVxjrvo/XGD9xg/Js47E3Kv+Tb+8NPHjAVrytRgMMwBbbo5apq+b1GRcTUZE8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1594196951; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=7V0Y1mdQh92BH4uQ2n3obKmr9UwLXUfHi+CMhdVqZ7I=; 
        b=eRhcCNShYcOKjlME9P9tC4Ai3qene2NJJPHEmHdgDZNbSQan6oMU+w4ybDajaJpQYIJx93BG+LX4hFHjIp8VPB+mK58tbLyVPCNBZzJnDg2B3ouoXgqWfezTRRAmQJbQbI9/w/ZhsoZ/bfpls7p2P2P/PINvPB7SIR8UIZmVP+I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=qubes-os.org;
        spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
        dmarc=pass header.from=<frederic.pierret@qubes-os.org> header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1594196951;
        s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type;
        bh=7V0Y1mdQh92BH4uQ2n3obKmr9UwLXUfHi+CMhdVqZ7I=;
        b=dpMIFY/nDn9b7bmIhrA9OBVt4TVjnNylOrM4wh4fHIATv0mAQQFHjysXoZFfihei
        9JyUuX9FEIEs+D/HDGsKLc0uxfQCYp666gB/BPdWTaQ8yJw1oj15GMKyLAT/NFkwsx2
        fSvvDnnUHE/cku2t8Uwb2x6pnEeIfenrXoebt1e4=
Received: from [10.137.0.45] (92.188.110.153 [92.188.110.153]) by mx.zohomail.com
        with SMTPS id 15941969340521007.984087864391; Wed, 8 Jul 2020 01:28:54 -0700 (PDT)
Subject: Re: dummy-psu
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <a8223cce-636f-578b-7304-eb0e4868e018@qubes-os.org>
 <ccb6ed3d-db27-1648-d4bd-94efc8508e41@qubes-os.org>
 <20200619165920.q6oj4w43rqxhoqlp@earth.universe>
From:   =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?= 
        <frederic.pierret@qubes-os.org>
Message-ID: <a23092db-2e3b-e4c3-03b9-a6d5c4d98b21@qubes-os.org>
Date:   Wed, 8 Jul 2020 10:28:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619165920.q6oj4w43rqxhoqlp@earth.universe>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XBQDRtHYLdz3ogl28y10kqi1lQHMCAq1E"
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XBQDRtHYLdz3ogl28y10kqi1lQHMCAq1E
Content-Type: multipart/mixed; boundary="LciCClYidhrukSYD1JcNwbRWwuwpKyvvw"

--LciCClYidhrukSYD1JcNwbRWwuwpKyvvw
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

First of all, thank you for your answer. I'm currently working on a secon=
d version according to your suggestion. Here I'm using ioctl + misc devic=
e in order to register any type of PSU device. I'm only having an issue o=
n how to get the maximum allowed power_supply_property https://git.kernel=
=2Eorg/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/power=
_supply.h?h=3Dv5.7.7#n164. I'm seeing in git log that this enum has new e=
ntries in the middle of it's declaration so getting the upper limit of al=
lowed properties seems tricky.

For example in my current implementation, I'm allowing with ioctl to add =
any number of properties the user want to add before registering. A check=
 is done if the supplied value is in range of zero and currently the uppe=
r limit, POWER_SUPPLY_PROP_SERIAL_NUMBER. Do you have any suggestion on h=
ow should I get this upper limit without hardcoding some specific value? =
This current issue is because I don't want to trust user input...

I'm not C or kernel fluent so I apologize if my question looks stupid.

Best regards,
Fr=E9d=E9ric

On 2020-06-19 18:59, Sebastian Reichel wrote:
> Hi Fr=E9d=E9ric,
>=20
> On Mon, Jun 15, 2020 at 06:44:11PM +0200, Fr=E9d=E9ric Pierret wrote:
>> On 2020-06-05 16:02, Fr=E9d=E9ric Pierret wrote:
>>> Dear all,
>>>
>>> I'm working on a kernel module currently called "dummy-psu"
>>> (https://github.com/fepitre/dummy-psu) which creates a power
>>> supply AC and a battery like in
>>> 'drivers/power/supply/test_power.c'. After loaded, this driver
>>> allows to modify integer values of the virtual psu created
>>> through its sysfs attribute directly. String values are
>>> currently set through module parameters. Such module allows for
>>> example to test ACPI tools or desktop plugins.
>>>
>>> In the context of the Qubes OS project, it allows to setup into
>>> a VM, PSU components with real information coming from the host
>>> system battery or ac with some refresh time.
>>>
>>> I'm writing to you to know if you would be interested to have
>>> such module integrating side to test_power.c.
>>>
>>> Another name could be "virtual-psu". Any kind of improvements
>>> are very welcomed. Thank you.
>>>
>>> Best regards,
>>> Fr=E9d=E9ric Pierret
>>
>> Dear all,
>> Just a little ping to know if anyone has been interested in this
>> project.
>>
>> Best regards,
>> Fr=E9d=E9ric Pierret
>=20
> I think it would be worthwile to have something like this for
> the power-supply framework. This is useful for your VM case,
> testing the power-supply API in a better way than test_power.c
> and for peripheral devices with userspace drivers.
>=20
> But I don't think it's a good idea to use the sysfs files as
> input. There should be support to register multiple virtual
> devices (e.g. battery and AC in your case, or multiple BT
> peripherals). Also the sysfs interface does not allow you to
> change multiple values atomically. I think the proper way is
> to do it the same way as uinput and register a miscdevice.
>=20
> -- Sebastian
>=20


--LciCClYidhrukSYD1JcNwbRWwuwpKyvvw--

--XBQDRtHYLdz3ogl28y10kqi1lQHMCAq1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn6ZLkvlecGvyjiymSEAQtc3FduIFAl8Fg70ACgkQSEAQtc3F
duKYcA//ROWr4FDw3sDN+z94Cx2i6TVI2KDfYwuR3PUDLxNo2ze4tzRKRevt435I
6KoPDHwfQjqYxIRPMbsPov0tzyO5DSwVYxaFSBD1NX4ICop8Tnc983lngRqbXMA7
D4BMvmInmRW/ekXhGd3CY/uye9EME45gRO2M0ZpZG4w2PEJgCfGJmGip7yRVaKYy
9H+iSygSP6pJO2FbKVZxidHe/IoqSJvwAfFtWOls/5sCwfWBTesoOFM9+N8UB5/E
xHMxVkz4sJraOrCtU3VUS/K4H0ygZU21eG1DTSNWdwuILiXvMuRNqb+HNMSbDhjO
M0WcrPYy3PPvA4BWo20iRHUOZhpJKnsfCdJd3FEZ45Ej6mOECSBD9XNJdCwz3lYI
UkPqu9f5QkWZWyIxyaXdzAmU0DwujGYnhQ5wfFKBxlU/aBdhOTuNAvHTU/kRAt1N
3c+nN4PkHSfWklegxbBLooitwGLt2+wXWNt+c5V0mtT/a0yGHDFswwyIdiwlKTIt
OMS35SZnT8JgZ2RY+VSkrHpaT3H0UUToUmUYSyuIgEym7Y2yFDacVMw4BsqCCdaq
wQl2DAte47cTXrpuNJBfhgc8ZmP8aFWe4Y386dmd0YYxaZeP/dZXbdOTj8HJSaDs
Qsx26k8Z82MuVzg0isBGuuCth/YBLnjE4qr3UFQlhVSFHfRfKj4=
=T4S3
-----END PGP SIGNATURE-----

--XBQDRtHYLdz3ogl28y10kqi1lQHMCAq1E--
