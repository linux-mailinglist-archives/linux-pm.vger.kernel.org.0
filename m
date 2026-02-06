Return-Path: <linux-pm+bounces-42199-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPkMH/nmhWnCHwQAu9opvQ
	(envelope-from <linux-pm+bounces-42199-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:04:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE170FDD60
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76650301DE38
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA61F3793C8;
	Fri,  6 Feb 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="X49wI0kX"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FD313E10;
	Fri,  6 Feb 2026 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383094; cv=none; b=Ebnd5T+1H3eGJ0ENRlGCJ2bMYyJZ90/EnArNh2+JqNeiloU7MB7XaD7++7p6XpwSDVIdNmfmwGUHrq2W8XIt2inJQYCneIwqJFB/3VQXBGNpx7oiAUtu5Fxur+l7rmNMEw6Pkt0sHM9c/4/4H1qegMei8ZN+o8+LNjZ91KpUw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383094; c=relaxed/simple;
	bh=ApWPhL6JQBKOjYvyWVNeD4gaRhQWHkve1pRyR2n+Sdo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FQYoJzPThKsVksvmbihBOT3KMtDJKU8MejN1O9KZmqArgPjjxQEK9NqAP4iVT7T51VLMTfyFp9iMS2qmzv+TfL/Xr+HTI2K7OYuBMOJGGViVBtUn7/adf1tDDvgXlPDkQcp9WnTGzPUdsHtCtOvVc1Z/sD60zQe+plrX5ppcBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=X49wI0kX; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A90A525F3F;
	Fri,  6 Feb 2026 14:04:51 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cfgujahYoJKc; Fri,  6 Feb 2026 14:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770383091; bh=ApWPhL6JQBKOjYvyWVNeD4gaRhQWHkve1pRyR2n+Sdo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=X49wI0kX9/xFhK147Q1nKOBVuMw59bC30WOKQwfWva0RLzTbdUe1L8LgIuGApjbcF
	 1I548ua2067P1/kaDqtD55RV7/x+5fA67RxtAajfdHvSJkhIbgSv9FjUI05fTWyl0G
	 kmkgbIGEQlrExgUASdflLJP1nVubJwDf1thQ3X6rBQi190pgb1R6vX3wgQy68qQQec
	 n5ffj9hetUofNH8G3tF6r9SRtVdMEUVvD0EVloIGSB9dJ2YDfP4BqqBTmWknzqdTh4
	 yUaL1esaswwpSMijGLGqIWUf5INPVnO8jSoO6SKTp+uCmI7Ts7blad3TG4k3VQJ4KU
	 4RUN5TEGfGH7g==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 18:34:45 +0530
Message-Id: <DG7WFDLZ3J68.2PGGTXYAB777A@disroot.org>
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
 <aXq7NohfIy3c5AWL@venus> <DG2QBROWWMLI.2EE3CBLLPAJHR@disroot.org>
 <aX8yPp2JVubxHNFJ@venus>
In-Reply-To: <aX8yPp2JVubxHNFJ@venus>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-42199-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE170FDD60
X-Rspamd-Action: no action

On 2026-02-01 12:14 +01:00, Sebastian Reichel wrote:
> Hi,
>
> On Sat, Jan 31, 2026 at 04:44:36PM +0530, Kaustabh Chakraborty wrote:
>> On 2026-01-29 02:59 +01:00, Sebastian Reichel wrote:
>> >> +static int s2mu005_fg_get_status(struct s2mu005_fg *priv, int *value=
)
>> >> +{
>> >> +	int current_now;
>> >> +	int capacity;
>> >> +	int ret;
>> >> +
>> >> +	ret =3D s2mu005_fg_get_current_now(priv, &current_now);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	if (current_now <=3D 0) {
>> >> +		*value =3D POWER_SUPPLY_STATUS_DISCHARGING;
>> >> +		return 0;
>> >> +	}
>> >> +
>> >> +	ret =3D s2mu005_fg_get_capacity(priv, &capacity);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	if (capacity < 90)
>> >> +		*value =3D POWER_SUPPLY_STATUS_CHARGING;
>> >> +	else
>> >> +		*value =3D POWER_SUPPLY_STATUS_FULL;

[...]

>> An older revision of this driver (I don't have it anymore) used to add
>> up the consecutive values of current in order to reduce the effect of
>> this inconsistency, but it was still unreliable.
>>=20
>> Moreover, I do not possess any documentation for this device, so it's
>> not possible for me to know what or how.
>
> For the setup I described above, you consider everything above the
> treshold as POWER_SUPPLY_STATUS_FULL independent of the current
> direction. So you need to reorder:
>
> if (capacity >=3D 90)
>     return POWER_SUPPLY_STATUS_FULL;

So I have tested this. Should it not be discharging when power is not
connected (current_now > 0). Doing this shows 'fully-charged' in upower,
with the charging symbol in GNOME even if the charger is not connected.

In such case, the logic in the current revision of the driver is
correct, where it assumes the battery to be full ONLY if it is charging.

>
> if (current_now < 0)
>     return POWER_SUPPLY_STATUS_DISCHARGING;
> else if (current_now =3D=3D 0)
>     return POWER_SUPPLY_STATUS_NOT_CHARGING;
> else
>     return POWER_SUPPLY_STATUS_CHARGING;
>
> Greetings,
>
> -- Sebastian


