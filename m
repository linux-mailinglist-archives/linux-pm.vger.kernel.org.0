Return-Path: <linux-pm+bounces-33782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6EB430F8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1527B648E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 04:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B92238C3A;
	Thu,  4 Sep 2025 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLTWsFVb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68571E3DF8
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959280; cv=none; b=KwIfU3Fzebgc1tccBdsGqcYrvugfHSBiCLlTPXkEPpzrUqTe2wxcJd95rxmtsrAt/k+zQzcwG5BryFQc+csnBDlXzsEJO1W/GzqcIc5k9tBS+ATz+tSLBpxJlLalcPe+K3EAYSMYkuMYPnaWcKPS2/WTh2tXM+4QPykwsYmmJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959280; c=relaxed/simple;
	bh=wfhBwTLerbIFEpI0SAT9l34CPI5ZRFP2pNH501mDj30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljcT6XFKtErBAzosn0DCYmEOEMbRFoPFuseoJ9ZJRW968ihQhd/pef0QrLgNjjz1xAC1AmO3+yQiHRNMlxjVnyJav9Ul1hHBAbq2O7mWTNjOxvgaOL9mE/8vjiJlNywG0a4zvVIVuRojCfYvW5iefYfW/BnSRU50b75pbm3Jm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLTWsFVb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4717543ed9so325389a12.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 21:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756959277; x=1757564077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LocwM3GBVVDfOIx9PjNIngxyRovOpNm11wI4of2MRWY=;
        b=lLTWsFVbUv9+vpnl7x0CrpXfDLcWsyFRm91UrntfsuCWR1vciTCFSGlYJ9BLS09nxG
         0YlYZiUGxXvnoq6KwT+rS2MebQu7nbn4x6GESo+N4LNGN78mmhqUydxOdxBBS7f8n9iY
         3mLYNLLz8xvri6AIMSjfCejL61itmyDKZPxjNEZ8bQ8gGLvkXqCuvvHnzp36Nc8jQl5V
         An0XXNBAd+jJOXduvkUgv54Gocqsm4DuTn0Xh2aiytk2orccWMWJqMCrxEVSqXVidEoq
         AVuBZUzxclEFQhF7EaHXhV0U98LFC+JA8V+YGN42ViZINN03m/wR+xw3B8JRqAk0r50r
         8Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756959277; x=1757564077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LocwM3GBVVDfOIx9PjNIngxyRovOpNm11wI4of2MRWY=;
        b=Omj004CssTvk67imVeXt4ZIhWDXaioBT48YvTqfKj/FURmYmAgTQ71mnrK6lF5kA0W
         omS6d6Q8ZT1n2+ADgfhAmtTvn/mRWHaky5aNSbwJLu3IlwmlP8PR4NXprf8oiXx0lxkq
         4HBqnQCEhIo81xtmLnYEuxUivR2HwuL/7RTrdByMcEYlM+KNBAvykB3zFdIwAh5o77xu
         qYdhn5gVDpDyZr7booyewZfzl/8XYYMkLUKI3dR2dI/41DTDhQ99g6Ae8RlEC6gkeZaY
         gKP13497CK/hGxre6q3zANEhgr7YkzSKmkBvAZgAyz5gOk9QK+JpEzNgASd10dBiY2xd
         eIdw==
X-Gm-Message-State: AOJu0Yw2gEdVq70bqxvCgquUQ5q3phYWBszgV31cR4++MnMyoyFy6C/2
	RmpWcuxsAeq6+T14q854up9WDOfhx9Y4k33p1beToIsJiLAy2ug+FHfCEHX+KiTyzCY=
X-Gm-Gg: ASbGncu1pa+BC3WyCf60uo1m/NgQ6DxgiWqfffy/mQWVJk6S62JbAOooIHx7s/g0RT+
	oii/HbQdL5QoPo3msRwp4CTBVXyJhCH0fWJyuKXkgU3c9qyr5c5MNkOCErDfJhq8L5x1yVAc8SF
	lzQa8OlOLu1Fa0H0ib0MqxpAisVR6aqQL0IPLk6H5ySQNJ6AgMkTUs5mU4jMhIFosmvfohXLXe9
	PAuklZh3+pHPKRO7MJITares/kc3xp2pZxROI0nyOWyU5CAxZtDzEnDeZV5IvZ9SLHI4QaYpX4f
	pqFIKTpFghr+D7ECS/Z2sjyj/dXexCZh6Jwfqh2uubTOAVjBRedlNoStrFoDWKra606zyz/7Vxd
	UsAef+cx/kQ5oqZq6T6TRaQ/3
X-Google-Smtp-Source: AGHT+IHYV8nFK793hWCZc3pPhU9vTCt9DxyMPIvaatR1rCvBdvcPzSm23YrTWhjMGZtVSn7xStvSZQ==
X-Received: by 2002:a17:902:e749:b0:24b:164d:4e61 with SMTP id d9443c01a7336-24b164d5153mr82404125ad.13.1756959276906;
        Wed, 03 Sep 2025 21:14:36 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2493b6ce20dsm147546105ad.92.2025.09.03.21.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:14:36 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:44:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: Re: [PATCH v1] cpufreq: core: Rearrange variable declarations
 involving __free()
Message-ID: <20250904041433.v675m7u36sxfeuov@vireshk-i7>
References: <4691667.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4691667.LvFx2qVVIh@rafael.j.wysocki>

On 03-09-25, 16:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Follow cleanup.h recommendations and always define and assign variables
> in one statement when __free() is used.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

