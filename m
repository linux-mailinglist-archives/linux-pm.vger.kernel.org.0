Return-Path: <linux-pm+bounces-2481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE3836BA5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 17:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259B028432F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE895A0FD;
	Mon, 22 Jan 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpxXo7HQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF55A0E4
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936938; cv=none; b=u9wcb0xndcYSgb+h6vDrwVdqZvY9MEzC0ySjs5ffR2DCU/w56M6Pu3biualpxrH4+H+d6KK8YjwRzT1N7iJFzaFDzV2mV/dn5jQZbHWE7ZIhXzUpJZ3QsdTih9OiI6UyMgSjW3P3chUHeQ2i3NthuxsokfZaxCAmOtAFdd6jVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936938; c=relaxed/simple;
	bh=xeP58IH4kb9w8GJL/zzLJNHDo+3mbpiqzZNNn2ybr7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4Z5EP/TEMqziBTN2nor56u13YscT20zCabjPrS+WrdINJ+7K7omDsGhtAF8+VjI+QsQ8yLmbHaRZO3NZU/E+wR2O/s4zmJ7KMgJbqCbppALTrL3Tlv5H/WCRtVo+JAx7lYIgxXqJng3LzmEmCVKapdlCPRo1ChUuAStPMfSG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EpxXo7HQ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc221f01302so2137546276.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936935; x=1706541735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCAhKhxlNboSP5z3UoLufXQw9Hdms1pvWA9BruMBgy8=;
        b=EpxXo7HQEufR54TXn2VkNYzt4mBYN9pCBjJzLKkhB8b4J/05jpK0AfRFQVJazVnQ5o
         Kv2C5YQqq2fhKe5/5tWIAo6qvdg4JGWaW8dmlauq7zAj60tEPhCeKcPB9lMgetn0v6q4
         XYMOxRHsft+nw8zU6b0z7vbD+TJ3ypyMXyzLo2mS25hKX6Vy64TgTtrQYuuDR++Oj+QX
         rasuQqARBOBlJjOzkD+UBZJuw6KVXPiiAPhT0Sn6FJBpyLZk9kbPNel2Z4iBQFAxp6VY
         jQtqlDaZZoQ3BspnP56luzGh7WnH14WwmHmIO75s2vfEhu75iJbGqUO4Ssk+xZrWPlEY
         qNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936935; x=1706541735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCAhKhxlNboSP5z3UoLufXQw9Hdms1pvWA9BruMBgy8=;
        b=PAX1dbTZvOUXiWm79LVKDTxVgzrvnRHyYxDBMHpQVPYgveRp2rgQmL4cNyjUxcrHm0
         l4uJnzDbOmFkCF+w9eCN7CqXC9xRKva6Rf8cSQED5Is8B7jwif8azdX+JRI2xl6O7R2h
         Z/T5MAdCHArcEoihQsis8fTRdMxDuYm/bj1lvI0L32r5ah0rZwUGZIUyH+dXHdRKjHoG
         PPhGYdSRhX/yWzqy45sPLswttlqMOAom1tlyfzgg8l7uHWozygFkLYHJw1zjtps+516Z
         wuXjY0a7D2md9mCjidsP+N3VVgyZtC9t+Anmegwn5UABeDy3MomSDYfL+eWN9lTIWGgM
         TltQ==
X-Gm-Message-State: AOJu0YzbgWpJiizoOL/qmjX00IPA5o40AQ+qUzjiwtQ5X2vray0UDiqf
	nVahvgmEeQ/6IX4EDoGWzb9a3rteLKjTverzIP3/4k/4Rk/QAx76w1HoY/MGMzu1kZ6CKKH3xyR
	wnXSiBsSl/qr0zpHq0pGIIA4rF1XqhN2kO3RlAA==
X-Google-Smtp-Source: AGHT+IED38eHjjKsKwTwHlake7WIjAFshwwfrqlbYigahn2tybClh+eS/93P97aG2765xCGlzD7m+AzmNArNegd8TVk=
X-Received: by 2002:a25:d607:0:b0:dc2:2b0c:2113 with SMTP id
 n7-20020a25d607000000b00dc22b0c2113mr2277335ybg.77.1705936935251; Mon, 22 Jan
 2024 07:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227-topic-pmdomain_spam-v1-1-ff0410086b36@linaro.org>
In-Reply-To: <20231227-topic-pmdomain_spam-v1-1-ff0410086b36@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Jan 2024 16:21:39 +0100
Message-ID: <CAPDyKFr1+vnrhQgSLhD7Kp9WAoJ6qNA0k2WP53wJ0GigdC6P+Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Print a message when unused power domains
 are disabled
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Dec 2023 at 16:18, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> In a similar spirit to commit 12ca59b91d04 ("clk: Print an info line
> before disabling unused clocks"), print the message in both ignore AND
> cleanup cases to better inform the user (and more importantly, the
> developer) when it happens.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index a1f6cba3ae6c..69902797a5bb 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1100,6 +1100,7 @@ static int __init genpd_power_off_unused(void)
>                 return 0;
>         }
>
> +       pr_info("genpd: Disabling unused power domains\n");
>         mutex_lock(&gpd_list_lock);
>
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node)
>
> ---
> base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> change-id: 20231227-topic-pmdomain_spam-2e86227bf02f
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>

