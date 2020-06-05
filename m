Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37C01EF9DE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgFEOCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 10:02:37 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21309 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgFEOCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 10:02:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591365749; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ktCgRGRp5TNqHHuH+3Op5mSa6e1yqaFYnnRSnVES9IDY+m5XhkkhZrse//utnsUXsak5ClNqx1EqDJtCPvp+QeqJaVY0OhquLDKJs7VjCpQ3cFGWPIvh/jqdW5gcYxt+i4ntS8uaaCS6Gu/YLwACo7GjR1DB28snZDiUup30Ikg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591365749; h=Content-Type:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6259WH+8GXwpvJ8L+deRyee+WkZ0pOpRoX37oxGIAHU=; 
        b=LBri1xZLqTf0J1cChmT7XxOPn14gXcF3St4xwojDYcZ7RYkf272OknD4gnT71FImKKcAProAIljaT1DvfTuDUXrkU79kQTW+p1rHHM0YHRNeDMg+o4pvhMhkYbcp7KW3jSODDv3+W7jhD3kP2c6GjQGBfqvbbRJurb7XOqFbaEM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=qubes-os.org;
        spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
        dmarc=pass header.from=<frederic.pierret@qubes-os.org> header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591365749;
        s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
        h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type;
        bh=6259WH+8GXwpvJ8L+deRyee+WkZ0pOpRoX37oxGIAHU=;
        b=PQlhbHNnQoOueWb9PqTzjCU6sGXjaZb6+/pClUk1jSGTXgTyd/Kz6rLsR/29AeBM
        V6gZ+bPuhS05J3Wh58exvfU2CkV+BFClmU4SdauyTNARvQwA6ZPdFKz36P3KolHGn2G
        7pTUEuYsu5aK8jgQuurau1/u9wKf6zUWfM+0woKM=
Received: from [10.137.0.45] (92.188.110.153 [92.188.110.153]) by mx.zohomail.com
        with SMTPS id 1591365745631622.3889732173463; Fri, 5 Jun 2020 07:02:25 -0700 (PDT)
From:   =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?= 
        <frederic.pierret@qubes-os.org>
To:     linux-pm@vger.kernel.org
Cc:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: dummy-psu
Message-ID: <a8223cce-636f-578b-7304-eb0e4868e018@qubes-os.org>
Date:   Fri, 5 Jun 2020 16:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GvWCsJwxqkqQJXB20RU5x6EHX1jiBEgQD"
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GvWCsJwxqkqQJXB20RU5x6EHX1jiBEgQD
Content-Type: multipart/mixed; boundary="4h2qsgUTaQmHOYZN8q5lBhTKIZDKyEhvI"

--4h2qsgUTaQmHOYZN8q5lBhTKIZDKyEhvI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear all,

I'm working on a kernel module currently called "dummy-psu" (https://gith=
ub.com/fepitre/dummy-psu) which creates a power supply AC and a battery l=
ike in 'drivers/power/supply/test_power.c'. After loaded, this driver all=
ows to modify integer values of the virtual psu created through its sysfs=
 attribute directly. String values are currently set through module param=
eters. Such module allows for example to test ACPI tools or desktop plugi=
ns.

In the context of the Qubes OS project, it allows to setup into a VM, PSU=
 components with real information coming from the host system battery or =
ac with some refresh time.

I'm writing to you to know if you would be interested to have such module=
 integrating side to test_power.c.

Another name could be "virtual-psu". Any kind of improvements are very we=
lcomed. Thank you.

Best regards,
Fr=C3=A9d=C3=A9ric Pierret


--4h2qsgUTaQmHOYZN8q5lBhTKIZDKyEhvI--

--GvWCsJwxqkqQJXB20RU5x6EHX1jiBEgQD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn6ZLkvlecGvyjiymSEAQtc3FduIFAl7aUG0ACgkQSEAQtc3F
duJTmA//RVZRomMOjJ45DL9AfphaEubm6x5dwZcWzLbVShhUHkBqSbAUI6ElAQ7s
xfghxttWuEYhtd5hgV48nHmt55lkTvyDSfw57WnhQ1jWSQCzRqltfVkL9prKpq3M
Nfl8z6wH/RXyyJaYj4GVzLU+0BtxBPWFQJJo+vnbM/NxEgGQwuWKYYHN1LaerqAS
24EizMQOLbDO/0toan0554OZBzrNz1LzWezX6aQy3SjlhqZ59SaCqWGM08CAQ2VY
NR02LxPLdkz+IbVZBwF0WEb0yDUASQyl7BA1nBaP5FcC8QizGSZR9XKarupVVya0
FE8RWAZHPFIDn9gjEM0d2QOipedLsyoJsKiZ6txIPpV+lKtaHujswku5PZHElhw+
mwLKTq1433xizK/EledlFXpDlHW4bTop6B+0d+afI3Dzm20CnaTgIon0CHwpEXn+
wOPCOUqt3gj42ZQqKvtTrfE7hhIgxTf9n5tj+nB7x0Ses415qtzej/KpGf497e4L
nfQBlusqKUam22Pzm+kHP+ujfa2uankO/qRT8GoXWKzl7bsqbT3vr8DRux2bk0Hr
0BviY65pMMpQAAUJRsl1LBVNhvwWa0nOm8taaocuPLaDmi6HaBPubMSfPwoXvvD1
OqkfFMgH1BBHulbeDhDiVS58tuOXUWN3qoHJbiDS4QToLb2Oc1w=
=3heO
-----END PGP SIGNATURE-----

--GvWCsJwxqkqQJXB20RU5x6EHX1jiBEgQD--
