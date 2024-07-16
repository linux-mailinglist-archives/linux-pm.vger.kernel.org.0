Return-Path: <linux-pm+bounces-11143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EA2932478
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 12:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FE3281A33
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11929196438;
	Tue, 16 Jul 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="QZ1HW0VT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF413D630;
	Tue, 16 Jul 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127362; cv=none; b=JPU+j/uYM/o7mrToLSqLlXRy0QAo/WB/b0orPk8JacrWE6OQQyqN77mw4lCwbyxSpbkM5+Mu/7bSHBUnzWKRgNgtKm2nzf2jgaYHEDIc9QYlQfnJGy/dgqk4rMlU7E3lboU665EaJ77WDcF/3RUkdZQY4/ImKSYdBKRyvpRfF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127362; c=relaxed/simple;
	bh=RQ3y3PQ7crcZ7ZGxgOJF8qEI16yOasY0cMut+iWSaOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsPZtgwrN/wVkxUISGFb/ztm5Usj7t+aQu52CmRas5dG9XI4Vk/KkDAqR/RuPQfGozBkxa4mZCdRCe6rOhOzwM1GXHZyZ2DDdriZhkwZuNpxpFTpIaYoJtvWd2nSnqXj14SRdXbrIjwQtybbPsTghnF6JxpTNQhenxUVKcABPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=QZ1HW0VT; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721127341; x=1721732141; i=s.l-h@gmx.de;
	bh=mlL3qiEKWhlaSR86j38poKpFJD8cyzTAaqVAoAn6vCM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QZ1HW0VT8qAwMLSgW5RIUkkREmsjVINZxOH3TrbOy5HPSALGOaGQvobKm01jEp95
	 E0SHcdGbssFFJyWWKmyApBFINkdTx5GVjb7O7AkqwkJNBClTjoky2pyzLkjS5JHXI
	 R+PnRojfp+XzisdVUhRROBh/IxzM8AKqjkW+NfXqN9qzRQ4F+WaMIlpgZNoxcTBJ0
	 AvhxWxGi7M+whO0Maa0c1PQz+MMxsNRb8eZxS7fu2yLH+qxH3A60w/jL/tDZxvXuk
	 bV1rKlDmJzVYFT7MusCGWvo/D2pRlqzi1roVjy9ypGGzqZIBiq8aQuZJ+lZurX0So
	 pNhf5NK8LpFwJvN7cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1sngdI23cP-00SrVO; Tue, 16
 Jul 2024 12:55:41 +0200
Date: Tue, 16 Jul 2024 12:55:38 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Eric Biggers
 <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz
 Luba <lukasz.luba@arm.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
Message-ID: <20240716125538.09f716d1@mir>
In-Reply-To: <CAJZ5v0jkA72=avuthGkrS5iu_UGEQeaEp7LjedXCpzamcnRKsA@mail.gmail.com>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
	<20240715044527.GA1544@sol.localdomain>
	<4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
	<CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
	<20240715145426.199c31d0@mir>
	<CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
	<20240716014830.243bb0cf@mir>
	<CAJZ5v0jkA72=avuthGkrS5iu_UGEQeaEp7LjedXCpzamcnRKsA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rw./VzWhpwsM8iFyc=ywj9o";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:PuMlUK0IdDrNegEJKYQbbOifkYWqN1wFfEKchi0RFrNl3tgbBwx
 YUfcRA3Nai8+eyJ61SmctrDZPSML+fN5Fei6Z9tgPOWhvN78pRi08OIkR8UyuZ+E50CAVBD
 FIz03H1x8hjmGMSeA4HSx8fs5wtK059U95+oOaYUOLhlfA3/1nInr8uSA6Pa2K4bGUQuSGd
 Z1US4h0VCeYfeO/cfWQ1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cHU28S3U2I0=;/dJtd3FxeVJTHVZLqgoBl205xot
 0HXwPM1HhtuoKjcT9lMF+tzptFLrYNK5fSvUvbSqGRBnSs0Avja0ePSwf6ETAihid9ZPJEejF
 1ePmg1fWbsX2GglsJpGq0YGpl7NqDPWQLrW2xrhAF5xEI6wywkznlecyWQ2CzRCjb1kG9BHrg
 hktZzbsML3DtgLHkBercYfhPLAhsMxOGhhrd5cGmLTfndNeLY5KSuGs70bJT+tTBjv/7P5T4p
 ExX3EFSi8sbhN3mzYpveQxeBz7doUEwvtAhvotB7UVJLaf4ZMmr1IAxcFCLefSq3Fc18nudfJ
 QhuIMUsLymrXC6lxWxvVaSdvThL/mNvI1Yfax1CSMeq1H/9vAuyllKrCP5KppZ2GGiOW3DN9e
 vLIX7w45oixH4qxekLHQQJ1Xf3mz5fd+3r15/JBkqMqFgijhu9eAbzCHCCEPbHNhh9BAtgsNQ
 HVJa0V62dxwoMwyJkgt2Gzpj/cY/J+sqjPQMj9EGrZFtH/R0PHbY3FEMgYiOAotuC7Ok0yO2l
 3Q9sIJJDg6YIGrZm4a1xWenI1wfl/iUmussS98t+pcW4Os+5GUPcnCKnHSSVPNDHLCtvJC9iX
 3uQJj7trXePXfrN7GZdli4I7D9U7gZ9yFgGeDgk3FZkHHh2kTHRtCEq93ff4c+OC/Cc38BpiX
 vsUBFzGLIlunVCR6zel9/FHdjhNvYnIINYjc85SqG7elplUrepEKZysc1TVHv3OXxUdyTDYEl
 UUNQO7lR6cngwMyQyF7hlBDU90tnR9eGpqTkuqMF3uGlx0R3Q28fjsDC0K63Rw31ZUAI52xM+
 /TzvvHsEWdM039NZlznM9Prg==

