Return-Path: <linux-pm+bounces-39395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6BDCB1ECF
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 05:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B597230AB444
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 04:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A462773EE;
	Wed, 10 Dec 2025 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jr8FHh4s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F47224240
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765342120; cv=none; b=owYWPkgzO/rChL+fyK27HSQg17y6X5i8f1riH/GmZS0KZEcX4x5ZyZBs+vGhFq2fBuGW30mm9drGetfhc3kBiNVy8oTBl8JaQVaX8/u9UBby6rILf2PJ9htwkxJx8ENtX9DP2zfO4v+uwjsid5JDdexHRd4nQQBOZUL/CsphsWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765342120; c=relaxed/simple;
	bh=P54ccrHuyIwLrbnMEv0y0zJlMDfcrog6JMX+7J7k9CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocfuCGhFDnxm0PtXYHTy2sVIsNMM5D2ZTrIBIoBw6oxPVVvZT0WVbhMqMRvWXaXE/irnAexHA3s3+FITEbhZ4YVTvnOiQUbc7RWLx6cO9yY1HtP5P4I+O6Wh5YaCn0noiS1v9W1NPDie6yF/uol4Eeeb7AkIPHRKKPNHUaGrORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jr8FHh4s; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so5353256b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 20:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765342118; x=1765946918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GvyeZQdAqlK3B3kJnMLsbDXQhJSBs3gRq3FYfwJP/o=;
        b=Jr8FHh4ss3kiAwCKrMcp3kt4uSJMpQVBGwOQXutSdakBAok7IWUvRFcbhTXgETaA//
         s1VQkirEknxoLnq6NhY81IIkPDonD3LiRoJs3VSrReXp8QyL/gSfdU8s6oJBCnMGXLQW
         tcg56k590TCNFebgHo1jpqWKLqsNOY2lrrISa+VZCQ1ABMK91MaVm1NjRJnQTmQjeBGB
         BLxbofvLJE3BJwPiI6UbggK9FNVfhIGEZBAvoCwTMh2I0hvCFkGD/4oCrkM8RXL2mgZ1
         cP35R3X1kh92/rkR+vyAplFL6xge/C2NAWI0Dqq87s2dgeLjqeX7kVOOl+JWQ/PtKrrF
         LNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765342118; x=1765946918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GvyeZQdAqlK3B3kJnMLsbDXQhJSBs3gRq3FYfwJP/o=;
        b=wlAyPNSBT+u/xvSgh/GmkWSswXKBaLuErjGv548mx2eopRGKtF0yZFMgTF5jqWOHrW
         rsphFD4iJKeguq/yX2ox0uqIi16DQGv3hBy2yTNVOsRzH4Q9xUJrp9cwsRhcyFd/i57D
         Nv1NMvLz/w2mCrH6SRi/b3DthPdnrxMLLA/LX8tc589emuHQC1oqWC6cvRJ67stJAIQH
         cwm+Ltn0R4LHneM5sjtUozHCbNg+GMEC0yOPEP0y1BVxTCf9N801YtRVq/oJ4dE6Pnkl
         rzHyXLIQK1oQK3h8CcJfd1VIKOrHnHq9YT4/GpDgQgpXM+LtoPWXt1slt1DLUTTz8TVs
         NlaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCSISQQp9btN4BiXVNfbKdaxZNbgZ4UjoUfNKGo15t49AnviYVW2qnPkADyo6Qz2cA61mrU0+yCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DDeF510Z/+03q51w20EdQ/0LgjCWx092ZI5ZmpMBq0qw+GdX
	MbktvK/RFfKAqwC15cpPfE/wJYdplCTvokHvAApM/DurNtN8rNGuxh8rlaLuUwbpj6KRhG1rRen
	muPm3
X-Gm-Gg: ASbGnctF3RMFFdQN7LQv7M9Rl6UIX8vH4sLMJAig398oyl6rSmQnr0vJsWMWnoITABX
	+rlx4QpzVoCJridcJzEWsk+v/RkI5hmPpecPuvnO0ndq5TISry6i7l5Lv9Myr0Kz+afbs9fmrgf
	ESrxCdWCduvQyTWOmMcJ0ifdGGEhHaotFYklfOv2qlJcTDgADpYMtXm/9HC4UXh5LwiCO/NiZQc
	iLCO2AF3JEsdO8azB/Hbt/nKSyHSuzr99H+6yKkh1U0ScrbOibYwIolfz0dhs2w/QYyc4ya3pQp
	XpUtdrEXbkw4tsgzMVkHpJW0U4+4YcbCCwclOqP6iUBIIEniLJuZp4Vw5dsrzs3sz44eOgpmvcm
	D9uDWCujBcfgXSaiTqXlDrPahIXJiV7ew0aRdjCYe3ucvwQnIcuN2RK7N/nVKsXu2T2AR0s/9Vy
	QbS7esXYaRrLM=
X-Google-Smtp-Source: AGHT+IFW4olonzDfaJ8jrZC0PFE/s/Z4ygA41vOb2lzWIvbF7XbI4WeF8W5Ss3Y/pE+Z3uRx9DfzGg==
X-Received: by 2002:a05:6a21:32a2:b0:358:dc7d:a2b3 with SMTP id adf61e73a8af0-366e24441fcmr1109028637.44.1765342118223;
        Tue, 09 Dec 2025 20:48:38 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a7000c984sm1056651a91.6.2025.12.09.20.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 20:48:37 -0800 (PST)
Date: Wed, 10 Dec 2025 10:18:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, Michal Simek <michal.simek@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Pavel Hronek <hronepa1@fel.cvut.cz>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: arm:xlnx,zynq-7000: missing CPU freq in /sys after
 6.18.0-g8f7aa3d3c732 from 2025-12-04
Message-ID: <grlujzufqwttr6f4haoa6s3c2adqz7eo2fokqz57w5xdqeufwc@c2g4xg7e2tiz>
References: <202512081758.02574.pisa@fel.cvut.cz>
 <6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz>
 <202512091447.26580.pisa@fel.cvut.cz>
 <nitrtsck5moqc2xfovcgc2tppkbfd7224jb6iaezetjgfjmvjf@hhdr6hwqwknl>
 <02ebe8ea-d3fe-4bce-bb84-256603ad6c6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ebe8ea-d3fe-4bce-bb84-256603ad6c6f@kernel.org>

On 10-12-25, 05:40, Krzysztof Kozlowski wrote:
> I did not get it...

That's what I thought when I didn't see a response from you.

> > Krzysztof can you provide a fix please ? Or do you want me to revert the patch
> > for now ?
> 
> I will take a look now, but I am at LPC so I am less responsive.

Thanks.

> I did not get any logs though, but I will take a look now.

I bounced the email to you now. The issue is simple though, the table entry
doesn't have data for them and the recent code changed the logic a bit
unintentionally I guess.

-- 
viresh

