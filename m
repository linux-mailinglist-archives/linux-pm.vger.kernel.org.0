Return-Path: <linux-pm+bounces-27974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C4CACBB40
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 20:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E571175728
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 18:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734B1FCFE2;
	Mon,  2 Jun 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EgCPp2W5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A092C3259;
	Mon,  2 Jun 2025 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890268; cv=none; b=qXRORowozuKTKw7SdjPSTFLgjI0obZKYZZ+hwiSsCzi/mRCzzckPdNPN2HaTtm3tuLU6L6UXK9KAQJnFfuMm8PynG+inl/B3fDEEH6A1rBGfI5TqE/OV4fy8eZv6kdpnOKuE+9sHRHqXDBtioEcHAwFwxiH4XBoctkmEMNfj3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890268; c=relaxed/simple;
	bh=31hnNgd79GBmoN9zQcfuoe6SKDLiVIHuPZkpbGefHuk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LNh6y+q/NCpqLzuCiZbXUXNZyFA06raesNNx71im+jKo3JseEByl04NEBJ088xGfRmnyiczz2caA+TzWDamNoMPCf809q8i3tX6oJ33v+aXOHj7JbQ60RlaKNbw3LiNGZmyVVzGMJHpVBhGPr8IziaMFxBMbbRb6piMSMoQ9LzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EgCPp2W5; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748890239; x=1749495039; i=markus.elfring@web.de;
	bh=bhYqTLrL7ElhDEdXHPA0IYxW9lrvK+T0G1+e+OFeEWU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EgCPp2W5zkUBJVCxahnbmD5edp9MVjGePaZ0CtSmh+Gj/aWF+Hrang61xEISNQ9M
	 hEDp+OwrZa7j9ZgH5UJ3xaUWrX4BMtqFxKVuPvIwU4+Nff8bbhGdOxEVGISRBEFRG
	 IB44gbsqKRtp+0aQp5iLHsFS0lKAOvsL+OZOhW2Rrx5pn6t95b4DQxQoow8iutjdu
	 8P0FIaxmzYSk0p0es7Too/p2Q6w0i+4qj1RN0o+eCb3wBmt2MUPs6Cai0gjZRc25h
	 lzA0Jvp3xXXHaEVm8NBfwrWzMoLzV1rRDISr4mKuTcRkcDvQtOhU60LJO3kJBUFDD
	 s1TcNrCve13FXRbKLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.173]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBB80-1uAatw2qcw-00ED6h; Mon, 02
 Jun 2025 20:44:18 +0200
Message-ID: <f5942d82-a7ce-46e1-ba13-ec2beef3403f@web.de>
Date: Mon, 2 Jun 2025 20:44:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Abel Vesa <abelvesa@linux.com>, Enric Balletbo i Serra
 <eballetbo@gmail.com>, Robin Gong <b38343@freescale.com>,
 Robin Gong <yibin.gong@nxp.com>
References: <20250527-pf1550-v3-5-45f69453cd51@savoirfairelinux.com>
Subject: Re: [PATCH v3 5/6] power: supply: pf1550: add battery charger support
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250527-pf1550-v3-5-45f69453cd51@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N19EgUuWxp9xLVxJ6hgrPcByenieBdhgJ05RBsQ7klH6bgR1lsO
 W36lGDa9wtpSDUpz1avZ8Q/WAzyX+jobwOjX+wkR+OQ+1QOJHOY8bjsUpkCd4LbfPlE4Neh
 551wcnuWwA6OA+vncYbPQuTelk08kQuyrxuoaxEcSnnJe/GVcRwhPmxfmWZyTUE5RwZgl66
 splxBvjz9ZAGkZZtOZ8WQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a7hC8t91ACs=;xJYzT8vNMj8L5IAqyT91QnoLOfF
 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
 OJsDWk2ihQ8CbaMc+ettGaZHNi27gNSNw5UEOA==

=E2=80=A6
> +++ b/drivers/power/supply/pf1550-charger.c
> @@ -0,0 +1,639 @@
=E2=80=A6
> +static void pf1550_charger_irq_work(struct work_struct *work)
> +{
=E2=80=A6
> +	mutex_lock(&chg->mutex);
> +
> +	for (i =3D 0; i < PF1550_CHARGER_IRQ_NR; i++) {
=E2=80=A6
> +	mutex_unlock(&chg->mutex);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&chg->mutex);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.15/source/include/linux/mutex.h#L201

Regards,
Markus

