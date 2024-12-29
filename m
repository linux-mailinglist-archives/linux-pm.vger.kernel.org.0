Return-Path: <linux-pm+bounces-19824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D269D9FDF53
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 15:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84170161972
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4C916F0CF;
	Sun, 29 Dec 2024 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FFoiTSNd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4532594A6;
	Sun, 29 Dec 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483774; cv=none; b=hWIYIE48qrKKwSwlG1bbsUh3vrvDYEQXVn7PgbdauIiFIiMsOpxxX1qG9rgd0FStAzxqjuLT0pSJesjgZQUbEcO2wKrt8QS8TqAX6k+dM8F+8hye+9FHIomQfPG/Fd9RpAxGofTdOxj3uhSfHc5NihsqSfoA6pNPp1R56KrxS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483774; c=relaxed/simple;
	bh=k0ZngxZKM6fOJCwatdrmbqUfNxevJYyyucnNVKDe7Pw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rRrFWsrM5AyuzcNOKg9jQqYiITo0HgV1v24ZMLbFeVj63vNH34SO62TfttVCNwZv9qMiC93S5W+53pYOs+dSGz8v+C4Mw+heZi+JO+7JB5QmwECJiefUeISLQOC4kf9+6LlbjoQco0g7qMIj2CfJyh6e/o8UpdRn8Zn21If1GEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FFoiTSNd; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735483745; x=1736088545; i=markus.elfring@web.de;
	bh=HqBR+j1S1SOZ52pSXNFEjgGp09gt0sT/jE/UV/DQVko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FFoiTSNdWpGKXjZUZlvbbDc5VCHZJzyjXaLhnd5DZue6Xqq+s5c1JueQc+/qClD5
	 CAZV83FvB28dN9ZkE2eLIZKZ/j2XAvPIepLGuuafep9Ot8iCiDvkamuuBS6cPednW
	 RcosBKI+mpml7t5AyzvrEZhVcp/CSe+sEgvmcNqN0WlpaSHpa/S23mQa3Oukw2ZXg
	 r36Q/09riex6RgAYbCsJl8BletqqmJfcxdS0ISZMndrqfff8XoEJS7UGBglHSJTLg
	 m32qk1psWRsisZcnDG25YRB+GdrVwFwswAHm16NhTW/LUu90rRPxpdK3rxo+J5GGi
	 d+gRg8X15z7ZE3Sy0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.72]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpiO-1tj3ux2yb8-00zGNQ; Sun, 29
 Dec 2024 15:49:05 +0100
Message-ID: <b55886e2-9a21-4903-b344-2dccb359bcbc@web.de>
Date: Sun, 29 Dec 2024 15:49:01 +0100
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
References: <20241227171353.404432-3-mitltlatltl@gmail.com>
Subject: Re: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp)
 EC driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241227171353.404432-3-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u/t21Gl+b0kv/L7T/6C0mdnE5HLDCB9ud5PsPoMIUZ0+nydSYBG
 JcV6qZcMFuRRCxXWuL2HU8ddK8udFsp+Ogn/QkHNdDUowH9DrwNV8OvBnTE1aXg3gSw7oI8
 IPKug7WB9ZjKA0ZfGo4KT4+SdylJ3YzAQlzwngFGSQPPkfI1Ix46BF/pl33eE6ttFiH41cJ
 O6LgUlo3552a90hJ1wC7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ShYNGWyMq0o=;bntqRl1t/Vl3qe/+W68wkBbphT9
 AvhOZqMYRAzx34o7xq7HFv2EO5ceHj0wWTcQrNFCphG0LA7XfbF0Bmn6aSroyh+gYPXKfbh41
 XTWwIo1Tpybc5rqV70WOZ+mpQ5ZRiO4cdQXd5vzOXem+H9gxRH8r+4udJtjD7qDjFcOkie3CS
 HdZaBnWnqwt9NlhzPDlet+ht+1TfzvZcAiuR60n61y53JyfiiloQCmlhs+e2+Lb4MPK0XInzV
 pyOByK3GL/KDjWHzRF3hMWuX/T905gnywOwZTjZi7Sj098uv1vGuaRmN+2Mf4OIZqsLDgGHBK
 avj82mWPJPOBA/KNgxd0A663Gd6b/c5t9HqHELQB/YrR5npkB9hC+EueQNpmouzgY+INieQE7
 GgqV4YQLcMpW0P+ZkuxtBWX2LwRPQvRJrXucz/NBfnCAURSKglR4UMZkd4SAFy5tVD4nxhFfJ
 4lCJUwhyK2IB1GvccXXxdXalmr3Ko6dfhGtgexvG85XRFABL7kmpTEFgEU+LcpWJQNN4+8eGA
 4CZNXitO3HhwEyhReh/WPJeJKd/aVjhdapPCHaxGozigZBOlM6tcU2PoeNbTFNypiFNgn02W5
 c4UWTI2RKRqAQpF6Re0lY0lAKyRGatR8wGdOK7BcVDH6aaecj3xrgDyFZ1FrKd28DvHVEAwng
 aGsDoGd8ngemjCFIDnHIKfSowhAWlQObfDWGXEQxaai2G+ahlWu+AarRU4RcPA+OzxM9hxWxm
 GHWHPZGF9dU7HgkfF6SOPuFxhWC+Ld7/qD548vC65EuygUwHQuqs5jMLJZ9G7WDgmOQ2fj2VI
 tpnCEJOIJgh9iGJwRTl0h/gI4Zht2LUqRyKVRVZm2HaNnIB41w8paS8PouSJzLAbDKs1oSxaR
 Xv9JTtO5luW/yI2EKGQz4kkgFGDIqmcyvf4TASjMcCX/xuM0lhrRLDrnwb5IrxlGm64aOTTo7
 gyh4mDydkJLVVGEgt1SWEVJioOpPgY6M4c5cyqiFor2A/tuZwV8S1HCpVMfi/5yWjYUdKvdHS
 36sLP8+uJbAGkkHr9ZRHH9RTvWjFkfN0oEIYNdZEMicggeBkIXmz7BLRK0nFxjxlF0YVzbT11
 a9nJ2KCEQ=

=E2=80=A6
> +++ b/drivers/platform/arm64/huawei-gaokun-ec.c
> @@ -0,0 +1,598 @@
=E2=80=A6
> +static int gaokun_ec_request(struct gaokun_ec *ec, const u8 *req,
> +			     size_t resp_len, u8 *resp)
> +{
=E2=80=A6
> +	mutex_lock(&ec->lock);
> +
> +	i2c_transfer(client->adapter, msgs, 2);
> +	usleep_range(2000, 2500);
> +
> +	mutex_unlock(&ec->lock);
> +
> +	return *resp;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&ec->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.13-rc3/source/include/linux/mutex.h#L2=
01

Regards,
Markus

