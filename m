Return-Path: <linux-pm+bounces-21528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB59A2C05B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 11:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6283AA82E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34351A76AE;
	Fri,  7 Feb 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2JC/M7f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97980BFF
	for <linux-pm@vger.kernel.org>; Fri,  7 Feb 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923504; cv=none; b=oj1mphVHwaOBdu1YrGFqGczuQcOKbnwNqL7zyjxpPriEQv3Lam4QAhHn3iaXqcLVTXbEkH+r81xeLSnOT8VO2v6JBzu13nKLjiyPcJjCJIIFQYDhtQ1YaLH0NttxU/MKdoafkLUrsom9ysAyyYvjM+2iXGQxPAGd6kM1BZ/snOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923504; c=relaxed/simple;
	bh=BYJ+tN1iYPpmV5vZwwLxt3f3U1fpzYNvlj4mO7XwDIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzJMZobYJ8JsvfDntqUESOrBXwEoB66iBoBWVbuvT7sImaQYb65WncKntiKQSfcRdvG5yuaLhQ/Wg+oqizm9ETOSFi2dAsslIjzT32yuJrWSz/h6qgIeMA60n1nqrRWb6wvNxYI93sXYAjq6mWVf+DLxbUM6V8Rd5/YtaKrGPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I2JC/M7f; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5b22d35268so1754192276.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2025 02:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738923502; x=1739528302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k2O4Pdt3lmbd3SSqpJ+FSdd/ZryfZbPXCdjWvrm1MQ4=;
        b=I2JC/M7fexWeBsiRzFX/btAFcPJJwisEPsKn+ymldXXfmPzC+QJ60U+3paox5+biTb
         4rfLeUcvjx9hB2fe5i+qnKb3vwJFr+f0zEK+hZCICr/miMewte1ANxrc1hfGyX6BwouY
         RNlOmD1E218YL7RkvDaE89Ja7s8BPmQL+yKy1a0RTLsl0SoP6Jv0sfpvidYK8UQIJJyG
         6MNjeE5EElqB0H/LHaCJMGgN9ltMfElZMIWjy7qYehX5pqKzAS3Z5IklQW8H0KFMj79r
         GRFWLtZSqLh+gX4kne9iY4P6G0/W5MzA5ySBHEiw+vT0C+QuXNXe+FDSmhjbD3g9Xx8P
         KrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738923502; x=1739528302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2O4Pdt3lmbd3SSqpJ+FSdd/ZryfZbPXCdjWvrm1MQ4=;
        b=Ay6DsE1zykfPNsAdEjXsvNNVhg42Xy1hCK3MCKzKhQOJXsQWLqPZOXfu2CRlHFGUzz
         3njR39A0W1uieDFuBorHEziNYSRrVqwTZ+fxs1eOBAhz2MaQ8o+gMqD+4wSxWWm5SAlk
         UMDaAPYRuIl1g2ewuTwoRG9AnZjPmrGGRFbgY4kPNtghC2zS/WNUJ0sQDBMcurgIOae7
         7fUjVWk1rbft2Cr7wq2gOmaT4nGE5uD14NF3X6q9x2EF3kFNTBXW0wgJXakkdVbJZL0S
         HaOZbHn+Z86Etgiuq7jz0ifQPxZbIoE2UZduxSJwS5IfEyjXqtBgL2SI83HvMe05nSRt
         ojuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd9FMKxUl5sE91DbQCEpwq2OyXouq2BQgT0+Z/bR1vpN1a4/+oZJXV1CGRXn25LVRfgyHHRZNAfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4NBDaFyDhgZW49WyohEfHbjT7kKajQ54tNjGdPvcwUc0JpdjZ
	E7lwJOTGH5JfX/HwAWyC/FZjq4cyB4iY2aoYdriYqBeBk0UIE5n3yP217yXvLP5FI7yCX1r70hY
	nM2GUpm3wSHGA8sJu9Imh0bYcSTEsgSMlNdQV3A==
X-Gm-Gg: ASbGncsV+lChcCO1Zhp6j0JaHi8dqm7tYdhy7IE6fnRODtHlSa+bV5pP+NTynSfCGPk
	WAWTW7T/RH3+I4Y7b3OY6r0nQEX6z46WAkjqcJBE0zXrNWibC1KB8R8U5rlbQvhygh8pFmcHI1A
	==
X-Google-Smtp-Source: AGHT+IEmzZf2075id9cclwyGT9DbXThEdzScuMXDu+oELf+4CgST0QdmLWP6xyTxn4FlyYvfafBj1CcF9N5xwSZznZA=
X-Received: by 2002:a05:6902:1142:b0:e5b:2352:7875 with SMTP id
 3f1490d57ef6-e5b461728d5mr1878106276.8.1738923501974; Fri, 07 Feb 2025
 02:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 7 Feb 2025 11:17:46 +0100
