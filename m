Return-Path: <linux-pm+bounces-1269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A700816649
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 07:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80448B21A86
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 06:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D26ADC;
	Mon, 18 Dec 2023 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLP9wyXs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D7F9CD
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d2e6e14865so8218335ad.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 22:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702879793; x=1703484593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4fv33Fm98eoYxsFhCy3k/IYwg8anoZGWSZZeryLa0Lk=;
        b=rLP9wyXsWxAlAXC2WbW9KVDY0fNJ7Cez6j4C+8W8AMgxz0R5jYWXyjyst+wPu4gd40
         Vi3m16LjxYZiD8yPyctnuETvNXDCMQrQzl+OAjm96lpb7Gn+jG0vrCyAYnLqNgZnnKdo
         dyo6Bs0Agklm7puOB6BF/nbjOZvFxFjEpkdKMRPS825L1A/E4TPQz3FXjH2uoNtrF8Gu
         X2FDJ8TO7R6RX6K/uj0iDb9N8sXgI/haPruHbEDlCtcDKI/vwnto6XWZOXk4kfcxmEy7
         f6pxhUCCosmln19t0ohxqnRx3SgjgCn47si0diVNleAc2ycONeDS5s5d92Xj/2W40OmN
         QOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702879793; x=1703484593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fv33Fm98eoYxsFhCy3k/IYwg8anoZGWSZZeryLa0Lk=;
        b=Hq8ud29hUPPtlCCWRzrhO6FbtRzzQp5CSZh0mfDsNUKQXtmsHZU+WzkovqBKub6lcq
         Bo5RSIgI/3wDWxgo4J9BcZxOTbz2M3zO+6b/XlGiUIks92XF7Ff9wkCMfiWl71jJ1XNG
         sQznjCtXyBw3f6lnmg66rp1wjoxJrzGoytmsAlF7nR6WapZ/EG42Qc2P5BpqPDC2m9+I
         4BsJNWCPyad/mGfEg4UYNkf1IgdvcwveZlGndelowGo4puxGl/bbSQHgoZxOh6goDde7
         wqwCmY3EZVbx/FBmpcfCj6J+zLnE1kf0y0W7Ud+obH6a9czSKEwpQTxIrxjTRUE/L41S
         nUrA==
X-Gm-Message-State: AOJu0YyjUrYxmR1vEc930w6fNLIi4R8T+XHQrQo3R9651DsZq7I5uve2
	aX3owGnxsxORJySScCSfSt5ruQ==
X-Google-Smtp-Source: AGHT+IHO/9Xk10TyLpqn8u0P4FpfNwnhyw1y6P9qlEWj/EdN4sfd0o4DUGEMCVK2HXlQ7b1MpZUXAA==
X-Received: by 2002:a17:903:2446:b0:1d0:6ffd:6e6e with SMTP id l6-20020a170903244600b001d06ffd6e6emr8491684pls.102.1702879793608;
        Sun, 17 Dec 2023 22:09:53 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001d058ad8770sm18245931plh.306.2023.12.17.22.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 22:09:53 -0800 (PST)
Date: Mon, 18 Dec 2023 11:39:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Holland <samuel@sholland.org>
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>, aou@eecs.berkeley.edu,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev, palmer@dabbelt.com,
	paul.walmsley@sifive.com, rafael@kernel.org, robh+dt@kernel.org,
	tiny.windzz@gmail.com, wens@csie.org
Subject: Re: [PATCH 4/5] cpufreq: Add support for RISC-V CPU Frequency
 scaling drivers
Message-ID: <20231218060951.yhhyini4neyusyxv@vireshk-i7>
References: <20231214111702.xdd7qlcrpqh74i3j@vireshk-i7>
 <20231215151723.46409-1-fusibrandon13@gmail.com>
 <11b5aea1-7c6e-4be5-ae01-9c4c869dc98c@sholland.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b5aea1-7c6e-4be5-ae01-9c4c869dc98c@sholland.org>

On 15-12-23, 15:09, Samuel Holland wrote:
> Move the option to the main drivers/cpufreq/Kconfig, like QORIQ_CPUFREQ,
> which is also used with multiple architectures (PowerPC and ARM, in that
> case). We don't want two options for the same driver.

+1

-- 
viresh

