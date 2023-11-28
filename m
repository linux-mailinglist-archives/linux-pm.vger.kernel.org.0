Return-Path: <linux-pm+bounces-350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5427FB7F3
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 11:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD1E1C2121E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0884C3BC;
	Tue, 28 Nov 2023 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNg89kuF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B53CD45
	for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 02:34:31 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso3825748b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 02:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701167671; x=1701772471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Yyve/MpYopjqzKEDi1Y9CR3K8+cxDXLytjrxavvjAU=;
        b=vNg89kuFzkutHT6nenw0wB5E+SvIdw2AOS0ytnHwaQyfmaGrcTNUNvFLv8DBdHTZ3B
         g70V+bf5M5PiaUsFBKsJFummHFMx76ca3WHH+bgR4ajRa70uWWBnmC3e6tL2sEEO1/gh
         QwMyGR0pu/N//0xIliW5odG1ccMfY48PWVuuU0dshLqnmn3j7+PQx1RJa8kmQtNBMDhS
         38CXQRmdPKG02dlO6DAL/KbZpeZNRU32AXYOMsDpdEzjYH9i4O96kEoBazNzmK9ntfdM
         Osj1LrbmJwkjx49P5ks07aIpe6l0e2gqrL6SEzaV3BBCsrj7E+trIQzrf+i62hxs59xD
         Mwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701167671; x=1701772471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Yyve/MpYopjqzKEDi1Y9CR3K8+cxDXLytjrxavvjAU=;
        b=gXkZYP4CWkyd8+8Z+fJSQ7OPM2W9DFqt6UkhyfawuPFoafAE9bHPoktNzLUyaQx093
         y5Urj8ApvDJQ5iZHDjgwmTlV8Wdzjj2prTgVennJd523iCNeQCIfakwloDxT9AygbCvs
         Gi8PdRwyEyMi9uiDrP8/WhcD8hpZgVIna4OyZZvAfnZsJUi0WczSQU+FM6WvnpC/yGY9
         KXnpKZ3PnBqgb9K+dmIa2nnFNDOcncCHpAbVBei12uGa6XUUeptnCD/UGeQLSh/fgPKh
         2f0KafiFmG2aXPzrRWu+E+xK8LGqnF+QNro8CQQ/aqW1jQ8IXUoRnC5GUMFdaoz9ud++
         rs6A==
X-Gm-Message-State: AOJu0Ywruy+pmNcvGJLFQVT+/X69YIcyFGr3t4Qx34kAzDcpdjuu8Uy+
	Jdtm1RbK12OT2CNfAjwD2aCDKg==
X-Google-Smtp-Source: AGHT+IFphre2IOCGQmscY6xeXA4mJ80hFOQLqrzgfqIhwhyj3EcjqOVFv1DI9ExufEeI4z1KX4HrYQ==
X-Received: by 2002:a05:6a20:8f01:b0:18c:a983:a5f2 with SMTP id b1-20020a056a208f0100b0018ca983a5f2mr7390871pzk.29.1701167670999;
        Tue, 28 Nov 2023 02:34:30 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id by6-20020a056a02058600b005c216d903bdsm7982692pgb.89.2023.11.28.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:34:30 -0800 (PST)
Date: Tue, 28 Nov 2023 16:04:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/3]  OPP: Simplify required-opp handling
Message-ID: <20231128103428.hckenu5khg3n5cok@vireshk-i7>
References: <cover.1700131353.git.viresh.kumar@linaro.org>
 <ZWXA9_VDRKzMA9Nj@kernkonzept.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWXA9_VDRKzMA9Nj@kernkonzept.com>
X-Spam-Level: *

On 28-11-23, 11:29, Stephan Gerhold wrote:
> Sorry for the delay. I tested the "opp/linux-next" branch (which seems
> to contain the changes in this series already now) with the following
> configurations:
> 
>  - Single genpd used for cpufreq (MSM8909): Works
>  - Multiple genpd used for cpufreq (MSM8916): Works
>  - Single genpd used for cpufreq + parent genpd (MSM8916): Works, warning gone
> 
> Thanks for fixing this! :-)

Thanks a lot.

> I guess I'm too late now but FWIW:
> 
> Tested-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Updated the commits with your tag :)

-- 
viresh

