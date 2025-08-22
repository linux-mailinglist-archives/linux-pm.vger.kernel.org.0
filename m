Return-Path: <linux-pm+bounces-32909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21421B318DC
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 15:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB39625150
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A242FD7DE;
	Fri, 22 Aug 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="nxmKQCPh";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Jp/67mQN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77D42FC008;
	Fri, 22 Aug 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867649; cv=pass; b=QO1DmY8FuZitIk7GRYJQg/HY7BooiRDu9nV8sVU4hicRcijQmHTybF+LB+96dttPEF+/g5aejiy/PEQwkLfe71/wfHn48lDQgOn3lnXFgXTeKY0wdqnsY3shrrEN+QM5ONlPlUSGinm5cyAabfnIGmDGbizlmZTKAg2S80uBxqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867649; c=relaxed/simple;
	bh=tKWIfxfpH/XWzFDUflAitZfOsO2kUNsz1M5UwojPLDg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XytnqKdvjkoY6CJ3FHsvAkMwMjAY5au6qYI/o8eGmnCUOzLaOTrrg4VG5iWNFiv/HSNb+MPO9dmbLkfK+XA9HRRAxi1ihQIHn0nQHQHNIKyNM2SQ5fMn1zJhHu30SmxrsICVvD1RRcTqFyS4EgS9kGLHO8sATKJcompAkarafEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=nxmKQCPh; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=Jp/67mQN; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1755867629; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OQUKXQKrLIEkTNdxgMLMUmUMN1QNPVW0lHu4nhT5I54CNgy8tU3OL/oJpC05WWuNgo
    atu3NCfBEn7rtkv7CGNd+TtNAZ+SW009ZBrBvBuJP9oZOrA8KLhQnAI4HhHrsJGpZfmX
    HEyAFLI689W/IVIh6TfdNymMsxOKW0vkdufHBc9RZ8gsdRqEeSc8Q0mMjPiSW6HX8OAU
    iHKZWSeMpGKteU3jlL3OZqrPzJOdjPYjptIjDqwljJHMmPxAaEYMkxOio/QgafsXYZGV
    57ORTCHGUiPxKAEHTI6vIMOFGWwzTmigrLUauM0jlFfSjRRMFzZqwH8I//C1DLgApuXt
    4wQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755867629;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=dyqgy5T3hx+MqXXKObwy6WBXqr/oFHAkqS1wlQiF4gA=;
    b=L9UOthVWOLA+Lfpxh/Wt0eJ53Y3mvGXJ1j6Mqn6iUfpxNdgJ+NcrK8ZPIqALKTIlwu
    jh7wgXfanMBNJG6E3FjIOscmJaxqKKSfjrymRyjCZ8TBoNKsCFeAPiqhoRg/gqdgwpGg
    lkfcFJIY1h4t1eS+nLrMzBgKB3cqBItlPsPxryDC2fncGs2BjHIHiW4QPE9l1un0BlsT
    ILZuyi+wsfLN+ExJPMxzptEaeIThos/neqEQhw094JUYP1MVGx6DDakiUcWPBQXfwRNh
    4zFJlBEIP11FT4s3dq2x1KlGQ3Y6zCJmQ+llzK1gNSkWFm0YYgTbm8ryL+DMjyBYWLMt
    +5Aw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755867629;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=dyqgy5T3hx+MqXXKObwy6WBXqr/oFHAkqS1wlQiF4gA=;
    b=nxmKQCPhCIRF7ZinVmUI7+HayKuUW41E/T0aRamLmIPI7FcMOU7U0ooj/fUIIAYAvY
    eTFvu+ygC6mJivTInVSNFdlgqRg6qYJbEJVSYquAiwLpSVM/n/H9dZ3XtOil6Y/uHYwE
    AF396238NbPCXZ5qYYgG1kruPzPzbAvHhDFRCbkn0wL4WxcFa5Yr9io3GScTpMFljWOM
    cb6Yziznjm31oBF5HqwVKQN6NR5JSIgSvIrf87axlgUxWmlmFhRcFVSLb79/fKz7pQx9
    rV4WqyKU/ArlNT8Do5SBhu6a8jq4v1GrlqpEfq6pD3CjKbZdosJOHoV/dw65cM/T7Bub
    U+8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755867629;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=dyqgy5T3hx+MqXXKObwy6WBXqr/oFHAkqS1wlQiF4gA=;
    b=Jp/67mQNx3H74Jec//qwPYmo0UxLEBWaAYkXHLrRjsBN71l+eAVP61N54Ku31kPZwu
    +rS7H9RI/6iFaZr9KiDA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfz0Z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 52.1.2 DYNA|AUTH)
    with ESMTPSA id Q307a417MD0S2Yt
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 22 Aug 2025 15:00:28 +0200 (CEST)
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
In-Reply-To: <F9E0EBBA-094D-4940-8A15-409696E6B405@goldelico.com>
Date: Fri, 22 Aug 2025 15:00:18 +0200
Cc: Sebastian Reichel <sre@kernel.org>,
 Jerry Lv <Jerry.Lv@axis.com>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 stable@vger.kernel.org,
 kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D003BFF9-737D-432D-B522-9AD5E60A6E9A@goldelico.com>
References: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
 <20250821201544.047e54e9@akair>
 <10174C85-591A-4DCB-A44E-95F2ACE75E99@goldelico.com>
 <20250821220552.2cb701f9@akair>
 <F9E0EBBA-094D-4940-8A15-409696E6B405@goldelico.com>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi,

> Am 22.08.2025 um 08:51 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
>=20
> What do you mean with "catched earlier"? What is your proposal?
>=20
> Well, as proposed by Jerry earlier, it appears as if it can also be =
handled in bq27xxx_battery_hdq_read()
> by detecting the register BQ27XXX_REG_FLAGS and the read value 0xff =
and return -ENODEV.

I tried this but there are more locations where BQ27XXX_REG_FLAGS are =
read and where the reading
code is not prepared to receive an -ENODEV. This will for example emit

[  293.389831] w1_slave_driver 01-000000000000: error reading flags

each time the battery is removed. And in some race cases (a read of the =
full /sys properties is
already in progress), there may be more than one such message. That is =
not nice to replace one
console message with another...

So I am not sure if it is a good idea to make the lowest layer ("catched =
earlier") read function
detect -ENODEV based on the register number. It can not know what the =
next layer wants to do with
the result.

BR,
Nikolaus


