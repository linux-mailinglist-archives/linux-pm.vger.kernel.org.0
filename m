Return-Path: <linux-pm+bounces-11900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705CC946FD0
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FEDB20FE1
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583CB558BB;
	Sun,  4 Aug 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="AMrbWufe"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4831E76025;
	Sun,  4 Aug 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722789044; cv=pass; b=KO1x5R8Z2cs2ME7C5B+GVKRKieZd1VN2e6+XOY31sktnczHDv2QnVLckE8fFL1QTUkhv/nINnCIR0mYnAJ791AxHrAY17KvZfPGw6TRG5SczEXDv0Yno7m9i4NM1qnO8dD78yr11EWzJsxtmkMdZ0FANXdtPuMcJA2SmvKxrNhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722789044; c=relaxed/simple;
	bh=kQKdMWe3MvPWs/iBEYQoVr58syp150UxqcwavQKQoR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq+OZAC2BzSOAyOVtAClSouKoEsy+0UiSHBpDXoPDXiFRICdkC6SQPqHqmcfaHPyRRQY/0dz2ceigMdJWI0QH04VyypKOSpPFY4zR46/IpxvREYpnwh8hY6Hk3PHUI3SUykPSikJhdMMktJr5tE9fHBstz8toYxC2CLtibnsLPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=AMrbWufe; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722789006; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nwje/47x9KaVtqaLL0x9JfB1uyv0xjezjL1JgVw191JI3w3bKebnLgfS1NI8frLPb5pc3a0X5cmnF8vYOrqYPt8JqyNVHyR3ya2WcQcVTa9FI2bveOCgsHI4ZA9F5pwtVB8LKnunM05oT9gJxR7/3cOnvOTfkWqhJT2YN6iicSA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722789006; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k83AKgKohjBrZOHcPcl1ds4ciQppXSWeH0BLAv75Agw=; 
	b=N4LwckCvh1DS36oBCam3In4ZWTiB7Nvp0kLKR5oZvbVj8uHEkv56H5txuTLUMTUzBwzKyJXYvyzsqrMa4d7WZPyroZiuCRG964e3cbAMCJ7I3Pt9n9QBh/vdCgBm3EPQ6w1mEIT6ziWI5iCwpYaU/LmdsilKE4wJEMH+gBjXwtg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722789006;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=k83AKgKohjBrZOHcPcl1ds4ciQppXSWeH0BLAv75Agw=;
	b=AMrbWufef61W362zeWt6joY4UHfkcqN8r6+iGgbsMlePkrgRDUA3CPzRfNY4iOgZ
	CGnuqKI96NKx2E0X8NFOVBOkdi34qci86W4D/aiDioJbhR6ekf6OAYOPlRdt6J5afxz
	DIqkJTgD653qMtX9NVZODt8R4/185rnW/YO+B+eQ=
Received: by mx.zohomail.com with SMTPS id 1722789004041478.35275864340895;
	Sun, 4 Aug 2024 09:30:04 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 5F8131060930; Sun, 04 Aug 2024 18:29:57 +0200 (CEST)
Date: Sun, 4 Aug 2024 18:29:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Chris Morgan <macromorgan@hotmail.com>, 
	Chris Morgan <macroalpha82@gmail.com>, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, jagan@edgeble.ai, andyshrk@163.com, jonas@kwiboo.se, 
	t.schramm@manjaro.org, heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org
Subject: Re: [PATCH 2/5] power: supply: cw2015: Add support for dual-cell
 configurations
Message-ID: <3fgf7jyla6gtxqppjjnjb5dgciqqus2iwjunjavlmhy7fxdqv7@a2iycmzlgkbb>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-3-macroalpha82@gmail.com>
 <eimocj6mlvo6u4x54heywblwrfnftxelzpvfcogpjp7vjmunor@5eqlqsszk6ni>
 <MN2PR16MB2941F5FFA92B056533586FBDA5B12@MN2PR16MB2941.namprd16.prod.outlook.com>
 <2eh5iqwtwlbpg5kpr4lvvhxo2tngw4w7qanelr6filcrru62le@o7cwpsahp2n7>
 <8c44fcf923c5697ca55c8e32f3938d3b@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nr6obygdxvzehgev"
