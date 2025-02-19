Return-Path: <linux-pm+bounces-22381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E105AA3B100
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 06:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2683AE483
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D827B1B4F14;
	Wed, 19 Feb 2025 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gr5icUyw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482591B6CF5
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943734; cv=none; b=sgRWAIqzKRxObyYKr6VA14SfCnPphNkZvLFu/BFd4fNx7O6KVIfZH4tNCgi2cssJEKeI5QM80VIbtGAt5whaGdoOpzFNDE5zXLSf5qCdOQ6CsHr9YM0gNXz5AikIiazxR0ReiTicDkhc419X/fDaf24w8QO5PR4l0COA5cM1wP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943734; c=relaxed/simple;
	bh=UlxN5nIxHgy+wAG7x32fxZL8LlqDfxRzsgF07t+gqsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvN+6AgUuthgU0wuguorojEFRCrnwCsbvhMGcxAzon1PsMvUoZq6/JxMho08881QVMGO2bU3z7tPLFkGCoYFiwcYSYYfeXNC/2qvtputLf/2ckTChJ0BkGrD1WluzJdGymXT6nZ3lyyq4G6CjS0oIouefTNU0aDVgAyWkv/TsAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gr5icUyw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22101839807so84831635ad.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 21:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739943732; x=1740548532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw7t6rEqkTZXH92Wz/4+gNz4tFU3pvCeEiYAUtl7Rbc=;
        b=Gr5icUywPWVr7KKXKa4D6/TQPndfU1OryjWZ+9n//bbxkdufIMfN1R+Z2GfHvPlBhb
         0J0GoBEmYOIBpo2HdmSYe7j7S9jV53+fzeSteE178SSLJ8Ovq9E5RYwMsSTwuNB/LiYu
         oiKrKcTsXagiq7n0A3rjJ9OJ7kOv927mauaDcAxbSmDUZv1zAN+jdAqMAkdyhpzViH/X
         5kvA0zfpI2whjhwddbr9K51BISm90haF2etHzV9GwUJ4GgWbCxaFum5pHtr7v7mdXSEw
         uN6yUueVcdkuxwhRsQoJHLefMLpIGUyYGQsWeXlQkWVHw/xfKKyoCrhdDI2ubjfJSaAv
         AksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739943732; x=1740548532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw7t6rEqkTZXH92Wz/4+gNz4tFU3pvCeEiYAUtl7Rbc=;
        b=OJ8jkrydTMwHylKsHtHn8qYtvcI8UHI9YpB3vQNwGC+RWTOY978JQWek5k88so9/QQ
         4HmbbsEuHB6SQo942NYsLG1W1ri0y+skkdXGA39nDE+P1RKjo3wC6B96rCNoSnOZXdz1
         o3Dij0gih8sQotECWNzk2G36dmObmVBMBId+m2fCpVBQFXeoDGdbwkQFReV9/F0/A2yz
         1GlpV6L3TiAocqRQnC86YUiEUpeKk7Bh1vQ3az5vf2zvwtUPIlMG4ijwIe6+GwHWbVbm
         FJc5p+1hSeybrZuom3xcPC0TRhUuvucpWKBtSRif4HgX9iXhYZnVyD1KvEhhgymDDT6x
         LdCw==
X-Forwarded-Encrypted: i=1; AJvYcCVtorSkXprO8FZZIIueb4+9p/QfdTGsvR5m5leCiaJ+aFlQXebJU4bla5May9Zp+vo3nTec4mzH3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVslDXVCHVi2wtatwSPXAzoJzV2D3rJjsUl5AyGLu8DPhSZ+n
	Nlvdf8N9L3PRz62TLZw+8ZFuS5jYqIiMbl+/0f6yfEJ+ggUAW7WUQllvEBfuigs=
X-Gm-Gg: ASbGncvRwfeDHvvfJCD61GaVDqE7SBK4betRS6wUtEdJzzrLqWbEcDWCZoN8vwea3o1
	cjoBEze0yKCF6268AT5flIWQUXLTy5ErniDjoKD5qYZO/HS4QFeJaYH0iasBkBXZUko+eKQd4zo
	WxcKAKp2n/SKZEq3X/HoHKkntNNQREt52pYJWlXZz7s0wC+huuwkhoZUwUx1w2FHr+iCyMxvDng
	xDnm7oEyFSvDjeHT4l2BPYnKmN+vO0WwDbN+NBqHhPc884Dftmn6Bn0MexWviwEapSSyll6p8Sp
	jIdFQd1xW1PjA7PjYA==
X-Google-Smtp-Source: AGHT+IFmJl4t7FAw0hGuv5yC3n7fuRs/TbAcabQxCpBJfvULJjAbDJAYajm1qYLNhiNrv4hZgm/Tjg==
X-Received: by 2002:a05:6a20:7491:b0:1ee:d3ac:56f7 with SMTP id adf61e73a8af0-1eed4fb2369mr3887537637.33.1739943732560;
        Tue, 18 Feb 2025 21:42:12 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568adasm11461609b3a.52.2025.02.18.21.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:42:11 -0800 (PST)
Date: Wed, 19 Feb 2025 11:12:09 +0530
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
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Message-ID: <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>

On 14-02-25, 15:43, Mark Tseng wrote:
> In mtk_cpufreq_set_target() is re-enter function but the mutex lock
> decalre in mtk_cpu_dvfs_info structure for each policy. It should
> change to global variable for critical session avoid race condition
> with 2 or more policy.

And what exactly is the race condition here ? Can you please explain that ?
Since the struct mtk_cpu_dvfs_info instance is per-policy, I don't think there
is any race here.

The lock was introduced earlier to avoid a potential race with notifiers, but it
has nothing to do with calling target simultaneously.

commit c210063b40ac ("cpufreq: mediatek: Add opp notification support")

-- 
viresh

