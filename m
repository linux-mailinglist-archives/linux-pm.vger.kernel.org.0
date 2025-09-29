Return-Path: <linux-pm+bounces-35545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E901BA8893
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EEF3B304C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0C280330;
	Mon, 29 Sep 2025 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLkFKoN5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640B2641E3
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137072; cv=none; b=AFBzF3nptlN3jCSgQC+D2kCIziSlu1VYsiySdRwDpXSzogknFO/FN7onbie0nzEKit9wrx/lCsUiqbTFUUNY3jAU1KpowpnXg3GoB0vwbjwIHZLKTSMQSFqJ/Bh20rZsL9lr6tkvr57fMTdOmWP/X6jW/SSVBrFN+2iDALZ2pr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137072; c=relaxed/simple;
	bh=IzPi6YAga9PuMbnzG8is1PD6DWuMBpvZP4lMq4idAD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/clOaX4+Zci+GlefO4TRyzWKxbLf1ViLCjkriqyA9SQom6DZLfFwwmDzAbANzcjSvifW6XO4HZaUgQ943qmwh/PvoNLt7ps4ABlFk6y8LyrOMZNp03IucA/elTVK2dDOANE6ua3XOsFqpLZ9RbqOuWNiIAzhAHftI34c1aXv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLkFKoN5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d3540a43fso48438765ad.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759137070; x=1759741870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0UzoMEpxwYA11OgHMzNuzA/C9K31n+vXlsLGo3esRlE=;
        b=FLkFKoN5rgxTsIlilQWGcR1g1CJeqhrXE+hkdzjSpbYWiA3Wj85lLHRvb+BKXZbfn4
         DjKmUEjngS+KSrFPQRZGOhjtbGnCPdDMwNxCGTYoUWlD19wIhf4aXjF+09iQbuwc9NOa
         Cgu2faNfcBuUq0GS0jW1GrOpTPAAthhqdO/TedYv/GyP1HEiner8SYk5PsH/Gj0zmFfJ
         DZByhJwOrrIubNhFyNGk2xPrEneMJj8aRvHHQaxKXJ5ukCpJxw+h/fc7ofMSMikS0ttk
         4yBZR1QT8Dew1ad489L9ikp8q4q3snU9ujDP4ilr1/YvI4trwLWtFdgvNd9wUftbAcW7
         WeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137070; x=1759741870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UzoMEpxwYA11OgHMzNuzA/C9K31n+vXlsLGo3esRlE=;
        b=Q/P7N06147ORajMFvgKFsv7/ByalOX31cWoZGMoom7bqcBz58eNfS++IiCSfMxLy6H
         YN1qU0qDpMtOw3AAZMFQpg+q0gHOXX3pjjnTESiyZPscz41rqsXgTuAyCJer1Apz8C1K
         a0BecWyIFOy0mDzcftPptabocWnlMEkFXab9COe9Sh8AhGUKbtm+ybXWqDp5g9xsQb2u
         kBJvjGI/jroz9d8wsuLrRsy1JgLG42K6FA5kkyn1tV7KVEN6ZkO3DPFPH1QgREMmF/nI
         kT7lXVyQWKlIhug3IJP00lnPDPXoa0WBD8IisSa2tk77qaF0W510Uq1JIK32wL53ZGcA
         ml6w==
X-Forwarded-Encrypted: i=1; AJvYcCUIFqSt+0EJIpw2CnG+Z2KZuEyYP5Q/n+x9+8Kp0arTDdnuNwV4cRfP/QGI6teJXpIr1HsVzE+itw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmV7Vzx9nKudWcKtq7TOj67Ztjj15YEIrVU9rLd4Q85+AUAQY/
	YHBTMLVajvuDOI3X5OzLh3zcgSySug2SqAm/GmAeGYw5nzwlRMRbS0nJKSv3K2Lcqu0=
X-Gm-Gg: ASbGncsofu9lFN0IYKPBbkjt858lTfspvx9IhZYvOch635wjFJFOh0Rfr4+E+qoQgzQ
	5xtA0U2YJCcvfpBNAMpq9zjEMQ2YR+QgAgAS55khjwewTuySWIkcl0JXmZWySmA+ik6uM/usdfA
	0eqJ4fE7fLMB2JIat8f5eHSSQkPxcT48GWH3CyzqHMC9z2M4xrweyNXjqUfoHB3fV/fhce9qRsp
	Gq9TxC3/W2UeFNYqCmXDogRrHPeDy11ROhQ4juUpLyAoJPbKS6JCKwQxccNelfyl9dRTQSlk1wG
	fGzAldSCCi2Cja++FoGilBc3PxItdCW/HsVbIKNJSMYQyraJShKXxPQ6r0k+oaU7nHDvJ4B+u43
	vMM1jy58X3kVtRprM0K9SgHcA
X-Google-Smtp-Source: AGHT+IE36qC4gdaY+djdCS+K2gAOuhROlHGPGFHjHQiGsIGh3DmF86iNkcqZhdF2hU44jns2gHjhyw==
X-Received: by 2002:a17:902:e5c2:b0:26a:f69a:4343 with SMTP id d9443c01a7336-27ed49df6acmr178971505ad.4.1759137070390;
        Mon, 29 Sep 2025 02:11:10 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf181sm125192125ad.28.2025.09.29.02.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:11:09 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:41:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH] cpufreq: mediatek: fix device leak on probe failure
Message-ID: <20250929091107.4xltfrms2zdnhov4@vireshk-i7>
References: <20250909073819.25295-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909073819.25295-1-johan@kernel.org>

On 09-09-25, 09:38, Johan Hovold wrote:
> Make sure to drop the reference to the cci device taken by
> of_find_device_by_node() on probe failure (e.g. probe deferral).
> 
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Cc: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Cc: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh

