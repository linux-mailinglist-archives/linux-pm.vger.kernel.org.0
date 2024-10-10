Return-Path: <linux-pm+bounces-15442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FEA998322
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36061283D21
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92531BDAB0;
	Thu, 10 Oct 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eu3jl8O/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA536D
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554840; cv=none; b=i00+kVT9b/N2XGzcdJ5lQJp4Xe7RpAtoK6X4DpKwXZUHgmRzmfmy0f2faNfXYZqW9IahBpUpR8lsOEt33lwPIvicNNd3dXOLw13PCf91Jo009ZmaddottVJqCNBWCgx3RtjPRzT6iHMYfJGv+cK8EUSH8/ZDq6qLRut0SGJLjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554840; c=relaxed/simple;
	bh=7y7cxuTJHYmgeNz1IQ/OyZKVAv8+2FQ7zyJgmIWILI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxoNj90gfRNrfpgIzlzsG5/tQNFWg/C2E0It6WGK2nJ1zyC9IUkABZ2Ggk7W6/0xupMl4v3I6wMumx3CbvWjozYFnYmUvnsF667zK0oih6JtQDGE6x5fOjPnQsCpoNvPokpCeAr0LtvRSk6C6SWQ5YW5er4T6zupKqXIl1fX4tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eu3jl8O/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20bc506347dso5612095ad.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728554839; x=1729159639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOAjLNr3ULWfKUtF75MCpA435WSZvgqvWL/wFUG5XrY=;
        b=Eu3jl8O/YRXl5E4MzaNOVIJSoK4M160DFFljkdStnqCdTjuza99J6V+QYvVXl3qwXn
         j1eCPe+7F7qhnTgCOvuD1oUUl6y2KIevrPMJlQEVhRhugiUfQjIzhJ0yzRs9D6JBdEoK
         tOoncOSGh3w+iLXBX6mGQcSmzM9HtUBPrDp1HqnKSlDVO4lmcn2fW1UuO8HczqqRgGHr
         e5bGYVdvwF0ic6sO5vJIMFn91dGNGCwJON+n9k086vADgS/7kcsKjxGGag6Qm3qjWFn2
         Q84bCiQ0s8whURiaweuSXAJaI9p7DHxsOFN1xn9JNe01Kh/2PBmIeF0XElN3s+6Yyqsh
         A0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728554839; x=1729159639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOAjLNr3ULWfKUtF75MCpA435WSZvgqvWL/wFUG5XrY=;
        b=WcxRg8QVC/x0ScTDKf5XwWbKLRBozvSA/aRbhOFDyXfyHAJiA1CPz0Zw8QO/zUW6Op
         7ZmhKGN5COQBIwMBc+4o1nP7rrxr5YTzozpJ8Nfjsx8j8CME7jJXCDIGXtrHoAsdPgJB
         CptaL5HAgWBr5i6hC633D/GIaUS2EBFMoiS9l/aL6oeMYFdisxYFuzWtZhTZaG/3fP0n
         0sP5sGUnCt4dUHgLrraU+rPbvnvR/5aHKo0OFFANI2Oxmi45iGNjza7sqbCBn2vYKznL
         Ff73xLLwnGl9sWhx5UTFfjpFPRrEe5CErYEjAfVPgaOOCOoOJQ8I/97HEwvflEQablWl
         LOPw==
X-Forwarded-Encrypted: i=1; AJvYcCWV3YxcZNn5R96b4XcdzLsUT69xyQ47luyuWbOKthaJYUqK9VseJ/SjIpQkZGST1lfpOyfZ6AhbOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnwn+Xm37+BDCjQBHwIVHBA0MXsyB2oqa35/4tiQnKGJm4+mY
	L/6WGPITIjV4ucTGC5y8AgZdZmfhFWEkSIRRyS8IeJvK6wR4+FRCQyJFeiEFZfg=
X-Google-Smtp-Source: AGHT+IFMWfrQsqybIcI0tSDYWOJNHBSlL3M8OpXyx3WEtEF6xXw3hPxQDnu93oiX6qYnV5fBYaBaHQ==
X-Received: by 2002:a17:902:d50d:b0:20c:8cf9:6134 with SMTP id d9443c01a7336-20c8cf961f8mr21657395ad.4.1728554838827;
        Thu, 10 Oct 2024 03:07:18 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e7744sm6783645ad.135.2024.10.10.03.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:07:18 -0700 (PDT)
Date: Thu, 10 Oct 2024 15:37:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
	ray.huang@amd.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
Message-ID: <20241010100716.omywobjusxzrknew@vireshk-i7>
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
 <20241010073541.nxsftik6g3tche7n@vireshk-i7>
 <1a38d478-6e34-4041-9169-ba34996d573c@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a38d478-6e34-4041-9169-ba34996d573c@amd.com>

On 10-10-24, 15:24, Dhananjay Ugwekar wrote:
> Sure, that also works for us, if it is okay with you and Rafael, I can add the 
> u64 field in policy struct.

Let Rafael continue the discussion on the whole idea first, if we are aligned,
then you can make this change.

-- 
viresh

