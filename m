Return-Path: <linux-pm+bounces-26578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B188AA75D7
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3041890794
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B02566C4;
	Fri,  2 May 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fubQaLOX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65506241696
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199048; cv=none; b=Cpa8yLEBa9TxvtpPuW0R6JozhPwZIw1q4d4ahQDUs3UvvJhGgb+1hn8KK2n/iVxdKBYtHMGjfGaTcDNjQgvw9nYvRsgtvpOlQzxukkoG3K1j48HpvCkFaZxEoWi2VqiQdLq7cC0hCgUXwsxLuiqCtIObB6P7/lJlht9I8zv/a7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199048; c=relaxed/simple;
	bh=/145zL9NzlBwWKgzCeNS6sMYAsiMiw3WskgH2Vnl1gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3y8nW1csndjpKizCJaga41TqHtFTFmIaLay+mnYl3z/hTqd+G7XeZof5mLc1RKJVMwz0168C5BMgPctDcTBuVywe5SIV4/Wae8FjwTLKFHClD/J09vhRJhhpOFneio6isHRygH//cLTfe0jDMvF0/wh0cgoRY+K4m5vrIoqt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fubQaLOX; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e730ea57804so2953207276.1
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746199045; x=1746803845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VXQoocgfizkpU9Nm1Zjh50U6LWogcq7si/7CJqUeXKk=;
        b=fubQaLOXAWjdGdUyBizllo8OoMy98amI7AzJlxkD5rfyQ6ZVxYEDIXr9C4ZvRxFFEB
         744Z6ia0p+scwhgUnr7v834Qac/KY6M0cU5RC6tujD2bmgvlXBFh9dxj+p+ABVCubOvG
         yDmQ7BtHs73+Jt4obsX3AQfkW1l/ea5JHbm9z7yLF9kIm9jthoq3Q4634Z+BPVNjIil4
         IoSX1g3qB8v2vJ3o2pswK96W3RxpZWiCG2mx/Yw8FlLkpTJ+nPEh2swJHKWf5ciCPx98
         k8xVSZ6+kJuiT816nRyeAjhX5a/UizCnXT2iOuKKbkQXv6lJBP0VoRmHraCEnbsHtnIB
         6Zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199045; x=1746803845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXQoocgfizkpU9Nm1Zjh50U6LWogcq7si/7CJqUeXKk=;
        b=BEQVph0m2M4NtJknkfUfps3oqWkc+0ZeROy7kiv9N+SiO71TbA2/RyN9YKqHEo6H7R
         b0Rt8zozDzAIBGO0WDRlWtyBuSu6PRCSqQC/nkJYyEcyZ1MESv/T+9/0xYxgbAp8ZJ0N
         bVJGZSZZKKyURJx8Y5sDcpGT9w0GqVLYPKHLZ4E4cQs4Ax5l+hhNljn7LKVyIu9EGboW
         NGyvAwUU0KpKMLz5qIH0vyEsNE2o5x5c6/asDPS27eUNCL/elVicLmtYfqMpG+xiZqKM
         p7FkBU+/gbrJw9LPIBRHQnJMs3Q6H/5OAg1JlUalOrvvgDV7BTnfyAaz4qD3CZklQrMF
         zoTQ==
X-Gm-Message-State: AOJu0YwIKYBObiwWILjXyfif3V3UZrhqQEQNEOO/KtPfSHy8DZiZs8Y0
	FfFTHiTx3nVV72sc4jG2P/XUl7hHfulOZ76rWuck296ZOtTzRmtBXmy6yF8KqUdrjTBzwzDmzN5
	qyyXH1+beHv3QMPrl4Tphr1eXlkN9NrqIGQss6g==
X-Gm-Gg: ASbGnctBZqvbZnBcpIZD5JryjTRecExDdeafp6+uV37ZegLkiIC7JwERCyWBKvnZC1q
	rN9LCCqzTibjQKJfqUGrafxdtwFO8puZkUe7ilOcdJBUr07jt2JSJ/9GJmli1PcWmDCVCToMdX+
	HSmS05ihVqJclyJnNv4GxF7+E=
X-Google-Smtp-Source: AGHT+IGOJ8Eir9GxuesZHcEuIu1ZjHJGGsWPS/EU0OhDLRhyf0gUO15gbaMUnY4Y3NvLRwmdo2aOggOJtMXJXT6u/NE=
X-Received: by 2002:a05:6902:274a:b0:e73:1749:ed9c with SMTP id
 3f1490d57ef6-e7564d4eae9mr5266817276.24.1746199045400; Fri, 02 May 2025
 08:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502140119.2578909-1-sudeep.holla@arm.com>
In-Reply-To: <20250502140119.2578909-1-sudeep.holla@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 2 May 2025 17:16:48 +0200
X-Gm-Features: ATxdqUGHsKjN1SkITjGe8n04FhBneRxtxXjAJhE7PE4nZsGHUusZ-4S_tfwcPqw
Message-ID: <CAPDyKFobCehWO2jo2H2wMx40NLggoFOnhWKCuqcMURTLgiK1ug@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Avoid initializing faux device if no DT
 idle states are present
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 16:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Commit af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
> transitioned the PSCI cpuidle driver from using a platform device to the
> faux device framework. However, unlike platform devices, the faux device
> infrastructure logs an error when the probe function fails, even if the
> failure is intentional or expected.
>
> To prevent unnecessary error logs, we can skip creating the faux device
> entirely if there are no PSCI idle states defined in the device tree.
> Introduce a check for DT idle states during initialization and avoid
> setting up the device if none are found.
>
> This ensures cleaner logs and avoids misleading probe failure messages
> when PSCI idle support is intentionally not described in DT.
>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Fixes: af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/r/cf4e70e4-9fe5-4697-8744-8c12c41b5ff9@nvidia.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Rafael, please pick this one.

BTW, I was not cced the original offending commit and it was funneld
via Rafael's tree. No worries this time, but probably easier to stick
with my pmdomain tree future wise, to avoid any churns. This is also
reflected in MAINTAINERS.

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle-psci.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index ee35ac816321..40f378c1dc9f 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -438,10 +438,29 @@ static struct faux_device_ops psci_cpuidle_ops = {
>         .probe = psci_cpuidle_probe,
>  };
>
> +static bool __init dt_idle_state_present(void)
> +{
> +       struct device_node *cpu_node __free(device_node);
> +       struct device_node *state_node __free(device_node);
> +
> +       cpu_node = of_cpu_device_node_get(cpumask_first(cpu_possible_mask));
> +       if (!cpu_node)
> +               return false;
> +
> +       state_node = of_get_cpu_state_node(cpu_node, 0);
> +       if (!state_node)
> +               return false;
> +
> +       return !!of_match_node(psci_idle_state_match, state_node);
> +}
> +
>  static int __init psci_idle_init(void)
>  {
>         struct faux_device *fdev;
>
> +       if (!dt_idle_state_present())
> +               return 0;
> +
>         fdev = faux_device_create("psci-cpuidle", NULL, &psci_cpuidle_ops);
>         if (!fdev) {
>                 pr_err("Failed to create psci-cpuidle device\n");
> --
> 2.34.1
>

