Return-Path: <linux-pm+bounces-32881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82BCB30E57
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F86F3BE34A
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3A2E3360;
	Fri, 22 Aug 2025 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHnbbGFB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70372E2EE3
	for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842035; cv=none; b=Ue9z7ow8K0E5i1GVeRVlIsSQUqu2T0jF9s+DtrVeEEiHEthH6HV9mZFInUIhsweLKuXjt/79V6tshsRIoRjc/CBK9XdwWpxjDpHe+egemyqPuTHBDEdaauKd97QBgjHawPOlv5lTP77rE1EJsqvqSv+hEgePf90qFMrVRUFb5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842035; c=relaxed/simple;
	bh=4wc7/VqmVDfbilpC+4CI5l9qIomR32O2gKFjfvsNibE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3/W3NBDa7Vvhb9B3I7T82wGvfAWHicUo/zJdEFEjKWdfbZC4MYG68FOp2Ppn9RbaHjn4S0i/EPE1zW6fhLNb9gaPaYfFa2pFDtzx+51G7E0pldi2AnPeIyCt20y56EkYT1mKMNwIrcgzkPdu0sSQuxiZ3QnAdKJ7IadypMFqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NHnbbGFB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24639fbdd87so2402215ad.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755842033; x=1756446833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRfMPsVFFjc7ryDHEvdpPmW3OI/EuSPBqar4AEujing=;
        b=NHnbbGFBgQIZrMexdm3Z4j+W+4QwNcCd/G32h07PtVrBS2ffFgtJa2FOCy84oXI9sM
         +jAldJjA6bAuNTJxc5J3B9xiKrYV4DRt7oegzLz+k+BbnQQXEqblyqOx5uOngtyIu8K9
         YZ2531sH2I0DEqTk/CWAPpk4DIqc/ij641PI+WOEseouwcyf/EU1nAwrKQLIRXI4es0F
         0XpXQUetUGxAjCitGp0a+ZZPKvsTBVvw9dP6NWsVLlIBk5vnGca4b5fr/rTAebBZhesi
         Z511LgOVKS2CjISXrNH40I9iiMqyf3nVkHVQVGmHPbKiloBC+BL7FezIEXd/i64pAZfz
         9ZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755842033; x=1756446833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRfMPsVFFjc7ryDHEvdpPmW3OI/EuSPBqar4AEujing=;
        b=qGx/OGMTAtYPMmhe2/NOajKsLOv3KBMOGwCzOUoIohSYEBe17hgsPDT21jrS5rj0PS
         J+6DPJ8HTY65PlH2cbbDsJvfst5kJ86exFozTW9jlEH6HOCGi+Ex/VAztmrLhm6LjBNm
         EbcayIqcN1mAA+G5v5aaWC51tSQGZ9AR1U3sPp5NIBQ2BBt8+9UYTyFhwElhY1+zYxZe
         MIRcSd2LfTwFui9Re696StSj9Jn8eA5/ZcXYyNQiACgfE5VER8mcIqscKrdbJrgZ9yP9
         5KnUmhwuaa2sNtH4R8Cxs2jfOaxGFyUfKaxEqepdDbTqH5FMuQMLjn1fZ9BjusgIL7ls
         bjgw==
X-Forwarded-Encrypted: i=1; AJvYcCUtMxUAArn46LgTi4/LILlk1bVg1ZGpbbooxoySotPaAtldvm3kKkVosxOdXrj2cOZ2Cv79hVDdkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQMpP3kOkqG6qLeQSSDZb2R0NCUPTz9fKDZ158nOjVfmO0XEn
	lqDGv2sLExtXq9pva3HkcKd+qtA2aOr5TWXaEijxNxvJb+xnkGhsMWeZG+8LmTuXRA8=
X-Gm-Gg: ASbGnctDprqXIRr918/jt+LaakROIukWWhZT0LO+PmRxIkwgsGPd5RrB8+9UeHB98Mz
	/jNSm2JXCa4feuhqqaTQY3Q4+EeFe2w4txal4bmTmBgz9Rb8EPy5xQTDw9zftFSRwlPha7rKUvW
	fuzlQioLsKXQRZoE1m1XN+Mg57kUHZuRgqdRygB1W62D9iLqoRutmh+F5ITPjvqsSIo9l62VqOY
	uPkw4rWJEYIdt/KzJcomrEoDrde9nOiznke7iUMRP2FZOuVqWjt/qAUCfplGBAEL0E7GKtfwbbY
	rQOKt2/O18LW0Gv6TU4l8sxNE5FdlJ43KhnM0KcCkvh0VigHtXXnHuhIT+LLSvzwzXf8mi3fbjI
	sstup89Pj92xjY5f7fwOHsgzk
X-Google-Smtp-Source: AGHT+IGDUhRl59xu9W6ouXglnOGMNfVPExl8Z8m2MHMr5khzXc/sDm3TLhU4hJY5umoiXpIgj2VCDw==
X-Received: by 2002:a17:902:e888:b0:240:4d19:8774 with SMTP id d9443c01a7336-24633d6a31amr21624495ad.24.1755842033049;
        Thu, 21 Aug 2025 22:53:53 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51b3d3sm72222245ad.147.2025.08.21.22.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 22:53:52 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:23:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, vireshk@kernel.org, nm@ti.com,
	sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: use to_result for error handling
Message-ID: <20250822055349.6brvcxtljkz2k6p7@vireshk-i7>
References: <20250821091606.7470-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821091606.7470-1-work@onurozkan.dev>

On 21-08-25, 12:16, Onur Özkan wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/opp.rs | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Applied. Thanks.

-- 
viresh

