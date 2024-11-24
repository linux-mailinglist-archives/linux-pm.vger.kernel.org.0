Return-Path: <linux-pm+bounces-18002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917A59D76E5
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570B4283645
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D716977F11;
	Sun, 24 Nov 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bL0HEzWW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CE41746;
	Sun, 24 Nov 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470716; cv=none; b=N32qqQRkILsfbWSSvnjMaMpjMpnbF0GU+urUhBix6BET5d/iTlvoqvJ8KllHO9Ar8itZvfATflUrvn5etiSiuS9lMNdP+r83ZBTvQ4jS7TxG+XOrpAQJUj0k+EPWetOt0u0bIsYie1lIphz5ZjfV3YE8IwAAseg0/DvoPGxxiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470716; c=relaxed/simple;
	bh=aFiMuy9mcRHMPQ053hGyjtKqIn+7hqWhqOvEFy3aZJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/mNMDEegcasQEQWKQoJ9sPOyTbV6rSgg1LfFvzcTcLe54Tx62SrPX16Cx+Xm22WewuUOPcGT6Oc4jnPSdS4tMv+APyCjET3Zym20VMBmWHjvXFxOirgohQMIatJFd+2b8psWl7qJ24mjJEtq5fuOMSirojYM2qk76hyHjjReJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bL0HEzWW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732470703; x=1733075503; i=w_armin@gmx.de;
	bh=fwL0qNtLB7MUk+18v3c9cA+7lZR+Usz2hqAs8ycRtzQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bL0HEzWWPBbU3JKDpMGcidAV/EQ71pLzWlsg3l9DMzO5qFX4W/VNZfFWTGOQEpIu
	 RzKby6BlRNTVrCAzTxUeUXiNo9zvqJBTc3kOnS59V94i2ekhN7oYd3AiGxy2Jgz4E
	 ExOCDfeGJE/r5O+1pe8S+2wy/pLuQwAZbTSnM1RVcshPLJXo4+QgC5pzGqOs0wIUI
	 gpWmfdr8WjIGlNsC81U+KLk6urvajlc9GcRsrps3/W9GvP6wruaifiVu3JHnyuMA/
	 koLy/cCGCL+k8R/LzMugkCcrGGmxtMyyMeSxVrT20cFQPaiXy+xfNfTbQAjP7MLPo
	 z6Bf9UhW9g+H5NvIYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAONX-1tPPlt2b2h-001JRA; Sun, 24
 Nov 2024 18:51:42 +0100
