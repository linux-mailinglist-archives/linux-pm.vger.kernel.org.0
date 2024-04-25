Return-Path: <linux-pm+bounces-7048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E3B8B1A23
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 07:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D2F1F22BAD
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 05:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497A2C1A0;
	Thu, 25 Apr 2024 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSv+OnR7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611651E492
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 05:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021646; cv=none; b=biXCobQJEwvaeKJipoJJMOyhQpcHW4uG1MpSQkHRYchxf/cZohkmB2pol8qcMu7fqKTeF1MwgruNvRbmcFB8Yjh9CiPJKj433Orpvk363dkeeYDggQ9FgrPYJz6UH7Zww9FwMuLz7XxVhSAKyhzJiqMab3H5qlf6c+vJUCB6hcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021646; c=relaxed/simple;
	bh=Ncm25OorSfz9ZnjTA4O3Y7gRy0DGBERjo58g7YZCcmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUkWmAWIfRLuZI6zddghlcmnkEROaX7g3gxklW8Z+QY3SyvhhVoLRX8+oFqTO4QOA+HPPSsYOeiub8gNBSfZTTBlsz7rLdJfh4bukGs8i6gW7Ed+Z7RF+PwqJ2PezFvRJNLaFYHqSeNe/hmDGgHwCm/XoexlTvBtFs5rQviD7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HSv+OnR7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so586318b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 22:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714021644; x=1714626444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1QZb4MudunGoT1d0CEZNxbpWlJt6A7q5DEKaxpPxYs=;
        b=HSv+OnR7EEy3RGOUvgS8KFYsug0vpc5b5XAXoB3//KCXCPp8VsDrSh0rFn4ZmCOwpj
         FfQW5QU3pQCIbBPL/jF5Z49t/qlX71WUMoZqHGQZeHDiv0l5/6MJV8f51eOgLqjS0eNR
         d0TFLDJa8bGH50ssB4LcU+uhMXcE8bQH/HlBQia6cUIS+qjRoMLVfz0qB0PlEe/w6bme
         8yN4eUqhewhPoGMc1OH1AEkPAzc3246v/fYE9y5MUre6GThThtR6S7g1VQRKsTrmAPxN
         M2yrvX6H/EEY6beKea7XCQmqHHQ8BsyWEMDfb+frxaFdcfXdWqts1gVb+aA9hFtLNnga
         Swvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714021644; x=1714626444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1QZb4MudunGoT1d0CEZNxbpWlJt6A7q5DEKaxpPxYs=;
        b=u2ciUDy3xIJgEesAVJ0Bio5Y1CjgPKvXfIc09hurUjHw0y5pHUTXLndUqfgIsHAMnM
         HpxarYNYPb2rUDdSDqE38tqiMkBP3V476e5jpQsJUtR36JcU3xF/YEfqAbTkuPmJzxps
         coNfpbdKE7MXseTEHcNHhDu+H5zuzXRhccJr3YQL2Oozyc8SUdTH432UJo9IUirVKdFe
         VBgy90hAOAPdyamiberBsMhB17iejtW2qzPeZAZOkK5I/JIyAg8XynMoAKEcETOJNHyu
         F/0tCnk8SlyQT+akX6bjRi8hh0kf0yJjLbsH2nIjD/Zj7rRaCgFV8oykAxUUIrkhj4ox
         KT9A==
X-Forwarded-Encrypted: i=1; AJvYcCUAhaXqCFO5GRwFID4912jEvgoTfupcRuJvK2Z1ewi0YryUCMk0NI49iPE6VmiGJTLehK54eOPHezb802vpiLWEZf6Rf5vAxqE=
X-Gm-Message-State: AOJu0YynGCHuyyN363GbNl4m98fnTLKj2h/1wvhegVsZ9T/urHQfBDZ3
	TRp+znPfc7b4EDDW9uCJpG3IVB/ilx69ZGc7L8ODSNxZ7IDEb1lW7+m8cL8SzZs=
X-Google-Smtp-Source: AGHT+IHJ+k3q96gkiNx4O1VRjqwvvQM6h0PmO0ZbYeZFT5gD1l1NPwbOgm2RMmcK2waLpaq8Sbt/HQ==
X-Received: by 2002:a05:6a20:da81:b0:1ac:efbd:dc46 with SMTP id iy1-20020a056a20da8100b001acefbddc46mr5597081pzb.2.1714021644464;
        Wed, 24 Apr 2024 22:07:24 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b001e8d180766dsm10760282plh.278.2024.04.24.22.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 22:07:23 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:37:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Portia Stephens <portia.stephens@canonical.com>
Cc: mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	rafael@kernel.org, florian.fainelli@broadcom.com,
	abelova@astralinux.ru, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stephensportia@gmail.com
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: ISO C90 forbids mixed
 declarations
Message-ID: <20240425050721.vks2bq7gqwl2gfpe@vireshk-i7>
References: <20240424050220.889814-1-portia.stephens@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424050220.889814-1-portia.stephens@canonical.com>

On 24-04-24, 15:02, Portia Stephens wrote:
> There is a compile warning because a NULL pointer check was added before
> a struct was declared. This moves the NULL pointer check to after the
> struct is delcared and moves the struct assignment to after the NULL

            declared

> pointer check.
> 
> Fixes: f661017e6d32 ("cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value")
> 
> Signed-off-by: Portia Stephens <portia.stephens@canonical.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

