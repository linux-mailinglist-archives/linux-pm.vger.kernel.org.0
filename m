Return-Path: <linux-pm+bounces-16642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D409B4298
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 07:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E71CB21EFF
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20AC201262;
	Tue, 29 Oct 2024 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsCVp205"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14D200CA4
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730184804; cv=none; b=BpJ6fmZqWoA4UTy5v18+sOWLV/wZyOv+qOb0Z+B+WH/dAqwAxizgZtbj0lf1BQxG/UznKnZwqwA4raFTyFTAKiL7Qbmq7rgtnhFLiSFiaWXUXwE7JZu52FmAr0QLYfzJtndCyqy/xkwGvjRiSA2PaG+U+HWvqdU3vY7oFCVig74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730184804; c=relaxed/simple;
	bh=VI5gBCWScORZmQ5M5JKICCGe/z8Tu5nvu1z/DGuqTYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMYW8ZH1QJvUAzW7uDobIo0e6DXisIHnulxwq+E4EV9qOwK+IGbO6lu4AfIAo0KUj9gNMysmMU9cpDJ/m9t878UXJbpS09e3etejdkdGW1D+FddK9Ks/PSH0gfGeaBLlVY4/RAQfvuBpN/aYMiBa6HXgfWJ0TDQHmC1420FrIsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TsCVp205; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c693b68f5so54476365ad.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 23:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730184802; x=1730789602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxdqxmWJXdXU8AUeRm4skNzTB6cELoVffMjUmz4VZV4=;
        b=TsCVp205Z2Rx58O5LNpZUuxsBJqxEYmRVNvrPr05GsIT1URTAfMgYQMYAEKnbzqUGR
         yajxuID98PopypqyNE4CEFYQD8hTAUi2jV4fay16BNghfISNCYSMVfblB8bDOnrcAKI+
         nGQ59tbKZbptMj2c6gimilCedT+Cj+tkMpFKZPwwx9+OFdj5IhX1iqyULBaaP09tm0+n
         MwlMYNWfuGxHxouJHNjdluosOiPy9L8SbbFjV1FnC/bLROYaSZwew/NL3kr6S/7Z8+Qw
         9xji6NMUiCEcBHTRJaDix1z6b6Oui5lgzyuSZlz0mWLToRDAkCOazRLMb6yl0XIdwN0S
         R4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730184802; x=1730789602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxdqxmWJXdXU8AUeRm4skNzTB6cELoVffMjUmz4VZV4=;
        b=P8YomsieoaHAZYzutYEOj5fEYxWAeCgeLXztQEHhcadO+b/6hdzYr9uknuR+dQ5z2G
         6ysIjZDj/uV3J/m3DUv99JWTgBB090LND9Y66TkTpJrq7O9BumZQaQ45x8yyJifK38Bd
         PRs8Sc92y1VUAU1OkOyA1iCcJQJW91HBIlXQx1Kc9blg8ci1PxShpAgxo6v63IUb4J+7
         PezWJ6rWigNitc4SRT2+nIZyn5zA47yY8qSmvgJkTsxNMT6tJ+UZaEivTaydeA+wS7ve
         g55gUt0cnrtNxQSvARKN1y7j5WOkZzbvKYkW7bxIve33hCDB5F053vjC/yXT5tJQuTCU
         DVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ3uYWrUVfmRyAFHeDKuaxbE06Pb6EoUNCckBeQeLL9VQnm2Q1oWmAEROhILXrMy/lqLErspBkHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdqNTF6yo+w/elMnt+Sq2+2a4g1M9pKGvcctulFH997czcY6W
	1BaW08qzcBm2xePwqMmTgvvsJOZzPUyEAaHm+i8waF8+mh1Czcv9MJoeBIREWwo=
X-Google-Smtp-Source: AGHT+IFmnh6BfWm9u00lcdmwhUncv3sqpOQIn0HAENF9MSk8JtP1yLm3zPeUH5AL8E7LPGeuXgJA4A==
X-Received: by 2002:a05:6a21:3a4a:b0:1d9:1d2d:b656 with SMTP id adf61e73a8af0-1d9a83d9f36mr13743238637.15.1730184801978;
        Mon, 28 Oct 2024 23:53:21 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921daasm6909172b3a.37.2024.10.28.23.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:53:21 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:23:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, rafael@kernel.org,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, linux-tegra <linux-tegra@vger.kernel.org>,
	Bibek Basu <bbasu@nvidia.com>
Subject: Re: [PATCH v7 3/4] arm64: Provide an AMU-based version of
 arch_freq_avg_get_on_cpu
Message-ID: <20241029065319.zto3wlvceec3fjym@vireshk-i7>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
 <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com>
 <ZvU4mR_FZa7jXUgk@arm.com>
 <ylcfqw4swz6xjxxfoyljyifs4ibbueywogqxusxfz3a3fgh3du@cfaajchbwgvn>
 <Zv8PKlr_PJgxazro@arm.com>
 <5y3yz2ct2o42c53dc6rwpse3andstjx74lowt2b3hohj4ogbct@nu2szdnxvxid>
 <Zwe1p0La_AFknglf@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwe1p0La_AFknglf@arm.com>

On 10-10-24, 13:08, Beata Michalska wrote:
> That is a fair point but I am not entirely convinced using '0' instead makes
> things any more clearer as this is in no way a valid CPU frequency.
> As long as we document the expected behaviour keeping the interface well
> defined,  both options should be fine I guess.
> 
> @Viresh: what is your opinion on that one ?

Failing to get frequency for the CPU shouldn't be represented by 0,
even if it is confusing for the user.

-- 
viresh

