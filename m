Return-Path: <linux-pm+bounces-1155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20017812E5D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44491F219E0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24CF3F8F6;
	Thu, 14 Dec 2023 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4mfJcqX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A47B7
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 03:17:05 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c659db0ce2so6885272a12.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702552625; x=1703157425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhCwqmV8xLeKliC/IPYCJgesOy9krq9jbqPfrEK110U=;
        b=U4mfJcqX3m54VsdVzL4nix77soE66bGG2Te9nVi0c6csFEDYFi4C5HFm2D6S6FhX7s
         9/2cb6xmW0PHIh8woA/A12Vuyod0EJ5PA+z2pHyEy7q+O3YLBi6bwrBVblofS4mDd4YU
         bYkoYs8WvK1cdgaiq77Xdylvc6I5Gj8GDL0SmZJ2+W6O0bbQUa2Nc+orCWBG2p+Qh8Xz
         MEDeUw3YjJy+y00ogQlxHXtTENklAUFYU0+Vo7IpESRXIgWCKdDB2If21JZ9u79R9DtM
         ykUhXY9UFxgFIVzGHKGxYyY/hCCScYU/Uhrv8sLPa1HNsTEoquxj8G6/Whny5atqirPz
         X2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552625; x=1703157425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhCwqmV8xLeKliC/IPYCJgesOy9krq9jbqPfrEK110U=;
        b=EfC+iPgFpT2HfetGTg2ZMAvBI/uzPRggcnZztaSjbkZKr8QjQxqLbIzxq04QK1wyy+
         rWmZVc2P6Q3muF5qLFQXSknr2jlNSyNCQAxA+aJOWoQ3U6VjLkNIlByW6AIAJX8yQG4j
         CQ+V/1ndUZK35ccXXmcA0ib9UjKvvS9YD6vxQ1qBKg17ZyZ4+lyXepCq4gFLth2FdleR
         rphoqdSK5GZNSkOm4nDnKvng9P0um+Rbwqgjyh23SrbbmHSf4Zqo/6BS4x+x65dWbSNn
         lMEwe5+hjIqb5diIjBCd6RiTO7SVDiRW2NWz7EM9JYa7ndgv802lOudZqO1rfD3KRSYC
         ca2A==
X-Gm-Message-State: AOJu0Yx3eRhcosHinHh7oXeVLNobw6Xp4z0ngjD8vkD10id7pDXSCzwk
	uE/fRkdxbWEC8gB5x6qUvt680g==
X-Google-Smtp-Source: AGHT+IEGJ5iYsTvFrjTZorn1/MwkkSYEnSuscp/ZLU2pi2M1jcJ955V1my91fjw6E7prxIYt4wTjYw==
X-Received: by 2002:a05:6a20:8e13:b0:18f:f57a:e761 with SMTP id y19-20020a056a208e1300b0018ff57ae761mr12774382pzj.63.1702552625048;
        Thu, 14 Dec 2023 03:17:05 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id f7-20020aa79d87000000b006ce5b4ade28sm11799418pfq.174.2023.12.14.03.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:17:04 -0800 (PST)
Date: Thu, 14 Dec 2023 16:47:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] cpufreq: Add support for RISC-V CPU Frequency
 scaling drivers
Message-ID: <20231214111702.xdd7qlcrpqh74i3j@vireshk-i7>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
 <20231214103342.30775-5-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214103342.30775-5-fusibrandon13@gmail.com>
X-Spam-Level: *

On 14-12-23, 11:33, Brandon Cheo Fusi wrote:
> Add Kconfig file for cpufreq scaling drivers that can handle RISC-V
> CPUs. An entry is included for the Allwinner H6 cpufreq driver that
> works with D1.
> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  drivers/cpufreq/Kconfig       |  4 ++++
>  drivers/cpufreq/Kconfig.riscv | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 drivers/cpufreq/Kconfig.riscv

We don't have a separate kconfig file for each architecture. Only if
there are too many entries for an architecture, we add a new file.

-- 
viresh

