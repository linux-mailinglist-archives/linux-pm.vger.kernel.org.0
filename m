Return-Path: <linux-pm+bounces-23958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04602A5ED01
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 08:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F31A1899C60
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB222422E;
	Thu, 13 Mar 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Furkzabx";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="4+Mwq12V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306E13AA3E;
	Thu, 13 Mar 2025 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850948; cv=pass; b=Hn4FJ69DSRsLV3J74Z+xonVHliKCkTX6W3PzxdlTmAvq7+I5KzizaxUv4mUQ+Dd5Y3wPLf0AYxS7/+mB6N1foTKtjFLGBQK5Ml8CGBuTOK8kq8zwAlzLM7L83iqrzhVRS0ZjnsLBcfkfnVDBqfHvyPZqvBX4N2jlfWits0fWuVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850948; c=relaxed/simple;
	bh=uFSxP81pn/e6yGYfTf0mtO12DY8QUBvh9IO6vm5S4L4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f11SPIZ5bOvjePNcQuUDyuymB4asmffy78x7uDMTST4738vgdxJmkRbyicArR9xW9bU1hU5m0u7zhDPuL3dK+H88vIKRDvxDN4iWAxgYhv5K4cu1rZBtP9Inu2OhpVz+PUnKccZy9ltvbrcsJxdhRsTH9MCNJH5kedktl+NAUhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=Furkzabx; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=4+Mwq12V; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1741850927; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XAYWul15chdPTIEU7rI7UWMq41H16DeZf2Bt6NAUsvEsiUUoJoKS41zbkTLWLZHgXN
    GXSLJa6Ji/TDCU08rZpHdT2Y2xWEoh5SP4JaRC/XSg6lB1uZR1JmpW0TGJjL/bx1G+vh
    Lx+RJLGmWo5VSMvasTHbkiPpsugTolqpJUqgz1I7EbPC3NKhkRT0ifSY4SwA2TmsRi55
    MO+ZZ0Md5mOOqohV6XpnjLIrdH8UdYbd6Z9Cn53SxVe5DFR0Thg1y56uz5oPzgm/rskV
    KBGQK0jxvYiGa9AMJXvpKN/0kdT4pr6L/DUdwygUuYtOivQ8hI2tb+X+zxodcP7LFltq
    rBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741850927;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2y7lhIIyHLZwLevk5jJUidsX10DrQJatyGZDfibeqIs=;
    b=jGSgT1AZgiqobTfk1u2pOw4fU4VE8xLCFCA2mGtcfDoM6PclkTxmvzMPvi/oqWoi1J
    9sHbOSWfHXTjcH5wzqL9bYQZ164wqBUx2fzOwVwI+7QfJ6YHrgb11sBt7piz/CdtDCfV
    EuDuQC7i9+/ffcc6bPQAdGN3ZojJFeULHluKrkbT+qRtIg7nYGDQq+lbemDqlrRFauCr
    GGsvY5Za5LOBFyOdAHxZzLmvgsPwkby8ZPBYjktnx4oRHAifuN724XiZ4foelfF+FsIz
    E8O7gnbFbHzgxhQQMYRk1OCLp0DIVCJZ4KD82wAQTvRzUubgYusi04XCKBMQ4j86XEX9
    nijA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741850927;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2y7lhIIyHLZwLevk5jJUidsX10DrQJatyGZDfibeqIs=;
    b=FurkzabxQNucHd2+ArHgKqV9Oh8vp1EjQWbBo3Vqoj8SKTjJkK5GXE91cOeh05k0IV
    +svaKqrewE/HfIgafg75dKlN6wFZLrPIhBEN6goda1r4FMBdQDZ5nX6zvsil6Wz35GKq
    I2CJLNGMdo7Te7hH/9v2tZ11eq07tj0Ay9sKCtBFR2p3jcsb7Q63IwMAYaf9+1mlDxru
    uve1K03stmAhDfNRZKpPRHrE76XUODU0qpEWNOei+cevXfqsX2Q8s2BFvJmNb1aV64x1
    UYSBUx7++Nbd4SA6s46gtYb3iuVw1AndhsyU5JeKgBQ0j6uc9DgVS3SEmvyMX1S0l1pi
    V9rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741850927;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2y7lhIIyHLZwLevk5jJUidsX10DrQJatyGZDfibeqIs=;
    b=4+Mwq12VsFMFnXeAySf7msUj0yZUXcDv7eyDktIVwIP4yBIBjD9lT8D/htUG0+Aymv
    g3wxEVmhOjhpLKFB68AA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeTsZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.3.0 DYNA|AUTH)
    with ESMTPSA id Q56adc12D7SkmNT
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 13 Mar 2025 08:28:46 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <Z9F92vGJbyUSFgxa@tp440p.steeds.sam>
Date: Thu, 13 Mar 2025 08:28:35 +0100
Cc: Sebastian Reichel <sre@kernel.org>,
 pali@kernel.org,
 linux-pm@vger.kernel.org,
 maemo-leste@lists.dyne.org,
 phone-devel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 akemnade@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF01728B-C13C-4CD8-8F61-419AACE03C0C@goldelico.com>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
 <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
 <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
 <C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>
 <Z8GHuu8RXkcY8utL@tp440p.steeds.sam>
 <4D7D3E00-59C6-42F6-AE96-F04970D60E8D@goldelico.com>
 <Z9F92vGJbyUSFgxa@tp440p.steeds.sam>
