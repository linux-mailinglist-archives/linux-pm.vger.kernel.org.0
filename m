Return-Path: <linux-pm+bounces-32833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF7B30289
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 21:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969BCAA4110
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF7B343D8A;
	Thu, 21 Aug 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="DWNouFtu";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="bCHTvQEA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15652DCBFD;
	Thu, 21 Aug 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802688; cv=pass; b=Ar1Zxzy3hFtQYaopepFplmfemyoUm1qMLKScI+5qWQ01v7iWzvrZAORjpL4BBdgLmBerg3uwUnUDeoR2Vg2yORcIDW7jNbolRPt4ijPSSfIIRyeCVWHCzMYDyeLzGvWzdKAnmI2M3yJdu9MIdzQOD87+kme+inO3WgdpjoVqqrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802688; c=relaxed/simple;
	bh=GjsOBI4bPr96x7VFuHyS3ITwTCf8VRb/tRRe/XKU8XI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mXakUMrne7Do09SzKdt46Q/Jk6/SmnlMK7FdBFNl4MAIpV3ZCr8USwN2g5BC549g9Ae71FpqSKQ/38T8/zwwVO8Z94z3ZIuSOtwaoqWqyYHRYakoJI9A5nNmQAbLyB7WbrZIHMY2mtMjz0rMOX6O0bzDM7pWwYGol006IljdYr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=DWNouFtu; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=bCHTvQEA; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1755802492; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BPVJy5WlfNgBmiZ3mbsnTR6JVN2Tck6iGLGbqHi9RT4RPr+wvjFJMFS7r5seYtfuCX
    FkkVkjryDe1leg+h3ma2b9D878lcOk9d8di1mUG3ZM2OGC/bId9txxzzL0jPVHVgxSFd
    LpG5h3kdq3/Mg52qxnYQZ91la01XEjE46lK2IT3Y43hp3kdwE52fFTAhZsn+RJh0OKxl
    z8nNERRBIdfwYmD7GdErhy6JPH5p3fw2pOhbPGdeHwBtziiGPDXASGTjnViOHeEu/w/+
    gTD5JfIy92KvAqGH/t9616grYIZxngCFJ8DxbNZJmb3SAAd5jUKPFLaXqayqEZOFLPbK
    xZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755802492;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=n+K+WaLmPgM9QTvAsx0hZF849I/TLqpLKyL1G4QQN6Q=;
    b=ADVsbH+L1W7OkTlMuOMXB5+IkE3ZkySfsj3nOlc7ZFNmpLN7IYCsi5WHrg1AnXLyGz
    qveoe6FlN2TN2i/jfzMVv7Kd8rRqwdBYAklGjdkLpVeChMfxitZ1yQ3D+Hb2FimRch7e
    1E3hVAXJMakwNgt1Yfs6ml6tctN+wWnid1FgW5Wd/DHbgPMMcpVIXIQ2I6vr2pB1XMZS
    1z+bwp8Djdrprh9FV6B9uFe0mgnZ9S7TYAhn3NRqb/qdhV2CVSH3UZvrrd1nZgGEpjC5
    Nn1yqz9zsjRUdh/lMIYtQ/DbtA4OySWIAx48ZPLVhhpwozQpZYwxce8eCkyXQuPVk5FU
    tQSA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755802492;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=n+K+WaLmPgM9QTvAsx0hZF849I/TLqpLKyL1G4QQN6Q=;
    b=DWNouFtuhwIG1SzjgXQjkFo3jgAeQhjSU/T23DKwtazEJlEVRrBdYIjJCnNn/SjWTj
    LiM2faos8KutLRtSN1yQ+tVfNuf4Zf4MLBWAp8vWqMOfNyRDy9ggp7DpcT6a1lvA0vH5
    Y2ycHmER2U6cBVQfKE3cz+qFAym7y3bzXlGlrXYFESPe1YOLrCiHgb6ZnKnUzSjzYg+N
    9Ys27ebnyJNoiV6Rz7deuNfswP0bLOrdU9hXzuR8Qrqks3P15yLUqK+tijkxQxlLeuzp
    X1w2vBWObznsGPtXDyG3Ch2JLOb7cpHlFcFb7DQQ6RF5i6T9tCHXSw41KIcY4nzs4JLh
    fpSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755802492;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=n+K+WaLmPgM9QTvAsx0hZF849I/TLqpLKyL1G4QQN6Q=;
    b=bCHTvQEAdp/diUjvAMXSxik4969cJ52xm9gI7AKnTHX4lvazJ1zIkmAdl5+l5Tze8p
    xF57xDH6cc9enhUYLLCg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfzAZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 52.1.2 DYNA|AUTH)
    with ESMTPSA id Q307a417LIsqvZv
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 21 Aug 2025 20:54:52 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20250821201544.047e54e9@akair>
Date: Thu, 21 Aug 2025 20:54:41 +0200
Cc: Sebastian Reichel <sre@kernel.org>,
 Jerry Lv <Jerry.Lv@axis.com>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 stable@vger.kernel.org,
 kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <10174C85-591A-4DCB-A44E-95F2ACE75E99@goldelico.com>
