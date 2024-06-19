Return-Path: <linux-pm+bounces-9541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D790E324
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 08:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156B31F225A4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E956BB58;
	Wed, 19 Jun 2024 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNqK85Wb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F74A1D;
	Wed, 19 Jun 2024 06:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777653; cv=none; b=LqBXGQzTRgggbdn3D2nzdKc24p5kcP9J+hpBpXJUtzMZqrUbTF4sh5lgr5JyOoWDSMqUflWXwM86aIqWgMRhFxk4WYg/oWlkTNzgqZJsvDuj800eIAiiH9YJvt93TJB1tVOW5UQlIlB9qUrdge1BeS8VYlfkARPHUETcDAUsX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777653; c=relaxed/simple;
	bh=xvj6DblVXIhvHqhIgVQ38lAueoVuFR6OL/vl+QTmWaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx5fGXFp28Hp7QQH7aBX1SqepA//4wRwhhaV2lW4j/iqPTUxmUQxohwcGBuQt9PsuxaLvX2z6ercNlAyPavG89CIWnM30gBgwVoHWAe4DbhT2TMCdDctSES07Xad1LpNQ/DAf555nO0cbciG2HEZLvVl3G1FSlbs44OuIwkJ8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNqK85Wb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52bc335e49aso6907390e87.3;
        Tue, 18 Jun 2024 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718777650; x=1719382450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzmSViGchLceE7ZVFGAcuIV9ClbAk4S7GC1JzzuAB8s=;
        b=aNqK85WbdFXNisyxvobVPxYvYRyJL4QKhTwXP+ZXLS2JhFArTkdV2wZxU+zV11LkjB
         PhQtnNkg+b28sJq4i3soj6zIQTZKmoQNSVYCD42fzhK8CNzX40Hy2OtRC4BQQGOSi8Me
         4lALphbjMNGRLCHdIypC+uqfOuci9W623O/tm8fr9Fk3eK/7svZDwDeWQ1HqjRBboAxF
         OWY+YDV2nE0zREjNruq7lvucSgU12VWojU7ve4hUvwP58QLi08hbrl9ZDcJsQZ81idWX
         dGJP4fq1Yx8e2Eole0cD7e5/gXHBR8a3nc4Rhmtfzlvy7++VzhZJJDX3DMVU4xlUSdz/
         UpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718777650; x=1719382450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzmSViGchLceE7ZVFGAcuIV9ClbAk4S7GC1JzzuAB8s=;
        b=AlXFvNLcathm7CMF85Cy26nhBF9SkSVHz4cpsrxIe/iSgvlB5h7e5dPXIEXONIXQkN
         RFcYtQDGw/rK+6SEWFioi+JGCbUnpI/S6sM3RMxlRpXaquGskKfNk7y9LFQ3c1/qD3iN
         /2oBw+fYtf2qM2poLs3fz0DDZ+IN5BRw5dK8t1r+GxjtjCnSmv9HMkbqSieFF5ulH4t4
         kuHz/hMSmMsV5OV42DRnk1wtnxKf+dpOwivIhHlFSwU+uInXuJKIYcZN10PiV7lcQ2tx
         SG00QAo7uJ1I/CjNTeU2cHvGceDIStkvWh99UdPDrNFtdyI58J8dahzlH+D2tzG/oGAM
         7HHA==
X-Forwarded-Encrypted: i=1; AJvYcCX6xICzP2rrE3ZPYAc5YzNArPBnfFAMmDOFp6N6WF3KbDP46Yj9O2KxHM1YWLHSsddOlnXkhga2V/tc1/HZG+aA2JGAsS6C29BXzjYISnzhPOwq0oBtwMFYXCrORTp5N3jFgcuF9cyd1fsBagjW+OmoRgVg/d736FnWj/J8iOFQ/NT9
X-Gm-Message-State: AOJu0YzaW0+BaKlKK45mf+szxG2AHXyvSHZUucwNFpsfeiWUhCeLA55j
	+VIYplPvExz/XFVd2ii0ONI754GiLqZSX/svmjPtNTw/fIN8ovA5
X-Google-Smtp-Source: AGHT+IGg6DQJIzO7sfrKDh1lIktrtgxmEg2uujJDnLN3SUBWBfzQsv9XXF/KfNs1cnWVnwHz1hV8cQ==
X-Received: by 2002:ac2:58cf:0:b0:52c:88b8:12ab with SMTP id 2adb3069b0e04-52ccaa5e2b6mr870434e87.23.1718777650022;
        Tue, 18 Jun 2024 23:14:10 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de63asm254980325e9.30.2024.06.18.23.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:14:09 -0700 (PDT)
Date: Wed, 19 Jun 2024 08:14:07 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v4 2/2] power: supply: add support for MAX1720x
 standalone fuel gauge
Message-ID: <20240619061407.GA51605@debian>
References: <20240617184504.304211-1-dima.fedrau@gmail.com>
 <20240617184504.304211-3-dima.fedrau@gmail.com>
 <dzrsh5dsraz62sc3mfhlmf5yolkzjet2agv2ochg3xg4ryfofs@bnmxbtsavv4o>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dzrsh5dsraz62sc3mfhlmf5yolkzjet2agv2ochg3xg4ryfofs@bnmxbtsavv4o>

Am Wed, Jun 19, 2024 at 01:19:32AM +0200 schrieb Sebastian Reichel:
> Hi,
>
> On Mon, Jun 17, 2024 at 08:45:04PM GMT, Dimitri Fedrau wrote:
> > The MAX17201 monitors a single cell pack. The MAX17205 monitors and
> > balances a 2S or 3S pack or monitors a multiple-series cell pack. Both
> > devices use a I2C interface.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> 
> [...]
> 
> > +static int max1720x_read_word_data_nvmem(struct i2c_client *ancillary, u8 addr)
> > +{
> > +	u8 rx[2];
> > +	struct i2c_msg msgs[] = {
> > +		{
> > +			.addr = ancillary->addr,
> > +			.flags = 0,
> > +			.len = 1,
> > +			.buf = &addr,
> > +		},
> > +		{
> > +			.addr = ancillary->addr,
> > +			.flags = I2C_M_RD,
> > +			.len = 2,
> > +			.buf = &rx[0],
> > +		},
> > +	};
> > +	int ret;
> > +
> > +	ret = i2c_transfer(ancillary->adapter, msgs, ARRAY_SIZE(msgs));
> > +	if (ret != ARRAY_SIZE(msgs))
> > +		return ret < 0 ? ret : -EIO;
> > +
> > +	return get_unaligned_le16(&rx[0]);
> > +}
> 
> Have you tried using i2c_smbus_read_word_data(ancillary, addr)
> instead of the above?
>
Yes, I did and it worked. Used it in V3 and changed it due to review
comments by Thomas which make sense to me. I don't have any preference on
this. Should I change it back ?
> [...]
> 
[...]

Dimitri

