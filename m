Return-Path: <linux-pm+bounces-20052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625EDA0473F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 17:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19447A15EE
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DA1198E75;
	Tue,  7 Jan 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA9am919"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0D18B47D;
	Tue,  7 Jan 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268911; cv=none; b=AYqrWbknV4JWF727QrOmH9J7a4kaXpNxetJLPKhyTEmC1k+0zPgTPIwX3ms5uUD4Xx+lfp8KnIKedzifH7+dMyvN65RPzN368SKszMos8zLOoOd3bacXwOkQ2vM6wKWl9d174xmEIGHDOS9wCTr5z5NxmDhGq439lfXDW8A9+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268911; c=relaxed/simple;
	bh=DXrIQMQkgHSv+0fLXdyceFm3g8JVUnp0G5t3pqb49Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRS98sPtF7+geBosPuUNYBOtaUMUm+MoIZn+WdVPUIUpYrT2kPC3t2oD0a1yIXq6hmgHdFWXbBZMim6HVC3QaYQYkRAUQRpMMXgiT7qRQhonUnHQnycejTgtcHesdvHmEfZzxYbw3W5sjIwmsomD9q5cwSpeQzLeCU0sRsCkBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA9am919; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216395e151bso169069175ad.0;
        Tue, 07 Jan 2025 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736268907; x=1736873707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfSOyFtuyebrltRrlhkHEzWaX2hoPdohMq3C5Xp0dVo=;
        b=gA9am919otTL6UYKpXCVqLVlFF5LCC8kPoDYHwu/c24R86vrJWFQddB47euFqo85SV
         QW+9q3MaPALdQ+qjZYwm3TmmADhFMry2Phy7l04GcEYj6e/JPGwM48mvDy8GN39sORns
         oEpVg6st5hM7PecCxSswXpHkRfo+h2gOx3JOUHV+tkp6OZy3Wl1v768CX22fWdgN5Du3
         ClUIxWplgsozinWfiOSJRrrKXOZ7FGRPn1LAlVHSFgxQwwdSfafV2KbVnJZO5C0fmbna
         UqwmLjhdqjbFzBMKsqk1QeNxYXxzRDKCQHl9U7J+ZEZ/yFCcCfcN9GP4nPLrAdBS5ro2
         flvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268907; x=1736873707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfSOyFtuyebrltRrlhkHEzWaX2hoPdohMq3C5Xp0dVo=;
        b=CbJrOXcMmyMYLFcEC9qa1GJEY3X/ZodlnvR6iLUxvb+OKxKmNcgSu7M/WHsQAxKP/3
         ezik/7MCEgSGVZN75Z2QWco8JlRqhXwQmEQbeki2Pc1mKSDoWfv/C8+8Aiu49yfZoZTc
         jnJv5PVOAaAZ4Nvl2P1VPeA+5rNf8fOxfxn+E4KJrfdf3qNscZh9WNa6QQrTk+bUlIs7
         gma4lgWs0tNXbF1W2dfNXIyVpfoTafQ6IU5F4luKxZFxF7vVgATqFc1d8G7vJZ/+4I3p
         DjlPif3kqFTQFPvMzCIQPR9PJpiNeUbNlCW0H8Unc26oAE4DgD1jRF/x+XGjJcuXQXtw
         sy9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhjjD3/TUb5bNdj8gIIOITSyFBC6abkk8CXpR9gWEjMTxS2DdP56EvtzKxAIJ9eC507kcIu1pXBW18@vger.kernel.org, AJvYcCUkt0KAOKZDLbKUQWBSoUFExwu+eWnaOLyCqXl6p/U32D535CvTnPnSiqu75KX///DLC3OYLp3VyerFr+JNTRoehMjWTQ==@vger.kernel.org, AJvYcCVWYDzsNATkDGi99juWKzip5yxt8mCAc827iIrSK+YlEIAnCNQdonlgEv5AMvk58dOSMrr2iXAlNXSDg92tVQ==@vger.kernel.org, AJvYcCWKkWKyom2ojjuNpGrnkE7pkbOF4oLF6BguJVEPgpSTAD8sHQ+iG1k9Gv4P/xKxCuHFCE4A6p34PyBAk+E=@vger.kernel.org, AJvYcCWf3jgfv/tY0dqfWR26KjCvlO9ABEiu40GiX5WPn/1wDyONH5Q8/FOd1yOS6HFnfMueTFS2eTYnbjk=@vger.kernel.org, AJvYcCWyMOWGqTt+sqvCiro2VyhDrspLN3vjRg3RelsnxOtH7sO9Ek+DEf4N5BkrNs9kxXvMFpG+7yVLa6HQV9Js@vger.kernel.org, AJvYcCXGAHfNlmvlTlRgniaKTiwYqcV92SqeW4vFRbg8sBGBs++AKdUqwDjZOB7mz+4S+1ld+qIUCMxbh2mc@vger.kernel.org