X-Gm-Features: AWEUYZmQZT92aTUfye4lvbLVdLcBAyqbrxP8axB62G9bX6fJamFMemAPNZXrIyo
Message-ID: <CAPDyKFq+pWXq75xEtfkeCkmkdZtfp9dAFej4M+6rO6EAUULf=w@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Initial support for RK3576 UFS controller
To: "James E . J . Bottomley" <james.bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Feb 2025 at 07:16, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> This patchset adds initial UFS controller supprt for RK3576 SoC.
> Patch 1 is the dt-bindings. Patch 2-4 deal with rpm and spm support
> in advanced suggested by Ulf. Patch 5 exports two new APIs for host
> driver. Patch 6 and 7 are the host driver and dtsi support.

Looks like this series is almost ready to be merged?

If so, may I suggest that I pick patch2, patch3 and patch4 via my
pmdomain tree and share them via an immutable branch, so they can be
pulled into James/Martin's scsi tree? Or do you prefer another route?

Kind regards
Uffe

>
>
> Changes in v7:
> - add definitions for all kinds of hex values if possible
> - Misc log and comment improvement
> - use udelay for less than 10us cases
> - other improvements suggested by Mani
> - Use 0x0 for consistency
> - Collect Mani's acked-by tag
>
> Changes in v6:
> - fix indentation to 4 spaces suggested by Krzysztof
> - export dev_pm_genpd_rpm_always_on()
> - replace host drivers with glue drivers suggested by Mani
> - add Main's review tag
> - remove UFS_MAX_CLKS
> - improve err log
> - remove hardcoded clocks
> - remove comment from ufs_rockchip_device_reset()
> - remove pm_runtime_* from ufs_rockchip_remove()
> - rebase to scsi/next
> - move ufs_rockchip_set_pm_lvl to ufs_rockchip_rk3576_init()
> - add comments about device_set_awake_path()
> - remove comments suggested by Mani
>
> Changes in v5:
> - use ufshc for devicetree example suggested by Mani
> - fix a compile warning
> - use device_set_awake_path() and disable ref_out_clk in suspend
> - remove pd_id from header
> - reconstruct ufs_rockchip_hce_enable_notify() to workaround hce enable
>   without using new quirk
>
> Changes in v4:
> - properly describe reset-gpios
> - deal with power domain of rpm and spm suggested by Ulf
> - Fix typo and disable clks in ufs_rockchip_remove
> - remove clk_disable_unprepare(host->ref_out_clk) from
>   ufs_rockchip_remove
>
> Changes in v3:
> - rename the file to rockchip,rk3576-ufshc.yaml
> - add description for reset-gpios
> - use rockchip,rk3576-ufshc as compatible
> - reword Kconfig description
> - elaborate more about controller in commit msg
> - use rockchip,rk3576-ufshc for compatible
> - remove useless header file
> - remove inline for ufshcd_is_device_present
> - use usleep_range instead
> - remove initialization, reverse Xmas order
> - remove useless varibles
> - check vops for null
> - other small fixes for err path
> - remove pm_runtime_set_active
> - fix the active and inactive reset-gpios logic
> - fix rpm_lvl and spm_lvl to 5 and move to end of probe path
> - remove unnecessary system PM callbacks
> - use UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE instead
>   of UFSHCI_QUIRK_BROKEN_HCE
>
> Changes in v2:
> - rename the file
> - add reset-gpios
>
> Shawn Lin (6):
>   dt-bindings: ufs: Document Rockchip UFS host controller
>   soc: rockchip: add header for suspend mode SIP interface
>   pmdomain: rockchip: Add smc call to inform firmware
>   scsi: ufs: core: Export ufshcd_dme_reset() and ufshcd_dme_enable()
>   scsi: ufs: rockchip: initial support for UFS
>   arm64: dts: rockchip: Add UFS support for RK3576 SoC
>
> Ulf Hansson (1):
>   pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()
>
>  .../bindings/ufs/rockchip,rk3576-ufshc.yaml        | 105 ++++++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  24 ++
>  drivers/pmdomain/core.c                            |  35 ++
>  drivers/pmdomain/rockchip/pm-domains.c             |   8 +
>  drivers/ufs/core/ufshcd.c                          |   6 +-
>  drivers/ufs/host/Kconfig                           |  12 +
>  drivers/ufs/host/Makefile                          |   1 +
>  drivers/ufs/host/ufs-rockchip.c                    | 353 +++++++++++++++++++++
>  drivers/ufs/host/ufs-rockchip.h                    |  90 ++++++
>  include/linux/pm_domain.h                          |   7 +
>  include/soc/rockchip/rockchip_sip.h                |   3 +
>  include/ufs/ufshcd.h                               |   2 +
>  12 files changed, 644 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
>  create mode 100644 drivers/ufs/host/ufs-rockchip.c
>  create mode 100644 drivers/ufs/host/ufs-rockchip.h
>
> --
> 2.7.4
>

