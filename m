Return-Path: <linux-pm+bounces-36537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C8BF4890
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 05:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A2C407A72
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 03:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE111D6193;
	Tue, 21 Oct 2025 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MMROzRBj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79301487BE
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 03:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018322; cv=none; b=JvWKXZFKVex7xH8cEA19+b2nxo/X/wG9EKIe77ZZ30bypSrxxzVqlvvNNoA5X9wP3kCda2dHk53lbamTtg+yO42s3nMQ/dbvANSHCzhzTWiJDS2sjdwKm4jfOj3Iz+ao/+Er/Ada5jB6m/3eear63vdS2hDfqcOWkoDDyTcSaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018322; c=relaxed/simple;
	bh=VutfssI6qKCEbMppqaBHbdfMNvGVt8B87THwkbQ3q38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n17LegU1KHCi79Yr4uF0cWSZpSpwE5X0q/TrayiqxA99oBEhfhf9SXhkL/AoHHPqhTPapTTwvh+4BLs1TV9Lh6LKRWUUoloYOgRq3zXkChImndomD0aoDoBbhvIfQ/tiZqYxinswNAhHAMA9odzwxnSqqtLWwI+4/0biVq/jOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MMROzRBj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33ba37b3ff7so4802148a91.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761018321; x=1761623121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJf//7sAC/ag3LwWhj798Mg6XcoigCVTC6AC6dv9wJ4=;
        b=MMROzRBjsMFBUXyn8gzen5jH2kc0A670KM5Am+ALzYXjCxmgy3FLtdkY3bRpUi46/7
         SANFIoVDTAUIdHg9D9wcgjNbTiRsjwOGaSuxyJvqtHxLAG+0bACy65gL+6BGhmzqIr31
         M95wHnyBBtOpyZG/LY1dOZ7Mo2keNUm1E/0yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018321; x=1761623121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJf//7sAC/ag3LwWhj798Mg6XcoigCVTC6AC6dv9wJ4=;
        b=ER1qbu63s/2ZVnT/iL0yTbyaTlWIdQov0IfiNDiLEvBnClTI2Hvax1O2BvqGkYTmpI
         3Pyj7To+EzG5eJbdfGD5ISLYQwoQg2Qjiivrzku2XD/Rid2iZYJ2ei3OaMJvIbks9iTA
         IbY/oYNlR3XmIpARlF39AyqPEpZoQYbU6mdYU2Xn9veeiWQWr0OmR6GfiItU+IwwuNU5
         QnCEw15Y133IprT9JhUe+BusqusJ5QWTsYdUDpaz6U4i9kLJgvXmDoGevBnQmQi7VeGi
         +BW4Gv2zzmSul7vkfv9CB1uH166P06kmRKu3bTJiJezhb+ta+y+n9Dm7uZNyrTLMK7Yp
         76Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUBeo0tb519ga/n+8lKfyMvJRSQIICzySxfWN1MKNuP4tYGurQUa+St2G/1Kmo2uiw312TY6DBj1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4jFz/w77T/XUQYuQpQv2/3MAs5L6fxE9bagb7R7KrCzextxB
	FSlykcVt78GMHwEzARKfJRNIJ6i6mZlSLNTCCzDw0C3RGTfJw1MzZMw9hk8Rf9ZV/Q==
X-Gm-Gg: ASbGnctRM0Bm70G4ucDx/gR6sm8hSIFSkgOAGnREGzJ7/qT7KsoLla2oYmY8TP11ZUt
	m3Y5LSVWO+wNr6GsA5g7T89EJkL9bz+59TWuqHSEVwxuoUgvngadtWxeUkyRbiVuBXIHjxgUiHs
	bHipCM/gZrvCDWFgfrlbf0/nnu2jLYOhh8hiBCXcE2/urjehPymog/RT9Q9hCEw5216/vwM7co9
	1m1ZiRnQJpKSj3B6AWu2xOEMXtw1hUu6juWG0OpvDZPSTGGz0oETdBKI/8OTW17fBDbt2gGWw/1
	S6mGHRwxYxitLPhqLm3hL6Rjs6f05nvdUKPjc2KsccGzEm5eCtjjM1VHsn1tb/OYoNXQIiIlkun
	RliVY/sG8dCVHeY9//4ZjFfJM890BF41OrzKa+76Yilzs4dVFOVpJmtD8VdeWC0RUbFH3iWtdY0
	kR2n4=
X-Google-Smtp-Source: AGHT+IEcVfie/cU9hK86hVQEDzdIqKsmMm8fLZZ/416YCVXxsDETHB3xmUafin3LJdnPj3e+3Wmi4A==
X-Received: by 2002:a17:90b:5868:b0:32d:fd14:600b with SMTP id 98e67ed59e1d1-33b9e0a4a30mr27344576a91.7.1761018320802;
        Mon, 20 Oct 2025 20:45:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3364:b517:9129:5413])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de11392sm9688130a91.7.2025.10.20.20.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:45:20 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:45:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, 
	Doug Smythies <dsmythies@telus.net>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
Message-ID: <ndxgcsseqab4fqxemwscykintho6t2pjjqg6nkihcqlp5aesc5@7a6kxqjcfdxq>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki>
 <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
 <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
 <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
 <001801dc4041$607c19f0$21744dd0$@telus.net>
 <8ccf53bd-81cc-4c7b-88b5-5d7aeebf2c3f@arm.com>
 <CAJZ5v0ijNkUQdTGRUHRUQKKeEzCR354CGkf-L2oUsG51bnU5oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ijNkUQdTGRUHRUQKKeEzCR354CGkf-L2oUsG51bnU5oA@mail.gmail.com>

On (25/10/20 15:18), Rafael J. Wysocki wrote:
> While it would be kind of interesting to know the test details, I
> don't think that this is just one test.
> 
> Sergey mentioned several different symptoms in his initial message:
> 
> https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/
> 
> which kind of indicates several different tests regressing, so this
> appears to be a whole-platform issue.

Correct, different test scenarios:

GoogleDocs, VideoPlayback, VideoCall, and perhaps some others.

