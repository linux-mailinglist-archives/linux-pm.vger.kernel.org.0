Return-Path: <linux-pm+bounces-23919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1230A5DC98
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 13:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CA63B84CB
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FDF242917;
	Wed, 12 Mar 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFTWDbPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D02417C8;
	Wed, 12 Mar 2025 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782499; cv=none; b=ehHUof4gUHHtkg7PFw3v0v1E6ThV1Wq9exWY+wyhyFuk0lBBJLA8RQDxNQ/33bJsWyd0SF8LBJVG6NoXswfmsg846hO2WNFj/CfYjS98rXw8L8lkDTVNPDzm/le4HhNhk1XEiDdXfPKwBjY2lSxA4WUuKEfBOZJ2/dOb8NbM9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782499; c=relaxed/simple;
	bh=JONbt992A2++n0cV4SiUFBSFKKZy3qKjS2WQIdDkxrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a880GG4uvaTYH62F+n5WQy+xD5omnjYX9SbaiheMg22zgsTfDOmms0Ba9vRylsba/wa2Fkg2VaUxm7pVtRwv8q05DJ5Fl8Ky3a2wFAD65wC3IZakhy8a+E0W+bMU3CJzTywMUu78JdB7+n2kmQ1eKUd/wPpmQYJV00kQYTL/Kjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFTWDbPU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac298c8fa50so519677366b.1;
        Wed, 12 Mar 2025 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782496; x=1742387296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=udcJZmwY9vygJ+nqWIO5M9M9ZBnqe+zAARQm+nnDFyU=;
        b=LFTWDbPUpNV64aR/TK/Wpp8krMqZyoE+1nVQDUSg22k9IzM2cZwNRIMo3kZUe+ImRj
         N6ZfpzZWOU0ZGsMCm/OjTRBYBQ/ri1t/ZPAlWlk8kTOdsPO7IOsw0gE9Ls7HYzVNtJPZ
         hHftrwTU2J9LqwCXYhagFZpsXfFNIz448qdch2Ui20gxXUB1AT65qq8t2OkG+XaimsWE
         xS1ggLV8LkShe5uysLdGSaS8Bg6yZ0V8RI/Y6nGi+4ojqiDVQ7wxmpIv4QpUVgsfFE2s
         paAUtI/OFgsNdbkVVzv/9oKMpARBPM7bZmHqEAAqj5upd5zR6KNgbBfKVyDOzZE/XTGk
         bIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782496; x=1742387296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udcJZmwY9vygJ+nqWIO5M9M9ZBnqe+zAARQm+nnDFyU=;
        b=IkTNVqMczmX2lkjP/6XIdgvdtNhWKUvmavGFiMNxoXc8G2OQtV4EeO58hKAZz+T26P
         /Sn37y0zjvhiavYvNicnkJK2gwamDJXufscq8qwu4wMLYMZ/hU/esignm4UXTeIkfUaU
         BIbz2Sco9xXvUlq/NyYw2gQ4ldfmRu+l0RGn3zsU5h+GxzzC5WeT+i/fhxdUt51mNoaj
         ji/ODMpn9PVIS/PHl58gdX98R6yJSZD0GuosUb570sv/s0MPTmiaO1AdYoIWO+vy3kFD
         dExe7ffMjNqPXwVFxJIPLOdkVG6lptnIkM/ZKudwJwC5tkTgiVoQTBbqxkAi2qFYrzIj
         tu0A==
X-Forwarded-Encrypted: i=1; AJvYcCUXF8EoypIgZDZkDIsMjsOWO6QEoZak5HZl/ChwUQ4jLbUPDL58Lx6RXyBB6MY8mWMZTWwQ2MMkv41IFLQ=@vger.kernel.org, AJvYcCVmxcLpuxmNc5aKr4D7T4JvFfpPiwaN7MDHkZZCwvFlBDTmayN19cyj8CM15fmnqUC/8j5W59kl3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyge1HLbjQGUKbuCnI8K855/oWlNBC6sJGVrpczc0gZZlLldSIa
	27C9sGj/xkmUOVeCoPK1xM9gdjcSWNjDfrcpW+jBBH9mbB/ntseBaxrk06oc
X-Gm-Gg: ASbGncv/w9fKzjfhC+mukRSJj3X6XL9lsyXDTLmiZYR1yuAj86g8UmELmJwYyaVc9ps
	F0bcHN+gXtOJDK/8+mjl0N5O+xi+iUuCtbGRGrL3z0TP30kh8Bvg2MoXiEMjgea+2FCED++mSiG
	/9N7tlwd0bpethA0WtEQktGQJB9sXp5eMwsSiL1ic5G3vkMfZuRr7lB83hvRDuiAlSVqvHlhs7G
	VcgkskkOOp34Lnp78Fm2oFAWqfJkPzo5yAzP636WLJ82yFBrg5OsLPwt4KCWXBURRSwkkxVuFYN
	oAvdn6ft4Ci8pl5PS3Jczt3g6YorgpxYbTuzeOrKIBk7IvY+ykgReGE=
