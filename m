Return-Path: <linux-pm+bounces-1714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B529E8217AE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jan 2024 07:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C591F20FD3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jan 2024 06:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FBF1858;
	Tue,  2 Jan 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFrbBfB5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C415CA
	for <linux-pm@vger.kernel.org>; Tue,  2 Jan 2024 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d4c3393f99so3555815ad.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jan 2024 22:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704176749; x=1704781549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezudi6jLM5VLjqPu4bAcNVcTI26aFcnMsqxplzeyERA=;
        b=CFrbBfB5juUneDuMDK3SFQLkOgv09nlYK4RqNcvcWxKCsopRt5Y6pNrcjfkLJhJ/fq
         1pHOYvsBYOqC+0VBbMp/zL8jsIKCGlMnU7mEn8e4gQ+JdqOzwN8kmB1WBO76UL9QiI+Q
         7wkoCxA7pZ5cJzFThOeGkLMl3jZTPrOUwEyxOzqy0n7DkmyNPZ3hiDiftPRvTYDgHdv2
         j8R8kUcEJb7iwFRpgzQqDCuuNJ170XaLQpQR+uHA/CEnHO3K+hvk9wKM6+NC4Vj4bWy4
         KdCg1PyYK1vFO1ucQLJ7KHAq9peiwZhvhNzebsT1T/1GGdqB8Y6WNsHnIv4W3tgx9Zka
         h40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704176749; x=1704781549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ezudi6jLM5VLjqPu4bAcNVcTI26aFcnMsqxplzeyERA=;
        b=FyZsvpX++L4+dltR2zKRAn1BkmmPseyEGYx2yjvW4R93UbiDnfAMd5pHRo5IOihmVM
         NyGGNPaASWzTrnbBtcOr5TzgH70WKe7u0stJZBBUV6t3ot7rqpIRaFMIOUUhrLU5djz9
         lmpYW93/fn3mhY8yBQ7upymcrbOf9YGLU+ZuYMC7lOxOfc4V0aDvcVVJecGuVD4mjy1b
         n+evO4WFXN/LYWCeWSWVMiCyM+ghxzXaUgaPdflcKbNiqSuuTzAbcX8K9VmXiIap9gEJ
         m8434dsAwhaoI7g0PtSn72vO8kdF67ackBtfOLNerQ4pSKUGRfpcSgtPRCQ2Ap2GwJg5
         f79g==
X-Gm-Message-State: AOJu0YzXSpqbibM5jgKmSHC4qzq3wVSnAhhuO2VfaLJ2LQtf30s4u++l
	XxBWxJd3qi7Y24botGtm0CZwso6YzPom3w==
X-Google-Smtp-Source: AGHT+IG8RoUn2lOLhQxfuWS6czwFFzvzj+yq/w7xBIIrrresiaj7KS/ia9C2eRfGtjuKKFWio60WGQ==
X-Received: by 2002:a17:902:c652:b0:1d3:d27f:77c9 with SMTP id s18-20020a170902c65200b001d3d27f77c9mr14807221pls.14.1704176749072;
        Mon, 01 Jan 2024 22:25:49 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id ay5-20020a1709028b8500b001d4ac8ac969sm4371115plb.275.2024.01.01.22.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 22:25:48 -0800 (PST)
Date: Tue, 2 Jan 2024 11:55:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/5] PM: domains: Add helpers for multi PM domains to
 avoid open-coding
Message-ID: <20240102062546.qhd6rfp4l53ubfrv@vireshk-i7>
References: <20231228114157.104822-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228114157.104822-1-ulf.hansson@linaro.org>

On 28-12-23, 12:41, Ulf Hansson wrote:
> For OPP integration, as a follow up I am striving to make the
> dev_pm_opp_attach_genpd() redundant. Instead I think we should move towards
> using dev_pm_opp_set_config()->_opp_set_required_devs(), which would allow us to
> use the helpers that $subject series is adding.

Big thanks for that :)

-- 
viresh

