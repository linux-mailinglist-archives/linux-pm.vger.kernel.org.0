Return-Path: <linux-pm+bounces-32114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E446B1FEF7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B927189AAC8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471E327AC35;
	Mon, 11 Aug 2025 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oI6Q315h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75462798FA
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754892357; cv=none; b=pQWVa8AV25zBzxoDZ/V7CkkGNzu/9IapWGBJp4d0SKIMiU/w8J4DD2b9qCo7xAQ9bh1wcc+Bw+KUIpemAaEnQPgTp2I8C1jMGXl21d1+Byx8DnBhC8TzBdubJFMvOpz+2PVmXwINIF235vSwpWM2oi8DwOmpUHxqmPNbMXRixso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754892357; c=relaxed/simple;
	bh=jw07oOfPIIudddquxIbhqqyzg191DRg7M2Uc5HD9xgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFTHxPKYWkCNCRrGt51cemJ2w86sBFNy1Xu0PVLjJ/tXIzf8S+mzzo95yuxlqhKEcrvfb7ubw/IJQq0Fu7juDmXg3jg9Xto+K6vs8EXaQPpGt6NSf8KCqrQQGZl15Vf6TdcP8gUcWtHKPMcohDxUDh2zQ9b2Q3ccmdGyVpIluS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oI6Q315h; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23ffa7b3b30so36593105ad.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754892355; x=1755497155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pv4Y9hoI9PiZC02H9KvuEQaXOMSZ/GwCfxO4ubNZLUE=;
        b=oI6Q315heYbk8J1OR01CG4i4HBsMxunJ/Fuji5cFgDSN0PzJbbXRwMa789GNKwOuD+
         mdA/7HcwVJJvDZrjEvUYaOcEYXcMT5rQaF51G0WIbKUBzMR87vYNA8aDrTkWcLFTd7S9
         Fgcywo4SIZgnnDceJQyj/DQtZQi4FfVnETCQ6GIj+dhJgnTw67O7dZzjiY9rf0y7l3DO
         uhCp/LidlfsNi5m7Mc8fkIzs/vo3v2Juu3DJjrC3eo+Vili4F03u4qBxeFLvIeWfLPe1
         cN6lF+9ZAkE0I+y5Tp4cnyxGUxcavdT7BVRJnXJaoLFBrVm1MPUGrdMw+X+YEb5k/DIp
         tkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754892355; x=1755497155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv4Y9hoI9PiZC02H9KvuEQaXOMSZ/GwCfxO4ubNZLUE=;
        b=j65eTyBIGW9xr+swv0Er2Q+fsAcJd7brr5E+nwbCNTXF9omgeHs7v/Mxf9suJsTdIg
         3Idcnb5yPYb3lPyUQD+EJ47ZtSASSHnstiFu7MoCdwSst2KDNyuJGbOxTLzHUhQZuJ2c
         YXJXfOLxpH6Xzm111sI5clNLWQ1wNndVVDzXSY6GfFif4ubL1lDEwMmPI5ph0/UmGKKO
         q/2jPJD5vb9Ob0VplkerFeny1tffKK6rXetqE09cvNgCaJUOR2pHPOU+2CXWCR3K1ve/
         kbcw9lsc2lNkQb5+z3q/hLfMVlMtUF2+yP/x1VyjSciRx7lPmJS6LDn6HBvddndBr7b1
         qNDg==
X-Forwarded-Encrypted: i=1; AJvYcCWR9DIrl1pEbbDTtdG1fzVtSMf/Q0Z5+oX3NYA5oNHmBW+Xn0yZwERt5974sIk1sBu1Pqbv3Lp2qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZdTPaYEvhmD69v+52AEfeUO75hH7bLx4sNWFnGfxxsvYqb9hh
	9b+36b3gKjfO6JQmkgEPgp6iTnwHiWqnD6ku4DOAANUJRVZHWcIc0GtWNXQhQTz4hgg=
X-Gm-Gg: ASbGncterAa7NJNsOJ+9fYakzIMTptGIW//3vHdcs+II+fK2Hw0E4sdHN083/WBkyeS
	5I0Q1ZgLk24vvqkjMqEiRv2hHQm5BG6oJAUUUQLhx1pHWs/eMhRCSEtIn5R82UXjBsUQh6rM3Ex
	OlzsHfCUo57fncSO74+y4MaoEdhy97CgJoeEkL8BMPSUnS0ZZ5YVFPr5hXXupuyCfmnzykXNmXM
	pbz26CyZFF/CabO4I3KOgZw3kdsHbieoeLEovVcklP1HK3vrBQZDZTURncALVJkxWia0+DDsOhv
	+Qs6zdQvQJ2+UBo+y22sDdMflI+VurxNm3TlgmJyDW08r0v8S1FbWOMfQnJz0yimcaE+tmz2cvR
	DIMyOMRGshXp0IcNj1v2GUQyN
X-Google-Smtp-Source: AGHT+IHYuEeM905+TEPBVEFx8PtIPIWjUz+dbW//zyktdq6/BorfwdhX7ZjxcijwB0tDQa+/72ZIZA==
X-Received: by 2002:a17:902:f544:b0:240:6aad:1c43 with SMTP id d9443c01a7336-242c2262291mr179601355ad.48.1754892354118;
        Sun, 10 Aug 2025 23:05:54 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67e8sm264942305ad.8.2025.08.10.23.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:05:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:35:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Prashant Malani <pmalani@google.com>
Cc: Beata Michalska <beata.michalska@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <20250811060551.ylc6uutni4x6jqtg@vireshk-i7>
References: <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com>
 <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>

On 06-08-25, 17:19, Prashant Malani wrote:
> So, do we have consensus that the idle check is acceptable as proposed?
> (Just want to make sure this thread doesn't get lost given another thread
> has forked off in this conversation).

I don't have any objections to this or a better solution to this.

-- 
viresh

