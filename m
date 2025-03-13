Return-Path: <linux-pm+bounces-23959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6AAA5ED33
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 08:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACB0189A45B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196E313BC3F;
	Thu, 13 Mar 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ndndoLzp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDD1FC0FF;
	Thu, 13 Mar 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851765; cv=none; b=CLoqB50P+DTxgq5931ASygj+RCr5BML6V31cADkd6Mjm0xCGwq/eXTyx9C8cp14+as0PFF06/337vEOVS2ZhWP2ZsxjHhuqge9JTPwtyS9Wz9GU/u9zqhEmpj1vXxv0UfwCWMkFd1sZ/pAupZBcwDjhrxBFJeTWd2zQzjXhC+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851765; c=relaxed/simple;
	bh=1CWiZ/QGHZQ0ncSiJsU2ciZ1PiftlSrzXql0n17AEB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1YswKEoZJBgGXQHvZWLQYBGu6/zfu/z9L9kmErg1n6p/Pvdgcj5Su6fYup0aPq+DAkIFyZiX5eOOcNw4ZXCFv+2YhFhlMePE1nnB/kU+LCaZzYN2JAznHmjgZRmntY7its0yi7HOBlF56bShdkGYe25EQoupCsV1BtRJcQ36s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ndndoLzp; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WRdyeSScTzNUiuoEjAxTUDecuGjauvQK9XKxzhuQQgo=; b=ndndoLzpYP3r4WHM5zp2YU1YbH
	vSRIuqMVGPGeSl5FMl9gPh/okB/m+srxV9bCPUyTvKL2l5sdLMPHMo4u0iwDV5jkwIteFrr1WRMb3
	TGtHAd5rdibe21ZAfriLejeznnnIng7BZsOwysE4OOrKdarKHxv/NuWWOV4vCdb+N/Goi8pJBkqHr
	oZAOAx9i2MyInqp1LaNwWnsUbBGeCJCD74tBMMAXq0Jg5y8JJ58ezr24GCOUp9AEEu9dhdVhl6B5y
	ibZxuQ516VMAU/Nq1gIRt0X+QPK9oXwIKXTOEhgncHQOBmBtpzn7B0L4BsBysKKE/U2pX13gy3Q9S
	O6z9OINg==;
Date: Thu, 13 Mar 2025 08:42:31 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sicelo <absicsz@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 pali@kernel.org, linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org,
 phone-devel@vger.kernel.org, Discussions about the Letux Kernel
 <letux-kernel@openphoenux.org>, akemnade@kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
Message-ID: <20250313084231.7e132b17@akair>
In-Reply-To: <FF01728B-C13C-4CD8-8F61-419AACE03C0C@goldelico.com>
References: <20250207220605.106768-1-absicsz@gmail.com>
	<CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
	<511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
	<Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
	<C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>
	<Z8GHuu8RXkcY8utL@tp440p.steeds.sam>
	<4D7D3E00-59C6-42F6-AE96-F04970D60E8D@goldelico.com>
	<Z9F92vGJbyUSFgxa@tp440p.steeds.sam>
	<FF01728B-C13C-4CD8-8F61-419AACE03C0C@goldelico.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Thu, 13 Mar 2025 08:28:35 +0100
schrieb "H. Nikolaus Schaller" <hns@goldelico.com>:

> Hi Sicelo,
> please can you append the patch to the e-mail as usual?
>=20
That just applies, no issues.
$ b4 shazam https://lore.kernel.org/linux-pm/20250312121712.146109-1-absics=
z@gmail.com/T/#t
Grabbing thread from lore.kernel.org/all/20250312121712.146109-1-absicsz%40=
gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 3 messages in the thread
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH 1/2] Revert "power: supply: bq27xxx: do not report bogus=
 zero values"
  =E2=9C=93 [PATCH 2/2] power: supply: bq27xxx: do not report incorrect zer=
o values
  ---
  =E2=9C=93 Signed: DKIM/gmail.com
---
Total patches: 2
---
Applying: Revert "power: supply: bq27xxx: do not report bogus zero values"
Applying: power: supply: bq27xxx: do not report incorrect zero values


> Then "git am" can easily be applied or it can be found in patchwork.
>=20
> BR and thanks,
> Nikolaus
[...]
> >=20
> > [0] https://lore.kernel.org/linux-pm/20250312121712.146109-1-absicsz@gm=
ail.com/T/#t =20
>=20
>=20
Regards,
Andreas

