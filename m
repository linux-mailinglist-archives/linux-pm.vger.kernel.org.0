Return-Path: <linux-pm+bounces-21527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1AA2C03F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 11:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335AA16ACBA
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 10:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C26E1DE4E3;
	Fri,  7 Feb 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UgdOYb+f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A511DDC20
	for <linux-pm@vger.kernel.org>; Fri,  7 Feb 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923000; cv=none; b=QYR7omoZoh3ElB1qBqiBzqnBsywZ3SfDrWNqZD4dTX4/BSJI90VJkyzOWHjXs8MieHEPP/eodvnu5ydyV2Gkxd7HvMLiqUAtFIotuaWdytjn40RC+D/Bl3/mSZgZJ5N54jEfZ5Qfx96lB8yguCJyW55TKcu9s/LKzT9cMfSwOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923000; c=relaxed/simple;
	bh=fozwRqctrOxLpSdO3MevSvRd0gXJ8hjbI9tSkvTXnUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qarZSZdWtOl+8lMprvbJO6Tq/Shd9fKk5SuO7Nw0tuZxuwTpfpF1FOMK0CSDFkY5ywnYHCGVefzG0mOon8xkI4pyv87E8FNODYXkd8X4kRoAPP3PS+K0WCcyoSOaexVKUtQEZwY1gBI50ORBz4graomDT3YV91iOIde9U/Xeofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UgdOYb+f; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e5b16621c28so1499179276.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2025 02:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738922997; x=1739527797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aMlnBxSr88oKxJqvSdzTpvP2j51w5II8vu4/hm//nuA=;
        b=UgdOYb+fenojnKOhxNJTz2QVnJ1FnCk5Q/GCA8INtVsJi4YQZ3IlwR7Wd3x/ROOdaV
         RPy6SQ8pvMyQSD6/CiK20h4jWfOlfsGwD8/CODs6ZsXjnSZkl3TnGLu68IhLqIlmNSSX
         /q82AfXS1GTT7uYbwLQVY3lZjn34LHxYny1R4c6LsQD60+FQxOB1TQ+Wuyq6iuz8lxF6
         q9ga2WPBiIlf6Kohstxb5CeOCXeX2RfCIWGBVQwrcuGMqZ/uLlU/SpvSQpbYByCzyumQ
         Nfl3RD0FkJDrwi9kRTNFMIDI1CLDg85foG8Dr5YTQBBTD3YNMHbR2TvdAgxjDfKhg7pK
         8FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738922997; x=1739527797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMlnBxSr88oKxJqvSdzTpvP2j51w5II8vu4/hm//nuA=;
        b=GSOvq84KwiBdJu9YmLzb/J/MjU9ivhCW3OZN3nFLqmzG1rN12hH/44b/GJbQla5Nd8
         PxjcuIP0Xic64fchF0Dq6k8u7IO5eMqUK8sbtArcdXmIMQfnuRNAAW9lcMgafmahRMQa
         tRngbrlDPRg6o6i+0YH8IQ3kZn4Ma1M23j/sPw2l7OmBHQnPLP4xUWgAFjyDFXjxZMgi
         EGcSlFomuYcVU6Pz9yVw8WohXAnbLem+ohURTXRlsv3/a+GuYglGtR5lxN+NkSss82YR
         QJdcWw3mSx3FufdmqriVU07EJKHiIQKQ9CCSZtIZWbQpWJXuzLc1BaEpvk6YdC5JEt65
         Nylg==
X-Forwarded-Encrypted: i=1; AJvYcCWzmkpKo0jBrgSqAxiNsHZUqsZGmHkI5j84M0x0k+GpdjSnXzNwsI4R7l6AY9bGJem9IswwVimK6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2A3LQU2VzgJRUGs5A0W/pukAzv7WoxsJOcPSf8y/UY12ba/9
	gu7leWOs2SFQEjndCDFuzxxd0lfT+R929BgIwZFP/rg27chBSeuCwnaHx/6kqmmhRYzrHLhh0NM
	wbQYq9DLWZJTUJxeXw8Jde3LVzDmIkpHKbpquGQ==
