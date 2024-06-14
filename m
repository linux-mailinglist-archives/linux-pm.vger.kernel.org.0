Return-Path: <linux-pm+bounces-9180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B29089B4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 12:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C461C26837
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848051946A7;
	Fri, 14 Jun 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVZqrN1b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E919413D
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360695; cv=none; b=YkK3agGXHdUnHEe6F6UKA/xrbVGy5Hh+GSoyJE+mFDV1Kw+Ip5XirVAdyIyRuv5Tu9xkoSmytmI7/OvDIYnOyS9DHQMmuuQ/DaS40k+/3pWI2ffmpM1Kzo+PxVmEKHz3QkBq+eDev6wfBqKTMj2vQpxwEUaIlZNpSTTQk1fRb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360695; c=relaxed/simple;
	bh=ZuwSgi9zLIoNZp877URK5FteNaoBqxpCKd2FeYdrG38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFfuDeE6JDJazSWw7E5uTABDXxkKJQiPscMmsEDPKJL3h3NDreeAU0acaVvGzZBpgH1yqYrHg5u8ofWVkwNKhaKHB4O0NBjtUOpNNVczz8UmfoEAM4QWXy7JeUkSGNQ36KKCDR32tuCGMRo5WxtZgkX/FJmBXTXj2BgfrxAWPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZVZqrN1b; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c85a7f834so2618369e87.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718360691; x=1718965491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=efnhjpqQgsmtdaUVLcqkEj44nSpt4V5RfvjPWerlFZk=;
        b=ZVZqrN1bcVkscnqRfkObQYXi2bS6sEMRFe0GFJamipcs+6ukeqxE86Hgc/RVZfOKa/
         ZCv4KAN3DAJwAH+Zigx4dimz5aDoBUIhFlkzXZWcZ1zCypnt10DmANYns33SxLm4omOg
         eiCEMrgV1MHxZvbMcZ9li2buyyvPzmR+4NYXV0z+UVGCFK7hvImpwiSj0SCboHZ5wpTo
         idF2fQyVdX4wiliiqvet9M+WVQX204+OcpE4EZW/hYEPnoUpwAd2wnJ5yNCjhVK5t8nj
         V+x9FxyJDLpCvhEQ/iRZmKTYpU4S4ralN62CFSp6uZHs9olw4kfJvGfuZ098ZVF4D0ac
         zm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718360691; x=1718965491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efnhjpqQgsmtdaUVLcqkEj44nSpt4V5RfvjPWerlFZk=;
        b=kok5j9HN5OSBE1UfUHG7ZlJE/GvBN0agmFSd6NbUHt24nwm20a5p8OtQcOVTp5WmYV
         3j+fDCKrAb4MaPWPGkUtN0WRyUB7SR58NJQhAJNefmcxLMSoJWtOiVmjo9XI+JdKYtk+
         aabZOq5rf6DPZKmDv7ACWP8A0xBU91GDnJz/xUDapzqHAqsdTAZdbWFNCh+zJGFlr7SG
         oZtjWvWYPYAWx8ZgAWBx1EvcbsDDcxIZuZdrDtCEZjhtpy+5rEowovLxUDyxNnErYBrd
         mfJhGnz5/cEHk4x8Rs0IVS+xEEFsbZXEVuhfXJjl4Bj9QyqaI0x3XBx4hJwz1LX8YZ5u
         s3BA==
X-Forwarded-Encrypted: i=1; AJvYcCU7xOpQ3jkhRTVYu0nTcREj+wZpGDrIisFnbVXHwvdCPYWVIAcDjEfLUeFlyJ5P2NZ7XhvGE6b9SC803VDCBJ+Jxdn79IzWQIc=
X-Gm-Message-State: AOJu0Yy0jaIif8Y0EsFQgv45ATr8BKN40Y41rZupo2m+yZPU5xRW8F8f
	DqI7pKaML1Kdj69kLx0uugXDERISGfSMZ0ZbKkUjZGGfFeH3DIJUrTMS9fY3lOk=
X-Google-Smtp-Source: AGHT+IEWORdeTtr6fZukAQJ2f/JpYbjWtk3eAvDeBEJR863+Icr9nb85v00/m9s9du9B/uAO5LpWzA==
X-Received: by 2002:a19:914d:0:b0:52c:8a4e:f4bf with SMTP id 2adb3069b0e04-52ca6e90db1mr1229088e87.51.1718360690961;
        Fri, 14 Jun 2024 03:24:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca886e23asm168540e87.270.2024.06.14.03.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:24:50 -0700 (PDT)
Date: Fri, 14 Jun 2024 13:24:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v6 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
Message-ID: <s5ykyyczxrn7pblzbiu7st6barn47zrtjr6yn5shbeo7lwqkfk@hdctgjwpqu55>
References: <20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org>
 <20240612-yoga-ec-driver-v6-4-8e76ba060439@linaro.org>
 <r5wjdxqdechzxbyqwbyz7ou6nbxqewb6bruvklvcek2dhspixf@ujavcd3ky7n7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r5wjdxqdechzxbyqwbyz7ou6nbxqewb6bruvklvcek2dhspixf@ujavcd3ky7n7>

On Fri, Jun 14, 2024 at 03:35:25AM GMT, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jun 12, 2024 at 12:59:35PM GMT, Dmitry Baryshkov wrote:
> > On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
> > and battery status. Add the driver to read power supply status on the
> > laptop.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/power/supply/Kconfig                    |   9 +
> >  drivers/power/supply/Makefile                   |   1 +
> >  drivers/power/supply/lenovo_yoga_c630_battery.c | 500 ++++++++++++++++++++++++
> >  3 files changed, 510 insertions(+)
> > 
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 3e31375491d5..55ab8e90747d 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -167,6 +167,15 @@ config BATTERY_LEGO_EV3
> >  	help
> >  	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
> >  
> > +config BATTERY_LENOVO_YOGA_C630
> > +	tristate "Lenovo Yoga C630 battery"
> > +	depends on OF && EC_LENOVO_YOGA_C630
> 
> The driver should no longer depend on OF. Otherwise LGTM.
> Thanks for reworking it.

Ack, I'll post a fixed version once Ilpo announces an immutable branch.



-- 
With best wishes
Dmitry

