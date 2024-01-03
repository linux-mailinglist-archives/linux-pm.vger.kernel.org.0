Return-Path: <linux-pm+bounces-1807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1D582392E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 00:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19141C249D2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9013D1F60B;
	Wed,  3 Jan 2024 23:30:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0211EB53
	for <linux-pm@vger.kernel.org>; Wed,  3 Jan 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce0656a7bdso2183613a12.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jan 2024 15:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704324656; x=1704929456;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPKuGIxWLQkrxq/6HJv4rBrlgdO9b/KHP8c8IcA9QQw=;
        b=GhFnEyNf3uHKJ5TG5Zz8R5XH+H2R145bLPS2VUinaxN5f9Ida/AnP5GZU2x3ZQ8djo
         g4zE7IjqcYXNOe5tojCBEKErYJxqwDRVJYpaionSMHbveHVuyxwrcZaA7QKR/anp7C1S
         6mPWk4aZvJzsW4mt1R0qgWQ+XpJriJNThnTnfedCbB3FsveOmWdqJG6o7AglRmXivk+U
         VVcceXPRcIZJlQocynhZ0hNkq9/7x0NDTcgHTRoeBOFAEIc5fwpZZQbHQ61UjdBFK+rF
         4uOvXDudOdRP8DXpI+Wpbxx8yTOJJVUyANVASr78yz/RoPcr2N9UC015GaaprYanIV4v
         qy7g==
X-Gm-Message-State: AOJu0YxRVWE/LqBTOmfhsjttebKDXEnOU4kklcvi5pmlMqpcNcycV5hU
	acyBXXti7feRQPanDka1eMGunC4K/Pf1aFZqnu58944W9Rc=
X-Google-Smtp-Source: AGHT+IEJCBdZg1COiav9DFGhNY/oMbK6nuckRXEunUknRy40h+ZiVhN86tqyGQ0BWUQxq5YQITU85A==
X-Received: by 2002:a05:6a20:3d01:b0:196:a52d:94fb with SMTP id y1-20020a056a203d0100b00196a52d94fbmr3672706pzi.46.1704324656277;
        Wed, 03 Jan 2024 15:30:56 -0800 (PST)
Received: from localhost (75-172-121-199.tukw.qwest.net. [75.172.121.199])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b006d9bf71461asm16450490pfj.86.2024.01.03.15.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 15:30:55 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PM: domains: Move genpd and its governor to the
 pmdomain subsystem
In-Reply-To: <20231213113305.29098-1-ulf.hansson@linaro.org>
References: <20231213113305.29098-1-ulf.hansson@linaro.org>
Date: Wed, 03 Jan 2024 15:30:55 -0800
Message-ID: <7hcyuiatao.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> It seems reasonable to collect the core parts for the generic PM domain,
> along with its corresponding provider drivers. Therefore let's move the
> files from drivers/base/power/ to drivers/pmdomain/ and while at it, let's
> also rename the files accordingly.
>
> Moreover, let's also update MAINTAINERS to reflect the update.

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin

