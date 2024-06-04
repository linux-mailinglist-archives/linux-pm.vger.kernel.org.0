Return-Path: <linux-pm+bounces-8571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565158FB1FA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8753A1C2232D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92221145B32;
	Tue,  4 Jun 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljCsdDM/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85ED1459EB
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503395; cv=none; b=LK/UNZAXB4AtE6c/HWYEhUrS4sy0HHbfC0QaexV6rK3kEiiUhU51iEGb8zgFw3VvBzb68t8YUg4hPw242NwK3TdCikCf5AYdaALPqsE3bw8r1VezAfWOely8kjqJDVByIhShp/nNQn34GqeM5MmUT+7gy2xnqss1vbPxBjlW378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503395; c=relaxed/simple;
	bh=b8cLxRvYj1/phqQW8gDYECJAh2SrsZxNYxVUrn68cFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DI+5UliH2xg5MdYpomW6Lh6iUhsA1utWcpFkWmGdwOwZbYoJyeEeAHLzKAhLt0aOtV/i+vuXL+98P0Wn0Dp0yAljAvFHvCD+tKtmLofRRAw19KSyyWQti6zJJqevVY/bRQPxqfRPIzwPo3H5bM4ajQaF6gN1/2ldrYg/SuZ6RNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ljCsdDM/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso8880895a12.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717503392; x=1718108192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dywsdci0cGCcHwgLNG5qrYK2Y3eLUZPha79pAOiUCrE=;
        b=ljCsdDM/IteQsuepkIiUGO4T1GyDj/HBUvJr3KqIEKyZUYqIHUGZUcF9h61zlecJsk
         qtFnUb2wAGzp5wat0v8aDU3pr12OtvM6zj0AqYtw4Zg3Auv3usMcFOVbph/7BEJ/SNC/
         tE6Ju/HDrEWM6duc9lj5gb6uBvjbdgoGKJicfYbHEO/5C2qRGna5PyK1pEiZX72z2Zz/
         wapEVoTl08oHHmzjqHaREXn75GvaEmuy6vo0Tba9KvWAvL6HCr7tSAy4Hlal6g1IilPr
         lM8clktESXsN2RBPlAn2WyGHSlKXUtlVlz0a5zzjV7R8uAGhVJuxspWUjSx6ddHImMXc
         +ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717503392; x=1718108192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dywsdci0cGCcHwgLNG5qrYK2Y3eLUZPha79pAOiUCrE=;
        b=jFuaT+Sl1SUxO46nQNld2cVgeU6i/iCPafqaOqxkJKGxM99HylI/aTdZsI5qx0uZeP
         X1CFhhgGF3WRIsiJNEfjdu0O4NSnZCCO5dp9Dxn+arzDh2Lyk8uxOpiIYg5Z2QMUBq34
         yir/I02ATJ59J2dC6XicD4j/7i+p4YUhP3KLHJGLinNVXcnS69l6UPDOYtZeB+8uVXgH
         yUXMTGelGDJnGAOs0i3hetLCLrqK2h97U0MdIZtzru50coCpHViGe6yjHP6Edl5OvGOn
         QYhmHD+ezaAvEuzqBqgfdEZ7jf0ZPEzOsGyWbNRNjB6uJSiDkWhdH5zDxSNKpp2stY8t
         8n+A==
X-Forwarded-Encrypted: i=1; AJvYcCUamSdkPWQEd/I808meGYHKePPNfdOE4eO8JLRhgqruvP1noG7J3qBTPD0aCG+54PXayp5JsCy42zzCjF7LgFdnpUssORJX3Aw=
X-Gm-Message-State: AOJu0YyrtXFct7olu0ywTcCCq6zfMNFdn3Y0uhQ1EJW7e7t24wmUcYtF
	0Y+Pu7Ui5H9kBdQ2l7fxBsaWobPnDGUF7OAtMtReVmOcVFCV9XNavG4y+tQhwWfYEj89sso1E7e
	BFig=
X-Google-Smtp-Source: AGHT+IEFaJ0okDCNQsxvLPiGgKSQN856ez5eKhIPOn4MLW8EpFkv7n6Hde5n/wqnwaBga2SAvHqs4A==
X-Received: by 2002:a50:c04f:0:b0:574:ec3d:262a with SMTP id 4fb4d7f45d1cf-57a7a6bb20fmr2012274a12.5.1717503392064;
        Tue, 04 Jun 2024 05:16:32 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c9c0desm7358775a12.85.2024.06.04.05.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:16:31 -0700 (PDT)
Message-ID: <99967eee-da39-4a35-b80f-a78fe3c10733@linaro.org>
Date: Tue, 4 Jun 2024 14:16:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Skip retention level for Power
 Domains
To: Taniya Das <quic_tdas@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 quic_jkona@quicinc.com, quic_imrashai@quicinc.com
References: <20240531114148.8550-1-quic_tdas@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240531114148.8550-1-quic_tdas@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/31/24 13:41, Taniya Das wrote:
> In the cases where the power domain connected to logics is allowed to
> transition from a level(L)-->power collapse(0)-->retention(1) or
> vice versa retention(1)-->power collapse(0)-->level(L)  will cause the
> logic to lose the configurations. The ARC does not support retention
> to collapse transition on MxC rails.

This is not very legible. Are you saying that:

a) transitioning to/from LEVEL_RETENTION causes the resource to be powered
off internally for some short time and lose state

or

b) the linux implementation of rpmhpd handling causes that transition to
include a power collapse step that makes it lose the state

?

> 
> The targets from SM8450 onwards the PLL logics of clock controllers are
> connected to MxC rails and the recommended configurations are carried
> out during the clock controller probes. The MxC transition as mentioned
> above should be skipped to ensure the PLL settings are intact across
> clock controller power on & off.

So is this a workaround for clock controller drivers specifically, or should
MXC never enter retention, and only poweroff? (the latter sounds like it makes
more sense given MXC's purpose)

> 
> On older generation of targets which supports only Mx the logic is never
> collapsed and it is parked always at RETENTION, thus this issue is never
> observed on those targets.

"On older targets that do not split MX into MXA and MXC..."

Konrad

