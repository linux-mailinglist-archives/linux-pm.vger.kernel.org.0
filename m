Return-Path: <linux-pm+bounces-16617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5469B39C8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367C0B22579
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EA81DFE3C;
	Mon, 28 Oct 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5ndG5x8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670A1DFE07
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 18:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141878; cv=none; b=rqtYdCmoRaxb6U9nB3QbXDe7hRs/EWqqqJywHtgxTTWlaFdLT5uv1t6W10+Iu/llkj6oDeZN4xYpXZAE+3/3abXYpDq1i/cmff5RLAC67mGKmbyhLehW8Py1/neebTxZt5ZwGTzsK9U1TJm04Bhd3E0yV3zz5PEdyjfEBsz0u/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141878; c=relaxed/simple;
	bh=ZqOIymdW7AOFGrkkZotyqe8mFhuss0YMD8c1cAdy6hM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kei2n36CJrbPW+sl4oUz8dlj4wHomaeK7HzGHXT5MMgtRgiV8qm3lGNtNTzNTTW2RQRL2Hxp+Bt7p56YbwyzmvSBzBkE3YtbMgnSxKME/riPbr++ks4m1F/Q/moAlMlFN1ndfdW/zLolV3jHuQB6UGLxU9NGgXGkQZEb0OcklCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I5ndG5x8; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebab72da05so2430296eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730141876; x=1730746676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2LfEYca0SVAQ5XFZmx5kmUvCRKMJSdnjq6kZ9JePCA=;
        b=I5ndG5x8bk8g9vlRPHBXSkKBj1M+LSvxp3YEpMcaC8MietUnPAMMrj5vUjWrpYXpVI
         N84oWd0GRM8sbYxRJ1u8hnLavW4E0iAJws4k/Es5EiIR8FYbxot7OD1UmNE6PSV0Uv0+
         T6wYH/alg+2mWvuv+fXcurNMPALq/rmUvJHOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141876; x=1730746676;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2LfEYca0SVAQ5XFZmx5kmUvCRKMJSdnjq6kZ9JePCA=;
        b=I25dg5djB9X9hO4kxsQADGgxrk9aSY++FjiW2Tp/UNsO8HuDhsFrFGXAuThCWVEYAD
         aoHyFinYNbJ7KzA8E833UgJuFkvCuKGomPBsQ6f8dCIfE4sKv1ElmLQ93XgDExiGQsVp
         yfSkBdTMMLUCKWUCVLpbIodrb51UeJrFyn93yvTeTXSpZSwN/aS1AdOU4nkOdRm4z05y
         9F+J/2lSCx4IG3tFQWoctCK8qbdpjIs+VKhcOLuU9/055AWzSNly9Kn0Do412t7K8ICY
         jrkIuxuCpxaBWtXxyzidkA/P2a6ULEJ3Wu8xRBfTVGkz9NTc/kNtxZZGfvTuaBjrzp8D
         XZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjeAhKVhVg9uHsSvAqGw28keo7yf08FZaHaWHC+gtarlpRh+q2+Udc6vW6SF+4DpVLz9x33zBpSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJGeiOStXdUgs4d07eRtL7i0XsZVM5nqcXHmCVmEeT2pfs551
	Qm2uz/jN/dfBz/aafZ5q1r2sC2hZBmUqLY2yglOjdTQU/L7F0VCQKLBj+I+CG7n5HxOWoyl7Bra
	JMD7Q349LB1nizL7+xTCfXoU1ny7xrIekx5w6
X-Google-Smtp-Source: AGHT+IFvmYBtQn6VF/6ueDr0Mul6XafO9LMXlXZyFfebnMWZxAt0RxG3GM+9mJwqrZJNTpm99hm2yO6Tjm648OHps4A=
X-Received: by 2002:a05:6358:41a1:b0:1c3:92d9:db9a with SMTP id
 e5c5f4694b2df-1c3f9dfc925mr362147255d.10.1730141875928; Mon, 28 Oct 2024
 11:57:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Oct 2024 14:57:55 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241028-arm-psci-system_reset2-vendor-reboots-v7-3-a4c40b0ebc54@quicinc.com>
References: <20241028-arm-psci-system_reset2-vendor-reboots-v7-0-a4c40b0ebc54@quicinc.com>
 <20241028-arm-psci-system_reset2-vendor-reboots-v7-3-a4c40b0ebc54@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 28 Oct 2024 14:57:55 -0400
Message-ID: <CAE-0n52buO+oJfesc+025hogm7BygMp4dO6b2_6aAoXVKRBs7w@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] firmware: psci: Read and use vendor reset types
To: Andy Yan <andy.yan@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Melody Olvera <quic_molvera@quicinc.com>, 
	Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Elliot Berman (2024-10-28 11:44:57)
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 2328ca58bba6..2d7b6efc8743 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -79,6 +79,14 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
>  static u32 psci_cpu_suspend_feature;
>  static bool psci_system_reset2_supported;
>
> +struct psci_reset_param {
> +       const char *mode;
> +       u32 reset_type;
> +       u32 cookie;
> +};
> +static struct psci_reset_param *psci_reset_params;
> +static size_t num_psci_reset_params;

These two can be __ro_after_init

> +
>  static inline bool psci_has_ext_power_state(void)
>  {
>         return psci_cpu_suspend_feature &
> @@ -305,9 +313,38 @@ static int get_set_conduit_method(const struct device_node *np)
>         return 0;
>  }
>
> +static void psci_vendor_system_reset2(unsigned long action, void *data)

Can 'data' simply be 'const char *cmd' instead?

And can 'action' be dropped? It isn't used in this function.

> +{
> +       const char *cmd = data;
> +       unsigned long ret;
> +       size_t i;
> +
> +       for (i = 0; i < num_psci_reset_params; i++) {
> +               if (!strcmp(psci_reset_params[i].mode, cmd)) {
> +                       ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> +                                            psci_reset_params[i].reset_type,
> +                                            psci_reset_params[i].cookie, 0);
> +                       /*
> +                        * if vendor reset fails, log it and fall back to
> +                        * architecture reset types
> +                        */
> +                       pr_err("failed to perform reset \"%s\": %ld\n", cmd,
> +                              (long)ret);

			return?

because we're not going to try another one, right?

