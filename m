Return-Path: <linux-pm+bounces-37718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97531C463EA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE9224ECA03
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B730B512;
	Mon, 10 Nov 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7XBuqb6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863130AD0C
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773881; cv=none; b=eSoqCyaEUaIiNoSbkJkiyEHyxCBR7kfSe+718pwtCW9bde1gYwzp8LUtfeDcGRTrUd5t4hf993c0XXHtQl3VtNwxNIAGcNnNFCn8hyLO+qI1BBNOOTWVih3t7S0fQAU9xetO+N8wdlpdwQ+WjIXnyCfmWsGBHDLgk9yCPjIJsfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773881; c=relaxed/simple;
	bh=VZG4ADvxmOQVKXoG8pF38F0+M2qbCM7PhQDQ4O9N4wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bjf9rlycaJhBznsGLA6vLG0wBknHAoWdYTR01lRE2YYxDZZQeJ8MgyG83kK3+GXulUF42F0Hp8+AZHsMh8aRa4c55ZTUhWlMCwdfVQyB593lcpaiJRXspN2TGV8sHOX21iLTtl8ChIhXa7EpfjmgT3rW8+Z8aEJ0XY5nq8XIvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7XBuqb6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so3019607b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 03:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762773879; x=1763378679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vMDkjQGobsOv3RR6xr/uyV8xnVRXND5aFdVyt0tgcL0=;
        b=f7XBuqb6sBMF6DaAsQ3/yGe1CPap8qfs+zBddr9yvZWwkj8nNbL59JiCuU4u8tKCf0
         95vXGUlmwnydx441+Nw9lAxi9ZS5lHF35Xvni6TqHQkOQ9gMKsV++rtuHkbU4Z9J9wEi
         WYVoo1bpWkUj/vA1GyxhOElFMTSrZR288WCKsmTsl8hKPTEB9iFs6nJqYrmCp7YtUGmI
         cf2wUEcc/rGWAvK4t0eQpukg749Rv4vVjgvxyknBpgMoog5K544oQVHjmo5M2GLgRN7x
         7GG+Fr4Ele5NsTMe0jGMRAHPiCyLh9qS+QNqh8QCdi4GxP+TDGleYuIGylt0QxD+WNqR
         vk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773879; x=1763378679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMDkjQGobsOv3RR6xr/uyV8xnVRXND5aFdVyt0tgcL0=;
        b=N1hcHUnFrsRcOImprdLQ/xf2iwp36d8ifIMQlz2cRnb8aOOus9eWXg8xWgHmtv1/2V
         6CQUivkIc7j70Uu4xxpAua6zgHrRioUGGf6BDjPdL6YsF0Uafs8FhbiOAmcg0rnZTajU
         o9w97nmtSAc3yMZ5mmdnV6RdD5rWB+Vlul3NOCOYM41K01mg45ATvOkp4Oi/HmwrM/Ts
         el8WimvEWskXbdXiGOnVD4u7JLjZsRLDYl8ZLvx4VnFBPtE5SzZRYvOgrquro2xoLw44
         Ynd3OKjKIJaljQq/sLdXJP/dhbsWmb5+Ejh+Zn53JbaOAb3ZKjtI+X2mTr/1kn17u0PQ
         mU2g==
X-Forwarded-Encrypted: i=1; AJvYcCVWc1i3ZIfYtteabK4P8XeX2dUpjRHV0MQ+vfpsYKCBKWlkABBAqUwKCZ/EeY9C1EU55l1qkLwgEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSc1DucQtUhqR0SvxsiDKxeKPF1ePzX8K1nx33CiWj2COcfmB6
	pZR9pJCvtoeqDErPv50akg5+FpVysGeClLhzdCVyLIckzUxesBAvEjC+NZjoqH3Gbhc=
X-Gm-Gg: ASbGncvBqPzNiXVjOuzaHHUzyTyZaEl/ScfIP7PARVgO0Re+T9fGgtxuuKsslMDrN+I
	3uWdqYSuZf32HMBSOqfMkNpjkCzG6QWn+f9aMqygJn17J70lew2IiMNTf/QCbSwtBKkbAsYhC6R
	+/wetVTkMoyHv2mWGgV1f290wmWIxuvK85WQIdlwviOjcQVa2lafd1AZXQ5bkhwPbrUTZhD2EOn
	bWD13sV24757p2XHHTVuXzxGNiRsVG1ZcKhfYWo2VJ9FJVdewpsAoHtHbA9Eue58IDimSnokiUi
	CVHmraP+n2KAaMsg0PlrH+ryW6luKVKTLbLQZ7i4Ro2App0O4ofg1ZmxCYXdyQ0zgOCF4yb4cky
	I4ehahvhMHmYR8a3CfOg5r2nfa6stXwnPW0CRDRefXKnuWVQ91ijSU7G5ywDWM+UhjqvyqTzbZb
	G4
X-Google-Smtp-Source: AGHT+IFAkaqN83yZLc1MvlehEFP3AsNvnAaW41gBCIMnAllwfEShHWXKI43+yaUimozXj7v3jpkizQ==
X-Received: by 2002:a05:6a00:228b:b0:77f:324a:6037 with SMTP id d2e1a72fcca58-7b225ad97f8mr9670962b3a.7.1762773879445;
        Mon, 10 Nov 2025 03:24:39 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9f01821sm11646876b3a.26.2025.11.10.03.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:24:38 -0800 (PST)
Date: Mon, 10 Nov 2025 16:54:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	ulf.hansson@linaro.org
Cc: vireshk@kernel.org, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: Queries on required-opps on calling dev_pm_opp_set_opp()
Message-ID: <7paqqdkxfxd3hz76o7o4q7pkmc27czqtn3smffpkwoha7bncdq@w7ik7v3c5uwk>
References: <8e542a9d-132d-45c3-b17f-1dcea4bdf337@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e542a9d-132d-45c3-b17f-1dcea4bdf337@oss.qualcomm.com>

Hi Krishna,

On 07-11-25, 15:25, Krishna Chaitanya Chundru wrote:
> As you are aware that we had OPP enabled for PCIe[1].
> We plan to introduce a OPP table for phy node also where we want to change
> the frequency of the clock based on
> PCIe data rate it operates. we planned to have the reference of OPP table of
> phy in the controller node so that
> when ever controller node sets a opp then corresponding phy opp also will
> get set.

A DT example could be useful here.

> But currently we see calling dev_pm_opp_set_opp() for required opps is
> removed with this patch[2]

Yeah, it wasn't working as we thought it should and moreover there were no
non-genpd users.

> Can you tell us if it is ok to call dev_pm_opp_set_opp() for required opps
> if level is OPP_LEVEL_UNSET
> or is there a way to know that opp is for PM domain (maybe dev->pm_domain)?

Yeah, something like that can be done.

> if know that we can call dev_pm_opp_set_opp() for remaining devs.

We need to figure out voting aggregation in that case. For example, what will
happen if we change the OPP from required-opp call chain and then a driver
directly updates the OPP of the required device.

-- 
viresh

