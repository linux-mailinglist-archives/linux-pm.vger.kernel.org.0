Return-Path: <linux-pm+bounces-36633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF4DBFABD6
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7906134F38A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E02F2916;
	Wed, 22 Oct 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IEMP82VW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CEF2FF17C
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120050; cv=none; b=FTHMu211oRPhQ6UaNqNlrHE/pTuP6PVpwCkvKnIV01BC/ELIOgi6K4cdANgjWXhXapgIXx98UkFnDmGrYdMnr0YV8r6/TW3ywhbI9BuO0qaPHGirvVbZxXQQXyruUfTe8NZdHplsN+hJZ57eajjNc7em4vLBUBo1Qk0nuv3zgjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120050; c=relaxed/simple;
	bh=QBICN3xZ4ilHueEBD5CeEiNoOhGjZ8M4nbBlTjd48Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4ujSKawBzNnV5bKDRS1msuqGkqSs7crjNHrJu3j3KIYj6AAiplhvDwcaTJ7/PKQT2zuGBRtvy4TK4EJKnOyK/5xWJWyirqry4C3Q/25gp+1gb7yP1ISwJs/UBnHmymYKxnQgJBojRl55eGAI/UoErri0KCovju/RuplJzvBhpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IEMP82VW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2698384978dso45731355ad.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761120048; x=1761724848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+A7Bdl6G6fPPOIETkq0bjl/DvdZzVvjHtnPQ5t53Qlc=;
        b=IEMP82VWvTIMAuGjoH8Vscd8iecr/W2v1XNnCA9+xOBS9yShmkMYRENheIF4eOGpsE
         Vrdy+HjWJbozYC1Bz4q2nnNL0gM2mjntr/dGlqW9oX1xTWYASO+9svmdvEpJtZbFYA2r
         xN5zJq8ca0xRnUbs+XUBpFBv0lCiJPxmdh3tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120048; x=1761724848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A7Bdl6G6fPPOIETkq0bjl/DvdZzVvjHtnPQ5t53Qlc=;
        b=usnWAuHVkQ3Fsdr0eGMt9TBCTG5FSdDt6yT5XlUUqqIJATqS/MSPG8GzFB8IEXJQpt
         n43O+a9Py/JRPtWHsi51bRQS6YbxZcLpU1DOSFtZ3L9JQIZDgBCOzpCoEEtykbYZ3kuy
         QmAQCOHO+sR2hpUVtY5/3cVVtb4B8p8dQXjXkEUpsg/BW1LAdtlqQXxgXaP7vlZ224ym
         kwnQe7s4qRDKfye7bN6i+aUcSmWd1JzRy8wZI2wJ2HSENrRikuW3EDliuBL/zQu5QnOk
         7XXY5zyTDbIJJdo2i3q/xXhvt9amX4eiTk+YnZVnkG+q4wrwArmIKIemoLIG3xFdqVfM
         JTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUoC1PonhLHVcFSfsHz0boEylkix0dqvC9VLzJwFn7Tjr5pfJzFV46OAXBvdbZJEOe18Vv3uuHUWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsEYAIdOE6I9v5X5X/fIJIGosxNFnuuTyDFnAo7zPFycIA+96C
	0p2wrKRLA+5I1vRaXcRihIAuhGvW4Rxw/LgWWEAL+Wr8DCw2xZYcU4CS4+iYRCMpHw==
X-Gm-Gg: ASbGncvWrMozA+ug04hRbu3syHp7MgDEbwbi1qH0fajRA7HVAZZVyEkeLdS7BHsmwjk
	dXJVWKdU9VVshlkj6SraaWGUta52QbITpWSCMjmjpLxPZjfKxsSFOV2GhoaxXGU4rrTYE9G861U
	toRiP29Xs0WpJxa7FnyM4SxTZaw/6Uy/mUFZ9j9RRU/nd8XgeRrYeSZ6YBSFnZthxaQjwyJVFww
	fAPzLQe/3ej1Wd7mkgewr0xBnHZvech6Ewgy0cvSOT67utf4fMuQ3s8mIqBgj8jpfr87O6x0X/E
	+WVrwAQoYI7DAfJJGUeFSQ31A77DzgogBqz0iGJEq+/lCnV4UHKOTwiR/I9oMBIzreVlTSmWcxu
	Xt31HTnGJ3A+KVTgIzQm9j8d8z9yEvobHsIXlO63Z7AnOJSxLz6MCFSMsJVQGo9/cwAcCbRzgDp
	pZWi0=
X-Google-Smtp-Source: AGHT+IFwRfu2UU0x0CKVnA2XXQOjlQ8Lf7ncU2eagOpQerJK/r+6LchvP6koj2zwwU6ovd0NdBRa6g==
X-Received: by 2002:a17:902:f550:b0:275:81ca:2c5 with SMTP id d9443c01a7336-290cba42439mr266990885ad.59.1761120048009;
        Wed, 22 Oct 2025 01:00:48 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a47:339b:a440:e7b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd8edfsm130602485ad.44.2025.10.22.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:00:47 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:00:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Sergey Senozhatsky' <senozhatsky@chromium.org>, 
	"'Rafael J. Wysocki'" <rafael@kernel.org>, 'Christian Loehle' <christian.loehle@arm.com>, 
	'Linux PM' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, 
	'Artem Bityutskiy' <artem.bityutskiy@linux.intel.com>, 'Tomasz Figa' <tfiga@chromium.org>
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
Message-ID: <zq6mqdrq2kxmyga2skrizuj63ocbab2o2k3ogeufq3sydmwyuo@epxcrwomkvvp>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki>
 <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
 <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
 <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
 <001801dc4041$607c19f0$21744dd0$@telus.net>
 <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l>
 <001201dc4297$3903af70$ab0b0e50$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201dc4297$3903af70$ab0b0e50$@telus.net>

On (25/10/21 07:30), Doug Smythies wrote:
> For your system booted with "base" and "revert" do:
> 
> echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> echo 2300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq

Alright, here are the results:

~ # echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance
~ # echo 2300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
2300000

Base:		52.5
Revert:		45.5

