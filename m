Return-Path: <linux-pm+bounces-1257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB75816187
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 19:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479CC1C20D7C
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91EB46B9B;
	Sun, 17 Dec 2023 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xa1Tewpr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540E47F51
	for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c6e2a47f6so21768395e9.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702836198; x=1703440998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yty6ELNePRoN9Iur2hux3uKbK99AIBOkzbbd5Y9B9LY=;
        b=xa1TewprNo+rUheXDQDVVUkaz9EK7jeJ44gHxrVaBvFXGh6DpJlhWZxhkp4Qqrcaea
         9Tk40ueFLuDdOyzgQn3NJpsXo6VQosf5a6vtLgb8CKXSUpRm6DJAjGiZA+lW1ViTQc+N
         yP4UCMMLnLDhyMkg8uS5mCGTB9NvptE0aGCXRfjZYbiP9LzCY0lCIO0QMo+YyVDhXjzy
         cfr1gQciAki85Nkatn/6ITMdaonO3vA46eN4ntTGus0rbeThWmiotWVW9se4DwctvMW1
         N58vp3AgKaabJaKhbj4SJxru4QKbzkRs6XUyqarByKXkdztoXqcyZndb2pBdjmXH7P/H
         CA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702836198; x=1703440998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yty6ELNePRoN9Iur2hux3uKbK99AIBOkzbbd5Y9B9LY=;
        b=mDyNxp8jWp7bLwi//5KyxC29GFGnnP9IBbb27Adq5Iufea/Hx6jEPNSrXDx3CVAfbz
         +qKC99YgqEeZRLZY+8rVLCgcFfT+x48ZDau45PKBjDTESOl0do4v7iBmaBtaQ68ce3O3
         y+DNlWDYCGWtYc0HiMKIHA2a5HbNWpY0aqPwkN3/uvZ996U+yJlDHUiFQNpdejX9wHbS
         3rlytgH/Rsfl+gdyGmvO+rL3zuFAoq/Z53D5Q/CNFbBP94nKW8+Q8biG3CVMsH2z5WmH
         JDcHnOCx7jHotXavlKy7EYJYeSa7y4rNQiW9W+udN7i/MHhN5UnEbdO+hW+p0aZyszgp
         C5+g==
X-Gm-Message-State: AOJu0YyhY1jeI3nEnwDYvZX1CSocj/EaAo+hEVURbbyzV+OJ8iE4aJf7
	K5D0m88LKu0gnA9JVsBWqcwsGQ==
X-Google-Smtp-Source: AGHT+IE3tkYSif8lrwDwPBDxv5hdH9V4RYyDPRCX+8SafTxCATHTUhEIxbEi4cH7e1+d/pBOZrByyQ==
X-Received: by 2002:a05:600c:3510:b0:40c:5112:a0a with SMTP id h16-20020a05600c351000b0040c51120a0amr2600010wmq.309.1702836198337;
        Sun, 17 Dec 2023 10:03:18 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id fm21-20020a05600c0c1500b0040c03c3289bsm39056087wmb.37.2023.12.17.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 10:03:18 -0800 (PST)
Date: Sun, 17 Dec 2023 18:03:16 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael@kernel.org, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 22/23] PM: EM: Add em_dev_compute_costs() as API for
 device drivers
Message-ID: <20231217180316.rblvtqaxjvu5xedf@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-23-lukasz.luba@arm.com>
 <8fc499cf-fca1-4465-bff7-a93dfd36f3c8@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fc499cf-fca1-4465-bff7-a93dfd36f3c8@arm.com>

On 12/12/23 19:50, Dietmar Eggemann wrote:
> On 29/11/2023 12:08, Lukasz Luba wrote:
> > The device drivers can modify EM at runtime by providing a new EM table.
> > The EM is used by the EAS and the em_perf_state::cost stores
> > pre-calculated value to avoid overhead. This patch provides the API for
> > device drivers to calculate the cost values properly (and not duplicate
> > the same code).
> 
> New interface w/o any users? Can we not remove this from this patch-set
> and introduce it with the first user(s)?

It's a chicken and egg problem. No interface, will not enable the new users to
appear too. So assuming the interface makes sense, I vote to keep it.

I lost brain power half way through the series and didn't review this properly
yet; but will continue looking later during the week.


Cheers

--
Qais Yousef

