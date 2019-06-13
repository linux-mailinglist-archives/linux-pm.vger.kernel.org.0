Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFFB445D2
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 18:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfFMQqv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 12:46:51 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:49434 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404168AbfFMQqt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jun 2019 12:46:49 -0400
X-Greylist: delayed 1124 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jun 2019 12:46:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:Message-ID:Subject:To
        :From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1I3y8nqcJVpxthG73yLJqt3fM1GjciDgS30mgpzyGos=; b=i+5hfE2B0oerl7ASbQfCQ9Ckpu
        NAD8hrilFOX0+AkKTEAiXKhYzkYZ+HYcfEJiwgdIIqSHP9KAY63nD2ajs05yT6mCfecjlZNDWg3vo
        VFiK/OsEtD8diKZTdcFaaRatrvKu3Gfzd1Q+S+jciRacE0tKZIWwSEWQYfcezjTCsOSY=;
Received: from p5dcc3dfb.dip0.t-ipconnect.de ([93.204.61.251] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hbSa2-0005j7-2T; Thu, 13 Jun 2019 18:28:02 +0200
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hbSIz-0002wp-Cw; Thu, 13 Jun 2019 18:10:25 +0200
Date:   Thu, 13 Jun 2019 18:09:58 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: BUG: no cpufreq on gta04 (omap dm3730) in 5.2-rc4
Message-ID: <20190613180958.48e04530@kemnade.info>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/phLSzGZi9/nM=tEb3SaLRWC"; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/phLSzGZi9/nM=tEb3SaLRWC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On the gta04 (dm3730 cpu), cpufreq does not work properly with above-mentio=
ned
kernel.
cpufreq-info just shows
analyzing CPU 0:
  no or unknown cpufreq driver is active on this CPU
  maximum transition latency: 0.00 ms.

dmesg log shows these interesting lines.

[    3.140655] core: _opp_supported_by_regulators: OPP minuV: 1012500 maxuV=
: 1012500, not supported by regulator
[    3.152709] cpu cpu0: _opp_add: OPP not supported by regulators (3000000=
00)
[    3.160278] core: _opp_supported_by_regulators: OPP minuV: 1200000 maxuV=
: 1200000, not supported by regulator
[    3.171142] cpu cpu0: _opp_add: OPP not supported by regulators (6000000=
00)
[    3.178710] core: _opp_supported_by_regulators: OPP minuV: 1325000 maxuV=
: 1325000, not supported by regulator
[    3.189483] cpu cpu0: _opp_add: OPP not supported by regulators
(800000000)

looking through logs shows that these lines first appeared in
next-20190506. They were not present in next-20190503. If I understand that
correcly it is about vdd1.
Analysis reveals:

in
int regulator_is_supported_voltage(struct regulator *regulator,
                                   int min_uV, int max_uV)

the following if fails:
     /* Any voltage within constrains range is fine? */
        if (rdev->desc->continuous_voltage_range) {

The following hack did the trick

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regu=
lator.c
index 6fa15b2d6fb3..f7bfdf53701d 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -478,6 +478,7 @@ static const struct twlreg_info TWL4030_INFO_##label =
=3D { \
 		.type =3D REGULATOR_VOLTAGE, \
 		.owner =3D THIS_MODULE, \
 		.enable_time =3D turnon_delay, \
+		.continuous_voltage_range =3D true, \
 		.of_map_mode =3D twl4030reg_map_mode, \
 		}, \
 	}


not sure whether it is correct, whether these things are continuous enough.
If that all is ok, I will of course submit a formal patch.

Regards
Andreas

--Sig_/phLSzGZi9/nM=tEb3SaLRWC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl0CdVYACgkQl4jFM1s/
ye+K2g//QGXv4imVjMS+bJhxOxvePnHgA9xkT3GXJjB1my/12HiWIXt7lsqr67mQ
K8UmKN1ZazgBCDk77d8s8pLIZXPQOCwNgmQq6OXqeeSKVeR23VLh7q+FAIw62d+G
p8GGkrh5qPjWncXnzdnAvXSl0qDe5vCvnlTjxwJ4H0H1S/+yBEb8FP6CkJa7Q2yJ
2eXi1MM308zn2be24+WT7BFFkSWRbsLrOk1d1Tlxofgb4aejN1dymB5xi/VjSj3B
OWFLvnal5wKnktWjpRhTy+hozzgJN/OQsz8tbkQh73ty68X6DIxXhJLNlcu0uO0n
oBg2ebKnybEwEDlMhTxWfW9eG5Fk7opiDMUEWpQoj9HSitSzgfDH5M544UzfLeBu
EVaMMcHxpHLVYKpSJtEfKW+Po6JmnT7ckV4r8i4qzyKUEIkVp5EPryZdX2JPgexn
83HOiHdkf91I4KpLncAXzcSpoWxe7VJZOWNIudSgF32/tkoopq7hkmaeKCF0ukPi
WfDtry1onnbfKwxaOpZ+LL5kqq0w99oKgx+jwZseCO/X9+7R5qnvk3NBMM1ado/Q
RIYPl94GnEDz481cGBsuO/AT3B+MUMi9IchLb4bclHTKNxvllszVoq9Rl+t8mI/J
L3YtP4UQL9a20qFHyFfE1NvyymW0bsYiWHzsh077OpebgPBepwY=
=8loG
-----END PGP SIGNATURE-----

--Sig_/phLSzGZi9/nM=tEb3SaLRWC--
