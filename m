Return-Path: <linux-pm+bounces-6750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FFD8AC323
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 05:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07945281255
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26250FBFC;
	Mon, 22 Apr 2024 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IV/CTnq0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D573DDAB
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757278; cv=none; b=L3xR6jO9Q0UWmyYkxWVF8snCjcaBe/MahG2eYk/cDXl7PCb7quuxpxxQ7Q4HTn35pyLNERIzsc+BN8eEmzLQTGTwQUzexr081zLDxDPNl4w5zvd0W7AHKTQ2qFYeS31WRrb6uUaSqCmgCHPpKs6pTGd5ft1zXjMYnPnkiVWmDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757278; c=relaxed/simple;
	bh=QXCwamK07MsvJLUBrAceuoynnr5As4trjRDujWCt1Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYR0TdcnJBYGky4jzy7r7BM2foFZz4DisRQ70VSdcABiEoPv2LGvAlpqDrFVNPi5uNlm86PlFYF9mtspJ2GbXoqcN3kKhBOV+3WBLow8PakS8p6Zk1a/X3hdrYJbEQCOtc2WJmBi/E4wi13vVn/I96x508TLLhm25ipbhHB3DZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IV/CTnq0; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23333ef4a02so2399447fac.1
        for <linux-pm@vger.kernel.org>; Sun, 21 Apr 2024 20:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713757274; x=1714362074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl5iDmcU+vdD5ORuT+ZmSbv78xBtfXPu+m5CHFPkBDg=;
        b=IV/CTnq02p8E+rxmZsk7j3TeJFn70+D8eqC94FwvQvZ8njDwlVJA9YJA8NYolygcin
         oQIFidoML+OLg9zbmEtyGrv/PVkeDU2AMy/Pg2fuBioT8B+90d08UHLiN71ssuqTGOQi
         iwFQ8I3Bl8bJ8qFCReZbnO2Sw7gwQpqJLrdQ3ZZk5nzGebiU4tlkZEvCyRyPrxeVPcCa
         UH0bxoK89e1HD9+fXLwigcKk4TDEG+mucWRGTYLvhnaEUjKa/TKFyHZVR3NFYKNZ0jeA
         pKmDInEXayjHPIYqiWfTdxvKLdAVqzXP6CuG97axr0iitWbLKoA9bTL2SvbkDZEspCrZ
         ag6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713757274; x=1714362074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl5iDmcU+vdD5ORuT+ZmSbv78xBtfXPu+m5CHFPkBDg=;
        b=VTP9d7oLmiOS72m+9ZdsS1CLszkSvCOfapPQwkS/snQi2NjFSyHZK57KdQ+QP9o2BU
         t+UyKShrX2TtECwwTyav4ckYUUdod2qPjdds2FEMYqtIcvKmYuxp5lXiE8rWGY88CKcq
         I+0r6DgMfdq9vzcDCtO0Bu1B9sxcQWk7r1iWLKY8lS00+cyDOuHMoTtBRxyLy2qotM73
         IpM9OUHuAyGYegRYk4pk49b9U50YzIKTulWvenAW4yIIy0CLtGc16mwFQXVe93rPFwoE
         CuP3X7OkcJ3l7G6qvyEgUdj2/DTe48P9/L4tZ5/oxAxXckHpAJkQ/K2r7xxQ+Ou2f5Nw
         Hu0w==
X-Forwarded-Encrypted: i=1; AJvYcCV8KbqMDIma0mZ/LCIk5z5kAMMLD1npEUXSZx5fyptOWSDi8kwdz9W8tbdK1gUQqqe1mWc9keIOo5sLIl7mCoUzPjvcZjj3GAs=
X-Gm-Message-State: AOJu0YxTggWbADAGtE2fcWNDGs+UQjLbVtkHU29oEtgGVfGMXnE062s6
	RoBgZa4GyWuRQdkmS6kqacY0M2aU3MvAc7bw/qpX2ntma0BTkNZIchtJVaX4eCw=
X-Google-Smtp-Source: AGHT+IGk4VpEttqtX7wmUP0DjSs0Hnai1BKypHYXOPdM34VHuqvCdINyqmTAuf5HKKeFHylZBh137A==
X-Received: by 2002:a05:6870:c352:b0:222:99cb:2215 with SMTP id e18-20020a056870c35200b0022299cb2215mr10754338oak.28.1713757274492;
        Sun, 21 Apr 2024 20:41:14 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b006e697bd5285sm6803551pfa.203.2024.04.21.20.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:41:13 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:11:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Add support for MT7988A
Message-ID: <20240422034112.rugixkqrbeyq44zq@vireshk-i7>
References: <acf4fb446aacfbf6ce7b6e94bf3aad303e0ad4d1.1713545923.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf4fb446aacfbf6ce7b6e94bf3aad303e0ad4d1.1713545923.git.daniel@makrotopia.org>

On 19-04-24, 17:59, Daniel Golle wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This add cpufreq support for mediatek MT7988A SoC.
> 
> The platform data of MT7988A is different from previous MediaTek SoCs,
> so we add a new compatible and platform data for it.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied. Thanks.

-- 
viresh

