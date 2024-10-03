Return-Path: <linux-pm+bounces-15081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C10F98E90B
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 06:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4CE1C21403
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 04:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3D51EF1D;
	Thu,  3 Oct 2024 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxALIxIe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CA15C0
	for <linux-pm@vger.kernel.org>; Thu,  3 Oct 2024 04:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727928550; cv=none; b=PzMJo1KVO9SY4h26I2HskCxQQOIbYr6ZUbLsw3jk7DFFNQhOL1rBFkYkc4I4k5QrODfgmVe2iwa0+LzsZWMPRDaAm78xna31fJv6+ZNRNczilg4M7jhYplLdtEeI/2lXFswA3T0hmulV3da6B5gGQVmvMNsCjcg1J5UmW5gbXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727928550; c=relaxed/simple;
	bh=XeBkGsgnNUinbhkKskk1LlS4zxYxg034DyzgTy8EuFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzXKWZSGWOpx2Gvyb4R28JiPB2wHxoMgNYEra/ihfQxTDDwO5K3gXhYUUe/Km6Atc11LLkvMY0h9RKcCAPUfdB4cXax23o6CZoOTkwoOQGes0ALihX0pcmlbWPFF2OkFBEoXqXifd1nPdlKZu9ynmOBSjy2DVpa4mb1g6eOXVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxALIxIe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b49ee353cso4405825ad.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 21:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727928548; x=1728533348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Mm+sSVEZoPLZhWE/X27DKG75nOpfc/KIOgMps+wASo=;
        b=NxALIxIe/qAdC/FnheQtYaU85m3MJ3U1ZfhUlcl+5oJDN8yG2eN6sNCevju7uu4C5A
         cJ5YGVVB0pSHZ7E+89/+sy67PzfEGwgVtrttexKZNU78+3NRx40EF0/+5kooeNydRKW1
         ZzS2HkAwdvIOYWVazVrI4ofYA5wD11ujOw0v92FEyzTNcSTJYmrVPPNurW67ESbgZBr0
         T51W070FaX8l3hDEaioc4mVtUeJCNiPtcOlMKqDn6OQl71e2HGcgNghjDKOaD+YM7MxI
         KdkDEH4q9Jp9t+OuJN5iBaJEEFPbKD6MfaKdQ2U6XJbDXqX50SIU+0dGyANRiaQGvcsS
         UfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727928548; x=1728533348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Mm+sSVEZoPLZhWE/X27DKG75nOpfc/KIOgMps+wASo=;
        b=NqU13jePdrb1rvJpXs1g/Ru+IS5IkdKV491y8kIGpbizyqLGhbPyBD0X/vnZuVaIrt
         8xqgQGI+UG9AjGVnFd4K08qZ2luGKM8M3ne+qkFlaEZ4YxAxHocoJu2RChp/jDzxL42N
         op+0SRWVP14i7nLgLiSWR/P2IaSmSioBREKC+uv85LyaM3l664mI/VsR+jwK6mlwpiuE
         PJw/xrYkAP/EAjSutwi1SJBJm9SHOrMkeanls/UJINlqPKfRYnilEqSEUdivb39fy7Da
         EpMyLWz3JHwtpxBuBOWKdET7ReDOv2x5MOTPbW/ZwsOk5eeE6KlF8Rhz3eu6JkrO20oq
         1OSw==
X-Forwarded-Encrypted: i=1; AJvYcCXJamB66HSO3OCard7SX4XoryLCidt37Ln1F5XQH6RFvmCdX6kH6PicxTXqFfoKYnzUpjeqQ0PBKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp05t167Y5T/FTAikBKCKwgSJtKCOHEBdQAh+HG7ymo06KSKo8
	/rhsE/uuHHF2gJGHqar/uSmMkXE6F6CCLettjsOtvnm1zHQTOFVr6mQ0im+RZoE=
X-Google-Smtp-Source: AGHT+IEP4SDn2AnLnAai+AHGFfLLboZlAfYeqXni2jF56stiOFGSo4HwH14+KvK34NuqqkfTEY3ZrQ==
X-Received: by 2002:a17:903:986:b0:205:968b:31ab with SMTP id d9443c01a7336-20bc5b0016amr90780425ad.58.1727928548129;
        Wed, 02 Oct 2024 21:09:08 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefad16asm780935ad.193.2024.10.02.21.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 21:09:07 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:38:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: mediatek: Fix resource leaks on
 mtk_cpu_create_freq_table() failure
Message-ID: <20241003040859.manukmwmrahgcqqi@vireshk-i7>
References: <20241001053906.mkhld5ufrmpdhfud@vireshk-i7>
 <20241001112908.6863-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001112908.6863-1-riyandhiman14@gmail.com>

On 01-10-24, 16:58, Riyan Dhiman wrote:
> In this file, devm_kzalloc and devm_regulator_get are called. Do I need 
> to call this devm_platform_ioremap_resource instead of ioremap if devm_* 
> api need to be used?


Yes, that would do.

-- 
viresh

