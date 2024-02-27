Return-Path: <linux-pm+bounces-4424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6396868889
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 06:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A91F25182
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 05:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABDA52F87;
	Tue, 27 Feb 2024 05:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HaIdc1OD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628AFF4EB
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010861; cv=none; b=dRpJh9hNjEeBfW5TnucX0lbB7Nnv1vu5iRAYoRNKOg5LG4CbpbMhbaRF5d/b+66BBBLre/EHVZJzG+kq2alLCswrY8VxPkcSZzQeCPmsNppvVQDPpl+5mBFVAwfWNU7vT1WCxLqHj+MPB3GyaKOH4f95rL+gpXv/AyMI9Z25X6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010861; c=relaxed/simple;
	bh=Wgvaos4tMDHQHCPQqba3sjMn7hXYBzfhsdVtj292alY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYL76/EGyuKMLCheY7VB3F9to5ADoaeVFkvHFevof/UYRtQDX1SMB+KblSHdh2qrnjlY+dVwgWjQl7UE/kW1h7HbjLlyUkI+F9/35W1g+LVDefHiZOiWpFHHokAPiHewr3Y/SUsxdUW93W/5+JtkhST/a5QDPEtd9NUf0Iug3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HaIdc1OD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513052d91daso355053e87.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 21:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709010857; x=1709615657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+BQPLCLZpqrKhiNrmiNzr4nlNlMBixVqIVv6pIcROQ=;
        b=HaIdc1ODNMxlOsrywwjh3RFkhQkvE3ZYafJeIPdrulpSwzeyUh9AsW00piKpLZwlAn
         URKPTxrOjN6tp3uNO/23dvbMa8rCNcPWCGKsLEUpR4u+hEhbOUACjMVMgfSSI2VdkKrp
         BeOJ58jSLmi9W5fgMeWm98PxiiN0y2MQmDwmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709010857; x=1709615657;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+BQPLCLZpqrKhiNrmiNzr4nlNlMBixVqIVv6pIcROQ=;
        b=YmBYMC6tA3TBhXXV/Ljytgg7fRzV8yGc14JlIC8E+KpoQlQD+nnp5huQ+Vh1i3B72l
         JbAO64UcT+takdG2ddiZB+Y0dfKoJF8Ysj2Ux6lA9CB5Brj+AXl5meLt8aMUVgZOenG4
         w6ZHJIcWNIBqHbhwzT1aqhJq5NYKd3h0VW+P0tnPJUBiK6Pco9Ox+P/IPuHLxw88gxQ/
         eoqnpwi3KudOflPx6hs3iDBQm3n/xustnpFF7F+jeZN9nuKQpAV+8iKay/v0FGepp6nk
         1hqPfihXoAKlUH5Xk1T/jmBgEyoW9XxC7w34fGavVw1IdEfrgXnVAn62cCZTWxBXBAwN
         ePnw==
X-Forwarded-Encrypted: i=1; AJvYcCXVKoGudfCa7/HgLpaS2W+fKEIqAJ5MCDrMFj7Tnwp/p721yo5kY7IQULxwAfNcUnn1wk5omVYnel52727/HoIK8ldcAinaFns=
X-Gm-Message-State: AOJu0Yy/l6l7rE0Df3QmI9uw1iuq854WC2HkQgW2q1IlpUklAXsw9HyP
	eppbgRArIgJtIwePi+zkiQVGs7suMREG1kTve+KuYjb87X5CHCxEvr6La2fVEig2i18Yt9T2Cwa
	zMpQrGRs3EbbO32QY67JsUKsbVzPRkJBi+VKH
X-Google-Smtp-Source: AGHT+IEyr7KXQAxsoRvnnHsDV6pqu0w4lJ40YXWqL0S1fUTZrVkMUjLcnZFHznlTZjulbsH6+afvAMnzVzmlCSDcWyk=
X-Received: by 2002:a05:6512:991:b0:512:ee1f:b5af with SMTP id
 w17-20020a056512099100b00512ee1fb5afmr4441994lft.41.1709010856400; Mon, 26
 Feb 2024 21:14:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Feb 2024 21:14:15 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
References: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 26 Feb 2024 21:14:15 -0800
Message-ID: <CAE-0n525gwp5kJGgw9Pnz+h2K6FbuqSG79KfMj_EnueZ-RYnuA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
To: Bjorn Andersson <andersson@kernel.org>, 
	Bjorn Andersson via B4 Relay <devnull+quic_bjorande.quicinc.com@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	quic_bjorande@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Bjorn Andersson via B4 Relay (2024-02-26 17:49:57)
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> Commit 'e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable
> the domain")' aimed to make sure that a power-domain that is being
> enabled without any particular performance-state requested will at least
> turn the rail on, to avoid filling DeviceTree with otherwise unnecessary
> required-opps properties.
>
> But in the event that aggregation happens on a disabled power-domain, with
> an enabled peer without performance-state, both the local and peer
> corner are 0. The peer's enabled_corner is not considered, with the
> result that the underlying (shared) resource is disabled.
>
> One case where this can be observed is when the display stack keeps mmcx
> enabled (but without a particular performance-state vote) in order to
> access registers and sync_state happens in the rpmhpd driver. As mmcx_ao
> is flushed the state of the peer (mmcx) is not considered and mmcx_ao
> ends up turning off "mmcx.lvl" underneath mmcx. This has been observed
> several times, but has been painted over in DeviceTree by adding an
> explicit vote for the lowest non-disabled performance-state.
>
> Fixes: e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the domain")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZdMwZa98L23mu3u6@hovoldconsulting.com/
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

