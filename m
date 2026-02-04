Return-Path: <linux-pm+bounces-42079-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF7SHUhBg2kPkQMAu9opvQ
	(envelope-from <linux-pm+bounces-42079-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:53:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D27E60A5
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8585300CFCC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF383E9F61;
	Wed,  4 Feb 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="LICtSYF7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09C1D90DD;
	Wed,  4 Feb 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209605; cv=none; b=NtUaKKuMvWGKytIIi8Moi06psyTag5xJwrIIZoev7EGDKSh90hpbm/wNuLeZw6b4oT7DzvPEUMM5hGK3BYtSgo2dek8EtwBjJdx1cMc/IC1WeA6WUKg6i2c5eI5U/jKZtv7NRr+YVwZYWd8i+DNjPCR5ZVG25QIxZ4QNQXxw0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209605; c=relaxed/simple;
	bh=XKZ0O4tib32/WcZrVvEJHYSf0v/u8ruNYekVR/2Gpt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7KgKQY11F23K1TuQDKV1ei4l2/rNNS/Ykoy5B3lIDdpf22uLAvKiJI/vn4eRdOBj5YHIoNI0QRx3/UrG/5QGp4wklvJ+nEM6TkJv8AT6C+CxCWUzU4w9d/kZ0fsIwTrmV8HNq9LdXZO9XgR5BDUI4YnJyoqj3bC7bwPCPnWpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=LICtSYF7; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1770209580; x=1770814380; i=laurent@vivier.eu;
	bh=XKZ0O4tib32/WcZrVvEJHYSf0v/u8ruNYekVR/2Gpt0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LICtSYF7t70Dbj0bVHC7hxS6Ai4Bbk04f84ar5V2x3ER1zNpmOELcsiUtrFr9DY9
	 N+tSGxd5O8dcK7Q1CwiEw1TfhD3m/aCmKoWmlzq7SDgsJiwUotAnniPLYh1QXBtvy
	 E4yozK0zw4t9/oskASSNALOPEJh1U/zOSfeopfYQQ68X34NxIlSSe++ur2qEwdgyN
	 xCXKFvZru0yVgPBJJag7FfCURWPTbRH27y1eG6c31DemzpdPtrmQ0QlPE2a1iV0JI
	 BJof6pMZmpP8F/qLYSB888wH4I1j45jV6EIvwiUeJ5WZVpg6yQWVEESmTO0KTy9lo
	 zdmsHa9GvD5I9IqnGg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MBDvU-1vzDU20SVy-00EZNJ; Wed, 04 Feb 2026 13:53:00 +0100
Message-ID: <2a4ebbea-12c9-4362-aa09-dd3a7de1be46@vivier.eu>
Date: Wed, 4 Feb 2026 13:52:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add QEMU virt-ctrl driver and update m68k virt
To: Daniel Palmer <daniel@0x0f.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, sre@kernel.org,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260203170824.2968045-1-visitorckw@gmail.com>
 <CAMuHMdUMBoLd8cKXMK64qjGfTqQfK21mDAXMh8DdJHkL7QbDVQ@mail.gmail.com>
 <e7ddd671-6e25-4114-9d4c-21ecebe82ef5@vivier.eu>
 <CAFr9PX=heS=ywLCidd8o_BzS4TS5U=GA8yv7itzNFp5nuwf2XA@mail.gmail.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <CAFr9PX=heS=ywLCidd8o_BzS4TS5U=GA8yv7itzNFp5nuwf2XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dnU8ToB1l10ON9VWpX9DtFusS+B83vjoCMcTgHBE9iZSWwTpKJw
 MyszHosrdCRKZ37xN+Vimg+0Wvcl5wISHv6O3gZjAXPs6BhtAwDOGQmXkCr1Ub298vmj4aa
 dzz2lwLbB+rXmjgaOm7sE6RPWL0f9FSQcM40cbxSzENWYjyyGNFnKXs35zTZqfynUt92t8Q
 3WDr21klMcbo1FhCvxVlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WGzCrz8zgbs=;f/HvPiGzegGuXldSlulnyctZ5R6
 9txvZhbcvL7rKeuwAPEWZL5k3Mzh43Zm0Tk9P+91FbXKZCi5dCzdmwRPgGPJbs9bDlbGQwAWD
 HGAsaYLdLa4T8mpDG2Otlw5SIG9mUmVpAE84cCRVWsQbTnOZDndRz+ASCQ+RRoDpE+V6aWf33
 giBVUBU9iU3Q8WrBqBaGpLSSored1RI7PfNBlgtyJdBDssRTBP0aQYPVRcuD4cXz2SJMEM5c/
 L+pROkPGQlxT7buVeM5IB9gCSCqj2VdlPZZGEN4P1fnZqqXcRoHvGo/H52RnIr/ww0rMdLWvN
 h2Sgpd7QOJrqI2t1AKLRzLYrX92RgC6OoX+6NVN19ImqeP3hiUG4bVXOkTzyZXeaTEMNH7uoA
 tGM+FNDrGP4oh11yKe12Qnkwf9TsE7N7p+G0TNvwLXNooIliWRAyGjK/zNQwTPYG12y/PuN7w
 dbTUnZV0TaWgclpfo1vO5yHWGhNnbwb1N+qfrYGA7OkpdSkK6RFflEzw6nLDC8daCLwVvq1HZ
 OkWPVLn7d9PgB2sHSjgrLXGF1E4fUagFRzujAjkObS5YhaqxsllbzRCZFuVM+RQ9ByVmhzuAq
 7Su0h2CgOiCt2nxilzgwIG7WxRuBEFZBhtkpmraHRNkqeEIbwucJeP2baEGEScWOnr/a3WTdz
 uL+qP9qgqYYh3srh5X0ze7gerwxMNOSZstyGMEBg3vb4f6CzShUAExCjgaARSCWYjz8Md/4Km
 HGX/+ZdjaAsv8EBQeQiKBjRCUNb+tt0I7qz1OwAEgkk+7SR6kG+/stnFHmUIAmR4Gj72vGlHa
 QwjLkbltvMF3hbBRFGAL1IA2iFU5SKIgVSVOq7RghnRraE0R6E5A1f0UycvOQp8Zlhwx1cBKI
 ZMe4+XuKSqHObfFPQFZqevuL18Kvhm/hkgmq2X3iWFizhm7PdtZBhzyOeExcs2XpyqGlHFSu8
 q29/edoFVwwSZDkQv/ykge4zBP42PNiIhN0bov9UiKTpshI9tzLlIb7fXbrHkt+/pPt8clab6
 OY0nxOL1DhMhu63CbXxSHcExHv0gxthZohBuVebZPWJxXXrNx0gC3/7RMO76mliDD0QLksJtV
 EGM55nJCuqJsqTphiWMtNQUfOGS5jN52tHrMI+hP4fGCg4kadC39nZkIrpE5RgZxrkjsaPCDr
 CEIon2nmKkaU9xEiVj/JyKP81+NesAv2eRywZzX2c8MZh0I5bkO6dno6vYGNh3LxXhE9TlZ+C
 GJhVrnMLztE3HcpojqeGQTe84HHb+FYiitkfsXnFFEkwp+tpHY3BIX2ZuWqQlbumXnf3wKrNL
 VilMsQ8ZpUnMv7kDFhG20QwPR1ZU5RjoLQwDF3YtdPLFQKzXqWAIyVqJvufyauXA/J2aLXL/w
 +pv/yZnBWbG9h781Nn4GL6Flu5ComJ6zwbNPfyubG7SsmfRxtk9f0vjyfi01NJyq6JCLjx0BW
 Tpbk4nsWORBaEjf0R4jucclMsejDcDkfcN1TKdWH3rUmnku1hSSnJ8wNnabllgNbBRy718u0V
 Lc9O/2mK7dfIk7xkrdKQDygNevFIWOXzADN0KRnRxZ7mvDusClH/9FDVt2VKhPWkb62Q3txlO
 jEMn2u7FLhrLjzCXzZ9b2oW4AAj2yeBrGh04DbSKKlANdB7cJxbVdlRv59F5tiL2+QMe76KTl
 N9lkSj7sFYeO1uxnaNJss4xPTvHMJEbOOcjKATZOvnKWVf5FB13nV0gLy1jiu9nAWF1rgOpVs
 edQyUbwHS68sGi0tpL1uL+j3qjZlQcbNZt/MxJ/lP2s8dGqPqDhA9/jY=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[vivier.eu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[vivier.eu:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ccns.ncku.edu.tw,vger.kernel.org,lists.linux-m68k.org,linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-42079-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[vivier.eu:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent@vivier.eu,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E9D27E60A5
X-Rspamd-Action: no action

Le 04/02/2026 =C3=A0 13:47, Daniel Palmer a =C3=A9crit=C2=A0:
> Hi Laurent,
>=20
> On Wed, 4 Feb 2026 at 18:09, Laurent Vivier <laurent@vivier.eu> wrote:
>=20
>> Please cc: me on the next version
>=20
> FWIW support for the m68k virt machine also just got merged to u-boot:
> https://lore.kernel.org/u-boot/177007672356.4123720.10843284111217950440=
.b4-ty@konsulko.com/

It's great. I did a port of petitboot but never merged it to QEMU.

How to use it with QEMU? Do we need some changes in the code?

Thanks,
Laurent

