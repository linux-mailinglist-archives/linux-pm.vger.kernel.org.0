Return-Path: <linux-pm+bounces-4539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6F86C3C5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 09:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A166B1C22280
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BEF524AF;
	Thu, 29 Feb 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS6rrUpI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B650279;
	Thu, 29 Feb 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195742; cv=none; b=a6W8t008i0UKucOPKjT+RxW5+rSfkydpZfVZSsmyYC8zcRU3brw3M8hEwtdoVReyNAf2k5vN5kFKOAwrDDb8j5BwfB23oMvvbTXub5WpxEuXI8pt/pInubDRYjx9BBdrOF9VPG9ovaxmLdOaTLa7+ghaTQOiQbZwKqHf070de+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195742; c=relaxed/simple;
	bh=Ry3XJ0zgov5hfjRZoYIZfwvnFJc9lMbRqp+Ji3xGrY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhLE7Nl3BXiHnQcUwu7+kFvDRTFF/7fvhTGuLi96b9NThW4+9Go4Jd7fi04DIUgtTEfeTRYmKmxdjxyXi5TWCrJ14aY50DmQQ2bDtd7sAjFc9Ft09lkB2vUlBrCssra8jfI7nLhKns6895q6GgTyuIAF6axCJLl+l5hQmMvlbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS6rrUpI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412bcb76703so2656475e9.2;
        Thu, 29 Feb 2024 00:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709195739; x=1709800539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnfylAbrkY2RzpmVXOqukYKnA1Zk4JFIZcR8wtA1qUI=;
        b=iS6rrUpIqyzCFKz7Sx19eEAkLv7/TfIl4Uav0ahEBprxkR6FLIl7B4nbJYHYL1Fx9T
         qXVXtPZuqr/LGGxcWMHJFdBVIjU/nsIfW52Fd0Y8NwNSdR2fjmhyyHAKb/rWfSe4tUjR
         xXs1O8H8hjGGipKYkupysvoPiOvke7IVVPZb6y2g9/MJqif6dBkeWj9mGpmJlS9xXCv5
         jSTsSKbgTWf1KWjNnQaa7GwV4AJyMtcq+SZmmRnDrWCV8/rRuA/Oj7vPearxV3kONNJH
         VnVzc/b/olrYgsiezvgAJEfCPHEcTZQOEat19oSSSAK/7vMSoPnbV3kt0LwsmpOIYHwp
         8x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709195739; x=1709800539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnfylAbrkY2RzpmVXOqukYKnA1Zk4JFIZcR8wtA1qUI=;
        b=IF42HW1v4L6hyE1GjdjDviYiUDPL64/faTD+7B/KOEO7nWsMVVYmodTNRwtf89h0Zv
         KEvgHtfQcILdVvm2IjeL1kHYTPs2YcUDA+2fA6nOewjE0WJx+9+n67tFHEF7IT408fN8
         kywjm9hT8kmrdnuVHBZJWM/lx7ioyn+eIwCduPPDx0Xdk9bOcB4YD3X9dD/NN+0ZI6+K
         p4IJQPjgaFUdq4FVuBkpuYwW4XXrGoZld63umKpCPEMIlEKyvapBwAn/n33TM00TDItM
         wE43eePp88glPDzaM6K0Yl8LYWf3AAfTQ1Sd7LIATDxP0JoyG5N0XMpA9ebSWtIon/O7
         +NXg==
X-Forwarded-Encrypted: i=1; AJvYcCWWPVdz5iifSoJln5w0+Co24wLU3qti3BkFEY7rjhZ0ijxqq6OGvN9Ir8jU3YS9lbCEoiER/KN+MxfgLukefSf9fvjtfhtArhlPSIettT4JI24AFivLncN0E82N8U0MqRaah8y1
X-Gm-Message-State: AOJu0YxPN4w/7+mfeSOgWxa6V9AlcQp1jGjS/rjn2AgRJ3tuz7nCbR7m
	UcBiDbaY8ZFRFYX5O2ETG5yDQX/6han3wJaIlc+dIiggQhiSZZ6v
X-Google-Smtp-Source: AGHT+IF2CrHWsYVn8AqXy5R/UGnjqtqiyzRD/8+A4WAbwbjD0fdH0mbKVlN1DoiGoc9Sx/JThfcRxA==
X-Received: by 2002:a05:600c:4fd2:b0:412:c1d3:1a85 with SMTP id o18-20020a05600c4fd200b00412c1d31a85mr57972wmq.33.1709195738498;
        Thu, 29 Feb 2024 00:35:38 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm1088916wru.112.2024.02.29.00.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:35:38 -0800 (PST)
Date: Thu, 29 Feb 2024 10:35:32 +0200
From: Sicelo <absicsz@gmail.com>
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	pali@kernel.org, sre@kernel.org, spinal.by@gmail.com,
	maemo-leste@lists.dyne.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: n900: set charge current limit to 950mA
Message-ID: <ZeBB1GYb31UAW886@tp440p.steeds.sam>
References: <20240228083846.2401108-2-absicsz@gmail.com>
 <20240229081923.GI52537@atomide.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229081923.GI52537@atomide.com>

Hi Tony
On Thu, Feb 29, 2024 at 10:19:23AM +0200, Tony Lindgren wrote:
> * Sicelo A. Mhlongo <absicsz@gmail.com> [240228 10:40]:
> > From: Arthur Demchenkov <spinal.by@gmail.com>
> > 
> > The vendor kernel used 950mA as the default. The same value works fine on
> > the mainline Linux kernel, and has been tested extensively under Maemo
> > Leste [1] and postmarketOS, who have been using it for a number of years.
> 
> Makes sense to me. At -rc6 I'll likely wait until v6.9-rc1 before applying
> new patches. If this is needed as a fix before that, then please let me
> know.

Thank you. It can wait for v6.9-rc1, since using 650mA does not cause a
major usability issue.

Regards
Sicelo A. Mhlongo

