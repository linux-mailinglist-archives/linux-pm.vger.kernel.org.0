Return-Path: <linux-pm+bounces-17295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F09C375A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 05:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339861C2160E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 04:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035F155327;
	Mon, 11 Nov 2024 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qru5J9pK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9414A4D6
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298398; cv=none; b=Bbkx9pAKdlgIN5GCJCXBbC5RTdkeKq8drZNzYRgIJTiG7XtSHSNi5hoW2j6Ipu+3Z7wwWOSnPdsDokGXGnoUltFuA9MQQsWim/zSx6dZ5xktO3mUGvHqB6FAfXd9hOgAcLh2pdXQyJPjDYNyXyq3P8OXz+7vpZExsSj5oMDs0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298398; c=relaxed/simple;
	bh=5Vg5LKlFHRSRZSf6nL2juDCBh/tRwylEiwuI7e/LabQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4F/lO91v+I9nlHmB6myfmoMBzc5RyjPqGJM3Pfpa7ifA095y3a0l14OLzLkBsKPAvkUqhb9wEPgcMry1b/IQceG4tGn5qyrc/fUtJRMhc2xj/aVfys6FR3SphykTKIK6V0Nj+OYFiqZy0ZcDAj7gPQ3xCK7n6M9ivESDiigcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qru5J9pK; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a6bd37f424so16385435ab.2
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2024 20:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731298395; x=1731903195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8MtdHLQlnE39Q/Ipi2Y33s1bnwJbhLgXZcQQfcZ9Dc=;
        b=Qru5J9pKyXW06MPmDCFJu9THA5wtj/brAUILsEQiMs1FmM827/Tt9ckbKzxIuLCA7T
         205WGTp2euxXlRBC26oPV8a/PbGw6jZOifG6MYaGjJH8dZ2ZpFgQHn8R0/5pMtgB7WhL
         xCDfej5cUfxsVNmX4PWq0LdQTQEcW2dY2ZOced00eZaZdpum5gUF+LQY3j8Ve6NIwSil
         yLKapG3dN/1kSQ8n6vGpe9Z0cGUtJT7OiDNZ4PwYFA505Z9Ts4jHDTKJgj9clokDJw2/
         GG1ID8qyQhbEBso+xUOCzJHZxTzc5USEAEfwFY7sZQVEd/lLCI1RX1TZerVRmLmrygRe
         sIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298395; x=1731903195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8MtdHLQlnE39Q/Ipi2Y33s1bnwJbhLgXZcQQfcZ9Dc=;
        b=VzW0KdoL+MJIeDpczvV37NNNHWXYW4jfUEEidntd4u0ulj4mK2ZjKo/AQSkZchv/MP
         x+DlZcaIyc9m5z+98T0fxSWHT7DSL1YTbDcIJlcluF7oWagapTG7s9Hnc8lOk3dyYLBK
         FrtwFjsCWrERD7pFr3k8bAwIVl6Ghzuczxo9TbgMWGyh1GO8dbV9/hdLbExskgeejOU4
         QPgNy5EZY5f+0ItZoVchL8x0uTbzNmP4wn6amlCXmgSaCzgVZScSXfljLSC2s/sBt5QJ
         xuXIjvpCQ0M3lFFOMYBAWELIosqzU1o6aMzQMCPilGWdBT4lEfElD67XK1IGyJ0LVh/u
         fpmw==
X-Forwarded-Encrypted: i=1; AJvYcCWI7jTQ/mUBMFbKr2Xk0Kw7nE1z5olksmKoFIOrvnHLnXLYkNgcde3zJTQZ7X/rbXBIM1jnB1DEjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJF8uVqE7r0CQ4xmFRj27unO6HwK1Hii0OtiwkPembiUlXxT+a
	Vdjn5EycjUHGVY0lE9PdoAMxpc44w5AgJensQ3t+DSfa+QtGqAQ0/c1Ecu5w29U=
X-Google-Smtp-Source: AGHT+IE8pyAAVUtA2paQ66tQO5vUZ71OyT+KLnUQAUEAU5tTlgSVZPHhBhmkiVG+VvVFIMNzcTXwGw==
X-Received: by 2002:a05:6e02:18c7:b0:3a0:9952:5fcb with SMTP id e9e14a558f8ab-3a6f1a2e2b3mr121627285ab.17.1731298394659;
        Sun, 10 Nov 2024 20:13:14 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5e9c61sm7533387a12.49.2024.11.10.20.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:13:14 -0800 (PST)
Date: Mon, 11 Nov 2024 09:43:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
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
Message-ID: <20241111041311.hleaz5fgipsyxigm@vireshk-i7>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-13-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031070232.1793078-13-masterr3c0rd@epochal.quest>

On 31-10-24, 04:02, Cody Eksal wrote:
> From: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> 
> Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h6,
> let us use efuse_xlate to extract the differentiated part.
> 
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> [masterr3c0rd@epochal.quest: add A100 to opp_match_list]
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
> Changes in V2:
>  - Add the A100 to the cpufreq-dt-platdev blacklist.

Can this be applied to the cpufreq tree separately ?

-- 
viresh