Content-Disposition: inline
In-Reply-To: <8c44fcf923c5697ca55c8e32f3938d3b@manjaro.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/222.613.84
X-ZohoMailClient: External


--nr6obygdxvzehgev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 02, 2024 at 11:39:24PM GMT, Dragan Simic wrote:
> On 2024-07-31 19:02, Sebastian Reichel wrote:
> > On Wed, Jul 31, 2024 at 11:02:11AM GMT, Chris Morgan wrote:
> > > On Fri, Jul 26, 2024 at 11:06:21PM +0200, Sebastian Reichel wrote:
> > > > On Fri, Jul 26, 2024 at 02:49:45PM GMT, Chris Morgan wrote:
> > > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > >
> > > > > The Cellwise cw2015 datasheet reports that it can handle two cells
> > > > > in a series configuration. Allow a device tree parameter to note
> > > > > this condition so that the driver reports the correct voltage val=
ues
> > > > > to userspace.
> > > >
> > > > I found this:
> > > >
> > > > http://www.cellwise-semi.com/Public/assests/menu/20230302/640007680=
6706.pdf
> > > >
> > > > Which says:
> > > >
> > > >   CW2015 can be used in 2 or more batteries connected in series, or
> > > >   several cells connected in parallel.
> > > >
> > > > So dual-cell seems like a bad property name. Instead the number of
> > > > serial cells should be provided. This property is then not really
> > > > specific to the Cellwise fuel gauge and instead a property of the
> > > > battery pack (i.e. simple-battery.yaml).
> > >=20
> > > It's conflicting information (which further confuses me). I see in
> > > that
> > > datasheet it says 2 or more, whereas the datasheet found here says
> > > only
> > > 2 cells:
> > >=20
> > > https://www.lestat.st/_media/informatique/projets/python-cw2015/cw201=
5-power-management-datasheet.pdf
> > >=20
> > > But I agree in principle that we should be setting this as a property
> > > of a simple-battery rather than a manufacturer specific parameter.
> > >=20
> > > >
> > > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > > ---
> > > > >  drivers/power/supply/cw2015_battery.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/powe=
r/supply/cw2015_battery.c
> > > > > index f63c3c410451..b23a6d4fa4fa 100644
> > > > > --- a/drivers/power/supply/cw2015_battery.c
> > > > > +++ b/drivers/power/supply/cw2015_battery.c
> > > > > @@ -77,6 +77,8 @@ struct cw_battery {
> > > > >  	u32 poll_interval_ms;
> > > > >  	u8 alert_level;
> > > > >
> > > > > +	bool dual_cell;
> > > > > +
> > > > >  	unsigned int read_errors;
> > > > >  	unsigned int charge_stuck_cnt;
> > > > >  };
> > > > > @@ -325,6 +327,9 @@ static int cw_get_voltage(struct cw_battery *=
cw_bat)
> > > > >  	 */
> > > > >  	voltage_mv =3D avg * 312 / 1024;
> > > > >
> > > > > +	if (cw_bat->dual_cell)
> > > > > +		voltage_mv *=3D 2;
> > > >
> > > > Unfortunately there are no details in the document, but this looks
> > > > very fishy. Does it only measure the first cell and hope that the
> > > > other cells have the same voltage?
> > > >
> > > > This (unmerged) series also applies to your problem to some degree:
> > > >
> > > > https://lore.kernel.org/all/20240416121818.543896-3-mike.looijmans@=
topic.nl/
> > >=20
> > > I think based on the application diagram it is in fact measuring the
> > > cell voltage.
> > >=20
> > > That said, this ultimately boils down to a cosmetic thing
> > > as not having this property simply means userspace sees the battery
> > > voltage as 3.8v instead of 7.6v as is written on the side.
> >=20
> > With the cells being connected in serial, the voltage of both cells
> > can be different. There is not "the cell voltage". Instead there is
> > a voltage for cell 1 and a voltage for cell 2. In a perfect battery
> > they are the same, but in reality they are not. In the extreme case
> > one of the cells may be broken while the other is still fine. It
> > sounds as if this is just measuring the voltage from the first
> > cell and assumes the second cell has the same voltage.
> >=20
> > Ideally the voltage on these platforms is not exposed via the normal
> > VOLTAGE property and instead uses a new property for telling
> > userspace the voltage for a single cell. The kernel simply does not
> > know the voltage of the whole battery pack.
> >=20
> > FWIW this is the worst battery measurement system I've seen so far
> > if my understanding of the hardware design is correct.
>=20
> Please note that two facts should be considered here:
>=20
>  - The GenBook schematic [1] clearly shows that the individual battery
>    cells aren't exposed at its internal battery connector and, as a
>    result, aren't available for individual cell voltage monitoring
>=20
>  - The GenBook uses a CW2013 as it fuel gauge, [1] instead of CW2015
>    as mentioned here a few times, but I haven't went through the CW2013
>    datasheet(s) yet to see what are the actual differences between it
>    and the CW2015
>=20
> [1] https://wiki.cool-pi.com/notebook/coolpi-genbook-v20.pdf

