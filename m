Return-Path: <linux-pm+bounces-36213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE344BE174A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 06:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 533F04E4862
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 04:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55504216605;
	Thu, 16 Oct 2025 04:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0GjQlM9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8E8488
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590651; cv=none; b=gknPCcN8HgXvU1IsTWGJ66SxXgU6qkMOVhjOBybOHUcnkzTVQHgvqcUHeOTrgGWkU3KYuMradXPzPEK84h5AtMbVMaaDEgK7ekd4FcmA5qc9eAS4hjiaBizAFceyX/UcAivd6qqrOG8cpTcHMHGko4v7zNx3+vZyZEf0TKMoQhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590651; c=relaxed/simple;
	bh=ycXwIHSULxLOKelyoMw1kfz4fvZtlHOxyQBUEQvwH1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGXIwX80x/YyroE0VcKY3wzT8Vbntp/vbMH9z4P0kzV0Le+6TdgwhOBkjdPsSsNL5FydjNoxE5C2R1+RE0o/6qXHhdOBUZ2M3ny8LMYr0hAJ+pZA1h/vs1gkR7Xch0xso9HlxGX6GjcTfeRY7ohqBE8BgEK5LNNNW+nBSVDKI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q0GjQlM9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so171862a12.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760590649; x=1761195449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbio/3Hp4DA4Om97Ada+C8lyoGbDCkIRGtSA7EfxlAI=;
        b=Q0GjQlM9DIG8TPbPaJDwaxYjFLwfRPrNMu6TdtNLxGOUUDeUfxoXGC9eKIq6naF7VU
         KzvHV+6ebUfllk4C+tuEZWa3c26U2VpzgtOnILmVRxZOK/KJYMrYvQE7yRIG6OIppZNX
         jcSDLgIOkP22qroDn3zITx2vHjjJjkuuMX4U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760590649; x=1761195449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bbio/3Hp4DA4Om97Ada+C8lyoGbDCkIRGtSA7EfxlAI=;
        b=dV1SkNArWBgIa+8naisSonCR4+6xECWo2vV1dbEycU00Eegq+0cV+pIAHT3KzDoc39
         GQrWs13NKYGgt8Ge5lPbRBWS6O8Cnt6OYEaKqz+mphOEUie5BnILjW4SDONkLSXvm0+0
         Zq4b/H+fauvv29w05HwvElwGb3k/o0RzzjcsCcnU6th+S25Uvk4E3HYz0GSG7UkXaAr3
         6nAZZ4AKPjCI7U6W3T/2iXCM+YOFQ6S9RfxE8JaWDEb1Sd9oXCaT8nnLjorPyUg0cRdy
         s+/W5GrGNt2w2nf1MAmCt//RsKF2TJZtHqdoEr4JAMVeIRKU/6o/Nken16ecTb9+jJ03
         GHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSkJVFTN8Fo2Zgfm8A+ROdtsz7qddUqM/LeRu2Ly/Y1pbkXaOVxhQSIF0ctKdJIvYoU+t1VNdAFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUU//4Jv8KKcvQwSSNm+XILVN88nMkFxmvd0ZZRcdgddE+w1xE
	uPZzi6VcDVw8xwCFXG8UllehsaNrLMprsLyVrDlWjb0NpkoRMI8msxO19Wx5BrQ3Sg==
X-Gm-Gg: ASbGncuJ4fetoyNV7A9MKyqRMZlu/h1ZhIZUWsV1yibQpDUgx0+J0njIbfjcnZWGHVs
	syLIHLkPcTeRTyO7tQFDadhEaTenhBxLbEjrcX+E2Tfv5gRq/Ke5lAB6tcSzu332WYsJeYiHSCY
	Haq9mKDfpcTnQNEMBZJHBwBeujswKFR19I7MJSRw4GgOftEhGePez0nizf042OZbAkDZIrjrCYl
	Na1Ok9eWaUsM2ZJSnXkETCIvvjT9Uwi73G4CjQTvHPwfQbJl93PU9XmeNZbA3eW8rb+Vs+4DjCJ
	NE9rmgY0gdap3LXe1JS13MEySCsnFyrqJp945I7g0OPOL6V3/YQxMPUxrwmFJvSolEPBZN9noau
	YFCY61WDNaw4KaogUDp2SNG0gosBV8FVCrtInL1Ns5JPKZ1Xq2gDTiM+kwMpus1Qb3JliRKQETz
	mW654=
X-Google-Smtp-Source: AGHT+IG6pV6T3EqWizlYJiSDqOG3iYJ0VWq5XBwemEziGJYiTELwOGp/PUZsKzFN0fJLNllV3149Lw==
X-Received: by 2002:a17:903:3843:b0:24b:11c8:2d05 with SMTP id d9443c01a7336-290272dfc42mr385419215ad.45.1760590649069;
        Wed, 15 Oct 2025 21:57:29 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:18d7:f088:3b2a:6563])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343087sm14450085ad.31.2025.10.15.21.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 21:57:28 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:57:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
	stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <t3sh2ifq7bdykxjejk2uopra76xp3fusbk3rpbw5aojmt3hjnt@o7djv3dntbwi>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
 <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <CAJZ5v0ix7zdR0hJqN9OZPGp0oZMD_mzKU48HH1coqHTm7ucTDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ix7zdR0hJqN9OZPGp0oZMD_mzKU48HH1coqHTm7ucTDw@mail.gmail.com>

On (25/10/15 14:31), Rafael J. Wysocki wrote:
> > Please find attached the turbostat logs for both cases.
> 
> Thanks!
> 
> First off, the CPUiD information reported by turbostat indicates that
> the system is a Jasper Lake.  Is this correct?

Correct.  That particular board is powered by Jasper Lake.

[..]
> Something like this may be induced by RAPL power limits, presumably PL1.
> 
> Do you use thermald?

I don't think so.  chromeos doesn't use systemd.

