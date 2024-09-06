Return-Path: <linux-pm+bounces-13765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8312796EEBD
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E531F2578C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADA01C242B;
	Fri,  6 Sep 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paxnb1a2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320F1C2328
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613311; cv=none; b=jPrqJrmlU3wQAsf/YZGztsd9ZkE5SujJgutx/S+4I6CbOt5VUexgUGyZ591uj7hrFU3kq3cjlwF6jNvfogMPgKLKQAUkHNjdC30/L904PNREMVMZBIGjqh8rINjOd1xczuZmNV6V/YkOJEeHsmwzOJ1p0CkUY7+fRPl45CVel6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613311; c=relaxed/simple;
	bh=AK1DjOpyBmg6MrZsgyycLtZEyblkfcxZ3xEStXmD5Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C74r93MEPpLzWRDBtC02MQgJ9Z3Y7w51Ky1Bjf4IZfcKDexweyhR2AzxRIgEbw4Q+qoVPm/G6bZS0Fq0RkDLEkeZ91DjRg+wjCL2MmTLWlhN5GoudMs5xIWiPuwzxKVJ5Dc8aRRA3zcWFxq0n8V3AY9g2KFT5UJo8+LYDM0iHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=paxnb1a2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso1931775276.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725613309; x=1726218109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naafd9NQdL7c0TVHJHZyeDroIpmJmtpt2mzXoi2uMhw=;
        b=paxnb1a2Ha1yT4jQNLC3ma595OoNDdyFiUjMbsBFa7qcq4INetdoEfMSXOt/kjiuBu
         HpKdXhjN7f7nfeW5pSEOThfAxqpn6IQKelaAicKCQYKiMje+O7ecdBLnkHu5YKfJi2U4
         wuFVLeppYMB+wkrQUpVOqC3oCuOaYh9Z/Ut+FFNPiHZ3ugyQC2aTCSL7kOl/NRTAAyul
         I34J/3Q/TK+594y7zJWXNJJDBBFo3hkwIMSSuMVOihJdTHhqQMtZLHtGVu9uvt2BaSW0
         BENZWBZXV9+AGmidDpEe3HB2Y2d6HJC2VTAYvCXDHcIzhdnGB4vbB6ZS0vXWALM6C7uy
         d/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613309; x=1726218109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naafd9NQdL7c0TVHJHZyeDroIpmJmtpt2mzXoi2uMhw=;
        b=RbKoab99lJViNhc0TjlEcPr+F2tnpxi5XScAUXWK71idBtTDGaioEOJcT+s2++D85n
         PVg+f+zZ4gN6btKnAJxnMuvm2SWtyBCa/xY7Suk5NNEILtBhEEFJ6JOKVozhHXQa05Rm
         HahcmdVTuN+YcUjjzSylrcoq8RP7cZcmnbGMfDH2pddl3VDSooZ17AtjgoCFn4E+8sNS
         v8ntN7oIu4ek1Z6pCJF7usTKadZ24WbkdMTk+dJwkHnalCM+mmvCprC5xvvdlWJSW/Hk
         wLwNXinCoeccoYRRuCbFoqy/eslR0wgg3FfvY0HbdY5pKhq36eD2O8CFr7r1ElrS9EyL
         ZVtw==
X-Gm-Message-State: AOJu0Yx5Nmz7DAzR+197Hp1Mfnj3oXH7cIts85yvIFXTKbqy/rTpH2SI
	N3lj+r2LsPkSysc8Rvs9Ps4rdEqdNWcJvxAaxGsJlrbVZEHrkwMSBlQ4CwnCXLvlFnoqqkv0GB7
	wu+0647IkVag9AS1jePtzAAPhFG47ikmGegkcBQ==
X-Google-Smtp-Source: AGHT+IFGQXdRZWy9RIvR/NJ/1402FeLabmNEa/IgMAE8xXJL7U/I48UXtAHrMD5jwlbUTFr/jlclZyUQEZZyPK0rr4M=
X-Received: by 2002:a05:6902:2e11:b0:e0b:db06:18cc with SMTP id
 3f1490d57ef6-e1d34875b85mr2345005276.12.1725613308963; Fri, 06 Sep 2024
 02:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
 <20240905-lpm-v6-10-constraints-pmdomain-v3-2-e359cbb39654@baylibre.com>
In-Reply-To: <20240905-lpm-v6-10-constraints-pmdomain-v3-2-e359cbb39654@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Sep 2024 11:01:13 +0200
Message-ID: <CAPDyKFq=z8QQ3BLHd=sdJUcP+ZuekUzaBEt5PLARgJWD=PBMpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pmdomain: ti_sci: add wakeup constraint management
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 00:03, Kevin Hilman <khilman@baylibre.com> wrote:
>
> During system-wide suspend, check all devices connected to PM domain
> to see if they are wakeup-enabled.  If so, set a TI SCI device
> constraint.
>
> Note: DM firmware clears all constraints on resume.
>
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index bb95c40ab3ea..1ab1e46924ab 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -74,6 +74,21 @@ static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
>                         pd->idx, val);
>  }
>
> +static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +       struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +       const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +       int ret;
> +
> +       if (device_may_wakeup(dev)) {
> +               ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
> +                                                              TISCI_MSG_CONSTRAINT_SET);
> +               if (!ret)
> +                       dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
> +       }
> +}
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -115,6 +130,8 @@ static int ti_sci_pd_suspend(struct device *dev)
>         if (ti_sci_pd_is_valid_constraint(val))
>                 ti_sci_pd_set_lat_constraint(dev, val);
>
> +       ti_sci_pd_set_wkup_constraint(dev);
> +
>         return 0;
>  }
>
>
> --
> 2.46.0
>

