Return-Path: <linux-pm+bounces-27333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61982ABBAA8
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 12:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5DCA7AEABD
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964A626F467;
	Mon, 19 May 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvaJdDcd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1110326F447
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649307; cv=none; b=UBIUKXBqkdJmcTTdqy/xUMyKWjmlhYYrv9V1q4FhlyovCJ7wML/6TjJwItl8kvfCaRWhxNMwNzk1JmbUv2Y7pgZfUaahtN5T2geIAMzLME2urOKd7vrHyBRe3xo6JzBd4kDYJUHCDePZhmaFimz8aq0ud1Ox+godEoW5X/GlKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649307; c=relaxed/simple;
	bh=z/sjIVYh1QCOUgieYgekPUG6x3X7vMY1sv7Ow5t/JAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAAK+H7ByVWJLgK5I4UeAHpfR0j2p7Z3ILKxUf+bnguNB0E05iqifI+z7wSbaMtJ+6ebDELjLP/4Z0aO1amcflSDDK62vO0S5z4B5v1atccZl+CPYBD2sLRAw6rzGbMKCK94SZ4bfqd9U4FYO/dH5MOlkIV8TAgNs8qi96H9DBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cvaJdDcd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2322dc5c989so6227995ad.3
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747649305; x=1748254105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PuBulIo1CkbxayB7KEtrbV86yLWE3VV7SPvLxmKhqYc=;
        b=cvaJdDcdmBcmDGGxC++gm7bjRghNQbkwZvTbIWdk+mU77A3KmqRvVFdIYT7XmCKgl7
         U8Ldx2atTGWkbFKfBDZ2D+z8MxWBqwbv3joLquNwRlxIVmlUDFCPG5TjPMz4NNH/mMaM
         I01H+s9a4quWcVDCrSc3KXFDZLEAuITj2CB2O0ZDcxQWpLq93iEP2qCH39V5DdF+xM/A
         DLs2OVA+MgWvXwte8CAwYEAcPUqJypQARCGG/I3KgMimJi8YkYuTwPpKxHV9c65+COpr
         b27vSFuhATO/NSXM6OIQy5bCRSrmgY8APi4QhOKaq0Y+0Ak3OSCrXKjJS2TOsPKSmzei
         e+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649305; x=1748254105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuBulIo1CkbxayB7KEtrbV86yLWE3VV7SPvLxmKhqYc=;
        b=mx96DyjQcgoxzPaVSccEYrHBluVY+yPGg99Hwn1CMlN0VFY7sSZk3IEdtuwzet2hYN
         jj3ZuwCJiVb5nEf+RrTZGE7bmqXbZ5mM6Rn/YnQ+4QLkeomooDQBg5zBucmCYg79Vqf0
         cfqAL13+6HoHvWjY2YqXMEZh92Zgn325sApto/YO3B10EUx2KwvyYztCBgah3XGwasSR
         zT1drb7b95ExrqNn5bms8WKouMpWtN69YpUaflSxl1b9ypcdac2XQ2HhRex1J/om8QIx
         k8AA0A/Po/deamAO6UbiU+kaEfZCUxzXE3XIsB5bN+QlYTLHxCUtw7XgUdlb2Oufyi2C
         Gb9A==
X-Forwarded-Encrypted: i=1; AJvYcCVTgTeS62FeesGACSV/smGu32P2AxFAkCq8zRBi0i9nYwDQbSlZ8udpBUdI8FocFRP2DRAXmdbZfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4t4yEXnhws0NlY/FNNn2UNOpw7ndhvcEaGZzsCFAC7Ymr5SP
	2WhfgXEKRgxA5MNEfTVD2ns1VVjjQbK6GX2kW2SfL6lImX/l0nv4ppSt4ATcgbN6iNM=
X-Gm-Gg: ASbGncu6mo61mLmVmro+gD8A9GD8Bb8FfOS6xqJjFfM8+HQEOqsMUuwlD/VLwo/S8Uq
	/gtEPQeDJK7SChvdtN9ZU62wTkyeZ2uGIeCJ+AVWkbjvoIu01zlpA/nSC534QHXEA3EIPf85SMa
	DxtrCUE5cRsnsagbqrv7oa6ONkaJABCjlCrrxxByKMA+Vfhp7WB7F3icH3ZJ5vJOdinSth69zYX
	DIHdHPLiDM+4NlHfHfF0fnzizzS8ShkAW6UamZQGuxSsLZCpI2ECyVfsRazpH2Xh3O2nhl8I/9h
	HmtxNkggAsPvC4yhXd2w4e61iS+km2sOEkrJZWjKRpw3JgCl+c4h6OqY9CYpjdI=
X-Google-Smtp-Source: AGHT+IGVe2J3cpxAL9EWq9+6d/4gOwJD/80cWTDZrTmrnV8DWVsCp2X+TptmRzbGQd3z7gfCQALgqA==
X-Received: by 2002:a17:903:41c7:b0:224:1221:1ab4 with SMTP id d9443c01a7336-231de317b43mr180365815ad.22.1747649305463;
        Mon, 19 May 2025 03:08:25 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed5e7bsm55732915ad.249.2025.05.19.03.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:08:24 -0700 (PDT)
Date: Mon, 19 May 2025 15:38:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: zhang.enpei@zte.com.cn
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: switch to use kmemdup_array()
Message-ID: <20250519100822.evhd4vs6p34irx2q@vireshk-i7>
References: <20250515201312562vXizlDSg23_PhQ1nALjYV@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515201312562vXizlDSg23_PhQ1nALjYV@zte.com.cn>

On 15-05-25, 20:13, zhang.enpei@zte.com.cn wrote:
> From: Zhang Enpei <zhang.enpei@zte.com.cn>
> 
> Use kmemdup_array() to avoid multiplication and possible overflows.
> 
> Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
> ---
>  drivers/opp/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 72fbb6cadc23..d85e3371493f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2087,8 +2087,8 @@ static int _opp_set_supported_hw(struct opp_table *opp_table,
>         if (opp_table->supported_hw)
>                 return 0;
> 
> -       opp_table->supported_hw = kmemdup(versions, count * sizeof(*versions),
> -                                       GFP_KERNEL);
> +       opp_table->supported_hw = kmemdup_array(versions, count, sizeof(*versions),
> +                                               GFP_KERNEL);
>         if (!opp_table->supported_hw)
>                 return -ENOMEM;

Applied. Thanks.

-- 
viresh

