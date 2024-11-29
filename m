Return-Path: <linux-pm+bounces-18220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F368F9DC09E
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 09:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBE7B2081B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945A165F1F;
	Fri, 29 Nov 2024 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKIhLVOH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D915A87C
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869657; cv=none; b=MmWnYNm5gZ63CXv3KZbFHuF8DGgTkJTljO1Y6kaFUOY4MMZImL08mOQJxG55JW1PdwTjqo/JIk99sc7yimwrmMEE6AqLKQY0BzjTLhjBQhTR36+GslauPGsHYQWgaPyV2Tj6hw2t9QABYHiGOUC1jOoaHDNNRRO2VJwgyrHDoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869657; c=relaxed/simple;
	bh=ltzMSsQLYC/4qUZo1d3pV9RN8/HZ7OnfIqYqFX8gARM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYrzBO9Qi0wR+iQ1AtUDHSIzxMZ131voamuDK6V3+1qvDoWdINjwaXhExTtTQrsGxDWL5QaG7SfVN0Wchg0w2oY/Mc0iwLi31gULO5XW+kkSTXXB2u5wsIhCahyFJpX7QCjloOQ2CtaDxekS4SUGfj/p9wVS4Blw7QJfhAdSnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKIhLVOH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724ffe64923so1665504b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 00:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732869655; x=1733474455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbwQYpitovH5oQlteNzxBXcjWfkad4Wni/HhJDybuVI=;
        b=mKIhLVOHjjP8eIzyq+7Qkm40Mg3TYu7Qf1RIUWlt1Tn8dGqPIXATDWVT+b1jkUa+PR
         xpEtHabOZKCILFqPKw8D5QceYFe6PcEJDJ3l8gleTEwlSR8TC6OjuuwZHa39m8+MoF14
         LtgYrHOrM9e3lUP++wIvBqbDzYOKfdf1JRL4d0Ky47sAThbNTKr8hysTLmkwJTyIAyhz
         JtSdPA3v1g4KGs+oNhj/58rWk6nZf+Y21f5D4JMLjLvZyF4ZoQF1udxi0MrRCs+Zna8Z
         8xa8Dd5pxB01BzuD/mDU2x0uXaxx0/3f31ROFGj0vrROVJbRxzqRFN714bPpgUiQpkRO
         r+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732869655; x=1733474455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbwQYpitovH5oQlteNzxBXcjWfkad4Wni/HhJDybuVI=;
        b=ehjZtzBG4KfgQpTmaoM8TY7XkX8UtiimPPfzhf79UcC5B0vfR/ldGw2bRPsef74nrM
         h7C7UPs1FJvVdmkQULjfGavwWb//S+v0Zy9i3WxDHnWyCMQ1tN0Nk2Bpl/02KO6gQCtT
         ssBIJvSWgk/DaXgfT2P5mPjh6WwifyHkrHm1bTVhM4zcTQ0RzhD2gi+DlhW+48FsbTmx
         y59Y5AtllA+u3fxeqy6k6442Q4zZraKDAYAuTpnk0qLXtwjluVDPM3hUUArUB2lDwu6T
         G9mD+tDW+XTnQ/QibrSoQgvxWy+XadISZ6PdR8guGUR1hUM5eghXFF3MCzmBEPH+GXRL
         IFtw==
X-Forwarded-Encrypted: i=1; AJvYcCX3zftABKiQN9QP72QyBfXpcOeMrjfsQKvmTaFCmGuS+LEwvCiQ6UgsQg91/e5JNWY1O1PiofRLbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yiTfy47GjBjOvapmHJWxe8TagRJXTSqOHAqqSi1Sr93Kseoi
	Ex/pGsy2O/kBqJ15mT2N7D+7t+rgCnYuK2X8cC2Vl/VvnlBz6vdjKTCmo7DMx28=
X-Gm-Gg: ASbGncsfAwol4M0hwFmg8x1+a04ckW1XuyjOKIi+Zm6iMJGEqzW8phXAQa+lfvez+uq
	cjqyHNn8VsKSfKeUk+FmZeQShv8sZsiqNd3rRWrzt0lpEz3A42IxWxiYGIAHlXW7GeFS6Zvn4Ab
	iFlKw1SCzvTMenMln1g0qFyrW061dB8N43J3vlHmY85Du+07VPvRtHt9upYRqBAiqkG5Bm6HVh6
	/4aoQKShQSAJGBtM/lcZxvM2pUWsE1UAD11c5JTy/IjIVTRKj5r
X-Google-Smtp-Source: AGHT+IES7KHozRR3CC4f/KofJkNoePMuMocdqyoM2Vahg/s90rTfb4PjPf5nBfVGqPl3tpw4jaSNHg==
X-Received: by 2002:a05:6a00:22ce:b0:71e:5b92:b036 with SMTP id d2e1a72fcca58-7253013e930mr14090384b3a.22.1732869655100;
        Fri, 29 Nov 2024 00:40:55 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541828c61sm2936394b3a.163.2024.11.29.00.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 00:40:54 -0800 (PST)
Date: Fri, 29 Nov 2024 14:10:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
Message-ID: <20241129084052.wfi7nakgcnt3zkur@vireshk-i7>
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-1-cb8bd4c0370e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-topic-opp-fix-assert-index-check-v1-1-cb8bd4c0370e@linaro.org>

On 28-11-24, 11:07, Neil Armstrong wrote:
> Pass the freq index to the assert function to make sure
> we do not read a freq out of the opp->rates[] table.
> 
> Without that the index value is never checked when called from
> dev_pm_opp_find_freq_exact_indexed() or
> dev_pm_opp_find_freq_ceil/floor_indexed().

These APIs aren't supported for cases where we have more than one clks
available and hence assert for single clk.

-- 
viresh

