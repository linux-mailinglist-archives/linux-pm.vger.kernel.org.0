Return-Path: <linux-pm+bounces-14993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E2C98B499
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 08:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60651F22412
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 06:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBF1BC063;
	Tue,  1 Oct 2024 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZLEUNrq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56087191F8D
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764909; cv=none; b=fPQ5xzjzH6iyFVXdbu1ePYRkTIGCLtX/OlUeEy6JcQiL/HO+RX99MuqJ9SDapztnkxj/Ch3AylXSeeotl1AilDOdD8yEB7IaJ7dJHkmMKSjuib48XgB4WbyYYRs8fdQZTFmSOVOINGVIjZPRfEj7wzy6EhA/QmmULs/n/dmmm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764909; c=relaxed/simple;
	bh=YtVW8h8bqOHldp7HwSG/PfiEqEPsdApO6u51GkoDJ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH/9XwdZjs0icjtn1CA4K2Rw1ZSkf1K/u0wJX4Uetfikl78QZykzwlyzp99srCcqun8MW3W0qnZ25Of8fg1mVOF2fTDCUV6MOgtKbllUtInGgHMg/vsowsJungv065oOYIkuO8k2eK0MJj93VsS5QyCMKFOQ+Wt67ld1WEXU7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EZLEUNrq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b1335e4e4so47149215ad.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727764907; x=1728369707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrlCI6gDMqjjvh07SpujHzw4G0hvOwNj3Og9A77/EN4=;
        b=EZLEUNrqGipYiaptsr6ndy/8aAtR41d9ZDSMX8RF1iJB4mqInjey8WOgh6IhHbpUXm
         gImks6yAyICA2Ko/KWXQ0xISLgd+nSaeWaYqJIVviaEabrEQfrreY1GDUUsign+Tsyek
         LBnc/bm5JfV+QhvpssESYQ1APqeluhijTKKvrgSAH1KyUvpBYE2SidvjcI5YCzj/+HIQ
         t59iII3uwZfcjQB7mZLR+yfWqsr/h/24h0lVwIDUq9mz2kIRsYqmM1yI+EtbYJiqqrRn
         Jz46vdLq5K1DV/+svHHkH5211hg+blaO5bOH+s49uIXWih1HPaDRGvhu6OD/Fosv7pCe
         Mq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727764907; x=1728369707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrlCI6gDMqjjvh07SpujHzw4G0hvOwNj3Og9A77/EN4=;
        b=BBQSdk29reejz/oK+ukxoz7Zr7LlHQi+nfeYHtXC/b/RLIE0BwkS9WFJSAxPFetXKo
         yZzH105ejQ0lHhar6eldE0ZgJvkHId78cn/tI+QENWOTYlrNtAOONJQ5dojTPiVXoPMP
         e0pg2BUy/lHcz92wMQGmHG7rql/4mDl/KERcPTgwVK/zkQVWQJjKDWaa8bSxwyOd+dxc
         GhLS4rWrtwoqvn7RNZGbbjbwtJuHVwbSN0ZjVCvRJGbhzigazLDLPYtd9l5lpSO+ba2/
         kQqaLW44QFqFUW3ji1+UnUBmre1frqAmO7ffDBGcTuWSURGPpf7qwG3/70ZKyUzLrNlV
         JbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdHoI8F4DTj53DBH9IQnV9wQJI+VsbUMyjDRckzI/+ROTmSJBsPtzuIXy1Iyybn41RV4uTj9Q0hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycTp32C/8f3W5zmCrlBU81sj0o6QGr7oLlCNWAZhLvm+MwhBj9
	BkF1A0x1ZMx9PWOXfnWGXIqaoxVJuGD7gYmfa5pcSMQKx+m+QZdLupxyDVrntPA=
X-Google-Smtp-Source: AGHT+IFP3u0mkHLILfVEb/4G2eiUN2Rl9g69lxh2r/A1UnM0/qF+U9h+WXBSTr/0YXwcXLpcsRJ+KA==
X-Received: by 2002:a17:902:e80a:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-20b58f2e394mr152709015ad.18.1727764907712;
        Mon, 30 Sep 2024 23:41:47 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37daf85dsm63772875ad.113.2024.09.30.23.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:41:47 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:11:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mark Tseng <chun-jen.tseng@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 1/2] PM / devfreq: mediatek: protect oop in critical
 session
Message-ID: <20241001064145.fnnzcsrewz6pttoe@vireshk-i7>
References: <20240913103933.30895-1-chun-jen.tseng@mediatek.com>
 <20240913103933.30895-2-chun-jen.tseng@mediatek.com>
 <20241001063919.ekqfd4epcefh5eci@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001063919.ekqfd4epcefh5eci@vireshk-i7>

On 01-10-24, 12:09, Viresh Kumar wrote:
> On 13-09-24, 18:39, Mark Tseng wrote:
> > mtk_ccifreq_target() & mtk_ccifreq_opp_notifier() is re-enter funtion
> > when cpufreq governor is more than one. It should add global mutex to
> > protect OPP , avoid get wrong frequency & voltage.
> 
> I am not sure I understood the problem well. Can you explain clearly
> why the current locking doesn't work with details call chain ?

Ended up replying to the wrong email. This comment is for patch 2/2.

-- 
viresh

