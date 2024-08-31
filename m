Return-Path: <linux-pm+bounces-13290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F849672F0
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 20:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353511F21E71
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF477102;
	Sat, 31 Aug 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6nJFi+H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B7446D2;
	Sat, 31 Aug 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725128142; cv=none; b=tXwrSJ0xk3XRbxOzeaLvgPHL22lNfCE8vWZnj+eEGvBrLJYWSqmD5/bMn/+f0PVJrxC93M/QJKMQw7oAeUt6chCUBf668THx/b825lDnQFek+dbGAv1Iecb33sxfnt0aph28PhaN9XNGsOqxxvCcBwW19LyvqzZJbYBV6CErv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725128142; c=relaxed/simple;
	bh=vDI612IftcdDFqrMK0Qx9+AAtOOfaDEwErct1nJhYNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzej1VTgwqye4k1HtRNNPv/EfcmS/rY4AL4DitWjQqYLyBkeRYkjmC70mIQmoE19k1iEBwjqjb1XDncGKNQ9mCvC7RRzCu1wDEuDk0rEWRnPgOESaHLB1jFEIO8f5KBVrIZ/eA7+MZ0wHkNBZngpKoazo5OpmV3Fo46EZjQE7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6nJFi+H; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374bfc395a5so299018f8f.0;
        Sat, 31 Aug 2024 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725128139; x=1725732939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nh3Fojdf1las6Of/pugfWnQ4VISJuccGl6ZEkAsvZ3k=;
        b=S6nJFi+H/psTnuqh2+w2ddN38gnFpkqRwv49sS0XYbbi+/OYSlNmoa1nxZ+TwMxz5f
         zUyX2CvMOsyDlbGd5rJCnddSGpOKMC35DbIXNKrky/VAn/6gQuCfnflzykGzzPvYGuC8
         tytMTgF2NyTm9VMI7Sv8w2jszM5n/ogH/W4ME/d6NwY8uK7/+bxjnQK+IpkwOlvOpu5/
         m0YcDI21/kYZP1qcwUw+JBsn9LAHfCmqFL+VI6JQK1vdWEGf3nNkgKQ9nf5mrbOr/0qg
         THno7Wr+USI95+/tk2FSSvYmZ20FlL07e2AvmDvQetVD4LogSqsS8mou4UuPYHJbDwag
         RXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725128139; x=1725732939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh3Fojdf1las6Of/pugfWnQ4VISJuccGl6ZEkAsvZ3k=;
        b=oNKhhNS/98QxRhNqzV0I4t2D1MlD9uiphXDJnWfRdzGzBPJdBpyTP+i4Nr18hlLVbu
         IyGIO5tlsxpmgP5ViOfDZgZfQXLRw9aeTfgYZWfpLSgh50JMjlxz6o5r53Vnzq2jw9tf
         69o/wNCi80EHs2lb5o7yQ8LlNjwWASg7S8ucRFI9nCCIOGsarMCemi3tCJddE0s00j7K
         86QQmPt7aPsXoJijrl2lsb/K/goeOQsIUexFyCVTCK0wb6JrqwMfnkiDRSCyRNuoEt5+
         hZZAM5cONe078/QYRXuWZaMH0nYRgtTfTlgAuezNSOpTFFJA5Jwr+Z0VMfiQK0hrokjn
         bUkA==
X-Forwarded-Encrypted: i=1; AJvYcCVXLWAJqq4UM52bi1exVwxamlZTRfK0gTFC2baIxHrziYTrngCPivnxdQUIaVPU48PwQp9/Th/gjl0=@vger.kernel.org, AJvYcCVoOvyJQKHyjAtZqsX1ytwh3OTjgUTi175lWAoGfAXfoTF4btby4C9cpS0kFiGH92u/kTOI02ZZNDSERCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIin1mpoZpt7qGDUBkbl7pdhUZOOtnLfcb1jJYZXwYgvxJfrTs
	8T69y8kUtrE5t2jG1a80xejR6NyVKHfocIvTaHF0DlMaTs5tKQ0b
X-Google-Smtp-Source: AGHT+IFcDaf1wy4pcZ3+xfzH5g/DOHtwZhb9Ra7wXnCE6wYdEu8PQ9+LAz6cMe8owH0xX4AY9yr+xg==
X-Received: by 2002:adf:f891:0:b0:374:c64e:3ff1 with SMTP id ffacd0b85a97d-374c64e4095mr19517f8f.17.1725128138286;
        Sat, 31 Aug 2024 11:15:38 -0700 (PDT)
