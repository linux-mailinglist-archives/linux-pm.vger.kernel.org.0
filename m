Return-Path: <linux-pm+bounces-19770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE859FCDC9
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 22:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A3A7A01B7
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 21:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147341586CF;
	Thu, 26 Dec 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I12BqFWB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FE33E1;
	Thu, 26 Dec 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735247286; cv=none; b=Nhfa523lxWqB1Kf5DvofRtBO1kjNoEFTLL0oRUHWNqBum0m7Z6VgQ27Rpi1z1sW7iFZW7brtiIxPNZE0p+Pbgkd7riMOQoNseqSgg1D/adfF+/x8Lj03UOO9AUqwsJqt7fob9MJAeAkAdI96u/9KOcdBoeJzmorCP3r9CCjM978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735247286; c=relaxed/simple;
	bh=IHssIBZCGymWp4/fHqi7UM2IPOHwQbJDFvO6SRZWaU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odvKzeyxZCnIOUmmw5cwf6mXVEJPUiy0Ccx6MSL5vvL6vKnzZm4PCBkcI6P6joWagXsEpRXPdVMPaNmRbukZcpsHa2EUjv+t/WGtX/zlYKFvfafy/bwhS8lszP7idmdBM3SAQtsdmnryndZKM+y7Msm4nf5vV5V45XXzbsKHcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I12BqFWB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21634338cfdso113969155ad.2;
        Thu, 26 Dec 2024 13:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735247284; x=1735852084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCBlBnykuwvkbu8e5sqm5s/Qaw3aHtmkyh2cQ8G3Gzw=;
        b=I12BqFWBMNjhJX/Bc1fLtkSbyVQGMWaTbHUSAv/vZhmqbOrx8jqs4S4WK/3bFcP9PW
         xmX+4iHztb59Ne4KixhAbVke0fyXxqDDu8JTRj4EYYbrI/Fef/zM5NryD77CaZU62wjn
         WvQqlBKdoKw68Ru198ocL5Ur8eUjLjyuPHLXuO0m0c1yRa8+l8vNQTJSKfSNAjIQj9mq
         LbbalzA3vAl6CwK4amR6xJooeF+lliJffDzXaRD3yYnUwGnD0V6b7FmxCmXKtjQl2sz8
         EG7GfykR2o8Wv9DXG4WtE+kBbGqd/whlBUjmOIdxJyJQ2UtnZHaR/3mZHxOp331MpO+g
         LqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735247284; x=1735852084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCBlBnykuwvkbu8e5sqm5s/Qaw3aHtmkyh2cQ8G3Gzw=;
        b=tRAgl4Ugzz+wLqgDZ1TDImG2Lo3ng/Uhx7JU7xpMSBzRHbx1wdZQup0hfc1tb/N+M0
         7cs/RvTV/P+YdhAOZPdu6pApkpQcMJ19icf5uRMMd2+z8/ChAOlkuSCXO6ewtil+6i/7
         WftOespwAH/suxjiWk+1NodxTvncTLA7Sg9q8w0RtmI+9eYe1KMWcqE3S6RD1Hc/uUAI
         ic9AR8dmvOzRf9rwg415SapYZ9wX5+RAC9GraeGs7z1FLkk4ed6tQCTej5ljpuET6ocv
         VqSyI3Iiibf6AXXLW6gDg/tRpe9ybjjDrBapJLHLnYSa6OPz+f6Z53y/cMtyE6aT7RAO
         gLdA==
X-Forwarded-Encrypted: i=1; AJvYcCUY7BvT6YeCgLeXQVFJnxSp1bUejisDQx3AGxo7Lp/BZ6pQy8SUIPJpRn7SOTxsiyG8NFzdVm5gBpg=@vger.kernel.org, AJvYcCUdcziObQOAEjyOomMkW4P1D9j1i34mVnuSbkGxJyf1OZhbuPzMZAL8GJNqI7TZtzX6wzk1tg4mDtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdW4PyiAsRqnVy66+90Z43bg5RjjWn4U/kNWJmdtTB8QxAK7L
	XEdiMVMYTryavKge85YuzAE900Zk6xX8ZpKPv9KcHM4Rhj6SObiC
X-Gm-Gg: ASbGncvtkXVBecYguxLCwt1X9IDdj8fuqp5PyOJmF+gjqF6epsyhARI5yZ8PVIo9zER
	TTn9JjdL9oiui/q2FlKkPIhy7s14j9+DOzsob9bJrhdh2hWUQJNOHASCoXYeyPoQ5ifacGtzuOP
	h3QinOUeH3sR4SVTffjFqPE0qBIFFDPuUZR1x4z180vk/O30NVypNjkdVU143HqlOweLD0Tqclv
	FHuX2yAUzVEAghEsFbfaGbtqklAxqMVFV4MhdxEFHNGyGl0e8Gr/Lxsw+wXdbjNFvKArA==
X-Google-Smtp-Source: AGHT+IEyAE6qVNXJbdrnx5TgGAUjggHuN2JVN9bkmUCL9fqLabcTtwMFy/5C7tNOpyAfAjxt67rGuw==
X-Received: by 2002:a17:902:d2c6:b0:216:3dc0:c8ab with SMTP id d9443c01a7336-219e6e8c641mr322325965ad.9.1735247283903;
        Thu, 26 Dec 2024 13:08:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdf02sm123916295ad.151.2024.12.26.13.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 13:08:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 26 Dec 2024 13:08:02 -0800
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
Subject: Re: [PATCH 00/10] hwmon: (oxpsensors) Add 2024 OneXPlayer line-up,
 add charge limiting and turbo LED, fix ABI
Message-ID: <a8e6d5d5-703c-47df-ab57-58234fdeefc1@roeck-us.net>
References: <20241226112740.340804-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226112740.340804-1-lkml@antheas.dev>

On Thu, Dec 26, 2024 at 12:27:30PM +0100, Antheas Kapenekakis wrote:
> This three part series updates the oxpsensors module to bring it in line
> with its Windows OneXPlayer counterpart. First, it adds support for all
> 2024 OneXPlayer handhelds and their special variants.
> 
> Then, it adds the new charge limiting and bypass features that were first
> introduced in the X1 and retrofit to older OneXFly variants and for
> controlling the turbo led found in the X1 models. For Bypass, it adds a new
> bypass variant BypassS0 that is only active while the device is in the S0
> state.
> 

This is a hardware monitoring driver. It is not a charge controller driver,
and it is not a LED controller driver. If such control is wanted/needed for
this system, it should be implemented either as mfd device with client drivers,
or the entire driver should be moved to platform drivers if there is a desire
to keep it as single driver.

Guenter

