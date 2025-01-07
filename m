Return-Path: <linux-pm+bounces-20054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65EA047F9
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F93A3534
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51B1F63E9;
	Tue,  7 Jan 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCNDUV0/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8D18A943;
	Tue,  7 Jan 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270138; cv=none; b=tJqSVA3u2x+/iQ4bO0y+eYzp5Ex3W50pSVpC52SAh0c3Ju94LP8BHxB2kbZPLFjj7SAH5EcFIL1Jd0ABEgM+r+bKr0/DD4SZoJFEjVn5TSBEfCU618D4BeNn3cCLKiW3qVv/5kqOata8OIv1d2KONJuc4nu1+oK1UJw7oWk/tfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270138; c=relaxed/simple;
	bh=OCp8XIW/iVjuSQMKDQ5D20QcSAdjhaqSja4L/tXSGXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6xiWtmEImR5GNS5sK4H7mKeGvk5wotD+vk7GR40IYsoAdJf08W6nCi1V9jNflmk2ObJ4snsN8mHz1mTStdxEDn+LoTXRCAihTiOaIrfALAQdXo5rQVDyI+D4dI6Gx94dCuK3qNkLQ6SrYUMY9qGRjLWGugAaH7w7u6aUf33DWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCNDUV0/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so23150773a91.1;
        Tue, 07 Jan 2025 09:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736270134; x=1736874934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Phi0BJwRoCy7LtgG3cuCqi/oioxuOIHuUrBFKsoyUEk=;
        b=NCNDUV0/F8BZbiyau5GlrqWfdd4LCqjuIjL/TdkhMw0vwjvUiN3PuBL+IH9NvHU310
         XXO9ay3xoY9vBO7ptu6emU2yH+Mt7s4w5fn/GZ3VQcJ313L8qgf6tSU95BSoQgwYL/0W
         PbaBLpgZvrEmR8WYx5vsVYFqzs8VUzcWAE2qoSz6g+80gma4WAMhCLlAeK4BDfTMJMGP
         kCuePKpv3ANp+t8x0WkEkbS+wv4evHk56spBYvQn3bLRmpM+HUch6S1UngbAAdC7u204
         C31+Il+j1HyrXpreqv/W/FTC0fawqYWtpvaPd+5MsYmniwtFqhyCaiLMzGIG2CX3ytOj
         3fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270134; x=1736874934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Phi0BJwRoCy7LtgG3cuCqi/oioxuOIHuUrBFKsoyUEk=;
        b=jMTkW6ktb16zsC1aVdoDy4QyCUYPEy0Mv+Tw0bNP2sVqzUQkwJr9tm3/AEGZAno5Uh
         d9KsyQ4AiCKiH+WpMS0c1gSEvm9zEf2hfcpqOgXfGp9i44qwW+KKTYXDPi4yQkKFWEzk
         W/tZj6Lho0xbVNR7R8TGvwBvfeK0/qUAvKBy5TRaPPOPH2PIfCBllaNiZPb4Nlh8cTQG
         b9X0wlpqj0D5Gy3RJMjx9cByiJMPxO+UU+FhwuL5dj598oBOVQRnf0tGjJURtJvsWSfw
         KHrMrWXp8ucRNy5f9sgk3PE9qrVHi76BBftAdvbVeZKis0N6CyaGPyhgbqz+5j4pqndt
         ictA==
X-Forwarded-Encrypted: i=1; AJvYcCVHitVDWre3lSdDibstrKd0vh8I2MNgwj6rg46GLdHQkzNJO7bFZf1uQtHj5BQqUsefpu/SClP79nw=@vger.kernel.org, AJvYcCXBY0rpe/OSDdTvTeMHN86z+5IF6WTBb5GEN7NROgIWXZM1o5YcmWWjx2fl+ppIamjz/JmABf7XmjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bbelpZIFn0BYWBIJTXnAmFcSh/DAqXTfG9dx4I5z/h5FOwTk
	63GZaMUQsKlxSE2VfttAvNF1d3lhP1Vg1b/SxEKendd8FOILY2O2
X-Gm-Gg: ASbGncv5Kmoid8sdfu2hG1yuGVyWhvjiR7E6FXZbSVti7J3qs3JpGemkdnYVkbPaYVw
	XHpWcFQzM42UoOzdlJzD0PpM9TrLGD4/jvfGJHss9H1QclpI7kKQPJNXJlPAaYAcLnhGTFiWVW1
	CsMQdDk7gh9LKLXPri39Se6d6L6O5iFufhe9cB9CikDMRHtWGHNIFjaylqOTcYjcNgWVVZ1udMP
	B9g0Eo6jV8ZMEHc1DUOjLfQuk87+XJjiVLUzYYW2xxz7ytMKWtT7/fj9oYa3v9euVBhEg==
X-Google-Smtp-Source: AGHT+IGS616iV8NftkSPimSe8ktMqorvBTl59Pfg2mAk7R+x0AIYQFBDb10AsddUnTX/OIlUEAZjrg==
X-Received: by 2002:a17:90b:2f0e:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-2f452ee5e54mr96683153a91.30.1736270133950;
        Tue, 07 Jan 2025 09:15:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f454f58087sm37899197a91.11.2025.01.07.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 09:15:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 7 Jan 2025 09:15:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>
Subject: Re: [PATCH 04/10] hwmon: (oxp-sensors) Add charge threshold and
 bypass to OneXPlayer
Message-ID: <05cdd309-ec15-4236-ad4a-0a821a8eed76@roeck-us.net>
References: <20241226112740.340804-1-lkml@antheas.dev>
 <20241226112740.340804-5-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226112740.340804-5-lkml@antheas.dev>

On Thu, Dec 26, 2024 at 12:27:34PM +0100, Antheas Kapenekakis wrote:
> With the X1 (AMD), OneXPlayer added a charge limit and charge bypass to
> their devices. Charge limit allows for choosing an arbitrary battery
> charge setpoint in percentages. Charge bypass allows to instruct the
> device to stop charging either when its on or always.
> 
> This feature was then extended for the F1Pro as well. OneXPlayer also
> released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> add support for this feature. Therefore, enable it for all F1 and
> X1 devices.
> 
> Add both of these under the standard sysfs battery endpoints for them,
> by looking for the battery. OneXPlayer devices have a single battery.
> 

This exceeds the scope of a hardware monitoring device, and even more so
with the subsequent addition of LED support.

I would suggest to move the code to drivers/platform/x86/, where
multi-function drivers in a single file are permitted.

Thanks,
Guenter

