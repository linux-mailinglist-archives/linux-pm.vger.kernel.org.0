Return-Path: <linux-pm+bounces-37013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F5AC18903
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 07:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8663A3F04
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 06:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1082C3064A9;
	Wed, 29 Oct 2025 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXKtHUfG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7D17A2E8
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721032; cv=none; b=T2ySrwFrudyI0BzhjQRM0UVXJ1lcRSW3xl3iJDMIvOMrO25mpnLMby/xV0X0q0KL/LXV2qgU3QscNojE8hM0h5oy/mW7D+WY0MLIwccXXMqXZaCuTVbQ1wJ2Fn72fl2U5yFqIKdS6XgUAqyigK1x9f4ner2zQnoobbSp52kgJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721032; c=relaxed/simple;
	bh=ok9dT4MfExQ5WiZNPWfHGVmnga3L7bykmmPx2qnik9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ/sqqYRlsZQaSNW2wywkEpJNyHupU2Jozn4TQnnq3gvJn0ri9stCrT+Wbdt6JLS9md6//Vfdvaq7Z4Dhf4l15lWBwqFFT5dNKNpXAOri3SEPYfI9rIyZefT5G9Te4NyVFsZuFVT4qXr4ZEW2mYUOTNRhIy6eXlTeHdC2TqBDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXKtHUfG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29470bc80ceso9414065ad.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761721030; x=1762325830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAzHjA1DGMw75h1oXuHrNcgI7jwtDfH+p5O7whoKqeg=;
        b=iXKtHUfGYI93jMssXQ4yZG7kK3WlaY57zDUP0fw2MwGzYp6j8T3REKmF/NYfOCT7FV
         TcJXxveSlgIctPC1rJMsYUfrwerby7GhVgxkG21WDAxSBuM+jOp+8SUoWTGJs++fqjyZ
         HfGmXoxBpaqlFBDIjbLxyY0qb7st5ioqYRe5qGhwti/TM9EzJzvGZkjsXmH4yQeKfVKe
         3XiVD8JgahGexJQ7Sz/T8WUeRyz7Kcv275BBBoUJLJ9Ngv2Uim4bxM53c/frL7ITVNT+
         l746QSIB7GvNnmf+4TN76FoGMu6ShuAaiB2SY/S5i8Ms8+lfasYc6JdDEOKBy8BBZUM/
         0irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721030; x=1762325830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAzHjA1DGMw75h1oXuHrNcgI7jwtDfH+p5O7whoKqeg=;
        b=JuDi6NXnSl1JMF5Ij1J+W3ne0zUQc+iy+t7lNFQ4iYsNjrvxlbUQA5rCcRrLwqE88f
         LN6S4ZsaUW9Y8+8txbPUOkSEkkco6tPqfCWIUMk2edK+Q+lD/8zIZ5aHTSynOJL/SpcF
         vZ6pMW7IGm/90kmY9gPbDtuOTcLDnRLtdIN0uXJQzY7Ly6LPeR1Dh582DQKx+4qL68GS
         ix6xxHdsNZh9WwTRM/ZGj02tJWxPRXI5BA3XMt5b+ZjuIa1LOyj5pkzYUSXSsmtQEEhJ
         UyENQGUzUgvDtpl+KxuS2l/Tmu1IwU0eVz35TIUqQa/DfMz72boXxWoWv0uHVkVH863K
         WTIw==
X-Forwarded-Encrypted: i=1; AJvYcCXu/PQD4Um4h723mucm160OoNE/IUMi90dbnDJEopSOM/fYYooqiyX0VV0DAbHWH/Jjx68c8C/7uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2cwboj3y/BtxoOR6mLpiH3ZW51SZPwYbOgXVq4BHKoVVmUHlU
	vlIRoY7LbQMy6DbNOtAvf2E7aFi18uH0ercIX612vM858ILuOKpYRpZu
X-Gm-Gg: ASbGnctQ5dAxZ4qP5GffMWTbRYklmPg1BS0XaFd0z/H9LAVyEIEehhAugregsvsg+eG
	oNpLZWsaXURCTwJmEAxFiDbo84HeI/KiHgXSF7LYm/8LgyxS3hackjxXSypbMNNlOZwLeIEmobY
	n5iLBtdWiOFUbvXdIjKYNuHQ1+gjY/pkrzsicB8MP925Uuv2tglw7ycOFAWixALwXpDA9zfpilF
	he7wNJuEoPHL3mnlvdHHLVh+9ilNX5nWIG1JT7HsEPojuNc8k3UawGCEWO29HfjlvmL9NhhWgGD
	BQ9fEKx6OAzBYzXfYJvYZx9/Tq3i95GMQS7AyOSG/zTvKbyNpEbfYpQ9AvigbR7OYQ6DVMUTA6a
	Gs2Ao9z6UEp/tyC+TSsyFnZ4qblbpxojAPeLXgIhDYDsGtWnpPFiv6TXG6w9JxfhQWtr0VPy7Qq
	Yb8uqgEDE=
X-Google-Smtp-Source: AGHT+IHAyxSSOH40p4t7F9MwgeCG/5rdk7C1zelhSNkfw2jl6rNnp0o+7NhxcY4tilgw3gjqSJR7Lw==
X-Received: by 2002:a17:903:1a28:b0:293:639:6546 with SMTP id d9443c01a7336-294cc7538c3mr72609105ad.20.1761721029610;
        Tue, 28 Oct 2025 23:57:09 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:32e:3ee0:36e4:46c6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed807dbasm14531229a91.12.2025.10.28.23.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 23:57:09 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:57:05 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, jacob.jun.pan@linux.intel.com,
	jserv@ccns.ncku.edu.tw, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmon: Fix undefined behavior in left shift
Message-ID: <aQG6wTDy7Bnf4XDI@google.com>
References: <20250901144756.1179834-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901144756.1179834-1-visitorckw@gmail.com>

On Mon, Sep 01, 2025 at 10:47:56PM +0800, Kuan-Wei Chiu wrote:
> Using 1 << j when j reaches 31 triggers undefined behavior because
> the constant 1 is of type int, and shifting it left by 31 exceeds
> the range of signed int. UBSAN reports:
> 
> tmon.c:174:54: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
> 
> According to the C11 standard:
> 
> "If E1 has a signed type and E1 x 2^E2 is not representable in the
> result type, the behavior is undefined."
> 
> Fix this by using 1U << j, ensuring the shift is performed on an
> unsigned type where all 32 bits are representable.
> 
> Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

I know maintainers are busy people, so I usually try to avoid sending
ping messages. However, this patch was submitted about two months ago
and hasn't received any feedback yet. It looks like it might have
somehow got lost?

Regards,
Kuan-Wei

