Return-Path: <linux-pm+bounces-36105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 583ADBDBFCF
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 03:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5037E4E246A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D91273804;
	Wed, 15 Oct 2025 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqrlZUQe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C073285050
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760491995; cv=none; b=MuNbwD9YDAjHkNKrvAbIxbKfZX+z6DZiALl14piAXks55+t6BdWnMIFIwiir3/ttj/Z2IX/EntxkY+4MWSFNIHpFGnL2VJGFNo5NL/gIMaZn/+tptWANukvsTToHDve2oaafvmsuqCICmzere8H10yifud8XmnAM0XmfVbP+PUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760491995; c=relaxed/simple;
	bh=6badzYk/nvV1acB3qT5JfVBXT+d6ShZ1CA6n3TANN74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXCzmfOI6/tI80fyFGuSHflm7lGccoyH5LiS8RxbHmpoCa8WydqywlZbPCeGq6Hvysr334mvx9VpQOtUjxeHr5RrY9cBYto8BdAxnHPh5seTrqH0WMhrqSKB1S+MYKoFxW3b2wgoHsDLKWQgK9Hhgm6VgQqZZZUGin0Qe4tCnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RqrlZUQe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26d0fbe238bso43620945ad.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 18:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760491993; x=1761096793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpWqEUjcuMYUOuKFrDJhZOLovSxcHFHGML/0fDzV26A=;
        b=RqrlZUQehIfOhLtXDcrF4zHpE464kqdimoU8IDP4E0qhj2tBPPFRJLz63CPLQu1Kw8
         Vqr/11r62TZEwFvPc3AKoQUTiLlFEMYRjqbUUEfUgOQOIYEAHBGhOfcZ0tZkp2lzEeES
         ykLWornCkt7hBdEBSM1Kjv8DkemDhQJuOej0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760491993; x=1761096793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpWqEUjcuMYUOuKFrDJhZOLovSxcHFHGML/0fDzV26A=;
        b=R3oefQ6taCryOAj+IGZ0gyMRRLfxg8fMUDlOlsIJ0WliPp/qWmME9Rd5DoN8h9S0ah
         o07P0aGgjvw0I5v5mDkTCARzW8mihAmko0cGedHONqUkLv6775TluyUBLyq32ncdC6yv
         QzwBbc5uyaGG6LJ0TaYj10ucv1d/8uFvpGAc+K4LzoY7OBBLzMFlqctjA6b29N5odQFF
         zRVI1Q6/sHaolNX2I6vG/PyULGl9ErXxG8QIxyjS/sAF2+PUUVq+O1JkFzWU6XDyyNbF
         ByG7LqtO7Bh0PHPpq0f8UBRipefF/UQP5yhtY4ZLsHGcjhP99HGTezlOLqp3QqXQtLcy
         tLng==
X-Forwarded-Encrypted: i=1; AJvYcCV8UD5PwYIBicN5EiXzNmqLZWZcduSWvjS2w90OgAQaMotSkGKIHVj3fmOO5FjUazFqYLTc2fb0xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytD2H4DJ6aDiXjMEwlTG0frzPwm5v4m3p9e23WIjiDYvob6nJh
	Ju5k8YqI1s81RjCrmnVuMbiPmNO79YxBU56oFaMD4JLn/rWY9lHwbj5svjOSGHkkvQ==
X-Gm-Gg: ASbGncv+4iL8DOZkgc8DAvCD1XXHf6T6TrUUkwJo3uBzLgk/O0UgsA/Em0iIOtia6qw
	8ne/ZRf8MGmgTLktr5WuozWrkgoQ3+bSldvHAifNTggRSocJyU/uT0ZVPQaJKFav1oXh4RpZYTB
	8etm8jEySL6x9rHHw1C7NOlMZ7l2nSXCtANFy3j4l8DBHAKWP4kUfBicEPpmBouPiXY94HIijpA
	k3eyztPRJs6dUzYasTW09SUmTgD8F2cHDX5Dnf/LKH17XjidgXWCIS65is92VT1V0c9VTjcFZex
	HQEsZ/QP+fLlZK6kiVRnSCP4jNCUQUh4BNhaJs63dM2SQZInqyWy/cYlZlH1U0pHwgGeAKgtKRb
	UJq5nxtbEYMfWy+uqYBrBQ2UUX9ht7yQP6d4mNBpbJosdigkU3L11vjHlOEK/fPmg
X-Google-Smtp-Source: AGHT+IG40gAg1zdLGZmMjI5naqJD7ijTD6o4+KRe8hXPev+79JqTTzIKatX374QnWR6oHoZ6OkEh7Q==
X-Received: by 2002:a17:902:f693:b0:267:bd66:14f3 with SMTP id d9443c01a7336-29027402ed5mr309800405ad.51.1760491993114;
        Tue, 14 Oct 2025 18:33:13 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29084e1709fsm13104905ad.2.2025.10.14.18.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:33:12 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:33:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <yapeufdqxobl7yn2ylmtktyon55nofcpwujnwjjrwol37pxw4t@wv3akoz5w6f2>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>

On (25/10/14 16:11), Christian Loehle wrote:
> (Also I can't send this email without at least recommending teo instead of menu
> for your platform / use-cases, if you deemed it unfit I'd love to know what
> didn't work for you!)

I can't tell for sure, I see a number of bugs evaluating teo vs menu,
one of which mentions the following:

    on Tigerlake/Alderlake hardware [..] TEO leads to higher power
    consumption (130mw more power usage in video conferencing) when
    compared to menu.

