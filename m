Return-Path: <linux-pm+bounces-9610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68D90F3B9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 18:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D4D1C217EC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7565612EB;
	Wed, 19 Jun 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8K47a0F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDDA29;
	Wed, 19 Jun 2024 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813395; cv=none; b=ivkBUBi2tmlxiYVDtS/p6zjhJd9KMuuoxTiJ3iFbY7lu4FItwr0shCXhB5cqTxSwW7j9BdH41rpPrHP4jdrthn7yZTswrPbwZd32pgD6yeLLULg7axo2PIN4XMUuyyFRkfVScTReiBWHR3Afa+PHDj1KrAKe3U5qLAy6MLgkYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813395; c=relaxed/simple;
	bh=jiAjSxEoHMD3b475hAvr1/rsStb5mKPmUQy8MQWE9Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKxjhDVVh8m4iRKtBaEoDVzJqySOLX8pEE0SA1dLrP4aYYdp1faolaWoLYt2mHxY1GE/035fHpBPFEc7j5hw+2RILjSWUQWbOnv5VMIyd3PMKLiEzuq90dpzBG/8LmNCWFBWddIAgrg1c/fYbCR3wGoFBtoF/BtXbe/h8mGfktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8K47a0F; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a62ef52e837so878557966b.3;
        Wed, 19 Jun 2024 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718813392; x=1719418192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4GefIAh3qFrs4XiLEl++OqZDXLVqbHTFYPgxJpnh8Q=;
        b=M8K47a0FKJ/siOKAllLlzHs51ybec3hdx9rdmQiWCFeJ12Pwmm829pFFRKUmSCroP5
         icEIeesNawdV3clAlq/x7GBkgrTvX2BrPFrt7RGELzqzPiEH/tYimt+T/HkkTrQq7I9T
         9hnQ5lv8FRV6z6rxaXIyJSnGznutXKCKEd8yd35xjphzATDZW+MIbzqGNfR5zM1vMCo9
         J7Wx5HBLklKLriGgwXgjEPQUD4rgjTppqa/WcBWfZ3pXYJoNPVQ6znBImz1lxewqFR3+
         l9jgYMzFxZwdSlztqaFVGAbIc4PRbPy+M6IwF/A9YGjlWIhS/D24SrsVX7N48Yi5hGHb
         Pevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718813392; x=1719418192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4GefIAh3qFrs4XiLEl++OqZDXLVqbHTFYPgxJpnh8Q=;
        b=Ethc2YNB1Ev1iZwM+sJL2zdHUmuh+kiIyQGOxdevKSlPVFTF085wuM1cLWWo4vkGDA
         7fHwNRyk8baqlhroKl9YfEHgzz+xp3+Pm5DTK7rqB07aYn0j48qVp4WVbezVd7NxNu17
         iVE/e0//tzYYr9R4pFBcN1NOiMGDETeHA5YYOY8JoNACOqGRkDw66op7fbzY9AAhQoxb
         BJjEkqYAZHMpcKzJE/cKadYuxsBQhyUTOLjEk0WhXe+JG0U4ynQIQAR2Kv8I+G3TPcXj
         jIwTYZbHqYYN01Hwd840qnRiLeUrFkwO9Wf8Fp/QqnzSHa/vpMva3/mku0lFmWmBu4yY
         Jr8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0GNroA/YFVdCwmme3KLJwQ4c5Pid+s+T1tCGiabOcpOPYcv436x1jyTysYZJDi4DN9CR0by21iz8I88sX+RyKeMnqWvNMsB9/LhCleXALV9DkYAGV3zg3VwdAU0mJji7rJPIQC0c7OFqfk2Vh8pMk6yK/gDmNcJ885tTWQUlLBeqE
X-Gm-Message-State: AOJu0YwFsDBK+uj6fGDDm8x9wORmhbnaFXn9KynIu+A+f2DqZzkTiFx/
	g/TFioptb769Z81mtC2DrPozQzhv2+Zb7AZMfWKFDlBXmBjGuec7
