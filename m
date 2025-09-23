Return-Path: <linux-pm+bounces-35239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB5FB96CC5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79ACA445FB0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA179322C98;
	Tue, 23 Sep 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYlLQxu4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8531D733
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644467; cv=none; b=U5hFiBWLRTD+MECNwKouOsIsCrTR/JwGS1oBaC44+eLfG1jUIWsX2gBOTHmhUqzHg5FZa3O0L/0yCJBYvSj9sqnjSazGvJMzAR0IbIEOVkg+GXJHndwK09nqvq/8ZyHx35UP42OAZzUFcYDrneX5kUfy1XtoYrxlOlvHDhNDT9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644467; c=relaxed/simple;
	bh=J0zYrROHm59Kv9l2BgsGDceHqwDg3Z4R0dFjaeHFHxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTlTzYpW8Z2joWzvCAUgY8Sn5uUpcbyNogctaFh9lqV0Hs6V02QP9HdzaU/r2gVV42//29MRUidRERT6lHZ7EDzmICLAJbIdiWZdqPwe98WqRQaM77JW5yUtwrSX244ZAiUKuVMYhiupHZLNSPBNXWXLByvVJibdW5wN5m+iTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYlLQxu4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2681660d604so55402685ad.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758644465; x=1759249265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnl623znH7NUrxrG7pcJc4egYSbH0ZUgSosdzvmTRxI=;
        b=GYlLQxu41QDtn0MY2Y6kf555vHpDfdBb3Tyosudu92UmJe3Q6aDuCpl3MqPzPKlHw/
         Z99u2nb07FpxCzjDCDu6LXX30FPHW+TDQL+V19ffXdyvTD+gZBfQ/63Vz0+wX8w6K3d6
         7TCpGfQOxHXht0wToVOGVSFdW1krFshqZNxCzh5h/yuZgJg54GqCOq0j6w+2+eUcbd4h
         XWid+DL/C8EGluPwh2SMAHBBbgUDAxx2wvyebmMpZOvKiKTIiHTtoEID+otNLLBtCPQy
         MZXf82fWfEO0W4mN8x+ag8Wp8PGwnd/Xzd88D9CAcqJpRL7Q70Ogsut7p6FCbRdw9B42
         yreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644465; x=1759249265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wnl623znH7NUrxrG7pcJc4egYSbH0ZUgSosdzvmTRxI=;
        b=ZonhZGAbdkbWWdDRWcgKFv1AyWuq5v5WMadhVga/+ys3o0Ylg/ta6RfWjJvovdAI/U
         4dxrKV6jV+cpKKB7sixo3PzYjW3rv/JDX9pR4dotvkSMG5Hbj0lbyyyModXC9xS0EZxA
         fXCdzJ7w6xkYP2XRdN1hOV1Q5xAqxcpM291wpvR4zgSNM9SQd21pko44lL3dzfPU1A59
         E04Z5r6wy0ZJIV5XblzIyTvn2XSrsZB407M+uSHNSnRaW1KGo2cdsUzOIoH+NEqMUJF0
         j1yRU2Yn5qRrpH4jnjqYxukjzTDtyLZ0bS/gW2t61cr3nRVaVB32iUupvuPWqFY2ablL
         5SJw==
X-Forwarded-Encrypted: i=1; AJvYcCWYH9L60vQ+X00+KO81x2Ob7L7o0VVXZ33YOk51KfOO6mwTijHyn2nzdBia52Ygh0T9YatVyDmIaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpdUFBkqYqYLRc0WuluPI5HStG16iQ1aa/ZCQOaEcfANl8L25
	lTGNx+Ons/xiRvFcdg/NTFn6TbuY0PsNUP0Qx3+fa0HJXviQAg/fy7Dj
X-Gm-Gg: ASbGncs6Gtw77/ncePBbegbo4vFV8e2ox+AP/v9h3trUQOEu4pOMUIPeXwqu+Z9ZJFc
	LcNunCFgfjLnPdcS+w+L/bXs4gOLbulYn4z8JRnQVDKXEVCYVvHfIV//bvI+hsgxlYl50VAxhkD
	TJTqX7VAI8w99jbMv4anBPY+u7Mbj0Ofy86PdqqBwkUio74PTpJ8DcuqZKF/NLo11eZDw+6YGzv
	sQCxubGaU86oRvk53aVsplPcpDAY23FL8wF53Vi343cnjTfFfn8FWOIJsr3hWK5JuGx4ddlHJJw
	DNNcj/Ldgq66vz0e2XjO8lp/622phA3UXzZTKcH3pJx+wG7xj7AkBf19ZPHT5gS/HNGD+FqSJpn
	T8tJwjihIuapySpWB4OfvF2rRzNz+YHn9VxjSILL+dJvb8gchzg==
X-Google-Smtp-Source: AGHT+IEzcSrcbQzqmk2Gk22qQe56jWZoe9278D+hOsua5qVrCgwiGLfCjvRMvJL9TlZTYKvN+ny7Mw==
X-Received: by 2002:a17:902:d584:b0:278:9051:8ea9 with SMTP id d9443c01a7336-27cc5fcdca3mr37291175ad.40.1758644464728;
        Tue, 23 Sep 2025 09:21:04 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698035d337sm162975475ad.139.2025.09.23.09.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:21:04 -0700 (PDT)
Date: Wed, 24 Sep 2025 00:21:01 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: ray.huang@amd.com, gautham.shenoy@amd.com, perry.yuan@amd.com,
	jserv@ccns.ncku.edu.tw, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/power/x86/amd_pstate_tracer: Fix python gnuplot
 package names
Message-ID: <aNLI7VBQc+NFrmo8@visitorckw-System-Product-Name>
References: <20250824200902.163745-1-visitorckw@gmail.com>
 <75046094-d3b7-49da-af8e-3747ae9ed272@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75046094-d3b7-49da-af8e-3747ae9ed272@amd.com>

Hi Mario,

On Mon, Aug 25, 2025 at 04:25:58PM -0500, Mario Limonciello wrote:
> On 8/24/2025 3:09 PM, Kuan-Wei Chiu wrote:
> > The prerequisites section listed non-existent packages
> > "phython-gnuplot" and "phython3-gnuplot", which may mislead users and
> > cause installation failures.
> > 
> > Update the names to the correct distribution package names
> > "python-gnuplot" and "python3-gnuplot", helping users avoid confusion
> > and saving time for those following the instructions.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks for your review!

Since the merge window is likely opening in less than a week and this
patch has already been submitted and reviewed for about a month, I
noticed it still hasn't shown up in linux-next.

May I ask how we plan to route this patch?

Regards,
Kuan-Wei

