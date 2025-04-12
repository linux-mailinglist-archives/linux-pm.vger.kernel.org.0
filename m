Return-Path: <linux-pm+bounces-25317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A8A86EC4
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 20:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF23C189FCC0
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF90820CCFB;
	Sat, 12 Apr 2025 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPnnyI7Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3681EA7E9
	for <linux-pm@vger.kernel.org>; Sat, 12 Apr 2025 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744482669; cv=none; b=N78fQNZ1EB/o3K02UzTaTnBVZlL56tOHY7WMj/FY2Jap5WYm2munjEkLXPn9OKJNJA8K7QyvabcsEMRBQQ8Y1OS8Zeyb2iuE8PBBUGYecDyZ6BneanSJrJlIItJ72sVgsX+SyHCI9gpIJehLcx7w13RLTn2Cu+GskGwMnhx+4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744482669; c=relaxed/simple;
	bh=UXWTbPpVMi3wyEEzFn8t+68PK89c4a+mJ8HY7oopugg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/xu0CKrSNFkrVTGxnoVIf1bGwqBSL8F70jLVnqOCg94QERS7H/bZjrRx3RwaFxuzUK3Nnv7JoAQYX2YXBXIv4iVmzr0cSTsRT8k55Wfl10HIch10sVRo9GyC67zeFz+fyKiUVTJA6LsUHCyToJ0cuVedUQZ7VF22gW5c8/t62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VPnnyI7Z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso22968575e9.2
        for <linux-pm@vger.kernel.org>; Sat, 12 Apr 2025 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744482666; x=1745087466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CyrR9KNkaoIb+djhhX7+16j+DQ68McNR1nNH1QOCtU=;
        b=VPnnyI7Zyl95p1eP3iF0Rjo7IgOUK/ixCTmtTrln3TQLOQX+lTXVj6OWA5jY61Hgtx
         mVJ6YLixpcayFjWddRu9kNNyQkUiSac0r6nWck054BLWZusYkyuNBCTEgpDbVPlheIXT
         CYHvFjp9jQ7J4au5tDMVReIlQ3e0L8nk0DraehaQPa9RvpkMSLm0AP08PbmHcvDJKuxp
         XCFuHz1CIngXkL8XBIsGEHaaWfXKtk6/oEFnva5MlRCABxmu8SHTnKJZzV0W7du/HS9p
         DpmXm4TaUEfa538XDTn8aUNbLxn0VAGzco5iM+Hbs0Asmwkhd/i0P3guwKCLb8AlMK/J
         vDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744482666; x=1745087466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CyrR9KNkaoIb+djhhX7+16j+DQ68McNR1nNH1QOCtU=;
        b=oRXbp5+d/ShsKVeAWAoM4BcdB+EDV0gWce5HG9Z2Tc1Bgy5ktq5FMOPRZXONOARqwO
         7tRRN5k46bAosQ6qmbDCAcMT9lVDF88eD92rJok5M630s6y8FPjq7j1LXgTeJwf8ht2F
         o/NXGYoZRk6cwj7Q0G/1QDT45VlpB0LANfH8gMVzWA+PFIOPq6u9oTgVNR8Q3K4wJh51
         Cjbnl7buVXa0JqyNrlasy+u03umGDvbwUZZmbQ9uy3gOlqvqcCjC39A4pZUG7rzQyQgY
         0a2Y62u+MDibTPHLT6OUQl/yrQkai0SOSVRwAEBs/rD+BTQ6CHpUXd4jeM98nMfp+AHS
         P4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf1/QwDAbd7tfAbiQz1dTAf45ho9bNeVPyhBXxToz3uIRHNQS/KXqUQnJSxiNgYUNZJ/44Geul/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyahHWNucrrfz7VtAccjlR5g3UdFBZ7uOmdqg+tbVR6BiuKjy9c
	Ov66AoZloAjrL9Oj/UCX9VVuPO7cq/XrEy5lCbMekYYHbumJbp9pZJD53Jzyz8M=
X-Gm-Gg: ASbGncvgYXLDbUJor0BMtsjX/bby4alhcXfXLduVvmzuxHmfulNoMpCADQaHCmrofRW
	VN36jg4v/jqIkCJpy5aqvaKsl8gYf8r9U2BrinhnAnhs7uZSYAw50alo39IJYHBt5+sg35XVvDA
	b/15HImqE1vhqmaLVD2bj7LxlLVhXi6jPo0sbDNsAKYfTh7igyY/Jsdk39IpWaWrewYDO/RFuX8
	7dUT+cBCxIQXA83OEDd/lMH2g/dZ8ATW9kfe45znJdRkw4ZTjTVL0mUkS7+CE5AWdLcsfvWkZc6
	Cr90aAff64LvAskIv5DQ6cVaBDM1h4gPfNOcMbiWtHpOww==
X-Google-Smtp-Source: AGHT+IHARGq36rcwuoUqKZ76aegRkcgHirTp4EATHkOfGBZZRYyZYhGL+bYneAm7wceJLq4bHfWKmA==
X-Received: by 2002:a05:600c:a53:b0:43d:fa58:81d4 with SMTP id 5b1f17b1804b1-43f3a9afbbdmr59892105e9.33.1744482666250;
        Sat, 12 Apr 2025 11:31:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39eae96407esm5776966f8f.17.2025.04.12.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:31:05 -0700 (PDT)
Date: Sat, 12 Apr 2025 21:30:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	viresh.kumar@linaro.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Fix possible null pointer dereference
Message-ID: <0081fcd8-da99-47b2-b136-3ea04232046a@stanley.mountain>
References: <20250412180831.3252963-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412180831.3252963-1-chenyuan0y@gmail.com>

On Sat, Apr 12, 2025 at 01:08:31PM -0500, Chenyuan Yang wrote:
> Check if policy is NULL before dereferencing it.
> 
> This is similar to the commit cf7de25878a1
> ("cppc_cpufreq: Fix possible null pointer dereference").
> 
> This is found by our static analysis tool KNighter.
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")

Henry Martin already fixed this in commit 484d3f15cc6c ("cpufreq: scmi:
Fix null-ptr-deref in scmi_cpufreq_get_rate()").

regards,
dan carpenter


