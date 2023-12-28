Return-Path: <linux-pm+bounces-1652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A5E81FA3F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57330B20E5C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 17:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA2EEB6;
	Thu, 28 Dec 2023 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="SE9s4t14"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED8F9CA
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso22939465e9.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 09:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703783682; x=1704388482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5bhZr4OZWNhAWGe5k8YtvZn7JH/mPSTxU7SneuBK2M=;
        b=SE9s4t14+uJnP8aRfGIjtqA/6q5KNgWDdQWHwyDOjBIj2F4qIbY5aMRg8l9h0pJQQP
         7ET0/ZrE9gRbKe0bID3ttWKoYAquyYImJg5yVedh8AbBPpsbycK+2y509N0+ckxMqSjW
         ySsfiGykN2m99KXBsB1z5Iho5UwSrMDBfa7XwTdvpIFN1uZSZEfh251ds/7ZbVd4ZOZ/
         9muEUHx5axYvqYBrMXLiSvae1urijB8DOyd8poLIJnVKdZeDMpJLFWWRIfPUTB9yTjtJ
         7AVMsqHum20LCQcn7qox56uma8gDlV14PP50Wv00EmxwITb6dpxVCCjc5dcrCl9rIs5f
         4+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703783682; x=1704388482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5bhZr4OZWNhAWGe5k8YtvZn7JH/mPSTxU7SneuBK2M=;
        b=lM+w4vz2N12neJhfTdnxi/L2XUkyaXXNRzWbJgauFV/4wu69Pxw3j0Ru9AkXacue4M
         H/6NyXtUgqQJsehM7YmDz6GHbJoVviFwqdtDa+qrqWuorLPZMaJZXEuAOV5Yqz7/3lDD
         nR6lO53vZt8dz1K9e8pF3x37MhBV+ULsIamK0EsZoDiuyuR726NZG8V/1uQJnV7v/j9u
         ralQYYnQDCYpUwBlz/6B3lEu4fm1sRhSgwfeXZr+WHHJmUiomuYLRNHaNSFM7GQYizoh
         lffZnDS0JIgg6e1fECxAkikTLCIas3UgNIXqMEczautXwMaZVhVJqLqgiQMCdo6z3ayL
         Liug==
X-Gm-Message-State: AOJu0Yz8cqhp8aqKWJaEGU6OnQsxhSuQEb++jEdQuvOrUYFs9aySxv/w
	B67/JByFOc1WZ55FnLFx3TiAFEiSw2SCnQ==
X-Google-Smtp-Source: AGHT+IHTkh/6edX4qHjr6QTUR6Vo2mxhnQqGjR8riEsvT7YhXvjEzVuTLLE+BAEdL5iB+sx3JUDMBw==
X-Received: by 2002:a05:600c:1503:b0:40d:355e:ab92 with SMTP id b3-20020a05600c150300b0040d355eab92mr5759877wmg.22.1703783682448;
        Thu, 28 Dec 2023 09:14:42 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b0040d61b1cecasm4180432wmq.33.2023.12.28.09.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 09:14:42 -0800 (PST)
Date: Thu, 28 Dec 2023 17:14:41 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 05/23] PM: EM: Refactor a new function
 em_compute_costs()
Message-ID: <20231228171441.jgyjtp3knbtcqgf7@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-6-lukasz.luba@arm.com>
 <20231217175845.2jdeqaz62mmcjuwu@airbuntu>
 <5f7f52a4-4f0a-4694-a743-478c5e4e4079@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f7f52a4-4f0a-4694-a743-478c5e4e4079@arm.com>

On 12/19/23 10:59, Lukasz Luba wrote:
> 
> 
> On 12/17/23 17:58, Qais Yousef wrote:
> > On 11/29/23 11:08, Lukasz Luba wrote:
> > > Refactor a dedicated function which will be easier to maintain and re-use
> > > in future. The upcoming changes for the modifiable EM perf_state table
> > > will use it (instead of duplicating the code).
> > 
> > nit: What is being refactored? Looks like you took em_compute_cost() out of
> > em_create_perf_table().
> 
> Yes, it's going to be re-used later for also update code path, not only
> register code path.

Sorry I was terse. I meant the commit message could be clearer to require less
effort untangling what is actually being changed.

