Return-Path: <linux-pm+bounces-4420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37E86869C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 03:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9274D28854A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 02:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48AD107A9;
	Tue, 27 Feb 2024 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lAwWueSj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB337E
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708999933; cv=none; b=gR9bJbqRtDeHtk9wUEvh+os3dP9Rh9YDvLK+rsDlRWXTn/QeNffQFArWl9PMUca4TED8Se1NH1qUbDoihAfcIP20gJTq0INkQN4osC082qEzufg1BoUp9+DA8qj8jItyKOQooSd+pS9ky+vLprI3MF3IpGD3r3RcYFdeYdJCL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708999933; c=relaxed/simple;
	bh=Z56/LI8VZmdz98CuUjLKRxqM+/e9GrRj/1Z7Ht5aUfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1tOAXWQ/ZMssrvw+u4XqHzz8m0b/bBMrvRy3EHnsv+XFFTNeikAcWffEmuMcX0MAGCta1Euntt///mHHK3LUSmzswtjXVUV5EXRumAyGRbv/v2OJlYZBIv5IzsREoypFltL+/NuSLHfBwkcW7bt90eCFxGuHART0scMYXlHNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lAwWueSj; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso4068836276.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 18:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708999930; x=1709604730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tkk2Ni6/yhyMeaZGa7IIqv+Yfz58c68ZVLrD2RbHJZ4=;
        b=lAwWueSjV4zfBBmTtNJxigVRZQ+zhyUyZvljhuzxtHCNg/vfHzo2m6gKWLG0THEA8W
         Kh8Sl5OVoPOcHbiae2DMkkmWL/G7efTrOJkH0yg2YO8bCItELs4e4WG6CPcqmBODBUGp
         7wX3V0t+jkyYsCcpO6qxCShm4Dz+SjzArJ46rsWDCuEiPpYbjpnbwgryfNMiju9DNuFx
         J6Vvucq1r7nlOvR4jATY+3gzXQXPNG8c709UBhkyFHlo1o7HWX+/TLwBx61z9Mjhoxjw
         pa7muU7hrNQEpckhdeYvy3XNB5t63nusm4WVctz2egTxZDEcHb/5UPIKF2MjGejB0qnk
         F3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708999930; x=1709604730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkk2Ni6/yhyMeaZGa7IIqv+Yfz58c68ZVLrD2RbHJZ4=;
        b=K6cTCMEmNw678geTtEXsbSyOJVh6WWyBIa40YnP7xOoAtVV25vrBxu7dHwcfZ5wz7P
         s3UhxVCP5Saib2ss9BS3+UUDpkFet78fOMiIG1FT4C04iJq2KZavQuVpyCsZksY9gAtE
         Jxe4qoYcMUkRO6bNnRjP/DKN4Qgbro7HVUm4/jPC26u05RTb6hJUw+tUQI8Nh4PJlQ9O
         VyqpcmB7rCDRzfJ6PSW+qmRo0UxnGHsyeVrdq1NAydkqizlG5pew6QCqt3slzGUmEfBv
         H3aTMeSUWylEiY9bpTpJ/ag0y1cXrLvNAb6N+rwfjm9JhrWV6rFW3+NEz4c3sA9attDy
         QFiA==
X-Forwarded-Encrypted: i=1; AJvYcCU5IwJ4WeVY/MmiCvITdTA1eAcyBLsuiKS6a9ihkMvXEm/tIYlhB1IU+TA6s6hUB4JbY4A7Eo1oAQOYes2cZSO7goChpZPgf2Y=
X-Gm-Message-State: AOJu0YzLt88Y82gvBVNKUW5TKgVq9qrBMB6dzR1mm1mU1vy8k+aGFDQN
	wgh+M2wygoe3O1dBPMaFqM/l1AJ0qz6KpUFUAYgQTQoxdIlwoOKen62qf7Q/tLncMR+kTfcWs9D
	6kyYFvWztvdB0D3uQl4anhHuixTbJ9H+7reVW9g==
X-Google-Smtp-Source: AGHT+IFxwZo4jdNC6Y1qg8jo3OFzprpy0HeWCrowjlAGstZGCPHgOw7rD/34/+prPDnHsvSDlgsCDFtxPaz0GjLwWbM=
X-Received: by 2002:a25:9a05:0:b0:dcd:5635:5c11 with SMTP id
 x5-20020a259a05000000b00dcd56355c11mr940809ybn.45.1708999930374; Mon, 26 Feb
 2024 18:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
In-Reply-To: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 27 Feb 2024 04:11:59 +0200
Message-ID: <CAA8EJppya80cFev=ZKCJrj8=+5jexDYyr5uZOSHBWK65gRJofA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
To: quic_bjorande@quicinc.com
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <swboyd@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 03:45, Bjorn Andersson via B4 Relay
<devnull+quic_bjorande.quicinc.com@kernel.org> wrote:
>
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
> This issue is the root cause of a display regression on SC8280XP boards,
> resulting in the system often resetting during boot. It was exposed by
> the refactoring of the DisplayPort driver in v6.8-rc1.
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Probably once this lands we can drop explicit required-opps properties.

-- 
With best wishes
Dmitry