X-Google-Smtp-Source: AGHT+IFIg2lP7GRrUC4dOGs4mpOZWh5vYC4Zr3r96uhXiY5AlyYNsIBslsgU3YLwi+NCHNXhcXFbZg==
X-Received: by 2002:a17:906:ef0a:b0:abf:6ebf:5500 with SMTP id a640c23a62f3a-ac25260afefmr519645966b.16.1741782495915;
        Wed, 12 Mar 2025 05:28:15 -0700 (PDT)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac254346ce8sm931347666b.177.2025.03.12.05.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:28:15 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:28:10 +0200
From: Sicelo <absicsz@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, pali@kernel.org,
	linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org,
	phone-devel@vger.kernel.org,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	akemnade@kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
Message-ID: <Z9F92vGJbyUSFgxa@tp440p.steeds.sam>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
 <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
 <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
 <C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>
 <Z8GHuu8RXkcY8utL@tp440p.steeds.sam>
 <4D7D3E00-59C6-42F6-AE96-F04970D60E8D@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D7D3E00-59C6-42F6-AE96-F04970D60E8D@goldelico.com>

Hi Nikolaus

On Fri, Feb 28, 2025 at 11:01:35AM +0100, H. Nikolaus Schaller wrote:
> > 
> > Thanks for the review. I will do more thorough testing over the weekend
> > and send the patch.

I have made a follow-up patch [0], which produces the following values
on the N900:

bq27200 in 'normal' state:

   DEVTYPE=power_supply
   OF_NAME=bq27200
   OF_FULLNAME=/ocp@68000000/i2c@48072000/bq27200@55
   OF_COMPATIBLE_0=ti,bq27200
   OF_COMPATIBLE_N=1
   POWER_SUPPLY_NAME=bq27200-0
   POWER_SUPPLY_TYPE=Battery
   POWER_SUPPLY_STATUS=Discharging
   POWER_SUPPLY_HEALTH=Calibration required
   POWER_SUPPLY_PRESENT=1
   POWER_SUPPLY_TECHNOLOGY=Li-ion
   POWER_SUPPLY_CYCLE_COUNT=0
   POWER_SUPPLY_VOLTAGE_MAX_DESIGN=4064000
   POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3000000
   POWER_SUPPLY_VOLTAGE_NOW=3536000
   POWER_SUPPLY_CURRENT_NOW=-432327
   POWER_SUPPLY_POWER_AVG=1146100
   POWER_SUPPLY_CHARGE_FULL_DESIGN=2056320
   POWER_SUPPLY_CHARGE_FULL=2050560
   POWER_SUPPLY_CHARGE_NOW=366680
   POWER_SUPPLY_ENERGY_NOW=1207420
   POWER_SUPPLY_CAPACITY=18
   POWER_SUPPLY_CAPACITY_LEVEL=Normal
   POWER_SUPPLY_TEMP=316
   POWER_SUPPLY_TIME_TO_EMPTY_NOW=4140
   POWER_SUPPLY_TIME_TO_EMPTY_AVG=3780
   POWER_SUPPLY_TYPE=Battery
   POWER_SUPPLY_MANUFACTURER=Texas Instruments

bq27200 in 'broken' state:

   DEVTYPE=power_supply
   OF_NAME=bq27200
   OF_FULLNAME=/ocp@68000000/i2c@48072000/bq27200@55
   OF_COMPATIBLE_0=ti,bq27200
   OF_COMPATIBLE_N=1
   POWER_SUPPLY_NAME=bq27200-0
   POWER_SUPPLY_TYPE=Battery
   POWER_SUPPLY_STATUS=Discharging
   POWER_SUPPLY_HEALTH=Calibration required
   POWER_SUPPLY_PRESENT=1
   POWER_SUPPLY_TECHNOLOGY=Li-ion
   POWER_SUPPLY_CYCLE_COUNT=0
   POWER_SUPPLY_VOLTAGE_MAX_DESIGN=4064000
   POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3000000
   POWER_SUPPLY_VOLTAGE_NOW=3633000
   POWER_SUPPLY_CURRENT_NOW=-397341
   POWER_SUPPLY_POWER_AVG=1432260
   POWER_SUPPLY_CHARGE_FULL_DESIGN=2056320
   POWER_SUPPLY_CHARGE_FULL=2050560
   POWER_SUPPLY_CAPACITY_LEVEL=Normal
   POWER_SUPPLY_TEMP=299
   POWER_SUPPLY_TYPE=Battery
   POWER_SUPPLY_MANUFACTURER=Texas Instruments


Hope this also works fine on your devices.

Thanks and Regards
Sicelo



[0] https://lore.kernel.org/linux-pm/20250312121712.146109-1-absicsz@gmail.com/T/#t

