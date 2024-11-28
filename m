Return-Path: <linux-pm+bounces-18207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D040B9DB66E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 12:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0B216401D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 11:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112D197552;
	Thu, 28 Nov 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oDrB7OT4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C51922EE
	for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792975; cv=none; b=c2BeFndW9dBfK+l85N6YrlqjFVATNTi0sJ34fsAOhN34f7O7WYxZ7o3mUare3nZhA8kuCxwLYiC2Qecf8gYg9Jz/MuGP7YD94cFGM/bBJM1gL8qHuca3ZnLdAzVZsFuBfW/Wa3pT8kyQ1NpbKEnSBSKzZtb+YKtalnc1kRR5Jgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792975; c=relaxed/simple;
	bh=N+FnFOZIluj4zPhoTI/4zAptkY4TE3BF6majq5p40Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDmMHHaDF0warbsOTZ2CCfcRJBdb2m7TNWjzEIMyyrpGV2IuVSM1Rs/5hpWxT8eeII6G1ML3z5sj98I63t8PAQKFzWD/GE7zYogI5J2KofG8ZrrvUuyOYDHJnmfA+K+plu7/ZZsx7lpnaOg6OgJ5PFSEqtldRb3l5EJb6pCWvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oDrB7OT4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fbd70f79f2so635864a12.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 03:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732792973; x=1733397773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+FnFOZIluj4zPhoTI/4zAptkY4TE3BF6majq5p40Qg=;
        b=oDrB7OT4QTXjwXMLO3vsChNb/aR8LxQYNtJ0RXEmS7r93D7TvK+0j4RlB9EJiwzWUy
         gffrqlzRsxAPuLSEUJybAvVcAR9hZm19rG9m2MbSKqywK6Lo7T6C6WSvGTmDhV2UBLGy
         /+kpQZAOIcBBklEQ1IZCo+hvSgTkV7Z6pnir0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792973; x=1733397773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+FnFOZIluj4zPhoTI/4zAptkY4TE3BF6majq5p40Qg=;
        b=h4CFixKZ6C/SwaEfQbLiH3FkYOqDgaeaN3w3cOi/Z6CNPGoiieRu900d8MTwAcv9NX
         k84gDckLugfacIBButCYDvMDMl/pIwjxc4kBERboC4b5MghYgLP+1jNl13vEll2PKZ+J
         vYs+mj0qGxLz/G45xuGOUYobq227/A0OcnwS/WRN+eizZ7KLlQV46HG4Q2Fo1kFRMjSE
         txiFYGbYh+whUIRTXBpLdV8a34Iqi4IbJxm4v7QQa7htvCWtmcdGf95RzaaAg1RdQWi1
         a69Bgz+PeGbPSFRvF4CmmxTs2Pf439hSJ1H5XWZlWjGBAG7mLBoDIriZWr5dJ2FDDA2M
         E5xg==
X-Forwarded-Encrypted: i=1; AJvYcCUWPJ/79bHsS9Atqb2CP7Y3U0Ga1bhmY0fXD7+a5q2mX0ADcgsxoMwFRLAyRyLpmIEB1UHPgb0t0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DKNoq/66aItGuSZAEv+4Br20pHtwyzUcjHLtR643S3kL4yr6
	10PT4HdGxoL7CABw7NeIg77eFcfeKvJkdNgwvFYvO5xLK/xKrgUgvZCvEnUTkA==
X-Gm-Gg: ASbGncsVkALhBqmTJJYkBTewLWR54Y0EJw+FfenwWaV7zTGz5vJqi3PY/JWhIX94CvX
	zgetT6lwsetXDVt0sOgOoLqRO1Mc53Hyibp24Cw1cxh8A60OCGC584AvmG5aKRAWlBanvzddNdI
	oBOseVSG6L0HEr1e31N80VJbX+yiZT2NAdzMFEJ119pa3GtS1wTh7KnTVdYlIHFJv3Wc8h6d1Vk
	oyW/OAjiHHufNWTQHor3Dodfx/kGaLBu9OPDYZIUofv+w27Jv9yoA==
X-Google-Smtp-Source: AGHT+IGSK/XvZKOFB2ex4RHOYZmrSnGwNNSIjBIo7jknMLWkQqro0Oiu2YcbIKyXVIhkOWowiR133Q==
X-Received: by 2002:a05:6a21:33a7:b0:1e0:be48:177d with SMTP id adf61e73a8af0-1e0e0aada5fmr8200732637.3.1732792973006;
        Thu, 28 Nov 2024 03:22:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530753d15sm4336945ad.52.2024.11.28.03.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:22:52 -0800 (PST)
Date: Thu, 28 Nov 2024 20:22:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: hpa@zytor.com, peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com,
	rafael.j.wysocki@intel.com, x86@kernel.org,
	linux-pm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: bisected: [PATCH V4] x86/apic: Always explicitly disarm
 TSC-deadline timer
Message-ID: <20241128112246.GF10431@google.com>
References: <20241128111844.GE10431@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128111844.GE10431@google.com>

On (24/11/28 20:18), Sergey Senozhatsky wrote:
> > Disable the TSC Deadline timer in lapic_timer_shutdown() by writing to
> > MSR_IA32_TSC_DEADLINE when in TSC-deadline mode. Also avoid writing
> > to the initial-count register (APIC_TMICT) which is ignored in
> > TSC-deadline mode.

Upstream commit ffd95846c6ec6cf1f93da411ea10d504036cab42 (forgot
to mention)

