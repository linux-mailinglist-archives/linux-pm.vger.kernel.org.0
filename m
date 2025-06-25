Return-Path: <linux-pm+bounces-29491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4D9AE7E77
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4DE5A2E1E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF0285CB8;
	Wed, 25 Jun 2025 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyV7PgI/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412C26A0DF
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845873; cv=none; b=tpZP+4XpDcHCNLLHVllEMgC84K+z/QT/1AfpGmoFgu1U9WX+jL9zpz/fWiZCtCukRiBUupGEuwxs5tKKcpp0baP0rNLxWMQYwPQ481lv4g1hh9vNFL2lHHq7k+32Xtpsjm5I5gwhwccZ8mibXLY6LGN+Fk33V7bh//tTzZZEZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845873; c=relaxed/simple;
	bh=EQuPWVkGF1nshAKLaU4W+d2hSy30i6DDLNsWfTtXoGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cl4WbRyUAlTfguVqHZErmxMDNaOonluMXKVzkVDMcGl2IeO32QMf8G4bDpf+lU1hekiFRpHNP64rxCaZ1dS4p+k8az59dr9bs/3xcELafIuoUcnCYhq0TM6D0tsLaXxLiI+WgY8y0JzW46dY7eBFASIJZOF6AuOis5pSLiyzu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xyV7PgI/; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8275f110c6so4831801276.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750845870; x=1751450670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2FoYZ4Nr01R53huec/tf1xznQvupBhVO4tbylq2xKes=;
        b=xyV7PgI/+uKLHWg1XqvU//E0ZL9rWBVCCQl+WJuiImbX24rOSLJu8dVZBQumszGCtJ
         cJJ22cAoXQqVAL1rpiIxh6Wm80cRyjDuIGzAJeQP1RBsf0Qw/R2QW3b49EB5+NQpqAij
         0HwqPqEf6J/gtUWJGmR6xD3KWDa7SJDqmA8JcRX6BYTTXiyOODiuR8QK+31P+doEaKPD
         qmARKXfqeoL6Rwvh+WsOlQoh6VIgceSsBjmoYnJm/fu8XMKGuumwvwHCdKVrkb9Nb56I
         IFV3RmsTBDvCOVe349vj05fQ7Du8QRTvQcs8GbXNUavwoqtdN8M6ZgvTFyE+3LhhIAmH
         w5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845870; x=1751450670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FoYZ4Nr01R53huec/tf1xznQvupBhVO4tbylq2xKes=;
        b=Z9NkAAu1nHglKIt3F6W9F/jHgy4kyuYiqxkdLW5zom3p4bH8oujSu+raglQEHYrUrO
         TznzChJGlJkrKVUkfokciaxDbbz6nvCfKjFwfoCVSI5F+gBmHxFdUCR4CBnUPJnbAiSp
         fM89sVHs7SHcEantkxFG6gnIZej0CmgbvVbffpiL9aAGRN0Yv3MQlqIWPPOl1Rg6RTe6
         wkTa+FclSK1HRREnZW7ZGg0t5e7HLJURLnhPsYE+QfDzE7D0PtDj2kcsDtPpCRMRCLKz
         ms7mi151l4w6f3HzvBAXS4KQzfpzjefBL2SpCuWYWzD0VOmrC8CYmU/oJ+ZvtikW/gcH
         +3ag==
X-Forwarded-Encrypted: i=1; AJvYcCX8oA6AKpNiH/G4C5f3L/SvPuVd6PsNUV9CDzzFaWtlxzBWgFqJpn7IFeoX4OwJDiXsurEIRmnFhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVNlJEgLlBt+DSNzyQJgaF+ae8OhRS5/x0SJuuEVby+6QN9nu
	gCuOL0FZ2decICrd1sxQ/G/JtY2HA9jo054fTtdtqbWrEINqwM05/ygYTnhtTXQtjiRsDyT0IdZ
	5Bv1gk6b1Vaux695K6CYTCwPEDiyy+JF+hlxNrnbPuA==
X-Gm-Gg: ASbGncvpD01hwYNZodN7kN/zGK0Y2XNMdF9D0bWRckgCcp53IpCqcT6zGlohE2c88jG
	MloeM14MrnTj73iMfZc3CLO2rVPMkeF6Oqh48mA5YvL9z6wA5dVg6vXZz4P6GrSWpOFAjIsGqeC
	pVuLoFsoEekztaZRsGpCeRE/MLYm7PVuy5X2dJH+ZARJo=
X-Google-Smtp-Source: AGHT+IGEwF//unOd8KqnIb3kUSk3TkEl6eAh1VfDQazORQUWho3pyKqqzApD4UjhgThjUzADzPYQsRLphHC9Om0O8cU=
X-Received: by 2002:a05:6902:100e:b0:e81:4a97:b8dc with SMTP id
 3f1490d57ef6-e86019b93abmr2658200276.48.1750845870308; Wed, 25 Jun 2025
 03:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
In-Reply-To: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Jun 2025 12:03:54 +0200
X-Gm-Features: Ac12FXxb7NJQLDFAGAZjqxBIaCwRE2IAI0_rkmMKymSaefvVyWHj4pimfXs-K_g
Message-ID: <CAPDyKFqUZ4pVPgrWfCjH2dDBPRs37L9nc_tAqOtUR=0hzweKVA@mail.gmail.com>
Subject: Re: [PATCH 0/5] pwrseq: replace magic numbers with defines for
 match() return values
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 16:32, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> We currently use 0 or 1 as magic numbers returned from the match()
> callback. It's more readable to replace them with proper defines whose
> names indicate the meaning. While at it: fix a build issue with the
> thead-gpu driver I noticed and extend build coverage for the drivers.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Bartosz Golaszewski (5):
>       pwrseq: thead-gpu: add missing header
>       pwrseq: extend build coverage for pwrseq drivers with COMPILE_TEST=y
>       pwrseq: add defines for return values of the match() callback
>       pwrseq: qcom-wcn: use new defines for match() return values
>       pwrseq: thead-gpu: use new defines for match() return values
>
>  drivers/power/sequencing/Kconfig            |  4 ++--
>  drivers/power/sequencing/core.c             |  6 +++---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c  |  8 ++++----
>  drivers/power/sequencing/pwrseq-thead-gpu.c | 12 +++++++-----
>  include/linux/pwrseq/provider.h             |  3 +++
>  5 files changed, 19 insertions(+), 14 deletions(-)
> ---
> base-commit: d4c2d9b5b7ceed14a3a835fd969bb0699b9608d3
> change-id: 20250624-pwrseq-match-defines-aec46817e69e
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>

For the series, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