Ah, thanks for pointing to the schematics. So the fuel gauge can
only measure the voltage of the whole battery, but VCELL register
provides the voltage for 1 cell? What is the origin of the dual-cell
property? Was this something you came up with yourself when noticing
the wrong voltage?

Based on the above information my guess would be that CW2013 uses a
different voltage resolution than CW2015 for the VCELL register. The
datasheet for CW2015 says 14bit ADC with 305uV resolution. Maybe
the CW2013 simply uses a different ADC. Do you have the datasheet
for the chip?

-- Sebastian

--nr6obygdxvzehgev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmavrH0ACgkQ2O7X88g7
+pr/qxAApdbotqU12LgNuKVPIMNCOH7Yh7rvIWQo+T5qKZ02AaK6/KMqHdXEeak6
zeEpTOYH7It70HVoe04AXVCUxl2Nq1YtKZP1aWoeHbjuE8fQNqyAGk/C/X3Lv5uA
MbjschmTykXt9iUc/7aQnLUjsKf6Oi1SnhQA6fMlXqZxxaEAaNvRyorx0JLSnNv9
w13ijDtnhKY45jkYONftZr7KTSOFg8E3YqnG4Rzxmx58m5caL6kGDbiUbi3VksfL
tooBQgLw6N4kbzY0Egwv6wkDKRmEcsgtm8+CylHa1IO7Pji0BZX1C19HxXp+eR4G
ATkTXWkdDl4bhA0vuc0gIISLp/H//YzMBqIdd6jYXFxma0BwpWBGdeFdb2oYWea6
JKmPpX2/XaMF0AQXFY9eckn/GD1Kq/ogvuni4fPHPppOfl6Q3lSl4R1N5Kunuxfy
sE4Kby5004Eyl+etceuAEOfNvNxDO6HVIDzjVmBumwW2/bdG511zM7BeVX2nz1Jk
DMXP0BLEHekROWv+vY3JYskD+Iuux0FPMOU8YFEw97nBXAvt7JNIruv4ROO1bMPW
/Eg1WzAd41kVw1rPYdY+lfCX949L/LlXgPz+EXzynYzR5M8nDtaNIE9IaQ+r1aoX
5jNA+6qaAtg5r4Jwo5QdHz+XHPS1dkN5qvCJh/kfjOV9341UFxY=
=82He
-----END PGP SIGNATURE-----

--nr6obygdxvzehgev--

