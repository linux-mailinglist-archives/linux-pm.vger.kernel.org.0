Return-Path: <linux-pm+bounces-39148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A530EC9DA7C
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 04:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509A13A9196
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39622652AF;
	Wed,  3 Dec 2025 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWh/eijR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B82641CA
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732878; cv=none; b=B79x0WZkVPmadNM+obc418NxIPOKA3EZh85Ev/9zjHLUYQMHSGP34wlYY7m8D2CLeqBMzONdQ25Re5Ys2rnAdzNvy99N2J/e+Ca7Et6/2CsK0QP9gSHP+LTIts6L68MVVLDm0eAP87TKjmdMwxwDxTcZf1azCgdjsXC7hvrjhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732878; c=relaxed/simple;
	bh=I1AImt9xkS50xUTUKM3FFT8JhAHzj3Llv8/10BB4+VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePUxZLjsuvkyrNg4SmfXUw0s2l6rB9wF6axIhXluSfbxHUfF475H+0KyvAvuZdFMwgb2YMwHbu4E6Z05RMiHoltuSwBxWQyUGb7r/4/Mx+JqTWQlP91m9NHgHYCQkkO53XIgmUoBaKAR0Bd7b8pOY70BcWdi43nBCyR01hGZ0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWh/eijR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so4031312a12.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 19:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764732876; x=1765337676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN4c8sU/S8sKfqIqWSZ2ukImvsU3t4AIDPSRgGg4a6o=;
        b=SWh/eijRMr9gFBZralvgltxctV7iLTxoYaz5U5bnz+AVlup/jIzxRf1t234hgUN8M9
         q8o7fksFtdrrmMVNXdDWwHJq3OEPZVz6b/yp7THRYPgMVTvBgBhK/1exH91UpmhSEMof
         8UIjek/nidh8hgOfTO4kMlEgwwkzpY3pG6xzV47Lv1ofoluhsVvvM2NSkPQJqBIdDAsz
         X/iaWYQhV97UdS39taAPogGdpO1cSp8ytUjjRUU7N2kP+RjspfoZkzhqP9MyjPkHDcWx
         xrR4LhzZXn9xFCByP8SuxBo8g8Mb2wemajBALutBmimvx7FQEywlrT7tTM5kBd+AK+LQ
         +VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764732876; x=1765337676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uN4c8sU/S8sKfqIqWSZ2ukImvsU3t4AIDPSRgGg4a6o=;
        b=pA6sX6e5eAWeHiCOjAyfuvYxAQWUsDtVAY7YWWY4V7kn1Er1wQdjykjJWpEvMKynB6
         Xzbb41EJV0mJYLze6cS3sdixVHvqNkAnh8i0jOCcKia21Y2rkpZqci9hNUMLxQ777LnJ
         jaCBXo/zHBYPtwZeIaDkM6nmRZd69w62AA1mD8WxfeUDRtO4RUkiaCUhee+bc8QTdg6E
         JdLbLyk9GmBXXCW8QZRSnLScXGx7ly0Xl2c+6T8sTHmhlDF+59DYaJuXreAKELmVeunb
         tGK8MekEvZe0w7qlQnxsyP/tuHlKDGCjW4fe1TmBZYD5FXs7WjofoMU6H3TN9EBrTqvF
         XiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXHLOKgq+vyRD0s2SKsWsTaW0VoG/uZBGToE9MJPAjTmaZwdk2YPV6IIQjt6F0mafSqQKOjfim5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxriquDmHwuS1j8nOjVPKpKaXyndzMxqeDjqXF0gaEAEBE/giL7
	BL+ri7rmEdCMf6chj//KRD6+0MBRJa2ZOMN0RfEZ+Alg/hpwskovrW7e
X-Gm-Gg: ASbGncs1A+pQ39FcbtbdQpmxQJ92sN4fLCKKHbS6H5fgl13BsJpW3SJvJtXLHz6QDyu
	GGBpFA53r/cViHDSnGukWXE+/Pw+K9lr5tMC8h+YVWo6uk+g++AIQQKnwvWWU6/xF9VAP5obgQj
	WMCOQDNXq9PvE+W6mvvNQ4wNHyf9SCXzPt23S34XYP+1M5/EkHFuLPPv5nDbBW9vQ7E+3Dh+eI0
	IHuSiMP5FO8loW6IBsr3IhQT3+xobonkYWfW3nbOHuoEC5jQ4IJtRrmZYqny14sjoScNJ4c50vG
	zIVry4P9mnwcHlCaHnk/axyBduPyu3yEl5UbYuMBONHIdHUjibGEXeaW510dt4ulEMGZarK9rlp
	CtQNKDzD/yREMu95ksv3sK7NJY6F0tWb5Dv/yW3uOjvbc7dSwE/pcaML3TgKvNGpC+77zEQGBIb
	E2ZL6SWauO3yd8mTk+IHruEE8=
X-Google-Smtp-Source: AGHT+IFOo3b067vZP6G4di0CLw5msqr+mDhAcC0nkiYdidAZ7X4NCaWsVzZpQDYswNnKmbz2SRQeIA==
X-Received: by 2002:a05:7022:1b08:b0:11a:273c:dd98 with SMTP id a92af1059eb24-11df0c487b1mr822518c88.20.1764732876419;
        Tue, 02 Dec 2025 19:34:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb057cb0sm96057395c88.9.2025.12.02.19.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 19:34:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Dec 2025 19:34:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr
Subject: Re: [PATCH 3/3] coccinelle: Drop pm_runtime_barrier() error code
 checks
Message-ID: <0061398a-1b19-4249-a0d1-31ed2826770d@roeck-us.net>
References: <20251202193129.1411419-1-briannorris@chromium.org>
 <20251202193129.1411419-3-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202193129.1411419-3-briannorris@chromium.org>

On Tue, Dec 02, 2025 at 11:30:26AM -0800, Brian Norris wrote:
> This function doesn't return anything any more, so the compiler would
> notice any bad error handling before any cocci script would.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

