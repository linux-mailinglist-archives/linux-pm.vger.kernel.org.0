Return-Path: <linux-pm+bounces-39534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4436ACBC8D9
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 06:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F4583011FA1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 05:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3178324B1D;
	Mon, 15 Dec 2025 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwfl1z6v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31813C3F2
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765775897; cv=none; b=lH26mPqQu+/83Xa/VjJVkvLQkPhteoKFLaule6tcDKzmsVDVpitZa+KUSMneC811Y7+bnlPJk+VLG8XC/oQe0KCUAaCXNn+XqLmRU/MtjkspB59coMqZoTCgPD1dVbZD3/dYISJzEFgvww/bMNJ/52DpL/jyY8gnjcquTpOTetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765775897; c=relaxed/simple;
	bh=EyhhTu6tEajuduNp4/0le6GxWfnSGbcGf0p5nThcZrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9MKxUCavxJmS3S9fS74shs/J2wSIBvUGnijBCWO7ThoUf6uoFlUcBbtS3dU/NaKD/NbVnb7xJ6CVaMbfPXtCtRmoKfWHnGzVorrJdJZfivo72zP9xRZmmi90USwiEuikPLK6KPjh7tqjgP0UUPm6I/mtmeMbIsm+ZsM37ho6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cwfl1z6v; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0b4320665so14455235ad.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Dec 2025 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765775894; x=1766380694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYGV5sGRh2yeK6uvxRn1wHQ6jEWyDVrINv6+U1Id/8A=;
        b=cwfl1z6vO+qUVJ/kEpR+Lr4aURVQNuPWddaQ+x3kC1SqBY8LBgPG4p2wcQC2IYlFgK
         lBqoCFwgRGdrOhhnviFX2J6A3YDDQAfEXr5b6bAekBTp5VzNle6WThA9PCFpEDFPrg0T
         NptK1k4/5IOPxUqF9SgOojtd2CUSc7NbqsJ5Fo/VL0A5pe6u9uaC7OpDoULsTvscXQsw
         7mIRuAGaY7aKV2luDl/9CCLUc57JZL96fvQaivg68pUM2Rpa7cI2MqdfDpwJybGtrLhf
         mG5XNJ7gspEA9ayj33xQre90gP4uppO+8L0JjzhMzcXt0Lelj5SF1drE06fzzq5BQ4oH
         g/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765775894; x=1766380694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYGV5sGRh2yeK6uvxRn1wHQ6jEWyDVrINv6+U1Id/8A=;
        b=b+MSG8KaGTfg7XKkZPz3jhafNNvQx9Sn+tiAV2+W15wNAN+hz4DsISu3p1OwrdKn+/
         6kWeQICloOf9esCe5baKv6EHzoLp9oOkOMY1sZKy0suzImx047rkTgOidTr0YNEyswju
         73RLzHVRKTwhAhPrrRxW9EsaggpW9rDiLRSDfAM57jPh6ozxIU7Onv7v3lqzkUEB5RmD
         UTfGRsSY4KPR5RP9CTKwnlIBjrwLrVKMFHesMgVXlbbsqIRKgi4FdXcoBsOB94vRoXOZ
         dalDs48whWbjGE+0pcYfAPyLFYlhswF3PJ5rKR6I54QNZpFe6OZ4a7EqYfT1HZiTTBPs
         jIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTazAmdhxLooLVZ9/Ou2BjNTWmsA3473cMYdr1z6TjIcHEWhU//8/7Wzh7Mxd/jswhzCRsSjYXfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8W69rNnzGx6ZtEcF+XeF0oGlU8LvCjf6Jrfol9aUeS0AiFtHR
	N3SO42LgaUciVPW2mGL/gR2q/M6ldCe/UrLrvL5P98cAp6IBKH4d1mJ70hdP36t/AFk=
X-Gm-Gg: AY/fxX5GmdxQWQPybO16WFH3nP4yVCEQohLdhvCoHP+knDlxM0toYHlFZHuAnQIcMen
	0dEehVLBexBVbXG9pan8QhLBatD8lFjpcNXRN+1RVTeeqAHSYXI5xVqvA2XmZuX/ybuu4yvM0vZ
	uCFdEcrSdEgtcdWOOTj5MSmd/WByrveRI3UNAov95isnzlh0NMgcZo5q133jsWltIJp0A5Lvycr
	f7sle5oaSD6GFfywTyKpewl3mXRjEQOqD/ENcisPmVVGPCdSpLzdgtTHTcke8fC+E+byQpZ68RV
	3YhjYU2s4makOVw3rU6PoSuzu4v/m8/6bNl8U6nfbEQKrkF4sO5TUEmodnERbB5SF9YGMifoi59
	CZfBBSjTsCw1MisxNz9qFga7bDlAJO+LWKMD+7rxk40RxQmiZ1kX1X8XJuZYoBwvsrWE+RjQ/SR
	rmmg8srY+cpMU=
X-Google-Smtp-Source: AGHT+IH71LGyS6r6X/23fUIRTMHB9hMJFZwpz7dGoHIihSQCvhU76eKfPDxzle5KT+xNtC/kg/DPCg==
X-Received: by 2002:a17:903:1b66:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-29f23caa438mr105521885ad.42.1765775894222;
        Sun, 14 Dec 2025 21:18:14 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016ef4sm122285845ad.56.2025.12.14.21.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 21:18:13 -0800 (PST)
Date: Mon, 15 Dec 2025 10:48:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: cpufreq: qcom-hw: document Milos
 CPUFREQ Hardware
Message-ID: <qogyami7g3wdvfodttrjqzvmrufw4qaqvzp3jsq6lt6wqshu5y@kofhldddiznw>
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
 <20251210-sm7635-fp6-initial-v4-1-b05fddd8b45c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-sm7635-fp6-initial-v4-1-b05fddd8b45c@fairphone.com>

On 10-12-25, 10:43, Luca Weiss wrote:
> Document the CPUFREQ Hardware on the Milos SoC.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 2d42fc3d8ef8..22eeaef14f55 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -35,6 +35,7 @@ properties:
>        - description: v2 of CPUFREQ HW (EPSS)
>          items:
>            - enum:
> +              - qcom,milos-cpufreq-epss
>                - qcom,qcs8300-cpufreq-epss
>                - qcom,qdu1000-cpufreq-epss
>                - qcom,sa8255p-cpufreq-epss
> @@ -169,6 +170,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,milos-cpufreq-epss
>                - qcom,qcs8300-cpufreq-epss
>                - qcom,sc7280-cpufreq-epss
>                - qcom,sm8250-cpufreq-epss

Applied. Thanks.

-- 
viresh