X-Gm-Gg: ASbGncv73PiN6Yo3rtoViHwcBjv4BFLkU/tvOtMCVMtG0+bTIaZZZ0QoFOZl0GvZvYG
	Nows1lJ8sHiEBG+rzftgWGrxEH5Fs1LRO8DjcPsjNuQi5YsxzX9laslF3gYRnUlbrvlcJ/ay8mQ
	==
X-Google-Smtp-Source: AGHT+IHoiInh1hUMnE6qERiHNS3cS8CKAY9eNIzyp9FkL/HZJzjp42lBKNL5doKpGdV1ysL98ISo0TrNPBDVJXuqONw=
X-Received: by 2002:a05:6902:1147:b0:e5b:44a6:6a49 with SMTP id
 3f1490d57ef6-e5b461e3b73mr2069997276.27.1738922996853; Fri, 07 Feb 2025
 02:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com> <1738736156-119203-7-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1738736156-119203-7-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 7 Feb 2025 11:09:20 +0100
X-Gm-Features: AWEUYZlh5I7dXTfcGIsd-Bb5BhscOMYbYEdqLf2ekINZFP8SE-lE7AuxpmHbrEo
Message-ID: <CAPDyKFpzfyacXidTwU1ec9L4058k3Mrx43MS0JTnukgwqci6BA@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] scsi: ufs: rockchip: initial support for UFS
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Feb 2025 at 07:18, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> RK3576 SoC contains a UFS controller, add initial support for it.
> The features are:
> (1) support UFS 2.0 features
> (2) High speed up to HS-G3
> (3) 2RX-2TX lanes
> (4) auto H8 entry and exit
>
> Software limitation:
> (1) HCE procedure: enable controller->enable intr->dme_reset->dme_enable
> (2) disable unipro timeout values before power mode change
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

One minor comment, see below. Nevertheless, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

> +#ifdef CONFIG_PM_SLEEP
> +static int ufs_rockchip_system_suspend(struct device *dev)
> +{
> +       struct ufs_hba *hba = dev_get_drvdata(dev);
> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +       int err;
> +

The below code seems to require that the device is runtime resumed.
Maybe that is guaranteed by the upper UFS layer, I don't know. If not,
we need a pm_runtime_get_sync() here - and thus a corresponding
pm_runtime_put_noidle() in ufs_rockchip_system_resume().

> +       /*
> +        * If spm_lvl is less than level 5, it means we need to keep the host
> +        * controller in powered-on state. So device_set_awake_path() is
> +        * calling pm core to notify the genpd provider to meet this requirement
> +        */
> +       if (hba->spm_lvl < UFS_PM_LVL_5)
> +               device_set_awake_path(dev);
> +
> +       err = ufshcd_system_suspend(dev);
> +       if (err) {
> +               dev_err(hba->dev, "UFSHCD system susped failed %d\n", err);
> +               return err;
> +       }
> +
> +       clk_disable_unprepare(host->ref_out_clk);
> +
> +       return 0;
> +}
> +
> +static int ufs_rockchip_system_resume(struct device *dev)
> +{
> +       struct ufs_hba *hba = dev_get_drvdata(dev);
> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +       int err;
> +
> +       err = clk_prepare_enable(host->ref_out_clk);
> +       if (err) {
> +               dev_err(hba->dev, "failed to enable ref_out clock %d\n", err);
> +               return err;
> +       }
> +
> +       return ufshcd_system_resume(dev);
> +}
> +#endif
> +
> +static const struct dev_pm_ops ufs_rockchip_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(ufs_rockchip_system_suspend, ufs_rockchip_system_resume)
> +       SET_RUNTIME_PM_OPS(ufs_rockchip_runtime_suspend, ufs_rockchip_runtime_resume, NULL)
> +       .prepare         = ufshcd_suspend_prepare,
> +       .complete        = ufshcd_resume_complete,
> +};
> +

[...]

Kind regards
Uffe

