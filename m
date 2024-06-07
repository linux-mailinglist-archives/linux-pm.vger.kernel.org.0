Return-Path: <linux-pm+bounces-8776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F590010E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 12:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779ECB24161
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF1615DBAD;
	Fri,  7 Jun 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnaCFC+S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9077A15D5C4
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756689; cv=none; b=sdV2W89rUuDVsL11D0nnG5X7/XE+HknYGT6jXG/LSl5YyygV6jHDLSyQJllhNrnzU/VEn2vpyI3WbFyDk8Tiuh2D4Y8NHEs2Gt/MtKFvOSoYsw4O6z1VR5bCAbdqW0+MYPVGoU0lOk4Jrthh7JxGbI+xHDInkoIi7uRABepPK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756689; c=relaxed/simple;
	bh=Dfhm+Ao2OctkWzCPUlbZo2WPxOBCaMO/F20ozOPjqus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RwB0JubgeDP2i9Z2uvLRk/3ji5MYoFJEA77bQa+Zz6yco+EzD298CPGLbbJUdFEDKyLcEtoNKXa18lIGnbUIsQGjy1U0shWHYKNGf1yHlvALzOfB+G3vaqRIyT+pGFqe2LR+Xqo8LSpwZhEP+nM3X3OVkzB9JGynGS6Gt16nFA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tnaCFC+S; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3550134ef25so1916200f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717756686; x=1718361486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dfhm+Ao2OctkWzCPUlbZo2WPxOBCaMO/F20ozOPjqus=;
        b=tnaCFC+SfWcqaMHB00quB4nInAKRiCZ3/LOVjc287R7qxnZjZpN5e3BPN+ZzlW3moj
         ggk+LgOorn0Q5iL2g/rIOfCT1w16yAeXwxMkozo0R4e/n0J6mkoIanKKU8LSUONCzPdM
         qQzreCyjRcpQhrPlIkhEPo0yzRe8WX2VF4QMHPVmTQa752KibDwCyHufFR8U0j7HDniI
         HSqKGj4GZNiN4/K3d0BTnbzGsyxEZo0K/xEnIMd/gjtqK9Q+RJB3j/2GC+fTuKX5ltsR
         xPytFClmybpR9z/J6wygzscxN6n8s5WuUuL0xUX22m+cfpfTnzwHIz6lesjdetA6VXKI
         MIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756686; x=1718361486;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :references:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dfhm+Ao2OctkWzCPUlbZo2WPxOBCaMO/F20ozOPjqus=;
        b=Gbxp3/M/zYxpHhGvT9/bzR8nwVq6DSHOYFHDy6PrO9yU0lTCLXthQWaP8bwECwWGKn
         8qwTLRsqarVuXu7YNWSWETfqqdCccho+83DtlDKi8pk3hwTlz3WcLbAb9ggEuin+4B2B
         T6lPvqCAOc54Q9RoafT2/Y2rVtB5RpdTibFzpbVmN5JNwy6BVIWL0wx58lVFZr+5ygoX
         Ft+evcfI/x3kaq5bi4HYYiWuhLY8uOXejVc8XZ1oWIp4JJz4YUmeJf3KivpJFDJGWMS6
         k6DG/FAYBTNQY7A1vRTMlQN4bVra5hsfXdacSYV283f5KizgRIoxTZNomw4LJqLvnTcN
         aSTw==
X-Forwarded-Encrypted: i=1; AJvYcCUN2NgmmBcF2wpXhNTpKL5P0j3Vzqufap6oYUjjfTUXfoI1Sm5yRSVLiPdch74JpaFFnrEBRGO7OqcoeC4OgghcNeBgMvgundo=
X-Gm-Message-State: AOJu0Yyf3T246ujqqeYG4GB3T851gbA71u0q+50/yvw9JfkkPy2WxH3u
	5Y2YdNOJpqooPSqZEeOF4+aCfO3VY75djXcglremzdtWew2sdodYRccTEMY5EGA=
X-Google-Smtp-Source: AGHT+IEalbWRcpQcRyHzFdufx8s7rTDBgqplrK6U7baTcerM2u8XIM+miaw2LC/2FNTBgh129sR4nQ==
X-Received: by 2002:a05:6000:1755:b0:34b:1a4f:23fc with SMTP id ffacd0b85a97d-35efed1cfeemr1613166f8f.1.1717756686002;
        Fri, 07 Jun 2024 03:38:06 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e96d7dsm3675615f8f.67.2024.06.07.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:38:05 -0700 (PDT)
Date: Fri, 07 Jun 2024 13:32:22 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Y=?= rn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 1/8] rust: Add initial bindings for OPP framework
User-Agent: meli 0.8.5
References: <cover.1717750631.git.viresh.kumar@linaro.org> <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org>
In-Reply-To: <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org>
Message-ID: <ephjf.9236xxczfzy@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Fri, 07 Jun 2024 12:12, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>This commit adds initial Rust bindings for the Operating performance
>points (OPP) core. This adds bindings for `struct dev_pm_opp` and
>`struct dev_pm_opp_data` to begin with.
>
>Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>---

On the Rust side of things,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

