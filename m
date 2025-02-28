Return-Path: <linux-pm+bounces-23168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B3A4968D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 11:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C353B24F3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5C25DB15;
	Fri, 28 Feb 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="L/W6fTqW";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="UhjLYDQY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1C25DD1D;
	Fri, 28 Feb 2025 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737100; cv=pass; b=C1H3/SXKpLFLczVDi7v7uaJxoYwhKmGsHU7r5wn8YSY/5moTQKdCCqHmgrS+0AIFz9AC5oMmP335mk58ac372VDh3xM7TQSCGwBa1LO/nxF7MKStdVVja1KMEWXvzPHqK+RO19pO/czejR2mQMtssxSPl/zHkaqyQ89AxQaqZYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737100; c=relaxed/simple;
	bh=jPDALfJ9nOL+lYDnCEeUEdOe2ioz+vzs32Iyd3gnumA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=me9v9Ylzdihy/RelYSvU4DbANiarV3pS0xxTJxj+k3ZC/48T65nnraOrfACtJgY6y9csKXBw2xs05niF/9ZeZ2zVtevllX7WUaArvlhUVYObRadTveOk232TJfLvhjZ8p417G2LiqmHBJ3YoSZasdGfCCd5Ag9msjiHv1ZU3Lxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=L/W6fTqW; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=UhjLYDQY; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1740736906; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ze2OTPM/iC1Yv0OlkS/bh7N/ZWQX3G0rCCoHhJoShWm1PJ08VDmXjs7sJL2fcspPQv
    x2nYaubH9w7HlqjdQE7xnkbu2H50PjoUSVuiviFxtw/wKS6dDESjAXl/PenxXPOTkNwT
    XjiVSB5jdXMyI2inOSan+7XunyXKauxWxrld8Gi2J0Oo7FnzJuNw3Qba3jI0/LUCFoIf
    aY3+G9l9sSU0mSJ3vXUYLbFIzjuSmUj7rF/U+mJa6w7haZ304+pC5UsMGxvEk0XIEChl
    a4leD1ICrdaKPJTcsriLgD42qPljhbnE1QqUW9SNQmLzOWzUo/KHIaFox9NskFEuXLYg
    vb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740736906;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=jPDALfJ9nOL+lYDnCEeUEdOe2ioz+vzs32Iyd3gnumA=;
    b=blEmoaun9dipJ9oJ24XX+DbSv4ZgAdxsn0dqB8Z4787dyHc/SdyymbPRHPIJAdAufV
    8qZ7LTc2/9Gwxs4/8/onP3mVYcpijrVR8tp44tIu+NkVtsO5ViFoR9D/TR1Lf7O7HbHN
    OeZaPfZEH2P3sa8dKXaABFYvIgVvIq5yV/1hiWOEQUbVwD9t7B3i456f1ArEYDhX86CT
    7tRs20VV6/G6Hw8kYyzBTFBmdr7b8IQ0zzykLovHXUwAuqXJkU7H4UXIjCRn7rpOI5aU
    U1xvkRl6bJk/8m6VoAJcGn4pO3VTyTFi20QyXlc3rCxwLiyzSctKp+uGVhkLLcmC9Y2y
    RsoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740736906;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=jPDALfJ9nOL+lYDnCEeUEdOe2ioz+vzs32Iyd3gnumA=;
    b=L/W6fTqWi34g7SgxwBdaXX23+PCB5eKgjGYbR1xlWBAJkngGhjBMUTs7I5C0zE/he6
    BDAusn+b6yIwfgULgAwKjF316AxGm2YQ1Ja/Q9s2vb6VBi57RUtoUXEtl/kNwIJpU2qG
    0TeqVhWRgSyF1bhz+YCf/zYF2tSYTo5xzkZsqk4f9bZskY1Pe5UzUzmD75PtScnCxVFS
    nZDdLIYYASVKhE3vc8B9b20yFptJAH3kxNd7qiRgvGRv5d0P8odYPleM5W3nyaKp8Zb7
    Su/yoCioyzz5MB8wS6DmZqK+PhaYTFiYhi735/FVJePg4yIygLnJ1oYQ7zarzLIbuI3f
    I3Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740736906;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=jPDALfJ9nOL+lYDnCEeUEdOe2ioz+vzs32Iyd3gnumA=;
    b=UhjLYDQYzpwbT/Wv6JV7Kg4wUMKhNWsYYW9IIX0kn7Swy3cI/RT71+p8HTYkU7nFW/
    PyFJTPJ4bHuBapHyxtBw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeTkZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.3.0 DYNA|AUTH)
    with ESMTPSA id Q56adc11SA1jHF0
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 28 Feb 2025 11:01:45 +0100 (CET)
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
In-Reply-To: <Z8GHuu8RXkcY8utL@tp440p.steeds.sam>
Date: Fri, 28 Feb 2025 11:01:35 +0100
Cc: pali@kernel.org,
 linux-pm@vger.kernel.org,
 maemo-leste@lists.dyne.org,
 phone-devel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 akemnade@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D7D3E00-59C6-42F6-AE96-F04970D60E8D@goldelico.com>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
 <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
 <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
 <C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>
 <Z8GHuu8RXkcY8utL@tp440p.steeds.sam>
To: Sicelo <absicsz@gmail.com>,
 Sebastian Reichel <sre@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi,

> Am 28.02.2025 um 10:54 schrieb Sicelo <absicsz@gmail.com>:
>=20
> Hi
>=20
> On Fri, Feb 28, 2025 at 09:27:29AM +0100, H. Nikolaus Schaller wrote:
>>>=20
>>> Will you submit the fix, or I should?
>>=20
>> I think the patch has not yet been merged anywhere (but I am not =
sure), so
>> you better can send a v2 of the series.
>=20
> It is in linux-next [0]. Not sure if that counts?


Ah, I didn't recognize that (and must admit that I did not search =
through
linux-next). Sometimes maintainers close a discussion by telling that it
has been merged.

Maybe Sebastian can replace it or recommends a fixup.

> I guess the only option
> now is to submit a follow-up fix?
>=20
>> And, I think I have found another potential issue.
>=20
> Thanks for the review. I will do more thorough testing over the =
weekend
> and send the patch.
>=20
>=20
> [0] =
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co=
mmit/drivers/power/supply/bq27xxx_battery.c?h=3Dnext-20250228&id=3Df3974ac=
a381e81c0b1418d8ecc12fa62e1e9d31f
>=20
> Sincerely
> Sicelo A. Mhlongo

BR and thanks,
Nikolaus


