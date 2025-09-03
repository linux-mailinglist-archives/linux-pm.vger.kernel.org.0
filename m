Return-Path: <linux-pm+bounces-33759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD9FB429C4
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01077684C13
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0B9322C78;
	Wed,  3 Sep 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="absLc8px"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE42D9789;
	Wed,  3 Sep 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927339; cv=none; b=SHV8VN6kJNT1fnaBzw+XJI1Y84UmlqfYh+BHJ9HR9pkJS1RcRg0rS2ZduLe++4pj3vg9SjoCIcutM2VYHpz3l4dMfKH4iuAHjpxWMgDmZSskyqzNuJ5Z9JgADJFJer70H6YsgU56rMXSRk6KQ76/tLhaz0wEVFpji6vK9QiHGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927339; c=relaxed/simple;
	bh=rykkV+aIo0HAPne2/nU2ZujvLiZiMYmAcJynKMLa6gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZZeadYLS85aHaaHxL1modGl6XTNoAUq+50Q85MnzFSwErFRw4GSRat0YmpMOyMF1EXSAIXTtnGS2tNZZR6r+dZf5mrTlnIbgCT82glVeWhMcJMrzX6tpQazVmBUAA167Pw5SuYA73pFtjnlhBeor1/2Mnotc4CVUdZ6mYNAh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=absLc8px; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so35409566b.2;
        Wed, 03 Sep 2025 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756927336; x=1757532136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L5hErnfofMrsL0rvB3tnJy6h2xcJ8CpBYIwMkGlraO4=;
        b=absLc8px06Tj7Hp3gv+pu6wMMleS2iw15b43UKwfSJBYWSHQouVkxd40mQlbyQG4I9
         oRLVEH8Jryv2dm7yqgikRgNlKeK80XpHei3uPQyc0ONmT5GcGnxhxxk4um6ugqyb0Yrp
         rDtoMksUmC7MF74z8pw6eolpLKwFT5GaIo4DnMBe0s7yRAz7Ip0UVMh/bEWlHSKU6ndi
         d3+OhL9RPTpjs6P4SNo4yEW8cQKKZpiBODxJ+J0z63uSBkQpkJucSNkeGXirKl6sPvrS
         2Y7cFkMwyYopf9psm86cxcjkjbXBw5uaBGO8qxWAbJv7CWgpGURcouNGkhWT2jI8WxQw
         2gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756927336; x=1757532136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5hErnfofMrsL0rvB3tnJy6h2xcJ8CpBYIwMkGlraO4=;
        b=Ct5kIftZEOgq+noq49hR0QWKEss2SjVjpTeu1t/HI8Dp7rklPXwCLPpFBrRvImETMv
         vBZpZuUXkDKAeLklVPfaNjx774yGSHWdexAYRCvhlC/RJ6A0qbeOFlq35EBJLHuvL5zr
         w2jpdUZVMHGkrzxbJV50fS/zSf+DA71udyKy/lyQGcvi5pJtPrrFPDyjqxS4m6Pvv1hN
         zWUREUcwwlZuca5cBQsUWfCf/5zFzsLUjES06tOVZtvrf+/ikEeweKGgqcIyBpKSpthJ
         aqMSZSd8zJqJNVDx74I4jaMALX/78VOwxNkHgsj7gsCbolrxeZnn7BHegQ+Lg2KTiPm9
         Noxg==
X-Forwarded-Encrypted: i=1; AJvYcCWJqxgPYhT+2MAEb5K3UrlGakpgcetXzDGexZGhjAsUKYpvnkJwjJBUNXv2sx/ihqJUOsm+n4S4DKSe2bI=@vger.kernel.org, AJvYcCWrO8enkIkm8wAV9qTsDHCNqkMBMpjMTidygOOvexewVpswKDDMf473LqY0/2ZF0j1nB1IIr4Tk6OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9VK7RUYVxPm6kJGbuRELjsqvUw+7WQIJ2Z8DBiXQxwU0mT5A
	MczHDAk65V0Ver4cRbHTNK2YIvR+FuI2W0G2H1Wb+ZAxKQU11PMh6Gj0u+cYTLUm6NY=
