Return-Path: <linux-pm+bounces-25525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C20A8B2EE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637803B0C76
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0DC22D7A3;
	Wed, 16 Apr 2025 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSRdqTw+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62031F94C
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744790722; cv=none; b=Z9vl647/Ir7Nyu4Fshjsq5qamh4P9qd7eqjSaXy4Kk4ScLjnrRwd0cWDBBcHVrt6qOH1ZYDB+FcvJfJN1AErkcmkFEuehc8/kBjCHaAqrZFIfl0pUdgao3fRwUhFikB84FhH89wOHaBI7ssskL09x/9QIh4VV4unphUG9JW0jBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744790722; c=relaxed/simple;
	bh=WsWHta+JMAg/6F0TNR0UBnNl/C11bjBp6muXAtHOYx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVANOuKbbP7649s+B9VhZ2BlhE25uM+5XACZIIXkM5/fbdD8MRqDHjyBIRI7wdHGZpQez3mqXqy8QfileZuYf0ZWKKLqig6uXV8Bsj3mSla8pfAz+e27zBdSIZc+FTpehh8Ix3Aeg8ol3D/iFA7yxfcdcdB4EAZw8AtIE7eSjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XSRdqTw+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736e52948ebso7303296b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744790720; x=1745395520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=inoGsYpigja5jTUghwsLjcEVgXmFJ+nXb0AjbaYD9QM=;
        b=XSRdqTw+n1Mam73vjtRm0CtBFwy/BcuWZNAE2njoNHVVtskrjTWhMxgff99BZ2tIBk
         ywy2+kw5Acv0GGgr36N4tkDxofw8eXi1sqdfQHPUKpxYmsPJpjdFXM51HgqixPRLkoi4
         Oo0T7EE+Q0VfduFebDN6ALc3K+qubXKgi+wb5nWaENZYDm9YPwlsmk4tDGMW/LeGarUX
         zCIwowcNGf2FZqSALUtoquLizeLrSTNQRyxglR207eiELjH5CBNu9zWD5eW/PFhNISW0
         pwsAS8c9SZLuSjmkAZB3OhNudsXArzbGdQSwmjeZu0VsF0h4aEbRZDy5rl8xPeBVbQ+J
         H/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744790720; x=1745395520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inoGsYpigja5jTUghwsLjcEVgXmFJ+nXb0AjbaYD9QM=;
        b=hr+mlLNEPsb+WhE0LCO/SF+O1HC0JOy7+zktIhJMirG7YyY1VM0Q/FxwDeSXIZdiEY
         e6yDbM+xMIVafZmgM3dwsqY8Fc/PZaK1k4X5utmUj/DqL2hKL6c5yvjKoEaj68E9GSVh
         gWmekYMHeQ19G4LV2bqclmcFuEFrXNQeAf/iRwHYChfgb9pKujVNVXvJwHQ88IaZrm2v
         qZEYZ2qpwZi7gnxhYF8eIbYOJfvDRLKofm4i4q/Sei/Onr6COeOgB+DdJLxLvrstQWnQ
         cmzN70GBHgSMLEQx4zGkof2tmuntk2c4JIr8ft8C4Kdj+Zzk4x214J8nM+GG2JGAH0oD
         IQRw==
X-Forwarded-Encrypted: i=1; AJvYcCV3DqkHamp2NSd1/ZHigsNufK5phWJqoGMj6XeWODDkDoroC9Qdl2sXJGt52fbyWkIjKSgDTq6bWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2qEuw8uVQUWwt5dMnbvCGeiSsfHCufRt66k1ZBH1g/mtyFno
	7ObnwJx0ptrOvB9bosbJTBXR7FRP5GgVhiy0QouZt//wjLRa7DnGQWAxIYppfM0=
X-Gm-Gg: ASbGncvs6eatODc09s1K8TdliB6SbJxT6tvY84kOP6gCvuvj/ubMWIQs24UMPnGnJzr
	uWw6XlNZdjWinekOnYEIA2p/csaMldSQ5ptB13g0+uz8JxMBQC2n6vLlcVb2B1hNVvkzcOkHgxX
	/Y25ECiRO6Ad3+HvM21taAQnGwgEpKjPegutVhPz82jxaDgoW5ZGS04fdwVXMxumwwj1WJ6pPsu
	a923v4CNkDmi4+9hDJox7rXKuTsHPdl6vuoYh/Zf20e3hvdF/gjEPL/qoZCrecyKc9lzgpdPlh1
	Y7gskjnaWPInAAbQ3mDUZ/MVNMLWYNSLXj1L3gjMJN8mLnzGE80D
X-Google-Smtp-Source: AGHT+IHE9GKOiXUJRd9ZbjDhVSEPnNsM58LQq5KKO/sJrxGQ10BPtZiiagmUa7v9I1/Pe/Ala+WMrA==
X-Received: by 2002:aa7:888d:0:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-73c267f1bebmr1314183b3a.20.1744790720067;
        Wed, 16 Apr 2025 01:05:20 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230dd17sm9721455b3a.129.2025.04.16.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:05:19 -0700 (PDT)
Date: Wed, 16 Apr 2025 13:35:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>
Cc: "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Message-ID: <20250416080517.feansrkpycsynk6t@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
 <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
 <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
 <20250321060148.adhxjexpnm4dkpnt@vireshk-i7>
 <e1c2c12bace22d1803d16ecbfb32129518d87157.camel@mediatek.com>
 <20250324054333.sgwwksawnybx3lp4@vireshk-i7>
 <06356a55cdb3c34dfc716349d1967f95655b0ab2.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06356a55cdb3c34dfc716349d1967f95655b0ab2.camel@mediatek.com>

On 14-04-25, 08:42, Chun-Jen Tseng (曾俊仁) wrote:
> Hi Viresh,
> 
> The CCI level choose by Max_Level(LCPU & BCPU frequency) in devfreq
> driver.
> without global lock, It may choose wrong CCI level and cause system
> stall.
> 
> I hope this flow is serial setting like, BCPU / LCPU set frequency ->
> set CCI level -> BCPU / LCPU set frequency -> set CCI level -> ......
> 
> without global lock, it could be LCPU / BCPU set frequency -> set CCI
> level(during this time, it may change BCPU / LCPU frequency and cause
> system stall.
> 
> I also can only do global lock on ccifreq_support SoC.

As explained earlier, I don't think there is a race here. May be I am
wrong. And so I need a clear code path example from you, which proves
that there is a race here.

-- 
viresh

