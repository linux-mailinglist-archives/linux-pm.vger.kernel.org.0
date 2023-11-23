Return-Path: <linux-pm+bounces-106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C27F596F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 08:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D7B28178C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 07:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CAF17998;
	Thu, 23 Nov 2023 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYtVk2yq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690341B9
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 23:39:04 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cbb71c3020so1217234b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 23:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700725144; x=1701329944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnV2yqKOcPNVU/h0qUFRaNBNtVv3KcbN9dof9BEc7kQ=;
        b=UYtVk2yqDQ7Lu8oprclAEfT45nJrY2hJQ+/whB1lYpT4jsWMHZTo9zV8s1KMwYEFI+
         H9wldtNcJzz2lTj1n9RsUjIRry705tibUHePkOA1CiQNM5tTxR9rhjbUv0vxyEaEglOD
         ywKF4p6MzQJmBsuZ7h+TmYLp7FVpeWP/JEYdtth7vn4zNSBDbrMqodENcXCzq7eBYGlC
         ycnsZ0jZ/LLIN+iCMYzDGj3RFEijzXSNE2CJ5soiOq206BpVd8SA6Je2HSdlxrFPSlIQ
         LYpFXr74dG+cKgiLumwzQD37DSUl4lA/DtODqeWb+q/V4LdyZd8+vEzKnXbAvvMfIBnN
         G/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700725144; x=1701329944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnV2yqKOcPNVU/h0qUFRaNBNtVv3KcbN9dof9BEc7kQ=;
        b=fPXtUZSQp+mcCl2+V0KQ8mMMTcIAWSfyJWcqHd2aIfIthevGda3Y+XFB7W9RzhRUJh
         5ukgJXi6FAHpOBbNN7xuvDw7MyI2uGV5sO3M4PIKFdlZaKMn7Fkrvtv7UkfB3o1M2qUp
         dBP7HLO35Einp8znCXJkAejnd3OJMTEzkh0jpGftze18eRnMoWLtNApBzIWVQY8NUoY+
         r57/LV+vGSgz3PnI/E+HOyRoq8XNY9t9WH9WnU49cJtEwGsl4/2NS3X2+bfduwxQAX75
         nrvfonyZ7XBZL9Th30haKeUjOuak1svjNEmXKqHrRvlZHz8y2IIVGpdMxz07cXHaBLpZ
         YHIA==
X-Gm-Message-State: AOJu0YwQ5fssAx6PFxzY2erVZ6SmUuQf+6CU8a2WRnC+0/5gNzEbEzAU
	PRoKpYkOzruwZS3JcYg53rwt+A==
X-Google-Smtp-Source: AGHT+IESFAAMDlqgKalFBUEpZJ78OIYtfPl0UuU+VSp5kr/47KyUaSkNptVf7zlPgQwcjCQST2ym6A==
X-Received: by 2002:a05:6a21:6da3:b0:187:bb9c:569 with SMTP id wl35-20020a056a216da300b00187bb9c0569mr2883617pzb.5.1700725143897;
        Wed, 22 Nov 2023 23:39:03 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7808d000000b006c0fe2cf26csm615737pff.107.2023.11.22.23.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 23:39:03 -0800 (PST)
Date: Thu, 23 Nov 2023 13:09:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] cpufreq: qcom-nvmem: Fix power domain scaling
Message-ID: <20231123073901.meb7p4yzueg2lkou@vireshk-i7>
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com>
X-Spam-Level: *

On 14-11-23, 11:07, Stephan Gerhold wrote:
> The power domain scaling setup for QCS404 and MSM8909 in
> cpufreq-com-nvmem does not work correctly at the moment because the
> genpd core ignores all the performance state votes that are specified in
> the CPU OPP table. This happens because nothing in the driver makes the
> genpd core aware that the power domains are actively being consumed by
> the CPU.
> 
> Fix this by marking the devices as runtime active. Also mark the devices
> to be in the "awake path" during system suspend so that performance
> state votes necessary for the CPU are preserved during system suspend.
> 
> While all the patches in this series are needed for full functionality,
> the cpufreq and pmdomain patches can be merged independently. There is
> no compile-time dependency between those two.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
> Changes in v3:
> - Drop patches with MSM8909 definitions that were applied already
> - Add extra patch to fix system suspend properly by using
>   device_set_awake_path() instead of dev_pm_syscore_device()
> - Set GENPD_FLAG_ACTIVE_WAKEUP for rpmpd so that performance state votes
>   needed by the CPU are preserved during suspend
> - Link to v2: https://lore.kernel.org/r/20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com

Applied. Thanks.

I picked the pmdomain patch too, lemme know if that needs to go via
some other tree.

-- 
viresh

