Return-Path: <linux-pm+bounces-1651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB781FA3D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 18:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F70F1F24133
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADBEEEB6;
	Thu, 28 Dec 2023 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="n5M0W6ni"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5BF51D
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d4ebcc207so49627775e9.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703783598; x=1704388398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Av6IqslQf5eK6UkK0GZEStZMwWsd1UR26mqfBMBGye8=;
        b=n5M0W6nia4WB2erSBeDDZ8qVV2tqqx0kDLzYaVKzrakcZX5PLrcDT9Hjx7+VKkBpb2
         Cok6YB/MdbLiCLET4bADuRZPxkNAbaCqM0CEc3UdsXGj4oR42bWYpClu55i2SqDt6jHy
         PNq9J0yiDnCa8UiE3JW9NZoBiRRR0FoIpTHYndsZDVDZItaceNBTDBWAe2xlWAj6WqCW
         O6cZ7v3QygZjDtj4DjbiwwUMBFLV3W+gsqNM79zIN+59w68TkODtQVlC6dl0pSVisK7Z
         4GECUgLOb77Bp9sql4hCY85rr5ynCnw+6OaE/94a5IqMq3NgdztAWoj8IN/8zWv0if4i
         jhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703783598; x=1704388398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av6IqslQf5eK6UkK0GZEStZMwWsd1UR26mqfBMBGye8=;
        b=Cq0P8XT85CtymYwW+hM72o3r/XdSg5qwPTcFSJPhont3wrtNKy6zKXocIr8mcAv5ll
         9a5PnQ8zo8qoFIYMDc7/d9VPiZ/FECTvO3oCdunAhb5l4kCQJnqnCD63YcL5FDYgpQKy
         o7srSKqbEvN/06k3TvvReUiu+AIktcIlHdM1Wcv3agwZCRIBJ4dmRdgPEvbABVWIUoOk
         RJSUiiD/03y4bh8969MmTI/lbPNlUudN1kbJSRQeMRzh08Vn4wa5CinxX5ZnBKo/2/uv
         pFT0ASCxHLrO0Bw0eepVrkOrchQTqvVJ4H0eSHnUsPwezjnFKhq5TLlWFxGhD+lIytB9
         /e2A==
X-Gm-Message-State: AOJu0YyovA0gPsTgtD/15hW+C5UqhATdOU5zY6sF6ro2sxcz6RzfTQp8
	iwPEPiZYNd0e3B8pFnWL5yJXgie//EdRnQ==
X-Google-Smtp-Source: AGHT+IE6faSSJZCLfazhRThkQJ/u7IPTTBPn6fZfaAkxqV5iXqYyLPA5xps9V1e16/in5i/LIAUo4Q==
X-Received: by 2002:a05:600c:12c6:b0:40d:3b25:476d with SMTP id v6-20020a05600c12c600b0040d3b25476dmr5433506wmd.4.1703783597650;
        Thu, 28 Dec 2023 09:13:17 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d5fcaefcesm5497844wmo.19.2023.12.28.09.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 09:13:17 -0800 (PST)
Date: Thu, 28 Dec 2023 17:13:15 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 03/23] PM: EM: Find first CPU active while updating
 OPP efficiency
Message-ID: <20231228171315.bmjdo5eztyix5o3r@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-4-lukasz.luba@arm.com>
 <20231217175829.a6hqz7mqlvrujsvs@airbuntu>
 <b31672e4-ab41-4724-86ef-038606318663@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b31672e4-ab41-4724-86ef-038606318663@arm.com>

On 12/19/23 10:53, Lukasz Luba wrote:
> 
> 
> On 12/17/23 17:58, Qais Yousef wrote:
> > On 11/29/23 11:08, Lukasz Luba wrote:
> > > The Energy Model might be updated at runtime and the energy efficiency
> > > for each OPP may change. Thus, there is a need to update also the
> > > cpufreq framework and make it aligned to the new values. In order to
> > > do that, use a first active CPU from the Performance Domain. This is
> > > needed since the first CPU in the cpumask might be offline when we
> > > run this code path.
> > 
> > I didn't understand the problem here. It seems you're fixing a race, but the
> > description is not clear to me what the race is.
> 
> I have explained that in v1, v4 comments for this patch.
> When the EM is registered the fist CPU is always online. No problem
> for the old code, but for new code with runtime modification at
> later time, potentially from different subsystems - it it (e.g. thermal,
> drivers, etc). The fist CPU might be offline, but still such EM
> update for this domain shouldn'y fail. Although, when the CPU is offline
> we cannot get the valid policy...
> 
> We can get it for next cpu in the cpumask, that's what the code is
> doing.

Okay, I can see now that cpufreq_cpu_get_raw() ignores offline CPUs
intentionally.

A new variant seems better to me. But the experts know better. So LGTM.

