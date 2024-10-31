Return-Path: <linux-pm+bounces-16816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8BF9B78B0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 11:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF871C20A0E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C23C19753F;
	Thu, 31 Oct 2024 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHIoG2Jl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300113A89A
	for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2024 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370748; cv=none; b=E94cxnLjYnisg5TTr7+vkmuWla6qWzKdsKct0lRWFNxvRxCLO4F7gCOElUGMhlTc8h2PQEOGqlI+rXktz/pWOJBvTyFZgVdDuwhyiTGavv+jAYmaDb1U3u/dzJ8OcdY5L4bLR34vJdhEr2MzUTFPav9Y+Kuh55Jewyh3uGKNe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370748; c=relaxed/simple;
	bh=TwtIW9LSv9G5r4rophK0QTZhp7Tjslr7WQNqsOzC/C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MojX7NfIqXBUDS70+PGgtt7/DvvIFIYRUbHkguYawuPesXC8CWBSKHF9e+s6MAib7X4686QaN7v5z0lNlE5MmhsDPrFBQ+IhTn5SxlojBaU/PeEsaxMHveBZPI5ocpaje6KGx1R8cm0E+PcXOsgDD6uIbHX6BV7aHDTcJJEVeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lHIoG2Jl; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e29218d34f8so564115276.1
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2024 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730370745; x=1730975545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VarKBH0QyosYNanStbSCN+BEj/IdJvCxWs79e+ws3Gs=;
        b=lHIoG2JlAG+HdepO2NDwlK8irxZ2eDRc9NAH8anhCWBpjWoBiuRAR7TI10wQ96xgrJ
         VpwO4XwhWaRdHPCs1mJCTofW8iEbPh4UNYTYTNEIdnweT1N2trsqkXUa5ODlaignVKog
         2uOf/vCyS4Ktj+YfQ6r1xCOK3A/NYgSaIMJPESpWVSEoSaS0B0ooowJ7AqbKkLm9d4cJ
         gQc9g7hCoSc8Cvx6z+Zg3qgmCsHVoV0woiXUanaXv7OPXYjx+OAXwCYR5jkaFAz+BboW
         0JYlqG0VxQAmRxAOkDFj0+HSh5yaWJu486u92j7X6u3znppeRpm8YMcAhMPmw4lMnKZV
         f0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730370745; x=1730975545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VarKBH0QyosYNanStbSCN+BEj/IdJvCxWs79e+ws3Gs=;
        b=ozEIu1XmjkCvUE4vlkaSXMsxOQs6X6EilLngSpj25x4P3tQ3WQh0bgOd350h6oOitS
         bhmUK3WsLwrKYCl9tbsF1pNl3zaWS2ao1K1lsW41MNEqAyz/BWNhbFLwBooDDt8mpSkF
         4Y+/d9v+1HESkASL90v2lvDjs2GenRLA024bax45Elm9wGI15rOI8ka/6IEAX9kW3eDn
         9+RZuD7kX4Q52ov5HVT2Hom+S5yeApfJ4fvdkkJTwk484tlQv9cYI6RvuVGmvzt4wytX
         x4ZGD/Qmi1693pC11LgVtRwei4hsjyZ5unfWmPmgY3Joz8VxSkeRPJCn/oqcvmm7Svjx
         eIow==
X-Forwarded-Encrypted: i=1; AJvYcCWV9KAyxsVyHXFok3zQGrLi22BslYYVhvLFvAKJHkdoODNFSZseX9rTrFjtix+n3hK8MlTM1RZUhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFiff6njAwEEMjoqgyn18xKLvPIeRgN3M8Cqckb+WdAFhh/Wsb
	MucTakV7J6rWLUz7CN350vgRLfTzvDn8MHVLxBLRtF0bj94+yUtWRxjKgowxb+06ssgt692qYSc
	JgeUqZG2iy6wo7OO+rz05vm6mLzKY47aNyCQM4A==
X-Google-Smtp-Source: AGHT+IG238JGH1qjLycIih9r3q29Lo0nGy+N1drTsSngm2dFuNwhbZo2/jN8Rgbl/kUJ5GFW+hkRyYQhbfCfyS6N5u8=
X-Received: by 2002:a05:6902:27c2:b0:e29:396:3fd7 with SMTP id
 3f1490d57ef6-e30e8bba6camr1278769276.12.1730370745298; Thu, 31 Oct 2024
 03:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024030442.119506-1-zhangzekun11@huawei.com>
In-Reply-To: <20241024030442.119506-1-zhangzekun11@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Oct 2024 11:31:47 +0100
Message-ID: <CAPDyKFqnW7FgeTtc-f+W40ZQj02pigTtS3CUW4PF-UyLexDUnw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Some cleanup and fix the missing of_node_put()
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: nm@ti.com, kristo@kernel.org, ssantosh@kernel.org, d-gole@ti.com, 
	linux-pm@vger.kernel.org, chenjun102@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 05:09, Zhang Zekun <zhangzekun11@huawei.com> wrote:
>
> Fix the missing of_node_put() of args.np and use the scoped
> of_node_put() to simplify code.
>
> v3:
> - Improve the commit message.
> - Link to v2:
>   https://lore.kernel.org/all/20240926012551.31712-1-zhangzekun11@huawei.com/
>
> v2:
> - Add missing brackets in patch [1/2].
> - Link to v1:
>   https://lore.kernel.org/all/20240822130055.50113-1-zhangzekun11@huawei.com/
>
> Zhang Zekun (2):
>   pmdomain: ti-sci: Add missing of_node_put() for args.np
>   pmdomain: ti-sci: Use scope based of_node_put() to simplify code.
>
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