--Sig_/Rw./VzWhpwsM8iFyc=ywj9o
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

On 2024-07-16, Rafael J. Wysocki wrote:
> On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollmann <s.l-h@gm=
x.de> wrote:
> > On 2024-07-15, Rafael J. Wysocki wrote:
> > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollmann <s.l-=
h@gmx.de> wrote:
> > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki w=
rote:
> > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > [...]
> > > > Silencing the warnings is already a big improvement - and that patch
> > > > works to this extent for me with an ax200, thanks.
> > >
> > > So attached is a patch that should avoid enabling the thermal zone
> > > when it is not ready for use in the first place, so it should address
> > > both the message and the useless polling.
> > >
> > > I would appreciate giving it a go (please note that it hasn't received
> > > much testing so far, though).
> >
> > Sadly this patch doesn't seem to help:
>=20
> This is likely because it is missing checks for firmware image type.
> I've added them to the attached new version.  Please try it.
>=20
> I've also added two pr_info() messages to get a better idea of what's
> going on, so please grep dmesg for "Thermal zone not ready" and
> "Enabling thermal zone".

This is the output with the patch applied:

$ dmesg | grep -i -e iwlwifi -e thermal
[    0.081026] CPU0: Thermal monitoring enabled (TM1)
[    0.113898] thermal_sys: Registered thermal governor 'fair_share'
[    0.113900] thermal_sys: Registered thermal governor 'bang_bang'
[    0.113901] thermal_sys: Registered thermal governor 'step_wise'
[    0.113902] thermal_sys: Registered thermal governor 'user_space'
[    0.113903] thermal_sys: Registered thermal governor 'power_allocator'
[    3.917770] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
[    3.926543] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x10053=
0 wfpm id 0x80000000
[    3.926551] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
[    3.936737] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.=
3.35.37
[    4.021494] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07d.0 =
cc-a0-77.ucode op_mode iwlmvm
[    4.347478] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz=
, REV=3D0x340
[    4.347616] iwl_mvm_thermal_zone_register: Thermal zone not ready
[    4.478749] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a100
[    4.478777] thermal thermal_zone2: Enabling thermal zone
[    4.543601] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
[    4.559564] thermal thermal_zone2: failed to read out thermal zone (-61)
[    4.602339] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
[    4.810373] thermal thermal_zone2: failed to read out thermal zone (-61)
[    5.066381] thermal thermal_zone2: failed to read out thermal zone (-61)
[    5.322385] thermal thermal_zone2: failed to read out thermal zone (-61)
[    5.579377] thermal thermal_zone2: failed to read out thermal zone (-61)
[    5.834375] thermal thermal_zone2: failed to read out thermal zone (-61)
[    6.091372] thermal thermal_zone2: failed to read out thermal zone (-61)
[    6.346400] thermal thermal_zone2: failed to read out thermal zone (-61)
               [...]

Regards
	Stefan Lippers-Hollmann

--Sig_/Rw./VzWhpwsM8iFyc=ywj9o
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEMQMcJCzZm4GSqVV4v+AtZbHRQu0FAmaWUaoACgkQv+AtZbHR
Qu1ZrhAAz0er4fsRIN93aBskjoCRENQK1Zlrc7zPWZbSKzRsqB7LhapzKFEofCAc
IYF7OkZHyTTKyQOhqFkDbyvk6VQ/PfpszRRpNplsZyug68C1uZ5g45MD5Pnv8rUE
4NpVnu6OVjX8PhoQacjjHJJWUj0BsDQiLII+GOmHqZWWrwKt4fbyCh1a1+ZOirUY
Y5Dleyv1vpsHX3IYdsZ6XKPqckYogo4DwN62bcDRqtBgtSymUr4xtY2j+PtcIdzA
HMjJFtXTiQZ3zlpe6FXVwshw8zmzSe9/wkwLcOZtMey2WNjqDwCWNu7T46FS1m47
MSzfIbunuTYKHuJbieVK9q5tlrrR5QA2NlZqrsb9OUbxXmxF3p8m/1pKKmbWjfym
Ktf4a1LcLOBKS4Ahjyh3FDhxIuNpK7ctXd5EruUlOgznwO4U0QfISszCv7EJDR/+
SXLIirdFNUW5R9nmOdCd05AvjGT4zUAgRF0zl3Q2gsWb2qIyoB2UYwAN7ePJTXvw
ZH2fj+R7Ms0G0K9daqqan4J63UsPzeyoTv97cixkxYWaqoIWhrBKU9BE4a0rUcXu
npO9Vj1jcD9vpNXta3LDbuzzsQGQ+EFrSaw+9H4CGzp6myNx75qtHFqW2IVfFUCf
I2MMZ+lNZPe46HKoNASiL713T9pD/S6BqZCcNBp2fe9zDC8ddAQ=
=QIPE
-----END PGP SIGNATURE-----

--Sig_/Rw./VzWhpwsM8iFyc=ywj9o--

