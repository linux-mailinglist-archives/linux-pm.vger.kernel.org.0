Return-Path: <linux-pm+bounces-24361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C13FA6B3D8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 05:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F14918993BA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 04:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6961E3793;
	Fri, 21 Mar 2025 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A25q+mdR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D91E1A18
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532989; cv=none; b=K7FX5mNCO+P6CeTyCn/RUdW1XvhDFOeSTg5ozZB2GPf5SrspEDlyBzakgpDyqfgOQB8bbAm8FuOtdfXksD1WBaVx2wvL5ESstZ73Ck+AXa7LLLqQ7SDndV0YiO63GgAV9ZFmZCSUx1lLGGZvL2rZhmsNKu/U+GqYsry24DDiNsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532989; c=relaxed/simple;
	bh=TKGmqm1ndvYNsgqNnkeO2QbbChwHZc+jTCz/4Yrq09s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiEN+xwkMQ2dPXoMsSk5SIegeATZadb+yGp+JDaiQxPaDimyI0ZAwyqBXPEhTlWnLPsUkCWeYseyPE2Des5eL/8Ou9JTzptntnolRYFx298VPL/wunvZwZLzaI4rBj1pxtHt75CJ2QncCjQOrYtJYBursopKLxuNV7wiQStq1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A25q+mdR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223f4c06e9fso26149195ad.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 21:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742532987; x=1743137787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ozUpcCEWntr3v7+jvGD7rSS3mGlFfqxCVTsgZ2wgtA=;
        b=A25q+mdRJLZmB7gHOg4Vigct//EqaCFdRgk2VTPq5yLgr/8D5QJwZ8ejGNOwoL6QaB
         9KagnS3c5/cNTFZXO4qipiBdWcRWaMmv8rc2/IqlDQv8LyI1Ald6RO7e3tEFt+fUWlsA
         ngYT31QKo3yP2WJC0PAUaohk/QabIThBOynE4YZjFvTEbLb6FDyEfMPImnF2pp3/4m9k
         inZf5Y5HoAIVTgZ73Hs2FKyo3bKS5kxtgxooIFf7FxbXBy+6xyIRwFJTyCZIM2QNfNW2
         mrbhUXbAG1OsMpCB4xdwDqhnpL3PuOhAUDgna5QO7B8ZwmTtMQXz5vfOkoSgKykav+RQ
         lQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742532987; x=1743137787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ozUpcCEWntr3v7+jvGD7rSS3mGlFfqxCVTsgZ2wgtA=;
        b=ceMQYEBordpUPBICdKttGbV9CDwDBuFvZEuA92h6DLTD1hrFDqNfgnitGTCHc9C4bz
         GFV4knry/uYgHvynkTfamY/f696FB48VdrFPqet9TzvziuQR9iSBK+iiVwB4JhQOzAwP
         LIHxC/dB0SoJs0f8h1OMV16aOglQFPSNW0SBvzfD/lnj3rrFBDG36Jdw3HhPnrrrO2Xu
         e2AagPEP8w/9CphVxcR5PQMbNc+QxfyCuBhXGM7LCLvIJkNXwVnk1SJ1Hf7QqsiqVVwW
         tiE3UuvnquDIGp+QSDJqsVRBOFDe0kwItpX6gy4ryMQ6IdoGXu5mUiTqPQEyN5x1/zyt
         uLXA==
X-Forwarded-Encrypted: i=1; AJvYcCVafy5OMmTrK0ZIz1ydJhfWasfVNQaPGvIlzDs3w/YmN3W9TTZnYSKIwJcWrcLMPML+74Eht7ksUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOLSfRkQzDnj9XpolGAwEjbNNaTvtPCVhTRBuKFA403ft4KXt
	kVu/bCuDvy5gKB1CsZCsNs3DtqlSyRUV9TQW35W2pB7ewfG3fK8P+480ZlVfsV8=
X-Gm-Gg: ASbGncvXPTYVStmDvBPdNN2cLc59iguB4hbyBUzzxk1Iw24iWW2l+kJY/C6dWbERN9m
	mJ/yOHXozcsdHx7DxL+CQnmz/p2SMWuP+k9ytGTnExet/LqISzFAJbcKZLY+go1nl8YyXtzRu1P
	CFwDTu65mB5ps6u2N+78s7yd0k4V25Iq0ggKVqpstL7nTPYUrlj02IVIWslCiABASn7o2pVPIxO
	MRYN1+pg/4h19VuRn4Xkxjd5mx6Ju8c1ocPEOZBmNc+wNt4mnaIUNLeURgKTCAXBPaLFOf7Mc6R
	WQDXMXoDiDhCMy/jzFMsLOMj2hji5JdZjotGeRRBTylgWA==
X-Google-Smtp-Source: AGHT+IEfZE88rs+io7iiRT/X8wJSM3aPVySwMLCiKFphdme5Nr2cI1Z/rOArrzthb1zZgjhHnKW+8w==
X-Received: by 2002:a17:902:f646:b0:223:807f:7f92 with SMTP id d9443c01a7336-2265e743880mr104023345ad.20.1742532987264;
        Thu, 20 Mar 2025 21:56:27 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4d5f5sm7225665ad.79.2025.03.20.21.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 21:56:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:26:24 +0530
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
Message-ID: <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>

On 20-03-25, 08:22, Chun-Jen Tseng (曾俊仁) wrote:
> The struct mtk_cpu_dvfs_info instance is per-policy and the reg_lock is
> also in this structure. when I have two "policy-0" and "policy-6" use
> the same mtk_cpufreq_set_target() function but the info->reg_lock 
> is from 2 instance(policy-0 and policy-6). when the policy-0 and
> policy-6 call set_target target, the mutex_lock is locked by per-
> policy. So, I change to global lock avoid per-policy lock.

Yes, that's what you are doing. I am asking why a global lock is required here ?
I think the per-policy lock is all you need.

-- 
viresh

