Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4089BA60E4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 07:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfICF65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 01:58:57 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:21823 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfICF65 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 01:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567490334;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=B7mHEtNVWP2s+UW9fA+wM8qTJ39ZdoUJ18B1zSJear0=;
        b=RPtFPa6V214uxtnrNqZhlyuE0X0ezgDFqTeH9GAhLvuarNofV+AAKtHcqNMQHdFnw/
        GFYAfZeqhuL/KXsRP6GSrCHfabnLwS84TONQuzCRv4GDNkfEhYee4NKYQua2vKyyxqsu
        BxrC0owKhFQbZOIazaxeZFQAhxmOpmH5XLbK7LmWIOa6ExJnQhRwAOlad7dYHyRsU7ME
        4sdOvwqmULP53/T960qAV3kuuCKQdeh5uMBQffa/8t2dzWfsksZtBFkXAudbZsVMYXlN
        ey5fxka6tk7RtRXRW4It7G0Ac3Qdg3Wz70y/tByfhq5Wild1uXZ+7IBvaHpXf3GT7xmi
        EzFA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlWfXA4ONfA="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v835wjUfm
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 3 Sep 2019 07:58:45 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 2/5] ARM: dts: add support for opp-v2 for omap34xx and omap36xx
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
Date:   Tue, 3 Sep 2019 07:58:43 +0200
Cc:     =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F72772FC-088A-43B6-B486-7AD172885796@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com> <d0dc1623ed6b1bd657f169dc2b4482b269bdba37.1567421751.git.hns@goldelico.com> <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
To:     Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Am 03.09.2019 um 04:38 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
>=20
> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
>> +		opp1-125000000 {
>> +			opp-hz =3D /bits/ 64 <125000000>;
>> +			// we currently only select the max voltage from =
table Table 3-3 of the omap3530 Data sheet (SPRS507F)
>> +			// <target min max> could also be single =
<target>
>> +			opp-microvolt =3D <975000 975000 975000>;
>> +			// first value is silicon revision, second one =
720MHz Device Identification
>=20
>> +			opp-supported-hw =3D <0xffffffff 3>;
>=20
> I don't see the driver changes using this field, am I missing
> something ?

This is parsed by _opp_is_supported() which is called
indirectly by ti_cpufreq_probe().

BR,
Nikolaus