To: Sicelo <absicsz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi Sicelo,
please can you append the patch to the e-mail as usual?

Then "git am" can easily be applied or it can be found in patchwork.

BR and thanks,
Nikolaus

> Am 12.03.2025 um 13:28 schrieb Sicelo <absicsz@gmail.com>:
>=20
> Hi Nikolaus
>=20
> On Fri, Feb 28, 2025 at 11:01:35AM +0100, H. Nikolaus Schaller wrote:
>>>=20
>>> Thanks for the review. I will do more thorough testing over the =
weekend
>>> and send the patch.
>=20
> I have made a follow-up patch [0], which produces the following values
> on the N900:
>=20
> bq27200 in 'normal' state:
>=20
>   DEVTYPE=3Dpower_supply
>   OF_NAME=3Dbq27200
>   OF_FULLNAME=3D/ocp@68000000/i2c@48072000/bq27200@55
>   OF_COMPATIBLE_0=3Dti,bq27200
>   OF_COMPATIBLE_N=3D1
>   POWER_SUPPLY_NAME=3Dbq27200-0
>   POWER_SUPPLY_TYPE=3DBattery
>   POWER_SUPPLY_STATUS=3DDischarging
>   POWER_SUPPLY_HEALTH=3DCalibration required
>   POWER_SUPPLY_PRESENT=3D1
>   POWER_SUPPLY_TECHNOLOGY=3DLi-ion
>   POWER_SUPPLY_CYCLE_COUNT=3D0
>   POWER_SUPPLY_VOLTAGE_MAX_DESIGN=3D4064000
>   POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D3000000
>   POWER_SUPPLY_VOLTAGE_NOW=3D3536000
>   POWER_SUPPLY_CURRENT_NOW=3D-432327
>   POWER_SUPPLY_POWER_AVG=3D1146100
>   POWER_SUPPLY_CHARGE_FULL_DESIGN=3D2056320
>   POWER_SUPPLY_CHARGE_FULL=3D2050560
>   POWER_SUPPLY_CHARGE_NOW=3D366680
>   POWER_SUPPLY_ENERGY_NOW=3D1207420
>   POWER_SUPPLY_CAPACITY=3D18
>   POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
>   POWER_SUPPLY_TEMP=3D316
>   POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D4140
>   POWER_SUPPLY_TIME_TO_EMPTY_AVG=3D3780
>   POWER_SUPPLY_TYPE=3DBattery
>   POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
>=20
> bq27200 in 'broken' state:
>=20
>   DEVTYPE=3Dpower_supply
>   OF_NAME=3Dbq27200
>   OF_FULLNAME=3D/ocp@68000000/i2c@48072000/bq27200@55
>   OF_COMPATIBLE_0=3Dti,bq27200
>   OF_COMPATIBLE_N=3D1
>   POWER_SUPPLY_NAME=3Dbq27200-0
>   POWER_SUPPLY_TYPE=3DBattery
>   POWER_SUPPLY_STATUS=3DDischarging
>   POWER_SUPPLY_HEALTH=3DCalibration required
>   POWER_SUPPLY_PRESENT=3D1
>   POWER_SUPPLY_TECHNOLOGY=3DLi-ion
>   POWER_SUPPLY_CYCLE_COUNT=3D0
>   POWER_SUPPLY_VOLTAGE_MAX_DESIGN=3D4064000
>   POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D3000000
>   POWER_SUPPLY_VOLTAGE_NOW=3D3633000
>   POWER_SUPPLY_CURRENT_NOW=3D-397341
>   POWER_SUPPLY_POWER_AVG=3D1432260
>   POWER_SUPPLY_CHARGE_FULL_DESIGN=3D2056320
>   POWER_SUPPLY_CHARGE_FULL=3D2050560
>   POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
>   POWER_SUPPLY_TEMP=3D299
>   POWER_SUPPLY_TYPE=3DBattery
>   POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
>=20
>=20
> Hope this also works fine on your devices.
>=20
> Thanks and Regards
> Sicelo
>=20
>=20
>=20
> [0] =
https://lore.kernel.org/linux-pm/20250312121712.146109-1-absicsz@gmail.com=
/T/#t


