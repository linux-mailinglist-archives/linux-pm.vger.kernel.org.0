Return-Path: <linux-pm+bounces-30432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6116AFE238
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344B0580CBB
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27823B605;
	Wed,  9 Jul 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEBgJEku"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3412749D1
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048766; cv=none; b=VS7WtOifxwXyDyLSbMGSmqo7lItk8s0BFvg98eima1JRzg9cvE0J4WYvGabHcwAZEym6ApKMUZByMS/tIe++8KDn4624tD72/REYz8HN+iP6dZT65qN2uRVt6z3PHbiJJKHEi484kQ4ZPujCNtSXAySFV5L+8JaNxYW4iBMaHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048766; c=relaxed/simple;
	bh=/zZwSYh2vU/5k39pFJ6jmYxsKtGH5f1vixahgGk51Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRJx6eKGJJE/jIVuMaw3h+shuubZNZymdNVHAVBLgF48GWbSfoWZ43VYzM9l7pGbGSYNY1aHvUFpiBz6R5P6k8JxpKrOla8JZ16BU99tq7DSloOFQpIOrNYEizLva5n8KUKiI1IrMKOOGICZ1/Hu+1xXP1kpJ0b6R3Ss5v/aj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xEBgJEku; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234b9dfb842so48113595ad.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752048763; x=1752653563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RyC7LXvFVaBKX4nsxZCPQg0l7p2DFOwCn7njR7ZoLI=;
        b=xEBgJEkuEF3a4t4DRNaa1vtbDBhD3XroghoTzlHEBI9yVTv4GCxJ+iylZfjv2LgWN3
         +qCyFzLO1DDUWrJaHhKVPy5TA8jF14GIhxtUmmbj10uaPlhplF2XmSxlJsBw3EOMQ+Vi
         rTl5I9f79weQ4mO5oSIUyzYaaX49LrtfNZO6mqHLi3SbicuY1lTq0+g9EAHlIH8dPtSU
         imEcD7Xe6Hn0xYnPiUDj2PWfHoEpWt0J6E/1z68jpYIZ6b3+i8Azh/2oBXVrz2Kvkf3x
         Ih+q5XJlYyDfJzo2a354RF7ouo6OiyfmN9ClPjRFFoKDfbgGgRRYwVRElpIo5f3c6qDi
         A/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048763; x=1752653563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RyC7LXvFVaBKX4nsxZCPQg0l7p2DFOwCn7njR7ZoLI=;
        b=AZUYDDCcpUe0JIZpUFy52lkJVbKvqz0T8ZWiCzitUPQWOG6ZjOocFtsWqmqPbAxlx6
         FcQ/R1SIrolU+O5TdeikW0f+S6G9mlUAvwn+n+JPmcVH2v/roX7XmI+B81Sx8WVTQ75h
         QnTJQbjK+jgheC+Z6JzBU75LSqo8fcLwCNmR4NNTlzqdCbsPhEXmG01jBS7ve2Kx7mZU
         wQrNv8P9ilwSJRWvFYqLaSomZ0Ut52S5hnyuaBFwvMst+6ru1fkgMvDQsfUmMvsBb5kX
         Tfrsohg6cOp4+svZxQd62SHsQ7U5fdAegfTOIjZv4Vmf16LfXBczXpWCpSNtzN+41oU6
         AJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT3lIIXy9mDVBi1M1+fsoHJi2Jmmhghb6DDcqxP5RNDK3b9D0wundrSrIf1A6ieAOQDwdUEdxW1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWrWACWokbPx0lU5qszWSdsY2CrdqxE77FGuy8n3y/4KA/rSo
	6TXNPXIAX8sYSkKltFOgJjMXq/JAScutAtlCkr0u6S7Wu/2uAGIAX1wQwXpHTnzD6ao=
X-Gm-Gg: ASbGncshBSy4/5QRNInxf4nZd5kMVPDEnzXxmWdC3ceIaX94qhu8wcgti1llQ1Canj7
	y9T1DH429xoHWKPesLsFj3yD3ZAZ8ondY6al+IskXAc6GUYEXrTAKgZSsUXJd6hxdEgIWiX+1zC
	rG8+4QX+DaHASKCw1f8X9j07YnsI6maMOXmQq6/d9cts0bFjCn1GP/oXnCaTns3ZMzTUx5Molx6
	WDwss64qJeKLiGfdpc/6nKc0wdUbcAGDzeeENAjiZCh/7Ki6XAbfUbSjBS+04rGncHYBbV0hZdx
	db1oNtwPMTydZlErmITU7uUQCLAjFlUwjbgYwpgzMM+XswCVwsZbudz7S4xcEgJs1XrNq8QxJw=
	=
X-Google-Smtp-Source: AGHT+IFiRMnSHmNBvUClpBlaNrV3TBD2G3A1eITscwtWGj20grwDeZwpsDQEjZBDH9aGNpfCQqSsrw==
X-Received: by 2002:a17:902:c412:b0:234:bca7:2920 with SMTP id d9443c01a7336-23ddb2e82a8mr32305155ad.24.1752048763584;
        Wed, 09 Jul 2025 01:12:43 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e673sm139950205ad.174.2025.07.09.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:12:42 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:42:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Support building tegra124-cpufreq as a module
Message-ID: <20250709081240.wycbxl6fc2mmkmlz@vireshk-i7>
References: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>

On 07-07-25, 16:17, Aaron Kling via B4 Relay wrote:
> This adds remove and exit routines that were not previously needed when
> this was only available builtin.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

Applied. Thanks.

-- 
viresh

