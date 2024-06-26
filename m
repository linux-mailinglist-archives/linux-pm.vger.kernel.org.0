Return-Path: <linux-pm+bounces-10017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A50E9917853
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF2AB23018
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B10F14A611;
	Wed, 26 Jun 2024 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QO4pS3Zl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7AA1442FF
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380996; cv=none; b=Bf90IKa8V30W69MVQZMfJLbNVyQHhePbHngpGtiyBnLIfwxZof0g4GVAyGJzS8si+sFlkb9CnCgO0z5N0JlfqRFqwD4p4TMmBd7mTvyDR/IUOLGslBLQ38IlE0euLA399L6f5D7Sf0S/uDjnP9LG1xO3nhR63Tjr7A1tyWavlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380996; c=relaxed/simple;
	bh=pSUvHg/FzekfJ7fdRGi6Oo5VjVSirznSLEDasE0EhDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF2weww1EicUdkTPWsJLSyHgG+84b/83o/l3GnG5aQSaZIA1+NjizjyXgI6viLosB51pb9xhG4tpSchcXCJ9UXpKO8iwfDs3mqQ00TnAjTycZ1bVbBKZGfke4GienhKfPgGHPc0KHQcs3bQ+DpiRia6Dyg/+vagfMkFP2rp0dq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QO4pS3Zl; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-375fb45f465so22900685ab.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719380994; x=1719985794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=12OtczYzVv5c0Y6UxFLwv0NJ7af5+oHW6u8zmvXCXqY=;
        b=QO4pS3ZlpkoEZYpKvNVq98dJRLWP7k3bXKJ54wDkqKP14Wd4Q8Wp5pp1A38HfHeTMs
         IFnLL/Vg5D4dgxnp5/aJzvvdJ36tM7GDidUOY/buMUWzH74Pa7m+VFgEAsLuAYy3i6h0
         VJkVFlwBAhchZCf8/rJ7B+8+op+m6OAKUha46en4hbwJF2R1TsjmWoDq8jVQXC3kZeie
         IwZ3GdioSFD8GV+KYYuW98jqlAUQZSykkxvWTjjhWRm3d+eqRk4Mm8Ic/Ihc0FptL8ky
         su5P4vxnMsEjlDHy5YlY46G3o4JOYwIJ08udbC3UuoBTYcwSNX3wSe6Ct2oyUQ5sjYgP
         9qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719380994; x=1719985794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12OtczYzVv5c0Y6UxFLwv0NJ7af5+oHW6u8zmvXCXqY=;
        b=hdl5Of1licqIDUlUgJIxKS3fjYnOEx24VW2KHlX+lverL4tXgCdGTXNCIEAe1Lb8EJ
         Zf6FLIowpmmrPYAQpukL47Dr0lR/WzJMdCECmEyEsHHUHbd2BqhcnPLVMmTB7DOOVE4z
         P8p+P7eU6+LbY7oxYczYPcmQtwgzN/cDd+PLVMvZoU37z44iebcTGgbymXI63h3fXR/K
         ZbD+4eNxq3XQS5MFYJDf/J5xlet38o5F6AU67dpGoYCtt2bEQuklOY9vcZmPB15A2lSx
         tSeHv82ruNxovsE2bacha5x9uNM6NrLELhmxwQmhNl2HFBbmj+dgjptdsH+KHndrk1WY
         L7gg==
X-Forwarded-Encrypted: i=1; AJvYcCWGggqYgIdhWQnheyBgxiEmnnyEnXkA8F+kUm5ndO3KxYfOFMqdSgzUwPi5Rxw02/T5twv8tuYq/55xBVWZBperA7yADCMSg3g=
X-Gm-Message-State: AOJu0YynuUtWdDWVGOsufu4GIBa4EhSRZDzwN93Gvej8yxaCPk/nyCc5
	RfwqhOwFiRAiahegw1Qez7lhfDZCB0KMMZLzqzeb6FjHaws7WLk3+3LohzuD1QRRxiB6iCiT2s8
	6
X-Google-Smtp-Source: AGHT+IEruyYyO2J474+j3YG7PqVzM5F1n4MH37X/lEz8RG6Cun4J9A3nA85+az/CEkOVv4lV6sR+rw==
X-Received: by 2002:a05:6e02:1a84:b0:375:9c7e:d04 with SMTP id e9e14a558f8ab-3763b0c07fbmr136526305ab.10.1719380994100;
        Tue, 25 Jun 2024 22:49:54 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba5b5f58sm8075825a12.73.2024.06.25.22.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:49:53 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:19:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] OPP: Introduce an OF helper function to inform if
 required-opps is used
Message-ID: <20240626054951.w6amlrqyaljdjk2w@vireshk-i7>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-5-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619140849.368580-5-ulf.hansson@linaro.org>

On 19-06-24, 16:08, Ulf Hansson wrote:
> As being shown from a subsequent change to genpd, it's useful to understand
> if a device's OF node has an OPP-table described and whether it contains
> OPP nodes that makes use of the required-opps DT property.
> 
> For this reason, let's introduce an OPP OF helper function called
> dev_pm_opp_of_has_required_opp().
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/opp/of.c       | 32 ++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 38 insertions(+)

Applied. Thanks.

-- 
viresh