X-Gm-Gg: ASbGncuaH632rgr3KDmtvae/fbKw0E+++Uv+0LRzgC+POXqN0ycOITQrNEAs00vcwVx
	XdSFiTBVZ1O4y8z5oonlOpCTGp5rTfuLpNSwjSTL6d2BE6PI7rlnj3ma9rqxCWKyckMB9+haVjy
	fLQM9hudnl7K/mc/9GWtFuHFQTDfC7HmxIDWNsaBtUyfbfirAJVYYCU8mXbq6h1mRkJQqYl92Lo
	OamZl78Lw14FseSYqh6y875nYRED1UyJqupk/3/sutXfmXT4WXup2SYwgEdSy0o69dvPRbPaxB6
	0f3QIpnX5X+a8ejVC09xFVZd9jbfuibtWrdZwPSeA3DoeorAFNjpulaokjIoyK3SgO4thAxpYox
	kcVWPTD0r/wC5d6MAohtBEo4Z2SUaAjd0sCpqSOEAVHu41iwtEXilPQsuR2ljcbOZ0Zs2EvuWFY
	a1FSLZr8Gw6nhe
X-Google-Smtp-Source: AGHT+IEeezqUr9fOV+VRXNcpCXANoGRtDZemK7RiaVtFwKS2NCo0HPyPFOYQoPA/+YXkdSPf0kSpHg==
X-Received: by 2002:a17:907:7245:b0:b04:76ed:3ff5 with SMTP id a640c23a62f3a-b0476ed442bmr148672566b.40.1756927335680;
        Wed, 03 Sep 2025 12:22:15 -0700 (PDT)
Received: from XPS ([2a02:908:1b0:afe0:5d6b:7d4c:ed7e:88a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b02152cc1b8sm1147287666b.36.2025.09.03.12.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:22:15 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:22:13 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: hwmon: replace deprecated strcpy() with
 strscpy()
Message-ID: <aLiVZWY9J1vdp0CD@XPS>
References: <20250901150653.166978-1-osama.abdelkader@gmail.com>
 <CAJZ5v0hrKBNxDeZOKpUXyuZV7LRUX4ov4ifEGDtNMrA8km6uOA@mail.gmail.com>
 <aLhK_zMvtkdCtsHR@osama>
 <CAJZ5v0j2ooBwnPWKjXGyYOOBtjs6zbAh-+jaUaV5u7sBi87+Rw@mail.gmail.com>
 <aLh62dIWcHtWv2uj@osama>
 <CAJZ5v0jpAm-KrS0k4be523ygbRMPjSDGgNas7ipwpd9kKacqKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jpAm-KrS0k4be523ygbRMPjSDGgNas7ipwpd9kKacqKg@mail.gmail.com>

On Wed, Sep 03, 2025 at 08:36:19PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 3, 2025 at 7:29 PM Osama Abdelkader
> <osama.abdelkader@gmail.com> wrote:
> >
> > On Wed, Sep 03, 2025 at 04:21:35PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Sep 3, 2025 at 4:04 PM Osama Abdelkader
> > > <osama.abdelkader@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 03, 2025 at 01:50:03PM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, Sep 1, 2025 at 5:06 PM Osama Abdelkader
> > > > > <osama.abdelkader@gmail.com> wrote:
> > > > > >
> > > > > > strcpy() is deprecated; use strscpy() instead.
> > > > >
> > > > > So why is it better to use strscpy() in this particular case?
> > > >
> > > > Thanks for the review. Technically, there is no change since both have const buf size,
> > > > it's just for consistency with other drivers.
> > >
> > > $ cd linux-kernel-source
> > > $ git grep strcpy | wc -l
> > > 1187
> > >
> > > What kind of consistency do you mean?
> >
> > I mean in thermal subsystem, it's only this one.
> 
> So please add this information to the patch changelog.

Sure, I just sent v2.

Thanks,
Osama

