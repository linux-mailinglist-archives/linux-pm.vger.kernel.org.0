Return-Path: <linux-pm+bounces-19829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455D99FDFD4
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974433A1B2E
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C318B464;
	Sun, 29 Dec 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WkZvn5WE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70472594B9;
	Sun, 29 Dec 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735488944; cv=none; b=W1B6e66yHIRrJ6sqq9FeTUQgJtcWBrDEYMD2VywGHcDsYu3QlmDVxjZVXiEOUO9ImQ994jfqxUP2A7KSskE1iZXwyzpc+XtvMSwfCEpysveVirukIP6CNuxlJ2C8rqf3ZBl+StmaFGVDN71KiZYMTK4lAF8UqXvJ114XMwK/cjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735488944; c=relaxed/simple;
	bh=apwEeeswKrp3FZ59Cs1Zz/EpIAJd+0SigGt3BHZfR5I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mBHZ44rp1CMcyS3XB73ggDEocZkgTa4otsIdlxUePqM2R5fnMSYCVrxBo5BiltqjA2L8534RkOzxpX5Lnqt4PEiGjIcxWZ53/lziWvJxPc+Gn3Y4aM11MP9a/LwMrnNMCKZfWzVIlbTLe+o9NrufYVE1re/V3NT8PpFdPemk230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WkZvn5WE; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735488933; x=1736093733; i=markus.elfring@web.de;
	bh=QSoFJnymi4D41ZRTLo69HsCAimuwsTVQKSmnk45fsGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WkZvn5WEJhEKukh+ReBwYGfpMnXV2b63AC+D2WGWx9M1c62i09yhvTtt5EaAKQFH
	 V5rSkvJ7Z508teds8ZVJUsWntkdm52921Iw4MwsK36SDL7fD0gCl5Az1sSNkgGKVM
	 TyoLdn/VO1Ye2fz41couCpbnNLk8ALXgN8L+sx3UdELgHLk/DqMGcfwD6Wmiimr63
	 /Qi+PTsAcmO1ndeAllYJlPRvz2AaiyaBaUC5VR/JCrMIJy/smuU+OytO9WbbabOSc
	 qdZjOGO6SQELwLtlnacqrTCw0GDLQAMRN2a6LEgnY5/1TBZfriTq2bQlUjwUjnkY8
	 B2TBfIdlU8J+Q3IrIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.72]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9LEU-1tXRhp2lDY-015KvO; Sun, 29
 Dec 2024 17:15:33 +0100
Message-ID: <231206da-e992-46d9-9998-5b2f1d3e8bb2@web.de>
Date: Sun, 29 Dec 2024 17:15:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pengyu Luo <mitltlatltl@gmail.com>, platform-driver-x86@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nikita Travkin <nikita@trvn.ru>
References: <20241227171353.404432-4-mitltlatltl@gmail.com>
Subject: Re: [PATCH 3/5] usb: typec: ucsi: add Huawei Matebook E Go (sc8280xp)
 ucsi driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241227171353.404432-4-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l6zmfyqEhSmiTu1FX/SaCtxQLAYyEO0OZchwogQX3ZhS8Z5HNi+
 Ij/Ti6CruIRcHef0IlgDewWJxQRgkDXzjVo9NaNDX7y4wx/O+BA7hB1fkzsA5QYru4GdTgK
 oHovdZy3UekwYAvyjxi03FJhAZ3UnC0g0/HYcqDxOAZG0zsHl9D3cXuCWBn+MhSPl64mMr4
 Narh2VtXzCa+bwDbHc4+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tRV+lQwU6w0=;6bUMAl4mOrcaVBR1H8V9433q369
 fJoqHZw2m2AwuhmE+IbClWkVk0anPc+xUT1oOQiCBGdqg1bnosA2qY+aKm1OKYe56V35hpytu
 qF0wyxwuYWGt8GHSmBFV406EuUwyhUbUk3vTTxLY5ITp/CC0xpWB1wGA7Uw4bd8rrSZRhnsVx
 Tu9ZQjr7jx+PN1boEJYIsapStUof38TH0NBPRKibL8hUsT/jeQT3sQfctK1G5kuxyvcU21Zqc
 Bm23OcOG3zdq5xpdJb5hqMbfBHfgCZvQhc5ES7HhAnKS2u+F2dNQPL+FilzFEh49ItA3oXb94
 axDTdHj3k/FTJjhPLyrdYKuBAN3gUnh4xnXXRW4vDZSqxfAOmUwUsoUtnkqw3DCI8MORocr7R
 vaZ0js04OuKOFTNYW8+XdS2MH42dQpvkL8f9cejw+q36W9Ke/eaRXCqJIn6mYPICmbakMLJjX
 R5lfRM9hBlzZe7QNZdTgxI7X0b0D22axxA/gV3TO22ltRa8saCFiJb4QYpkaDGguZyav9xaf1
 JygyI+svxjp+gOuorjfi9uJO8szMcL9DfDbimPXlp+8wp7JpQuEG4QsF4H+vIZHMeX1LUhnsr
 4W1tzN2jqLagwXsadMM9J+bYe7rZMpSpOrbp8rqCvUj3cj1tdVv4YNeGf76nukGocDrda7kb6
 ysra05FYyCHA1yASQxmflgbABPyym5FACo1VCiJrqTXogMypPowbbTh/knMc57xFU+zklTUh5
 YSn9eB3eZDoEsw2ph5597eT1/q3uzGSVAQ+J1ChEO5B/fl9aLGzf9TV2GP2siUBAEywxoykw8
 MJ21JUSkigORJC9gTyCgO1QgZ2PH9a4o8U++w10FkvwxoM7QL5GwniIKYvEM0NhD8I2y7gS1d
 NABQ2cJOhMFyfAxtlYCtBWjNM7DENuNPzWkbYU9HH3DgcYssllZs5euVLV1D5kHdP5B910HvR
 UH1uDGssXQY6lBBIwld4btoNhInG+RyQPummn8qTZL2QqpyCIwHIEvJnGgncF5nyQIhH5Snm1
 56b4++nC51yzfKind/zJ23kg4qQLHfmaxrrzvIdgpvxqRNfbkgZywvor+femEFr7TuPsNJfD1
 qPJLwkczg=

> The Huawei Matebook E Go (sc8280xp) tablet provides implements UCSI

                                                      Omit this verb here?


> interface in the onboard EC. =E2=80=A6


> +++ b/drivers/platform/arm64/huawei-gaokun-ec.c
> @@ -0,0 +1,598 @@
=E2=80=A6
> +static void gaokun_set_orientation(struct ucsi_connector *con,
> +				   struct gaokun_ucsi_port *port)
> +{
=E2=80=A6
> +	spin_lock_irqsave(&port->lock, flags);
> +	ccx =3D port->ccx;
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	typec_set_orientation(con->port, CCX_TO_ORI(ccx));
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock_irqsave)(&port->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.13-rc3/source/include/linux/spinlock.h=
#L572

Regards,
Markus

