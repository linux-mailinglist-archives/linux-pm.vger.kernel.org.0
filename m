Return-Path: <linux-pm+bounces-293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D27FA4CD
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3091C20A10
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E2328C5;
	Mon, 27 Nov 2023 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJQVOyWb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7091A5
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:34:08 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so3897139276.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701099247; x=1701704047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SFx0sc6Fj7zTpNP/EH1BCuEJYwxztRxRLD5/S1r93r8=;
        b=EJQVOyWbKB03Obo5GuSga/z4V6NEe/f0NJbKy72HcMCepfAA+7fTRe6nr43uD9SQTu
         GzCvKm1Umv9CXhAHxagW4geXDclg1+BhV8blWbG1+a4Nxrg6IRXTZ+9ZttyYVD6K9MiG
         VaUC6LZOp9A/CXbP7TZ45LWpqLOipqdQQKHjMm1Ht9Qy7eb51GcPSKMG7sbxNMqLNPBC
         RIduAo6u+BuwjhQQy1S7YRox/tzeocdRrq1ySStq4PeEvGaVHwIHCbVdOqFFkOif2f0o
         o5DK3VMNelpncOS+PmWjHHwXxrkpxsdZHI4f1tCPIaHthzo3TkKMZpL410BmUrlpETFR
         47Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099247; x=1701704047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFx0sc6Fj7zTpNP/EH1BCuEJYwxztRxRLD5/S1r93r8=;
        b=L4Vbv4J3ap8s0ZIOBPFmplkmQTUwJCCLpD2bvXKndYX4w71EPPvY22QjgvZjC6vWnD
         t2Kj/+rJnBI4fQp0+bNaeE2GLFfZo+O4BBvvPEwDh/AgOYwMMGBSo66D++O6/ZwzbT8h
         MVKvZyJvtsis+6FPw1Ndq+EKC58bmgisgalg/RJmoDdKzGMMRNcDG3zJohXD8GeMvo+5
         ZjdcgAUxHdNl5ggxpys6fJFp4HrTvv1V+Iz9S8uRwGf3C48WpZlA0kMyf2FLdNycSK24
         BoTOMdsld4kXroVzmJ9MFrUSuhnUoah6hAXZarwSNs9SFWPGN4ylMH2rpeND9GZ4jYkz
         gYAQ==
X-Gm-Message-State: AOJu0YyUcJK8uVCfJN3DQGaguivTKivcnKAqdpeEoFugUjItwM75W2Uk
	lvpiyx5+NSOYMstpwl0/sJLUa909UB+GhGd/mUh+LQ==
X-Google-Smtp-Source: AGHT+IECWCNmNCMvrUC/Cox/cF+UvUcCK5NPLIgBFNDdNQlG+5aAkL/8V/fSkjS9V1TFGTlqeAhsidRO+Bb1mFvKJTI=
X-Received: by 2002:a25:8e85:0:b0:d9d:8fb:d29f with SMTP id
 q5-20020a258e85000000b00d9d08fbd29fmr11180276ybl.45.1701099247369; Mon, 27
 Nov 2023 07:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127135033.136442-1-ulf.hansson@linaro.org> <ZWSwQklU0MFQLMeI@bogus>
In-Reply-To: <ZWSwQklU0MFQLMeI@bogus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Nov 2023 16:33:31 +0100
Message-ID: <CAPDyKFr=EUuKBqzjV4Uio8LWXemC+sPC9im44HLFNLEiZGc9Fg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Avoid polling for scmi_perf_domain
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Nov 2023 at 16:05, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Nov 27, 2023 at 02:50:33PM +0100, Ulf Hansson wrote:
> > It was a mistake to prefer polling based mode when setting a performance
> > level for a domain. Let's instead rely on the protocol to decide what is
> > best and thus avoid polling when possible.
> >
> > Reported-by: Nikunj Kela <nkela@quicinc.com>
> > Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
>
> Ah, I hadn't even noticed before  :). Anyways,
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks, applied for fixes!

Kind regards
Uffe

