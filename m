Return-Path: <linux-pm+bounces-36325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D924EBE6403
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 06:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D5474E6629
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 04:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F9C30C36B;
	Fri, 17 Oct 2025 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH3HiPNV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DD248886
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760673903; cv=none; b=HHrkgEAPLTYVKeZc3unJXOpmPsJEnforNY4fRz7v1ryoIkdD1/Wfkzy75VjVoMX0JIVFPQxuBeTHLqjtVnNu56uUQowhMdQEFkOoBISPF7GRhm3eLaB368Y/Ige1W2DFwl4tio9NztYkxKipg9YZOYH7pSvcR9TpbnvvDQSwx5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760673903; c=relaxed/simple;
	bh=if0Z65l0iVhtqX7EJ2LAVIPGjJ2azbvYwOOzwnLay28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiCl9M/5jOragM0yw05ORTqRlCUWto64M6Nbo/OQLlwZWD/0iCcL4U0GQKRCUTVpNOVH9f9a6jpRjvgriekwYEy1QrmLwjp5oLEuWLnJfn30F9caKvoVyr52ua+Vyhpu5h3iQgooqFFNU9ZMLRTcsMCDc/5MfAHauT0eZiHZP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yH3HiPNV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so19144015ad.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 21:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760673901; x=1761278701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yTr8XYfVKTbUORpK+gdA/VSO6LmqQtreJ6mNFyN7AA=;
        b=yH3HiPNVqT7TeMPYZQ8eVgmKeW2i6SOA55ddHBELyM89fNjkyuP4hqXPVItkNThNJh
         mZ3bcpFim9K1Bsygvbqg1wm83Y5WQYhG/yy1vlNtNwGa3cFI/l6RL7Gtt2mdd0V1wBI4
         GAbSqmHJPSzGW12Vgl9gW3dIRMBgUA3Jvm80k1QPpBvQ6EJczV+Zn1/gkobOs3L0rc3K
         6QzbnsOLVYOnyjWUzOLg2XppJzD4C65eCBPgL1ncrPdWmY+a2NepMMlG7b6KCYMetZV9
         4OfQgGd45kS2wkxO9Ga6GcoY8+5bgvJ1hkXudq3XcKwKpgOCJVzNOxuXFhcPYpvsqJ/h
         TCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760673901; x=1761278701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yTr8XYfVKTbUORpK+gdA/VSO6LmqQtreJ6mNFyN7AA=;
        b=PccWm2mN7ETemmX070thjXWyGXx0Z8FBVTI1A/a6NzepMf+hFoas3NvZvuUGGr2ZkV
         fIb6sJR5/nTKh7OJ7jrace8+Bz/p2RR40JqLuhZSDiQf7WtbDT08BhUGYyHyF1KL27tY
         K2aFW4SV2AsPrTpS7RsDPNA7IUEpvWyAnDf/HmgGKg1llFRhDzdeBYtB4DcsB/UWwuTe
         CibtVg3szsQreDN+DLIo0ZSvMyFUbDbQrXdT8WIFhCx472FrmX+IsDOFFY8SomxdEa8r
         uNT9GV/+9gHUmHne8853Jv/IUm/PbiNBoXvqY5kPmigTYT/KS9vhkujFiSxx++ATVVRH
         nsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO2EbjzvOwvjjAUy/k/CQ1dkOkufpkt8B/hl28TSYX4KX2YYpvGEy0rtxjpdJZEF1nzpJUOTbDhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/uFHUcTP7J2xaqpCfENAOYdPfS73/W5PSHiEWnfTdg9ZUljoV
	6Hyic3GAK60Hw7CL+m0rUOuDVbdP/bHW+4Pzj1ZGUl1lutENxNfrgHBXwQhbGpDqHGk=
X-Gm-Gg: ASbGncv7xUkk7NTivSFb5HrMfm/BttWX0rIlUKPewBO8j8758zjHxco2L/KSVXAyiU5
	K2kjfgS2JLa+kJjQC8weR2d65V5qqXUJaUDvJQkR0aWkLRPazyqws0HqydzCVmuwIFlriaxABXu
	42Lh3m5TADDdKsYKf6Hz5HO91tQo/OFJh6/jPhl6JUImN1ixtBOINOdJIzgMGyuRV08EQtH0kek
	2NDRaKH8EuZUNFbPvQbfGDqxUliTCjz2mJgrUtO/J3nwiqTvBhWYL9SYiMNYfRFG+qABH3Ugwja
	feZpkomcCTgihYYuqGKaqUrLCmFPijBa0/cVIFo2tt8MSQtuzZmVeq4BCdKduXKF+Asr0xjyOci
	VpUOrsAS8D/paGLtXeRJyBkamOsCtc1JbSUt9yktrfFdsm2w4qQGKbcVjLEuaLhayHoeP6Ugu25
	bBKA==
X-Google-Smtp-Source: AGHT+IGPSjlNzo0y0i/+GbYPAiFlc7JbgHfBpNrj/C4bxPOi+I7rIKsQiv4+wobJzyD79esO6O++kw==
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr27595565ad.46.1760673901015;
        Thu, 16 Oct 2025 21:05:01 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290cd93f570sm13832535ad.25.2025.10.16.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:05:00 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:34:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	ira.weiny@intel.com, leon@kernel.org, daniel.almeida@collabora.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
	robin.murphy@arm.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: driver: let probe() return impl PinInit<Self,
 Error>
Message-ID: <co76tfqycdxhrigoxv5expmozqzgq2rjzxvfkfwqzyvlplrfih@gsi5yarmilut>
References: <20251016125544.15559-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016125544.15559-1-dakr@kernel.org>

On 16-10-25, 14:55, Danilo Krummrich wrote:
>  drivers/cpufreq/rcpufreq_dt.rs        |  4 +-
>  rust/kernel/cpufreq.rs                |  4 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

