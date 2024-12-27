Return-Path: <linux-pm+bounces-19776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3BA9FD663
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCBE1885310
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A01F76D8;
	Fri, 27 Dec 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h09euNVW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591591F708D;
	Fri, 27 Dec 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319563; cv=none; b=soJXFh/cptw0oCL9e9uRAhEWRNeVG5bBiblCZjDes4NVPuuOMrZhiXVyA+pUdFwYXe9HL+5Ig6BWavj4SMht9MJvEw2O47ak1AkvXf3xmihfFW0Bh2L3TKTPpmIvVZOCoiQvqEhsHXO2A8vXxwAlqmAJojlMCp//xvOmuWGjl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319563; c=relaxed/simple;
	bh=4WQTZCwbZCVU4+lFvbuyOzu+DPqlwXMIzKUCeU4JYvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mr9OeL6uJanDBllsQG0vWZtj/2lRjDUk0JAbUuOOWop5WzblTgwdnaAyX4bB54zCTfEk/tiuZ6n+WgVPASGD7C8HOQk0dercxSdBH4+Pt7vrWOJ1l5DobdV2b3p3jljMOkKQB0aam3UrUDzY1tQSm05aYpyYSb+aZg6hJ27ddUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h09euNVW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216395e151bso65896545ad.0;
        Fri, 27 Dec 2024 09:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735319560; x=1735924360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxflWSIWJwHIbP9AwQCi8GrchWvityvfuG8lr9z+azE=;
        b=h09euNVW/m1vuL29XmL/uCHuLEBnDO+gVe08h3B3Qkds2o61v15xpQCKdkeddvEaj4
         adJeZtvpuTNFTQUypUCK1XttIg7hRexKzu8JPsaW1yAor/VYAD4tP20zLOgWqYsSOXTg
         CjD6sUr16MdFqCYup79bVxI8pJY5O/7OGibuTUmgUeiL5JG12IawYfkWbgQotXS3b4uB
         uAkcFiRJ/mZ3ss3dKrpZ0mLL/J3enWHWpx0to4dcqmpwPNRk4H/zsmxXpB9nqGcDu+az
         JjhXltJOkwoBTmalMc5iLybwYMliAD3+ceeZFV6zxMNiSBuPhtkkoyq4x0P0mrcroXJS
         47wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735319560; x=1735924360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxflWSIWJwHIbP9AwQCi8GrchWvityvfuG8lr9z+azE=;
        b=Cq2WY1PSFLXE9NUnGutrZDNGKnlJYFGEbl/ScKuf+tWd5FuPfqLp7y/B8sOpsM9XeB
         rGHd0IZR++/3v1ls5Wil8CGgfoYM2DGFmfo9ZvrBOORvLs2FX/YUOFsxiMmR3R8GjA9S
         jR5/oYLmfq6Jr3Mcoqh4klvoguOrvvfb3OQqkJ9oi34BClCgQAZTbtRFCUN2OW5uDXB6
         w4Lfdpor/XO8ivg0brcNff3Esm7mT9gEiWlT6dQnLskKXZrvuUy9TmGW3Jv7AuAn3RNJ
         h9XR3sMfgLUl5q93POyZL7f+m/KypJZKjcV3r2qfJph9wEFh5QP9edgVOh1IJhz+tNx5
         +Niw==
X-Forwarded-Encrypted: i=1; AJvYcCUFyAgXr7fG33njxW28SoczgRHoubVWTNxPJXbaqfkH8XS/LfTWnyoZlTRiR+QiVeKfGAtFpRQleI9qEcQ=@vger.kernel.org, AJvYcCUo12hJXkvbs6RXqOLCMz9Vi3ojkPzBnWfLuSoXY35bBwsiRzY75kIuSRo1fDQT/T/dpyEHIvPPEsk=@vger.kernel.org, AJvYcCW1Is8X8GSAZwQ2zWzeK+dc9WwInRx9SkBo623MALAks2WSNOpkQtsszinnekG0JVOWEDcJdRIRgVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKP/XRfX2FyyA6X3iwxgdqttPKz9XdDlAco2UybbFu2N/1N74A
	Ep3ATdvZNGNK9en7sHwkxCFasCcdYt30Kgev4v7sPIJEnMaaYQev
X-Gm-Gg: ASbGncu8sXe0NhonDIChwpOZ4aOBpIrny9iS7wIBYMd/RyCCvAsJeGQ5JE9tlgpgo+C
	5fDCB6kR0YC8oNF6XGuqLmtz+yN0Om6FGAKprgh3mUfVLiROGx3Uu7IHckGvpZG9PXVXsEvO5xr
	vV8SaxbOnWtYxg361hPIQyCxUa+qG38hHEfAQZxDJLtIX+2IBapx9Y++YhbRVKPNG0j36bvW4p6
	qekUwUOUgxSVFQriMe5agkMBRvXLWox4sI87fkILZz6wlafeuHWYhBiXHXa8nlNtUwZGw==
X-Google-Smtp-Source: AGHT+IHt5y/rHmMHJcDIkz4B/MJFJvfa7OTMJKaL8M+he1zdCjukHopWGudmiUKv28Xgv46l1MhelA==
X-Received: by 2002:a17:903:2cc:b0:215:6c5f:d142 with SMTP id d9443c01a7336-219e6d5997dmr400488625ad.20.1735319560552;
        Fri, 27 Dec 2024 09:12:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0140asm137455725ad.232.2024.12.27.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 09:12:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 27 Dec 2024 09:12:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>
Subject: Re: [PATCH 00/10] hwmon: (oxpsensors) Add 2024 OneXPlayer line-up,
 add charge limiting and turbo LED, fix ABI
Message-ID: <3b5b5486-9b11-484b-b5d9-6a830ad10130@roeck-us.net>
References: <20241226112740.340804-1-lkml@antheas.dev>
 <a8e6d5d5-703c-47df-ab57-58234fdeefc1@roeck-us.net>
 <E24291F9-731F-4C27-96C7-BD08FBCF7A76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E24291F9-731F-4C27-96C7-BD08FBCF7A76@gmail.com>

On Thu, Dec 26, 2024 at 01:16:15PM -0800, Derek J. Clark wrote:
> 
> 
> On December 26, 2024 1:08:02 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> >On Thu, Dec 26, 2024 at 12:27:30PM +0100, Antheas Kapenekakis wrote:
> >> This three part series updates the oxpsensors module to bring it in line
> >> with its Windows OneXPlayer counterpart. First, it adds support for all
> >> 2024 OneXPlayer handhelds and their special variants.
> >> 
> >> Then, it adds the new charge limiting and bypass features that were first
> >> introduced in the X1 and retrofit to older OneXFly variants and for
> >> controlling the turbo led found in the X1 models. For Bypass, it adds a new
> >> bypass variant BypassS0 that is only active while the device is in the S0
> >> state.
> >> 
> >
> >This is a hardware monitoring driver. It is not a charge controller driver,
> >and it is not a LED controller driver. If such control is wanted/needed for
> >this system, it should be implemented either as mfd device with client drivers,
> >or the entire driver should be moved to platform drivers if there is a desire
> >to keep it as single driver.
> >
> >Guenter
> 
> I think moving this to x86 platform makes a lot of sense to ensure two separate drivers can't do async writes to the EC. We probably should have done that when adding the turbo button toggle anyway. I'll coordinate that effort with Tobias and Antheas directly before moving forward.
> 

Fine with me, but "ensure two drivers can't do asynchronous writes" is not
really an argument. mfd supports that as well for pretty much all mfd
drivers.

Guenter

