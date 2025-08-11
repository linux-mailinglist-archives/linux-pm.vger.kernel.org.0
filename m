Return-Path: <linux-pm+bounces-32116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77E5B1FFA3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16BAE7A5A37
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 06:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951442D879D;
	Mon, 11 Aug 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgfcBgvU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9F2D8798
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895192; cv=none; b=N+cERRpxuoenibhgSSM1F3ZSDVY8a3rwe6h/kuX4Y846D6dIMAS/JhRynOF4XMOXPryuji6bbME336+rTVsngJzE/JQOxyaaImGfPWIZq+KFQt+XCqKN7LNn1hLe3TzIQU7s7qwWlcOHHPZl4IiQFwcO7i64lWPJan56+JC/Gwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895192; c=relaxed/simple;
	bh=xYbuFuOQE2iRVDFswBjY22aueZfkpLjtRD1jEbIWSZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDe9UfOgXDL2XK+YlfW90vFUEZxG0M2JKLcrEgdsO4VMIOnJbP/16/TG3EZiFIiA77SVzmEcBer4uJ3VtOJAPW6zPdgCBkftyiuqzN0O+EPYHhz9N42sbMgvrudE/loSuOGcN+6WbAdtLekQXDMLU4Dgl7JquL4pmB7V1UgFm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vgfcBgvU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24063eac495so29921915ad.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895190; x=1755499990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6IsZOxTo8GJ9RAKnkhWQjXljSbOqRKPbCsXfe50Af8=;
        b=vgfcBgvUEbX8AhNNIcr+tQQJucIVVv4ckY0xteuDev/qh850buDy8QAzuOrNco6Dbo
         pMy8BKaKMfNFfmUC17u2ATGylO80QStfYnNP/eKElwvJYI5nBKeCkfxM+x3OQpBU0xjJ
         gLjcjL2mUdKhG/5EddhaxxOrf39GnAh3zJXQ+2k4G8pfflCt7CssaeJj22msrS8FjVgs
         DY4kUEadlW+j6obGYwV8V5e4uXxwRtsqarEFv37RbB/Fvn8UEGzTf76/BontntC9A+21
         /qDqfE4dlEL4iJ5O46/vtXE6yqnwGaB/rIfjNcH3lJES4tPZQb+G1GksFwQn7FqQJU+U
         Ymxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895190; x=1755499990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6IsZOxTo8GJ9RAKnkhWQjXljSbOqRKPbCsXfe50Af8=;
        b=puUtyp1LJzpE/VQSekd2aaFaJS+2XvXOzJX7/ZqF975A7s2Asf+TBQEVV6E/RYA1qj
         OA43VBPgRKdbTMHBHOCF37nXVwxGsRgymRp/yrsoKSfYRS5CYQz5x1EXBzTPOp9NfGw5
         3o/Cqy5/W9/POFaszF1tuaW7+AfkR2e5C8/2kqCUk7dydmmYI/GJQn7GjOrmBZc1mjJd
         XkyK1yyvXAwEOa7LfMGyRJfwdtzoxiBgCbkiO+E5wfbzSV6N82rvx8mWenFEGPXPej35
         XkXZSU2W3SveJuDvpKJr1203b7S33sTjYOoD4zA3cm+D5LpcJ7n0335loCetTYxyFbsa
         ZGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrVRjb1iVFHsBtH3C0gsNRSwhsZ+Bon5Fz8WKR+3HCFrawaVRgVDirKm+NOunz1ezE7zoLmR/aGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BK19KxYKSeSJuchZhJXwafG1S1VqqQZIfkIxtJMk7eeFMvry
	Wtc759gDQgYQnuhAs5wlb/GIM2mAo4TFXYkgYVyGLzxMYvIqbBD4J7UcRsaq2/vfMbe3DZEzmDn
	QN1Pv
X-Gm-Gg: ASbGncvZlfvQSkPEmJVSUB5WL/qJ9+LbDsNu6pQ30aAi7rdXBgh3L26BsDNZsOtFqJQ
	MZUNkPG8o0Girj4PYYLb6JKVBMWJmlUTp7UsKjp5iMp5yrzrjlw5C03EmSQjiOc1JQT3bs6GlHQ
	3qS9hxW+apl/luSStqLAu/ynDNojTBdPYk1GNt/UCTqfigDd83rg7IYvdLH+QCSNa6N1vSszrlh
	3naq/HNKMrCucIy0cT4jERFe6zApP/vBwMqbDemAZJNoFWwENq133V/dYxCFO7CG5d8+BM1opYr
	h7QYjod+lmTcAV7YrRd0rtxHqOj0iJg5xBOr+p34NYDDS0BMIIztbfMfONlqd+83Xr9YJYPiKZ/
	vacgO45rqeFBPMxKDHKxFmPzR
X-Google-Smtp-Source: AGHT+IG95Z25+MbEXOab8ZAB57TBt6vJ69oSa3ZxghqlYC/meL+6fjmVaH43MbKEjD0vda80hIJ8sw==
X-Received: by 2002:a17:903:ac7:b0:240:3e40:43b0 with SMTP id d9443c01a7336-242c2225db1mr157984975ad.43.1754895190122;
        Sun, 10 Aug 2025 23:53:10 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm265507785ad.39.2025.08.10.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:53:09 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:23:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: airoha: Add support for AN7583 SoC
Message-ID: <20250811065307.2luk632awfrjfx7v@vireshk-i7>
References: <20250809112832.15830-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809112832.15830-1-ansuelsmth@gmail.com>

On 09-08-25, 13:28, Christian Marangi wrote:
> New Airoha AN7583 SoC use the same exact logic to control the CPU
> frequency. Add the Device compatible to the block list for
> cpufreq-dt-plat and to the Airoha CPUFreq driver compatible list.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/airoha-cpufreq.c     | 1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  2 files changed, 2 insertions(+)

Applied. Thanks.

-- 
viresh

