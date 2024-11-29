Return-Path: <linux-pm+bounces-18223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB819DC10A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 10:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E921D281893
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE94F158DC6;
	Fri, 29 Nov 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snOZ+VX8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46D143C40
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871102; cv=none; b=V/5dKtN7zSX+GMMugu9PxmRbFH9AB6m4uj9Ah4AT/iToHkSh8FXV6g0QDJ6yu2T9jnjY6mCyJci9GL3uf0epLzSAlXpkQDaRhZMG/ZmIpLsXL12SXApUwqrKNO9BToF2DKgZMdH3sr4hL5rFV2aQ2DT5+KqJPoEbOLoDOhG6cC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871102; c=relaxed/simple;
	bh=vO9ByBT/SONTBhVHpVkxBH/3ubi5rKJXvHi2ak4c5rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr8YYrJr3HV66q3G0kTINgYRWDqi8Dg9ERw2cd7Gy8deeXejqbcr9+ibIUC1U6qWq5Md95hrmJGaRuh8yjj7UM6tGyQ1O6NgLOg+yDT23i4k0C9qrrI784R8B2N2pcXcczMMnmzPBJCQZB2HWobhtA9fi931kKB9cGXNwNYDd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=snOZ+VX8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-214f6ed9f17so13629495ad.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 01:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732871100; x=1733475900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmzgYiTHuT38Cq1Mm5SUp1x96rSOx0XuBvQMGFzhB/s=;
        b=snOZ+VX8GgUZEPuf/7YeaZGbp3HR1aCyAOswJ/zlFoJgZsvcsBFPhJOiJcf7Nb7J31
         GuBYXJCQRUu31MTYIuxj9nsEi9EbAtysPGaZTKpZMT3Uer/G0tOB/HqV7FjxcnJLI6SA
         KHhRGHpFcrZc+30TI4RWLJ5WhGtigHqHdY/HPSyzpdiq+LM8FGWWuYn4yomdRfpc8v4D
         gz8vF+OUHc8fliXpkjM8ENc3yWKofqOqjS3qYbVcSxjqEb50WUaZMNu1LLtOOeRonX4s
         0qGUomDOlTjjkf/Y1scXVJEi7ZJrvsbb7h4XQl4t5m2dVgHlMKuO7QLYSnZTrrJAQDj9
         37zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871100; x=1733475900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmzgYiTHuT38Cq1Mm5SUp1x96rSOx0XuBvQMGFzhB/s=;
        b=Uj4eWJlD0urNfvIok8Dii2iwqXmgdZExUFB4JCBSV48wlKgT75KLQf/QgGl5RuGh3Q
         BmXR6e3fEjSf9cBZ7mA6LRlq1Rnh5bWyxPHAePPCqVEqty39OcRmDJfE9g6HB16VL1Z6
         5PKWe962Ob0/4e+28p34xKlYco+4Ie62QKqPA2ABK4N5/Y5cO0gxwTnDd9s7clncBiH2
         +V4K6hcpdRRVmsKPApu2gDXe8/hCYZMlfkUsJaEUJAqsxde21MVcoZNyEjiGksHpu9+8
         vM9FmGLaX8qRX8d6C1StlPzndwZyUBQcjBIbZ6x0XQJJqtZm7x8kJufAGv4yIVBaP2eM
         YUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbMWMfg4wqrvTYRKCZUo85CLXE9Rnq83yAjeEnNadipZFSRvTComjFYXimNo6yPWnbp1YvMma/cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqU8UF6efJ0hXrGUOgbTuvKaFc/S9jsICVkXGO8aIeui4f4Yi8
	NK+niXxj2gwxk0O1nDRv8m8PWlVWtKRX5i1eyQ8dGgZKAC1sm2lbPOYTBbVYcD0=
X-Gm-Gg: ASbGncsea6BeJY36gf/Rg1/51TJjLdUaC2yX2rJVL1Z1gHPV5H+qpfJ4t88x58MSYbX
	V9kAEsFA/4QCApMzyAUx7uIm4V5oTwWcwNzoXHebo8yLyycgEP0G4nF9FHOmQPxZvlJnyM1gF1K
	D/Xcr6aAf/xOxT8x0jyq2+iyT4a6n+vYngEpkFPy77pcVBP7SufV3UJWJFxZ+NDmJ64zqufEdyu
	xidGsvmEXSYRvuEyW0X2/lRMRWtD8OC5rIarux94jg/mDdlTez5
X-Google-Smtp-Source: AGHT+IGg1qw57WoQi6dR9QPFZwX2ihLooOHM8ZDLeNgvNGkx/nUn4iMKoXAEtGbpgf57okVCQmDWxA==
X-Received: by 2002:a17:902:b716:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-21501d6133cmr117311875ad.46.1732871100576;
        Fri, 29 Nov 2024 01:05:00 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21544fd9b4dsm6314165ad.223.2024.11.29.01.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:04:59 -0800 (PST)
Date: Fri, 29 Nov 2024 14:34:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
Message-ID: <20241129090457.4ibsyulffydnc3ns@vireshk-i7>
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-1-cb8bd4c0370e@linaro.org>
 <20241129084052.wfi7nakgcnt3zkur@vireshk-i7>
 <c6b5b6f7-ab55-4d46-888e-f9e00b269c9c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b5b6f7-ab55-4d46-888e-f9e00b269c9c@linaro.org>

On 29-11-24, 09:53, Neil Armstrong wrote:
> Hi,
> 
> On 29/11/2024 09:40, Viresh Kumar wrote:
> > On 28-11-24, 11:07, Neil Armstrong wrote:
> > > Pass the freq index to the assert function to make sure
> > > we do not read a freq out of the opp->rates[] table.
> > > 
> > > Without that the index value is never checked when called from
> > > dev_pm_opp_find_freq_exact_indexed() or
> > > dev_pm_opp_find_freq_ceil/floor_indexed().
> > 
> > These APIs aren't supported for cases where we have more than one clks
> > available and hence assert for single clk.
> > 
> 
> I don't understand, the _indexed functions clearly have an index parameter
> which is documented as "Clock index"

Ahh, I missed that there are few _indexed() helpers as well which you are
correctly modifying.

> I agree we could leave the other ones with assert_single_clk, but we would
> need to duplicate it to have one with the index parameter, so it felt simpler
> to use assert_clk_index everywhere but indeed we do not exclude them for
> when there's multiple clock...

What prevents a user to call dev_pm_opp_find_freq_exact() for a multi-clk setup
after your patch ? As we use Index = 0 here in the code.

That's why I would prefer the earlier assert for all these, except the indexed
ones.

-- 
viresh