Received: from debian ([2a00:79c0:660:4c00:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e36626sm82988005e9.47.2024.08.31.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 11:15:37 -0700 (PDT)
Date: Sat, 31 Aug 2024 20:15:35 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max1720x: add read support for nvmem
Message-ID: <20240831181535.GA11135@debian>
References: <20240717183757.3948-1-dima.fedrau@gmail.com>
 <635z2qvxmoz24dbqe5ur255iyzayggy3laq6zq4tav34r3yoy6@jugdtqrar2zf>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635z2qvxmoz24dbqe5ur255iyzayggy3laq6zq4tav34r3yoy6@jugdtqrar2zf>

Am Tue, Aug 27, 2024 at 07:28:43PM +0200 schrieb Sebastian Reichel:
> Hi,
> 
> On Wed, Jul 17, 2024 at 08:37:57PM GMT, Dimitri Fedrau wrote:
> > ModelGauge m5 and device configuration values are stored in nonvolatile
> > memory to prevent data loss if the IC loses power. Add read support for
> > the nonvolatile memory on MAX1720X devices.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> > 
> > Based on:
> > 479b6d04964b "power: supply: add support for MAX1720x standalone fuel gauge"
> > in branch for-next
> > 
> > ---
> >  drivers/power/supply/max1720x_battery.c | 215 ++++++++++++++++++++++--
> >  1 file changed, 200 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
> > index edc262f0a62f..175f36e83b85 100644
> > --- a/drivers/power/supply/max1720x_battery.c
> > +++ b/drivers/power/supply/max1720x_battery.c
> > @@ -16,7 +16,9 @@
> >  #include <asm/unaligned.h>
> >  
> >  /* Nonvolatile registers */
> > +#define MAX1720X_NXTABLE0		0x80
> >  #define MAX1720X_NRSENSE		0xCF	/* RSense in 10^-5 Ohm */
> > +#define MAX1720X_NDEVICE_NAME4		0xDF
> >  
> >  /* ModelGauge m5 */
> >  #define MAX172XX_STATUS			0x00	/* Status */
> > @@ -46,6 +48,8 @@ static const char *const max17205_model = "MAX17205";
> >  
> >  struct max1720x_device_info {
> >  	struct regmap *regmap;
> > +	struct regmap *regmap_nv;
> > +	struct i2c_client *ancillary;
> >  	int rsense;
> >  };
> >  
> > @@ -106,6 +110,134 @@ static const struct regmap_config max1720x_regmap_cfg = {
> >  	.cache_type = REGCACHE_RBTREE,
> >  };
> >  
> > +static const struct regmap_range max1720x_nvmem_allow[] = {
> > +	regmap_reg_range(MAX1720X_NXTABLE0, MAX1720X_NDEVICE_NAME4),
> > +};
> > +
> > +static const struct regmap_range max1720x_nvmem_deny[] = {
> > +	regmap_reg_range(0x00, 0x7F),
> > +	regmap_reg_range(0xE0, 0xFF),
> > +};
> > +
> > +static const struct regmap_access_table max1720x_nvmem_regs = {
> > +	.yes_ranges	= max1720x_nvmem_allow,
> > +	.n_yes_ranges	= ARRAY_SIZE(max1720x_nvmem_allow),
> > +	.no_ranges	= max1720x_nvmem_deny,
> > +	.n_no_ranges	= ARRAY_SIZE(max1720x_nvmem_deny),
> > +};
> > +
> > +static const struct regmap_config max1720x_nvmem_regmap_cfg = {
> > +	.reg_bits = 8,
> > +	.val_bits = 16,
> > +	.max_register = MAX1720X_NDEVICE_NAME4,
> > +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> > +	.rd_table = &max1720x_nvmem_regs,
> > +};
> > +
> > +static const struct nvmem_cell_info max1720x_nvmem_cells[] = {
> > +	{ .name = "nXTable0",  .offset = 0,  .bytes = 2, },
> > +	{ .name = "nXTable1",  .offset = 2,  .bytes = 2, },
> > +	{ .name = "nXTable2",  .offset = 4,  .bytes = 2, },
> > +	{ .name = "nXTable3",  .offset = 6,  .bytes = 2, },
> > +	{ .name = "nXTable4",  .offset = 8,  .bytes = 2, },
> > +	{ .name = "nXTable5",  .offset = 10, .bytes = 2, },
> > +	{ .name = "nXTable6",  .offset = 12, .bytes = 2, },
> > +	{ .name = "nXTable7",  .offset = 14, .bytes = 2, },
> > +	{ .name = "nXTable8",  .offset = 16, .bytes = 2, },
> > +	{ .name = "nXTable9",  .offset = 18, .bytes = 2, },
> > +	{ .name = "nXTable10", .offset = 20, .bytes = 2, },
> > +	{ .name = "nXTable11", .offset = 22, .bytes = 2, },
> > +	{ .name = "nUser18C",  .offset = 24, .bytes = 2, },
> > +	{ .name = "nUser18D",  .offset = 26, .bytes = 2, },
> > +	{ .name = "nODSCTh",   .offset = 28, .bytes = 2, },
> > +	{ .name = "nODSCCfg",  .offset = 30, .bytes = 2, },
> > +
> > +	{ .name = "nOCVTable0",  .offset = 32, .bytes = 2, },
> > +	{ .name = "nOCVTable1",  .offset = 34, .bytes = 2, },
> > +	{ .name = "nOCVTable2",  .offset = 36, .bytes = 2, },
> > +	{ .name = "nOCVTable3",  .offset = 38, .bytes = 2, },
> > +	{ .name = "nOCVTable4",  .offset = 40, .bytes = 2, },
> > +	{ .name = "nOCVTable5",  .offset = 42, .bytes = 2, },
> > +	{ .name = "nOCVTable6",  .offset = 44, .bytes = 2, },
> > +	{ .name = "nOCVTable7",  .offset = 46, .bytes = 2, },
> > +	{ .name = "nOCVTable8",  .offset = 48, .bytes = 2, },
> > +	{ .name = "nOCVTable9",  .offset = 50, .bytes = 2, },
> > +	{ .name = "nOCVTable10", .offset = 52, .bytes = 2, },
> > +	{ .name = "nOCVTable11", .offset = 54, .bytes = 2, },
> > +	{ .name = "nIChgTerm",   .offset = 56, .bytes = 2, },
> > +	{ .name = "nFilterCfg",  .offset = 58, .bytes = 2, },
> > +	{ .name = "nVEmpty",     .offset = 60, .bytes = 2, },
> > +	{ .name = "nLearnCfg",   .offset = 62, .bytes = 2, },
> > +
> > +	{ .name = "nQRTable00",  .offset = 64, .bytes = 2, },
> > +	{ .name = "nQRTable10",  .offset = 66, .bytes = 2, },
> > +	{ .name = "nQRTable20",  .offset = 68, .bytes = 2, },
> > +	{ .name = "nQRTable30",  .offset = 70, .bytes = 2, },
> > +	{ .name = "nCycles",     .offset = 72, .bytes = 2, },
> > +	{ .name = "nFullCapNom", .offset = 74, .bytes = 2, },
> > +	{ .name = "nRComp0",     .offset = 76, .bytes = 2, },
> > +	{ .name = "nTempCo",     .offset = 78, .bytes = 2, },
> > +	{ .name = "nIAvgEmpty",  .offset = 80, .bytes = 2, },
> > +	{ .name = "nFullCapRep", .offset = 82, .bytes = 2, },
> > +	{ .name = "nVoltTemp",   .offset = 84, .bytes = 2, },
> > +	{ .name = "nMaxMinCurr", .offset = 86, .bytes = 2, },
> > +	{ .name = "nMaxMinVolt", .offset = 88, .bytes = 2, },
> > +	{ .name = "nMaxMinTemp", .offset = 90, .bytes = 2, },
> > +	{ .name = "nSOC",        .offset = 92, .bytes = 2, },
> > +	{ .name = "nTimerH",     .offset = 94, .bytes = 2, },
> > +
> > +	{ .name = "nConfig",    .offset = 96,  .bytes = 2, },
> > +	{ .name = "nRippleCfg", .offset = 98,  .bytes = 2, },
> > +	{ .name = "nMiscCfg",   .offset = 100, .bytes = 2, },
> > +	{ .name = "nDesignCap", .offset = 102, .bytes = 2, },
> > +	{ .name = "nHibCfg",    .offset = 104, .bytes = 2, },
> > +	{ .name = "nPackCfg",   .offset = 106, .bytes = 2, },
> > +	{ .name = "nRelaxCfg",  .offset = 108, .bytes = 2, },
> > +	{ .name = "nConvgCfg",  .offset = 110, .bytes = 2, },
> > +	{ .name = "nNVCfg0",    .offset = 112, .bytes = 2, },
> > +	{ .name = "nNVCfg1",    .offset = 114, .bytes = 2, },
> > +	{ .name = "nNVCfg2",    .offset = 116, .bytes = 2, },
> > +	{ .name = "nSBSCfg",    .offset = 118, .bytes = 2, },
> > +	{ .name = "nROMID0",    .offset = 120, .bytes = 2, },
> > +	{ .name = "nROMID1",    .offset = 122, .bytes = 2, },
> > +	{ .name = "nROMID2",    .offset = 124, .bytes = 2, },
> > +	{ .name = "nROMID3",    .offset = 126, .bytes = 2, },
> > +
> > +	{ .name = "nVAlrtTh",      .offset = 128, .bytes = 2, },
> > +	{ .name = "nTAlrtTh",      .offset = 130, .bytes = 2, },
> > +	{ .name = "nSAlrtTh",      .offset = 132, .bytes = 2, },
> > +	{ .name = "nIAlrtTh",      .offset = 134, .bytes = 2, },
> > +	{ .name = "nUser1C4",      .offset = 136, .bytes = 2, },
> > +	{ .name = "nUser1C5",      .offset = 138, .bytes = 2, },
> > +	{ .name = "nFullSOCThr",   .offset = 140, .bytes = 2, },
> > +	{ .name = "nTTFCfg",       .offset = 142, .bytes = 2, },
> > +	{ .name = "nCGain",        .offset = 144, .bytes = 2, },
> > +	{ .name = "nTCurve",       .offset = 146, .bytes = 2, },
> > +	{ .name = "nTGain",        .offset = 148, .bytes = 2, },
> > +	{ .name = "nTOff",         .offset = 150, .bytes = 2, },
> > +	{ .name = "nManfctrName0", .offset = 152, .bytes = 2, },
> > +	{ .name = "nManfctrName1", .offset = 154, .bytes = 2, },
> > +	{ .name = "nManfctrName2", .offset = 156, .bytes = 2, },
> > +	{ .name = "nRSense",       .offset = 158, .bytes = 2, },
> > +
> > +	{ .name = "nUser1D0",       .offset = 160, .bytes = 2, },
> > +	{ .name = "nUser1D1",       .offset = 162, .bytes = 2, },
> > +	{ .name = "nAgeFcCfg",      .offset = 164, .bytes = 2, },
> > +	{ .name = "nDesignVoltage", .offset = 166, .bytes = 2, },
> > +	{ .name = "nUser1D4",       .offset = 168, .bytes = 2, },
> > +	{ .name = "nRFastVShdn",    .offset = 170, .bytes = 2, },
> > +	{ .name = "nManfctrDate",   .offset = 172, .bytes = 2, },
> > +	{ .name = "nFirstUsed",     .offset = 174, .bytes = 2, },
> > +	{ .name = "nSerialNumber0", .offset = 176, .bytes = 2, },
> > +	{ .name = "nSerialNumber1", .offset = 178, .bytes = 2, },
> > +	{ .name = "nSerialNumber2", .offset = 180, .bytes = 2, },
> > +	{ .name = "nDeviceName0",   .offset = 182, .bytes = 2, },
> > +	{ .name = "nDeviceName1",   .offset = 184, .bytes = 2, },
> > +	{ .name = "nDeviceName2",   .offset = 186, .bytes = 2, },
> > +	{ .name = "nDeviceName3",   .offset = 188, .bytes = 2, },
> > +	{ .name = "nDeviceName4",   .offset = 190, .bytes = 2, },
> > +};
> > +
> >  static const enum power_supply_property max1720x_battery_props[] = {
> >  	POWER_SUPPLY_PROP_PRESENT,
> >  	POWER_SUPPLY_PROP_CAPACITY,
> > @@ -249,31 +381,74 @@ static int max1720x_battery_get_property(struct power_supply *psy,
> >  	return ret;
> >  }
> >  
> > -static int max1720x_probe_sense_resistor(struct i2c_client *client,
> > -					 struct max1720x_device_info *info)
> > +static
> > +int max1720x_nvmem_reg_read(void *priv, unsigned int off, void *val, size_t len)
> > +{
> > +	struct max1720x_device_info *info = priv;
> > +	unsigned int reg = MAX1720X_NXTABLE0 + (off / 2);
> > +
> > +	return regmap_bulk_read(info->regmap_nv, reg, val, len / 2);
> > +}
> > +
> > +static int max1720x_probe_nvmem(struct i2c_client *client,
> > +				struct max1720x_device_info *info)
> >  {
> >  	struct device *dev = &client->dev;
> > -	struct i2c_client *ancillary;
> > +	struct nvmem_config nvmem_config = {
> > +		.dev = dev,
> > +		.name = "max1720x_nvmem",
> > +		.cells = max1720x_nvmem_cells,
> > +		.ncells = ARRAY_SIZE(max1720x_nvmem_cells),
> > +		.read_only = true,
> > +		.root_only = true,
> > +		.reg_read = max1720x_nvmem_reg_read,
> > +		.size = ARRAY_SIZE(max1720x_nvmem_cells) * 2,
> > +		.word_size = 2,
> > +		.stride = 2,
> > +		.priv = info,
> > +	};
> > +	struct nvmem_device *nvmem;
> > +	unsigned int val;
> >  	int ret;
> >  
> > -	ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
> > -	if (IS_ERR(ancillary)) {
> > +	info->ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
> > +	if (IS_ERR(info->ancillary)) {
> >  		dev_err(dev, "Failed to initialize ancillary i2c device\n");
> > -		return PTR_ERR(ancillary);
> > +		return PTR_ERR(info->ancillary);
> >  	}
> 
> Use devm_add_action_or_reset() to unregister info->ancillary. It
> results in cleaner code and also fixes a race condition during
> module remove, which frees info->ancillary before the regmap with
> your current patch.
>
> Otherwise LGTM.
>

Hi Sebastian,

thanks for pointing out, didn't know about the race condition. Will fix
it in V2.

Best regards,

Dimitri

> Greetings,
> 
> -- Sebastian
> 
> >  
> > -	ret = i2c_smbus_read_word_data(ancillary, MAX1720X_NRSENSE);
> > -	i2c_unregister_device(ancillary);
> > -	if (ret < 0)
> > -		return ret;
> > +	info->regmap_nv = devm_regmap_init_i2c(info->ancillary,
> > +					       &max1720x_nvmem_regmap_cfg);
> > +	if (IS_ERR(info->regmap_nv)) {
> > +		dev_err(dev, "regmap initialization of nvmem failed\n");
> > +		ret = PTR_ERR(info->regmap_nv);
> > +		goto err;
> > +	}
> > +
> > +	ret = regmap_read(info->regmap_nv, MAX1720X_NRSENSE, &val);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to read sense resistor value\n");
> > +		goto err;
> > +	}
> >  
> > -	info->rsense = ret;
> > +	info->rsense = val;
> >  	if (!info->rsense) {
> >  		dev_warn(dev, "RSense not calibrated, set 10 mOhms!\n");
> >  		info->rsense = 1000; /* in regs in 10^-5 */
> >  	}
> >  
> > +	nvmem = devm_nvmem_register(dev, &nvmem_config);
> > +	if (IS_ERR(nvmem)) {
> > +		dev_err(dev, "Could not register nvmem!");
> > +		ret = PTR_ERR(nvmem);
> > +		goto err;
> > +	}
> > +
> >  	return 0;
> > +err:
> > +	i2c_unregister_device(info->ancillary);
> > +
> > +	return ret;
> >  }
> >  
> >  static const struct power_supply_desc max1720x_bat_desc = {
> > @@ -299,24 +474,33 @@ static int max1720x_probe(struct i2c_client *client)
> >  
> >  	psy_cfg.drv_data = info;
> >  	psy_cfg.fwnode = dev_fwnode(dev);
> > +	i2c_set_clientdata(client, info);
> >  	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
> >  	if (IS_ERR(info->regmap))
> >  		return dev_err_probe(dev, PTR_ERR(info->regmap),
> >  				     "regmap initialization failed\n");
> >  
> > -	ret = max1720x_probe_sense_resistor(client, info);
> > +	ret = max1720x_probe_nvmem(client, info);
> >  	if (ret)
> > -		return dev_err_probe(dev, ret,
> > -				     "Failed to read sense resistor value\n");
> > +		return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
> >  
> >  	bat = devm_power_supply_register(dev, &max1720x_bat_desc, &psy_cfg);
> > -	if (IS_ERR(bat))
> > +	if (IS_ERR(bat)) {
> > +		i2c_unregister_device(info->ancillary);
> >  		return dev_err_probe(dev, PTR_ERR(bat),
> >  				     "Failed to register power supply\n");
> > +	}
> >  
> >  	return 0;
> >  }
> >  
> > +static void max1720x_remove(struct i2c_client *client)
> > +{
> > +	struct max1720x_device_info *info = i2c_get_clientdata(client);
> > +
> > +	i2c_unregister_device(info->ancillary);
> > +}
> > +
> >  static const struct of_device_id max1720x_of_match[] = {
> >  	{ .compatible = "maxim,max17201" },
> >  	{}
> > @@ -329,6 +513,7 @@ static struct i2c_driver max1720x_i2c_driver = {
> >  		.of_match_table = max1720x_of_match,
> >  	},
> >  	.probe = max1720x_probe,
> > +	.remove = max1720x_remove,
> >  };
> >  module_i2c_driver(max1720x_i2c_driver);
> >  
> > -- 
> > 2.39.2
> > 



