Return-Path: <linux-pm+bounces-43745-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOvGFfR7qmkqSQEAu9opvQ
	(envelope-from <linux-pm+bounces-43745-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 08:02:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB321C400
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 08:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4460304C7EA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 07:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D09372B55;
	Fri,  6 Mar 2026 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCm3L4LM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1F37267E
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780514; cv=none; b=qMKZcdQJFB273yE5ty4MGyLLzcZf84YCE90A9J5yvo+9JU7K52tWDm+Y21MNVH19yYBCwCEBWb2IQ/Alyh2orvPCugrroZ5V4Zt514QRFXZnx87wLnKZ+2K7fsj7rGWr/Tjm7B+iZ3n1yeOmfVfvDEOSbJJHf39OwpvOG7Q1RVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780514; c=relaxed/simple;
	bh=U5ovtFZGT6J0/COcDYCmDClaijQmWD3Zbr+hgB175wI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mfxcszviyKtUMtN+wEPT1b7azAbxz1swbw4nUhv3lRlquDLNe7hFSeJDYuizDIlC1a+Bz0Hq8xSGTwsKBnDUvTKXhpGyL9FXyq/4XoLpDgcx16y6VrXOG/98QSR38dh7sALvAfFBujhEq1CYWxbdDyXgGfMD2eKvjnP52Qwax6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vCm3L4LM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439af00d33cso5667439f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 23:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772780511; x=1773385311; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/Izo1I7P2lYa0tqmXpdAdhxEzYAi9jVGmrjmB9VLPo=;
        b=vCm3L4LMiKmftf3eRWD9P1SVpACC++c85cqWIBuhJKFxk2R2zmxiR8x2RBCcchKeXF
         u4opsiONqqzqO1DnRd7toRGZ7MhKr6XHHQGjFlzAtGZw8mSFRD6hRMqkkidgpEU5fZQ+
         fX/KxhHH0kuHlk00afeFbBhOuLsqKXFihxqy2M1MA7cemHWI4aYqT+4mCXSG1Ervy60m
         Lh09GYHO+5TUMRV2uKzLwA9c1a/NT0aV6IkaLMbbzoqIx61XltFO3eFRBHayyf+CP/Kw
         G3ZdJoEdGp5kYsJbKLtktfB8+2xTkiN0hHT1yguewNMZk+i4qdaKAv5D9+l9ZVw12BF5
         sChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772780511; x=1773385311;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/Izo1I7P2lYa0tqmXpdAdhxEzYAi9jVGmrjmB9VLPo=;
        b=DBIH/N+CZ2pALa/E0dDKezzYK4lcIqGRgVtAhE1wmE80OtLxIuEUzhf8SDXrb97jHA
         FqWB6IRTQzk9WyBxwSbhKN77wSKrJrIUEiNP++flpEWfJ5ONcZc9/CBXCDxippejm0he
         Mn0CDKjpgWKtNG255QaLiS8j1ugRD1ToTG1kqxKEXGNbC6nLMVyCPvrzZBVXIF/Bkn6o
         auBq5SjCR/d8xr8N9G1HItJwNSll/bSVjdTMuhHncVf5qoQXr+qdS7sc3xauK0LDNMc+
         b7PVsckWcmJS366Ntm0PmylmjxdZ9p5e/v72ZV66b7rOGOtWtNn3/FP6EqE1gajo9iKs
         Be8g==
X-Forwarded-Encrypted: i=1; AJvYcCVvXR8euTvZaGBABlFWUdxRx9phM/PNOV5DI0oLgCNJ6wblUBdhXTxtwqCHduDUFBLJfC8lI/9lIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNQgL/pDY07858KBuk0XXMaPhit3UJnDH9nhqId+yZAsc1La6
	BumDh46EuYqjOOkxiWCF8Kn6dvquWQzTilplYY/RQUTtf/CWj+gtWDe+watj/peTZB8=
X-Gm-Gg: ATEYQzw/0BfEwF4IwJPtx6/AnwYj5/9GJ/1lNHLmgjzqfQqwnwx1cJSKdvTRvbZdVld
	gDJuwl50N59tcnxC/F6rFVNpngdOxg56MKbpwG3Zz/A9s94yhtGi8oip/gWbG9L8zw4SVavh2ak
	wD3ETuFqLhfAGXHLFcCO32gkUqw1VW83myef2ZRk1KCJll+yIIMRDw5ol/qAhPdhYoVSsr5SVsF
	IsI9Zad+e/iPRoZyoA6GoUJze7d/kFcd9R3mqLSaCphhpNF5pijFO9WJm/lfYlG6anlcoYI18Rr
	Q5tZ3+Kle02Ab5kNwSmtGN8/K8sQg8s4tZ+1aAEvouRClVl9u3/e3Pe5yxgnmwDVPXI+/xBET8W
	fb2FOtxqwo3Kv73UdhHzWPZ3FNWXhKoD9GbudIHR99ziEq/+Z6d2DzASlIOJ/tKLgs2QICfJFZT
	S4HM3Pz1N2YwuiqT6A7471PMw1IZsq
X-Received: by 2002:a05:6000:2c03:b0:439:bd70:610f with SMTP id ffacd0b85a97d-439da890077mr1657657f8f.44.1772780509950;
        Thu, 05 Mar 2026 23:01:49 -0800 (PST)
Received: from draszik.lan ([212.129.78.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba06sm1713784f8f.24.2026.03.05.23.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:01:49 -0800 (PST)
Message-ID: <198f569078f4a6e3b4e8ad080a94cd336c1e39bf.camel@linaro.org>
Subject: Re: [PATCH v3 07/13] mfd: sec: set DMA coherent mask
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, Lee Jones
 <lee@kernel.org>,  Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo
 Choi	 <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Jonathan Corbet	 <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Nam Tran	 <trannamatk@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Fri, 06 Mar 2026 07:03:10 +0000
In-Reply-To: <20260225-s2mu005-pmic-v3-7-b4afee947603@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
	 <20260225-s2mu005-pmic-v3-7-b4afee947603@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: F2AB321C400
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43745-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[disroot.org,kernel.org,samsung.com,bootlin.com,lwn.net,linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,disroot.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 00:45 +0530, Kaustabh Chakraborty wrote:
> Kernel logs are filled with "DMA mask not set" messages for every
> sub-device. The device does not use DMA for communication, so these
> messages are useless. Disable the coherent DMA mask for the PMIC device,
> which is also propagated to sub-devices.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> =C2=A0drivers/mfd/sec-i2c.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
> index d8609886fcc80..9fa1449a4f6eb 100644
> --- a/drivers/mfd/sec-i2c.c
> +++ b/drivers/mfd/sec-i2c.c
> @@ -177,6 +177,9 @@ static int sec_pmic_i2c_probe(struct i2c_client *clie=
nt)
> =C2=A0		return dev_err_probe(&client->dev, PTR_ERR(regmap_pmic),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "regmap init failed\n");
> =C2=A0
> +	client->dev.coherent_dma_mask =3D 0;
> +	client->dev.dma_mask =3D &client->dev.coherent_dma_mask;
> +

This should probably move into sec-common.c as it should apply to all
transports.

Cheers,
A.


