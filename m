Return-Path: <linux-pm+bounces-42581-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFaeIX4ljmlrAAEAu9opvQ
	(envelope-from <linux-pm+bounces-42581-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 20:09:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA70313093C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 20:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 038C530078B1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0E7214813;
	Thu, 12 Feb 2026 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="c5oE22p7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E0289824
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923171; cv=none; b=OudsqkdKmY95Fh79V2HrCiRpK+LJ3tRxr5FqLD0i+DpngVdb+nTE1y5n5niBcYPbnVuecv62ThpXPoCnZuVQGjqpqmr3ILoBWwRHLh9GI4Ef8OlUmUJM1nyqRdN+++m0HOPQowYX6/3bQT6GLcv2KmBEK4zQLv+hXt+qEojsZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923171; c=relaxed/simple;
	bh=fRDnmRRUu0uBjEmOH7o39TfRWh2ebSV0A83JRHo4+lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWWJqvrkjOOYxmsV+28jcukncHpNhPN5NH+TPPxBli/kudujxsxfEfKT9CY6cTW57ttl2CUIc5KDGd9rRpm50VJMoMslQ1JCSvlRBdZiNL3IEtF0yWzRiCeeHutu5KGq0Sy7cNUnV/lqz2pvO0faku5uAE6fxqXLZs007+fsjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=c5oE22p7; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1770923168; x=1771527968; i=wahrenst@gmx.net;
	bh=HELERbfs/az4fHNRaoNWkJQLOU5+XYFGukZga0wOTcA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c5oE22p7ILxcnv2ENYB7Bhj2N09FUkGtVWa7rY89Q7OB222Fd5gv3ShPafJtHTk2
	 WW3FC+STXixcz18quC+9g5B/nc8/2H1SxF87lbA3v54Oc6ordJq/JM5rA4coP3SAp
	 6qTgva3rBHToQB6Vpf/Gvq2y2kKy3zkkN6M1+fNdVNp4Iq26ujeA9MrzKqCBTwjSp
	 jp+eG8Lb5kPN/dhOA5emA480l0twxAc76gh8o2wNUMsu/00Q83MZdB+/wuLryI85V
	 Bw6Sf6UFZcFpN/scd5Z38DimBb4/0ysLB/6BBXE0bg6wy7H+tpGX+jNTRPYOzQ5Zc
	 OVZntQGzBCJ9lfx26w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([91.41.209.202]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1w3FKn44Ha-007gKo; Thu, 12
 Feb 2026 20:06:08 +0100
Message-ID: <eeeaeb7e-55d1-47cb-ab36-1aaad396944e@gmx.net>
Date: Thu, 12 Feb 2026 20:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Fix broken reset status
 read
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
References: <20260212150039.67117-2-mcanal@igalia.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260212150039.67117-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R+ZH0FKQy9LzBT5qEgwX4469pkJUTo9fPMpzPXeXwbWrs6rTYM6
 CSiS8da9IQKVlNElKy9hyaOvL7H2Nh2AvOuVRyD7npDrTtUIpMLA5zWST0zEkiIXPh7ieFi
 Gbb1lni8nuzXj1rUtv2e/uXLkMssYSyXP4tPH9ZydWB5z3GU+B7ZE4jbi52BLVp7F5JQpI2
 vfXqvssthTBytod/LnHJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lDTjF3u9T6k=;PrbvH4MbN7y8QMJJqDtfx+53Met
 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
 Nc4xm/mKdAq/Ny9qAaVkl0He5bHuy
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42581-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmx.net];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA70313093C
X-Rspamd-Action: no action

Hi Ma=C3=ADra,

Am 12.02.26 um 15:49 schrieb Ma=C3=ADra Canal:
> bcm2835_reset_status() has a misplaced parenthesis on every PM_READ()
> call. Since PM_READ(reg) expands to readl(power->base + (reg)), the
> expression:
>
>      PM_READ(PM_GRAFX & PM_V3DRSTN)
>
> computes the bitwise AND of the register offset PM_GRAFX with the
> bitmask PM_V3DRSTN before using the result as a register offset, reading
> from the wrong MMIO address instead of the intended PM_GRAFX register.
> The same issue affects the PM_IMAGE cases.
>
> Fix by moving the closing parenthesis so PM_READ() receives only the
> register offset, and the bitmask is applied to the value returned by
> the read.
>
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domain=
s under a new binding.")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Nice catch
> ---
>
> Hi,
>
> Most likely this bug went unnoticed as there is no in-tree driver
> currently calling reset_control_status() on the BCM2835 reset
> controller. Although I'm sending a fix to the .status callback, another
> possibility would be removing the implementation of this callback
> considering that (1) it's broken and (2) it's not used.
>
> I'd appreciate your feedback about the most suitable option.
I'm fine with the patch.

Best regards
>
> Best regards,
> - Ma=C3=ADra
>
> ---
>
>   drivers/pmdomain/bcm/bcm2835-power.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm=
/bcm2835-power.c
> index 1d29addfe036..0450202bbee2 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -580,11 +580,11 @@ static int bcm2835_reset_status(struct reset_contr=
oller_dev *rcdev,
>  =20
>   	switch (id) {
>   	case BCM2835_RESET_V3D:
> -		return !PM_READ(PM_GRAFX & PM_V3DRSTN);
> +		return !(PM_READ(PM_GRAFX) & PM_V3DRSTN);
>   	case BCM2835_RESET_H264:
> -		return !PM_READ(PM_IMAGE & PM_H264RSTN);
> +		return !(PM_READ(PM_IMAGE) & PM_H264RSTN);
>   	case BCM2835_RESET_ISP:
> -		return !PM_READ(PM_IMAGE & PM_ISPRSTN);
> +		return !(PM_READ(PM_IMAGE) & PM_ISPRSTN);
>   	default:
>   		return -EINVAL;
>   	}


