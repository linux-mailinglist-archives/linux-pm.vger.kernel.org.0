Return-Path: <linux-pm+bounces-33748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB0B427F4
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593DF189A35B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37053043DB;
	Wed,  3 Sep 2025 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS/3Clob"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F62F29;
	Wed,  3 Sep 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920543; cv=none; b=mmB/DHgAPHsaTFnT1s015c3iRq5IZHScPAyIImo05NP7y0Tn1lUeAEShbeDQySD+AgS3cS0U36USSItJeSXVaTeuUquzBj1NeLPeBHI3kCqX20Ve8W89DbLAE2lLyYVF5cE9PK/v6WS1ay3zjPoykRaCFZ0VsX9mlI5T0mm/gcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920543; c=relaxed/simple;
	bh=czDIasOMcTnmNXpGC7buC1etHu3sNqn7jeUj8jZmgng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5Ud6N/KtbztZmf2HRsNiTE9urJa5Z0b7Ftz6Cx/ZM2kRI/HDlencMp9+nHnPiAGoNqHcnu2tt4xJLeu/sOCEaZy2RKQ54pUG2PQx9xDiVA7M7Us0gh0FWrEXwgRevPBQ6X+keoXKKm583HOLeHMMYlUhvSAOXrjiCeQZTSGa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS/3Clob; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b04163fe08dso22003966b.3;
        Wed, 03 Sep 2025 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756920541; x=1757525341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XWu9xeL8VBpey0n7SWYhCd7sec1c7YLPdObD5FR6epg=;
        b=bS/3ClobxJt62rsH1mq0UfaLEQW59cwM7Us75y2coDFCho1qSNQ0863W2savOU6Iic
         YruUYdI5Z1hWsMnpmFlmGJWVWcie9IycKbcKxcYaPytPdO8iqK/vFkN09Eba2srm/HFP
         6Ak4KLoGvArXZslhdI3XEZaE8CChWqQxHtkbm+Y+maoSWzD+OlCqeb90ZvjleC/ibUCx
         Ls/hWkcsIwVl28/CmZQFwjJkQdS6Qc2RKYKjOpTDHJPnW3QV+LXUsdMvXe0hemJIGMhN
         Z1kl3zcsWKFk8hqDIJxta+fG5gQf8sGzzqaCcWPOjLm9JUAxm/NUHHEsz8okYSQ0Dh4S
         /bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756920541; x=1757525341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWu9xeL8VBpey0n7SWYhCd7sec1c7YLPdObD5FR6epg=;
        b=P3htT9jHkQoRFVB1iwf5nlEYz6mg/WisO7hq5rEZN8x99F+UaJ4KJM6HJds5/Q3mbv
         xQ50lBMIS0iAv0tzHyE4ICMNy+XFfmDT8FYXjDiiNucuOLBDTEVl5UNGYfwh0gMvrrZL
         viwwH8B3xjyOeS3wLp1qwrO8xMyNvfWXHcWVV1SbPqYRu85RHjONzjAcRLR/phI06Al5
         my7AITJAXBdOoNvOH8gA1mLUXVHTnvdnB0kmvaVD51tgrfkkWB7cvzuHwoBC/OuQLWc/
         ULjha0WeTAwN2k0iyCYyrSN18Lj5j8a0FVtHo1MbVqRSuyX6nCzc555VDF872S9j8mw6
         zG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMpm1K2/pmiC+qPv1QD0dfNKcID5a1fOsoUC2V744HWA5M3HpcIOfH2ZbqM9Pbrt54dhWww33NC1g=@vger.kernel.org, AJvYcCXErlgZiN9rZwPaXlJm1yqbPklX13LR+g6Hp3RFO3z8h7B0+sKzGdcGGAhI45aN+hyTsE78X8WG4DXB98M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7SOiv0Awutj25UdoD0V8A5sA2e992BNiwjCjGnZMgU/AN1im
	jrv5GQ245mCCTsKCZcOJohFPDQRJFd06OGS12jso93bhQp02YXOBfVa1
X-Gm-Gg: ASbGncu1rAyULO1ZqBqBP+6C0oenA4n1sR1j1oCWinAXoUwwHt5Ni2C+d0NtydznCWq
	ooCAefDm8YX3uJRUTKA1fxRZWKdrJp0cq8/c2UqK2IdPZSaVofd5Yi4avbGA6Mv99XThgDO8TLO
	n5VoaVcmRXCkvcKzFMAUqRao/xhpAqaPLFofBbZfR4/wWCzN/aMUdLMJLAEdlBAvnPiKBhIBDfy
	heoiJeyS/j33GBlZl6S6Y0LycBlYSQjNTycMpXj15NjCS3NdfcocRtmWAPSPrEiHRC803Mcd3Zc
	T9xv61ATLKnsl0TKekm6KLK2ALcEZHxClvkyepTxZo0eZJWKXfTodTiCl+QemxNm5PbdzTkIMBN
	9IYUs4u7Wy6u//TftBF3iHCIaZ+R/c13xMEqCBwJue/FLgfFGjOBi1/njqlqPHnuSDQMIgcrbAz
	QW/lIQ
X-Google-Smtp-Source: AGHT+IELUIt2PidsVExRo1sEvtHXYrQqf/H6nGOn9Vany7WFI0RwS1E2R3PgT0vB0jB9W4a4VvEelg==
X-Received: by 2002:a17:907:da0:b0:b04:616c:d74d with SMTP id a640c23a62f3a-b04616cdf40mr441162866b.0.1756920540397;
        Wed, 03 Sep 2025 10:29:00 -0700 (PDT)
Received: from osama ([2a02:908:1b0:afe0:5935:131b:b520:dff5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff08b86833sm1328911466b.48.2025.09.03.10.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:28:59 -0700 (PDT)
Date: Wed, 3 Sep 2025 19:28:57 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: hwmon: replace deprecated strcpy() with
 strscpy()
Message-ID: <aLh62dIWcHtWv2uj@osama>
References: <20250901150653.166978-1-osama.abdelkader@gmail.com>
 <CAJZ5v0hrKBNxDeZOKpUXyuZV7LRUX4ov4ifEGDtNMrA8km6uOA@mail.gmail.com>
 <aLhK_zMvtkdCtsHR@osama>
 <CAJZ5v0j2ooBwnPWKjXGyYOOBtjs6zbAh-+jaUaV5u7sBi87+Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j2ooBwnPWKjXGyYOOBtjs6zbAh-+jaUaV5u7sBi87+Rw@mail.gmail.com>

On Wed, Sep 03, 2025 at 04:21:35PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 3, 2025 at 4:04 PM Osama Abdelkader
> <osama.abdelkader@gmail.com> wrote:
> >
> > On Wed, Sep 03, 2025 at 01:50:03PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Sep 1, 2025 at 5:06 PM Osama Abdelkader
> > > <osama.abdelkader@gmail.com> wrote:
> > > >
> > > > strcpy() is deprecated; use strscpy() instead.
> > >
> > > So why is it better to use strscpy() in this particular case?
> >
> > Thanks for the review. Technically, there is no change since both have const buf size,
> > it's just for consistency with other drivers.
> 
> $ cd linux-kernel-source
> $ git grep strcpy | wc -l
> 1187
> 
> What kind of consistency do you mean?

I mean in thermal subsystem, it's only this one.