X-Google-Smtp-Source: AGHT+IH4L8TiEcLgrkFzICsJXAyH3qfqCpGbex8LFyPLKfFDPJ3OsJ/BIwdKYBqEP9kGtYfX4OfFNA==
X-Received: by 2002:a17:907:d383:b0:a6e:fad9:6dbb with SMTP id a640c23a62f3a-a6fab058a39mr255639866b.0.1718813391947;
        Wed, 19 Jun 2024 09:09:51 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da4496sm672316466b.8.2024.06.19.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:09:51 -0700 (PDT)
Date: Wed, 19 Jun 2024 18:09:48 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v4 2/2] power: supply: add support for MAX1720x
 standalone fuel gauge
Message-ID: <20240619160948.GA4190@debian>
References: <20240617184504.304211-1-dima.fedrau@gmail.com>
 <20240617184504.304211-3-dima.fedrau@gmail.com>
 <dzrsh5dsraz62sc3mfhlmf5yolkzjet2agv2ochg3xg4ryfofs@bnmxbtsavv4o>
 <20240619061407.GA51605@debian>
 <nar5atcllxoulmzm247uhe5zwyn2tpyt65mdrlxshejx5wcjlh@55re3bsshcqe>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nar5atcllxoulmzm247uhe5zwyn2tpyt65mdrlxshejx5wcjlh@55re3bsshcqe>

Hi Sebastian,

Am Wed, Jun 19, 2024 at 05:30:27PM +0200 schrieb Sebastian Reichel:
> Hi,
> 
> On Wed, Jun 19, 2024 at 08:14:07AM GMT, Dimitri Fedrau wrote:
> > Am Wed, Jun 19, 2024 at 01:19:32AM +0200 schrieb Sebastian Reichel:
> > > On Mon, Jun 17, 2024 at 08:45:04PM GMT, Dimitri Fedrau wrote:
> > > > The MAX17201 monitors a single cell pack. The MAX17205 monitors and
> > > > balances a 2S or 3S pack or monitors a multiple-series cell pack. Both
> > > > devices use a I2C interface.
> > > > 
> > > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > > ---
> > > 
> > > [...]
> > > 
> > > > +static int max1720x_read_word_data_nvmem(struct i2c_client *ancillary, u8 addr)
> > > > +{
> > > > +	u8 rx[2];
> > > > +	struct i2c_msg msgs[] = {
> > > > +		{
> > > > +			.addr = ancillary->addr,
> > > > +			.flags = 0,
> > > > +			.len = 1,
> > > > +			.buf = &addr,
> > > > +		},
> > > > +		{
> > > > +			.addr = ancillary->addr,
> > > > +			.flags = I2C_M_RD,
> > > > +			.len = 2,
> > > > +			.buf = &rx[0],
> > > > +		},
> > > > +	};
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_transfer(ancillary->adapter, msgs, ARRAY_SIZE(msgs));
> > > > +	if (ret != ARRAY_SIZE(msgs))
> > > > +		return ret < 0 ? ret : -EIO;
> > > > +
> > > > +	return get_unaligned_le16(&rx[0]);
> > > > +}
> > > 
> > > Have you tried using i2c_smbus_read_word_data(ancillary, addr)
> > > instead of the above?
> > >
> > Yes, I did and it worked. Used it in V3 and changed it due to review
> > comments by Thomas which make sense to me. I don't have any preference on
> > this. Should I change it back ?
> 
> Using the smbus function makes the driver work with a pure SMBus
> adapter and keeps it working with I2C adapters through the SMBus
> "emulation". By using the open coded version we have more code and
> the driver does not work with pure SMBus adapters.
> 
> So I see no reason why the open coded version should be used. Note,
> that regmap also uses i2c_smbus_read_word_data() internally for your
> configuration of the non-ancillary device.
> 

Thanks for the explanation, will switch to i2c_smbus_read_word_data in
the next version.

Dimitri

