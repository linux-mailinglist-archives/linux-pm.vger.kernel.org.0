Return-Path: <linux-pm+bounces-9983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D789176AA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A19B2112D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342ED433B3;
	Wed, 26 Jun 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCqV9zp9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAE175BE
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371508; cv=none; b=tl1pEKH1T71XX7UmT/cRacEdZn569wJO+XlkecBuIrQ8eZs10oQ/Re8Lu4FZtvpVE6KG1Xo9qjdPpChWSkvHeF9AlkUJA70Fb6ecIFClpLQ2+YUMmv3p53VsErqWdStD+xdW9mCXngygg7L9lyNIDXFX6Rijk3oshstqmcXGZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371508; c=relaxed/simple;
	bh=LcJPCpKjl5eXNauT23Z//zH1W+w53FoPGhUbtxB1TXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvCsdWsj5J97xIjmRPRWuQ+XGXksPNkZgC+rH8MGYCyL6FpBnpghrubTO/VRghlaECGLyW5IwaCbprKfEA+m5Us/L1Kpg4aOGENsWG7xPjvTa7TPIAIUrzVwdHSh9H4EzWIXXQ4uS9pLtc64cdFVuOcHypwdJKJslsx9N6hZHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCqV9zp9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7b3c513f9so4809467a91.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719371506; x=1719976306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46lK66HMyTXekDrj9mrBTMry24375OQ7YAvAgU76C30=;
        b=CCqV9zp9lVYAE4Np4744yvRKdUAtHysXRxNYycBIFz0i8VxSNCRpW9ga7QifRjdELg
         NGivA05Jg6ncm7/lkaIU/Hok8N/6CXt46DZPT49kMNJQkDDa71v+dAsmro5uid4keFH4
         KjwfYkvPadrjDZbG0NG0TfC7ituL7uTwmVCc+EtvZ2TXGOnkZlyBNyvt7/gOLSVbc3DA
         nk+PS62GFbRClkUewGAztzLb4v+BhyCO3jOW4722m1vR7plDZl4IWu40fszBTF5D9GM7
         VL/aLm4+6KwrdXfCdJOgNl02RHxpy2RwpIp/LEfW1V2bmN7yQERPCHMBZ1p/Y9A4u36u
         TaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719371506; x=1719976306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46lK66HMyTXekDrj9mrBTMry24375OQ7YAvAgU76C30=;
        b=AQw7WSVkrFxheaqSz/Aie3MLcPItYa7OGs9UCERlFzYrx39EyRSDy9z0IFV4+N96ow
         7e7oN0MTyvaV0Fd9hSknrnQvUmYpsm/a85OoNtJc6SP9RElOHvcM7cJrB3AXDeQqP4jR
         SWlhO/ep/zrxou1aOJmT+hPj8n4Ha8Y65jNIOLyvJrhnYiGM9U7ClOVfMhcC9zDjYA+G
         vyM+AFIi32TbX6zfAtnPnUxgV7RJrbijKAAe/D+ealzaleshcnZP/Ul5pw8c/YH4wd77
         df0k4aJbzPxnxoQPrMu8FMcbchbzrIhVkSOfMMuzBEuDbkLdYQ966aya+7lyhSvBgub5
         oijw==
X-Forwarded-Encrypted: i=1; AJvYcCVDzB70Sm8XVdo0ISNeLrqDc1cu42D4g+DPVotn+epPwzOZv13wT2q0kSvKIc32Z2rCEeDKRhDxmtwgpCmNCljtbzK2dpt6tFo=
X-Gm-Message-State: AOJu0YydXkeodatz9xHkhQ2AryiyncsxjMECwEIvoWQFK4o6uaZBZO6E
	i9+3htLIN0y9pdvtouGfC6j4OYFV82BQKb8H7bHyTplcqLz/AyLiSHIjSqWjS6o=
X-Google-Smtp-Source: AGHT+IFZqJkb01vkxqUuD1B+RLQCUk9jlaPwt3GuwtTJ4gry4YQqwXrfqmE/veMPo1NnYB7kjxzuBw==
X-Received: by 2002:a17:90b:b0b:b0:2c8:53be:fa21 with SMTP id 98e67ed59e1d1-2c853befb16mr9513851a91.34.1719371505744;
        Tue, 25 Jun 2024 20:11:45 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d81b464csm407005a91.42.2024.06.25.20.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 20:11:44 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:41:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
	Linux PM <linux-pm@vger.kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
Message-ID: <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
 <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>

On 25-06-24, 07:31, Mario Limonciello wrote:
> The core issue is that there are drivers that have boost functionality but
> don't have a frequency table.  As pointed out by Gautham there are also
> drivers that have a frequency table but don't advertise boost pstates
> (CPUFREQ_BOOST_FREQ isn't set on any frequency).
> 
> So what happens is the driver may have choosen a policy to have boost
> enabled but when cpufreq_online() is called it gets "marked" disabled from
> this check introduced in f37a4d6b4a2c even though it's previously enabled.

And who was setting policy->boost_enabled to true before that ? Also
how will your patch fix the problem ? I don't see any other code
setting it too, unless request comes from sysfs, which would work even
now I think.

-- 
viresh