Message-ID: <0d56a09d-59a4-4574-9fb7-635f627f5657@gmx.de>
Date: Sun, 24 Nov 2024 18:51:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] power: supply: core: introduce
 power_supply_has_property()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-3-7240144daa8e@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241111-power-supply-extensions-v4-3-7240144daa8e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zfgWTVipdSrxgoPcOqE5dYf7tRVuHMhf22WtP4IDbcisbRsAJ6B
 TgCr8MwwkRbPIp4OJQVXGQ/NEzIK3RyNJLwk4x4nlSTb1Cntu+x+okhFYeS8yKW0LpZxM4r
 E/U6rvrZgaxd/MivMUAVvpMZfnYLTDDgtMAa1VAigNd/m/z52NAG6H/QnBatrA2TSTOysSy
 vLq4Xl9oQawc2Js43haaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rGzjzrvNnx0=;fAsho1mxkfy4ParjdwNU4aL/kS2
 PB/oHWUwTQaamNJUiNint8qlcOMC0WHzVn6/6AroFGUZWdhtgNHQ5DRftiPQP8NDAB9FHOsbQ
 or5Wedy3FnCz8QUE/fcQFi/4tcna+VDQjQooM075yI/fXUsMKizI42oBHDKYBHhNWjiunPuVe
 BlCvmtkbrTCvyP9Zh8KU5o1zl2L8DNbt6MBJ3s7CBpqn1sDpqQ9k7xBX8ScmguJX1y3ETAGNO
 FUKfhdNmPDxAa1Hl9fxMN0LylIhtoc9/T5E5S9OzKF8aTr0YLYY023w9mCuA/Uy9jCKN+bWas
 EihFlXeJvOGvt9d+QcbjdMvNuBXsllbhYq5k0k5KNK04lo9BeqqXUvKjqx1IgW+CiUxztA1ND
 JUHlMPc2PD6vxMsAplJBAyqanr5FQmcuQyIpLWIYNMfrmhV0d6/iyndq1v9NiADU6LtHeoTo1
 9cXmyy7LNEtjck77h3ksbiJRdiGWGuhKlUetXDJD2UZ6kNDdg7gjH0jECvlSQp6IK6m2FfKQx
 rwg/NpPBdyc3ZDF8RiMphlzigWAOoTDL0odY21CXjITb7SAlVS1kn5VhDho3BYSgaB5dR400D
 /fr7DvWkITXVYvaFYg2kQF3KIUjvSBvyJfM3jFFDPU+XjY2CY+hQGKsYCo/pzSKo0pYPglVjp
 /vRqJVdgvbMosdoDu1Xhl1WOHMiHfiVegjiMQ7TrLQYVhMZ1gwcRVA8/Ysffsg/KqOyXo9Tr8
 1Tar6Osyb/KgMMJLGH4YXe1HNKEwX/tk8u4OwqVnExUmplbNG7CNaLz6XfV/4xJoL5axwJV5u
 uER/vag8gVJNg2AcIwu1LFbxch8fqncPooHT2RyvlqTNauD1DEar+fSnaPCIqyLgIJAUF4OoM
 7wxZB1VDO7AlSNCJPReOpLaOy9GDBOIuMc44MKmQy1j0JWWimEaasH1GX6PJyn9rLMueovPj4
 7zYTBwklvAkpCSvUDI/zRGcR1x1RT76CC5X+VExs+EEgSn0wxtgvHYZE1NgqIYXgyY0CG6JxY
 Pvx1JQfrIsSkQH1xD8iRNRRy+EBlSFE5xnw3I31GwyV4Wpex14QMlkHmfZb2TBsGECZ4X+fgm
 z/555pnX4k6Fp6KOpK58jCPsptN0um

Am 11.11.24 um 22:40 schrieb Thomas Wei=C3=9Fschuh:

> Introduce a helper to check if a power supply implements a certain
> property. It will be used by the sysfs and hwmon code to remove similar
> open-coded checks.
> It also paves the way for the extension API to hook into.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/power/supply/power_supply.h      |  2 ++
>   drivers/power/supply/power_supply_core.c | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/=
power_supply.h
> index 7434a6f2477504ee6c0a3c7420e1444387b41180..5dabbd895538003096b62d03=
fdd0201b82b090e6 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -15,6 +15,8 @@ struct power_supply;
>
>   extern int power_supply_property_is_writeable(struct power_supply *psy=
,
>   					      enum power_supply_property psp);
> +extern bool power_supply_has_property(struct power_supply *psy,
> +				      enum power_supply_property psp);
>
>   #ifdef CONFIG_SYSFS
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/su=
pply/power_supply_core.c
> index 2f61f6b90b99f40ee04a6d63ebc20036f0447102..502b07468b93dfb7f5a6c209=
2588d931a7d015f2 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1196,6 +1196,18 @@ static bool psy_desc_has_property(const struct po=
wer_supply_desc *psy_desc,
>   	return found;
>   }
>
> +bool power_supply_has_property(struct power_supply *psy,
> +			       enum power_supply_property psp)
> +{
> +	if (psy_desc_has_property(psy->desc, psp))
> +		return true;
> +
> +	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> +		return true;
> +
> +	return false;
> +}
> +
>   int power_supply_get_property(struct power_supply *psy,
>   			    enum power_supply_property psp,
>   			    union power_supply_propval *val)
>

