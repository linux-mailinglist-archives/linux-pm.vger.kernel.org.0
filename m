Return-Path: <linux-pm+bounces-25098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D8A840A8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AA49E1DA7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9E280CDD;
	Thu, 10 Apr 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0PPNX7o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A126FDB3
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280678; cv=none; b=tWs8zmSt3gSY96/zS5TNeaKGUF5X53sZG/OUzp6Z+JTYYUouH61Y5CQm/k9lwv0ohpeM7hygdWBsBCjgnCMsR42f5xsHoj7+ekQfVkX++MYxcnnznLXa5B0sAdf0Mol5WhlIz0hOFs90YD4tDfvrkSDMOHIs3dE3ShbbIEvhRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280678; c=relaxed/simple;
	bh=4XYqEvw3pO3aeYAiEFs0J+jvt5iPOecIwEe31S/Ndpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4AwdvaRI2jWSIu49CD42N9NJAA8zjLM7CqFsEsN2eT81gKaK/oQLCHp67VmSJuFNAqZSoErluD5mqpcNeI7Csh6QmgMXnG7TZU3FLrvMqE+/LYVKh6zMnel2JgFk6f0VK9AG8UA08Ka0wgiABAr0JfUN5uMGh0/zwEkQu6EoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z0PPNX7o; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7394945d37eso470079b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 03:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744280676; x=1744885476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GX68swA9HrxO+eJnfk16Z9K7ND9yYGB3bnUXxmarCAA=;
        b=Z0PPNX7o9993BtdNkIE1oujzCdBR6E2UFw9tovVN9RzM9QP6EzvuA2jcOFUVOhcx1Y
         gTP5N7UW+bBbcBw26uY45aldIgyTsgCr3AYeSgAW/mXUUSc/AcyTHYRmTU16oQaBvgVg
         6zdrDxXc9ohVksYgN01HhKfzoljdUuGDEln2iImsjnMoBreoRlkmak5Mu2hFJaKa1sMQ
         PUZM3Uy1HgVvxRSKYdPMebiGQngIfkTg5s/xLBd/sNL5ClcMfhU37kmNbkkw+xh3953G
         geWz1wskxJRZpuUY6AQruUky6iFzkOGueByiWBaVwPt/f5p7mwQ0OylI2Q1wu7xb2u2u
         n+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744280676; x=1744885476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX68swA9HrxO+eJnfk16Z9K7ND9yYGB3bnUXxmarCAA=;
        b=vB7nXnUn1ei2s4sTLK+L0RHhKAGwKlYaGsETrYsroNaer4nXjiUkQ7bnR3tZeOjITD
         ltTrk10K3ZewILsFh7An6vpDdBLwQRcrRdd2PBtX/dh8Dtro+o9mZxLxkxBxnx5Qlpzi
         WQfaNQprlltKnU2jUnpsYgKFR1uERFZmo5qnlOlCvAWd022efZx1djgjRLxntucItz9q
         oEjgUY1pF6wQhk+9VJP9WQ6LPTJN2UBZZl1yVpsH9Xkk61JlGR+UK0VjGqAnO55uGg1S
         6h/SqVbxQRjxpW2znWW+hDJgYe4ZEY6de/4/xlXgKtSklNa0VMdFLbMFi5dzQZkOcPL0
         47YA==
X-Gm-Message-State: AOJu0Yy8GbEcJuwhLgfuVa2uwBg+wMwB9XLz8kZfr2PzieX1TRgcqJ1W
	kHIyj/bGyydboj/XSs0U7tX+FHkXbhnhJ/W0rMQxtF9H2pVzTfmbLhOqcninkMI=
X-Gm-Gg: ASbGnct8nYBOt08c+wUPdj9pev9ZQa+d93PvykkkFL3iwvbXj0z/XswIFhn/OgvdP8K
	m6NfSc8IJ2SQDQnab8Oz4i110ZA6AMO2VUN7xUaSG+qC4EvG4IA0opiv2402QdxM5lrNhGrAOhx
	4sQVXLvORDUnDPsLsO5aRlBe3/uB3e3JRarZAKdHYiL9nYTjfvM3l+YChxmyRNrLCHHB7lfYwLa
	wAJqm8uRwwKFdTuUUcn7C1FOBGbVqUt7m+LDgGg23VdOxGqSjMRKyvU/RIulQBKuYTnvimnIS3W
	NzN9Qsw1FYDkBjOYEizvdQn6U1AQ7vEwwcCrR8yzgQ==
X-Google-Smtp-Source: AGHT+IG2sLEZsm/PLhGsSjVJrT/g86UCeqGu2+t3DsfzOYJpMkwBlq4ZwTimT+XjrTeI9HudHDhEDg==
X-Received: by 2002:a05:6a21:329b:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-2016944d22cmr3592752637.3.1744280675957;
        Thu, 10 Apr 2025 03:24:35 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2b256sm2984539b3a.14.2025.04.10.03.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:24:35 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:54:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1] cpufreq: Drop unused cpufreq_get_policy()
Message-ID: <20250410102433.fro7cwxri2kitwck@vireshk-i7>
References: <2802770.mvXUDI8C0e@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2802770.mvXUDI8C0e@rjwysocki.net>

On 10-04-25, 12:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A recent change has introduced a bug into cpufreq_get_policy(), but this
> function is not used, so it's better to drop it altogether.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   25 -------------------------
>  include/linux/cpufreq.h   |    1 -
>  2 files changed, 26 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

