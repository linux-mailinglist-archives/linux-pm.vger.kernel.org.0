Return-Path: <linux-pm+bounces-10275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DEF91D9FC
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 10:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE281C20FCE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1063B83A09;
	Mon,  1 Jul 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5QgfmyB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D4537F8
	for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822808; cv=none; b=tSDzGCOtTb6/9jbUSPcVvebEtki2mZAr3ivca5r5DNoMTMjzc4XgL241dRyQC408NWqJZlb/zsczdwNDvP4M1cf4HP0MtqCejqQjW86P2HpateSgPIrjnUlRym4U0M3h+gy55QByoBOCSzoL6rQ8Su1QQQ42GMmqhew4xylXdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822808; c=relaxed/simple;
	bh=hQ3wIo8jfp+1QpIFa1TH6fMJr5lMyi6hFqlV4E+krQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDbCuZJJ68bTD1OStcPYT5A/+ap5COTYmv+YdAugeQULaMiIg+Nx64uEFIpngikLxs6rbqhToFxVHtMVehJPD+PJkNrkSr6g4451K/xEk1psSM9SMJl4V8VysK1L4hLHne0I6Fp2eWx8zjn9ec+pC435jXblVG3uTq5GAgcMX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J5QgfmyB; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d5611cdc52so1364092b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2024 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719822805; x=1720427605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plmjyndby8wCrQ0dzhsOGEIbNYKVIMLD81+XwlR3F9w=;
        b=J5QgfmyBoeorJkdPqoFp/l1yjZR+g9jGrNHMV60lcxA7aP4+p+/wSXJPZJnIjmjgrR
         feW1hPvaTGbIbuOzyDJO9G1VYh1dfdkqponINWu4NfKvkf3NRjZH3hCuZStGx7UOBQz/
         oVtcBEHpsYO2zWTIlp7qXKsomqbl/M/ZwnqF6ntFBmqy5uvqKJmX29IDFbqt60ckBJUn
         OFTBKlUsT079gl7t8AM/EeeXQ7BFrOcJ48JY3CdNB+Q0CcP9yUtZe4UyrSkPJB3Dkq/Z
         cf4faQNQMPn+RZz3Um9kbHS8aoP8QExhIB4ubNCfnmshpN4s6x4Ylwlw/lAW4/GjUQOh
         tJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719822805; x=1720427605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plmjyndby8wCrQ0dzhsOGEIbNYKVIMLD81+XwlR3F9w=;
        b=xNnpk/NCbkOjRW/nBdP9/6DLXGeGkQsqPuhzCikICpncG0xT0M6an51feGaD8KEXmL
         h/FzWIAcCnWAnjAxl6xYVaKbKiVJw1SMoFYVYNLj4Fbv4vjUIFMUdUoK9Ja6mjV4pIyD
         NGqqeJew6beiFGL4h5C0gMoB5/Dtbx5KHvQHsUgnl0ztJd9E8LjTSxsUcTbkAKWNumdF
         zGLmzojCnNrwz/wfSBrDRKzh8JYtsqrEGxK0EEBfA/QaYYN816blK4AvyVGbqLmgscC7
         39lvFjREzJJwP6oGFbooANOuC9QJzabbZgL3FC8bY4eTfXvrHgHw6QGfpzYyT2BjgnnI
         COcg==
X-Forwarded-Encrypted: i=1; AJvYcCVvyCOb1GRklyW6RyuT0whX1rfPMvsQaSBrUrRdL5e0oPmwgN1QhLGgvTF1j/HdJKPObXZz4E2etke/IqQo17cS1Qguflocu70=
X-Gm-Message-State: AOJu0YxP6IFjEwi3y1qs/7h/tIR06PkCw15lHCR5hoCb8A3P9y4OaePL
	X++MVMxlNFl6PtHbgaZgWqJRU4acBwgi39WDz+fqw3tYiK9fNf60eIctbgLwho0=
X-Google-Smtp-Source: AGHT+IE1oWZE1bOQ7gPCQ6D2Kkco7qOvhQLh2xnubHsY9YThCuK7aoKubwEBd7IojI4Hbf8ohqHZIQ==
X-Received: by 2002:a05:6808:14ca:b0:3d6:31eb:69b1 with SMTP id 5614622812f47-3d6b54975afmr7594905b6e.58.1719822803407;
        Mon, 01 Jul 2024 01:33:23 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf63esm5885051b3a.123.2024.07.01.01.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:33:22 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:03:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powerpc: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240701083320.c3r4aussa4qojewq@vireshk-i7>
References: <20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com>

On 14-06-24, 23:08, Jeff Johnson wrote:
> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/ppc-cbe-cpufreq.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/powernv-cpufreq.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
> 
> This includes three additional files which, although they did not
> produce a warning with the powerpc allmodconfig configuration, may
> cause this warning with specific options enabled in the kernel
> configuration.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