X-Gm-Message-State: AOJu0YwJP3jHE2B6QD/KbrMUlIC3NlRLTgD1sIkFE9pdJROufYQAPZ5R
	Ptm0K8hHeQ4PWi68aDi8SLkn9vwxNDX2N1DjzapQyC2uLDGmv+vV
X-Gm-Gg: ASbGnctr7XhquulaQ2XBmy4jXlrgzD99n0tGAMKJr72D95iWy7m3zBpYdwa7sJLEtf9
	crsTYVmQob3NBH25qI1euRwdNyGypLyJ3oac4EPgu06nHI2PujsZSPoceIB8sfvFeZMTYiaHfYa
	UBnGkwzkeiAPTjDwDo0PqSIqmcZaKbcSz9iYOdKocfLrcQmQEEqRqf9pjJkgwOjemqTi2FvE65B
	9S92FR94sRZG7/PCMFb+dswFJFdsYHAan9qoFpCJAEtZWGi5+hFpX4=
X-Google-Smtp-Source: AGHT+IFQf/aoQlxwYLfyxmbzyaa9BZYMe4Fh/X3mXsfcJvMkVvWHVRFPHWBxNOWgVziFcNJLIeXBog==
X-Received: by 2002:a17:903:1d2:b0:215:8847:4377 with SMTP id d9443c01a7336-21a7a2957dfmr62251775ad.15.1736268907329;
        Tue, 07 Jan 2025 08:55:07 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c8fsm313519145ad.60.2025.01.07.08.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:55:06 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: heikki.krogerus@linux.intel.com
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@roeck-us.net,
	mitltlatltl@gmail.com,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH v2 2/5] platform: arm64: add Huawei Matebook E Go EC driver
Date: Wed,  8 Jan 2025 00:53:33 +0800
Message-ID: <20250107165335.114744-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Z30dIRA4MdtCp63q@kuha.fi.intel.com>
References: <Z30dIRA4MdtCp63q@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jan 7, 2025 at 8:25 PM Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> > +/* -------------------------------------------------------------------------- */
> > +/* API For UCSI */
> > +
> > +int gaokun_ec_ucsi_read(struct gaokun_ec *ec,
> > +                     u8 resp[GAOKUN_UCSI_READ_SIZE])
> > +{
> > +     u8 req[] = MKREQ(0x03, 0xD5, 0);
> > +     u8 _resp[] = MKRESP(GAOKUN_UCSI_READ_SIZE);
> > +     int ret;
> > +
> > +     ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     extr_resp(resp, _resp, GAOKUN_UCSI_READ_SIZE);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_read);
> > +
> > +int gaokun_ec_ucsi_write(struct gaokun_ec *ec,
> > +                      const u8 req[GAOKUN_UCSI_WRITE_SIZE])
> > +{
> > +     u8 _req[] = MKREQ(0x03, 0xD4, GAOKUN_UCSI_WRITE_SIZE);
> > +
> > +
> > +     refill_req(_req, req, GAOKUN_UCSI_WRITE_SIZE);
> > +
> > +     return gaokun_ec_write(ec, _req);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_write);
> > +
> > +int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec, u8 *ureg)
> > +{
> > +     u8 req[] = MKREQ(0x03, 0xD3, 0);
> > +     u8 _resp[] = MKRESP(UCSI_REG_SIZE);
> > +     int ret;
> > +
> > +     ret = gaokun_ec_read(ec, req, sizeof(_resp), _resp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     extr_resp(ureg, _resp, UCSI_REG_SIZE);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_get_reg);
>
> Why not just take struct gaokun_ucsi_reg as parameter? I did not see
> this (or any of these) being used anywhere else except in your UCSI
> glue driver. So the prototype would be:
>
> 	int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec,
> 				struct gaokun_ucsi_reg *reg);
>

Understood

> > +int gaokun_ec_ucsi_pan_ack(struct gaokun_ec *ec, int port_id)
> > +{
> > +     u8 req[] = MKREQ(0x03, 0xD2, 1);
> > +     u8 data = 1 << port_id;
> > +
> > +     if (port_id == GAOKUN_UCSI_NO_PORT_UPDATE)
> > +             data = 0;
> > +
> > +     refill_req(req, &data, 1);
> > +
> > +     return gaokun_ec_write(ec, req);
> > +}
> > +EXPORT_SYMBOL_GPL(gaokun_ec_ucsi_pan_ack);
>
> I think you should add proper kernel doc comments to these exported
> functions.
>

Oh, I forgot some of them. gaokun_ec_ucsi_get_reg and
gaokun_ec_ucsi_pan_ack deserve kernel doc comments. Judging from the name,
others are obvious, should I comment all?

> thanks,
>
> --
> heikki

Best wishes,
Pengyu