References: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
 <20250821201544.047e54e9@akair>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> Am 21.08.2025 um 20:15 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Hi,
>=20
> Am Mon, 21 Jul 2025 14:46:09 +0200
> schrieb "H. Nikolaus Schaller" <hns@goldelico.com>:
>=20
>> Since commit
>>=20
>> commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when =
busy")
>>=20
>> the console log of some devices with hdq but no bq27000 battery
>> (like the Pandaboard) is flooded with messages like:
>>=20
>> [   34.247833] power_supply bq27000-battery: driver failed to report =
'status' property: -1
>>=20
>> as soon as user-space is finding a /sys entry and trying to read the
>> "status" property.
>>=20
>> It turns out that the offending commit changes the logic to now =
return the
>> value of cache.flags if it is <0. This is likely under the assumption =
that
>> it is an error number. In normal errors from bq27xxx_read() this is =
indeed
>> the case.
>>=20
>> But there is special code to detect if no bq27000 is installed or =
accessible
>> through hdq/1wire and wants to report this. In that case, the =
cache.flags
>> are set (historically) to constant -1 which did make reading =
properties
>> return -ENODEV. So everything appeared to be fine before the return =
value was
>> fixed. Now the -1 is returned as -ENOPERM instead of -ENODEV, =
triggering the
>> error condition in power_supply_format_property() which then floods =
the
>> console log.
>>=20
>> So we change the detection of missing bq27000 battery to simply set
>>=20
>> cache.flags =3D -ENODEV
>>=20
>> instead of -1.
>>=20
> This all is a bit inconsistent, the offending commit makes it worse.=20=

> Normally devices appear only in /sys if they exist. Regarding stuff in
> /sys/class/power_supply, input power supplies might be there or not,
> but there you can argument that the entry in /sys/class/power_supply
> only means that there is a connector for connecting a supply.

Indeed. If there is an optional bq27000 hdq battery the entry exists.

> But having the battery entry everywhere looks like waste. If would
> expect the existence of a battery bay in the device where the common
> battery is one with a bq27xxx.

I think the flaw you are mentioning is a completely diffent one. It =
comes from that
the 1-wire or hdq interface of some omap processors is enabled in the =
.dtsi by default
instead of disabling it like other interfaces (e.g. mcbsp1). E.g. for =
omap3 hdqw1w:

=
https://elixir.bootlin.com/linux/v6.16.1/source/arch/arm/boot/dts/ti/omap/=
omap3.dtsi#L502

And we should have the dts for the boards enable it only if the hdq =
interface is really
in use and there is a chance that a bq27000 can be connected. In that =
case the full
/sys entry is prepared but returns -ENODEV if the battery is missing, =
which is then
exactly the right error return (instead of -EPERM triggering the console =
message).

Or is there something related to power-management, so that the hdq =
silicon always
needs the hdq driver to properly idle?

Anyways I think this is a different topic for separate cleanup. For the =
moment we
should fix the hdq27000 missing battery detection which was broken by =
changing
the return value logic.

BR,
Nikolaus=

