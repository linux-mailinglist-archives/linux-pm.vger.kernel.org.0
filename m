Return-Path: <linux-pm+bounces-14139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBB2977F1D
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 14:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940E81C20BC9
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4531C2DC3;
	Fri, 13 Sep 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2pSzZGm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2831D86C8
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228935; cv=none; b=IvyFXNxK7In0UhQVFQ6PyZRNybhEG0r9c9KwPZyaW0AgtryzmDeIIOUXGtxUX3LTiJJWKFRDAXIkiMuNQCFGWtew9e6aGVOlQzSd9diGeX0YXbDsSsgWmeRyeBSi7U+ov/p6BcGEh316j844g57uA46TuI7ZRBA2Xl/p/A1Ha84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228935; c=relaxed/simple;
	bh=w2gCq2id6e6c4vu8b+ixNhiDDFQwsvXxERyONQtM/hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX0B74P6cP/BkQiGdFE8I9ZF/Jpr5G0cpnJ+qigXHEUUa00gU78iLtTQYElDDLzsybOSTYA+KQQWtlqD3EKgTMfFdTPHOCjD95ZGrv9OGFp04ike+ZEELSC8J+wC14CO2SpbcQXOwUlNMHLb1/UiqJzI5e5cw6IOGJ2QxjoRLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2pSzZGm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e04196b7603so1902599276.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228933; x=1726833733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ9BqaWY3fNsSgDu8aerxC1VdxYIkn7mbG3dEwg2yFw=;
        b=k2pSzZGmJfXSiOgsVoIzJ2Za4rki5GueVYYQPIra5X21p3IdjbYZh3I91ZaC0QiWBH
         uCPVmi1dhrdGguUn8pb6a/iGmJ/h7J8kR4Eun4F3UuHCHx5ayHGKSgrmLcKeAFydM0NW
         Y9ZYn7NmGQqUa5VC6VwV0OFrvRnYO2E6i6Ufthiz6VmJtW9EluqLhpj/WHZFzX6z+Jra
         RtlpFctmDomjIxxMjjWZBdRGccngFybWkQAbXMPqArKUtiIky8mSb65ARMbI2a3eEEbR
         A4blglIgs9BFYIgMVcTCTuMpWTFPypWFoUuo2El9iK/0vF7en8yvbyANVy2vXKh7ngpJ
         X4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228933; x=1726833733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ9BqaWY3fNsSgDu8aerxC1VdxYIkn7mbG3dEwg2yFw=;
        b=g2Bgq+g6t45qbminFHl3fo/g9RLbsmz3jRFSn/RGwjKV8XfwlFHRvuvMkpzpguWdcM
         mL78TcbKAeyhNlUid9TYLcDo0JaEWg7HOHeBRSqQ0Edt858p7x40EnIQmI0b9/+SoDHQ
         Mh1CA7g1x3t0iXVz4MPNeYek2m6baF+xa/QWQsQIPUZzijNfNWUQkpy+ANByCluyLcG8
         w3BG+/REMwS40LTkIKbkLqNgkC6eMZLY6NHAV09brL/rn4wHCB5iwZ5UZX4MDilDhou2
         /jTo4mRlXgyYt+xsjnijVBBN+PvGZxgFhbUYEw6zDmFM3CcMtYu5dc8H0pJ5ekG8XGb5
         UjZA==
X-Forwarded-Encrypted: i=1; AJvYcCVWyB+KaFm0SgscsfKng5rn91jpwi3b/cCwgranO8dI+LtDyMAww7d40VGEojzLWse4PQqlUhDHUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vtFjlFd0rfB0SSOSpoq632nHEutF/LQZx8NFcnskJRhQhlY8
	mHCDrdHX8Wfe1gVOL/hTjra/+owhaXUs/YonvUwStDV1FFRVdNFtjZWMxqn9LPFQIlD1DjnLOJL
	lX8VQjpU4AuMbR2lOTK0c0HkMTopW5syX9WfLDA==
X-Google-Smtp-Source: AGHT+IFVTbz4C2nypKmZT6XxsforhF0Jt2AptsAzZ3URjb1wJush/5JfohOAs/0O/7el+9fezWCSM1UowH+pN0+B3MY=
X-Received: by 2002:a05:690c:6f83:b0:6c7:7557:7a56 with SMTP id
 00721157ae682-6dbb6b0c887mr60092377b3.16.1726228932759; Fri, 13 Sep 2024
 05:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821034022.27394-1-zhangzekun11@huawei.com>
In-Reply-To: <20240821034022.27394-1-zhangzekun11@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:01:37 +0200
Message-ID: <CAPDyKFp19pqOAOXMu6P=fK6Xg1+GP8La0T09_UOOUNxkjPLnkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Some cleanup with use of helper functions
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 05:53, Zhang Zekun <zhangzekun11@huawei.com> wrote:
>
> Using for_each_available_child_of_node() and scoped of_node_put() to
> do some cleanup, this can make code more simple.
>
> Zhang Zekun (2):
>   pmdomain: qcom-cpr: Use helper function
>     for_each_available_child_of_node()
>   pmdomain: qcom-cpr: Use scope based of_node_put() to simplify code.
>
>  drivers/pmdomain/qcom/cpr.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
>
> --
> 2.17.1
>

The series applied for next, thanks!

Kind regards
Uffe

