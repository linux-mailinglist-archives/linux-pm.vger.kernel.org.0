Return-Path: <linux-pm+bounces-39704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 126C5CCFF1D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 14:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DAFE3032605
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A58324B35;
	Fri, 19 Dec 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Nxw1pCJe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DCF31E11C
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149267; cv=none; b=YtLOWz4wpWeE4TNWQv7fbIkiKE0USejUxFfsv7hG1WDbxCnRWJvIToX0g5U8B8RNTADOrW982m/yxBoYc8GRPJ4SkxznjfvwVKd11IZ5xY8bC5PFuNKN+a7xyjtMIi62Tiv1EikIHlpKEbr/G53KLhRCKySAaaSWVSFSkQs6qUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149267; c=relaxed/simple;
	bh=OMj7xeqwJMwjOl9SBTbfE9Y8LYVng9ddlrSM4o/HdWk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=O9S33m/wu6T6YJ4cjvSyQi9pWunN2hfk5wCPJOibfYuTFfUcJkXe2vcy1gWxx/jPHsZjomUa42xT+zYqXmx1aSNjcOc5H5zfzr0CDhjqdwVd0JL11lqIFmJ8w4lKta6wKh0IQxl3EVpys16AoRHYUOoCWwnxnUwzc39LXtWPpT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Nxw1pCJe; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b7ffa421f1bso497595366b.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 05:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1766149258; x=1766754058; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QH9a092t0vWzb6LlKTi2ntIznrIkgJiQ0lVDXHwlCgM=;
        b=Nxw1pCJeW6oYa0o7jXMT8/6bl0Qhufe/V6WkUqMzXlQARU542McV65Oi/jPSqlsZn/
         1GLdq0p/m3WxvDD27Z0cwi61SyEJ8ka7YygzMCSArhE+byrxS8Hr8HnQc+mFNmbWRhh/
         ZewHkSu1CVwenStJijMPshEsPoHM5V38SiDf9YLrQ4DMYZGTURGhWO5HZibBeZLdl2Tf
         H7WM76XqfwudX4lwdNHmTLSmc98SAmLrhTuJZUtEPCx04ER10yFEww5SUJ1pz8sbXLMC
         nMhYEuF9q32CvQYex+TBIFv+YYIcSczWUJet0EPT/rwbpBo1SnPYWfpEOISQpAJPq9RM
         iLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766149258; x=1766754058;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QH9a092t0vWzb6LlKTi2ntIznrIkgJiQ0lVDXHwlCgM=;
        b=CtNqe/g/sjQoINX+kw88SwBvgjqnZjDUoZWqgS/NJHGjO6HkiL8FhODQmEinaRhFpe
         0eNxeqY+wj2RR/w3WxpDjwjNirgHD24qPMLrjvM7oAJCh4mYMx9pztDT9aOgDVwb4y7A
         Hham3ehBVcxcaJhjQNId918Wy192lbugy2ODvbkTllzijw5FzTjFeCkhT0yPT8jIGxyV
         5jAwoZhNlNhvcMJ3eqzXr4DLONuAOkm5Skw82O8QI80Fk5vd1yGO41qbgHshtG8Recvq
         n+prwAEaTAqA4aTLnkvQ6H9bvR6hZ62NNgvDq/xZ/nsUfT/uj8rS2Zh5td4ry2CsoSpo
         VmMA==
X-Forwarded-Encrypted: i=1; AJvYcCUQYqz6VP6labXwD0rHWH11AFNxeWY0quPDnAQUCQ92gnVGD9boTyg22GYzji/4lTxuVm8ABtgW5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZERb14+U+ovM779C1WgWOfbrfyaqAGToT4z0O1NkDlWtglzh/
	xxPPxtpXjVPeiKJMFfg5tEmfZx2rAjZ6ryxlvIPlfnry/Gj54AeBCB2RjSDU4KwQrPM=
X-Gm-Gg: AY/fxX4IDCRUBmHR8vi5XxFuGdERoljv3vA4+E7IAYUdBVNU7J1iYC7gcObB/PNefPM
	VenMz/2KraK8rj1nnZA8vW5VbpoSnp/pjwcakpnyiYuglL7TqTzJX3fgP5b11M1eB3QsLHBJZlY
	MH/SrO41GcoY7uC9VyI01C+0VES2Qw2hz70KHseI71HYLcoMdgDx8PIqCpEn0cX9f9F4qoCGSRy
	YmJH89gW+fqQUaXWviMTVDhEEXruJ0oDIiN9/qwMkpJLJncG1qbs3CF5X/UvqJVxkxYnZHe7cNS
	/1TW69BK77hoLCxyH4+C0+CZkNXah2C2zW7YhUw2u5S7usG2GjHEePrgB5j1WNneiSRQUT6R8OX
	xErr9xHWN7EZGJRqa+rsEUj1WURTcybPVW5dIaDT8sXAm1OsVLFoLpFX1OUlGIeWoBu7TKslIRM
	MWZQMJVdbKLPkjJ0OqIuFZ83OAxniqPwEWrC6J5czFq95vcfA7+CnHMtRWQg5Ww+nqh4e455gxo
	wXEYPl+ijvJcyfmO9OGW+bR
X-Google-Smtp-Source: AGHT+IHLGt3dLozOmdXSlTcHVXCnuuxt1U6E7k8MjKzoQF2b3nEBMoU2ft3Yv3cwbA/6YNKG+iAu0A==
X-Received: by 2002:a17:907:fdc1:b0:b7d:266a:772c with SMTP id a640c23a62f3a-b803574c34fmr311215066b.21.1766149258484;
        Fri, 19 Dec 2025 05:00:58 -0800 (PST)
Received: from localhost (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm223530866b.39.2025.12.19.05.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 05:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Dec 2025 14:00:57 +0100
Message-Id: <DF27NRY60F8J.19D014VO387TN@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v4 3/9] dt-bindings: qcom,pdc: document the Milos Power
 Domain Controller
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Manivannan Sadhasivam"
 <mani@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, "Vinod Koul" <vkoul@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
 <20251210-sm7635-fp6-initial-v4-3-b05fddd8b45c@fairphone.com>
In-Reply-To: <20251210-sm7635-fp6-initial-v4-3-b05fddd8b45c@fairphone.com>

Hi Rob,

On Wed Dec 10, 2025 at 2:43 AM CET, Luca Weiss wrote:
> Document the Power Domain Controller on the Milos SoC.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Looking at other commits in qcom,pdc.yaml, you're the person who usually
picks up these patches.

Could you please pick this patch up, it has been on the lists since
months, blocking the arm64 dts from going in.

Regards
Luca

> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1=
 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,=
pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.=
yaml
> index 38d0c2d57dd6..0c80bf79c162 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yam=
l
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yam=
l
> @@ -27,6 +27,7 @@ properties:
>      items:
>        - enum:
>            - qcom,glymur-pdc
> +          - qcom,milos-pdc
>            - qcom,qcs615-pdc
>            - qcom,qcs8300-pdc
>            - qcom,qdu1000-pdc


