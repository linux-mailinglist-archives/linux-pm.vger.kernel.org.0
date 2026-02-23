Return-Path: <linux-pm+bounces-43039-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SARzHTNenGmkEwQAu9opvQ
	(envelope-from <linux-pm+bounces-43039-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 15:03:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B10177A99
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 15:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED02630372DA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3380F267B92;
	Mon, 23 Feb 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jrkSoxxO"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F418CBE1;
	Mon, 23 Feb 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855038; cv=none; b=hXO8bzssOr2Zsh/zuQZupCxOTBw10LqLR8DWiC8HtALJXZo87Pj3bFXpN4cH74jBtBTxiSGL3v4Q552P0VvgigZeMoPjrj34oyIvUNjs4c+BVZBBv8gbojKWoEsJ83wg7zNshklxKPvCQEUIjsK8/uYRhVHfX0qAeCpGeEYRinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855038; c=relaxed/simple;
	bh=jimk4cgA6P8145WtS7AypZKTzXi7xwx6dJcxj5oDHJY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=flwX8tugJZOx7xSqPu0CutCC/fPCD4FZ+kzc8geM8szI5DQ5GMxbZ/dsGzzyVSkDOPwyyyuN042Ag4S9Do+JcN5VkSh4H+oBrBGSZsWuJnS+qyZZL4N7ULQFuyrw0qZOso7k+D98tB9mAX8KccdPqFmxTGdXPKVAOwvW2ss374Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jrkSoxxO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A9C0B27E35;
	Mon, 23 Feb 2026 14:57:07 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tac2RrMprsBW; Mon, 23 Feb 2026 14:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771855027; bh=jimk4cgA6P8145WtS7AypZKTzXi7xwx6dJcxj5oDHJY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=jrkSoxxOqv98EFGeGJpGTfbWycO470StieDpHkpvwSVYOdO+ixUJHSH0/2Txy8R4/
	 bCEG7Sh9Ln/4+uBuszgWxdqJp0az+MJT2XJ2HTdPUFqkGvbXlKF2zGG0nrE/bbBkpc
	 06Ps65NKVetf/+bipRD8EqrhjOi2Km7fG1yvBDhUUN7p7SJOleCLskPp7UyvMqRj8U
	 yxrZARhKFgIx+l3MGQOLUht/nEYFJc875duDxCvM9BEAs0iGuIueRmgF67tCP9T3Ff
	 HzjS4vtY86VAjSKqWBLiHJUFhdMfiuM0G6doeDKLSyUx73VJAvVZi7xajZdGJmdyAV
	 V9p7G+qb5lXLw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 19:26:52 +0530
Message-Id: <DGME6JKOXQN9.3GQ7SEI0D8A5U@disroot.org>
Cc: <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 06/12] mfd: sec: add support for S2MU005 PMIC
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Sander Vanheule" <sander@svanheule.net>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Lee Jones" <lee@kernel.org>, "Pavel Machek"
 <pavel@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "MyungJoo Ham"
 <myungjoo.ham@samsung.com>, "Chanwoo Choi" <cw00.choi@samsung.com>,
 "Sebastian Reichel" <sre@kernel.org>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
 <20260126-s2mu005-pmic-v2-6-78f1a75f547a@disroot.org>
 <69e2c1b1a2f3d2ed5e5da995cc5ee49bb3627597.camel@linaro.org>
 <DG74Y3QSCLIO.32Q8ZKCTISXXB@disroot.org>
 <4cf24e281fac45637fedf40944d8b5230c0e22d9.camel@svanheule.net>
In-Reply-To: <4cf24e281fac45637fedf40944d8b5230c0e22d9.camel@svanheule.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43039-lists,linux-pm=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail,disroot.org:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:mid,disroot.org:dkim]
X-Rspamd-Queue-Id: 47B10177A99
X-Rspamd-Action: no action

On 2026-02-20 17:56 +01:00, Sander Vanheule wrote:
> Hi,
>
> On Thu, 2026-02-05 at 21:02 +0530, Kaustabh Chakraborty wrote:
>> On 2026-02-04 15:23 +00:00, Andr=C3=A9 Draszik wrote:
>> > On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
>> > > +static const struct regmap_config s2mu005_regmap_config =3D {
>> > > +	.reg_bits =3D 8,
>> > > +	.val_bits =3D 8,
>> > > +};
>> >=20
>> > No cache? And what is the .max_register value?
>> >=20
>>=20
>> This was in the previous revision, but I ended up removing it because
>> (at least I thought at that time) interfered with interrupts firing in
>> some way. The actual issue was unrelated, so I will add it back.
>>=20
>> However, there is also another thing I see in logs:
>>=20
>> sec-pmic-i2c 2-003d: using zero-initialized flat cache, this may cause
>> unexpected behavior
>>=20
>> This is due to REGCACHE_FLAT, I am not sure if I should just ignore
>> this.
>
> Sorry to be late to the party, but I'm somewhat responsible for that warn=
ing, so
> allow me to chime in :-)
>
> What you are might have been seeing is REGCACHE_FLAT giving you "cached" =
values
> of 0x0, while the hardware actually has something else. This can cause om=
itted
> writes, existing (bootloader) config to overwritten, etc.
>
> As Andr=C3=A9 suggested, using .num_reg_defaults_raw is a possibility, bu=
t then you
> have to remember that the register defaults are taken to be what the hard=
ware
> state is at that moment, including pre-probe changes. These defaults are =
used to
> seed the cache (so far, so good), but this may break the contract of
> regmap_sync() if you ever want to use that after actually resetting the P=
MIC.
>
> If you want to use the flat cache, I would suggest you use REGCACHE_FLAT_=
S,
> which will track what has already been read from/written to hardware. You=
 will
> also need to specifiy .max_register.

I had figured that out by going through the logs, thanks. :)

>
> I see the other regmap_config-s in this driver also use REGCACHE_FLAT, so=
 you
> may want to consider switching those over as well if these are also showi=
ng the
> new warning.
>
>
> Best,
> Sander


