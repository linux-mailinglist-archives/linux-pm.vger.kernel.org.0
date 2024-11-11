Return-Path: <linux-pm+bounces-17301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB69C37ED
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 06:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4411F21CA7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 05:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2E14F9FF;
	Mon, 11 Nov 2024 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzAIWO/j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA71531E1
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304509; cv=none; b=OZBMnwFB2dxtWOnm7gHbutBkZM4qP7JlsZfFmIqxiLRZDKhEXoDkp95XsM8WRxSDiey40MhE3/UPL8emGur5ZhiGRhhTcykOy6D38+sdsbWQs/mkINzJ335mN0o/MRAY/ii4W5u1YLZ8iHL3zdq9FE++fpwjZsSu5Gd13d+dSdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304509; c=relaxed/simple;
	bh=1wbt4id5qTsT4HTO1+224rcxhAAHXiof/62rdh090/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC2PBNoAqrSSwjgXGAQ6p3cL8jUELbRrVYkqKVpuG0R6K/BVmXLXPo8NRmimv+YFvv/ggGfTJro1ap4PrWIKH9r4on27Mfd0zUEEjhifxdyM+n8mldftMWJJTfUzjOy78vC/kepNTB6QvF9d4slOMCtZfztXuEoM/4XuilwlfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wzAIWO/j; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7206304f93aso3794144b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2024 21:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731304507; x=1731909307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nAWcQ5veHhNVgjM+Swr4gUazUOqqofF4VZks+AvSvMY=;
        b=wzAIWO/j9YvQkdELYgkwtoNij8P8ybBB9a4zGew03rdX2Bb/M+ZaXSBjaCdppWNFNe
         a5FXlmOCA83+k8bFrdQwRAcNb/NB3GcjPRsQ34oK5+pZmb89yzjFKe9LX1RY3P9FiQZG
         m8a34tB+67P9NXCFaE1yn5FdBFGvJTOlb+YnBJB/njGML0Up8n56Bm2yN6y2SvwSQ4Uc
         0fKLEpYLIU8a5NFVGAiLrGCH0qgYbKAvdz5k9KuGEbUUOSnOiWGIcLBstVmn5meJbb1g
         aMDgml63bPAL/nnrvzyszgwjWIQR0ULk222aYZwUhZWgxDUkgxXqqTuEhM2g8HbXkfbO
         qq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304507; x=1731909307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAWcQ5veHhNVgjM+Swr4gUazUOqqofF4VZks+AvSvMY=;
        b=g4iPNY9cYOWkUoyeLxs0mJQZUGX7i9Y4TQUFforueiqCQnTOX61f2jAygE7wqkopuS
         WrRr2SAWrmJf3OOfAupv5xE7IUDJJOiLP2IaJkPLhTQU4O5ThvKU/R53E+O9R5OJHmoq
         rP8zaVa9BTYSziGDn3Ke8RPMQITEKTYwtVxEhlIvvLqzy4onRSO7rgqQFAVfSBg8hFse
         IVH+lijYgDwQwycf/GjZsbmdXTRS4cjHapN+hY/AgdEwL7M+URwg7tkKUe9a1BZVoIQc
         UuPIEudeThRQUfEZrcR8cfJ+Oqmp7PqDKJDM43dEH8UjOxxo2HgtQkfSDUexWL63hHbe
         r/4w==
X-Forwarded-Encrypted: i=1; AJvYcCW25EEGOblOlVwaO5NrAKaUgnWhq/sGcJJon7ZtfQLp2KNv42Vs0/4CM5ok9hFBqbhP4vQK9uJZGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTjzcjgmUWVhne8vXYRz7+AWN9Fqm+owpQhG3yuE/Drez8hLk
	yfdR7/KRpi3UZ2topoM9gqmxwLMzzYy1/4ohkaRtS4Fh5WCeMxthf2/rbG4El0A=
X-Google-Smtp-Source: AGHT+IHtqVtA35vMC4e1EnNTvwTwqSJFlJzhlZOFgx3RSPLljVG5nE5Fqy9JY0g2bqUZOQmsSp1QUQ==
X-Received: by 2002:a05:6a00:198a:b0:71e:415:c4c6 with SMTP id d2e1a72fcca58-724133d215amr13597006b3a.26.1731304507363;
        Sun, 10 Nov 2024 21:55:07 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a3d5bsm8443325b3a.106.2024.11.10.21.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 21:55:06 -0800 (PST)
Date: Mon, 11 Nov 2024 11:25:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 12/13] cpufreq: sun50i: add a100 cpufreq support
Message-ID: <20241111055504.2f3szrd5ahudvtqm@vireshk-i7>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-13-masterr3c0rd@epochal.quest>
 <20241111041311.hleaz5fgipsyxigm@vireshk-i7>
 <CAGb2v646NHFAni=P+iC8OZsWMpg0PJc=kYbuWaY=C0-W-q6qAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v646NHFAni=P+iC8OZsWMpg0PJc=kYbuWaY=C0-W-q6qAw@mail.gmail.com>

On 11-11-24, 13:30, Chen-Yu Tsai wrote:
> On Mon, Nov 11, 2024 at 12:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 31-10-24, 04:02, Cody Eksal wrote:
> > > From: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > >
> > > Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h6,
> > > let us use efuse_xlate to extract the differentiated part.
> > >
> > > Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > > [masterr3c0rd@epochal.quest: add A100 to opp_match_list]
> > > Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> > > ---
> > > Changes in V2:
> > >  - Add the A100 to the cpufreq-dt-platdev blacklist.
> >
> > Can this be applied to the cpufreq tree separately ?
> 
> Yes.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied. Thanks.

-- 
viresh

