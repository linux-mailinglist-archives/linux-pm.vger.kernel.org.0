Return-Path: <linux-pm+bounces-14992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3898B497
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 08:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9041F244F1
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29C1BBBFD;
	Tue,  1 Oct 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHZGgVZi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441D191F8D
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764764; cv=none; b=WiZTbq1nqBeYgjmlqmDBCC7DjsSbuG7D2mzwcZzZwPPlkw0YaWtmnV1FTsnkU6tOp062drjYjenlAeD7Y8+3nr8zYaLV6Bc4Lq5OJlkliz9f3Ay9uV7TleJHpcQGYBjbkIdzHgZiWXo2l8gKTEfz3wZRTI8iaFTMgIffeA0qwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764764; c=relaxed/simple;
	bh=/8g2XKzJ7WqJdunmQNLOFhxbd7lyRBKMdd90F+97gug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJGjCQwiFPkf/o2XQnpRmCg90MrKC/2OXx0bc6iIx8FyYMyU1a2vZbwbRPzqamb/nbhvP+Owg4PfHOQ6PZVF2U5WHlLbnlxTQ8ZCQBjR4l3g1hoI4DREf0ZLikTR/6TfZUu7uM2wsm5qr2v/qeDnKRnt3MnOX4zu0PzaWbN9RRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hHZGgVZi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b8bdea19aso15064365ad.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 23:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727764762; x=1728369562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZZ9vGNAt5u/4C0MxsgZzleHQqz1x9Kb0YcmVd2T7II=;
        b=hHZGgVZiMrjUfITYD11LkPioz8ZzMHvRFWZYvru3+ruc4B5SO3y9JrtAGC6/u5V+Np
         Tukkkq7GIBIglfFiTgHbH8o3fRSW0iYOpSLkh+GshctbykwKqYhn/W/YW5kpRBp6y8na
         d+0TGP+GisaYfAkuhkxNwoyg2gG0EHOTcK5lXPzAvTomxgtecbPia/R+VxS7VMgW6gim
         tL/mWUpkPtHdqNY/EexUEcW1MLF/HQOdjCB3QycCX6VTNjWzEKT9oU4A3IlRXnWpV3WT
         gistaJ/nWkwgnCbknIXVbWk41iGKqOch7c4+nfasi/G9n1H/eYHlrMvReVDr2jecCc6l
         Qhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727764762; x=1728369562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZZ9vGNAt5u/4C0MxsgZzleHQqz1x9Kb0YcmVd2T7II=;
        b=btPAJ/h73xmOn4SxEU0ZQpp1klYpTccD63Lw9jCbu9v8S04cSZauwN/t9T+29SkHx7
         mWTR0TQIGrtm9QzfRa5FlVOEo+F2/oWtEUiLP11jRaSQRXJqy0Gi0AlqLCRrPDhfzNIi
         rAOICUVcDWPXv25Wevhyw/XduPnAWoPQOqnRgddRbvx913jDAyGiPlOYBqvD8rpiTMDm
         XpGuM2Z4jzmqMCrRIxr5ZcP7R6qIbnxCFdsKjhV/1I5m2/+HrJa+HUebZ8PBbRywW8KJ
         oqlFBBGsmUXPRrIWYmoM80LAUfbD+y14vW6jrF/iyOS15wOUBGsowUBwTOBWlkW96tuc
         NATA==
X-Forwarded-Encrypted: i=1; AJvYcCVZw/L5a+v9dnHybLRdxlsHEPmsoMyDhCHlk0DJcbJHFAq2FfqzZeJ1Q5+KAppgDDT87JPwoTaMpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjv1vgUkhTynyGd29xSamRhF4OZHBpfm5L0yiqIumWGVVwS20Z
	IJse+vt5rwmMrmeohIyXv6iLtjhCsLqZn3e/ozwEqsjsOj5lJNYA8b0v6s2qGWk=
X-Google-Smtp-Source: AGHT+IEOWqZzG8Ei19f42OBORnd3BwYUOQNDduKM+xXWWDwe/VJfk5IdBqLsuddvXismy7R+pVb62A==
X-Received: by 2002:a17:903:2445:b0:20b:6624:70a7 with SMTP id d9443c01a7336-20b66247298mr134389545ad.21.1727764761891;
        Mon, 30 Sep 2024 23:39:21 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4d67esm63482095ad.229.2024.09.30.23.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:39:21 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:09:19 +0530
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
Subject: Re: [PATCH v1 1/2] PM / devfreq: mediatek: protect oop in critical
 session
Message-ID: <20241001063919.ekqfd4epcefh5eci@vireshk-i7>
References: <20240913103933.30895-1-chun-jen.tseng@mediatek.com>
 <20240913103933.30895-2-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913103933.30895-2-chun-jen.tseng@mediatek.com>

On 13-09-24, 18:39, Mark Tseng wrote:
> mtk_ccifreq_target() & mtk_ccifreq_opp_notifier() is re-enter funtion
> when cpufreq governor is more than one. It should add global mutex to
> protect OPP , avoid get wrong frequency & voltage.

I am not sure I understood the problem well. Can you explain clearly
why the current locking doesn't work with details call chain ?

-- 
viresh

