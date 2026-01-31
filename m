Return-Path: <linux-pm+bounces-41826-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIBEHzHkfWkgUQIAu9opvQ
	(envelope-from <linux-pm+bounces-41826-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 12:14:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7836C1B00
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 12:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C6A7300AB13
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB542F746D;
	Sat, 31 Jan 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dPj1kd4Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785D2F5311;
	Sat, 31 Jan 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769858094; cv=none; b=SKB3JfBKKMPSvSLTG5doXAkJ4cU1hr6KKyOl0pY4FZI7iAOMuCxV6qSTjn6kH6wyMud/rJYLS1pm3pgIiqwEixXyPC5fS/6mDpiYonhVXXeWBupv3n5Pt7bBDiat81ARAkv5xHphuMNXw9FhwTS7Hd51zz8sATonlEf9te3YjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769858094; c=relaxed/simple;
	bh=vTPyY8HTmGW2RgCpl/uVO0QKx0bWf2s50h7Bkk+/OAY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=byqr2ZXQSWzF5k4LyUzAa5JpfFCKdeQLTdjkW1kexVg6FqJz4GNfppvgBIh+KZhCEUjt5+061P7HdKmIc02hBNmiyNjF5nyWIGNCzH5nYcuCnDyiBZcdsw1+Z/vgtBxfhsayoyosFDVWwGo80hRC0bZfblvLjsw6W7qy0IhlehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dPj1kd4Y; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E616E26082;
	Sat, 31 Jan 2026 12:14:43 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tn1XiRgQXBpz; Sat, 31 Jan 2026 12:14:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769858083; bh=vTPyY8HTmGW2RgCpl/uVO0QKx0bWf2s50h7Bkk+/OAY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=dPj1kd4Yr8tySwucNRmL1kMNl+enMMXuXJiv7AY2r6ovOphoz74bze89+MnRkco6j
	 AoIXxIoCd1DQ0zt878YXX/ECM0ng+BFHFFGNTnpauPR6rLqfeeDGuKBR7EGt062oz1
	 gtDTZeVAT7y9XXgrP8FGS3yz0S6WvYog24dUKmILxY9+7p83zREbgk6V/ZeXg/kuKf
	 JoKYPcNe2/s51SSesH80yIrUSEv04mt0bNjlgiGIoVNv9J0yhmEVEi5evBrwW/uStO
	 9WaYA5WzrPKWudm77HQ2e6TcK1m1blk3UfC3xdi8+eSWZXPkQvz2LoHTIGXZTTanUz
	 XV5wB9OtVGxLQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Jan 2026 16:44:36 +0530
Message-Id: <DG2QBROWWMLI.2EE3CBLLPAJHR@disroot.org>
Cc: "Yassine Oudjana" <y.oudjana@protonmail.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] power: supply: add support for S2MU005 battery fuel
 gauge device
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Kaustabh
 Chakraborty" <kauschluss@disroot.org>
References: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
 <20260126-s2mu005-fuelgauge-v1-2-68a146ed0819@disroot.org>
 <aXq7NohfIy3c5AWL@venus>
In-Reply-To: <aXq7NohfIy3c5AWL@venus>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-41826-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,disroot.org:dkim,disroot.org:mid,protonmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7836C1B00
X-Rspamd-Action: no action

On 2026-01-29 02:59 +01:00, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Jan 26, 2026 at 09:09:49PM +0530, Kaustabh Chakraborty wrote:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>=20
>> Samsung's S2MU005 PMIC, which contains battery charger functionality
>> also includes a battery fuel gauge device, which is separate from the
>> PMIC itself, and typically connected to an I2C bus. Add a generic driver
>> to support said device.
>>=20
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> Co-developed-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---

[...]

>> +
>> +static const struct regmap_config s2mu005_fg_regmap_config =3D {
>> +	.reg_bits =3D 8,
>> +	.val_bits =3D 8,
>> +};
>
> Looks like all register addresses are 2 byte aligned and you are
> always using regmap_raw_read to get 16bit values. So just use
> .val_bits =3D 16 here?

Sure.

>> +static int s2mu005_fg_get_status(struct s2mu005_fg *priv, int *value)
>> +{
>> +	int current_now;
>> +	int capacity;
>> +	int ret;
>> +
>> +	ret =3D s2mu005_fg_get_current_now(priv, &current_now);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (current_now <=3D 0) {
>> +		*value =3D POWER_SUPPLY_STATUS_DISCHARGING;
>> +		return 0;
>> +	}
>> +
>> +	ret =3D s2mu005_fg_get_capacity(priv, &capacity);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (capacity < 90)
>> +		*value =3D POWER_SUPPLY_STATUS_CHARGING;
>> +	else
>> +		*value =3D POWER_SUPPLY_STATUS_FULL;
>
> Usually there is some kind of hysteresis that stops charging
> when the battery is full and then restarts charging once the
> battery drops under a certain capacity. As this code first
> checks the current to determine if the battery is discharging
> and only then checks if the battery is full - does your code
> toggle between FULL and DISCHARGING?

(Perhaps I misunderstood your query, let me know if I did)

It has been a while since I last tested this - but as far as I can
recall, after a certain threshold, the current would constantly bounce
between -ve and +ve. I believe it was somewhere around 90% to 95% and
above. If that's what 'hysteresis' is, then yes.

An older revision of this driver (I don't have it anymore) used to add
up the consecutive values of current in order to reduce the effect of
this inconsistency, but it was still unreliable.

Moreover, I do not possess any documentation for this device, so it's
not possible for me to know what or how.

