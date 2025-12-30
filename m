Return-Path: <linux-pm+bounces-40040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFBFCE96C8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EBEE3031991
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B602E8DE5;
	Tue, 30 Dec 2025 10:34:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFCB2BE03B
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767090857; cv=none; b=QV0pWRpOUMWRsbU08u9/J/dKLps+exThdpCE2t0UUm63a3WXWizDbxdMRKHViTQsMh1LEbg53PPnLjd7tZndteo4lrp2V5GZaAb8EpfnsVAPIAUg/ycvYY1HpyWB46feGJCX1ZD28TuKhirsmDjqlnoLiGuxuLKWLJdpfSN4myA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767090857; c=relaxed/simple;
	bh=yN0KVfudTqjbDfHr9i4tNLq6M1rrpK08gDbM8j9k3PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2ASmGRy5pxC1cM1SIc5mJs+7D3K5FJJ/uocJK7nMl3RRiJcT3QvLn65eikIZFp/k+0VWGnc+Rvh0KForxGVV41jo5mdgAxL4LJqBvMm/9T2IWJgkSg8Nq3FRxWLUvQ62B7LQ2AKbi9+AuF6O3RYL1KP2y1WJqVCphRzt09oBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f63d46f34so3075282241.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 02:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767090854; x=1767695654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiqG0RuHQZMk6KJKRxI6Xkue4A0zmVgJcCqyVxR0fvw=;
        b=fYw7D2DiDxvVLdaf/YgbZ9A/Oz5tIPePJseGmxvGxwQX08/1cu4JGoYR+2DIrRwKEP
         8x13XFHnmMDQq0A5psblst4niE/KAWGfYkb6nBp/MvLO0EQbSj5G9aD/7RwmxHjmhqVy
         A+wEWLgxfT9biEMjT01zTbmWrTsP4F67fsGcJSZ+2Wud81kXyALCWvLLuuwAW66ugclI
         axfQRWSYPBZ0VR0CLMm49NXNOCC4mAnXMVrC5Z/MXpcRlp0uO1IUtMlMUGeqEH/EWPt1
         ukOEYKGVM40Yq/732PnTRn1vkItsgsacceLCNF+lMOxTfZbdiB0JhiDSNw55v2cEr2g7
         mUtA==
X-Gm-Message-State: AOJu0YzKbQYdPVoSYj/KKAHwN2F72vYDio0x2+UiO7ZcOatRu7kdlA78
	/YjkPu0hL0E5uDPFYHSqPY+956IjWI0RGGom6439zSS3XiW+HEEbACUemYcIUBpA
X-Gm-Gg: AY/fxX6Vw1O7nzzH5+gRQQtNVFyT8Ri5Z9BmpG8RfD5AL3A+xeE+LPjXxjWvm5IwSRI
	OGrsaJyBg/0bU2oyJDiKGcoVUStcFjIIvcO25PCuTBPcTQcB6fbGn3WcMwPbQGSAaLyAaP+DFpA
	7m9YrxsJaSCHZr+fTCDa8iZ2Z0Fx9Wysui40D5dzcZfmKHlkFOoCAmDnprbum+/Bhc4maTQ79q8
	MdUOcW4ynIHv9AfRpUPMIleqF55xTbFUce0EmmFsTQ5TP3gM4X2xJTqJH/ZO2ZoVtrspjyGK0j/
	OhHA4Kr5d8fUvChjjd11Ibov5BpVrNCau0qcH1hgoqrkk+MOA/8183QZRT+E5R4E+6Ir/VNexs7
	WXwfT19A+aqgPk1JincTbF623BrXRf97izLC738O2/w0MihwHQhI4to/IJhN/9FbNRDEhIvENk6
	4I9xoj0xzOAlLCMBvppcwNVuXCBozV074IlFGz1Mz1OfeMYU6+9Qw7
X-Google-Smtp-Source: AGHT+IEYUf6M2XvSl7QH7Q2A98iDFNeLd62bmOfdIHzmsuvN1bjmB7lzWtJFj3890PtCb8pzGL/nwQ==
X-Received: by 2002:a05:6102:3f51:b0:5df:b085:835a with SMTP id ada2fe7eead31-5eb1a810179mr10230801137.30.1767090854544;
        Tue, 30 Dec 2025 02:34:14 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-943562c3339sm7833365241.3.2025.12.30.02.34.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 02:34:13 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-55ab217bb5eso1082717e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 02:34:12 -0800 (PST)
X-Received: by 2002:a05:6122:1b8e:b0:55b:305b:4e37 with SMTP id
 71dfb90a1353d-5615bec271amr7076419e0c.18.1767090852559; Tue, 30 Dec 2025
 02:34:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <2556645.jE0xQCEvom@rafael.j.wysocki>
In-Reply-To: <2556645.jE0xQCEvom@rafael.j.wysocki>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Dec 2025 11:34:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVMFQebA43FJ53PBnd67C8fxWAC21cr4jWTGDwg-HV53w@mail.gmail.com>
X-Gm-Features: AQt7F2oNmmGurpUUAM5WEOMSDRy-1YxYjMjXZjhhxF2SDHcSD9gt9FTqJxI49VQ
Message-ID: <CAMuHMdVMFQebA43FJ53PBnd67C8fxWAC21cr4jWTGDwg-HV53w@mail.gmail.com>
Subject: Re: [PATCH v1 15/23] phy: core: Discard pm_runtime_put() return values
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-phy@lists.infradead.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Rafael,

On Mon, 22 Dec 2025 at 21:40, Rafael J. Wysocki <rafael@kernel.org> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The PHY core defines phy_pm_runtime_put() to return an int, but that
> return value is never used.  It also passes the return value of
> pm_runtime_put() to the caller which is not very useful.
>
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.
>
> Modify phy_pm_runtime_put() to discard the pm_runtime_put() return
> value and change its return type to void.  Also drop the redundant
> pm_runtime_enabled() call from there.
>
> No intentional functional impact.
>
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for your patch, which is now commit caad07ae07e3fb17 ("phy:
core: Discard pm_runtime_put() return values") in phy/next.

This is causing several messages like

    phy phy-e6590100.usb-phy-controller.2: Runtime PM usage count underflow!

during boot, and s2ram on Koelsch (R-Car M2-W).

Reverting this commit fixes the issue.

> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -190,15 +190,12 @@ int phy_pm_runtime_get_sync(struct phy *
>  }
>  EXPORT_SYMBOL_GPL(phy_pm_runtime_get_sync);
>
> -int phy_pm_runtime_put(struct phy *phy)
> +void phy_pm_runtime_put(struct phy *phy)
>  {
>         if (!phy)
> -               return 0;
> +               return;
>
> -       if (!pm_runtime_enabled(&phy->dev))
> -               return -ENOTSUPP;

Adding some instrumentation shows that this branch was taken before,
thus skipping the call to pm_runtime_put().

Can I just put the check back, or is there an underlying problem that
should be fixed instead?
Thanks!

> -
> -       return pm_runtime_put(&phy->dev);
> +       pm_runtime_put(&phy->dev);
>  }
>  EXPORT_SYMBOL_GPL(phy_pm_runtime_put);
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

