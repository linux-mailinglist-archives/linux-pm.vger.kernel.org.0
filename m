Return-Path: <linux-pm+bounces-17441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402749C5C9B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044342831A3
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471F205E06;
	Tue, 12 Nov 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cnlc05KE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E3205ADB
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427035; cv=none; b=ncR/xqOxN8OJWheNwLTcj2gkUKyk/FgCAj0Hk1WQNzp9/gC2m8FV+3SQ80scDqlPHydVipYmGeCpVW4Ay3kuUX6mKQNur4xVAubh9m4TfbPlpZQaY83n7NXy7qe4fm9iFCCIjCjFXrAGT4v1UxrTytEKynFz9Cll3Z08HTHnxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427035; c=relaxed/simple;
	bh=1jjU2f1tjrQe5+VqBCl3RvHzuSsE0kITI7vbRrSnONc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E72/0iYs3uF6d05kLbQynBgz8O5dBTRLqaFzT5mkarO+L+7k+WXSUnf7VtASui3iibgy0u9RNCKKrtVDfTwJviF5sE1UldEhAW0XvmooZ8L6vdpfRNkguj8nwDVKSS6lGrTfUluWxHVsVUCvs0g/m2Nrs6zadSvc/mts7YAaNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cnlc05KE; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea85f7f445so57974447b3.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 07:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427032; x=1732031832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TUxAz/Z2gbXGo+S6Wkm3HXVMQ/72U6UPILm/sEMm+BM=;
        b=Cnlc05KEeO0fHQVvfFGc1hVDKVn4IPxTmHNYs6vXf//JRS02xDzU0//9TzcYvthLKF
         6rNKopAlTHGee3Hg0hwLaGharxA46/XreYD/tmgl36f+Nvk+sdnqEKX1r0S5Dgm+n0Ay
         8KBuRK8oM0uO2cJdZ2+Cenk7pxj3n6z0vG/tlH45N0/82wD6FXE8GQpDRjgwLJ7tzCH4
         zLVkTif0/yjLpxAXMxv0a3i1fOT8aJah8DeEuEwvIWRxq+24pR+yv7l9h68XCoMBrCXB
         tO/l+osPhoxNyfGEnumfrVXXNIBe3EaRy/DLzy0dxuQqUHFVGGNCkfCyhzkJuH+4nncd
         NhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427032; x=1732031832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUxAz/Z2gbXGo+S6Wkm3HXVMQ/72U6UPILm/sEMm+BM=;
        b=XdERKF34XOXki/qTVSikY6SkumykKP+K41tmGyDppeHhIJk5f8AOX8ZRLskiYgCOLN
         WplBpYZ0qgUQ7h+j66XjBjLg1HZsr9OklVAjMXI9KcIFZ1BhsC61l74CfdGLW76WxciB
         teAeU0znGFn2pkVmtQ7YyyJv+euG1hN97uvehO+mgOrxlMweVg67BY+Wvmu2ueOJvTXH
         IVM3Il/hWsMFS7eVkod85DOvOwiBR8HWuCeg/+EHRZRi18LPQDkE7lklXgf6DqU1mW3V
         HaKWoGCu1jPyApIUD3HKO4fv+40UpM7b2CXntd81RzVMCoDtBe2pyPM1pckHiw0TnLoF
         jYrw==
X-Forwarded-Encrypted: i=1; AJvYcCXxhHecnC3RsAgxPkqSDkb7nglQDFvCgkeuPLfsCJ0ODbStdHHokb2jNfqHNjp/bdj3vgFqPXDspw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/juG9J24G3ybUzoqOGv8EvOV0QUNid3mvLFNQ2LunP3fdZyZ
	J4gwjJrl0m10BcaIQlffn+Z9M8ZeUPiOdzwE9AS9871XUZViCiajKC360Jqmx0Yql0ttnGBjBT+
	ExiZLrO5tkdAIsjr2KBkPBDwWYbhbDCv4+4sl9A==
X-Google-Smtp-Source: AGHT+IGxKvDCTnSu9K5GtsvLrHqik42J0uKIcJLRzwwShC9Gb+pV36cVlENq/Q4s/ju5EfTbb7FM2A5VXJd6NdZBAy8=
X-Received: by 2002:a05:690c:710a:b0:6ea:7e37:8cec with SMTP id
 00721157ae682-6eaddd74f16mr163974757b3.2.1731427031788; Tue, 12 Nov 2024
 07:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112002444.2802092-1-quic_molvera@quicinc.com>
In-Reply-To: <20241112002444.2802092-1-quic_molvera@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 16:56:36 +0100
Message-ID: <CAPDyKFptAh9fm8CBqKisQKg7Hb3sL_8XJC-GPdVXNJz5t2U4VA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pmdomain: qcom: Introduce power domains for SM8750
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Tingguo Cheng <quic_tingguoc@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Luca Weiss <luca@lucaweiss.eu>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Jishnu Prakash <quic_jprakash@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 01:25, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add power domains needed for the SM8750 SoC.
>
> The Qualcomm Technologies, Inc. SM8750 SoC is the latest in the line of
> consumer mobile device SoCs. See more at:
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/images/company/news-media/media-center/press-kits/snapdragon-summit-2024/day-1/documents/Snapdragon8EliteProductBrief.pdf
>
> Changes in V2:
> - squashed bindings into one patch
>
> Jishnu Prakash (1):
>   pmdomain: qcom: rpmhpd: Add rpmhpd support for SM8750
>
> Taniya Das (1):
>   dt-bindings: power: qcom,rpmpd: document the SM8750 RPMh Power Domains
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                | 26 +++++++++++++++++++
>  include/dt-bindings/power/qcom-rpmpd.h        |  2 ++
>  3 files changed, 29 insertions(+)

Applied for next, thanks!

Kind regards
Uffe

