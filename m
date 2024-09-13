Return-Path: <linux-pm+bounces-14140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F2E977F1F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC981F22403
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795EB1D88D0;
	Fri, 13 Sep 2024 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPYvN4/O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF771D86D8
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228940; cv=none; b=mtIIjNxlNTtjnpb0czM+5N6Mbde1LtbepeGlS7vDY21I2Pzxc8KGW3lzSNx+uTkIQtp/LJnl1WU4OaKcbZJGfJWN4hVCnSHfJ971HB/Bi0dL9/eGZoLZ3DiAHc9pC/a3/e0LMSTVOaSamCD+cxgw2BsQX96FIbp1mIaxvIkg/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228940; c=relaxed/simple;
	bh=WuwqpRmxlM+RziSDik+Xx/cAiRX1REx1Yj/wgaxdIFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pgu5lObIfBYvETp8sedVCw7wwrnhDd5jk/HWFhOhaeyRDdcHCVGypBLMa0rHUtUDUR7ai/GdlICa73BkO88kSLkMx5wzQM4wCTnip23T5EoyAhIkIkgKzXwXiwqnNmBGXkMAWL+zyraanA4PUAw4LmPR+a4SQrAwfBQ1D6HBdDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPYvN4/O; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6dbb24ee2ebso19810537b3.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228938; x=1726833738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VZUveVe5ug6pUVY95Hk2rZagT2tEgT+khEe5hqljA6o=;
        b=GPYvN4/O/P8AOTFh7dQrOYWMtpbMEkxSUdO10t9LY6BGBSNcG2l3laS+a3mP3/d83H
         sI0GHWdF83xiIqKHQi2Ht7+S9zGhGv1ERRz/Y4jCLeTjLO6ICBzqUtWVfqj36d1YhYq7
         1hK3PsHoMU/VcGX3iH9Rc6/xYcsAlq1g5OnFZX23DuQkujL1xQiAYa2TztKWspXDeGFD
         tzdG+pDgj7XmAOU5spvuMcinagiT103csfAofIvHLu6DbuK4tdRyBmHRFdazFRniNPKT
         gTZYuyzKgs7o1JKP6q9ep3TP18u9Oo7oH4SjKedW/oRDuae9cQGHn5ZbX9qLsI+ijzk8
         DSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228938; x=1726833738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZUveVe5ug6pUVY95Hk2rZagT2tEgT+khEe5hqljA6o=;
        b=NB0O7uHlrdcI2jiHWI9hZn8hNkaaIgWR47eWgPGdcnl1tXZ281lw4qlGyg7JtUjda6
         +ka34F7wwz7J3oJ/RLbIaHLEplEDmHkyzg7fFfAnAiy4+MHNzIo/WG/3uSM8x7juHzmc
         XoVDe8oWDiQuLnG1vdWtai5in4is1TNYDHRNJvvbTTGHVqEQgrj95yvJBxJDcCGKAuO6
         oh4l9JH1qjxHrJpaF4nEqmE8P4WXiGDr/qB9aM5FVmcsOXZojKLQwp9MZiRgPBD3i3YU
         ZLQFirVU3WuOYo+sC2Vr11L9UB1axLhkaAtocQPEXdpwuGUR+tJRvmx8RoCgSc6rv1jE
         ufRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYcNiIza4jK3jual9VOESyPvIdd+51lzkHG2kvdBnvpEwCpUZwg+U5/VRrafXOfzL5aOjsqusXMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCqpBhf3MJz/5dKWEKwRMgpxxe0TME8fQnj+TxfsnaQ+J5YRW
	AYbyG13yKGp4mIQ/O8NFCPy0drxDdhqsqoPmByqPaCxE8WHPg52k3pPuZ3nw3LSIGOm4D7W6pUF
	MI/JpkYWlJC3k3VMvwrpX/M4bPBlmQgr9yXsDQQ==
X-Google-Smtp-Source: AGHT+IHvWAtjRL3HNkWkaP3coSzhpDLefItiLLMliColzEkeBMjyYypjXfXV6VN6sYk4ULxR/arxmws/Y1dWw592ffI=
X-Received: by 2002:a05:690c:1d:b0:6b0:d687:3bd3 with SMTP id
 00721157ae682-6dbb6b20d8amr53618377b3.21.1726228936095; Fri, 13 Sep 2024
 05:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:01:40 +0200
Message-ID: <CAPDyKFr51pccY4Wx3x_NcuVrJcsG0U_xMptdC-2hf_5BnjaR0Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] pmdomain: Simplify with cleanup.h
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 14:51, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Simplify the code with scoped loops, guards and __free().
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (10):
>       pmdomain: rockchip: Simplify with scoped for each OF child loop
>       pmdomain: rockchip: Simplify locking with guard()
>       pmdomain: imx: gpc: Simplify with scoped for each OF child loop
>       pmdomain: imx: gpcv2: Simplify with scoped for each OF child loop
>       pmdomain: qcom: cpr: Simplify with dev_err_probe()
>       pmdomain: qcom: cpr: Simplify locking with guard()
>       pmdomain: qcom: rpmhpd: Simplify locking with guard()
>       pmdomain: qcom: rpmpd: Simplify locking with guard()
>       pmdomain: renesas: rcar-gen4-sysc: Use scoped device node handling to simplify error paths
>       pmdomain: renesas: rcar-sysc: Use scoped device node handling to simplify error paths
>
>  drivers/pmdomain/imx/gpc.c                | 14 +++-----
>  drivers/pmdomain/imx/gpcv2.c              |  8 ++---
>  drivers/pmdomain/qcom/cpr.c               | 58 ++++++++++++-------------------
>  drivers/pmdomain/qcom/rpmhpd.c            | 11 +++---
>  drivers/pmdomain/qcom/rpmpd.c             | 20 ++++-------
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c | 26 ++++++--------
>  drivers/pmdomain/renesas/rcar-sysc.c      | 28 ++++++---------
>  drivers/pmdomain/rockchip/pm-domains.c    | 25 ++++---------
>  8 files changed, 68 insertions(+), 122 deletions(-)
> ---
> base-commit: e188fd67a69319f3d105d9b90e424b8d1ff9580c
> change-id: 20240823-cleanup-h-guard-pm-domain-35eb491f35f9
>
> Best regards,
> --
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch 1 -> 8 applied for next, thanks!

Kind regards
Uffe

