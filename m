Return-Path: <linux-pm+bounces-1268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFEC81662A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 06:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8755228281F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256663DA;
	Mon, 18 Dec 2023 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9gpzD1L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5263D7
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2241506a12.1
        for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 21:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702878797; x=1703483597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GrTtFhUyASkEfUAMBw7959zTykF6PRJNu2ODeqC4YD4=;
        b=T9gpzD1LG2Wgmlu/XN6w+XEHSES3briYupkPo15pVUvYoDco7vy24tOoIebTabt+1q
         Ir1WoqD6K1LJjhHkCjJRcrQjUchXCoZ7iSE8Y+R9hc9OjjjctbDekTKE2HggOawOY2T2
         3prlgbZghtkPtrgDQYtP1rc2TG3gJhtR4zjnTvECsoShYhiXT45E1exrQF1f/KrZXO2u
         XLLBkKEv6heDwC+b6QhxctTMNDT35I4e88BgQ6NWxcp1t+qGl/8qKTWqo1/CPdXZqjrT
         fBnjaangUu4iFFgBINRlp9abYYC1y4eOJryLJq8KcTU1qA5AiRWGC7zQ+RF9lvAFU7i9
         kvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702878797; x=1703483597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrTtFhUyASkEfUAMBw7959zTykF6PRJNu2ODeqC4YD4=;
        b=uM3hcrYC3MUbqpSpv9E/wOqStxyKx4wCoeeD4k/AOBnZLi9ncBhFg2OTvkXK1E1cAd
         tjyxckhMAYhMXNZ6zJVspGCXfb44kc4zTe1VQ+DS4RQvzUfdXlO2jqApczjryUMbvekc
         Qxjh1E8wuKErCfjqgiI+Wgkw74TENsCwUFRjyhRMg37a5VgcIMGNQ7Mls6+WgAzHSxEO
         TbuEbO3NVkGFMjRktAYGEGL4VVCsUJcmESiIX9X8TdDR67pRMVF6mA08jWnIJtlYDwkF
         D8E3I4Ma1TVTCIkrpi1IJO5G19uax7ayPJth9/CwekX8NQpgiS3T9i4HQYGwVObiW3T5
         iHLg==
X-Gm-Message-State: AOJu0YxqWF9OX0XzdfBblxxbb6/W/haTkHjfoJPAe6hqsGhGFv94qDm0
	cPN9fKjrfOubOnb2k1lcXA5UrQ==
X-Google-Smtp-Source: AGHT+IFTYA/Cuk1OgbTlPp0MlCeZIBRXvTekXtawfFK79oQPOiJ14gasBs+V0J8ga/D2Wkw4ZK6x3w==
X-Received: by 2002:a05:6a20:d386:b0:190:1e0c:d29 with SMTP id iq6-20020a056a20d38600b001901e0c0d29mr27176175pzb.4.1702878796930;
        Sun, 17 Dec 2023 21:53:16 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id p2-20020aa78602000000b006d626f91d38sm1706268pfn.9.2023.12.17.21.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 21:53:16 -0800 (PST)
Date: Mon, 18 Dec 2023 11:23:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] cpufreq: armada-8k: Fix parameter type warning
Message-ID: <20231218055314.452spnbph2he3xoq@vireshk-i7>
References: <20231215153706.2087883-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215153706.2087883-1-gregory.clement@bootlin.com>

On 15-12-23, 16:37, Gregory CLEMENT wrote:
> The second parameter of clk_get() is of type 'const char *', so use
> NULL instead of the integer 0 to resolve a sparse warning:
> 
> drivers/cpufreq/armada-8k-cpufreq.c:60:40: warning: Using plain integer as NULL pointer
> drivers/cpufreq/armada-8k-cpufreq.c:168:40: warning: Using plain integer as NULL pointer
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312141651.lCAXGAZ2-lkp@intel.com/
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

